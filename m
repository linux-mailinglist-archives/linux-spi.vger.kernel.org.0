Return-Path: <linux-spi+bounces-12036-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B109CD1989
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 20:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C10A30173B9
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 19:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E8F340A70;
	Fri, 19 Dec 2025 19:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="sw8oG0a0"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC7934166A
	for <linux-spi@vger.kernel.org>; Fri, 19 Dec 2025 19:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766172204; cv=none; b=JB3rSAH1eFVZmL6OL95wjreoyuHGbwLPVTXrNgwILGYEQkT5NDmVpIRmlss8co0197PlZj+dD9xbovLwCa/2J0SYKIkDwz2rngU3htEKd2wbpnShq9ursdKuuPRgxMT77LH3J9mpPv9WIgzi39dR4w9OysJ+T7R7kU+MiBWZV+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766172204; c=relaxed/simple;
	bh=V1d7lGjeLKI9sMwgaextJPK1cYCiLcN3Ja+3a2Mk6p4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uqpELLO4votZecpTv29saowwYttJ0jARZRYRnm9msgu0uEGch+dk9vxJpqFBWfOqle/andvl+T+o93X0QgeU7jTsEzM1iB/KNT8uQqCAWFnrDVLvLpWEqpNQCleSRs+8+Q7nRGB29PZGC6UdoqS3NbeaoxWk7tbFqhrbWAgRLP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=sw8oG0a0; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0EB3D4E40B7D;
	Fri, 19 Dec 2025 19:23:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D6E4C6071D;
	Fri, 19 Dec 2025 19:23:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 86DC710AA981D;
	Fri, 19 Dec 2025 20:23:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766172200; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=56idGnW2rU9U+yKgXckx55lFlLnEcYAtFsLlIPjr5uo=;
	b=sw8oG0a0ySJnjHASF7yDy8+mZiGIHZPVU/i3inxbEyxXebYBktD4N5byFfV7DOLkCeaZuU
	0EnxlBEwylNN0kQAu+COOSMbyn57jWpN7Z7763WE95oifQiIhmTOM//aF7LZS0NwKkblvh
	dAgJ2iun0LkS9xN4e26eKGTCfS0qIK0IKezftTPt6JVrGlzrpVkLaPV5RKNy1M2WQlZCLL
	U6HGBuMcXy1MAdwXShKy8U3AfQ01j9YsVa57+BlOK5u/e7iFL45OycE4pHHlsxFqwKYi/B
	SNwxf3yWTblKTdPb0thXZnhlf0iDjELcJJmJAXQ3OiTlY1vaYkNmZu9eASQ13w==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Date: Fri, 19 Dec 2025 20:22:09 +0100
Subject: [PATCH 07/13] spi: cadence-qspi: Fix probe error path and remove
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-schneider-6-19-rc1-qspi-v1-7-8ad505173e44@bootlin.com>
References: <20251219-schneider-6-19-rc1-qspi-v1-0-8ad505173e44@bootlin.com>
In-Reply-To: <20251219-schneider-6-19-rc1-qspi-v1-0-8ad505173e44@bootlin.com>
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

The probe has been modified by many different users, it is hard to track
history, but for sure its current state is partially broken. One easy
rule to follow is to drop/free/release the resources in the opposite
order they have been queried.

Fix the labels, the order for freeing the resources, and add the
missing DMA channel step. Replicate these changes in the remove path as
well.

Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 45 ++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index f59f3a8dccf5..ff0ddd2c0d41 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1890,7 +1890,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(cqspi->clk);
 	if (ret) {
 		dev_err(dev, "Cannot enable QSPI clock.\n");
-		goto probe_clk_failed;
+		goto disable_rpm;
 	}
 
 	/* Obtain QSPI reset control */
