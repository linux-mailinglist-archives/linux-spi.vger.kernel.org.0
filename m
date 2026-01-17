Return-Path: <linux-spi+bounces-12463-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1387ED38B42
	for <lists+linux-spi@lfdr.de>; Sat, 17 Jan 2026 02:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C20F9305A8F8
	for <lists+linux-spi@lfdr.de>; Sat, 17 Jan 2026 01:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD3728030E;
	Sat, 17 Jan 2026 01:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="LePoMjus"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0274283C89
	for <linux-spi@vger.kernel.org>; Sat, 17 Jan 2026 01:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768612925; cv=none; b=XXJU4Jb382ALbZZk3AmT776JMFRvF2x+zbNNVDI1mcOfKi8+0OtRRPg/jJixQ7anuTrpbU7O0R36vFzx1tBg4p6hGQVYzGWAaqMsRnPIyGcbMv3ME4Tzak+rW2EoZGT8imLwRADmPRxR+5SjvByEsMbPpr29iY5DCL1fzWYtwA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768612925; c=relaxed/simple;
	bh=s8k8zl3WtMoed/26Y4g+hNYtY5GNt0CKKh6yKU0yxJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUrxandJhjbvRaqVjd+K4PT55r6jxlFaWVeS5HEFImW5IKKm5pimXLedWswbeLrbdmUYTeLtqrUEHYqa6L0Cbbxhi/3tcvCs3QIb0+16avTTqO4piMIml2YkIlxb+xR2yhD+heUQrxAXf2O0Bgsrq5X8g4jwn53AQ3hmiS5uXlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=LePoMjus; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2ae38f81be1so3395199eec.0
        for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 17:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1768612916; x=1769217716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rr1twA4iZh+FcXu79e86gzYn/j7DQvtF/WDnxVBdvpQ=;
        b=LePoMjusjn+PcXFoP0yCmZTdaXKOTOtOSlckx3ZmqdRnKs+MqIRbqHjtNTNl1+F9GT
         3zZbCu2LE4AfzRSgmJne4mPti082r6NBSikRDZPfW+YI7gKrsRsnAsmA/4GGFANmoCmt
         bINiKBWMulc3Mr6YazJKwIrJO13Wx0MONyM+DZE+JfFkBEct6eGDerzpY1UOAKDU3ZMR
         7rUZWVU0TiH1yOalbaFQcO7VatTQeZWoWDbQYoRj20P1w5wP4xEf5ij/RE4vCMdqJL+B
         78RnNMoI2pvXkpWPqDodxVQqIi2Btp63BPcsTLf69IYmpRbNJj24JaIfqMSz1biu4bx3
         nW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768612916; x=1769217716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rr1twA4iZh+FcXu79e86gzYn/j7DQvtF/WDnxVBdvpQ=;
        b=prEQBVToegR7oC5mUrv8fIRVVa3K46vdYJNdsb3ldbtxvJCE8kqHV7b3awAMi9OcpA
         WSJzBly5tPWovvwetDuP6yz/EjwPC6eujrHdAJUqd4ofjAOGujTAW5Zn+afxKvlBas8Z
         glELRCN90of2HGFoOWmhShftupx7om9J7koDVhDDl5qZ8Gx8aHSNxujYtNrIdrA/rRuY
         CEXAj14LUi+tSFRDKGuiEuDLXdp1KjCaPEEqP/Le/k7t1tAnmKJ4LFiTWr1cdCU8SbGH
         cKXpJD3HiXVaQSyS5Jd/KQc9wiEOugSiIBnN1tXfqjBFFWbPIqIwZZYri0QhHcyi85ae
         C3mQ==
X-Gm-Message-State: AOJu0YylmGQ4dE2j+3n7Exm4lgGJahNI3n6fVGqE8DD2WWlu7DJYUcP7
	z0/qvBSxxNw5ChRwD4qHbcDdFadG8TNl02M8E02wnao0OvpHEK6IIdhMoK/MRwYb1zs=
X-Gm-Gg: AY/fxX41yUHc3swYqh7Ji2z1Q2Z+Y0PAcsnr/nhbyU9wfBXb91fSDAnOxVx2QkTke9b
	AgIBovIWDGdI0HmbGHrWv1hHPiWnqBzTcSMa6lfevNu/JZPHnlLs+f9h7QcFhtUB3cFJrRAV8mf
	5LAD930O4d6CJG8wVlpXEQKgS7r5SF/aZ2ez7UT1/paoG1JPWVH5NlremFkaNdaw9n2go1Kvn4F
	tdY1+zfY0cFbii2NvdP8NA3pwUxsGW2Iny2Jne8VjNdw8YZ8ayVYRCHJRPgU//hprKGKf3+tBpE
	GV+ot43PnF7Ni0y/rYMlUO5jVjnRGqDXscGant5WO1IN1Y5X9OFjMzP7i3K0rjtbkSjeuhPrjL4
	hkIYgFCDvNpXV3kMizJuVcWom+4dUaeWekIszMclCQLQiANvj0euPPaOiVjgz6RxCmFnk/2+Nc+
	LW4hnIOlzzHO8=
X-Received: by 2002:a05:7301:1687:b0:2ae:5b32:774 with SMTP id 5a478bee46e88-2b6b46d2a6bmr4932689eec.7.1768612916322;
        Fri, 16 Jan 2026 17:21:56 -0800 (PST)
Received: from localhost ([50.145.100.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3651f39sm4128837eec.24.2026.01.16.17.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 17:21:55 -0800 (PST)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
To: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Abdurrahman Hussain <abdurrahman@nexthop.ai>
Subject: [PATCH v2 1/3] spi: xilinx: use device property accessors.
Date: Sat, 17 Jan 2026 01:21:34 +0000
Message-ID: <20260117012136.265220-2-abdurrahman@nexthop.ai>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260117012136.265220-1-abdurrahman@nexthop.ai>
References: <20260117012136.265220-1-abdurrahman@nexthop.ai>
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


