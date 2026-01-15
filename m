Return-Path: <linux-spi+bounces-12382-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4496D238A3
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 10:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8544D30BBEE0
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 09:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19B935BDCA;
	Thu, 15 Jan 2026 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EbrZSyQK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F88261B78;
	Thu, 15 Jan 2026 09:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768469141; cv=none; b=llZiVknQH3Iti3HHKt0wOgRmujETf3wJ79sd8f4Ft0/sUD9SH8vcMumjm32eb/v1bD5RjfjpdrnfSIn5W9z41JWV3UrFQhVhQiVe+aO/OSLVPAQV9W4Bn3IVYSJqANZHxuaLLezSX7iM+5xoZjER5ihhaOxzxeo8rqDdpaMIeoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768469141; c=relaxed/simple;
	bh=r4xsrvUEkrisBm830uVOi5LF7CumvVgNOo2uu+EAufY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fbDuhvytYQUTgfwSA2HoAf7OUXQ5DyYjTZkyn8SDe9Y2ioyGfdduoAXAhTZBfnhSPE9LEuQlHa5rEDYrpexjrj7oF9qAsUg8jE6cNzWNIDep07t3y2TSshfjGfJQNjxbUq0JK+26Kd8hY6ehGzKAkJIQ4WO/FjLDLqPNOkQEzzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EbrZSyQK; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D010EC1F1E8;
	Thu, 15 Jan 2026 09:25:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8913C606B6;
	Thu, 15 Jan 2026 09:25:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A922710B68530;
	Thu, 15 Jan 2026 10:25:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768469137; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=gltgqZxplCK6T7f5+zOiN0+WD5c1Yq1xx9kIlIzwwZA=;
	b=EbrZSyQKJUUTB5NptiNKVCUwI7JbCfuXCDSqTCUozcFI3T5j2UrOTsmyVkgOEPo/n7zw8q
	Q6ovswpKZ3Q/l2UNgF/GaCeA6AS12yaf2EJ1crWjCzBRbJsSBbMa4RK5DIF8mVbzyAsOl1
	9Nn3vzMCVqQfCSos34PzHlwObu62D8CULhpT3ji1ZL7oZG40ffCdknBVTmoRVeuwFMqvkp
	lnlYx2ctKUjO53L3IwfwUAsRFZmeemQoWYO0eLH+K/Krb877qTO2GNR1w8OqA2bSZTBXVp
	3L2MRb1AjlD4JizkrcZBOay9/GPNsN436/Fi/k1d9KCx8kibaNede0IKmQiuRQ==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Date: Thu, 15 Jan 2026 10:24:54 +0100
Subject: [PATCH v2 03/13] spi: cadence-qspi: Fix style and improve
 readability
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-schneider-6-19-rc1-qspi-v2-3-7e6a06e1e17b@bootlin.com>
References: <20260115-schneider-6-19-rc1-qspi-v2-0-7e6a06e1e17b@bootlin.com>
In-Reply-To: <20260115-schneider-6-19-rc1-qspi-v2-0-7e6a06e1e17b@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Vaishnav Achath <vaishnav.a@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Pascal Eberhard <pascal.eberhard@se.com>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

It took me several seconds to correctly understand this block. I
understand the goal: showing that we are in the if, or in one of the two
other cases. Improve the organization of the code to both improve
readability and fix the style.

Suggested-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index cc28da7fc686..c0a507953c58 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -374,17 +374,12 @@ static irqreturn_t cqspi_irq_handler(int this_irq, void *dev)
 	/* Clear interrupt */
 	writel(irq_status, cqspi->iobase + CQSPI_REG_IRQSTATUS);
 
-	if (cqspi->use_dma_read && ddata && ddata->get_dma_status) {
-		if (ddata->get_dma_status(cqspi)) {
-			complete(&cqspi->transfer_complete);
-			return IRQ_HANDLED;
-		}
-	}
-
-	else if (!cqspi->slow_sram)
-		irq_status &= CQSPI_IRQ_MASK_RD | CQSPI_IRQ_MASK_WR;
-	else
+	if (cqspi->use_dma_read && ddata && ddata->get_dma_status)
+		irq_status = ddata->get_dma_status(cqspi);
+	else if (cqspi->slow_sram)
 		irq_status &= CQSPI_IRQ_MASK_RD_SLOW_SRAM | CQSPI_IRQ_MASK_WR;
+	else
+		irq_status &= CQSPI_IRQ_MASK_RD | CQSPI_IRQ_MASK_WR;
 
 	if (irq_status)
 		complete(&cqspi->transfer_complete);

-- 
2.51.1


