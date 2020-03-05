Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7536A17A7C0
	for <lists+linux-spi@lfdr.de>; Thu,  5 Mar 2020 15:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgCEOhU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Mar 2020 09:37:20 -0500
Received: from foss.arm.com ([217.140.110.172]:49312 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbgCEOhT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Mar 2020 09:37:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DBD44B2;
        Thu,  5 Mar 2020 06:37:19 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4AB53F534;
        Thu,  5 Mar 2020 06:37:18 -0800 (PST)
Date:   Thu, 05 Mar 2020 14:37:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     andrew.smirnov@gmail.com, angelo@sysam.it, broonie@kernel.org,
        eha@deif.com, gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mhosny@nvidia.com, weic@nvidia.com
Subject: Applied "spi: spi-fsl-dspi: Use EOQ for last word in buffer even for XSPI mode" to the spi tree
In-Reply-To:  <20200304220044.11193-12-olteanv@gmail.com>
Message-Id:  <applied-20200304220044.11193-12-olteanv@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-fsl-dspi: Use EOQ for last word in buffer even for XSPI mode

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

From ea93ed4c181bd42d27b49b612d56f4ceb23d1d6c Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Thu, 5 Mar 2020 00:00:43 +0200
Subject: [PATCH] spi: spi-fsl-dspi: Use EOQ for last word in buffer even for
 XSPI mode

The EOQ mode has a hardware limitation in that it stops the transmission
(including the deassertion of the chip select signal) once the host CPU
requests end-of-queue for a particular word in the TX FIFO.

And XSPI mode has a limitation in that we need a separate CMD FIFO entry
for the last byte in the buffer, where the chip select signal needs to
be deasserted. It's not a functional limitation, but it's rather clunky
and the fact that we need to halt the pipeline and write a single entry
to the TX FIFO whenever a buffer ends brings the throughput down when
transmitting small buffers.

So the idea here is to use EOQ's limitation in our favor when using XSPI
mode. Stop special-casing that final word in the buffer, and just kill
the chip select signal by issuing an EOQ for that last word. Now it can
be mixed in with all the other words in the current TX FIFO train.

A small trick here is that we still keep using the XSPI-specific
signaling via the CMDTCFQ interrupt in RSER, and not enabling the EOQ
interrupt, in order to avoid hardware weirdness (potential races with
separate interrupts being raised for CMDTCFQ and EOQ for what is in fact
the end of the same transmission). That is just theoretical, but it's
good to be cautious, and the EOQ interrupt isn't needed.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://lore.kernel.org/r/20200304220044.11193-12-olteanv@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index df4944353ed5..d5983be32180 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -656,10 +656,8 @@ static void dspi_pushr_write(struct fsl_dspi *dspi)
 	regmap_write(dspi->regmap, SPI_PUSHR, dspi_pop_tx_pushr(dspi));
 }
 
-static void dspi_pushr_cmd_write(struct fsl_dspi *dspi)
+static void dspi_pushr_cmd_write(struct fsl_dspi *dspi, u16 cmd)
 {
-	u16 cmd = dspi->tx_cmd;
-
 	/*
 	 * The only time when the PCS doesn't need continuation after this word
 	 * is when it's last. We need to look ahead, because we actually call
@@ -680,8 +678,13 @@ static void dspi_pushr_txdata_write(struct fsl_dspi *dspi, u16 txdata)
 	regmap_write(dspi->regmap_pushr, PUSHR_TX, txdata);
 }
 
-static void dspi_xspi_write(struct fsl_dspi *dspi, int cnt)
+static void dspi_xspi_write(struct fsl_dspi *dspi, int cnt, bool eoq)
 {
+	u16 tx_cmd = dspi->tx_cmd;
+
+	if (eoq)
+		tx_cmd |= SPI_PUSHR_CMD_EOQ;
+
 	/* Update CTARE */
 	regmap_write(dspi->regmap, SPI_CTARE(0),
 		     SPI_FRAME_EBITS(dspi->oper_bits_per_word) |
@@ -691,7 +694,7 @@ static void dspi_xspi_write(struct fsl_dspi *dspi, int cnt)
 	 * Write the CMD FIFO entry first, and then the two
 	 * corresponding TX FIFO entries (or one...).
 	 */
-	dspi_pushr_cmd_write(dspi);
+	dspi_pushr_cmd_write(dspi, tx_cmd);
 
 	/* Fill TX FIFO with as many transfers as possible */
 	while (cnt--) {
@@ -707,6 +710,7 @@ static void dspi_xspi_fifo_write(struct fsl_dspi *dspi)
 {
 	int num_fifo_entries = dspi->devtype_data->fifo_size;
 	int bytes_in_flight;
+	bool eoq = false;
 
 	/* In XSPI mode each 32-bit word occupies 2 TX FIFO entries */
 	if (dspi->oper_word_size == 4)
@@ -732,11 +736,11 @@ static void dspi_xspi_fifo_write(struct fsl_dspi *dspi)
 	 * So send one word less during this go, to force a split and a command
 	 * with a single word next time, when CONT will be unset.
 	 */
-	if (bytes_in_flight == dspi->len && dspi->words_in_flight > 1 &&
-	    !(dspi->tx_cmd & SPI_PUSHR_CMD_CONT))
-		dspi->words_in_flight--;
+	if (!(dspi->tx_cmd & SPI_PUSHR_CMD_CONT) &&
+	    bytes_in_flight == dspi->len)
+		eoq = true;
 
-	dspi_xspi_write(dspi, dspi->words_in_flight);
+	dspi_xspi_write(dspi, dspi->words_in_flight, eoq);
 }
 
 static void dspi_eoq_fifo_write(struct fsl_dspi *dspi)
-- 
2.20.1

