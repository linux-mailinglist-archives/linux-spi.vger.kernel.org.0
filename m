Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D69A179B71
	for <lists+linux-spi@lfdr.de>; Wed,  4 Mar 2020 23:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388577AbgCDWCT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Mar 2020 17:02:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45848 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388520AbgCDWCG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Mar 2020 17:02:06 -0500
Received: by mail-wr1-f68.google.com with SMTP id v2so4422776wrp.12;
        Wed, 04 Mar 2020 14:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=306WVbrVGislQuIO5tDGMRoWCaVV0h0M0rRGCco/88Y=;
        b=aLYXLLt2K5tXQU74fJLuzWXy0VA7H8TL57UAsFdehmK7Y/OR9w7KMnJJscXFlVGqlW
         iFdmOXRDDa2ID9ZFGZgpL6daaGPti7RNnPy51J/H1bfL0h+RW4a7LeyGzp58XFHr9sUA
         Qy46LBNC1POFCfRmvoN1bSd5UyoCl5CiD2Ts2ujWWmhpTLkHxd85h58PQtNjHVRfAxE7
         Dqqv3sRFFzONgITFpAx319GPMzQKABR4cTWg/9/zhDUzYbnXDUjZCNTCqqjgOjSF2ccL
         5F/TZfyedo5yIAfl6vtIaeAm8i7iJBZ6dtijix1qlp4vz41uJmxolLKPuoARuLgEb1hx
         MmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=306WVbrVGislQuIO5tDGMRoWCaVV0h0M0rRGCco/88Y=;
        b=Im277r3LFEi89YpAIM9sh4v6GKN+uAcp2R/pSHfs4YP1+sIymfs3VpwTbWoRJ9pqh4
         y89WxlQBMKVl73XyFiXY+Tcswjt4UYvRkTDy/IppBZM3LQI6GC377zQmNNnIVfdB5BTn
         lPuq03ahWHsyUWlYNnp36OF+YjBszIkcn22hy1k4KQYVidyo0q/5V1DRi0SWiNHMVJQW
         p+3PVxC/l3vbxyA2wNjkJmfL09k0kvqLN5kFN8jcimgy/sX/T8gHjZ5bWHEzJH2ddHJc
         H/+EBnVcP8SpW/CI9A+oofeWOgdib5LlSsBm99TIyOV3MJh+jpF00UA97P54/9DqEadI
         K4Ew==
X-Gm-Message-State: ANhLgQ0ETTIOMK+TFJ51txPaIy46h8BmbGw4gKG/ftP4xWR0Mq7/E25y
        UNC9WPxgua/zpVwvR9OUK6M=
X-Google-Smtp-Source: ADFU+vu4hBAtzGbuO0bhfMqBO+qOx5p+Bh4imt6hsFaC0bgq+vt00CEQO+zh27GNd/qYl8BLpythnA==
X-Received: by 2002:a5d:61cb:: with SMTP id q11mr5969208wrv.256.1583359324749;
        Wed, 04 Mar 2020 14:02:04 -0800 (PST)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id z2sm36776402wrq.95.2020.03.04.14.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 14:02:04 -0800 (PST)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        eha@deif.com, angelo@sysam.it, andrew.smirnov@gmail.com,
        gustavo@embeddedor.com, weic@nvidia.com, mhosny@nvidia.com
Subject: [PATCH 09/12] spi: spi-fsl-dspi: Accelerate transfers using larger word size if possible
Date:   Thu,  5 Mar 2020 00:00:41 +0200
Message-Id: <20200304220044.11193-10-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304220044.11193-1-olteanv@gmail.com>
References: <20200304220044.11193-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

This patch adds logic in the driver to transmit SPI buffers that use
bits_per_word=8 with a higher bits_per_word count (multiple of 8).

Currently the following (most common) modes are implemented:
 - 8 bits_per_word on 32-bit capable controllers
 - 8 bits_per_word on 16-bit capable controllers
 - 16 bits_per_word on 32-bit capable controllers

Transfers which are not accelerated are transferred with a hardware
bits_per_word value equal to the one of the SPI transfer.

The difference from just extending bits_per_word=32 at the spi_device
driver level is that endianness is different - the SPI core wants to
treat bits_per_word=32 buffers as arrays of u32 (i.e. words in host CPU
endianness). So to preserve endianness when clumping 8x4 bits into
32-bit words, one must perform conversion between CPU and standard (big)
endianness.

