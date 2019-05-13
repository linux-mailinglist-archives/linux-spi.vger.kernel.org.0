Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3901B934
	for <lists+linux-spi@lfdr.de>; Mon, 13 May 2019 16:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbfEMOzH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 May 2019 10:55:07 -0400
Received: from mailout3.hostsharing.net ([176.9.242.54]:41443 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730999AbfEMOzH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 May 2019 10:55:07 -0400
X-Greylist: delayed 344 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 May 2019 10:55:03 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id 8004A102D3B8F;
        Mon, 13 May 2019 16:49:18 +0200 (CEST)
Received: from localhost (p54917535.dip0.t-ipconnect.de [84.145.117.53])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 153AC6154089;
        Mon, 13 May 2019 16:49:18 +0200 (CEST)
X-Mailbox-Line: From 5622fbd8314cf518b9530745e49545bc6287015d Mon Sep 17 00:00:00 2001
Message-Id: <5622fbd8314cf518b9530745e49545bc6287015d.1557758205.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 13 May 2019 16:48:39 +0200
Subject: [PATCH] spi: bcm2835: Replace spi_master by spi_controller
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Mark Brown <broonie@kernel.org>
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Frank Pavlic <f.pavlic@kunbus.de>, Simon Han <z.han@kunbus.de>,
        Martin Sperl <kernel@martin.sperl.org>,
        Noralf Tronnes <noralf@tronnes.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Commit 8caab75fd2c2 ('spi: Generalize SPI "master" to "controller"')
changed the "spi_master" nomenclature to "spi_controller", necessitating
a conversion of all drivers.

Perform this conversion for the BCM2835 SPI driver.
No functional change intended.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Frank Pavlic <f.pavlic@kunbus.de>
Cc: Martin Sperl <kernel@martin.sperl.org>
Cc: Noralf Trønnes <noralf@tronnes.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-bcm2835.c | 191 +++++++++++++++++++-------------------
 1 file changed, 96 insertions(+), 95 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index f87a023a445a..1c34a7bcdb7f 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -318,9 +318,9 @@ static inline void bcm2835_wr_fifo_blind(struct bcm2835_spi *bs, int count)
 	}
 }
 
-static void bcm2835_spi_reset_hw(struct spi_master *master)
+static void bcm2835_spi_reset_hw(struct spi_controller *ctlr)
 {
-	struct bcm2835_spi *bs = spi_master_get_devdata(master);
+	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
 	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);
 
 	/* Disable SPI interrupts and transfer */
@@ -339,8 +339,8 @@ static void bcm2835_spi_reset_hw(struct spi_master *master)
 
 static irqreturn_t bcm2835_spi_interrupt(int irq, void *dev_id)
 {
-	struct spi_master *master = dev_id;
-	struct bcm2835_spi *bs = spi_master_get_devdata(master);
+	struct spi_controller *ctlr = dev_id;
+	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
 	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);
 
 	/*
@@ -362,20 +362,20 @@ static irqreturn_t bcm2835_spi_interrupt(int irq, void *dev_id)
 
 	if (!bs->rx_len) {
 		/* Transfer complete - reset SPI HW */
-		bcm2835_spi_reset_hw(master);
+		bcm2835_spi_reset_hw(ctlr);
 		/* wake up the framework */
-		complete(&master->xfer_completion);
+		complete(&ctlr->xfer_completion);
 	}
 
 	return IRQ_HANDLED;
 }
 
