Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED7B107916
	for <lists+linux-spi@lfdr.de>; Fri, 22 Nov 2019 20:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfKVTzr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 Nov 2019 14:55:47 -0500
Received: from foss.arm.com ([217.140.110.172]:52186 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbfKVTzq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 22 Nov 2019 14:55:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 172C61396;
        Fri, 22 Nov 2019 11:55:46 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 885AF3F6C4;
        Fri, 22 Nov 2019 11:55:45 -0800 (PST)
Date:   Fri, 22 Nov 2019 19:55:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     broonie@kernel.org, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, vkoul@kernel.org
Subject: Applied "spi: pic32: Retire dma_request_slave_channel_compat()" to the spi tree
In-Reply-To: <20191121092703.30465-1-peter.ujfalusi@ti.com>
Message-Id: <applied-20191121092703.30465-1-peter.ujfalusi@ti.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: pic32: Retire dma_request_slave_channel_compat()

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

From eb7e6dc6d9ffcce129ac04d4e7bd2dc015bd45a5 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 21 Nov 2019 11:27:03 +0200
Subject: [PATCH] spi: pic32: Retire dma_request_slave_channel_compat()

There is no reason to use the dma_request_slave_channel_compat() as no
filter function and parameter is provided.

Switch the driver to use dma_request_chan() instead and add support for
deferred probing against DMA channel.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Link: https://lore.kernel.org/r/20191121092703.30465-1-peter.ujfalusi@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pic32.c | 46 +++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index 69f517ec59c6..156961b4ca86 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -606,25 +606,30 @@ static void pic32_spi_cleanup(struct spi_device *spi)
 	gpio_direction_output(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
 }
 
-static void pic32_spi_dma_prep(struct pic32_spi *pic32s, struct device *dev)
+static int pic32_spi_dma_prep(struct pic32_spi *pic32s, struct device *dev)
 {
 	struct spi_master *master = pic32s->master;
-	dma_cap_mask_t mask;
+	int ret = 0;
 
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
+	master->dma_rx = dma_request_chan(dev, "spi-rx");
+	if (IS_ERR(master->dma_rx)) {
+		if (PTR_ERR(master->dma_rx) == -EPROBE_DEFER)
+			ret = -EPROBE_DEFER;
+		else
+			dev_warn(dev, "RX channel not found.\n");
 
-	master->dma_rx = dma_request_slave_channel_compat(mask, NULL, NULL,
-							  dev, "spi-rx");
-	if (!master->dma_rx) {
-		dev_warn(dev, "RX channel not found.\n");
+		master->dma_rx = NULL;
 		goto out_err;
 	}
 
-	master->dma_tx = dma_request_slave_channel_compat(mask, NULL, NULL,
-							  dev, "spi-tx");
-	if (!master->dma_tx) {
-		dev_warn(dev, "TX channel not found.\n");
+	master->dma_tx = dma_request_chan(dev, "spi-tx");
+	if (IS_ERR(master->dma_tx)) {
+		if (PTR_ERR(master->dma_tx) == -EPROBE_DEFER)
+			ret = -EPROBE_DEFER;
+		else
+			dev_warn(dev, "TX channel not found.\n");
+
+		master->dma_tx = NULL;
 		goto out_err;
 	}
 
@@ -634,14 +639,20 @@ static void pic32_spi_dma_prep(struct pic32_spi *pic32s, struct device *dev)
 	/* DMA chnls allocated and prepared */
 	set_bit(PIC32F_DMA_PREP, &pic32s->flags);
 
-	return;
+	return 0;
 
 out_err:
-	if (master->dma_rx)
+	if (master->dma_rx) {
 		dma_release_channel(master->dma_rx);
+		master->dma_rx = NULL;
+	}
 
-	if (master->dma_tx)
+	if (master->dma_tx) {
 		dma_release_channel(master->dma_tx);
+		master->dma_tx = NULL;
+	}
+
+	return ret;
 }
 
 static void pic32_spi_dma_unprep(struct pic32_spi *pic32s)
@@ -776,7 +787,10 @@ static int pic32_spi_probe(struct platform_device *pdev)
 	master->unprepare_transfer_hardware	= pic32_spi_unprepare_hardware;
 
 	/* optional DMA support */
-	pic32_spi_dma_prep(pic32s, &pdev->dev);
+	ret = pic32_spi_dma_prep(pic32s, &pdev->dev);
+	if (ret)
+		goto err_bailout;
+
 	if (test_bit(PIC32F_DMA_PREP, &pic32s->flags))
 		master->can_dma	= pic32_spi_can_dma;
 
-- 
2.20.1