All appearances (both on the wire as well as in the buffers presented to
the peripheral driver) are preserved, just that accesses to the PUSHR
and POPR registers are now more efficient, since the same number of
reads/writes can now carry more data (2x more data on TX, 4x more data
on RX).

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 160 +++++++++++++++++++++++++++++++------
 1 file changed, 135 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 298c22def165..f5b802070d29 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -228,8 +228,6 @@ struct fsl_dspi {
 	const void				*tx;
 	void					*rx;
 	u16					tx_cmd;
-	u8					bits_per_word;
-	u8					bytes_per_word;
 	const struct fsl_dspi_devtype_data	*devtype_data;
 
 	wait_queue_head_t			waitq;
@@ -237,9 +235,70 @@ struct fsl_dspi {
 
 	struct fsl_dspi_dma			*dma;
 
+	int					oper_word_size;
+	int					oper_bits_per_word;
+
 	int					words_in_flight;
+
+	void (*host_to_dev)(struct fsl_dspi *dspi, u32 *txdata);
+	void (*dev_to_host)(struct fsl_dspi *dspi, u32 rxdata);
 };
 
+static void dspi_native_host_to_dev(struct fsl_dspi *dspi, u32 *txdata)
+{
+	memcpy(txdata, dspi->tx, dspi->oper_word_size);
+	dspi->tx += dspi->oper_word_size;
+}
+
+static void dspi_native_dev_to_host(struct fsl_dspi *dspi, u32 rxdata)
+{
+	memcpy(dspi->rx, &rxdata, dspi->oper_word_size);
+	dspi->rx += dspi->oper_word_size;
+}
+
+static void dspi_8on32_host_to_dev(struct fsl_dspi *dspi, u32 *txdata)
+{
+	*txdata = cpu_to_be32(*(u32 *)dspi->tx);
+	dspi->tx += sizeof(u32);
+}
+
+static void dspi_8on32_dev_to_host(struct fsl_dspi *dspi, u32 rxdata)
+{
+	*(u32 *)dspi->rx = be32_to_cpu(rxdata);
+	dspi->rx += sizeof(u32);
+}
+
+static void dspi_8on16_host_to_dev(struct fsl_dspi *dspi, u32 *txdata)
+{
+	*txdata = cpu_to_be16(*(u16 *)dspi->tx);
+	dspi->tx += sizeof(u16);
+}
+
+static void dspi_8on16_dev_to_host(struct fsl_dspi *dspi, u32 rxdata)
+{
+	*(u16 *)dspi->rx = be16_to_cpu(rxdata);
+	dspi->rx += sizeof(u16);
+}
+
+static void dspi_16on32_host_to_dev(struct fsl_dspi *dspi, u32 *txdata)
+{
+	u16 hi = *(u16 *)dspi->tx;
+	u16 lo = *(u16 *)(dspi->tx + 2);
+
+	*txdata = (u32)hi << 16 | lo;
+	dspi->tx += sizeof(u32);
+}
+
+static void dspi_16on32_dev_to_host(struct fsl_dspi *dspi, u32 rxdata)
+{
+	u16 hi = rxdata & 0xffff;
+	u16 lo = rxdata >> 16;
+
+	*(u16 *)dspi->rx = lo;
+	*(u16 *)(dspi->rx + 2) = hi;
+	dspi->rx += sizeof(u32);
+}
+
 /*
  * Pop one word from the TX buffer for pushing into the
  * PUSHR register (TX FIFO)
@@ -248,11 +307,9 @@ static u32 dspi_pop_tx(struct fsl_dspi *dspi)
 {
 	u32 txdata = 0;
 
-	if (dspi->tx) {
-		memcpy(&txdata, dspi->tx, dspi->bytes_per_word);
-		dspi->tx += dspi->bytes_per_word;
-	}
-	dspi->len -= dspi->bytes_per_word;
+	if (dspi->tx)
+		dspi->host_to_dev(dspi, &txdata);
+	dspi->len -= dspi->oper_word_size;
 	return txdata;
 }
 
@@ -274,9 +331,7 @@ static void dspi_push_rx(struct fsl_dspi *dspi, u32 rxdata)
 {
 	if (!dspi->rx)
 		return;
-
-	memcpy(dspi->rx, &rxdata, dspi->bytes_per_word);
-	dspi->rx += dspi->bytes_per_word;
+	dspi->dev_to_host(dspi, rxdata);
 }
 
 static void dspi_tx_dma_callback(void *arg)
@@ -393,8 +448,8 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
 			   dspi->devtype_data->fifo_size;
 	while (curr_remaining_bytes) {
 		/* Check if current transfer fits the DMA buffer */
-		dma->curr_xfer_len = curr_remaining_bytes
-			/ dspi->bytes_per_word;
+		dma->curr_xfer_len = curr_remaining_bytes /
+				     dspi->oper_word_size;
 		if (dma->curr_xfer_len > bytes_per_buffer)
 			dma->curr_xfer_len = bytes_per_buffer;
 
@@ -404,8 +459,8 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
 			goto exit;
 
 		} else {
-			const int len =
-				dma->curr_xfer_len * dspi->bytes_per_word;
+			const int len = dma->curr_xfer_len *
+					dspi->oper_word_size;
 			curr_remaining_bytes -= len;
 			message->actual_length += len;
 			if (curr_remaining_bytes < 0)
@@ -615,7 +670,7 @@ static void dspi_pushr_cmd_write(struct fsl_dspi *dspi)
 	 * generate a new PUSHR command with the final word that will have PCS
 	 * deasserted (not continued) here.
 	 */
-	if (dspi->len > dspi->bytes_per_word)
+	if (dspi->len > dspi->oper_word_size)
 		cmd |= SPI_PUSHR_CMD_CONT;
 	regmap_write(dspi->regmap_pushr, PUSHR_CMD, cmd);
 }
