Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4DDE1892BB
	for <lists+linux-spi@lfdr.de>; Wed, 18 Mar 2020 01:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgCRARP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Mar 2020 20:17:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56311 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbgCRARO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Mar 2020 20:17:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id 6so1303279wmi.5;
        Tue, 17 Mar 2020 17:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6P5WrwP6NjFcOpItmukkhUoQXsuZS/+qjDY/l5RWgYs=;
        b=iM9OE7YWFJe0lfd+LhhyBOspbI54Pb75wlsiHAZWkCO7pAstzGMFDc0LZpZgJft8pC
         xK/OiCFJP5zUOA8PYHBMcnOBUwRxSDbX1rDjX3WEVJ5H6KN39ct5kxIDoulWws9OVgg7
         P1oMSnRA1PVjFzxnTGA7kAtsv2bkmCR+T9mXNZLNWa1nOHQCOfYSgeKE4BLH6P8ZJRgW
         xWuZG+kmtSU3C5bFE0RfsdDxSiU02GipPsNJKheYfyN+p6YaQZPUik34sCRBQLswnNsl
         JDTDCi/H2elf0Z/PoAeAfjaZCz2gqdb83JZeWx5fuEudiVf6LcPjjMxYiYDMFQ77e7H3
         3JEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6P5WrwP6NjFcOpItmukkhUoQXsuZS/+qjDY/l5RWgYs=;
        b=GkA3euANffowsJpyNFpb12NQsIyov/vLlzcRBAJkn2uO8UkJ5RZtbWdbjq3iCswecI
         U8zhwUACo3LRDyGyIPVxVECe0zw1LKTowK7HX5zb9n9DeLEdVF7AdNVoUA6pmN15KVjK
         ex9r7RKasmpGKidJkAPjlGfaVQfdKF3aFA3aJvgD/oc7E7hDVc7VJglVppoYzdaAM3Pa
         JRwOtfdIECXosMncGBmDlumSynSU+l5K8j3uDH+fnjDYW461VLkZgF5cxAcstcf59uqk
         HLDnsRSvhplrT8f1nuPYa3QVHEsd6nmOFeXgxd3VqCL4P53tqy+RBcgCLpu9xt3DgM+m
         pgXw==
X-Gm-Message-State: ANhLgQ3v9bIeRL0Os+4mpoQ/MBvyx2o1XUjA7kn6O3Wb/+qB98Txh5pH
        ZQaHYacARhHiI9beq8pvOMc=
X-Google-Smtp-Source: ADFU+vt0clnLMBfdIRPQwGVCPmvf8lHWKxe429OrL2ZgaCjg7k6GTBrrIl1s80P7xh1bj/5T2s5rww==
X-Received: by 2002:a05:600c:d8:: with SMTP id u24mr1610402wmm.42.1584490630918;
        Tue, 17 Mar 2020 17:17:10 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id i6sm6584600wru.40.2020.03.17.17.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 17:17:10 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v5 03/12] spi: spi-fsl-dspi: Fix bits-per-word acceleration in DMA mode
Date:   Wed, 18 Mar 2020 02:15:54 +0200
Message-Id: <20200318001603.9650-4-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318001603.9650-1-olteanv@gmail.com>
References: <20200318001603.9650-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

In DMA mode, dspi_setup_accel does not get called, which results in the
dspi->oper_word_size variable (which is used by dspi_dma_xfer) to not be
initialized properly.

Because oper_word_size is zero, a few calculations end up being
incorrect, and the DMA transfer eventually times out instead of sending
anything on the wire.

Set up native transfers (or 8-on-16 acceleration) using dspi_setup_accel
for DMA mode too.

Also take the opportunity and simplify the DMA buffer handling a little
bit.

Fixes: 6c1c26ecd9a3 ("spi: spi-fsl-dspi: Accelerate transfers using larger word size if possible")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v5:
None.

Changes in v4:
Rebased on top of "spi: spi-fsl-dspi: fix DMA mapping".
Stopped uselessly writing to SPI_CTAR in dspi_transfer_one_message,
since we already do that in dspi_setup_accel which we now call.
Update message->actual_length before submitting the DMA transfer.

Changes in v3:
Pretty much re-did the patch. Before, dspi_setup_accel was called just
once at the beginning of dspi_dma_xfer. Now it is called in the while
loop. Everything else is just refactoring that follows along.

