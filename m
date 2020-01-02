Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F46212E6FD
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jan 2020 15:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgABOEo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jan 2020 09:04:44 -0500
Received: from andre.telenet-ops.be ([195.130.132.53]:35652 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728405AbgABOEn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Jan 2020 09:04:43 -0500
Received: from ramsan ([84.195.182.253])
        by andre.telenet-ops.be with bizsmtp
        id lS4g210095USYZQ01S4gT1; Thu, 02 Jan 2020 15:04:41 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1in15c-0006GP-Jk; Thu, 02 Jan 2020 15:04:40 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1in0gG-0007eN-DR; Thu, 02 Jan 2020 14:38:28 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chris Brandt <chris.brandt@renesas.com>,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/6] spi: sh-msiof: Convert to generic unused native cs handling.
Date:   Thu,  2 Jan 2020 14:38:18 +0100
Message-Id: <20200102133822.29346-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200102133822.29346-1-geert+renesas@glider.be>
References: <20200102133822.29346-1-geert+renesas@glider.be>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Currently the MSIOF SPI driver uses custom code to handle the unused
native chip select with GPIO chip selects.
Convert the driver to use the new generic handling in the SPI core.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-sh-msiof.c | 53 +++-----------------------------------
 1 file changed, 3 insertions(+), 50 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 8f134735291f14c3..b3732dc231cb4bf3 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -14,8 +14,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
-#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -55,7 +53,6 @@ struct sh_msiof_spi_priv {
 	void *rx_dma_page;
 	dma_addr_t tx_dma_addr;
 	dma_addr_t rx_dma_addr;
-	unsigned short unused_ss;
 	bool native_cs_inited;
 	bool native_cs_high;
 	bool slave_aborted;
@@ -587,7 +584,7 @@ static int sh_msiof_prepare_message(struct spi_controller *ctlr,
 
 	/* Configure pins before asserting CS */
 	if (spi->cs_gpiod) {
-		ss = p->unused_ss;
+		ss = ctlr->unused_native_cs;
 		cs_high = p->native_cs_high;
 	} else {
 		ss = spi->chip_select;
@@ -1124,46 +1121,6 @@ static struct sh_msiof_spi_info *sh_msiof_spi_parse_dt(struct device *dev)
 }
 #endif
 
-static int sh_msiof_get_cs_gpios(struct sh_msiof_spi_priv *p)
-{
-	struct device *dev = &p->pdev->dev;
-	unsigned int used_ss_mask = 0;
-	unsigned int cs_gpios = 0;
-	unsigned int num_cs, i;
-	int ret;
-
-	ret = gpiod_count(dev, "cs");
-	if (ret <= 0)
-		return 0;
-
-	num_cs = max_t(unsigned int, ret, p->ctlr->num_chipselect);
-	for (i = 0; i < num_cs; i++) {
-		struct gpio_desc *gpiod;
-
-		gpiod = devm_gpiod_get_index(dev, "cs", i, GPIOD_ASIS);
-		if (!IS_ERR(gpiod)) {
-			devm_gpiod_put(dev, gpiod);
-			cs_gpios++;
-			continue;
-		}
-
-		if (PTR_ERR(gpiod) != -ENOENT)
-			return PTR_ERR(gpiod);
-
-		if (i >= MAX_SS) {
-			dev_err(dev, "Invalid native chip select %d\n", i);
-			return -EINVAL;
-		}
-		used_ss_mask |= BIT(i);
-	}
-	p->unused_ss = ffz(used_ss_mask);
-	if (cs_gpios && p->unused_ss >= MAX_SS) {
-		dev_err(dev, "No unused native chip select available\n");
-		return -EINVAL;
-	}
-	return 0;
-}
-
 static struct dma_chan *sh_msiof_request_dma_chan(struct device *dev,
 	enum dma_transfer_direction dir, unsigned int id, dma_addr_t port_addr)
 {
@@ -1373,17 +1330,12 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	if (p->info->rx_fifo_override)
 		p->rx_fifo_size = p->info->rx_fifo_override;
 
-	/* Setup GPIO chip selects */
-	ctlr->num_chipselect = p->info->num_chipselect;
-	ret = sh_msiof_get_cs_gpios(p);
-	if (ret)
-		goto err1;
-
 	/* init controller code */
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 	ctlr->mode_bits |= SPI_LSB_FIRST | SPI_3WIRE;
 	ctlr->flags = chipdata->ctlr_flags;
 	ctlr->bus_num = pdev->id;
+	ctlr->num_chipselect = p->info->num_chipselect;
 	ctlr->dev.of_node = pdev->dev.of_node;
 	ctlr->setup = sh_msiof_spi_setup;
 	ctlr->prepare_message = sh_msiof_prepare_message;
@@ -1392,6 +1344,7 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	ctlr->auto_runtime_pm = true;
 	ctlr->transfer_one = sh_msiof_transfer_one;
 	ctlr->use_gpio_descriptors = true;
+	ctlr->max_native_cs = MAX_SS;
 
 	ret = sh_msiof_request_dma(p);
 	if (ret < 0)
-- 
2.17.1