@@ -627,8 +682,9 @@ static void dspi_pushr_txdata_write(struct fsl_dspi *dspi, u16 txdata)
 
 static void dspi_xspi_write(struct fsl_dspi *dspi, int cnt)
 {
+	/* Update CTARE */
 	regmap_write(dspi->regmap, SPI_CTARE(0),
-		     SPI_FRAME_EBITS(dspi->bits_per_word) |
+		     SPI_FRAME_EBITS(dspi->oper_bits_per_word) |
 		     SPI_CTARE_DTCP(cnt));
 
 	/*
@@ -642,7 +698,7 @@ static void dspi_xspi_write(struct fsl_dspi *dspi, int cnt)
 		u32 data = dspi_pop_tx(dspi);
 
 		dspi_pushr_txdata_write(dspi, data & 0xFFFF);
-		if (dspi->bits_per_word > 16)
+		if (dspi->oper_bits_per_word > 16)
 			dspi_pushr_txdata_write(dspi, data >> 16);
 	}
 }
@@ -653,15 +709,20 @@ static void dspi_xspi_fifo_write(struct fsl_dspi *dspi)
 	int bytes_in_flight;
 
 	/* In XSPI mode each 32-bit word occupies 2 TX FIFO entries */
-	if (dspi->bits_per_word > 16)
+	if (dspi->oper_word_size == 4)
 		num_fifo_entries /= 2;
 
-	dspi->words_in_flight = dspi->len / dspi->bytes_per_word;
+	/*
+	 * Integer division intentionally trims off odd (or non-multiple of 4)
+	 * numbers of bytes at the end of the buffer, which will be sent next
+	 * time using a smaller oper_word_size.
+	 */
+	dspi->words_in_flight = dspi->len / dspi->oper_word_size;
 
 	if (dspi->words_in_flight > num_fifo_entries)
 		dspi->words_in_flight = num_fifo_entries;
 
-	bytes_in_flight = dspi->words_in_flight * dspi->bytes_per_word;
+	bytes_in_flight = dspi->words_in_flight * dspi->oper_word_size;
 
 	/*
 	 * If the PCS needs to de-assert (i.e. we're at the end of the buffer
@@ -689,7 +750,7 @@ static void dspi_eoq_fifo_write(struct fsl_dspi *dspi)
 	while (dspi->len && num_fifo_entries--) {
 		dspi->tx_cmd = xfer_cmd;
 		/* Request EOQF for last transfer in FIFO */
-		if (dspi->len == dspi->bytes_per_word || num_fifo_entries == 0)
+		if (dspi->len == dspi->oper_word_size || num_fifo_entries == 0)
 			dspi->tx_cmd |= SPI_PUSHR_CMD_EOQ;
 		/* Write combined TX FIFO and CMD FIFO entry */
 		dspi_pushr_write(dspi);
@@ -711,8 +772,56 @@ static void dspi_fifo_read(struct fsl_dspi *dspi)
 		dspi_push_rx(dspi, dspi_popr_read(dspi));
 }
 
