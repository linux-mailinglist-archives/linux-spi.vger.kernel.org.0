Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028BD35F3B5
	for <lists+linux-spi@lfdr.de>; Wed, 14 Apr 2021 14:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbhDNMZn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 14 Apr 2021 08:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhDNMZn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 14 Apr 2021 08:25:43 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F2FC061756
        for <linux-spi@vger.kernel.org>; Wed, 14 Apr 2021 05:25:21 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z1so23449764edb.8
        for <linux-spi@vger.kernel.org>; Wed, 14 Apr 2021 05:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=devtank-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lr1X4qPtfOj8I8pn0HovtsnthddwkxztVDaDC8OO86E=;
        b=Hhr4gSeUNYilkOpoDFPXl89lDs/S24n69zLy8pkb2U6TRTBPZMUETnygzMW/V1ZphJ
         Ytjqmfs8IX1lc7vvxPPvOlo0dP8+7cCW36JcTRaVLQqTr7+nmd7BUaBubd4TzrtZ33YZ
         wA0zYaQbqsWnuYvY81otQVY9eC5yqiOL6cDgIVoUyyZvhUhwru7Gg4S9YiEtyMGqblU9
         CaBOEYynolKwi0U2386oHaylAxw1XJJfCyVibYqMlLlV8bfkjXZAva25Aa606d4GvM/R
         mqonH8eMMG1LAzb6reu7OFWbD1sChGwUaqUsJdbT1gbtbXFljJp6EdMkUb1NIr2AwwZf
         QZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lr1X4qPtfOj8I8pn0HovtsnthddwkxztVDaDC8OO86E=;
        b=UAWJafGglKeJBOTHpXL4qd6wUqo26BxgfcE4vJou/WCvik17P17wNT18YF0GlRq6rG
         Q4Uvb4qjwOrKbTalgRRFcN07+6IPObpoN45Ze/7wD12Rg6qXWLsu1AgIgLEH2JIgUEj8
         5ezj8zHwMKslnHLYdPd378B12wP5qivstqKKpc4+EQ5+9NZxllmxNDd1tjYfFLGynF1d
         zu+6HVQowyjdQObLWKfBNO65+cmlscuCh9T864VrAS/sO99nW0CVzCjgEWmOzcyj3uRh
         z2frTBBRPtEQoC5d131/DHYf8Ar7C4pS2HlrWKrqXceRcjZljGpxaGmaZNnNVq4Kos7t
         YZ/w==
X-Gm-Message-State: AOAM532SCcWGzVJpiw7QA2fQNetITdzU048HUwsKPNcQI3Al1PnKWMSO
        IpNoIB3zJ/ICBJmhdyxzP+KZDw==
X-Google-Smtp-Source: ABdhPJwxvN5/0WaRJ0EpLWLBmahI89lvzh6kWzPEqVO39YGewLL6PZ3PSTrqYmI2/7zLNtBMjHHODA==
X-Received: by 2002:a05:6402:344e:: with SMTP id l14mr41306634edc.184.1618403120044;
        Wed, 14 Apr 2021 05:25:20 -0700 (PDT)
Received: from jabjoe-desktop.lan ([2a02:8010:673b:0:27d5:da8f:c244:7b8a])
        by smtp.googlemail.com with ESMTPSA id h15sm9896917ejs.72.2021.04.14.05.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 05:25:19 -0700 (PDT)
From:   Joe Burmeister <joe.burmeister@devtank.co.uk>
To:     joe.burmeister@devtank.co.uk, Mark Brown <broonie@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Remove BCM2835 SPI chipselect limit.
Date:   Wed, 14 Apr 2021 13:25:07 +0100
Message-Id: <20210414122507.203348-1-joe.burmeister@devtank.co.uk>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The limit of 4 chipselects for the BCM2835 was not required and also was
not inforced. Without inforcement it was possible to make a device tree
over this limit which would trample memory.

The chipselect count is now obtained from the device tree and expanded
if more devices are added.

Signed-off-by: Joe Burmeister <joe.burmeister@devtank.co.uk>
---
 drivers/spi/spi-bcm2835.c | 114 +++++++++++++++++++++++++++++++++-----
 1 file changed, 101 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index aab6c7e5c114..4f215ec3bd1b 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -28,6 +28,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/machine.h> /* FIXME: using chip internals */
 #include <linux/gpio/driver.h> /* FIXME: using chip internals */
+#include <linux/of_gpio.h>
 #include <linux/of_irq.h>
 #include <linux/spi/spi.h>
 
