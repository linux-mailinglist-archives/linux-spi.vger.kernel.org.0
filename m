Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E1A365432
	for <lists+linux-spi@lfdr.de>; Tue, 20 Apr 2021 10:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhDTIek (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Apr 2021 04:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhDTIej (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Apr 2021 04:34:39 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1F5C061763
        for <linux-spi@vger.kernel.org>; Tue, 20 Apr 2021 01:34:08 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id r12so57023066ejr.5
        for <linux-spi@vger.kernel.org>; Tue, 20 Apr 2021 01:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=devtank-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fEyunwwdlfOesu6cu8znhTRdSvHiaQimv53Nkvu2/Ms=;
        b=A5tGY/62El4/U8UQgU4S13zEeq4lQO4yo6U+yMUh7uIXXxkUeGk3dMPiNXhRr60ozY
         mWoGrqx8xCoGS15Gx3RknYSGLXLRC/nLW3LWNa+pWUKT/2W6nL6mbF21FfxAJZlNFhBv
         8CPyW7TfBxL9sk9c8uK5NM84wPYZ8ULCz0Y6FZSCIRC22h5KFgmAw3dMSa3iYvKM+SyM
         IjtN/LwR+vZyUHStTnNE8adY3GSa3jEe2PygF71NQnoDptvxibLI7bi3kuOjW1j0y83h
         izsXaBaIYH6pL7o9BbzwbObOZPQZk7p1R6uY/AuREo5+GsSaWYnQEiCvuDzk8uNQB/xG
         +3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fEyunwwdlfOesu6cu8znhTRdSvHiaQimv53Nkvu2/Ms=;
        b=PigAKcUoLWqcG4lXfpw9sV26qyiDo9rfg/MdMS9upsBd5etudN84BHVT4Q8OUdLf9q
         pwB6uSS4Ef5nhZA8a01M4P8qN+lVlV+KQ7LCKLVIA0sbF4moAWVEtiVBft7wGGyBk8sj
         1UoipsIRMGjuE1EI/5yjIyUGPyQJ+ADqHrEBtFVK+9XnsZ6n1EPNCOaOPnxsrumum/n4
         0z6pXmTXb5GCo1y+MjWum/9g+EVDyjC7+T1M1JXMBrbRI1f5hs4vPyik3suD+afNvDm9
         9jZTR0W0RVUS3gQ/ivyt9p4CPNqxDkJzOrn++793tZnehvycynU4fcRzhhm4cMByWZCM
         aawg==
X-Gm-Message-State: AOAM532V8afWD5V/4mf/IytlDx8txwqKNg00/YwbdOeYMSd0/LzhpbyX
        OdYiKSH+N9c0lAJDlSQg9cOhuQ==
X-Google-Smtp-Source: ABdhPJz7aM7Bwl/dR2pKbxiKX0S4UODEQmGieslAoRD1LKebcp9kK5wHO4fSQbWLdOvboV32vbl3sQ==
X-Received: by 2002:a17:906:5490:: with SMTP id r16mr27211264ejo.352.1618907647259;
        Tue, 20 Apr 2021 01:34:07 -0700 (PDT)
Received: from jabjoe-desktop.lan ([2a02:8010:673b:0:27d5:da8f:c244:7b8a])
        by smtp.googlemail.com with ESMTPSA id g11sm15483620edt.35.2021.04.20.01.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 01:34:06 -0700 (PDT)
From:   Joe Burmeister <joe.burmeister@devtank.co.uk>
To:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     joe.burmeister@devtank.co.uk
Subject: [PATCH] spi: bcm2835: Fix buffer overflow with CS able to go beyond limit.
Date:   Tue, 20 Apr 2021 09:34:02 +0100
Message-Id: <20210420083402.6950-1-joe.burmeister@devtank.co.uk>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

It was previoulsy possible to have a device tree with more chips than
the driver supports and go off the end of CS arrays.

This patches inforces CS limit but sets that limit to the max of the
default limit and what is in the device tree when driver is loaded.

Signed-off-by: Joe Burmeister <joe.burmeister@devtank.co.uk>
---
 drivers/spi/spi-bcm2835.c | 77 +++++++++++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index aab6c7e5c114..cee761bfffe4 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -28,6 +28,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/machine.h> /* FIXME: using chip internals */
 #include <linux/gpio/driver.h> /* FIXME: using chip internals */
+#include <linux/of_gpio.h>
 #include <linux/of_irq.h>
 #include <linux/spi/spi.h>
 
@@ -134,7 +135,7 @@ struct bcm2835_spi {
 	int tx_prologue;
 	int rx_prologue;
 	unsigned int tx_spillover;
-	u32 prepare_cs[BCM2835_SPI_NUM_CS];
+	u32 *prepare_cs;
 
 	struct dentry *debugfs_dir;
 	u64 count_transfer_polling;
@@ -147,9 +148,9 @@ struct bcm2835_spi {
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
@@ -875,14 +876,14 @@ static void bcm2835_dma_release(struct spi_controller *ctlr,
 	if (ctlr->dma_rx) {
 		dmaengine_terminate_sync(ctlr->dma_rx);
 
-		for (i = 0; i < BCM2835_SPI_NUM_CS; i++)
+		for (i = 0; i < ctlr->num_chipselect; i++)
 			if (bs->clear_rx_desc[i])
 				dmaengine_desc_free(bs->clear_rx_desc[i]);
 
 		if (bs->clear_rx_addr)
 			dma_unmap_single(ctlr->dma_rx->device->dev,
 					 bs->clear_rx_addr,
-					 sizeof(bs->clear_rx_cs),
+					 sizeof(u32) * ctlr->num_chipselect,
 					 DMA_TO_DEVICE);
 
 		dma_release_channel(ctlr->dma_rx);
@@ -978,7 +979,7 @@ static int bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
 
 	bs->clear_rx_addr = dma_map_single(ctlr->dma_rx->device->dev,
 					   bs->clear_rx_cs,
-					   sizeof(bs->clear_rx_cs),
+					   sizeof(u32) * ctlr->num_chipselect,
 					   DMA_TO_DEVICE);
 	if (dma_mapping_error(ctlr->dma_rx->device->dev, bs->clear_rx_addr)) {
 		dev_err(dev, "cannot map clear_rx_cs - not using DMA mode\n");
@@ -987,7 +988,7 @@ static int bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
 		goto err_release;
 	}
 
-	for (i = 0; i < BCM2835_SPI_NUM_CS; i++) {
+	for (i = 0; i < ctlr->num_chipselect; i++) {
 		bs->clear_rx_desc[i] = dmaengine_prep_dma_cyclic(ctlr->dma_rx,
 					   bs->clear_rx_addr + i * sizeof(u32),
 					   sizeof(u32), 0,
@@ -1209,6 +1210,12 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 	struct gpio_chip *chip;
 	u32 cs;
 
+	if (spi->chip_select >= ctlr->num_chipselect) {
+		dev_err(&spi->dev, "cs%d >= max %d\n", spi->chip_select,
+			ctlr->num_chipselect);
+		return -EINVAL;
+	}
+
 	/*
 	 * Precalculate SPI slave's CS register value for ->prepare_message():
 	 * The driver always uses software-controlled GPIO chip select, hence
@@ -1233,7 +1240,7 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 						    BCM2835_SPI_CS_CLEAR_RX;
 		dma_sync_single_for_device(ctlr->dma_rx->device->dev,
 					   bs->clear_rx_addr,
-					   sizeof(bs->clear_rx_cs),
+					   sizeof(u32) * ctlr->num_chipselect,
 					   DMA_TO_DEVICE);
 	}
 
@@ -1286,39 +1293,71 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 	return 0;
 }
 
+
+#ifdef CONFIG_OF
+static int bcm2835_spi_get_num_chipselect(struct platform_device *pdev)
+{
+	return max_t(int, of_gpio_named_count(pdev->dev.of_node, "cs-gpios"),
+		BCM2835_SPI_NUM_CS);
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
+	struct device *dev = &pdev->dev;
 	struct spi_controller *ctlr;
 	struct bcm2835_spi *bs;
+	int num_chipselect;
 	int err;
 
-	ctlr = devm_spi_alloc_master(&pdev->dev, ALIGN(sizeof(*bs),
+	ctlr = devm_spi_alloc_master(dev, ALIGN(sizeof(*bs),
 						  dma_get_cache_alignment()));
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
 	ctlr->prepare_message = bcm2835_spi_prepare_message;
-	ctlr->dev.of_node = pdev->dev.of_node;
+	ctlr->dev.of_node = dev->of_node;
 
 	bs = spi_controller_get_devdata(ctlr);
 	bs->ctlr = ctlr;
 
+	bs->prepare_cs = devm_kmalloc(dev, num_chipselect * sizeof(u32), GFP_KERNEL);
+	if (!bs->prepare_cs)
+		return -ENOMEM;
+
+	bs->clear_rx_desc = devm_kmalloc(dev, num_chipselect *
+		sizeof(struct dma_async_tx_descriptor *), GFP_KERNEL);
+	if (!bs->clear_rx_desc)
+		return -ENOMEM;
+
+	bs->clear_rx_cs = devm_kmalloc(dev, num_chipselect * sizeof(u32), GFP_DMA);
+	if (!bs->clear_rx_cs)
+		return -ENOMEM;
+
 	bs->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(bs->regs))
 		return PTR_ERR(bs->regs);
 
-	bs->clk = devm_clk_get(&pdev->dev, NULL);
+	bs->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(bs->clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(bs->clk),
+		return dev_err_probe(dev, PTR_ERR(bs->clk),
 				     "could not get clk\n");
 
 	bs->irq = platform_get_irq(pdev, 0);
@@ -1327,7 +1366,7 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 
 	clk_prepare_enable(bs->clk);
 
-	err = bcm2835_dma_init(ctlr, &pdev->dev, bs);
+	err = bcm2835_dma_init(ctlr, dev, bs);
 	if (err)
 		goto out_clk_disable;
 
@@ -1335,22 +1374,22 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	bcm2835_wr(bs, BCM2835_SPI_CS,
 		   BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX);
 
-	err = devm_request_irq(&pdev->dev, bs->irq, bcm2835_spi_interrupt,
+	err = devm_request_irq(dev, bs->irq, bcm2835_spi_interrupt,
 			       IRQF_SHARED,
-			       dev_name(&pdev->dev), bs);
+			       dev_name(dev), bs);
 	if (err) {
-		dev_err(&pdev->dev, "could not request IRQ: %d\n", err);
+		dev_err(dev, "could not request IRQ: %d\n", err);
 		goto out_dma_release;
 	}
 
 	err = spi_register_controller(ctlr);
 	if (err) {
-		dev_err(&pdev->dev, "could not register SPI controller: %d\n",
+		dev_err(dev, "could not register SPI controller: %d\n",
 			err);
 		goto out_dma_release;
 	}
 
-	bcm2835_debugfs_create(bs, dev_name(&pdev->dev));
+	bcm2835_debugfs_create(bs, dev_name(dev));
 
 	return 0;
 
-- 
2.30.2

