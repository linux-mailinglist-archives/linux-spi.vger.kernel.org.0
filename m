Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB59B18929A
	for <lists+linux-spi@lfdr.de>; Wed, 18 Mar 2020 01:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgCRARR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Mar 2020 20:17:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41390 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbgCRARQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Mar 2020 20:17:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id f11so11315355wrp.8;
        Tue, 17 Mar 2020 17:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xVknuaNdOMQX03RuI0SzV8850sN44K94XjBLipDYOqs=;
        b=MffqPYB0yAfhNUEUaOWqsKLh0wTbP5IJztAsaokxaK9fi/RBhjVpJGPAwXbI5wjEwA
         2VKCQuPwZHOX39VhWNQOaYC8BYYh9VAsZgAZhORweQ0pLp/nMVmri1XSmdyi6lhIDAoz
         2wU+qj/5mZG8YEAt9DQC7w7pLoRkDMNLF5PC0cfllC/yKGf2W+eh0WWX0U217wCbgWsz
         8CYZ9XZX0E5ij1P4npCWx//HB4kXsxHpYqDeZ92HbU/C7KL5/zeWl2DqkIO2PP5HlCE3
         XREeuKchiWwmsloNCXVv/jci4vv2tGj6lBZ5mjw+a5ls6imYUlW79B2L0yMuEnAVIy+o
         LLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xVknuaNdOMQX03RuI0SzV8850sN44K94XjBLipDYOqs=;
        b=mLJjjXaScFW/O6fZghNR+901qoeAEV90vNsOpY2A+igdptAXZh1+UXhnjov8Zo47gs
         I3NXtpDCNxRmhdnoF2TLRSrEGaNf6pGoaqNBSf6twL5lo2/KcO9gYgMRcX7EIneg7zZU
         3ITdlIlx5BPmAnY/zQLX0RUh7bgiJNE+TEOufLP8LYXG9dRZPcf2hRt3H4TZ0TrR9pam
         CkjkMqANCIbFSQrBvUaAaOiJ8HtDj91bHjfV+KaOh0mQgV3gLKuyUtlpbHUj2GTp3BRr
         0gpIfvmNNz2A8+gD1ZO3S/DzXn7blVxEr2ztrbPMTno8F2zKbKBJ4X9VE2kriDcyAGxQ
         cTOg==
X-Gm-Message-State: ANhLgQ3Xdjv3xeOquXyMIlOCnREarXRrOmaw0H2LAin9wbY4qi7jKlhz
        2EabSBCeIyJK+CkXdURVzys/4QStURrZCA==
X-Google-Smtp-Source: ADFU+vtAi5S9Jfj4w5lAMDwnkAgqW2+H+8HxTz/zgr14Rf9/ax3hjoovuSkwaeWKuCRkw8L7UKVfTg==
X-Received: by 2002:adf:fcce:: with SMTP id f14mr1626163wrs.200.1584490633738;
        Tue, 17 Mar 2020 17:17:13 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id i6sm6584600wru.40.2020.03.17.17.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 17:17:13 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v5 05/12] spi: spi-fsl-dspi: Protect against races on dspi->words_in_flight
Date:   Wed, 18 Mar 2020 02:15:56 +0200
Message-Id: <20200318001603.9650-6-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318001603.9650-1-olteanv@gmail.com>
References: <20200318001603.9650-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

dspi->words_in_flight is a variable populated in the *_write functions
and used in the dspi_fifo_read function. It is also used in
dspi_fifo_write, immediately after transmission, to update the
message->actual_length variable used by higher layers such as spi-mem
for integrity checking.

But it may happen that the IRQ which calls dspi_fifo_read to be
triggered before the updating of message->actual_length takes place. In
that case, dspi_fifo_read will decrement dspi->words_in_flight to -1,
and that will cause an invalid modification of message->actual_length.

For that, we make the simplest fix possible: to not decrement the actual
shared variable in dspi->words_in_flight from dspi_fifo_read, but
actually a copy of it which is on stack.

But even if dspi_fifo_read from the next IRQ does not interfere with the
dspi_fifo_write of the current chunk, the *next* dspi_fifo_write still
can. So we must assume that everything after the last write to the TX
FIFO can be preempted by the "TX complete" IRQ, and the dspi_fifo_write
function must be safe against that. This means refactoring the 2
flavours of FIFO writes (for EOQ and XSPI) such that the calculation of
the number of words to be written is common and happens a priori. This
way, the code for updating the message->actual_length variable works
with a copy and not with the volatile dspi->words_in_flight.

After some interior debate, the dspi->progress variable used for
software timestamping was *not* backed up against preemption in a copy
on stack. Because if preemption does occur between
spi_take_timestamp_pre and spi_take_timestamp_post, there's really no
point in trying to save anything. The first-in-time
spi_take_timestamp_post call with a dspi->progress higher than the
requested xfer->ptp_sts_word_post will trigger xfer->timestamped = true
anyway and will close the deal.

