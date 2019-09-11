Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5A1AFAC1
	for <lists+linux-spi@lfdr.de>; Wed, 11 Sep 2019 12:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfIKKsF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Sep 2019 06:48:05 -0400
Received: from mailout2.hostsharing.net ([83.223.78.233]:50051 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfIKKsF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Sep 2019 06:48:05 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id D081410189D0E;
        Wed, 11 Sep 2019 12:48:02 +0200 (CEST)
Received: from localhost (p57BD772B.dip0.t-ipconnect.de [87.189.119.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 874156138D2F;
        Wed, 11 Sep 2019 12:48:02 +0200 (CEST)
X-Mailbox-Line: From 062b03b7f86af77a13ce0ec3b22e0bdbfcfba10d Mon Sep 17 00:00:00 2001
Message-Id: <062b03b7f86af77a13ce0ec3b22e0bdbfcfba10d.1568187525.git.lukas@wunner.de>
In-Reply-To: <cover.1568187525.git.lukas@wunner.de>
References: <cover.1568187525.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Wed, 11 Sep 2019 12:15:30 +0200
Subject: [PATCH v2 05/10] spi: bcm2835: Drop dma_pending flag
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The BCM2835 SPI driver uses a flag to keep track of whether a DMA
transfer is in progress.

The flag is used to avoid terminating DMA channels multiple times if a
transfer finishes orderly while simultaneously the SPI core invokes the
->handle_err() callback because the transfer took too long.  However
terminating DMA channels multiple times is perfectly fine, so the flag
is unnecessary for this particular purpose.

The flag is also used to avoid invoking bcm2835_spi_undo_prologue()
multiple times under this race condition.  However multiple *concurrent*
invocations can no longer happen since commit 2527704d8411 ("spi:
bcm2835: Synchronize with callback on DMA termination") because the
->handle_err() callback now uses the _sync() variant when terminating
DMA channels.

The only raison d'être of the flag is therefore that
bcm2835_spi_undo_prologue() cannot cope with multiple *sequential*
invocations.  Achieve that by setting tx_prologue to 0 at the end of
the function.  Subsequent invocations thus become no-ops.

With that, the dma_pending flag becomes unnecessary, so drop it.

Tested-by: Nuno Sá <nuno.sa@analog.com>
Tested-by: Noralf Trønnes <noralf@tronnes.org>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Acked-by: Stefan Wahren <wahrenst@gmx.net>
Acked-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/spi/spi-bcm2835.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index f79f04ea42e5..532c58bcfd45 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -94,7 +94,6 @@ MODULE_PARM_DESC(polling_limit_us,
  * @rx_prologue: bytes received without DMA if first RX sglist entry's
  *	length is not a multiple of 4 (to overcome hardware limitation)
  * @tx_spillover: whether @tx_prologue spills over to second TX sglist entry
- * @dma_pending: whether a DMA transfer is in progress
  * @debugfs_dir: the debugfs directory - neede to remove debugfs when
  *      unloading the module
  * @count_transfer_polling: count of how often polling mode is used
@@ -117,7 +116,6 @@ struct bcm2835_spi {
 	int tx_prologue;
 	int rx_prologue;
 	unsigned int tx_spillover;
-	unsigned int dma_pending;
 
 	struct dentry *debugfs_dir;
 	u64 count_transfer_polling;
@@ -551,6 +549,8 @@ static void bcm2835_spi_undo_prologue(struct bcm2835_spi *bs)
 		sg_dma_address(&tfr->tx_sg.sgl[1]) -= 4;
 		sg_dma_len(&tfr->tx_sg.sgl[1])     += 4;
 	}
+
+	bs->tx_prologue = 0;
 }
 
 static void bcm2835_spi_dma_done(void *data)
@@ -566,10 +566,8 @@ static void bcm2835_spi_dma_done(void *data)
 	 * is called the tx-dma must have finished - can't get to this
 	 * situation otherwise...
 	 */
-	if (cmpxchg(&bs->dma_pending, true, false)) {
-		dmaengine_terminate_async(ctlr->dma_tx);
-		bcm2835_spi_undo_prologue(bs);
-	}
+	dmaengine_terminate_async(ctlr->dma_tx);
+	bcm2835_spi_undo_prologue(bs);
 
 	/* and mark as completed */;
 	complete(&ctlr->xfer_completion);
@@ -644,9 +642,6 @@ static int bcm2835_spi_transfer_one_dma(struct spi_controller *ctlr,
 	/* start TX early */
 	dma_async_issue_pending(ctlr->dma_tx);
 
-	/* mark as dma pending */
-	bs->dma_pending = 1;
-
 	/* set the DMA length */
 	bcm2835_wr(bs, BCM2835_SPI_DLEN, bs->tx_len);
 
@@ -662,7 +657,6 @@ static int bcm2835_spi_transfer_one_dma(struct spi_controller *ctlr,
 	if (ret) {
 		/* need to reset on errors */
 		dmaengine_terminate_sync(ctlr->dma_tx);
-		bs->dma_pending = false;
 		goto err_reset_hw;
 	}
 
@@ -927,11 +921,10 @@ static void bcm2835_spi_handle_err(struct spi_controller *ctlr,
 	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
 
 	/* if an error occurred and we have an active dma, then terminate */
-	if (cmpxchg(&bs->dma_pending, true, false)) {
-		dmaengine_terminate_sync(ctlr->dma_tx);
-		dmaengine_terminate_sync(ctlr->dma_rx);
-		bcm2835_spi_undo_prologue(bs);
-	}
+	dmaengine_terminate_sync(ctlr->dma_tx);
+	dmaengine_terminate_sync(ctlr->dma_rx);
+	bcm2835_spi_undo_prologue(bs);
+
 	/* and reset */
 	bcm2835_spi_reset_hw(ctlr);
 }
-- 
2.23.0