@@ -134,7 +135,8 @@ struct bcm2835_spi {
 	int tx_prologue;
 	int rx_prologue;
 	unsigned int tx_spillover;
-	u32 prepare_cs[BCM2835_SPI_NUM_CS];
+	unsigned int allocated_cs_num;
+	u32 *prepare_cs;
 
 	struct dentry *debugfs_dir;
 	u64 count_transfer_polling;
@@ -147,9 +149,9 @@ struct bcm2835_spi {
 	unsigned int rx_dma_active;
 	struct dma_async_tx_descriptor *fill_tx_desc;
 	dma_addr_t fill_tx_addr;
-	struct dma_async_tx_descriptor *clear_rx_desc[BCM2835_SPI_NUM_CS];
+	struct dma_async_tx_descriptor **clear_rx_desc;
 	dma_addr_t clear_rx_addr;
-	u32 clear_rx_cs[BCM2835_SPI_NUM_CS] ____cacheline_aligned;
+	u32 *clear_rx_cs;
 };
 
 #if defined(CONFIG_DEBUG_FS)
@@ -859,14 +861,18 @@ static void bcm2835_dma_release(struct spi_controller *ctlr,
 	if (ctlr->dma_tx) {
 		dmaengine_terminate_sync(ctlr->dma_tx);
 
-		if (bs->fill_tx_desc)
+		if (bs->fill_tx_desc) {
 			dmaengine_desc_free(bs->fill_tx_desc);
+			bs->fill_tx_desc = NULL;
+		}
 
-		if (bs->fill_tx_addr)
+		if (bs->fill_tx_addr) {
 			dma_unmap_page_attrs(ctlr->dma_tx->device->dev,
 					     bs->fill_tx_addr, sizeof(u32),
 					     DMA_TO_DEVICE,
 					     DMA_ATTR_SKIP_CPU_SYNC);
+			bs->fill_tx_addr = 0;
+		}
 
 		dma_release_channel(ctlr->dma_tx);
 		ctlr->dma_tx = NULL;
@@ -875,15 +881,19 @@ static void bcm2835_dma_release(struct spi_controller *ctlr,
 	if (ctlr->dma_rx) {
 		dmaengine_terminate_sync(ctlr->dma_rx);
 
-		for (i = 0; i < BCM2835_SPI_NUM_CS; i++)
-			if (bs->clear_rx_desc[i])
+		for (i = 0; i < bs->allocated_cs_num; i++)
+			if (bs->clear_rx_desc[i]) {
 				dmaengine_desc_free(bs->clear_rx_desc[i]);
+				bs->clear_rx_desc[i] = NULL;
+			}
 
-		if (bs->clear_rx_addr)
+		if (bs->clear_rx_addr) {
 			dma_unmap_single(ctlr->dma_rx->device->dev,
 					 bs->clear_rx_addr,
-					 sizeof(bs->clear_rx_cs),
+					 sizeof(u32) * bs->allocated_cs_num,
 					 DMA_TO_DEVICE);
+			bs->clear_rx_addr = 0;
+		}
 
 		dma_release_channel(ctlr->dma_rx);
 		ctlr->dma_rx = NULL;
@@ -978,7 +988,7 @@ static int bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
 
 	bs->clear_rx_addr = dma_map_single(ctlr->dma_rx->device->dev,
 					   bs->clear_rx_cs,
-					   sizeof(bs->clear_rx_cs),
+					   sizeof(u32) * bs->allocated_cs_num,
 					   DMA_TO_DEVICE);
 	if (dma_mapping_error(ctlr->dma_rx->device->dev, bs->clear_rx_addr)) {
 		dev_err(dev, "cannot map clear_rx_cs - not using DMA mode\n");
@@ -987,7 +997,7 @@ static int bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
 		goto err_release;
 	}
 
-	for (i = 0; i < BCM2835_SPI_NUM_CS; i++) {
+	for (i = 0; i < bs->allocated_cs_num; i++) {
 		bs->clear_rx_desc[i] = dmaengine_prep_dma_cyclic(ctlr->dma_rx,
 					   bs->clear_rx_addr + i * sizeof(u32),
 					   sizeof(u32), 0,
@@ -1209,6 +1219,48 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 	struct gpio_chip *chip;
 	u32 cs;
 
+	if (spi->chip_select >= bs->allocated_cs_num) {
+		unsigned int new_allocated_cs_num = spi->chip_select + 1;
+		void *new_prepare_cs, *new_clear_rx_desc, *new_clear_rx_cs;
+		int err;
+
+		dev_info(&spi->dev, "Increasing CS count to %u\n",
+			new_allocated_cs_num);
+
+		bcm2835_dma_release(ctlr, bs);
+
+		new_prepare_cs  = kmalloc_array(new_allocated_cs_num,
+			sizeof(u32), GFP_KERNEL);
+		new_clear_rx_desc = kmalloc_array(new_allocated_cs_num,
+			sizeof(struct dma_async_tx_descriptor *), GFP_KERNEL);
+		new_clear_rx_cs = kmalloc_array(new_allocated_cs_num,
+			sizeof(u32), GFP_DMA);
+
+		if (!new_prepare_cs || !new_clear_rx_desc || !new_clear_rx_cs) {
+			dev_err(&spi->dev, "Failed to allocate new CS arrays.\n");
+			return -ENOMEM;
+		}
+
+		memcpy(new_prepare_cs, bs->prepare_cs,
+			bs->allocated_cs_num * sizeof(u32));
+
+		kfree(bs->prepare_cs);
+		kfree(bs->clear_rx_desc);
+		kfree(bs->clear_rx_cs);
+
+		bs->prepare_cs  = new_prepare_cs;
+		bs->clear_rx_desc = new_clear_rx_desc;
+		bs->clear_rx_cs = new_clear_rx_cs;
+
+		bs->allocated_cs_num = new_allocated_cs_num;
+
+		err = bcm2835_dma_init(ctlr, &spi->dev, bs);
+		if (err) {
+			dev_err(&spi->dev, "Failed to reinit DMA after CS count change.");
+			return err;
+		}
+	}
+
 	/*
 	 * Precalculate SPI slave's CS register value for ->prepare_message():
 	 * The driver always uses software-controlled GPIO chip select, hence
@@ -1233,7 +1285,7 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 						    BCM2835_SPI_CS_CLEAR_RX;
 		dma_sync_single_for_device(ctlr->dma_rx->device->dev,
 					   bs->clear_rx_addr,
-					   sizeof(bs->clear_rx_cs),
+					   sizeof(u32) * bs->allocated_cs_num,
 					   DMA_TO_DEVICE);
 	}
 
@@ -1248,6 +1300,7 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 	 */
 	if (spi->cs_gpiod)
 		return 0;
+
 	if (spi->chip_select > 1) {
 		/* error in the case of native CS requested with CS > 1
 		 * officially there is a CS2, but it is not documented
@@ -1286,10 +1339,25 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 	return 0;
 }
 
+
+#ifdef CONFIG_OF
+static int bcm2835_spi_get_num_chipselect(struct platform_device *pdev)
+{
+	return max_t(int, of_gpio_named_count(pdev->dev.of_node, "cs-gpios"), BCM2835_SPI_NUM_CS);
+}
+#else
+static int bcm2835_spi_get_num_chipselect(struct platform_device *pdev)
+{
+	return BCM2835_SPI_NUM_CS;
+}
+#endif
+
+
 static int bcm2835_spi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr;
 	struct bcm2835_spi *bs;
+	int num_chipselect;
 	int err;
 
 	ctlr = devm_spi_alloc_master(&pdev->dev, ALIGN(sizeof(*bs),
@@ -1297,12 +1365,14 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	if (!ctlr)
 		return -ENOMEM;
 
+	num_chipselect = bcm2835_spi_get_num_chipselect(pdev);
+
 	platform_set_drvdata(pdev, ctlr);
 
 	ctlr->use_gpio_descriptors = true;
 	ctlr->mode_bits = BCM2835_SPI_MODE_BITS;
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
-	ctlr->num_chipselect = BCM2835_SPI_NUM_CS;
+	ctlr->num_chipselect = num_chipselect;
 	ctlr->setup = bcm2835_spi_setup;
 	ctlr->transfer_one = bcm2835_spi_transfer_one;
 	ctlr->handle_err = bcm2835_spi_handle_err;
@@ -1311,6 +1381,20 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 
 	bs = spi_controller_get_devdata(ctlr);
 	bs->ctlr = ctlr;
+	bs->allocated_cs_num = num_chipselect;
+
+	bs->prepare_cs = kmalloc_array(num_chipselect, sizeof(u32), GFP_KERNEL);
+	if (!bs->prepare_cs)
+		return -ENOMEM;
+
+	bs->clear_rx_desc = kmalloc_array(num_chipselect,
+		sizeof(struct dma_async_tx_descriptor *), GFP_KERNEL);
+	if (!bs->clear_rx_desc)
+		return -ENOMEM;
+
+	bs->clear_rx_cs = kmalloc_array(num_chipselect, sizeof(u32), GFP_DMA);
+	if (!bs->clear_rx_cs)
+		return -ENOMEM;
 
 	bs->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(bs->regs))
@@ -1378,6 +1462,10 @@ static int bcm2835_spi_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(bs->clk);
 
+	kfree(bs->prepare_cs);
+	kfree(bs->clear_rx_desc);
+	kfree(bs->clear_rx_cs);
+
 	return 0;
 }
 
-- 
2.30.2

