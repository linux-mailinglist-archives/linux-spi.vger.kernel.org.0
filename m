Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70358DAFCE
	for <lists+linux-spi@lfdr.de>; Thu, 17 Oct 2019 16:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502773AbfJQOUu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Oct 2019 10:20:50 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:33249 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394992AbfJQOU1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Oct 2019 10:20:27 -0400
X-Originating-IP: 86.207.98.53
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 2CC1FC000E;
        Thu, 17 Oct 2019 14:20:24 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 3/7] spi: atmel: Configure GPIO per CS instead of by controller
Date:   Thu, 17 Oct 2019 16:18:42 +0200
Message-Id: <20191017141846.7523-4-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191017141846.7523-1-gregory.clement@bootlin.com>
References: <20191017141846.7523-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Instead of setting up the GPIO configuration for the whole controller,
do it at CS level. It will allow to mix internal CS and GPIO CS, which
is not possible with the current implementation.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
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
2.23.0