Changes in v2:
None.

 drivers/spi/spi-fsl-dspi.c | 86 ++++++++++++++------------------------
 1 file changed, 32 insertions(+), 54 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index be717776dd98..8f2b73cc6ed7 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -119,7 +119,6 @@ struct fsl_dspi_devtype_data {
 	enum dspi_trans_mode	trans_mode;
 	u8			max_clock_factor;
 	int			fifo_size;
-	int			dma_bufsize;
 };
 
 enum {
@@ -138,7 +137,6 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 	[VF610] = {
 		.trans_mode		= DSPI_DMA_MODE,
 		.max_clock_factor	= 2,
-		.dma_bufsize		= 4096,
 		.fifo_size		= 4,
 	},
 	[LS1021A] = {
@@ -167,19 +165,16 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 	},
 	[LS2080A] = {
 		.trans_mode		= DSPI_DMA_MODE,
-		.dma_bufsize		= 8,
 		.max_clock_factor	= 8,
 		.fifo_size		= 4,
 	},
 	[LS2085A] = {
 		.trans_mode		= DSPI_DMA_MODE,
-		.dma_bufsize		= 8,
 		.max_clock_factor	= 8,
 		.fifo_size		= 4,
 	},
 	[LX2160A] = {
 		.trans_mode		= DSPI_DMA_MODE,
-		.dma_bufsize		= 8,
 		.max_clock_factor	= 8,
 		.fifo_size		= 4,
 	},
@@ -191,9 +186,6 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 };
 
 struct fsl_dspi_dma {
-	/* Length of transfer in words of dspi->fifo_size */
-	u32					curr_xfer_len;
-
 	u32					*tx_dma_buf;
 	struct dma_chan				*chan_tx;
 	dma_addr_t				tx_dma_phys;
@@ -352,7 +344,7 @@ static void dspi_rx_dma_callback(void *arg)
 	int i;
 
 	if (dspi->rx) {
-		for (i = 0; i < dma->curr_xfer_len; i++)
+		for (i = 0; i < dspi->words_in_flight; i++)
 			dspi_push_rx(dspi, dspi->dma->rx_dma_buf[i]);
 	}
 
@@ -366,12 +358,12 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 	int time_left;
 	int i;
 
-	for (i = 0; i < dma->curr_xfer_len; i++)
+	for (i = 0; i < dspi->words_in_flight; i++)
 		dspi->dma->tx_dma_buf[i] = dspi_pop_tx_pushr(dspi);
 
 	dma->tx_desc = dmaengine_prep_slave_single(dma->chan_tx,
 					dma->tx_dma_phys,
-					dma->curr_xfer_len *
+					dspi->words_in_flight *
 					DMA_SLAVE_BUSWIDTH_4_BYTES,
 					DMA_MEM_TO_DEV,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
@@ -389,7 +381,7 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 
 	dma->rx_desc = dmaengine_prep_slave_single(dma->chan_rx,
 					dma->rx_dma_phys,
-					dma->curr_xfer_len *
+					dspi->words_in_flight *
 					DMA_SLAVE_BUSWIDTH_4_BYTES,
 					DMA_DEV_TO_MEM,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
@@ -437,46 +429,42 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 	return 0;
 }
 
+static void dspi_setup_accel(struct fsl_dspi *dspi);
+
 static int dspi_dma_xfer(struct fsl_dspi *dspi)
 {
 	struct spi_message *message = dspi->cur_msg;
 	struct device *dev = &dspi->pdev->dev;
-	struct fsl_dspi_dma *dma = dspi->dma;
-	int curr_remaining_bytes;
-	int bytes_per_buffer;
 	int ret = 0;
 
-	curr_remaining_bytes = dspi->len;
-	bytes_per_buffer = dspi->devtype_data->dma_bufsize /
-			   dspi->devtype_data->fifo_size;
-	while (curr_remaining_bytes) {
-		/* Check if current transfer fits the DMA buffer */
-		dma->curr_xfer_len = curr_remaining_bytes /
-				     dspi->oper_word_size;
-		if (dma->curr_xfer_len > bytes_per_buffer)
-			dma->curr_xfer_len = bytes_per_buffer;
+	/*
+	 * dspi->len gets decremented by dspi_pop_tx_pushr in
+	 * dspi_next_xfer_dma_submit
+	 */
+	while (dspi->len) {
+		/* Figure out operational bits-per-word for this chunk */
+		dspi_setup_accel(dspi);
+
+		dspi->words_in_flight = dspi->len / dspi->oper_word_size;
+		if (dspi->words_in_flight > dspi->devtype_data->fifo_size)
+			dspi->words_in_flight = dspi->devtype_data->fifo_size;
+
+		message->actual_length += dspi->words_in_flight *
+					  dspi->oper_word_size;
 
 		ret = dspi_next_xfer_dma_submit(dspi);
 		if (ret) {
 			dev_err(dev, "DMA transfer failed\n");
-			goto exit;
-
-		} else {
-			const int len = dma->curr_xfer_len *
-					dspi->oper_word_size;
-			curr_remaining_bytes -= len;
-			message->actual_length += len;
-			if (curr_remaining_bytes < 0)
-				curr_remaining_bytes = 0;
+			break;
 		}
 	}
 
-exit:
 	return ret;
 }
 
 static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 {
+	int dma_bufsize = dspi->devtype_data->fifo_size * 2;
 	struct device *dev = &dspi->pdev->dev;
 	struct dma_slave_config cfg;
 	struct fsl_dspi_dma *dma;
@@ -501,16 +489,16 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 	}
 
 	dma->tx_dma_buf = dma_alloc_coherent(dma->chan_tx->device->dev,
-					     dspi->devtype_data->dma_bufsize,
-					     &dma->tx_dma_phys, GFP_KERNEL);
+					     dma_bufsize, &dma->tx_dma_phys,
+					     GFP_KERNEL);
 	if (!dma->tx_dma_buf) {
 		ret = -ENOMEM;
 		goto err_tx_dma_buf;
 	}
 
 	dma->rx_dma_buf = dma_alloc_coherent(dma->chan_rx->device->dev,
-					     dspi->devtype_data->dma_bufsize,
-					     &dma->rx_dma_phys, GFP_KERNEL);
+					     dma_bufsize, &dma->rx_dma_phys,
+					     GFP_KERNEL);
 	if (!dma->rx_dma_buf) {
 		ret = -ENOMEM;
 		goto err_rx_dma_buf;
@@ -547,12 +535,10 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 
 err_slave_config:
 	dma_free_coherent(dma->chan_rx->device->dev,
-			  dspi->devtype_data->dma_bufsize,
-			  dma->rx_dma_buf, dma->rx_dma_phys);
+			  dma_bufsize, dma->rx_dma_buf, dma->rx_dma_phys);
 err_rx_dma_buf:
 	dma_free_coherent(dma->chan_tx->device->dev,
-			  dspi->devtype_data->dma_bufsize,
-			  dma->tx_dma_buf, dma->tx_dma_phys);
+			  dma_bufsize, dma->tx_dma_buf, dma->tx_dma_phys);
 err_tx_dma_buf:
 	dma_release_channel(dma->chan_tx);
 err_tx_channel:
