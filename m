Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B42B9AFAB8
	for <lists+linux-spi@lfdr.de>; Wed, 11 Sep 2019 12:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfIKKqV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Sep 2019 06:46:21 -0400
Received: from mailout2.hostsharing.net ([83.223.78.233]:36793 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfIKKqV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Sep 2019 06:46:21 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 879E610189E05;
        Wed, 11 Sep 2019 12:46:19 +0200 (CEST)
Received: from localhost (p57BD772B.dip0.t-ipconnect.de [87.189.119.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 46F696138D2F;
        Wed, 11 Sep 2019 12:46:19 +0200 (CEST)
X-Mailbox-Line: From 7ceb98f154cdcf72c577615fa312df41adea5f47 Mon Sep 17 00:00:00 2001
Message-Id: <7ceb98f154cdcf72c577615fa312df41adea5f47.1568187525.git.lukas@wunner.de>
In-Reply-To: <cover.1568187525.git.lukas@wunner.de>
References: <cover.1568187525.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Wed, 11 Sep 2019 12:15:30 +0200
Subject: [PATCH v2 04/10] spi: bcm2835: Work around DONE bit erratum
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Commit 3bd7f6589f67 ("spi: bcm2835: Overcome sglist entry length
limitation") amended the BCM2835 SPI driver with support for DMA
transfers whose buffers are not aligned to 4 bytes and require more than
one sglist entry.

When testing this feature with upcoming commits to speed up TX-only and
RX-only transfers, I noticed that SPI transmission sometimes breaks.
A function introduced by the commit, bcm2835_spi_transfer_prologue(),
performs one or two PIO transmissions as a prologue to the actual DMA
transmission.  It turns out that the breakage goes away if the DONE bit
in the CS register is set when ending such a PIO transmission.

The DONE bit signifies emptiness of the TX FIFO.  According to the spec,
the bit is of type RO, so writing it should never have any effect.
Perhaps the spec is wrong and the bit is actually of type RW1C.
E.g. the I2C controller on the BCM2835 does have an RW1C DONE bit which
needs to be cleared by the driver.  Another, possibly more likely
explanation is that it's a hardware erratum since the issue does not
occur consistently.

Either way, amend bcm2835_spi_transfer_prologue() to always write the
DONE bit.

Usually a transmission is ended by bcm2835_spi_reset_hw().  If the
transmission was successful, the TX FIFO is empty and thus the DONE bit
is set when bcm2835_spi_reset_hw() reads the CS register.  The bit is
then written back to the register, so we happen to do the right thing.

However if DONE is not set, e.g. because transmission is aborted with
a non-empty TX FIFO, the bit won't be written by bcm2835_spi_reset_hw()
and it seems possible that transmission might subsequently break.  To be
on the safe side, likewise amend bcm2835_spi_reset_hw() to always write
the bit.

Tested-by: Nuno Sá <nuno.sa@analog.com>
Tested-by: Noralf Trønnes <noralf@tronnes.org>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Acked-by: Stefan Wahren <wahrenst@gmx.net>
Acked-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/spi/spi-bcm2835.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index fbd6d1ae4c5e..f79f04ea42e5 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -321,6 +321,13 @@ static void bcm2835_spi_reset_hw(struct spi_controller *ctlr)
 		BCM2835_SPI_CS_INTD |
 		BCM2835_SPI_CS_DMAEN |
 		BCM2835_SPI_CS_TA);
+	/*
+	 * Transmission sometimes breaks unless the DONE bit is written at the
+	 * end of every transfer.  The spec says it's a RO bit.  Either the
+	 * spec is wrong and the bit is actually of type RW1C, or it's a
+	 * hardware erratum.
+	 */
+	cs |= BCM2835_SPI_CS_DONE;
 	/* and reset RX/TX FIFOS */
 	cs |= BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX;
 
@@ -479,7 +486,9 @@ static void bcm2835_spi_transfer_prologue(struct spi_controller *ctlr,
 		bcm2835_wr_fifo_count(bs, bs->rx_prologue);
 		bcm2835_wait_tx_fifo_empty(bs);
 		bcm2835_rd_fifo_count(bs, bs->rx_prologue);
-		bcm2835_spi_reset_hw(ctlr);
+		bcm2835_wr(bs, BCM2835_SPI_CS, cs | BCM2835_SPI_CS_CLEAR_RX
+						  | BCM2835_SPI_CS_CLEAR_TX
+						  | BCM2835_SPI_CS_DONE);
 
 		dma_sync_single_for_device(ctlr->dma_rx->device->dev,
 					   sg_dma_address(&tfr->rx_sg.sgl[0]),
@@ -500,7 +509,8 @@ static void bcm2835_spi_transfer_prologue(struct spi_controller *ctlr,
 						  | BCM2835_SPI_CS_DMAEN);
 		bcm2835_wr_fifo_count(bs, tx_remaining);
 		bcm2835_wait_tx_fifo_empty(bs);
-		bcm2835_wr(bs, BCM2835_SPI_CS, cs | BCM2835_SPI_CS_CLEAR_TX);
+		bcm2835_wr(bs, BCM2835_SPI_CS, cs | BCM2835_SPI_CS_CLEAR_TX
+						  | BCM2835_SPI_CS_DONE);
 	}
 
 	if (likely(!bs->tx_spillover)) {
-- 
2.23.0

