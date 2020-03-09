Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B39A17E57B
	for <lists+linux-spi@lfdr.de>; Mon,  9 Mar 2020 18:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbgCIRPm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 13:15:42 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:55512 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbgCIRPm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Mar 2020 13:15:42 -0400
Received: from ramsan ([84.195.182.253])
        by baptiste.telenet-ops.be with bizsmtp
        id CHFf2200N5USYZQ01HFfcT; Mon, 09 Mar 2020 18:15:39 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jBM0B-0007Pa-HO; Mon, 09 Mar 2020 18:15:39 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jBM0B-0005ca-FS; Mon, 09 Mar 2020 18:15:39 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: rspi: Add support for active-high chip selects
Date:   Mon,  9 Mar 2020 18:15:37 +0100
Message-Id: <20200309171537.21551-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

All RSPI variants support setting the polarity of the SSL signal.
Advertize support for active-high chip selects, and configure polarity
according to the state of the flag.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Tested on r8a7791/koelsch using spidev_test and a logic analyzer.
---
 drivers/spi/spi-rspi.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index aef05f2ac749c21d..06192c9ea8132911 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -24,6 +24,7 @@
 #include <linux/sh_dma.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/rspi.h>
+#include <linux/spinlock.h>
 
 #define RSPI_SPCR		0x00	/* Control Register */
 #define RSPI_SSLP		0x01	/* Slave Select Polarity Register */
@@ -79,8 +80,7 @@
 #define SPCR_BSWAP		0x01	/* Byte Swap of read-data for DMAC */
 
 /* SSLP - Slave Select Polarity Register */
-#define SSLP_SSL1P		0x02	/* SSL1 Signal Polarity Setting */
-#define SSLP_SSL0P		0x01	/* SSL0 Signal Polarity Setting */
+#define SSLP_SSLP(i)		BIT(i)	/* SSLi Signal Polarity Setting */
 
 /* SPPCR - Pin Control Register */
 #define SPPCR_MOIFE		0x20	/* MOSI Idle Value Fixing Enable */
@@ -181,7 +181,9 @@ struct rspi_data {
 	void __iomem *addr;
 	u32 max_speed_hz;
 	struct spi_controller *ctlr;
+	struct platform_device *pdev;
 	wait_queue_head_t wait;
+	spinlock_t lock;		/* Protects RMW-access to RSPI_SSLP */
 	struct clk *clk;
 	u16 spcmd;
 	u8 spsr;
@@ -919,6 +921,29 @@ static int qspi_setup_sequencer(struct rspi_data *rspi,
 	return 0;
 }
 
+static int rspi_setup(struct spi_device *spi)
+{
+	struct rspi_data *rspi = spi_controller_get_devdata(spi->controller);
+	u8 sslp;
+
+	if (spi->cs_gpiod)
+		return 0;
+
+	pm_runtime_get_sync(&rspi->pdev->dev);
+	spin_lock_irq(&rspi->lock);
+
+	sslp = rspi_read8(rspi, RSPI_SSLP);
+	if (spi->mode & SPI_CS_HIGH)
+		sslp |= SSLP_SSLP(spi->chip_select);
+	else
+		sslp &= ~SSLP_SSLP(spi->chip_select);
+	rspi_write8(rspi, sslp, RSPI_SSLP);
+
+	spin_unlock_irq(&rspi->lock);
+	pm_runtime_put(&rspi->pdev->dev);
+	return 0;
+}
+
 static int rspi_prepare_message(struct spi_controller *ctlr,
 				struct spi_message *msg)
 {
@@ -1248,17 +1273,20 @@ static int rspi_probe(struct platform_device *pdev)
 		goto error1;
 	}
 
+	rspi->pdev = pdev;
 	pm_runtime_enable(&pdev->dev);
 
 	init_waitqueue_head(&rspi->wait);
+	spin_lock_init(&rspi->lock);
 
 	ctlr->bus_num = pdev->id;
+	ctlr->setup = rspi_setup;
 	ctlr->auto_runtime_pm = true;
 	ctlr->transfer_one = ops->transfer_one;
 	ctlr->prepare_message = rspi_prepare_message;
 	ctlr->unprepare_message = rspi_unprepare_message;
-	ctlr->mode_bits = SPI_CPHA | SPI_CPOL | SPI_LSB_FIRST | SPI_LOOP |
-			  ops->extra_mode_bits;
+	ctlr->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LSB_FIRST |
+			  SPI_LOOP | ops->extra_mode_bits;
 	ctlr->flags = ops->flags;
 	ctlr->dev.of_node = pdev->dev.of_node;
 	ctlr->use_gpio_descriptors = true;
-- 
2.17.1

