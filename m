Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67A8EDCD56
	for <lists+linux-spi@lfdr.de>; Fri, 18 Oct 2019 20:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505771AbfJRSHS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Oct 2019 14:07:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45322 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505759AbfJRSHR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Oct 2019 14:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=TJSOTBg5uxsGq0E3SQaQTNlPvSqo6dIF5AgA35J30g4=; b=hM1DJuTQokPQ
        i2+799Z//Rv9NMZ6HfIhzKDZURp+kzcuokqeciLIRjPe3Jnifg2g2gKUJjBhrR+7KeN4AcvBxxu1P
        2G51OlZcZOWB5iI8bRvGPgIvlNue6D/izFCbLjKFZh1aFdgzp15nCZXO9M67dqqmhgP/GIj6iyXed
        0rlKM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iLWeb-0004H9-7v; Fri, 18 Oct 2019 18:07:09 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id AC1FD2743273; Fri, 18 Oct 2019 19:07:08 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Applied "spi: atmel: Configure GPIO per CS instead of by controller" to the spi tree
In-Reply-To: <20191017141846.7523-4-gregory.clement@bootlin.com>
X-Patchwork-Hint: ignore
Message-Id: <20191018180708.AC1FD2743273@ypsilon.sirena.org.uk>
Date:   Fri, 18 Oct 2019 19:07:08 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: atmel: Configure GPIO per CS instead of by controller

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 585d18f7ebd1dba7400dcc7189a5f7223b821374 Mon Sep 17 00:00:00 2001
From: Gregory CLEMENT <gregory.clement@bootlin.com>
Date: Thu, 17 Oct 2019 16:18:42 +0200
Subject: [PATCH] spi: atmel: Configure GPIO per CS instead of by controller

Instead of setting up the GPIO configuration for the whole controller,
do it at CS level. It will allow to mix internal CS and GPIO CS, which
is not possible with the current implementation.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Link: https://lore.kernel.org/r/20191017141846.7523-4-gregory.clement@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-atmel.c | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 6e08ae539bc0..b511df6a4846 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -275,7 +275,6 @@ struct atmel_spi {
 
 	bool			use_dma;
 	bool			use_pdc;
-	bool			use_cs_gpios;
 
 	bool			keep_cs;
 	bool			cs_active;
@@ -348,7 +347,7 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 		}
 
 		mr = spi_readl(as, MR);
-		if (as->use_cs_gpios)
+		if (asd->npcs_pin)
 			gpiod_set_value(asd->npcs_pin, 1);
 	} else {
 		u32 cpol = (spi->mode & SPI_CPOL) ? SPI_BIT(CPOL) : 0;
@@ -365,7 +364,7 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 
 		mr = spi_readl(as, MR);
 		mr = SPI_BFINS(PCS, ~(1 << spi->chip_select), mr);
-		if (as->use_cs_gpios && spi->chip_select != 0)
+		if (asd->npcs_pin && spi->chip_select != 0)
 			gpiod_set_value(asd->npcs_pin, 1);
 		spi_writel(as, MR, mr);
 	}
@@ -389,7 +388,7 @@ static void cs_deactivate(struct atmel_spi *as, struct spi_device *spi)
 
 	dev_dbg(&spi->dev, "DEactivate NPCS, mr %08x\n", mr);
 
-	if (!as->use_cs_gpios)
+	if (!asd->npcs_pin)
 		spi_writel(as, CR, SPI_BIT(LASTXFER));
 	else if (atmel_spi_is_v2(as) || spi->chip_select != 0)
 		gpiod_set_value(asd->npcs_pin, 0);
@@ -1176,7 +1175,7 @@ static int atmel_spi_setup(struct spi_device *spi)
 	as = spi_master_get_devdata(spi->master);
 
 	/* see notes above re chipselect */
-	if (!as->use_cs_gpios && (spi->mode & SPI_CS_HIGH)) {
+	if (!spi->cs_gpiod && (spi->mode & SPI_CS_HIGH)) {
 		dev_warn(&spi->dev, "setup: non GPIO CS can't be active-high\n");
 		return -EINVAL;
 	}
@@ -1186,9 +1185,9 @@ static int atmel_spi_setup(struct spi_device *spi)
 		csr |= SPI_BIT(CPOL);
 	if (!(spi->mode & SPI_CPHA))
 		csr |= SPI_BIT(NCPHA);
-	if (!as->use_cs_gpios)
-		csr |= SPI_BIT(CSAAT);
 
+	if (!spi->cs_gpiod)
+		csr |= SPI_BIT(CSAAT);
 	csr |= SPI_BF(DLYBS, 0);
 
 	word_delay_csr = atmel_word_delay_csr(spi, as);
@@ -1206,20 +1205,8 @@ static int atmel_spi_setup(struct spi_device *spi)
 		if (!asd)
 			return -ENOMEM;
 
-		/*
-		 * If use_cs_gpios is true this means that we have "cs-gpios"
-		 * defined in the device tree node so we should have
-		 * gotten the GPIO lines from the device tree inside the
-		 * SPI core. Warn if this is not the case but continue since
-		 * CS GPIOs are after all optional.
-		 */
-		if (as->use_cs_gpios) {
-			if (!spi->cs_gpiod) {
-				dev_err(&spi->dev,
-					"host claims to use CS GPIOs but no CS found in DT by the SPI core\n");
-			}
+		if (spi->cs_gpiod)
 			asd->npcs_pin = spi->cs_gpiod;
-		}
 
 		spi->controller_state = asd;
 	}
@@ -1551,13 +1538,10 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	 * discovered by the SPI core when registering the SPI master
 	 * and assigned to each SPI device.
 	 */
-	as->use_cs_gpios = true;
 	if (atmel_spi_is_v2(as) &&
 	    pdev->dev.of_node &&
-	    !of_get_property(pdev->dev.of_node, "cs-gpios", NULL)) {
-		as->use_cs_gpios = false;
+	    !of_get_property(pdev->dev.of_node, "cs-gpios", NULL))
 		master->num_chipselect = 4;
-	}
 
 	as->use_dma = false;
 	as->use_pdc = false;
-- 
2.20.1

