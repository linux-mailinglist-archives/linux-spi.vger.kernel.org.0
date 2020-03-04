Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29A781797E7
	for <lists+linux-spi@lfdr.de>; Wed,  4 Mar 2020 19:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbgCDS3a (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Mar 2020 13:29:30 -0500
Received: from foss.arm.com ([217.140.110.172]:38316 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730205AbgCDS3a (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 4 Mar 2020 13:29:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFCFB31B;
        Wed,  4 Mar 2020 10:29:29 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40C593F6C4;
        Wed,  4 Mar 2020 10:29:29 -0800 (PST)
Date:   Wed, 04 Mar 2020 18:29:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-dspi: Parameterize the FIFO size and DMA buffer size" to the spi tree
In-Reply-To:  <20200302001958.11105-4-olteanv@gmail.com>
Message-Id:  <applied-20200302001958.11105-4-olteanv@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-fsl-dspi: Parameterize the FIFO size and DMA buffer size

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

From 1d8b4c95c37ccccfc18adef7a13b79fbc3e1557e Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 2 Mar 2020 02:19:55 +0200
Subject: [PATCH] spi: spi-fsl-dspi: Parameterize the FIFO size and DMA buffer
 size

Get rid of the ifdef for Coldfire and make these hardware
characteristics part of dspi->devtype_data.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Message-Id: <20200302001958.11105-4-olteanv@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 48 ++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 021c658886d4..55ccb3d0f683 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -20,13 +20,6 @@
 
 #define DRIVER_NAME			"fsl-dspi"
 
-#ifdef CONFIG_M5441x
-#define DSPI_FIFO_SIZE			16
-#else
-#define DSPI_FIFO_SIZE			4
-#endif
-#define DSPI_DMA_BUFSIZE		(DSPI_FIFO_SIZE * 1024)
-
 #define SPI_MCR				0x00
 #define SPI_MCR_MASTER			BIT(31)
 #define SPI_MCR_PCSIS			(0x3F << 16)
@@ -131,6 +124,8 @@ struct fsl_dspi_devtype_data {
 	u8			max_clock_factor;
 	bool			ptp_sts_supported;
 	bool			xspi_mode;
+	int			fifo_size;
+	int			dma_bufsize;
 };
 
 enum {
@@ -149,54 +144,64 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 	[VF610] = {
 		.trans_mode		= DSPI_DMA_MODE,
 		.max_clock_factor	= 2,
+		.dma_bufsize		= 4096,
+		.fifo_size		= 4,
 	},
 	[LS1021A] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
 		.ptp_sts_supported	= true,
 		.xspi_mode		= true,
+		.fifo_size		= 4,
 	},
 	[LS1012A] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
 		.ptp_sts_supported	= true,
 		.xspi_mode		= true,
+		.fifo_size		= 16,
 	},
 	[LS1043A] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
 		.ptp_sts_supported	= true,
 		.xspi_mode		= true,
+		.fifo_size		= 16,
 	},
 	[LS1046A] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
 		.ptp_sts_supported	= true,
 		.xspi_mode		= true,
+		.fifo_size		= 16,
 	},
 	[LS2080A] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
 		.ptp_sts_supported	= true,
+		.fifo_size		= 4,
 	},
 	[LS2085A] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
 		.ptp_sts_supported	= true,
+		.fifo_size		= 4,
 	},
 	[LX2160A] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
 		.ptp_sts_supported	= true,
