Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB8D617A7CD
	for <lists+linux-spi@lfdr.de>; Thu,  5 Mar 2020 15:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgCEOhq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Mar 2020 09:37:46 -0500
Received: from foss.arm.com ([217.140.110.172]:49432 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbgCEOhq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Mar 2020 09:37:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C9291FB;
        Thu,  5 Mar 2020 06:37:46 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9433A3F534;
        Thu,  5 Mar 2020 06:37:45 -0800 (PST)
Date:   Thu, 05 Mar 2020 14:37:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     andrew.smirnov@gmail.com, angelo@sysam.it, broonie@kernel.org,
        eha@deif.com, gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mhosny@nvidia.com, weic@nvidia.com
Subject: Applied "spi: spi-fsl-dspi: Rename fifo_{read,write} and {tx,cmd}_fifo_write" to the spi tree
In-Reply-To:  <20200304220044.11193-6-olteanv@gmail.com>
Message-Id:  <applied-20200304220044.11193-6-olteanv@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-fsl-dspi: Rename fifo_{read,write} and {tx,cmd}_fifo_write

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

From 547248fbed23f3cd2f6a5937b44fad60993640c4 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Thu, 5 Mar 2020 00:00:37 +0200
Subject: [PATCH] spi: spi-fsl-dspi: Rename fifo_{read,write} and
 {tx,cmd}_fifo_write

These function names are very generic and it is easy to get confused.
Rename them after the hardware register that they are accessing.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://lore.kernel.org/r/20200304220044.11193-6-olteanv@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index a8077d4903c7..f37090ad7ad1 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -601,12 +601,12 @@ static void ns_delay_scale(char *psc, char *sc, int delay_ns,
 	}
 }
 
-static void fifo_write(struct fsl_dspi *dspi)
+static void dspi_pushr_write(struct fsl_dspi *dspi)
 {
 	regmap_write(dspi->regmap, SPI_PUSHR, dspi_pop_tx_pushr(dspi));
 }
 
-static void cmd_fifo_write(struct fsl_dspi *dspi)
+static void dspi_pushr_cmd_write(struct fsl_dspi *dspi)
 {
 	u16 cmd = dspi->tx_cmd;
 
@@ -615,7 +615,7 @@ static void cmd_fifo_write(struct fsl_dspi *dspi)
 	regmap_write(dspi->regmap_pushr, PUSHR_CMD, cmd);
 }
 
-static void tx_fifo_write(struct fsl_dspi *dspi, u16 txdata)
+static void dspi_pushr_txdata_write(struct fsl_dspi *dspi, u16 txdata)
 {
 	regmap_write(dspi->regmap_pushr, PUSHR_TX, txdata);
 }
@@ -631,18 +631,18 @@ static void dspi_tcfq_write(struct fsl_dspi *dspi)
 		 */
 		u32 data = dspi_pop_tx(dspi);
 
-		cmd_fifo_write(dspi);
-		tx_fifo_write(dspi, data & 0xFFFF);
-		tx_fifo_write(dspi, data >> 16);
+		dspi_pushr_cmd_write(dspi);
+		dspi_pushr_txdata_write(dspi, data & 0xFFFF);
+		dspi_pushr_txdata_write(dspi, data >> 16);
 	} else {
 		/* Write one entry to both TX FIFO and CMD FIFO
 		 * simultaneously.
 		 */
-		fifo_write(dspi);
+		dspi_pushr_write(dspi);
 	}
 }
 
-static u32 fifo_read(struct fsl_dspi *dspi)
+static u32 dspi_popr_read(struct fsl_dspi *dspi)
 {
 	u32 rxdata = 0;
 
@@ -652,7 +652,7 @@ static u32 fifo_read(struct fsl_dspi *dspi)
 
 static void dspi_tcfq_read(struct fsl_dspi *dspi)
 {
-	dspi_push_rx(dspi, fifo_read(dspi));
+	dspi_push_rx(dspi, dspi_popr_read(dspi));
 }
 
 static void dspi_eoq_write(struct fsl_dspi *dspi)
@@ -670,7 +670,7 @@ static void dspi_eoq_write(struct fsl_dspi *dspi)
 		if (fifo_size == (dspi->devtype_data->fifo_size - 1))
 			dspi->tx_cmd |= SPI_PUSHR_CMD_CTCNT;
 		/* Write combined TX FIFO and CMD FIFO entry */
-		fifo_write(dspi);
+		dspi_pushr_write(dspi);
 	}
 }
 
@@ -680,7 +680,7 @@ static void dspi_eoq_read(struct fsl_dspi *dspi)
 
 	/* Read one FIFO entry and push to rx buffer */
 	while ((dspi->rx < dspi->rx_end) && fifo_size--)
-		dspi_push_rx(dspi, fifo_read(dspi));
+		dspi_push_rx(dspi, dspi_popr_read(dspi));
 }
 
 static int dspi_rxtx(struct fsl_dspi *dspi)
-- 
2.20.1

