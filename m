Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 068B6179B72
	for <lists+linux-spi@lfdr.de>; Wed,  4 Mar 2020 23:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388572AbgCDWCT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Mar 2020 17:02:19 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42576 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388523AbgCDWCG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Mar 2020 17:02:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id v11so2482169wrm.9;
        Wed, 04 Mar 2020 14:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5R/rDmNhyc7vzbOzNZhfgybBBIbwrxzNOKgHeUzPXLM=;
        b=rghochqbZqiIro8RZxD23WmEphyvOjT2yceM94Q72x6k4qsWmK60LMI/c7E2bymqgv
         UyntMebX81uwjfc7EYeGCfAefy4gSCW1sp22m3rnGj5kqge4APpftsidMhlnOqkaGZWJ
         QVlWeBNQ6na12+NH3PSmr5MEmtYIX/7U2fsBkQvhnSnhhGHDKPzrxjpQmak/E2RdR3yf
         VjK5Kc/R2C9NBK4TIHEgpExwlLqCGYJq+UkObgel+R2OcbjTzmHhv/K32TRT/LCGj/we
         236Donr4UKwygYEetBQO2qnY0hgdw/IQVlP67ZFUJsUhBI1qGLOPD0uBZmxUsGlm5CJ/
         U8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5R/rDmNhyc7vzbOzNZhfgybBBIbwrxzNOKgHeUzPXLM=;
        b=jiQiQQp6/CCdAw04ZgP5YRaW5lfoAa9MVdygHaZLI5KR1mP8V2VJSd8jncFeAJCZhS
         h4tVypGcn5FwUu9eh5DIymGVJTddqJ6iFBw8fgMr6KGWh+DsQZ8bWYtynQWJlZ2VWaEv
         wsDngEt+rYOSTDuExwRo4TQSoNa9aiQLSF0LLQ48LBgNOBWGHsKB6PpaTF7joXhx0KlL
         V3BwZgWnD22Qs8REJFkBoGaz1AKFJJRK4fIUeG0eJF/zDqUzru/m4tJmNXlTKq4Q2a1J
         pN3cCg6qVFB3Sni+IkzOq0JX6SLje8fJaQDpUrUy0YiCZG+de4KJVpdjOyv9c4eSUEin
         46Fg==
X-Gm-Message-State: ANhLgQ0nT6myOsxQynTyQgEP3sT3sP+Sg5RHxPdKfC/rEO/VwjxVj1Sz
        7Sf9u/NNXzstKxUVjXgxgLE=
X-Google-Smtp-Source: ADFU+vusgvHCAauDFZI1KPMZLcsJpZZKnm3JgTdJzqhkpizWdoWfJjr+pxLtBVKKMxqzBAHLZIk3Ag==
X-Received: by 2002:a5d:5643:: with SMTP id j3mr5661015wrw.337.1583359323610;
        Wed, 04 Mar 2020 14:02:03 -0800 (PST)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id z2sm36776402wrq.95.2020.03.04.14.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 14:02:03 -0800 (PST)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        eha@deif.com, angelo@sysam.it, andrew.smirnov@gmail.com,
        gustavo@embeddedor.com, weic@nvidia.com, mhosny@nvidia.com
Subject: [PATCH 08/12] spi: spi-fsl-dspi: Convert TCFQ users to XSPI FIFO mode
Date:   Thu,  5 Mar 2020 00:00:40 +0200
Message-Id: <20200304220044.11193-9-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304220044.11193-1-olteanv@gmail.com>
References: <20200304220044.11193-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

The Transfer Complete Flag (TCF) interrupt gets raised after each write
to the TX FIFO (PUSHR) which means that it is not possible to devise a
transfer procedure that makes full utilization of the FIFO depth (4
entries on most controllers, 16 entries on some).

On the other hand, XSPI mode has a feature called "command cycling",
which allows a single TX command to be run for a pre-specified number of
TX words. When the command cycle ends, the Command Transfer Complete
Flag bit asserts and raises an interrupt. The advantage in this mode is
that the TX FIFO can be better utilized (more words can be batched at
once).

Other changes brought by this patch:
 - The dspi->rx_end variable has been removed, since now the
   dspi_fifo_write function sets up dspi->words_in_flight, so
   dspi_fifo_read knows how much to read without overrunning the RX
   buffer.
 - Stop using poll mode unconditionally for TCFQ mode, since XSPI mode
   is a little less efficient than that, and so, poll mode doesn't bring
   as many improvements for XSPI.
 - Stop relying on the hardware transfer counter (SPI_TCR_GET_TCNT) and
   instead increment the message->actual_length based on the newly
   introduced dspi->words_in_flight variable.
 - The CTARE register is now written in the hotpath instead of just at
   transfer init time, since it contains the DTCP field (transfer
   preload - the counter indicating how many txdata words will follow),
   which is a dynamic value.

