Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54C8B17A7C2
	for <lists+linux-spi@lfdr.de>; Thu,  5 Mar 2020 15:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgCEOhY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Mar 2020 09:37:24 -0500
Received: from foss.arm.com ([217.140.110.172]:49332 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbgCEOhY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Mar 2020 09:37:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB04D1045;
        Thu,  5 Mar 2020 06:37:23 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F6A23F534;
        Thu,  5 Mar 2020 06:37:23 -0800 (PST)
Date:   Thu, 05 Mar 2020 14:37:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     andrew.smirnov@gmail.com, angelo@sysam.it, broonie@kernel.org,
        eha@deif.com, gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mhosny@nvidia.com, weic@nvidia.com
Subject: Applied "spi: spi-fsl-dspi: Optimize dspi_setup_accel for lowest interrupt count" to the spi tree
In-Reply-To:  <20200304220044.11193-11-olteanv@gmail.com>
Message-Id:  <applied-20200304220044.11193-11-olteanv@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-fsl-dspi: Optimize dspi_setup_accel for lowest interrupt count

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

From 6365504d42d90c68555ee40cdf297a1f187cb4a3 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Thu, 5 Mar 2020 00:00:42 +0200
Subject: [PATCH] spi: spi-fsl-dspi: Optimize dspi_setup_accel for lowest
 interrupt count

Currently, a SPI transfer that is not multiple of the highest supported
word width (e.g. 4 bytes) will be transmitted as follows (assume a
30-byte buffer transmitted through a 32-bit wide FIFO that is 32 bytes
deep):

 - First 28 bytes are sent as 7 words of 32 bits each
 - Last 2 bytes are sent as 1 word of 16 bits size

But if the dspi_setup_accel function had decided to use a lower
oper_bits_per_word value (16 instead of 32), there would have been
enough space in the TX FIFO to fit the entire buffer in one go (15 words
of 16 bits each).

What we're actually trying to avoid is mixing word sizes within the same
run with the TX FIFO, since there is an erratum surrounding this, and
invalid data might get transmitted.

So this patch adds special cases for when the remaining length of the
buffer can be sent in one go as 8-bit or 16-bit words, otherwise it
falls back to the standard logic of sending as many bytes as possible at
the highest oper_bits_per_word value possible.

The benefit is that there will be one less CMDFQ/EOQ interrupt to
service when the entire buffer is transmitted during a single go, and
that will improve the overall latency of the transfer.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://lore.kernel.org/r/20200304220044.11193-11-olteanv@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index f5b802070d29..df4944353ed5 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -775,20 +775,34 @@ static void dspi_fifo_read(struct fsl_dspi *dspi)
 static void dspi_setup_accel(struct fsl_dspi *dspi)
 {
 	struct spi_transfer *xfer = dspi->cur_transfer;
+	bool odd = !!(dspi->len & 1);
 
-	/* Start off with maximum supported by hardware */
-	if (dspi->devtype_data->trans_mode == DSPI_XSPI_MODE)
-		dspi->oper_bits_per_word = 32;
-	else
+	/* No accel for frames not multiple of 8 bits at the moment */
+	if (xfer->bits_per_word % 8)
+		goto no_accel;
+
+	if (!odd && dspi->len <= dspi->devtype_data->fifo_size * 2) {
 		dspi->oper_bits_per_word = 16;
+	} else if (odd && dspi->len <= dspi->devtype_data->fifo_size) {
+		dspi->oper_bits_per_word = 8;
+	} else {
+		/* Start off with maximum supported by hardware */
+		if (dspi->devtype_data->trans_mode == DSPI_XSPI_MODE)
+			dspi->oper_bits_per_word = 32;
+		else
+			dspi->oper_bits_per_word = 16;
 
-	/* And go down only if the buffer can't be sent with words this big */
-	do {
-		if (dspi->len >= DIV_ROUND_UP(dspi->oper_bits_per_word, 8))
-			break;
+		/*
+		 * And go down only if the buffer can't be sent with
+		 * words this big
+		 */
+		do {
+			if (dspi->len >= DIV_ROUND_UP(dspi->oper_bits_per_word, 8))
+				break;
 
-		dspi->oper_bits_per_word /= 2;
-	} while (dspi->oper_bits_per_word > 8);
+			dspi->oper_bits_per_word /= 2;
+		} while (dspi->oper_bits_per_word > 8);
+	}
 
 	if (xfer->bits_per_word == 8 && dspi->oper_bits_per_word == 32) {
 		dspi->dev_to_host = dspi_8on32_dev_to_host;
@@ -800,7 +814,7 @@ static void dspi_setup_accel(struct fsl_dspi *dspi)
 		dspi->dev_to_host = dspi_16on32_dev_to_host;
 		dspi->host_to_dev = dspi_16on32_host_to_dev;
 	} else {
-		/* No acceleration needed (8<N<=16 on 16, 16<N<=32 on 32) */
+no_accel:
 		dspi->dev_to_host = dspi_native_dev_to_host;
 		dspi->host_to_dev = dspi_native_host_to_dev;
 		dspi->oper_bits_per_word = xfer->bits_per_word;
-- 
2.20.1