+		.fifo_size		= 4,
 	},
 	[MCF5441X] = {
 		.trans_mode		= DSPI_EOQ_MODE,
 		.max_clock_factor	= 8,
+		.fifo_size		= 16,
 	},
 };
 
 struct fsl_dspi_dma {
-	/* Length of transfer in words of DSPI_FIFO_SIZE */
+	/* Length of transfer in words of dspi->fifo_size */
 	u32					curr_xfer_len;
 
 	u32					*tx_dma_buf;
@@ -397,7 +402,8 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
 	int ret = 0;
 
 	curr_remaining_bytes = dspi->len;
-	bytes_per_buffer = DSPI_DMA_BUFSIZE / DSPI_FIFO_SIZE;
+	bytes_per_buffer = dspi->devtype_data->dma_bufsize /
+			   dspi->devtype_data->fifo_size;
 	while (curr_remaining_bytes) {
 		/* Check if current transfer fits the DMA buffer */
 		dma->curr_xfer_len = curr_remaining_bytes
@@ -449,14 +455,14 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 		goto err_tx_channel;
 	}
 
-	dma->tx_dma_buf = dma_alloc_coherent(dev, DSPI_DMA_BUFSIZE,
+	dma->tx_dma_buf = dma_alloc_coherent(dev, dspi->devtype_data->dma_bufsize,
 					     &dma->tx_dma_phys, GFP_KERNEL);
 	if (!dma->tx_dma_buf) {
 		ret = -ENOMEM;
 		goto err_tx_dma_buf;
 	}
 
-	dma->rx_dma_buf = dma_alloc_coherent(dev, DSPI_DMA_BUFSIZE,
+	dma->rx_dma_buf = dma_alloc_coherent(dev, dspi->devtype_data->dma_bufsize,
 					     &dma->rx_dma_phys, GFP_KERNEL);
 	if (!dma->rx_dma_buf) {
 		ret = -ENOMEM;
@@ -493,11 +499,11 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 	return 0;
 
 err_slave_config:
-	dma_free_coherent(dev, DSPI_DMA_BUFSIZE,
-			dma->rx_dma_buf, dma->rx_dma_phys);
+	dma_free_coherent(dev, dspi->devtype_data->dma_bufsize,
+			  dma->rx_dma_buf, dma->rx_dma_phys);
 err_rx_dma_buf:
-	dma_free_coherent(dev, DSPI_DMA_BUFSIZE,
-			dma->tx_dma_buf, dma->tx_dma_phys);
+	dma_free_coherent(dev, dspi->devtype_data->dma_bufsize,
+			  dma->tx_dma_buf, dma->tx_dma_phys);
 err_tx_dma_buf:
 	dma_release_channel(dma->chan_tx);
 err_tx_channel:
@@ -519,13 +525,15 @@ static void dspi_release_dma(struct fsl_dspi *dspi)
 
 	if (dma->chan_tx) {
 		dma_unmap_single(dev, dma->tx_dma_phys,
-				 DSPI_DMA_BUFSIZE, DMA_TO_DEVICE);
+				 dspi->devtype_data->dma_bufsize,
+				 DMA_TO_DEVICE);
 		dma_release_channel(dma->chan_tx);
 	}
 
 	if (dma->chan_rx) {
 		dma_unmap_single(dev, dma->rx_dma_phys,
-				 DSPI_DMA_BUFSIZE, DMA_FROM_DEVICE);
+				 dspi->devtype_data->dma_bufsize,
+				 DMA_FROM_DEVICE);
 		dma_release_channel(dma->chan_rx);
 	}
 }
@@ -657,7 +665,7 @@ static void dspi_tcfq_read(struct fsl_dspi *dspi)
 
 static void dspi_eoq_write(struct fsl_dspi *dspi)
 {
-	int fifo_size = DSPI_FIFO_SIZE;
+	int fifo_size = dspi->devtype_data->fifo_size;
 	u16 xfer_cmd = dspi->tx_cmd;
 
 	/* Fill TX FIFO with as many transfers as possible */
@@ -667,7 +675,7 @@ static void dspi_eoq_write(struct fsl_dspi *dspi)
 		if (dspi->len == dspi->bytes_per_word || fifo_size == 0)
 			dspi->tx_cmd |= SPI_PUSHR_CMD_EOQ;
 		/* Clear transfer count for first transfer in FIFO */
-		if (fifo_size == (DSPI_FIFO_SIZE - 1))
+		if (fifo_size == (dspi->devtype_data->fifo_size - 1))
 			dspi->tx_cmd |= SPI_PUSHR_CMD_CTCNT;
 		/* Write combined TX FIFO and CMD FIFO entry */
 		fifo_write(dspi);
@@ -676,7 +684,7 @@ static void dspi_eoq_write(struct fsl_dspi *dspi)
 
 static void dspi_eoq_read(struct fsl_dspi *dspi)
 {
-	int fifo_size = DSPI_FIFO_SIZE;
+	int fifo_size = dspi->devtype_data->fifo_size;
 
 	/* Read one FIFO entry and push to rx buffer */
 	while ((dspi->rx < dspi->rx_end) && fifo_size--)
-- 
2.20.1

