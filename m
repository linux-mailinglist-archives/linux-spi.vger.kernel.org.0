Return-Path: <linux-spi+bounces-6820-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1EEA355CF
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2025 05:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80FCD189099B
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2025 04:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6CD18A6B7;
	Fri, 14 Feb 2025 04:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNFxvhU0"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AE5189BB3;
	Fri, 14 Feb 2025 04:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739507646; cv=none; b=Z+LCRhJVJlLEvXiHRNkulU73e1X/1lRS4GkX6HscxE+AxJqaCJKVE1rA5O1RG/T35Wb2CmbwbKKBL/s9FoomGYdDdaW6ufHVEbA2GMkyAF2bVAc0Dp1rV1Cn4Ogm5/7lMQphAWQVg6Fx4h/RTqXPDYUeq1Zz253AdCXMHWUlfpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739507646; c=relaxed/simple;
	bh=fxrqtg7mkPoqliOCXI6BF3p+f14Tnmp/XhV0g/cmqYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hXVqOTM9Q15cT06sigA7mRnKs4LBQDk+T50S4/ZQdhF+ogD265eVR1qcL6+EvIUWkUadbIPZV5bryXZTrotvZV5dFLZEOTamoXnqbt3OYq5Xj9wsST4LVY/AJ1DbCj/cc6+SqDm8ALEE+lrjbViiSbFI43RMeJmWllu5gwjSEDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNFxvhU0; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4bbd554fe87so434539137.0;
        Thu, 13 Feb 2025 20:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739507643; x=1740112443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vGOH5ZfDWXC0xrIsnf4fLnv+iec7XidVdhhTf3PgyI=;
        b=VNFxvhU0sS5RBETnxjxU3cXBlo1CGuFZXkpuU8oVMAara6CaN1MqzdRBm2ebwFuNjs
         l/8+yVHv9lLePcJ2l6en+FN38nTk/Wn3CrR69z8HKhRfHvAQhjFScXZ8qlPACoDjDSnp
         5ICbdvARUE41qfTe7+VCeLY2dfAY5aflmNofFMa9T3I7zDV928RwdQCXN6VZEgNQ3CC0
         10gJLuHTMVMdZhvcRNZ77h7bwD8l8N1w+6AIVEdZO3La+40IkQHpdm/jjjzK9xgwi0+I
         OmfimFCskdC88EzhtEaw/1vo0LAABRuZhEUmTmkPAhLZ91uifQij3yhsSmnV1NjlVRMU
         +VBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739507643; x=1740112443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2vGOH5ZfDWXC0xrIsnf4fLnv+iec7XidVdhhTf3PgyI=;
        b=r6r0ZIXRvl/toLPdS5kSUJnSObN4rmhaRldcC29rC/tKBZJjdyJadRiOUiPfiC/g63
         gc8CFHMxOgz+y0ttbnh0gI4BUSR4C1AQI9+gqNHohZOr9gCrlS2suu5wwmi2JOwiILHx
         5TR72Lt/uWxawR25hKPV2w65AAFiFF7GM+4GT6eZcnd4br0laGpF00Gaer0T3Oi1M+WC
         Rz8qORZc7eRcmQnSMIKGdPsK6id45eO6wz3zCi2+lOGg7V2k1ndo3H3Ulo25ZCLxjtZX
         pc8j+yNT/fBkpKndMUHhegjqQt+cjHNpt22PAVU1tiptFlRTGT/gckRVw7Ax3/AArFSI
         91RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdZgsuPzUVXcya0BYgfgurv7wTD48bQpvlvsW25A8MK+yYicCOA0LSTBnAEnsPGamkGWaM0bEtCeUf@vger.kernel.org, AJvYcCVYAu1g52cLSVMT8O4uzS0LCS3Jo7l9UvCKV66PG97tOWtuUoJp1lXGvxrMYeZhSvUiRLBHVoDki4aCUiSd@vger.kernel.org, AJvYcCWPA47Ej34Zol+jZTzM/ecY91/I37UJlofQG/P+7mfhoJ/Jg6KHUpJhpghiiUmnPoqyfdDEHXcDBZv41J2SeyDzPRs=@vger.kernel.org, AJvYcCXebgHFHZ0JvU0Iqx3QgP/Ill/Z+Oqm08n/GUBKYagL5in4C/44zrDrLgU5/EAlfP84Zgfu5EsxWC+U@vger.kernel.org