Due to the fact that the Chip Select toggling setting is part of the
command written to the TX FIFO, the ending word of each buffer needs to
be sent via its own TX command, so that we have a chance to emit a
1-word command with deasserted PCS.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 189 ++++++++++++++++++++-----------------
 1 file changed, 101 insertions(+), 88 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 158cb48c0f4a..298c22def165 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -72,6 +72,7 @@
 #define SPI_RSER			0x30
 #define SPI_RSER_TCFQE			BIT(31)
 #define SPI_RSER_EOQFE			BIT(28)
+#define SPI_RSER_CMDTCFE		BIT(23)
 
 #define SPI_PUSHR			0x34
 #define SPI_PUSHR_CMD_CONT		BIT(15)
@@ -114,14 +115,13 @@ struct chip_data {
 
 enum dspi_trans_mode {
 	DSPI_EOQ_MODE = 0,
-	DSPI_TCFQ_MODE,
+	DSPI_XSPI_MODE,
 	DSPI_DMA_MODE,
 };
 
 struct fsl_dspi_devtype_data {
 	enum dspi_trans_mode	trans_mode;
 	u8			max_clock_factor;
-	bool			xspi_mode;
 	int			fifo_size;
 	int			dma_bufsize;
 };
@@ -147,37 +147,32 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 	},
 	[LS1021A] = {
 		/* Has A-011218 DMA erratum */
-		.trans_mode		= DSPI_TCFQ_MODE,
+		.trans_mode		= DSPI_XSPI_MODE,
 		.max_clock_factor	= 8,
-		.xspi_mode		= true,
 		.fifo_size		= 4,
 	},
 	[LS1012A] = {
 		/* Has A-011218 DMA erratum */
-		.trans_mode		= DSPI_TCFQ_MODE,
+		.trans_mode		= DSPI_XSPI_MODE,
 		.max_clock_factor	= 8,
-		.xspi_mode		= true,
 		.fifo_size		= 16,
 	},
 	[LS1043A] = {
 		/* Has A-011218 DMA erratum */
-		.trans_mode		= DSPI_TCFQ_MODE,
+		.trans_mode		= DSPI_XSPI_MODE,
 		.max_clock_factor	= 8,
-		.xspi_mode		= true,
 		.fifo_size		= 16,
 	},
 	[LS1046A] = {
 		/* Has A-011218 DMA erratum */
-		.trans_mode		= DSPI_TCFQ_MODE,
+		.trans_mode		= DSPI_XSPI_MODE,
 		.max_clock_factor	= 8,
-		.xspi_mode		= true,
 		.fifo_size		= 16,
 	},
 	[LS2080A] = {
 		.trans_mode		= DSPI_DMA_MODE,
 		.dma_bufsize		= 8,
 		.max_clock_factor	= 8,
-		.xspi_mode		= true,
 		.fifo_size		= 4,
 	},
 	[LS2085A] = {
@@ -190,7 +185,6 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 		.trans_mode		= DSPI_DMA_MODE,
 		.dma_bufsize		= 8,
 		.max_clock_factor	= 8,
-		.xspi_mode		= true,
 		.fifo_size		= 4,
 	},
 	[MCF5441X] = {
@@ -233,7 +227,6 @@ struct fsl_dspi {
 	size_t					len;
 	const void				*tx;
 	void					*rx;
-	void					*rx_end;
 	u16					tx_cmd;
 	u8					bits_per_word;
 	u8					bytes_per_word;
@@ -243,6 +236,8 @@ struct fsl_dspi {
 	u32					waitflags;
 
 	struct fsl_dspi_dma			*dma;
+
+	int					words_in_flight;
 };
 
 /*
@@ -610,7 +605,17 @@ static void dspi_pushr_cmd_write(struct fsl_dspi *dspi)
 {
 	u16 cmd = dspi->tx_cmd;
 
-	if (dspi->len > 0)
+	/*
+	 * The only time when the PCS doesn't need continuation after this word
+	 * is when it's last. We need to look ahead, because we actually call
+	 * dspi_pop_tx (the function that decrements dspi->len) _after_
+	 * dspi_pushr_cmd_write with XSPI mode. As for how much in advance? One
+	 * word is enough. If there's more to transmit than that,
+	 * dspi_xspi_write will know to split the FIFO writes in 2, and
+	 * generate a new PUSHR command with the final word that will have PCS
+	 * deasserted (not continued) here.
+	 */
+	if (dspi->len > dspi->bytes_per_word)
 		cmd |= SPI_PUSHR_CMD_CONT;
 	regmap_write(dspi->regmap_pushr, PUSHR_CMD, cmd);
 }
@@ -620,93 +625,115 @@ static void dspi_pushr_txdata_write(struct fsl_dspi *dspi, u16 txdata)
 	regmap_write(dspi->regmap_pushr, PUSHR_TX, txdata);
 }
 
