Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC4471204DD
	for <lists+linux-spi@lfdr.de>; Mon, 16 Dec 2019 13:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfLPMGR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Dec 2019 07:06:17 -0500
Received: from foss.arm.com ([217.140.110.172]:52600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727681AbfLPMGR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 16 Dec 2019 07:06:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9910D1045;
        Mon, 16 Dec 2019 04:06:16 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6E163F719;
        Mon, 16 Dec 2019 04:06:15 -0800 (PST)
Date:   Mon, 16 Dec 2019 12:06:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     alexandre.torgue@st.com, baohua@kernel.org, broonie@kernel.org,
        f.fainelli@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>, mcoquelin.stm32@gmail.com,
        nsaenzjulienne@suse.de, rjui@broadcom.com, sbranden@broadcom.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org, vkoul@kernel.org
Subject: Applied "spi: bcm2835: Use dma_request_chan() instead dma_request_slave_channel()" to the spi tree
In-Reply-To: <20191212135550.4634-4-peter.ujfalusi@ti.com>
Message-Id: <applied-20191212135550.4634-4-peter.ujfalusi@ti.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: bcm2835: Use dma_request_chan() instead dma_request_slave_channel()

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.6

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

From 6133fed0539bc5c059d3a661b61704159ba448a6 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 12 Dec 2019 15:55:44 +0200
Subject: [PATCH] spi: bcm2835: Use dma_request_chan() instead
 dma_request_slave_channel()

dma_request_slave_channel() is a wrapper on top of dma_request_chan()
eating up the error code.

By using dma_request_chan() directly the driver can support deferred
probing against DMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/20191212135550.4634-4-peter.ujfalusi@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm2835.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 662d55e9f21d..69df79914504 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -888,8 +888,8 @@ static void bcm2835_dma_release(struct spi_controller *ctlr,
 	}
 }
 
-static void bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
-			     struct bcm2835_spi *bs)
+static int bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
+			    struct bcm2835_spi *bs)
 {
 	struct dma_slave_config slave_config;
 	const __be32 *addr;
@@ -900,19 +900,24 @@ static void bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
 	addr = of_get_address(ctlr->dev.of_node, 0, NULL, NULL);
 	if (!addr) {
 		dev_err(dev, "could not get DMA-register address - not using dma mode\n");
-		goto err;
+		/* Fall back to interrupt mode */
+		return 0;
 	}
 	dma_reg_base = be32_to_cpup(addr);
 
 	/* get tx/rx dma */
-	ctlr->dma_tx = dma_request_slave_channel(dev, "tx");
-	if (!ctlr->dma_tx) {
+	ctlr->dma_tx = dma_request_chan(dev, "tx");
+	if (IS_ERR(ctlr->dma_tx)) {
 		dev_err(dev, "no tx-dma configuration found - not using dma mode\n");
+		ret = PTR_ERR(ctlr->dma_tx);
+		ctlr->dma_tx = NULL;
 		goto err;
 	}
-	ctlr->dma_rx = dma_request_slave_channel(dev, "rx");
-	if (!ctlr->dma_rx) {
+	ctlr->dma_rx = dma_request_chan(dev, "rx");
+	if (IS_ERR(ctlr->dma_rx)) {
 		dev_err(dev, "no rx-dma configuration found - not using dma mode\n");
+		ret = PTR_ERR(ctlr->dma_rx);
+		ctlr->dma_rx = NULL;
 		goto err_release;
 	}
 
@@ -997,7 +1002,7 @@ static void bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
 	/* all went well, so set can_dma */
 	ctlr->can_dma = bcm2835_spi_can_dma;
 
-	return;
+	return 0;
 
 err_config:
 	dev_err(dev, "issue configuring dma: %d - not using DMA mode\n",
@@ -1005,7 +1010,14 @@ static void bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
 err_release:
 	bcm2835_dma_release(ctlr, bs);
 err:
-	return;
+	/*
+	 * Only report error for deferred probing, otherwise fall back to
+	 * interrupt mode
+	 */
+	if (ret != -EPROBE_DEFER)
+		ret = 0;
+
+	return ret;
 }
 
 static int bcm2835_spi_transfer_one_poll(struct spi_controller *ctlr,
@@ -1317,7 +1329,9 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 
 	clk_prepare_enable(bs->clk);
 
-	bcm2835_dma_init(ctlr, &pdev->dev, bs);
+	err = bcm2835_dma_init(ctlr, &pdev->dev, bs);
+	if (err)
+		goto out_clk_disable;
 
 	/* initialise the hardware with the default polarities */
 	bcm2835_wr(bs, BCM2835_SPI_CS,
-- 
2.20.1

