Return-Path: <linux-spi+bounces-10427-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 120FBBB3DBB
	for <lists+linux-spi@lfdr.de>; Thu, 02 Oct 2025 14:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C76919C63A4
	for <lists+linux-spi@lfdr.de>; Thu,  2 Oct 2025 12:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF992472BD;
	Thu,  2 Oct 2025 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0jQ/Js35"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A430D2ED866
	for <linux-spi@vger.kernel.org>; Thu,  2 Oct 2025 12:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759407301; cv=none; b=G9fBTU8ZP91OYS9dAnBWx9vfn4izf8PVwPfVLbrw24dYfUGKjSe6z0ocZ31O2PrlkgDHYSR3JzBWE2Ea3/hTjY7i4SHycpXb5bMOQXxHGnJIaQkSsXiQ+ZGcNqEUo/wTYoZ7GXlYmXEUWwzSnJhLyXpFJjavzpAvPynHUGoeyEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759407301; c=relaxed/simple;
	bh=TL5iKamif9/4tL7FQ0FciqO0XBFjKW67GewQeJxLTD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RdZgj4l7OnySzCpmhUJDxgmtx/pHgN+lTh5VSHnTpZoNqb8sqX1IDoB5O3nWW5laZ0t4OpQLnxw6DUtWupmKHjOIGRejf5/ave7DF2NDXKfoRarZzQ2FWddsRbaBHCWuOyGG6uaYute0mjW0YsAWJfDp4t7j4B4/3jTKRzQIwyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0jQ/Js35; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E8A984E40E72
	for <linux-spi@vger.kernel.org>; Thu,  2 Oct 2025 12:14:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BE7A46062C;
	Thu,  2 Oct 2025 12:14:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 79AC4102F1BE8;
	Thu,  2 Oct 2025 14:14:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759407296; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=F8gvOaxNAH7inLC+vGtHLk3oAZwzMLD+DPQRdkt+DN4=;
	b=0jQ/Js35bCc6/HEB6wVHl+4Zbo7q1fveIsCqcSbyuks2Az6Q3SmhwPYqeE//S3+KKyNIu7
	gZaklzcpyteI2I+CUkA4GP7Lm+JQ+AaPEyBsK57GpgsO2NIzz4SnKJw6gK9iYfCqY/9jWF
	0klbwiNaQXvaboigmF8hGBNRihoMIArYBRs20NxndT0fRh0Tz/vhDyYBVVziChKNUKKrLu
	DTzYmsIhMrlTZ/oVfBiq+XB0yMhsWETlB/XfPxvBdGNw35qXd7WmS3WcwAARpJAwsbdwy0
	NhkaxmwJzO4vIfsMixQgpGiE0B6qj5cF5IsLyHFyx8AFKQEI1qhB9dz8iErJzA==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Thu, 02 Oct 2025 14:14:37 +0200
Subject: [PATCH RFC 1/2] spi: dw: rename the spi controller to ctlr
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251002-spi-dw-target-v1-1-993e91c1a712@bootlin.com>
References: <20251002-spi-dw-target-v1-0-993e91c1a712@bootlin.com>
In-Reply-To: <20251002-spi-dw-target-v1-0-993e91c1a712@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Since the designware SPI controller can act as both a target and a host,
rename spi_controller member of the dw_spi struct to ctlr instead of host.
Similarly, rename the functions handling the controller, using controller
instead of host as the suffix.

No functional changes intended.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/spi/spi-dw-bt1.c  |   4 +-
 drivers/spi/spi-dw-core.c | 128 +++++++++++++++++++++++-----------------------
 drivers/spi/spi-dw-dma.c  |  22 ++++----
 drivers/spi/spi-dw-mmio.c |   4 +-
 drivers/spi/spi-dw-pci.c  |   8 +--
 drivers/spi/spi-dw.h      |  12 ++---
 6 files changed, 89 insertions(+), 89 deletions(-)

diff --git a/drivers/spi/spi-dw-bt1.c b/drivers/spi/spi-dw-bt1.c
index 4a5be813efa75e3606b5dd546f0678ed68794d6e..91642e05ac6077cfb68dfd0ef6acf7cca960f211 100644
--- a/drivers/spi/spi-dw-bt1.c
+++ b/drivers/spi/spi-dw-bt1.c
@@ -288,7 +288,7 @@ static int dw_spi_bt1_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(&pdev->dev);
 
