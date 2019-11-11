Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA68F8077
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2019 20:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfKKTtO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Nov 2019 14:49:14 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50494 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfKKTtO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Nov 2019 14:49:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=PIfTM93qdGG19Mu2hY3L9jGo+XJ6ctbU8MTvg5JJabA=; b=YNZ0QM5WZ3nE
        gYVeW8LjVF7v/7SkxCM8qkXiDbbcNoncMPnGMPRnawQE8x5oMUsQSMy3inQSJYsBwpRhtkpZHaCVO
        nxciVGlEip+vzuZGMmEGlIk4NhxTSU+7mNvO8c2LGNzFG5RowpuaBP0jLgpbb2JIobmUXM6oWzE1X
        HS/eE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iUFgT-0005Ni-Lu; Mon, 11 Nov 2019 19:49:09 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 20B342742C95; Mon, 11 Nov 2019 19:49:09 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: omap2-mcspi: Remove redundant checks" to the spi tree
In-Reply-To: <20191109041827.26934-1-vigneshr@ti.com>
X-Patchwork-Hint: ignore
Message-Id: <20191111194909.20B342742C95@ypsilon.sirena.org.uk>
Date:   Mon, 11 Nov 2019 19:49:09 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: omap2-mcspi: Remove redundant checks

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

From 8d8584912a4348ca41653dca70f2099a82e644d9 Mon Sep 17 00:00:00 2001
From: Vignesh Raghavendra <vigneshr@ti.com>
Date: Sat, 9 Nov 2019 09:48:27 +0530
Subject: [PATCH] spi: omap2-mcspi: Remove redundant checks