To understand the above a bit better, consider a transfer with
xfer->ptp_sts_word_pre = xfer->ptp_sts_word_post = 3, and
xfer->bits_per_words = 8 (so byte 3 needs to be timestamped). The DSPI
controller timestamps in chunks of 4 bytes at a time, and preemption
occurs in the middle of timestamping the first chunk:

  spi_take_timestamp_pre(0)
    .
    . (preemption)
    .
    . spi_take_timestamp_pre(4)
    .
    . spi_take_timestamp_post(7)
    .
  spi_take_timestamp_post(3)

So the reason I'm not bothering to back up dspi->progress for that
spi_take_timestamp_post(3) is that spi_take_timestamp_post(7) is going
to (a) be more honest, (b) provide better accuracy and (c) already
render the spi_take_timestamp_post(3) into a noop by setting
xfer->timestamped = true anyway.

Fixes: d59c90a2400f ("spi: spi-fsl-dspi: Convert TCFQ users to XSPI FIFO mode")
Reported-by: Michael Walle <michael@walle.cc>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v5:
Enhanced the patch such that dspi->words_in_flight is protected against
races with the next dspi_fifo_write too. This implied rather major
refactoring of dspi_xspi_fifo_write and dspi_eoq_fifo_write
unfortunately. Perhaps the good side of things is that the
dspi_xspi_write function has now disappeared (has merged with
dspi_xspi_fifo_write).

Changes in v4:
Patch is new.

 drivers/spi/spi-fsl-dspi.c | 111 +++++++++++++++++--------------------
 1 file changed, 52 insertions(+), 59 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 51224b772680..f7e1e7085e31 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -669,17 +669,26 @@ static void dspi_pushr_txdata_write(struct fsl_dspi *dspi, u16 txdata)
 	regmap_write(dspi->regmap_pushr, dspi->pushr_tx, txdata);
 }
 
-static void dspi_xspi_write(struct fsl_dspi *dspi, int cnt, bool eoq)
+static void dspi_xspi_fifo_write(struct fsl_dspi *dspi, int num_words)
 {
+	int num_bytes = num_words * dspi->oper_word_size;
 	u16 tx_cmd = dspi->tx_cmd;
 
-	if (eoq)
+	/*
+	 * If the PCS needs to de-assert (i.e. we're at the end of the buffer
+	 * and cs_change does not want the PCS to stay on), then we need a new
+	 * PUSHR command, since this one (for the body of the buffer)
+	 * necessarily has the CONT bit set.
+	 * So send one word less during this go, to force a split and a command
+	 * with a single word next time, when CONT will be unset.
+	 */
+	if (!(dspi->tx_cmd & SPI_PUSHR_CMD_CONT) && num_bytes == dspi->len)
 		tx_cmd |= SPI_PUSHR_CMD_EOQ;
 
 	/* Update CTARE */
 	regmap_write(dspi->regmap, SPI_CTARE(0),
 		     SPI_FRAME_EBITS(dspi->oper_bits_per_word) |
-		     SPI_CTARE_DTCP(cnt));
+		     SPI_CTARE_DTCP(num_words));
 
 	/*
 	 * Write the CMD FIFO entry first, and then the two
@@ -688,7 +697,7 @@ static void dspi_xspi_write(struct fsl_dspi *dspi, int cnt, bool eoq)
 	dspi_pushr_cmd_write(dspi, tx_cmd);
 
 	/* Fill TX FIFO with as many transfers as possible */
-	while (cnt--) {
+	while (num_words--) {
 		u32 data = dspi_pop_tx(dspi);
 
 		dspi_pushr_txdata_write(dspi, data & 0xFFFF);
@@ -697,58 +706,15 @@ static void dspi_xspi_write(struct fsl_dspi *dspi, int cnt, bool eoq)
 	}
 }
 
