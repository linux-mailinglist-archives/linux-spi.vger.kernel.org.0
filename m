Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAE0361E4F
	for <lists+linux-spi@lfdr.de>; Fri, 16 Apr 2021 12:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbhDPK4Q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Apr 2021 06:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhDPK4O (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Apr 2021 06:56:14 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D74C061574
        for <linux-spi@vger.kernel.org>; Fri, 16 Apr 2021 03:55:48 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m9so13503299wrx.3
        for <linux-spi@vger.kernel.org>; Fri, 16 Apr 2021 03:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=devtank-co-uk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=+jK/khSVHJ1y5eubANaPZiTq0cIRmsC9NuskMZD6Be0=;
        b=wuK63TMJ+xLQW7LSV+erIfBCmBhBvQFYWuZ2vcf3zfsBRnZQkBtoyyjGFCji6Fl75x
         1fWWBWfiE99+Z9gaM1bsjg3Et9AmxCiNrhjmOtAlTrDjAEZuAxM8Aif5weTO9zwbhKrF
         MRP24qDHVlosryOL3Vzblysy/my6unHdygTtj6E7FC1I1iRprmyGc/06RylOKRXTIoGt
         PUBgrxPx2sGScsYH0YDQUiGVUnN+ERxwuaUVllP3c2g7wxHpWV11TtK7rt8+9eEPz2Ev
         LnTJ9nWT+rFF3Zrd1YWW/AlbS63FICtkz5262NLwai3bzw+NxZBWImnv5df1chuNWmQk
         WyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=+jK/khSVHJ1y5eubANaPZiTq0cIRmsC9NuskMZD6Be0=;
        b=LPGEjDEDUalixHViilUvy13hhacDwlOWmM3VtKC21nCosdyvg/Vcoej+h3OoULat5T
         bw8FGuo4oouINrad/YUbTw8yaEGGULwOdCwhDhwjPdG8WnUFsl/wt/rmMGienPMNMp1q
         mcVqZiKKPUs2VzP5FoJyb3d+dTavACPuwKQOcMKmQh6M0pPLmn756w5H021gNND7UX/a
         ctRxMYi1pg3JnU44/2jwJJkGfeyeSe6ceTQLXhpkjkkf7ylmr5mDIgCz5/dt+GVtW0S+
         lF5i+m5bWTHPtDJZNgchl4smGsqufbKeEGQ2tPOyFlZqg2HUiWcxkyg6vyo4lWinLkM3
         hwAw==
X-Gm-Message-State: AOAM532wUmBF7GBoFkj3SeveVJr1IZNpWFC2i58lB6lQbyjHG5RXHOeN
        2EZmMvJeKpn7G8I3CG1Tz3ilqYdwGKriCQ==
X-Google-Smtp-Source: ABdhPJyuRsP976qd8ndIH14tZxvj0AkvHqWK+C4/C9QYEXhs8E+BgHRQ+zvT01diirMWADE8O2f55w==
X-Received: by 2002:adf:ef84:: with SMTP id d4mr8434785wro.74.1618570547382;
        Fri, 16 Apr 2021 03:55:47 -0700 (PDT)
Received: from ?IPv6:2a02:8010:673b:0:27d5:da8f:c244:7b8a? ([2a02:8010:673b:0:27d5:da8f:c244:7b8a])
        by smtp.gmail.com with ESMTPSA id b12sm20186190wmj.1.2021.04.16.03.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 03:55:46 -0700 (PDT)
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org
From:   Joe Burmeister <joe.burmeister@devtank.co.uk>
Subject: Multi driver SPI chip select count unenforced.
Message-ID: <6a6c9d49-9064-4bbe-0330-87f92623d669@devtank.co.uk>
Date:   Fri, 16 Apr 2021 11:55:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------6B5BC019331F874EC2FDD890"
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This is a multi-part message in MIME format.
--------------6B5BC019331F874EC2FDD890
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Mark,

I think I've stubbled into an issue with some SPI drivers.


At first I thought it was just the BCM driver which is where I noticed it.
Patch attached.

However, after I found the same broken pattern in a few places.
You can find suspects by grep'ing in the SPI folder for "->chip_select]".


The problem pattern is basically that the driver allocates an array for the 
number of chip selects it expects to support. Then uses the chip_select to index
that array. However the number of devices on the SPI isn't enforced, so in
device tree you can go straight past it.


Even if the driver did enforce its limit, the returned status could be ignored.
Patch for that also attached.


So question is, what is the fix. Currently num_chipselect is not only not enforced
but changed to what is in the device tree by_spi_get_gpio_numbers and
spi_get_gpio_descs. Some drivers may not really have a limit anyway.


I only found this because we have 6 devices hanging off the a Pi3's SPI bus and 
it wasn't shutting down properly. Found this was because of a panic in 
debugfs_remove and that turned out to be because debugfs_dir wasn't a valid
pointer. Which was because it was after the prepare_cs array in the structure
and was just being overwritten with prepare_cs used beyond it's length.

Regards,

Joe


--------------6B5BC019331F874EC2FDD890
Content-Type: text/x-patch; charset=UTF-8;
 name="Handle-SPI-device-setup-callback-failure.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="Handle-SPI-device-setup-callback-failure.patch"

From 9b17e09bcec47eaa58e733336124ce4a53337572 Mon Sep 17 00:00:00 2001
From: Joe Burmeister <joe.burmeister@devtank.co.uk>
Date: Fri, 16 Apr 2021 11:08:07 +0100
Subject: [PATCH] Handle SPI device setup callback failure.

If the setup callback failed, but the controller has auto_runtime_pm
and set_cs, the setup failure could be missed.

Signed-off-by: Joe Burmeister <joe.burmeister@devtank.co.uk>
---
 drivers/spi/spi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8b283b2c1668..0c39178f4401 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3388,8 +3388,15 @@ int spi_setup(struct spi_device *spi)
 
 	mutex_lock(&spi->controller->io_mutex);
 
-	if (spi->controller->setup)
+	if (spi->controller->setup) {
 		status = spi->controller->setup(spi);
+		if (status) {
+			mutex_unlock(&spi->controller->io_mutex);
+			dev_err(&spi->controller->dev, "Failed to setup device: %d\n",
+				status);
+			return status;
+		}
+	}
 
 	if (spi->controller->auto_runtime_pm && spi->controller->set_cs) {
 		status = pm_runtime_get_sync(spi->controller->dev.parent);
-- 
2.30.2


--------------6B5BC019331F874EC2FDD890
Content-Type: text/x-patch; charset=UTF-8;
 name="Remove-BCM2835-SPI-chipselect-limit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="Remove-BCM2835-SPI-chipselect-limit.patch"

From c02e84b7dc8a89dbe6749779bff315ca572e4c2d Mon Sep 17 00:00:00 2001
From: Joe Burmeister <joe.burmeister@devtank.co.uk>
Date: Wed, 14 Apr 2021 12:11:10 +0100
Subject: [PATCH] Remove BCM2835 SPI chipselect limit.

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


--------------6B5BC019331F874EC2FDD890--