Both omap2_mcspi_tx_dma() and omap2_mcspi_rx_dma() are only called from
omap2_mcspi_txrx_dma() and omap2_mcspi_txrx_dma() is always called after
making sure that mcspi_dma->dma_rx and mcspi_dma->dma_tx are not NULL
(see omap2_mcspi_transfer_one()).
Therefore remove redundant NULL checks for omap2_mcspi->dma_tx and
omap2_mcspi->dma_rx pointers in omap2_mcspi_tx_dma() and
omap2_mcspi_rx_dma() respectively.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Link: https://lore.kernel.org/r/20191109041827.26934-1-vigneshr@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-omap2-mcspi.c | 105 +++++++++++++++-------------------
 1 file changed, 47 insertions(+), 58 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 848e03e5f42d..7e2292c11d12 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -397,30 +397,26 @@ static void omap2_mcspi_tx_dma(struct spi_device *spi,
 {
 	struct omap2_mcspi	*mcspi;
 	struct omap2_mcspi_dma  *mcspi_dma;
+	struct dma_async_tx_descriptor *tx;
 
 	mcspi = spi_master_get_devdata(spi->master);
 	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
 
-	if (mcspi_dma->dma_tx) {
-		struct dma_async_tx_descriptor *tx;
+	dmaengine_slave_config(mcspi_dma->dma_tx, &cfg);
 
-		dmaengine_slave_config(mcspi_dma->dma_tx, &cfg);
-
-		tx = dmaengine_prep_slave_sg(mcspi_dma->dma_tx, xfer->tx_sg.sgl,
-					     xfer->tx_sg.nents,
-					     DMA_MEM_TO_DEV,
-					     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-		if (tx) {
-			tx->callback = omap2_mcspi_tx_callback;
-			tx->callback_param = spi;
-			dmaengine_submit(tx);
-		} else {
-			/* FIXME: fall back to PIO? */
-		}
+	tx = dmaengine_prep_slave_sg(mcspi_dma->dma_tx, xfer->tx_sg.sgl,
+				     xfer->tx_sg.nents,
+				     DMA_MEM_TO_DEV,
+				     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (tx) {
+		tx->callback = omap2_mcspi_tx_callback;
+		tx->callback_param = spi;
+		dmaengine_submit(tx);
+	} else {
+		/* FIXME: fall back to PIO? */
 	}
 	dma_async_issue_pending(mcspi_dma->dma_tx);
 	omap2_mcspi_set_dma_req(spi, 0, 1);
-
 }
 
 static unsigned
@@ -439,6 +435,7 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 	int			word_len, element_count;
 	struct omap2_mcspi_cs	*cs = spi->controller_state;
 	void __iomem		*chstat_reg = cs->base + OMAP2_MCSPI_CHSTAT0;
+	struct dma_async_tx_descriptor *tx;
 
 	mcspi = spi_master_get_devdata(spi->master);
 	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
@@ -462,55 +459,47 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 	else /* word_len <= 32 */
 		element_count = count >> 2;
 
-	if (mcspi_dma->dma_rx) {
-		struct dma_async_tx_descriptor *tx;
 
-		dmaengine_slave_config(mcspi_dma->dma_rx, &cfg);
+	dmaengine_slave_config(mcspi_dma->dma_rx, &cfg);
 
+	/*
+	 *  Reduce DMA transfer length by one more if McSPI is
+	 *  configured in turbo mode.
+	 */
+	if ((l & OMAP2_MCSPI_CHCONF_TURBO) && mcspi->fifo_depth == 0)
+		transfer_reduction += es;
+
+	if (transfer_reduction) {
+		/* Split sgl into two. The second sgl won't be used. */
+		sizes[0] = count - transfer_reduction;
+		sizes[1] = transfer_reduction;
+		nb_sizes = 2;
+	} else {
 		/*
-		 *  Reduce DMA transfer length by one more if McSPI is
-		 *  configured in turbo mode.
+		 * Don't bother splitting the sgl. This essentially
+		 * clones the original sgl.
 		 */
-		if ((l & OMAP2_MCSPI_CHCONF_TURBO) && mcspi->fifo_depth == 0)
-			transfer_reduction += es;
-
-		if (transfer_reduction) {
-			/* Split sgl into two. The second sgl won't be used. */
-			sizes[0] = count - transfer_reduction;
-			sizes[1] = transfer_reduction;
-			nb_sizes = 2;
-		} else {
-			/*
-			 * Don't bother splitting the sgl. This essentially
-			 * clones the original sgl.
-			 */
-			sizes[0] = count;
-			nb_sizes = 1;
-		}
+		sizes[0] = count;
+		nb_sizes = 1;
+	}
 
-		ret = sg_split(xfer->rx_sg.sgl, xfer->rx_sg.nents,
-			       0, nb_sizes,
-			       sizes,
-			       sg_out, out_mapped_nents,
-			       GFP_KERNEL);
+	ret = sg_split(xfer->rx_sg.sgl, xfer->rx_sg.nents, 0, nb_sizes,
+		       sizes, sg_out, out_mapped_nents, GFP_KERNEL);
 
-		if (ret < 0) {
-			dev_err(&spi->dev, "sg_split failed\n");
-			return 0;
-		}
+	if (ret < 0) {
+		dev_err(&spi->dev, "sg_split failed\n");
+		return 0;
+	}
 
-		tx = dmaengine_prep_slave_sg(mcspi_dma->dma_rx,
-					     sg_out[0],
-					     out_mapped_nents[0],
-					     DMA_DEV_TO_MEM,
-					     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-		if (tx) {
-			tx->callback = omap2_mcspi_rx_callback;
-			tx->callback_param = spi;
-			dmaengine_submit(tx);
-		} else {
-				/* FIXME: fall back to PIO? */
-		}
+	tx = dmaengine_prep_slave_sg(mcspi_dma->dma_rx, sg_out[0],
+				     out_mapped_nents[0], DMA_DEV_TO_MEM,
+				     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (tx) {
+		tx->callback = omap2_mcspi_rx_callback;
+		tx->callback_param = spi;
+		dmaengine_submit(tx);
+	} else {
+		/* FIXME: fall back to PIO? */
 	}
 
 	dma_async_issue_pending(mcspi_dma->dma_rx);
-- 
2.20.1