-static void dspi_xspi_fifo_write(struct fsl_dspi *dspi)
-{
-	int num_fifo_entries = dspi->devtype_data->fifo_size;
-	int bytes_in_flight;
-	bool eoq = false;
-
-	/* In XSPI mode each 32-bit word occupies 2 TX FIFO entries */
-	if (dspi->oper_word_size == 4)
-		num_fifo_entries /= 2;
-
-	/*
-	 * Integer division intentionally trims off odd (or non-multiple of 4)
-	 * numbers of bytes at the end of the buffer, which will be sent next
-	 * time using a smaller oper_word_size.
-	 */
-	dspi->words_in_flight = dspi->len / dspi->oper_word_size;
-
-	if (dspi->words_in_flight > num_fifo_entries)
-		dspi->words_in_flight = num_fifo_entries;
-
-	bytes_in_flight = dspi->words_in_flight * dspi->oper_word_size;
-
-	/*
-	 * If the PCS needs to de-assert (i.e. we're at the end of the buffer
-	 * and cs_change does not want the PCS to stay on), then we need a new
-	 * PUSHR command, since this one (for the body of the buffer)
-	 * necessarily has the CONT bit set.
-	 * So send one word less during this go, to force a split and a command
-	 * with a single word next time, when CONT will be unset.
-	 */
-	if (!(dspi->tx_cmd & SPI_PUSHR_CMD_CONT) &&
-	    bytes_in_flight == dspi->len)
-		eoq = true;
-
-	dspi_xspi_write(dspi, dspi->words_in_flight, eoq);
-}
-
-static void dspi_eoq_fifo_write(struct fsl_dspi *dspi)
+static void dspi_eoq_fifo_write(struct fsl_dspi *dspi, int num_words)
 {
-	int num_fifo_entries = dspi->devtype_data->fifo_size;
 	u16 xfer_cmd = dspi->tx_cmd;
 
-	if (num_fifo_entries * dspi->oper_word_size > dspi->len)
-		num_fifo_entries = dspi->len / dspi->oper_word_size;
-
-	dspi->words_in_flight = num_fifo_entries;
-
 	/* Fill TX FIFO with as many transfers as possible */
-	while (num_fifo_entries--) {
+	while (num_words--) {
 		dspi->tx_cmd = xfer_cmd;
 		/* Request EOQF for last transfer in FIFO */
-		if (num_fifo_entries == 0)
+		if (num_words == 0)
 			dspi->tx_cmd |= SPI_PUSHR_CMD_EOQ;
 		/* Write combined TX FIFO and CMD FIFO entry */
 		dspi_pushr_write(dspi);
@@ -765,8 +731,10 @@ static u32 dspi_popr_read(struct fsl_dspi *dspi)
 
 static void dspi_fifo_read(struct fsl_dspi *dspi)
 {
+	int num_fifo_entries = dspi->words_in_flight;
+
 	/* Read one FIFO entry and push to rx buffer */
-	while (dspi->words_in_flight--)
+	while (num_fifo_entries--)
 		dspi_push_rx(dspi, dspi_popr_read(dspi));
 }
 
@@ -832,23 +800,48 @@ static void dspi_setup_accel(struct fsl_dspi *dspi)
 
 static void dspi_fifo_write(struct fsl_dspi *dspi)
 {
+	int num_fifo_entries = dspi->devtype_data->fifo_size;
 	struct spi_transfer *xfer = dspi->cur_transfer;
 	struct spi_message *msg = dspi->cur_msg;
-	int bytes_sent;
+	int num_words, num_bytes;
 
 	dspi_setup_accel(dspi);
 
+	/* In XSPI mode each 32-bit word occupies 2 TX FIFO entries */
+	if (dspi->oper_word_size == 4)
+		num_fifo_entries /= 2;
+
+	/*
+	 * Integer division intentionally trims off odd (or non-multiple of 4)
+	 * numbers of bytes at the end of the buffer, which will be sent next
+	 * time using a smaller oper_word_size.
+	 */
+	num_words = dspi->len / dspi->oper_word_size;
+	if (num_words > num_fifo_entries)
+		num_words = num_fifo_entries;
+
+	/* Update total number of bytes that were transferred */
+	num_bytes = num_words * dspi->oper_word_size;
+	msg->actual_length += num_bytes;
+	dspi->progress += num_bytes / DIV_ROUND_UP(xfer->bits_per_word, 8);
+
+	/*
+	 * Update shared variable for use in the next interrupt (both in
+	 * dspi_fifo_read and in dspi_fifo_write).
+	 */
+	dspi->words_in_flight = num_words;
+
 	spi_take_timestamp_pre(dspi->ctlr, xfer, dspi->progress, !dspi->irq);
 
 	if (dspi->devtype_data->trans_mode == DSPI_EOQ_MODE)
-		dspi_eoq_fifo_write(dspi);
+		dspi_eoq_fifo_write(dspi, num_words);
 	else
-		dspi_xspi_fifo_write(dspi);
-
-	/* Update total number of bytes that were transferred */
-	bytes_sent = dspi->words_in_flight * dspi->oper_word_size;
-	msg->actual_length += bytes_sent;
-	dspi->progress += bytes_sent / DIV_ROUND_UP(xfer->bits_per_word, 8);
+		dspi_xspi_fifo_write(dspi, num_words);
+	/*
+	 * Everything after this point is in a potential race with the next
+	 * interrupt, so we must never use dspi->words_in_flight again since it
+	 * might already be modified by the next dspi_fifo_write.
+	 */
 
 	spi_take_timestamp_post(dspi->ctlr, dspi->cur_transfer,
 				dspi->progress, !dspi->irq);
-- 
2.17.1