@@ -566,6 +552,7 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 
 static void dspi_release_dma(struct fsl_dspi *dspi)
 {
+	int dma_bufsize = dspi->devtype_data->fifo_size * 2;
 	struct fsl_dspi_dma *dma = dspi->dma;
 
 	if (!dma)
@@ -573,15 +560,13 @@ static void dspi_release_dma(struct fsl_dspi *dspi)
 
 	if (dma->chan_tx) {
 		dma_unmap_single(dma->chan_tx->device->dev, dma->tx_dma_phys,
-				 dspi->devtype_data->dma_bufsize,
-				 DMA_TO_DEVICE);
+				 dma_bufsize, DMA_TO_DEVICE);
 		dma_release_channel(dma->chan_tx);
 	}
 
 	if (dma->chan_rx) {
 		dma_unmap_single(dma->chan_rx->device->dev, dma->rx_dma_phys,
-				 dspi->devtype_data->dma_bufsize,
-				 DMA_FROM_DEVICE);
+				 dma_bufsize, DMA_FROM_DEVICE);
 		dma_release_channel(dma->chan_rx);
 	}
 }
@@ -833,7 +818,7 @@ static void dspi_setup_accel(struct fsl_dspi *dspi)
 	dspi->oper_word_size = DIV_ROUND_UP(dspi->oper_bits_per_word, 8);
 
 	/*
-	 * Update CTAR here (code is common for both EOQ and XSPI modes).
+	 * Update CTAR here (code is common for EOQ, XSPI and DMA modes).
 	 * We will update CTARE in the portion specific to XSPI, when we
 	 * also know the preload value (DTCP).
 	 */
@@ -960,13 +945,6 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 		regmap_update_bits(dspi->regmap, SPI_MCR,
 				   SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF,
 				   SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF);
-		/*
-		 * Static CTAR setup for modes that don't dynamically adjust it
-		 * via dspi_setup_accel (aka for DMA)
-		 */
-		regmap_write(dspi->regmap, SPI_CTAR(0),
-			     dspi->cur_chip->ctar_val |
-			     SPI_FRAME_BITS(transfer->bits_per_word));
 
 		spi_take_timestamp_pre(dspi->ctlr, dspi->cur_transfer,
 				       dspi->progress, !dspi->irq);
-- 
2.17.1

