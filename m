Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7C59180032
	for <lists+linux-spi@lfdr.de>; Tue, 10 Mar 2020 15:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbgCJObP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Mar 2020 10:31:15 -0400
Received: from foss.arm.com ([217.140.110.172]:37802 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbgCJObO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 10 Mar 2020 10:31:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A10D30E;
        Tue, 10 Mar 2020 07:31:14 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFD193F6CF;
        Tue, 10 Mar 2020 07:31:13 -0700 (PDT)
Date:   Tue, 10 Mar 2020 14:31:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Chris Brandt <Chris.Brandt@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Applied "spi: rspi: Add support for active-high chip selects" to the spi tree
In-Reply-To:  <20200309171537.21551-1-geert+renesas@glider.be>
Message-Id:  <applied-20200309171537.21551-1-geert+renesas@glider.be>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: rspi: Add support for active-high chip selects

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

From f3a14a3a4d9a54c665e979b1dedbbab1f7503a43 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 9 Mar 2020 18:15:37 +0100
Subject: [PATCH] spi: rspi: Add support for active-high chip selects

All RSPI variants support setting the polarity of the SSL signal.
Advertize support for active-high chip selects, and configure polarity
according to the state of the flag.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20200309171537.21551-1-geert+renesas@glider.be
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rspi.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index aef05f2ac749..06192c9ea813 100644
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
2.20.1

