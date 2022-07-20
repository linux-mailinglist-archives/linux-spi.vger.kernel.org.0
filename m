Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F140B57B795
	for <lists+linux-spi@lfdr.de>; Wed, 20 Jul 2022 15:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbiGTNeX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Jul 2022 09:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiGTNeW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Jul 2022 09:34:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED57387
        for <linux-spi@vger.kernel.org>; Wed, 20 Jul 2022 06:34:21 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oE9qF-0004tj-Bg
        for linux-spi@vger.kernel.org; Wed, 20 Jul 2022 15:34:19 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id B6048B5EAF
        for <linux-spi@vger.kernel.org>; Wed, 20 Jul 2022 13:34:18 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 57267B5EAA;
        Wed, 20 Jul 2022 13:34:18 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 911f8268;
        Wed, 20 Jul 2022 13:34:17 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-spi@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Lukas Wunner <lukas@wunner.de>,
        Mark Brown <broonie@kernel.org>,
        Jens Lindahl <jensctl@gmail.com>
Subject: [PATCH v2] spi: bcm2835: bcm2835_spi_handle_err(): fix NULL pointer deref for non DMA transfers
Date:   Wed, 20 Jul 2022 15:34:16 +0200
Message-Id: <20220720133416.3342229-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In case a IRQ based transfer times out the bcm2835_spi_handle_err()
function is called. Since commit 1513ceee70f2 ("spi: bcm2835: Drop
dma_pending flag") the TX and RX DMA transfers are unconditionally
canceled, leading to NULL pointer derefs if ctlr->dma_tx or
ctlr->dma_rx are not set.

Fix the NULL pointer deref by checking that ctlr->dma_tx and
ctlr->dma_rx are valid pointers before accessing them.

Fixes: 1513ceee70f2 ("spi: bcm2835: Drop dma_pending flag")
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jens Lindahl <jensctl@gmail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---

Changes Since v1: https://lore.kernel.org/all/20220719072234.2782764-1-mkl@pengutronix.de
- added Mark Brown and Jens Lindahl on Cc

 drivers/spi/spi-bcm2835.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 775c0bf2f923..0933948d7df3 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1138,10 +1138,14 @@ static void bcm2835_spi_handle_err(struct spi_controller *ctlr,
 	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
 
 	/* if an error occurred and we have an active dma, then terminate */
-	dmaengine_terminate_sync(ctlr->dma_tx);
-	bs->tx_dma_active = false;
-	dmaengine_terminate_sync(ctlr->dma_rx);
-	bs->rx_dma_active = false;
+	if (ctlr->dma_tx) {
+		dmaengine_terminate_sync(ctlr->dma_tx);
+		bs->tx_dma_active = false;
+	}
+	if (ctlr->dma_rx) {
+		dmaengine_terminate_sync(ctlr->dma_rx);
+		bs->rx_dma_active = false;
+	}
 	bcm2835_spi_undo_prologue(bs);
 
 	/* and reset */

base-commit: 73d5fe046270281a46344e06bf986c607632f7ea
-- 
2.35.1