+static void dspi_setup_accel(struct fsl_dspi *dspi)
+{
+	struct spi_transfer *xfer = dspi->cur_transfer;
+
+	/* Start off with maximum supported by hardware */
+	if (dspi->devtype_data->trans_mode == DSPI_XSPI_MODE)
+		dspi->oper_bits_per_word = 32;
+	else
+		dspi->oper_bits_per_word = 16;
+
+	/* And go down only if the buffer can't be sent with words this big */
+	do {
+		if (dspi->len >= DIV_ROUND_UP(dspi->oper_bits_per_word, 8))
+			break;
+
+		dspi->oper_bits_per_word /= 2;
+	} while (dspi->oper_bits_per_word > 8);
+
+	if (xfer->bits_per_word == 8 && dspi->oper_bits_per_word == 32) {
+		dspi->dev_to_host = dspi_8on32_dev_to_host;
+		dspi->host_to_dev = dspi_8on32_host_to_dev;
+	} else if (xfer->bits_per_word == 8 && dspi->oper_bits_per_word == 16) {
+		dspi->dev_to_host = dspi_8on16_dev_to_host;
+		dspi->host_to_dev = dspi_8on16_host_to_dev;
+	} else if (xfer->bits_per_word == 16 && dspi->oper_bits_per_word == 32) {
+		dspi->dev_to_host = dspi_16on32_dev_to_host;
+		dspi->host_to_dev = dspi_16on32_host_to_dev;
+	} else {
+		/* No acceleration needed (8<N<=16 on 16, 16<N<=32 on 32) */
+		dspi->dev_to_host = dspi_native_dev_to_host;
+		dspi->host_to_dev = dspi_native_host_to_dev;
+		dspi->oper_bits_per_word = xfer->bits_per_word;
+	}
+
+	dspi->oper_word_size = DIV_ROUND_UP(dspi->oper_bits_per_word, 8);
+
+	/*
+	 * Update CTAR here (code is common for both EOQ and XSPI modes).
+	 * We will update CTARE in the portion specific to XSPI, when we
+	 * also know the preload value (DTCP).
+	 */
+	regmap_write(dspi->regmap, SPI_CTAR(0),
+		     dspi->cur_chip->ctar_val |
+		     SPI_FRAME_BITS(dspi->oper_bits_per_word));
+}
+
 static void dspi_fifo_write(struct fsl_dspi *dspi)
 {
+	dspi_setup_accel(dspi);
+
 	if (dspi->devtype_data->trans_mode == DSPI_EOQ_MODE)
 		dspi_eoq_fifo_write(dspi);
 	else
@@ -726,7 +835,7 @@ static int dspi_rxtx(struct fsl_dspi *dspi)
 	int bytes_sent;
 
 	/* Update total number of bytes that were transferred */
-	bytes_sent = dspi->words_in_flight * dspi->bytes_per_word;
+	bytes_sent = dspi->words_in_flight * dspi->oper_word_size;
 	msg->actual_length += bytes_sent;
 	dspi->progress += bytes_sent / DIV_ROUND_UP(xfer->bits_per_word, 8);
 
@@ -824,13 +933,14 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 		dspi->rx = transfer->rx_buf;
 		dspi->len = transfer->len;
 		dspi->progress = 0;
-		/* Validated transfer specific frame size (defaults applied) */
-		dspi->bits_per_word = transfer->bits_per_word;
-		dspi->bytes_per_word = DIV_ROUND_UP(dspi->bits_per_word, 8);
 
 		regmap_update_bits(dspi->regmap, SPI_MCR,
 				   SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF,
 				   SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF);
+		/*
+		 * Static CTAR setup for modes that don't dynamically adjust it
+		 * via dspi_setup_accel (aka for DMA)
+		 */
 		regmap_write(dspi->regmap, SPI_CTAR(0),
 			     dspi->cur_chip->ctar_val |
 			     SPI_FRAME_BITS(transfer->bits_per_word));
-- 
2.17.1

