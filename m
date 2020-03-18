Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD0C018A887
	for <lists+linux-spi@lfdr.de>; Wed, 18 Mar 2020 23:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgCRWpg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Mar 2020 18:45:36 -0400
Received: from foss.arm.com ([217.140.110.172]:55998 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbgCRWpg (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 18 Mar 2020 18:45:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A59E30E;
        Wed, 18 Mar 2020 15:45:35 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BBF93F52E;
        Wed, 18 Mar 2020 15:45:34 -0700 (PDT)
Date:   Wed, 18 Mar 2020 22:45:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     andrew.smirnov@gmail.com, angelo@sysam.it, broonie@kernel.org,
        devicetree@vger.kernel.org, eha@deif.com, gustavo@embeddedor.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, mark.rutland@arm.com,
        mhosny@nvidia.com, michael@walle.cc,
        Michael Walle <michael@walle.cc>, peng.ma@nxp.com,
        robh+dt@kernel.org, shawnguo@kernel.org, weic@nvidia.com
Subject: Applied "spi: spi-fsl-dspi: Protect against races on dspi->words_in_flight" to the spi tree
In-Reply-To:  <20200318001603.9650-6-olteanv@gmail.com>
Message-Id:  <applied-20200318001603.9650-6-olteanv@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-fsl-dspi: Protect against races on dspi->words_in_flight

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

From 0dedf901078074d6c5b41c297fac12c02c6dc41f Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Wed, 18 Mar 2020 02:15:56 +0200
Subject: [PATCH] spi: spi-fsl-dspi: Protect against races on
 dspi->words_in_flight

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
Tested-by: Michael Walle <michael@walle.cc>
Link: https://lore.kernel.org/r/20200318001603.9650-6-olteanv@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
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
2.20.1

