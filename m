Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19EEEAFA99
	for <lists+linux-spi@lfdr.de>; Wed, 11 Sep 2019 12:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfIKKjj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Sep 2019 06:39:39 -0400
Received: from mailout2.hostsharing.net ([83.223.78.233]:34643 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfIKKjj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Sep 2019 06:39:39 -0400
X-Greylist: delayed 325 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Sep 2019 06:39:38 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 7D40610189D0E;
        Wed, 11 Sep 2019 12:39:37 +0200 (CEST)
Received: from localhost (p57BD772B.dip0.t-ipconnect.de [87.189.119.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 3DA656124A10;
        Wed, 11 Sep 2019 12:39:37 +0200 (CEST)
X-Mailbox-Line: From 73cf37be56eb4cbe6f696057c719f3a38cbaf26e Mon Sep 17 00:00:00 2001
Message-Id: <73cf37be56eb4cbe6f696057c719f3a38cbaf26e.1568187525.git.lukas@wunner.de>
In-Reply-To: <cover.1568187525.git.lukas@wunner.de>
References: <cover.1568187525.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Wed, 11 Sep 2019 12:15:30 +0200
Subject: [PATCH v2 02/10] dmaengine: bcm2835: Allow cyclic transactions
 without interrupt
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The BCM2835 DMA driver currently requests an interrupt from the
controller regardless whether or not the client has passed in the
DMA_PREP_INTERRUPT flag. This causes unnecessary overhead for cyclic
transactions which do not need an interrupt after each period.

We're about to add such a use case, namely cyclic clearing of the SPI
controller's RX FIFO, so amend the DMA driver to request an interrupt
only if DMA_PREP_INTERRUPT was passed in. Ignore the period_len for
such transactions and set it to the buffer length to make the driver's
calculations work.

Tested-by: Nuno Sá <nuno.sa@analog.com>
Tested-by: Noralf Trønnes <noralf@tronnes.org>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Acked-by: Vinod Koul <vkoul@kernel.org>
Acked-by: Stefan Wahren <wahrenst@gmx.net>
Acked-by: Martin Sperl <kernel@martin.sperl.org>
Cc: Florian Kauer <florian.kauer@koalo.de>
---
 drivers/dma/bcm2835-dma.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 523c507ad69e..a65514fcb7f2 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -691,7 +691,7 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 	struct bcm2835_desc *d;
 	dma_addr_t src, dst;
 	u32 info = BCM2835_DMA_WAIT_RESP;
-	u32 extra = BCM2835_DMA_INT_EN;
+	u32 extra = 0;
 	size_t max_len = bcm2835_dma_max_frame_length(c);
 	size_t frames;
 
@@ -707,6 +707,11 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 		return NULL;
 	}
 
+	if (flags & DMA_PREP_INTERRUPT)
+		extra |= BCM2835_DMA_INT_EN;
+	else
+		period_len = buf_len;
+
 	/*
 	 * warn if buf_len is not a multiple of period_len - this may leed
 	 * to unexpected latencies for interrupts and thus audiable clicks
@@ -778,7 +783,10 @@ static int bcm2835_dma_terminate_all(struct dma_chan *chan)
 
 	/* stop DMA activity */
 	if (c->desc) {
-		vchan_terminate_vdesc(&c->desc->vd);
+		if (c->desc->vd.tx.flags & DMA_PREP_INTERRUPT)
+			vchan_terminate_vdesc(&c->desc->vd);
+		else
+			vchan_vdesc_fini(&c->desc->vd);
 		c->desc = NULL;
 		bcm2835_dma_abort(c);
 	}
-- 
2.23.0