@@ -1898,14 +1898,14 @@ static int cqspi_probe(struct platform_device *pdev)
 	if (IS_ERR(rstc)) {
 		ret = PTR_ERR(rstc);
 		dev_err(dev, "Cannot get QSPI reset.\n");
-		goto probe_reset_failed;
+		goto disable_clk;
 	}
 
 	rstc_ocp = devm_reset_control_get_optional_exclusive(dev, "qspi-ocp");
 	if (IS_ERR(rstc_ocp)) {
 		ret = PTR_ERR(rstc_ocp);
 		dev_err(dev, "Cannot get QSPI OCP reset.\n");
-		goto probe_reset_failed;
+		goto disable_clk;
 	}
 
 	if (of_device_is_compatible(pdev->dev.of_node, "starfive,jh7110-qspi")) {
@@ -1913,7 +1913,7 @@ static int cqspi_probe(struct platform_device *pdev)
 		if (IS_ERR(rstc_ref)) {
 			ret = PTR_ERR(rstc_ref);
 			dev_err(dev, "Cannot get QSPI REF reset.\n");
-			goto probe_reset_failed;
+			goto disable_clk;
 		}
 		reset_control_assert(rstc_ref);
 		reset_control_deassert(rstc_ref);
@@ -1955,7 +1955,7 @@ static int cqspi_probe(struct platform_device *pdev)
 		if (ddata->jh7110_clk_init) {
 			ret = cqspi_jh7110_clk_init(pdev, cqspi);
 			if (ret)
-				goto probe_reset_failed;
+				goto disable_clk;
 		}
 		if (ddata->quirks & CQSPI_DISABLE_STIG_MODE)
 			cqspi->disable_stig_mode = true;
@@ -1963,7 +1963,7 @@ static int cqspi_probe(struct platform_device *pdev)
 		if (ddata->quirks & CQSPI_DMA_SET_MASK) {
 			ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
 			if (ret)
-				goto probe_reset_failed;
+				goto disable_clks;
 		}
 	}
 
@@ -1974,7 +1974,7 @@ static int cqspi_probe(struct platform_device *pdev)
 			       pdev->name, cqspi);
 	if (ret) {
 		dev_err(dev, "Cannot request IRQ.\n");
-		goto probe_reset_failed;
+		goto disable_clks;
 	}
 
 	cqspi_wait_idle(cqspi);
@@ -1995,7 +1995,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	ret = cqspi_setup_flash(cqspi);
 	if (ret) {
 		dev_err(dev, "failed to setup flash parameters %d\n", ret);
-		goto probe_setup_failed;
+		goto disable_controller;
 	}
 
 	host->num_chipselect = cqspi->num_chipselect;
@@ -2006,13 +2006,13 @@ static int cqspi_probe(struct platform_device *pdev)
 	if (cqspi->use_direct_mode) {
 		ret = cqspi_request_mmap_dma(cqspi);
 		if (ret == -EPROBE_DEFER)
-			goto probe_setup_failed;
+			goto disable_controller;
 	}
 
 	ret = spi_register_controller(host);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register SPI ctlr %d\n", ret);
-		goto probe_setup_failed;
+		goto release_dma_chan;
 	}
 
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
@@ -2021,15 +2021,21 @@ static int cqspi_probe(struct platform_device *pdev)
 	}
 
 	return 0;
-probe_setup_failed:
-	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
-		pm_runtime_disable(dev);
+
+release_dma_chan:
+	if (cqspi->rx_chan)
+		dma_release_channel(cqspi->rx_chan);
+disable_controller:
 	cqspi_controller_enable(cqspi, 0);
-probe_reset_failed:
+disable_clks:
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
+disable_clk:
 	clk_disable_unprepare(cqspi->clk);
-probe_clk_failed:
+disable_rpm:
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
+		pm_runtime_disable(dev);
+
 	return ret;
 }
 
@@ -2047,18 +2053,19 @@ static void cqspi_remove(struct platform_device *pdev)
 		cqspi_wait_idle(cqspi);
 
 	spi_unregister_controller(cqspi->host);
-	cqspi_controller_enable(cqspi, 0);
 
 	if (cqspi->rx_chan)
 		dma_release_channel(cqspi->rx_chan);
 
-	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
-		if (pm_runtime_get_sync(&pdev->dev) >= 0)
-			clk_disable(cqspi->clk);
+	cqspi_controller_enable(cqspi, 0);
 
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
 
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
+		if (pm_runtime_get_sync(&pdev->dev) >= 0)
+			clk_disable(cqspi->clk);
+
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
 		pm_runtime_put_sync(&pdev->dev);
 		pm_runtime_disable(&pdev->dev);

-- 
2.51.1


