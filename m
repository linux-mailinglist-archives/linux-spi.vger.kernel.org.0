Return-Path: <linux-spi+bounces-12457-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 43224D38A4A
	for <lists+linux-spi@lfdr.de>; Sat, 17 Jan 2026 00:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 04B793003B1F
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 23:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD0421FF47;
	Fri, 16 Jan 2026 23:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="iaN9jGWs"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9621923B61E
	for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 23:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768606548; cv=none; b=G2jtUtokt+oyH3uAXFMEqrXtkHoLaYrdbw5zIbOmg22iIgZhmdX+7lr1i7u29eReu3C0P5MD28v2pITHRgWmitwXW79dixX76VQge1SH4AWjrKnkeCJzLCEmq33Zb+xXbMS/t6jy+mBwIAXFttnlnmBedVXsc1sWef0Lu2bu040=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768606548; c=relaxed/simple;
	bh=s8k8zl3WtMoed/26Y4g+hNYtY5GNt0CKKh6yKU0yxJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gbJNjhIseAsux14ycImDFxwVoASczlKzxJONX59kqmHrNA2kKGRPat/ttufKUPq1E9q8pv4Af+zIwnhnRGWLLjvhfr/BRe1SvwpTnqMGXxrpXmP2Owwd/UIG/DMK7wpKWTJd3OhYFupRtTEq+VAqnTQh3mQcefkvJmcUHc84zOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=iaN9jGWs; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12336f33098so2278954c88.0
        for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 15:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1768606547; x=1769211347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rr1twA4iZh+FcXu79e86gzYn/j7DQvtF/WDnxVBdvpQ=;
        b=iaN9jGWs1Xx4kz/Vb9n8rfAv9j0BDYt/UhR9Zt7CllhvhQamkxZ9k6F61vL2gvBT2l
         XMMaWvbIkv/yz1YN6vNLAMDunkjxevBkUjsXoA7Zh2Tb1RZz1bhHQAIEpAnvitNjBlMX
         kn4R/mqp/CwYwZ/I11a6AgzPPxhJHW17Vwpi0Zt6YiM+U4BR2nt5cHorcz1BAis1g0Bo
         JxjIVcknxEUrZIk/zV9CRe+xQ5g9wVr0Hiat3l0+SGMBqE2yUk7E6KLCI+E6P/XnxSwS
         GmddEREgCtoY2tUiBM3mnN7zpl07BTla2eIjrnE6S4XLbky6t4E1lNEAdtcm1w0GJYHA
         7K5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768606547; x=1769211347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rr1twA4iZh+FcXu79e86gzYn/j7DQvtF/WDnxVBdvpQ=;
        b=nIVNj2ebrnttKoy2o9ugLwJAZkEPdcSttZxxR1KJwbWiMlofhVRVtL/kA3RrL8f32f
         zjCspY0rQvb9vyKxVw6fjsdchyd79ZG6TtwgP/jprwRXT9FOUjysDjOYiGqq1rSqTw3R
         zoXrrLbrrii4kufHadiz8L3bVJnY0Mse/vwAU34aAMtFFe3ULuy9BNu+4rFh0n7mK3vw
         MbJSUbqeLr7xF3rFzDAAVUbDn+nPLgL97JFU4dsyAxxKtZFR+tjRAjZyLRd79fJB5Eb3
         uP7oOW2SCzvlvn8jCeKny9fpRNWN1uBuEAVKAyr94jGM/boTdjYGDa246BT9vYRZ8Lcx
         E/lw==
X-Gm-Message-State: AOJu0Yzey1NUNq0PHnqcdYXmYM/Jp2BVQcxdiIt3IQNV4loAk1S9qivZ
	2eSmW0l9Dv1D2DhDDaWRJIdG5KIqPD0Bz5/9crpHUgFEgwcLrC+1dBJ8JucXo1qbw9k=
X-Gm-Gg: AY/fxX4S4n8Tv7qbFlDH2mGN6y0YT62h+AL13NsmSysLOFXDaZIZ3QtKNohmlR8+yeo
	TOwL0ollPUFvB0MGaeE5T9M94T1gMJh354xXIbZacpidGaIsUFBcJlQJI/xcwykci6bm8x7p/MB
	bQZ60i3bVnKFMQ53s66mnjQNdSZsdQxmV9IxOsTnRBB+uv8tmwhzr4K/by/H07nUl8BZCn13/iZ
	POvwBcenM1veg8Ch3/GYsp8nzQq8m7roUpKoNOo4h/FTChrlOwKK7W9a0RzWVYjhsSKvlLSxn6d
	QDJAA8pu7DDuMBNtVOKC++lR9rms+gjylq2ec5EWHCBZHYKNZ9WCbGBuXSbHtUmPlGhGlmFsK59
	e+Hkw4ymFcA+/zd310Ao0z26oIu3MWCvuazatDVlBY1WJ4dEZNCDH9J+5Rn5HrynVHSmFU+GXAf
	x83BaFDptLF6s=
X-Received: by 2002:a05:7022:6181:b0:11b:923d:7753 with SMTP id a92af1059eb24-1244b30817bmr3456497c88.3.1768606546673;
        Fri, 16 Jan 2026 15:35:46 -0800 (PST)
Received: from localhost ([50.145.100.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244af10e21sm4653570c88.16.2026.01.16.15.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 15:35:46 -0800 (PST)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
To: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Abdurrahman Hussain <abdurrahman@nexthop.ai>
Subject: [PATCH 1/3] spi: xilinx: use device property accessors.
Date: Fri, 16 Jan 2026 23:35:33 +0000
Message-ID: <20260116233535.260114-1-abdurrahman@nexthop.ai>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This makes the driver work on non-OF platforms.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/spi/spi-xilinx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index c86dc56f38b4..c4b70e95b695 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -405,11 +405,11 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 		bits_per_word = pdata->bits_per_word;
 		force_irq = pdata->force_irq;
 	} else {
-		of_property_read_u32(pdev->dev.of_node, "xlnx,num-ss-bits",
-					  &num_cs);
-		ret = of_property_read_u32(pdev->dev.of_node,
-					   "xlnx,num-transfer-bits",
-					   &bits_per_word);
+		device_property_read_u32(&pdev->dev, "xlnx,num-ss-bits",
+					 &num_cs);
+		ret = device_property_read_u32(&pdev->dev,
+					       "xlnx,num-transfer-bits",
+					       &bits_per_word);
 		if (ret)
 			bits_per_word = 8;
 	}
-- 
2.52.0