-static void dspi_tcfq_write(struct fsl_dspi *dspi)
+static void dspi_xspi_write(struct fsl_dspi *dspi, int cnt)
 {
-	/* Clear transfer count */
-	dspi->tx_cmd |= SPI_PUSHR_CMD_CTCNT;
+	regmap_write(dspi->regmap, SPI_CTARE(0),
+		     SPI_FRAME_EBITS(dspi->bits_per_word) |
+		     SPI_CTARE_DTCP(cnt));
 
-	if (dspi->devtype_data->xspi_mode && dspi->bits_per_word > 16) {
-		/* Write the CMD FIFO entry first, and then the two
-		 * corresponding TX FIFO entries.
-		 */
+	/*
+	 * Write the CMD FIFO entry first, and then the two
+	 * corresponding TX FIFO entries (or one...).
+	 */
+	dspi_pushr_cmd_write(dspi);
+
+	/* Fill TX FIFO with as many transfers as possible */
+	while (cnt--) {
 		u32 data = dspi_pop_tx(dspi);
 
-		dspi_pushr_cmd_write(dspi);
 		dspi_pushr_txdata_write(dspi, data & 0xFFFF);
-		dspi_pushr_txdata_write(dspi, data >> 16);
-	} else {
-		/* Write one entry to both TX FIFO and CMD FIFO
-		 * simultaneously.
-		 */
-		dspi_pushr_write(dspi);
+		if (dspi->bits_per_word > 16)
+			dspi_pushr_txdata_write(dspi, data >> 16);
 	}
 }
 
-static u32 dspi_popr_read(struct fsl_dspi *dspi)
+static void dspi_xspi_fifo_write(struct fsl_dspi *dspi)
 {
-	u32 rxdata = 0;
+	int num_fifo_entries = dspi->devtype_data->fifo_size;
+	int bytes_in_flight;
 
-	regmap_read(dspi->regmap, SPI_POPR, &rxdata);
-	return rxdata;
-}
+	/* In XSPI mode each 32-bit word occupies 2 TX FIFO entries */
+	if (dspi->bits_per_word > 16)
+		num_fifo_entries /= 2;
 
-static void dspi_tcfq_read(struct fsl_dspi *dspi)
-{
-	dspi_push_rx(dspi, dspi_popr_read(dspi));
+	dspi->words_in_flight = dspi->len / dspi->bytes_per_word;
+
+	if (dspi->words_in_flight > num_fifo_entries)
+		dspi->words_in_flight = num_fifo_entries;
+
+	bytes_in_flight = dspi->words_in_flight * dspi->bytes_per_word;
+
+	/*
+	 * If the PCS needs to de-assert (i.e. we're at the end of the buffer
+	 * and cs_change does not want the PCS to stay on), then we need a new
+	 * PUSHR command, since this one (for the body of the buffer)
+	 * necessarily has the CONT bit set.
+	 * So send one word less during this go, to force a split and a command
+	 * with a single word next time, when CONT will be unset.
+	 */
+	if (bytes_in_flight == dspi->len && dspi->words_in_flight > 1 &&
+	    !(dspi->tx_cmd & SPI_PUSHR_CMD_CONT))
+		dspi->words_in_flight--;
+
+	dspi_xspi_write(dspi, dspi->words_in_flight);
 }
 
-static void dspi_eoq_write(struct fsl_dspi *dspi)
+static void dspi_eoq_fifo_write(struct fsl_dspi *dspi)
 {
-	int fifo_size = dspi->devtype_data->fifo_size;
+	int num_fifo_entries = dspi->devtype_data->fifo_size;
 	u16 xfer_cmd = dspi->tx_cmd;
 
+	dspi->words_in_flight = num_fifo_entries;
+
 	/* Fill TX FIFO with as many transfers as possible */
-	while (dspi->len && fifo_size--) {
+	while (dspi->len && num_fifo_entries--) {
 		dspi->tx_cmd = xfer_cmd;
 		/* Request EOQF for last transfer in FIFO */
-		if (dspi->len == dspi->bytes_per_word || fifo_size == 0)
+		if (dspi->len == dspi->bytes_per_word || num_fifo_entries == 0)
 			dspi->tx_cmd |= SPI_PUSHR_CMD_EOQ;
-		/* Clear transfer count for first transfer in FIFO */
-		if (fifo_size == (dspi->devtype_data->fifo_size - 1))
-			dspi->tx_cmd |= SPI_PUSHR_CMD_CTCNT;
 		/* Write combined TX FIFO and CMD FIFO entry */
 		dspi_pushr_write(dspi);
 	}
 }
 
-static void dspi_eoq_read(struct fsl_dspi *dspi)
+static u32 dspi_popr_read(struct fsl_dspi *dspi)
 {
-	int fifo_size = dspi->devtype_data->fifo_size;
+	u32 rxdata = 0;
 
+	regmap_read(dspi->regmap, SPI_POPR, &rxdata);
+	return rxdata;
+}
+
+static void dspi_fifo_read(struct fsl_dspi *dspi)
+{
 	/* Read one FIFO entry and push to rx buffer */
-	while ((dspi->rx < dspi->rx_end) && fifo_size--)
+	while (dspi->words_in_flight--)
 		dspi_push_rx(dspi, dspi_popr_read(dspi));
 }
 
+static void dspi_fifo_write(struct fsl_dspi *dspi)
+{
+	if (dspi->devtype_data->trans_mode == DSPI_EOQ_MODE)
+		dspi_eoq_fifo_write(dspi);
+	else
+		dspi_xspi_fifo_write(dspi);
+}
+
 static int dspi_rxtx(struct fsl_dspi *dspi)
 {
+	struct spi_transfer *xfer = dspi->cur_transfer;
 	struct spi_message *msg = dspi->cur_msg;
-	enum dspi_trans_mode trans_mode;
-	u16 spi_tcnt;
-	u32 spi_tcr;
+	int bytes_sent;
+
+	/* Update total number of bytes that were transferred */
+	bytes_sent = dspi->words_in_flight * dspi->bytes_per_word;
+	msg->actual_length += bytes_sent;
+	dspi->progress += bytes_sent / DIV_ROUND_UP(xfer->bits_per_word, 8);
 
 	spi_take_timestamp_post(dspi->ctlr, dspi->cur_transfer,
 				dspi->progress, !dspi->irq);
 
-	/* Get transfer counter (in number of SPI transfers). It was
-	 * reset to 0 when transfer(s) were started.
-	 */
-	regmap_read(dspi->regmap, SPI_TCR, &spi_tcr);
-	spi_tcnt = SPI_TCR_GET_TCNT(spi_tcr);
-	/* Update total number of bytes that were transferred */
-	msg->actual_length += spi_tcnt * dspi->bytes_per_word;
-	dspi->progress += spi_tcnt;
-
-	trans_mode = dspi->devtype_data->trans_mode;
-	if (trans_mode == DSPI_EOQ_MODE)
-		dspi_eoq_read(dspi);
-	else if (trans_mode == DSPI_TCFQ_MODE)
-		dspi_tcfq_read(dspi);
+	dspi_fifo_read(dspi);
 
 	if (!dspi->len)
 		/* Success! */
@@ -715,10 +742,7 @@ static int dspi_rxtx(struct fsl_dspi *dspi)
 	spi_take_timestamp_pre(dspi->ctlr, dspi->cur_transfer,
 			       dspi->progress, !dspi->irq);
 
-	if (trans_mode == DSPI_EOQ_MODE)
-		dspi_eoq_write(dspi);
-	else if (trans_mode == DSPI_TCFQ_MODE)
-		dspi_tcfq_write(dspi);
+	dspi_fifo_write(dspi);
 
 	return -EINPROGRESS;
 }
@@ -732,7 +756,7 @@ static int dspi_poll(struct fsl_dspi *dspi)
 		regmap_read(dspi->regmap, SPI_SR, &spi_sr);
 		regmap_write(dspi->regmap, SPI_SR, spi_sr);
 
-		if (spi_sr & (SPI_SR_EOQF | SPI_SR_TCFQF))
+		if (spi_sr & (SPI_SR_EOQF | SPI_SR_CMDTCF))
 			break;
 	} while (--tries);
 
@@ -750,7 +774,7 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 	regmap_read(dspi->regmap, SPI_SR, &spi_sr);
 	regmap_write(dspi->regmap, SPI_SR, spi_sr);
 
-	if (!(spi_sr & SPI_SR_EOQF))
+	if (!(spi_sr & (SPI_SR_EOQF | SPI_SR_CMDTCF)))
 		return IRQ_NONE;
 
 	if (dspi_rxtx(dspi) == 0) {
@@ -798,7 +822,6 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 
 		dspi->tx = transfer->tx_buf;
 		dspi->rx = transfer->rx_buf;
-		dspi->rx_end = dspi->rx + transfer->len;
 		dspi->len = transfer->len;
 		dspi->progress = 0;
 		/* Validated transfer specific frame size (defaults applied) */
@@ -811,10 +834,6 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 		regmap_write(dspi->regmap, SPI_CTAR(0),
 			     dspi->cur_chip->ctar_val |
 			     SPI_FRAME_BITS(transfer->bits_per_word));
-		if (dspi->devtype_data->xspi_mode)
-			regmap_write(dspi->regmap, SPI_CTARE(0),
-				     SPI_FRAME_EBITS(transfer->bits_per_word) |
-				     SPI_CTARE_DTCP(1));
 
 		spi_take_timestamp_pre(dspi->ctlr, dspi->cur_transfer,
 				       dspi->progress, !dspi->irq);
@@ -823,11 +842,11 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 		switch (trans_mode) {
 		case DSPI_EOQ_MODE:
 			regmap_write(dspi->regmap, SPI_RSER, SPI_RSER_EOQFE);
-			dspi_eoq_write(dspi);
+			dspi_fifo_write(dspi);
 			break;
-		case DSPI_TCFQ_MODE:
-			regmap_write(dspi->regmap, SPI_RSER, SPI_RSER_TCFQE);
-			dspi_tcfq_write(dspi);
+		case DSPI_XSPI_MODE:
+			regmap_write(dspi->regmap, SPI_RSER, SPI_RSER_CMDTCFE);
+			dspi_fifo_write(dspi);
 			break;
 		case DSPI_DMA_MODE:
 			regmap_write(dspi->regmap, SPI_RSER,
@@ -1053,16 +1072,13 @@ static void dspi_init(struct fsl_dspi *dspi)
 {
 	unsigned int mcr = SPI_MCR_PCSIS;
 
-	if (dspi->devtype_data->xspi_mode)
+	if (dspi->devtype_data->trans_mode == DSPI_XSPI_MODE)
 		mcr |= SPI_MCR_XSPI;
 	if (!spi_controller_is_slave(dspi->ctlr))
 		mcr |= SPI_MCR_MASTER;
 
 	regmap_write(dspi->regmap, SPI_MCR, mcr);
 	regmap_write(dspi->regmap, SPI_SR, SPI_SR_CLEAR);
-	if (dspi->devtype_data->xspi_mode)
-		regmap_write(dspi->regmap, SPI_CTARE(0),
-			     SPI_CTARE_FMSZE(0) | SPI_CTARE_DTCP(1));
 }
 
 static int dspi_slave_abort(struct spi_master *master)
@@ -1162,7 +1178,7 @@ static int dspi_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (dspi->devtype_data->xspi_mode)
+	if (dspi->devtype_data->trans_mode == DSPI_XSPI_MODE)
 		ctlr->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	else
 		ctlr->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16);
@@ -1174,7 +1190,7 @@ static int dspi_probe(struct platform_device *pdev)
 		goto out_ctlr_put;
 	}
 
-	if (dspi->devtype_data->xspi_mode)
+	if (dspi->devtype_data->trans_mode == DSPI_XSPI_MODE)
 		regmap_config = &dspi_xspi_regmap_config[0];
 	else
 		regmap_config = &dspi_regmap_config;
@@ -1186,7 +1202,7 @@ static int dspi_probe(struct platform_device *pdev)
 		goto out_ctlr_put;
 	}
 
-	if (dspi->devtype_data->xspi_mode) {
+	if (dspi->devtype_data->trans_mode == DSPI_XSPI_MODE) {
 		dspi->regmap_pushr = devm_regmap_init_mmio(
 			&pdev->dev, base + SPI_PUSHR,
 			&dspi_xspi_regmap_config[1]);
@@ -1211,9 +1227,6 @@ static int dspi_probe(struct platform_device *pdev)
 
 	dspi_init(dspi);
 
-	if (dspi->devtype_data->trans_mode == DSPI_TCFQ_MODE)
-		goto poll_mode;
-
 	dspi->irq = platform_get_irq(pdev, 0);
 	if (dspi->irq <= 0) {
 		dev_info(&pdev->dev,
-- 
2.17.1