-static int bcm2835_spi_transfer_one_irq(struct spi_master *master,
+static int bcm2835_spi_transfer_one_irq(struct spi_controller *ctlr,
 					struct spi_device *spi,
 					struct spi_transfer *tfr,
 					u32 cs, bool fifo_empty)
 {
-	struct bcm2835_spi *bs = spi_master_get_devdata(master);
+	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
 
 	/* update usage statistics */
 	bs->count_transfer_irq++;
@@ -401,7 +401,7 @@ static int bcm2835_spi_transfer_one_irq(struct spi_master *master,
 
 /**
  * bcm2835_spi_transfer_prologue() - transfer first few bytes without DMA
- * @master: SPI master
+ * @ctlr: SPI master controller
  * @tfr: SPI transfer
  * @bs: BCM2835 SPI controller
  * @cs: CS register
@@ -445,7 +445,7 @@ static int bcm2835_spi_transfer_one_irq(struct spi_master *master,
  * be transmitted in 32-bit width to ensure that the following DMA transfer can
  * pick up the residue in the RX FIFO in ungarbled form.
  */
-static void bcm2835_spi_transfer_prologue(struct spi_master *master,
+static void bcm2835_spi_transfer_prologue(struct spi_controller *ctlr,
 					  struct spi_transfer *tfr,
 					  struct bcm2835_spi *bs,
 					  u32 cs)
@@ -486,9 +486,9 @@ static void bcm2835_spi_transfer_prologue(struct spi_master *master,
 		bcm2835_wr_fifo_count(bs, bs->rx_prologue);
 		bcm2835_wait_tx_fifo_empty(bs);
 		bcm2835_rd_fifo_count(bs, bs->rx_prologue);
-		bcm2835_spi_reset_hw(master);
+		bcm2835_spi_reset_hw(ctlr);
 
-		dma_sync_single_for_device(master->dma_rx->device->dev,
+		dma_sync_single_for_device(ctlr->dma_rx->device->dev,
 					   sg_dma_address(&tfr->rx_sg.sgl[0]),
 					   bs->rx_prologue, DMA_FROM_DEVICE);
 
@@ -552,11 +552,11 @@ static void bcm2835_spi_undo_prologue(struct bcm2835_spi *bs)
 
 static void bcm2835_spi_dma_done(void *data)
 {
-	struct spi_master *master = data;
-	struct bcm2835_spi *bs = spi_master_get_devdata(master);
+	struct spi_controller *ctlr = data;
+	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
 
 	/* reset fifo and HW */
-	bcm2835_spi_reset_hw(master);
+	bcm2835_spi_reset_hw(ctlr);
 
 	/* and terminate tx-dma as we do not have an irq for it
 	 * because when the rx dma will terminate and this callback
@@ -564,15 +564,15 @@ static void bcm2835_spi_dma_done(void *data)
 	 * situation otherwise...
 	 */
 	if (cmpxchg(&bs->dma_pending, true, false)) {
-		dmaengine_terminate_async(master->dma_tx);
+		dmaengine_terminate_async(ctlr->dma_tx);
 		bcm2835_spi_undo_prologue(bs);
 	}
 
 	/* and mark as completed */;
-	complete(&master->xfer_completion);
+	complete(&ctlr->xfer_completion);
 }
 
-static int bcm2835_spi_prepare_sg(struct spi_master *master,
+static int bcm2835_spi_prepare_sg(struct spi_controller *ctlr,
 				  struct spi_transfer *tfr,
 				  bool is_tx)
 {
@@ -587,14 +587,14 @@ static int bcm2835_spi_prepare_sg(struct spi_master *master,
 
 	if (is_tx) {
 		dir   = DMA_MEM_TO_DEV;
-		chan  = master->dma_tx;
+		chan  = ctlr->dma_tx;
 		nents = tfr->tx_sg.nents;
 		sgl   = tfr->tx_sg.sgl;
 		flags = 0 /* no  tx interrupt */;
 
 	} else {
 		dir   = DMA_DEV_TO_MEM;
-		chan  = master->dma_rx;
+		chan  = ctlr->dma_rx;
 		nents = tfr->rx_sg.nents;
 		sgl   = tfr->rx_sg.sgl;
 		flags = DMA_PREP_INTERRUPT;
@@ -607,7 +607,7 @@ static int bcm2835_spi_prepare_sg(struct spi_master *master,
 	/* set callback for rx */
 	if (!is_tx) {
 		desc->callback = bcm2835_spi_dma_done;
-		desc->callback_param = master;
+		desc->callback_param = ctlr;
 	}
 
 	/* submit it to DMA-engine */
@@ -616,12 +616,12 @@ static int bcm2835_spi_prepare_sg(struct spi_master *master,
 	return dma_submit_error(cookie);
 }
 
-static int bcm2835_spi_transfer_one_dma(struct spi_master *master,
+static int bcm2835_spi_transfer_one_dma(struct spi_controller *ctlr,
 					struct spi_device *spi,
 					struct spi_transfer *tfr,
 					u32 cs)
 {
-	struct bcm2835_spi *bs = spi_master_get_devdata(master);
+	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
 	int ret;
 
 	/* update usage statistics */
@@ -631,15 +631,15 @@ static int bcm2835_spi_transfer_one_dma(struct spi_master *master,
 	 * Transfer first few bytes without DMA if length of first TX or RX
 	 * sglist entry is not a multiple of 4 bytes (hardware limitation).
 	 */
-	bcm2835_spi_transfer_prologue(master, tfr, bs, cs);
+	bcm2835_spi_transfer_prologue(ctlr, tfr, bs, cs);
 
 	/* setup tx-DMA */
-	ret = bcm2835_spi_prepare_sg(master, tfr, true);
+	ret = bcm2835_spi_prepare_sg(ctlr, tfr, true);
 	if (ret)
 		goto err_reset_hw;
 
 	/* start TX early */
-	dma_async_issue_pending(master->dma_tx);
+	dma_async_issue_pending(ctlr->dma_tx);
 
 	/* mark as dma pending */
 	bs->dma_pending = 1;
@@ -655,27 +655,27 @@ static int bcm2835_spi_transfer_one_dma(struct spi_master *master,
 	 * mapping of the rx buffers still takes place
 	 * this saves 10us or more.
 	 */
-	ret = bcm2835_spi_prepare_sg(master, tfr, false);
+	ret = bcm2835_spi_prepare_sg(ctlr, tfr, false);
 	if (ret) {
 		/* need to reset on errors */
-		dmaengine_terminate_sync(master->dma_tx);
+		dmaengine_terminate_sync(ctlr->dma_tx);
 		bs->dma_pending = false;
 		goto err_reset_hw;
 	}
 
 	/* start rx dma late */
-	dma_async_issue_pending(master->dma_rx);
+	dma_async_issue_pending(ctlr->dma_rx);
 
 	/* wait for wakeup in framework */
 	return 1;
 
 err_reset_hw:
-	bcm2835_spi_reset_hw(master);
+	bcm2835_spi_reset_hw(ctlr);
 	bcm2835_spi_undo_prologue(bs);
 	return ret;
 }
 
-static bool bcm2835_spi_can_dma(struct spi_master *master,
+static bool bcm2835_spi_can_dma(struct spi_controller *ctlr,
 				struct spi_device *spi,
 				struct spi_transfer *tfr)
 {
@@ -687,21 +687,21 @@ static bool bcm2835_spi_can_dma(struct spi_master *master,
 	return true;
 }
 
-static void bcm2835_dma_release(struct spi_master *master)
+static void bcm2835_dma_release(struct spi_controller *ctlr)
 {
-	if (master->dma_tx) {
-		dmaengine_terminate_sync(master->dma_tx);
-		dma_release_channel(master->dma_tx);
-		master->dma_tx = NULL;
+	if (ctlr->dma_tx) {
+		dmaengine_terminate_sync(ctlr->dma_tx);
+		dma_release_channel(ctlr->dma_tx);
+		ctlr->dma_tx = NULL;
 	}
-	if (master->dma_rx) {
-		dmaengine_terminate_sync(master->dma_rx);
-		dma_release_channel(master->dma_rx);
-		master->dma_rx = NULL;
+	if (ctlr->dma_rx) {
+		dmaengine_terminate_sync(ctlr->dma_rx);
+		dma_release_channel(ctlr->dma_rx);
+		ctlr->dma_rx = NULL;
 	}
 }
 
-static void bcm2835_dma_init(struct spi_master *master, struct device *dev)
+static void bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev)
 {
 	struct dma_slave_config slave_config;
 	const __be32 *addr;
@@ -709,7 +709,7 @@ static void bcm2835_dma_init(struct spi_master *master, struct device *dev)
 	int ret;
 
 	/* base address in dma-space */
-	addr = of_get_address(master->dev.of_node, 0, NULL, NULL);
+	addr = of_get_address(ctlr->dev.of_node, 0, NULL, NULL);
 	if (!addr) {
 		dev_err(dev, "could not get DMA-register address - not using dma mode\n");
 		goto err;
@@ -717,13 +717,13 @@ static void bcm2835_dma_init(struct spi_master *master, struct device *dev)
 	dma_reg_base = be32_to_cpup(addr);
 
 	/* get tx/rx dma */
-	master->dma_tx = dma_request_slave_channel(dev, "tx");
-	if (!master->dma_tx) {
+	ctlr->dma_tx = dma_request_slave_channel(dev, "tx");
+	if (!ctlr->dma_tx) {
 		dev_err(dev, "no tx-dma configuration found - not using dma mode\n");
 		goto err;
 	}
-	master->dma_rx = dma_request_slave_channel(dev, "rx");
-	if (!master->dma_rx) {
+	ctlr->dma_rx = dma_request_slave_channel(dev, "rx");
+	if (!ctlr->dma_rx) {
 		dev_err(dev, "no rx-dma configuration found - not using dma mode\n");
 		goto err_release;
 	}
@@ -733,7 +733,7 @@ static void bcm2835_dma_init(struct spi_master *master, struct device *dev)
 	slave_config.dst_addr = (u32)(dma_reg_base + BCM2835_SPI_FIFO);
 	slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 
-	ret = dmaengine_slave_config(master->dma_tx, &slave_config);
+	ret = dmaengine_slave_config(ctlr->dma_tx, &slave_config);
 	if (ret)
 		goto err_config;
 
@@ -741,14 +741,14 @@ static void bcm2835_dma_init(struct spi_master *master, struct device *dev)
 	slave_config.src_addr = (u32)(dma_reg_base + BCM2835_SPI_FIFO);
 	slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 
-	ret = dmaengine_slave_config(master->dma_rx, &slave_config);
+	ret = dmaengine_slave_config(ctlr->dma_rx, &slave_config);
 	if (ret)
 		goto err_config;
 
 	/* all went well, so set can_dma */
-	master->can_dma = bcm2835_spi_can_dma;
+	ctlr->can_dma = bcm2835_spi_can_dma;
 	/* need to do TX AND RX DMA, so we need dummy buffers */
-	master->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
+	ctlr->flags = SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX;
 
 	return;
 
@@ -756,17 +756,17 @@ static void bcm2835_dma_init(struct spi_master *master, struct device *dev)
 	dev_err(dev, "issue configuring dma: %d - not using DMA mode\n",
 		ret);
 err_release:
-	bcm2835_dma_release(master);
+	bcm2835_dma_release(ctlr);
 err:
 	return;
 }
 
-static int bcm2835_spi_transfer_one_poll(struct spi_master *master,
+static int bcm2835_spi_transfer_one_poll(struct spi_controller *ctlr,
 					 struct spi_device *spi,
 					 struct spi_transfer *tfr,
 					 u32 cs)
 {
-	struct bcm2835_spi *bs = spi_master_get_devdata(master);
+	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
 	unsigned long timeout;
 
 	/* update usage statistics */
@@ -805,22 +805,22 @@ static int bcm2835_spi_transfer_one_poll(struct spi_master *master,
 			/* update usage statistics */
 			bs->count_transfer_irq_after_polling++;
 
-			return bcm2835_spi_transfer_one_irq(master, spi,
+			return bcm2835_spi_transfer_one_irq(ctlr, spi,
 							    tfr, cs, false);
 		}
 	}
 
 	/* Transfer complete - reset SPI HW */
-	bcm2835_spi_reset_hw(master);
+	bcm2835_spi_reset_hw(ctlr);
 	/* and return without waiting for completion */
 	return 0;
 }
 
-static int bcm2835_spi_transfer_one(struct spi_master *master,
+static int bcm2835_spi_transfer_one(struct spi_controller *ctlr,
 				    struct spi_device *spi,
 				    struct spi_transfer *tfr)
 {
-	struct bcm2835_spi *bs = spi_master_get_devdata(master);
+	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
 	unsigned long spi_hz, clk_hz, cdiv, spi_used_hz;
 	unsigned long hz_per_byte, byte_limit;
 	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);
@@ -874,34 +874,34 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 
 	/* run in polling mode for short transfers */
 	if (tfr->len < byte_limit)
-		return bcm2835_spi_transfer_one_poll(master, spi, tfr, cs);
+		return bcm2835_spi_transfer_one_poll(ctlr, spi, tfr, cs);
 
 	/* run in dma mode if conditions are right
 	 * Note that unlike poll or interrupt mode DMA mode does not have
 	 * this 1 idle clock cycle pattern but runs the spi clock without gaps
 	 */
-	if (master->can_dma && bcm2835_spi_can_dma(master, spi, tfr))
-		return bcm2835_spi_transfer_one_dma(master, spi, tfr, cs);
+	if (ctlr->can_dma && bcm2835_spi_can_dma(ctlr, spi, tfr))
+		return bcm2835_spi_transfer_one_dma(ctlr, spi, tfr, cs);
 
 	/* run in interrupt-mode */
-	return bcm2835_spi_transfer_one_irq(master, spi, tfr, cs, true);
+	return bcm2835_spi_transfer_one_irq(ctlr, spi, tfr, cs, true);
 }
 
-static int bcm2835_spi_prepare_message(struct spi_master *master,
+static int bcm2835_spi_prepare_message(struct spi_controller *ctlr,
 				       struct spi_message *msg)
 {
 	struct spi_device *spi = msg->spi;
-	struct bcm2835_spi *bs = spi_master_get_devdata(master);
+	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
 	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);
 	int ret;
 
-	if (master->can_dma) {
+	if (ctlr->can_dma) {
 		/*
 		 * DMA transfers are limited to 16 bit (0 to 65535 bytes) by
 		 * the SPI HW due to DLEN. Split up transfers (32-bit FIFO
 		 * aligned) if the limit is exceeded.
 		 */
-		ret = spi_split_transfers_maxsize(master, msg, 65532,
+		ret = spi_split_transfers_maxsize(ctlr, msg, 65532,
 						  GFP_KERNEL | GFP_DMA);
 		if (ret)
 			return ret;
@@ -919,19 +919,19 @@ static int bcm2835_spi_prepare_message(struct spi_master *master,
 	return 0;
 }
 
-static void bcm2835_spi_handle_err(struct spi_master *master,
+static void bcm2835_spi_handle_err(struct spi_controller *ctlr,
 				   struct spi_message *msg)
 {
-	struct bcm2835_spi *bs = spi_master_get_devdata(master);
+	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
 
 	/* if an error occurred and we have an active dma, then terminate */
 	if (cmpxchg(&bs->dma_pending, true, false)) {
-		dmaengine_terminate_sync(master->dma_tx);
-		dmaengine_terminate_sync(master->dma_rx);
+		dmaengine_terminate_sync(ctlr->dma_tx);
+		dmaengine_terminate_sync(ctlr->dma_rx);
 		bcm2835_spi_undo_prologue(bs);
 	}
 	/* and reset */
-	bcm2835_spi_reset_hw(master);
+	bcm2835_spi_reset_hw(ctlr);
 }
 
 static int chip_match_name(struct gpio_chip *chip, void *data)
@@ -988,67 +988,68 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 
 static int bcm2835_spi_probe(struct platform_device *pdev)
 {
-	struct spi_master *master;
+	struct spi_controller *ctlr;
 	struct bcm2835_spi *bs;
 	struct resource *res;
 	int err;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*bs));
-	if (!master)
+	ctlr = spi_alloc_master(&pdev->dev, sizeof(*bs));
+	if (!ctlr)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, ctlr);
 
-	master->mode_bits = BCM2835_SPI_MODE_BITS;
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->num_chipselect = 3;
-	master->setup = bcm2835_spi_setup;
-	master->transfer_one = bcm2835_spi_transfer_one;
-	master->handle_err = bcm2835_spi_handle_err;
-	master->prepare_message = bcm2835_spi_prepare_message;
-	master->dev.of_node = pdev->dev.of_node;
+	ctlr->mode_bits = BCM2835_SPI_MODE_BITS;
+	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
+	ctlr->num_chipselect = 3;
+	ctlr->setup = bcm2835_spi_setup;
+	ctlr->transfer_one = bcm2835_spi_transfer_one;
+	ctlr->handle_err = bcm2835_spi_handle_err;
+	ctlr->prepare_message = bcm2835_spi_prepare_message;
+	ctlr->dev.of_node = pdev->dev.of_node;
 
-	bs = spi_master_get_devdata(master);
+	bs = spi_controller_get_devdata(ctlr);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	bs->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(bs->regs)) {
 		err = PTR_ERR(bs->regs);
-		goto out_master_put;
+		goto out_controller_put;
 	}
 
 	bs->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(bs->clk)) {
 		err = PTR_ERR(bs->clk);
 		dev_err(&pdev->dev, "could not get clk: %d\n", err);
-		goto out_master_put;
+		goto out_controller_put;
 	}
 
 	bs->irq = platform_get_irq(pdev, 0);
 	if (bs->irq <= 0) {
 		dev_err(&pdev->dev, "could not get IRQ: %d\n", bs->irq);
 		err = bs->irq ? bs->irq : -ENODEV;
-		goto out_master_put;
+		goto out_controller_put;
 	}
 
 	clk_prepare_enable(bs->clk);
 
-	bcm2835_dma_init(master, &pdev->dev);
+	bcm2835_dma_init(ctlr, &pdev->dev);
 
 	/* initialise the hardware with the default polarities */
 	bcm2835_wr(bs, BCM2835_SPI_CS,
 		   BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX);
 
 	err = devm_request_irq(&pdev->dev, bs->irq, bcm2835_spi_interrupt, 0,
-			       dev_name(&pdev->dev), master);
+			       dev_name(&pdev->dev), ctlr);
 	if (err) {
 		dev_err(&pdev->dev, "could not request IRQ: %d\n", err);
 		goto out_clk_disable;
 	}
 
-	err = devm_spi_register_master(&pdev->dev, master);
+	err = devm_spi_register_controller(&pdev->dev, ctlr);
 	if (err) {
-		dev_err(&pdev->dev, "could not register SPI master: %d\n", err);
+		dev_err(&pdev->dev, "could not register SPI controller: %d\n",
+			err);
 		goto out_clk_disable;
 	}
 
@@ -1058,15 +1059,15 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 
 out_clk_disable:
 	clk_disable_unprepare(bs->clk);
-out_master_put:
-	spi_master_put(master);
+out_controller_put:
+	spi_controller_put(ctlr);
 	return err;
 }
 
 static int bcm2835_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct bcm2835_spi *bs = spi_master_get_devdata(master);
+	struct spi_controller *ctlr = platform_get_drvdata(pdev);
+	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
 
 	bcm2835_debugfs_remove(bs);
 
@@ -1076,7 +1077,7 @@ static int bcm2835_spi_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(bs->clk);
 
-	bcm2835_dma_release(master);
+	bcm2835_dma_release(ctlr);
 
 	return 0;
 }
-- 
2.20.1