-	ret = dw_spi_add_host(&pdev->dev, dws);
+	ret = dw_spi_add_controller(&pdev->dev, dws);
 	if (ret) {
 		pm_runtime_disable(&pdev->dev);
 		return ret;
@@ -303,7 +303,7 @@ static void dw_spi_bt1_remove(struct platform_device *pdev)
 {
 	struct dw_spi_bt1 *dwsbt1 = platform_get_drvdata(pdev);
 
-	dw_spi_remove_host(&dwsbt1->dws);
+	dw_spi_remove_controller(&dwsbt1->dws);
 
 	pm_runtime_disable(&pdev->dev);
 }
diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index b3b883cb954107ea631d12c1ef1074046cff39a7..90dea6f9b3dab773204c667cb12f3ecaef1d7108 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -63,7 +63,7 @@ static void dw_spi_debugfs_init(struct dw_spi *dws)
 {
 	char name[32];
 
-	snprintf(name, 32, "dw_spi%d", dws->host->bus_num);
+	snprintf(name, 32, "dw_spi%d", dws->ctlr->bus_num);
 	dws->debugfs = debugfs_create_dir(name, NULL);
 
 	dws->regset.regs = dw_spi_dbgfs_regs;
@@ -185,25 +185,25 @@ int dw_spi_check_status(struct dw_spi *dws, bool raw)
 		irq_status = dw_readl(dws, DW_SPI_ISR);
 
 	if (irq_status & DW_SPI_INT_RXOI) {
-		dev_err(&dws->host->dev, "RX FIFO overflow detected\n");
+		dev_err(&dws->ctlr->dev, "RX FIFO overflow detected\n");
 		ret = -EIO;
 	}
 
 	if (irq_status & DW_SPI_INT_RXUI) {
-		dev_err(&dws->host->dev, "RX FIFO underflow detected\n");
+		dev_err(&dws->ctlr->dev, "RX FIFO underflow detected\n");
 		ret = -EIO;
 	}
 
 	if (irq_status & DW_SPI_INT_TXOI) {
-		dev_err(&dws->host->dev, "TX FIFO overflow detected\n");
+		dev_err(&dws->ctlr->dev, "TX FIFO overflow detected\n");
 		ret = -EIO;
 	}
 
 	/* Generically handle the erroneous situation */
 	if (ret) {
 		dw_spi_reset_chip(dws);
-		if (dws->host->cur_msg)
-			dws->host->cur_msg->status = ret;
+		if (dws->ctlr->cur_msg)
+			dws->ctlr->cur_msg->status = ret;
 	}
 
 	return ret;
@@ -215,7 +215,7 @@ static irqreturn_t dw_spi_transfer_handler(struct dw_spi *dws)
 	u16 irq_status = dw_readl(dws, DW_SPI_ISR);
 
 	if (dw_spi_check_status(dws, false)) {
-		spi_finalize_current_transfer(dws->host);
+		spi_finalize_current_transfer(dws->ctlr);
 		return IRQ_HANDLED;
 	}
 
@@ -229,7 +229,7 @@ static irqreturn_t dw_spi_transfer_handler(struct dw_spi *dws)
 	dw_reader(dws);
 	if (!dws->rx_len) {
 		dw_spi_mask_intr(dws, 0xff);
-		spi_finalize_current_transfer(dws->host);
+		spi_finalize_current_transfer(dws->ctlr);
 	} else if (dws->rx_len <= dw_readl(dws, DW_SPI_RXFTLR)) {
 		dw_writel(dws, DW_SPI_RXFTLR, dws->rx_len - 1);
 	}
@@ -250,14 +250,14 @@ static irqreturn_t dw_spi_transfer_handler(struct dw_spi *dws)
 
 static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 {
-	struct spi_controller *host = dev_id;
-	struct dw_spi *dws = spi_controller_get_devdata(host);
+	struct spi_controller *ctlr = dev_id;
+	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
 	u16 irq_status = dw_readl(dws, DW_SPI_ISR) & DW_SPI_INT_MASK;
 
 	if (!irq_status)
 		return IRQ_NONE;
 
-	if (!host->cur_msg) {
+	if (!ctlr->cur_msg) {
 		dw_spi_mask_intr(dws, 0xff);
 		return IRQ_HANDLED;
 	}
@@ -410,11 +410,11 @@ static int dw_spi_poll_transfer(struct dw_spi *dws,
 	return 0;
 }
 
-static int dw_spi_transfer_one(struct spi_controller *host,
+static int dw_spi_transfer_one(struct spi_controller *ctlr,
 			       struct spi_device *spi,
 			       struct spi_transfer *transfer)
 {
-	struct dw_spi *dws = spi_controller_get_devdata(host);
+	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
 	struct dw_spi_cfg cfg = {
 		.tmode = DW_SPI_CTRLR0_TMOD_TR,
 		.dfs = transfer->bits_per_word,
@@ -439,7 +439,7 @@ static int dw_spi_transfer_one(struct spi_controller *host,
 	transfer->effective_speed_hz = dws->current_freq;
 
 	/* Check if current transfer is a DMA transaction */
-	dws->dma_mapped = spi_xfer_is_dma_mapped(host, spi, transfer);
+	dws->dma_mapped = spi_xfer_is_dma_mapped(ctlr, spi, transfer);
 
 	/* For poll mode just disable all interrupts */
 	dw_spi_mask_intr(dws, 0xff);
@@ -462,10 +462,10 @@ static int dw_spi_transfer_one(struct spi_controller *host,
 	return 1;
 }
 
-static void dw_spi_handle_err(struct spi_controller *host,
+static void dw_spi_handle_err(struct spi_controller *ctlr,
 			      struct spi_message *msg)
 {
-	struct dw_spi *dws = spi_controller_get_devdata(host);
+	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
 
 	if (dws->dma_mapped)
 		dws->dma_ops->dma_stop(dws);
@@ -574,7 +574,7 @@ static int dw_spi_write_then_read(struct dw_spi *dws, struct spi_device *spi)
 	while (len) {
 		entries = readl_relaxed(dws->regs + DW_SPI_TXFLR);
 		if (!entries) {
-			dev_err(&dws->host->dev, "CS de-assertion on Tx\n");
+			dev_err(&dws->ctlr->dev, "CS de-assertion on Tx\n");
 			return -EIO;
 		}
 		room = min(dws->fifo_len - entries, len);
@@ -594,7 +594,7 @@ static int dw_spi_write_then_read(struct dw_spi *dws, struct spi_device *spi)
 		if (!entries) {
 			sts = readl_relaxed(dws->regs + DW_SPI_RISR);
 			if (sts & DW_SPI_INT_RXOI) {
-				dev_err(&dws->host->dev, "FIFO overflow on Rx\n");
+				dev_err(&dws->ctlr->dev, "FIFO overflow on Rx\n");
 				return -EIO;
 			}
 			continue;
@@ -635,7 +635,7 @@ static int dw_spi_wait_mem_op_done(struct dw_spi *dws)
 		spi_delay_exec(&delay, NULL);
 
 	if (retry < 0) {
-		dev_err(&dws->host->dev, "Mem op hanged up\n");
+		dev_err(&dws->ctlr->dev, "Mem op hanged up\n");
 		return -EIO;
 	}
 
@@ -898,60 +898,60 @@ static const struct spi_controller_mem_caps dw_spi_mem_caps = {
 	.per_op_freq = true,
 };
 
-int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
+int dw_spi_add_controller(struct device *dev, struct dw_spi *dws)
 {
-	struct spi_controller *host;
+	struct spi_controller *ctlr;
 	int ret;
 
 	if (!dws)
 		return -EINVAL;
 
-	host = spi_alloc_host(dev, 0);
-	if (!host)
+	ctlr = spi_alloc_host(dev, 0);
+	if (!ctlr)
 		return -ENOMEM;
 
-	device_set_node(&host->dev, dev_fwnode(dev));
+	device_set_node(&ctlr->dev, dev_fwnode(dev));
 
-	dws->host = host;
+	dws->ctlr = ctlr;
 	dws->dma_addr = (dma_addr_t)(dws->paddr + DW_SPI_DR);
 
-	spi_controller_set_devdata(host, dws);
+	spi_controller_set_devdata(ctlr, dws);
 
 	/* Basic HW init */
 	dw_spi_hw_init(dev, dws);
 
 	ret = request_irq(dws->irq, dw_spi_irq, IRQF_SHARED, dev_name(dev),
-			  host);
+			  ctlr);
 	if (ret < 0 && ret != -ENOTCONN) {
 		dev_err(dev, "can not get IRQ\n");
-		goto err_free_host;
+		goto err_free_ctlr;
 	}
 
 	dw_spi_init_mem_ops(dws);
 
-	host->use_gpio_descriptors = true;
-	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
+	ctlr->use_gpio_descriptors = true;
+	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
 	if (dws->caps & DW_SPI_CAP_DFS32)
-		host->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
+		ctlr->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	else
-		host->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16);
-	host->bus_num = dws->bus_num;
-	host->num_chipselect = dws->num_cs;
-	host->setup = dw_spi_setup;
-	host->cleanup = dw_spi_cleanup;
+		ctlr->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16);
+	ctlr->bus_num = dws->bus_num;
+	ctlr->num_chipselect = dws->num_cs;
+	ctlr->setup = dw_spi_setup;
+	ctlr->cleanup = dw_spi_cleanup;
 	if (dws->set_cs)
-		host->set_cs = dws->set_cs;
+		ctlr->set_cs = dws->set_cs;
 	else
-		host->set_cs = dw_spi_set_cs;
-	host->transfer_one = dw_spi_transfer_one;
-	host->handle_err = dw_spi_handle_err;
+		ctlr->set_cs = dw_spi_set_cs;
+	ctlr->transfer_one = dw_spi_transfer_one;
+	ctlr->handle_err = dw_spi_handle_err;
 	if (dws->mem_ops.exec_op) {
-		host->mem_ops = &dws->mem_ops;
-		host->mem_caps = &dw_spi_mem_caps;
+		ctlr->mem_ops = &dws->mem_ops;
+		ctlr->mem_caps = &dw_spi_mem_caps;
 	}
-	host->max_speed_hz = dws->max_freq;
-	host->flags = SPI_CONTROLLER_GPIO_SS;
-	host->auto_runtime_pm = true;
+	ctlr->max_speed_hz = dws->max_freq;
+	ctlr->flags = SPI_CONTROLLER_GPIO_SS;
+	ctlr->auto_runtime_pm = true;
 
 	/* Get default rx sample delay */
 	device_property_read_u32(dev, "rx-sample-delay-ns",
@@ -964,14 +964,14 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 		} else if (ret) {
 			dev_warn(dev, "DMA init failed\n");
 		} else {
-			host->can_dma = dws->dma_ops->can_dma;
-			host->flags |= SPI_CONTROLLER_MUST_TX;
+			ctlr->can_dma = dws->dma_ops->can_dma;
+			ctlr->flags |= SPI_CONTROLLER_MUST_TX;
 		}
 	}
 
-	ret = spi_register_controller(host);
+	ret = spi_register_controller(ctlr);
 	if (ret) {
-		dev_err_probe(dev, ret, "problem registering spi host\n");
+		dev_err_probe(dev, ret, "problem registering spi controller\n");
 		goto err_dma_exit;
 	}
 
@@ -983,47 +983,47 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 		dws->dma_ops->dma_exit(dws);
 	dw_spi_enable_chip(dws, 0);
 err_free_irq:
-	free_irq(dws->irq, host);
-err_free_host:
-	spi_controller_put(host);
+	free_irq(dws->irq, ctlr);
+err_free_ctlr:
+	spi_controller_put(ctlr);
 	return ret;
 }
-EXPORT_SYMBOL_NS_GPL(dw_spi_add_host, "SPI_DW_CORE");
+EXPORT_SYMBOL_NS_GPL(dw_spi_add_controller, "SPI_DW_CORE");
 
-void dw_spi_remove_host(struct dw_spi *dws)
+void dw_spi_remove_controller(struct dw_spi *dws)
 {
 	dw_spi_debugfs_remove(dws);
 
-	spi_unregister_controller(dws->host);
+	spi_unregister_controller(dws->ctlr);
 
 	if (dws->dma_ops && dws->dma_ops->dma_exit)
 		dws->dma_ops->dma_exit(dws);
 
 	dw_spi_shutdown_chip(dws);
 
-	free_irq(dws->irq, dws->host);
+	free_irq(dws->irq, dws->ctlr);
 }
-EXPORT_SYMBOL_NS_GPL(dw_spi_remove_host, "SPI_DW_CORE");
+EXPORT_SYMBOL_NS_GPL(dw_spi_remove_controller, "SPI_DW_CORE");
 
-int dw_spi_suspend_host(struct dw_spi *dws)
+int dw_spi_suspend_controller(struct dw_spi *dws)
 {
 	int ret;
 
-	ret = spi_controller_suspend(dws->host);
+	ret = spi_controller_suspend(dws->ctlr);
 	if (ret)
 		return ret;
 
 	dw_spi_shutdown_chip(dws);
 	return 0;
 }
-EXPORT_SYMBOL_NS_GPL(dw_spi_suspend_host, "SPI_DW_CORE");
+EXPORT_SYMBOL_NS_GPL(dw_spi_suspend_controller, "SPI_DW_CORE");
 
-int dw_spi_resume_host(struct dw_spi *dws)
+int dw_spi_resume_controller(struct dw_spi *dws)
 {
-	dw_spi_hw_init(&dws->host->dev, dws);
-	return spi_controller_resume(dws->host);
+	dw_spi_hw_init(&dws->ctlr->dev, dws);
+	return spi_controller_resume(dws->ctlr);
 }
-EXPORT_SYMBOL_NS_GPL(dw_spi_resume_host, "SPI_DW_CORE");
+EXPORT_SYMBOL_NS_GPL(dw_spi_resume_controller, "SPI_DW_CORE");
 
 MODULE_AUTHOR("Feng Tang <feng.tang@intel.com>");
 MODULE_DESCRIPTION("Driver for DesignWare SPI controller core");
diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index b5bed02b7e5006d399697384c958137649786f1a..65adec7c7524b8362ec63be556a5a6ba8ab53a99 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -139,8 +139,8 @@ static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 	if (!dws->txchan)
 		goto free_rxchan;
 
-	dws->host->dma_rx = dws->rxchan;
-	dws->host->dma_tx = dws->txchan;
+	dws->ctlr->dma_rx = dws->rxchan;
+	dws->ctlr->dma_tx = dws->txchan;
 
 	init_completion(&dws->dma_completion);
 
@@ -183,8 +183,8 @@ static int dw_spi_dma_init_generic(struct device *dev, struct dw_spi *dws)
 		goto free_rxchan;
 	}
 
-	dws->host->dma_rx = dws->rxchan;
-	dws->host->dma_tx = dws->txchan;
+	dws->ctlr->dma_rx = dws->rxchan;
+	dws->ctlr->dma_tx = dws->txchan;
 
 	init_completion(&dws->dma_completion);
 
@@ -242,10 +242,10 @@ static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes)
 	}
 }
 
-static bool dw_spi_can_dma(struct spi_controller *host,
+static bool dw_spi_can_dma(struct spi_controller *ctlr,
 			   struct spi_device *spi, struct spi_transfer *xfer)
 {
-	struct dw_spi *dws = spi_controller_get_devdata(host);
+	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
 	enum dma_slave_buswidth dma_bus_width;
 
 	if (xfer->len <= dws->fifo_len)
@@ -271,7 +271,7 @@ static int dw_spi_dma_wait(struct dw_spi *dws, unsigned int len, u32 speed)
 					 msecs_to_jiffies(ms));
 
 	if (ms == 0) {
-		dev_err(&dws->host->cur_msg->spi->dev,
+		dev_err(&dws->ctlr->cur_msg->spi->dev,
 			"DMA transaction timed out\n");
 		return -ETIMEDOUT;
 	}
@@ -299,7 +299,7 @@ static int dw_spi_dma_wait_tx_done(struct dw_spi *dws,
 		spi_delay_exec(&delay, xfer);
 
 	if (retry < 0) {
-		dev_err(&dws->host->dev, "Tx hanged up\n");
+		dev_err(&dws->ctlr->dev, "Tx hanged up\n");
 		return -EIO;
 	}
 
@@ -400,7 +400,7 @@ static int dw_spi_dma_wait_rx_done(struct dw_spi *dws)
 		spi_delay_exec(&delay, NULL);
 
 	if (retry < 0) {
-		dev_err(&dws->host->dev, "Rx hanged up\n");
+		dev_err(&dws->ctlr->dev, "Rx hanged up\n");
 		return -EIO;
 	}
 
@@ -656,13 +656,13 @@ static int dw_spi_dma_transfer(struct dw_spi *dws, struct spi_transfer *xfer)
 	if (ret)
 		return ret;
 
-	if (dws->host->cur_msg->status == -EINPROGRESS) {
+	if (dws->ctlr->cur_msg->status == -EINPROGRESS) {
 		ret = dw_spi_dma_wait_tx_done(dws, xfer);
 		if (ret)
 			return ret;
 	}
 
-	if (xfer->rx_buf && dws->host->cur_msg->status == -EINPROGRESS)
+	if (xfer->rx_buf && dws->ctlr->cur_msg->status == -EINPROGRESS)
 		ret = dw_spi_dma_wait_rx_done(dws);
 
 	return ret;
diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index f0f576fac77afed6ca2ddc0d31e37bc76462c736..cc16139e121bf2dae29a16e362db56ea8ad3a18b 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -380,7 +380,7 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(&pdev->dev);
 
-	ret = dw_spi_add_host(&pdev->dev, dws);
+	ret = dw_spi_add_controller(&pdev->dev, dws);
 	if (ret)
 		goto out;
 
@@ -399,7 +399,7 @@ static void dw_spi_mmio_remove(struct platform_device *pdev)
 {
 	struct dw_spi_mmio *dwsmmio = platform_get_drvdata(pdev);
 
-	dw_spi_remove_host(&dwsmmio->dws);
+	dw_spi_remove_controller(&dwsmmio->dws);
 	pm_runtime_disable(&pdev->dev);
 	reset_control_assert(dwsmmio->rstc);
 }
diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index b32d6648a32ea251028d2b4ad422941867c71519..72d9f5bc87f75a00f97d9c159a0acb118b0a77ab 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -127,7 +127,7 @@ static int dw_spi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *en
 		goto err_free_irq_vectors;
 	}
 
-	ret = dw_spi_add_host(&pdev->dev, dws);
+	ret = dw_spi_add_controller(&pdev->dev, dws);
 	if (ret)
 		goto err_free_irq_vectors;
 
@@ -156,7 +156,7 @@ static void dw_spi_pci_remove(struct pci_dev *pdev)
 	pm_runtime_forbid(&pdev->dev);
 	pm_runtime_get_noresume(&pdev->dev);
 
-	dw_spi_remove_host(dws);
+	dw_spi_remove_controller(dws);
 	pci_free_irq_vectors(pdev);
 }
 
@@ -165,14 +165,14 @@ static int dw_spi_pci_suspend(struct device *dev)
 {
 	struct dw_spi *dws = dev_get_drvdata(dev);
 
-	return dw_spi_suspend_host(dws);
+	return dw_spi_suspend_controller(dws);
 }
 
 static int dw_spi_pci_resume(struct device *dev)
 {
 	struct dw_spi *dws = dev_get_drvdata(dev);
 
-	return dw_spi_resume_host(dws);
+	return dw_spi_resume_controller(dws);
 }
 #endif
 
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index fc267c6437ae095e37de78b480856ca8deb5656e..9cc79c566a70c0ababf01cc73111c14d73a35a98 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -142,14 +142,14 @@ struct dw_spi_dma_ops {
 	int (*dma_init)(struct device *dev, struct dw_spi *dws);
 	void (*dma_exit)(struct dw_spi *dws);
 	int (*dma_setup)(struct dw_spi *dws, struct spi_transfer *xfer);
-	bool (*can_dma)(struct spi_controller *host, struct spi_device *spi,
+	bool (*can_dma)(struct spi_controller *ctlr, struct spi_device *spi,
 			struct spi_transfer *xfer);
 	int (*dma_transfer)(struct dw_spi *dws, struct spi_transfer *xfer);
 	void (*dma_stop)(struct dw_spi *dws);
 };
 
 struct dw_spi {
-	struct spi_controller	*host;
+	struct spi_controller	*ctlr;
 
 	u32			ip;		/* Synopsys DW SSI IP-core ID */
 	u32			ver;		/* Synopsys component version */
@@ -288,10 +288,10 @@ extern void dw_spi_set_cs(struct spi_device *spi, bool enable);
 extern void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
 				 struct dw_spi_cfg *cfg);
 extern int dw_spi_check_status(struct dw_spi *dws, bool raw);
-extern int dw_spi_add_host(struct device *dev, struct dw_spi *dws);
-extern void dw_spi_remove_host(struct dw_spi *dws);
-extern int dw_spi_suspend_host(struct dw_spi *dws);
-extern int dw_spi_resume_host(struct dw_spi *dws);
+extern int dw_spi_add_controller(struct device *dev, struct dw_spi *dws);
+extern void dw_spi_remove_controller(struct dw_spi *dws);
+extern int dw_spi_suspend_controller(struct dw_spi *dws);
+extern int dw_spi_resume_controller(struct dw_spi *dws);
 
 #ifdef CONFIG_SPI_DW_DMA
 

-- 
2.51.0