X-Gm-Message-State: AOJu0YzH0sct60xFWmw02oVXMTsQATkxM24Kx56dLBSg0W4f0MuZXETx
	QmqAVqq9ikFK0CARaNxNt5I92cLdexuFpGPBRoFu5iyVqPZ19Oq2eSHAxAwy
X-Gm-Gg: ASbGncucHIaNJSWeM2JDq0G+0iGmyY8S20AOHTEBfSIx+MTUvpp/n/C8fP/OH7h+3Qy
	K9gDmkhRQh7XW7U3UtEZzpgZpM0TysWs8DfeXpFZ0bMkQhso1/ArW0wXrvUxUH60DwmG6B9e+hY
	PGXnWmm65mdz9JIZsWqIZPUvgsEDFmvF++xR6b2y88+vx5dIMjVAB1mSfI8D5CYsGsrNxO43Cun
	86WVPdksWvWsDK09QNrStp2MMH++5bnRnc3KVtX9f8GMnEoANHavdMgz1JFdDOw1mXk1OkESPRD
	zBFq40BS0mew4eeLCxOSXYsAyzUqBvqnVrauk9/TUk7AaT57HpIAlb+vG3dnbymFDHXSqmDMsCW
	b1g==
X-Google-Smtp-Source: AGHT+IHN3C0clGDeOw5iQJ/Yam+lOWcCUo9IUlBTZxkkZ9QAegrhpgsWbf5H3zijlrub4dNFxpqCeg==
X-Received: by 2002:a05:6102:50aa:b0:4bb:d062:436 with SMTP id ada2fe7eead31-4bbf1fbb722mr10132162137.0.1739507643517;
        Thu, 13 Feb 2025 20:34:03 -0800 (PST)
Received: from localhost.localdomain ([38.44.237.182])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-868e857f2desm422800241.10.2025.02.13.20.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 20:34:03 -0800 (PST)
From: Denzeel Oliva <wachiturroxd150@gmail.com>
To: andi.shyti@kernel.org,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Denzeel Oliva <wachiturroxd150@gmail.com>
Subject: [PATCH v3 2/3] spi: s3c64xx: prioritize fifo-depth from DT over port_config
Date: Fri, 14 Feb 2025 04:33:42 +0000
Message-Id: <20250214043343.263-3-wachiturroxd150@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250214043343.263-1-wachiturroxd150@gmail.com>
References: <20250214043343.263-1-wachiturroxd150@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rearrange s3c64xx_spi_probe() to ensure that the 'fifo-depth' property
from the device tree (DT) is always prioritized over the fallback
values in port_config.

Previously, if port_config had a fifo_depth value, it would override
the DT property. This prevented DT from correctly setting the depth
per node.

This ensures flexibility for device tree configurations while keeping
a safe fallback.

Signed-off-by: Denzeel Oliva <wachiturroxd150@gmail.com>
---
 drivers/spi/spi-s3c64xx.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 389275dbc..dae63a105 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1283,11 +1283,13 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (sdd->port_conf->fifo_depth)
-		sdd->fifo_depth = sdd->port_conf->fifo_depth;
-	else if (of_property_read_u32(pdev->dev.of_node, "fifo-depth",
-				      &sdd->fifo_depth))
-		sdd->fifo_depth = FIFO_DEPTH(sdd);
+	if (of_property_read_u32(pdev->dev.of_node, "fifo-depth",
+				&sdd->fifo_depth)) {
+		if (sdd->port_conf->fifo_depth)
+			sdd->fifo_depth = sdd->port_conf->fifo_depth;
+		else
+			sdd->fifo_depth = FIFO_DEPTH(sdd);
+	}
 
 	s3c64xx_spi_set_fifomask(sdd);
 
-- 
2.48.1


