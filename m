Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D9257940E
	for <lists+linux-spi@lfdr.de>; Tue, 19 Jul 2022 09:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbiGSHW5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 Jul 2022 03:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235378AbiGSHW4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 Jul 2022 03:22:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A0225C6D
        for <linux-spi@vger.kernel.org>; Tue, 19 Jul 2022 00:22:55 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oDhZG-0006M1-6S
        for linux-spi@vger.kernel.org; Tue, 19 Jul 2022 09:22:54 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 954C9B3C99
        for <linux-spi@vger.kernel.org>; Tue, 19 Jul 2022 07:22:53 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 8090DB3C96;
        Tue, 19 Jul 2022 07:22:52 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 464f640c;
        Tue, 19 Jul 2022 07:22:50 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-spi@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH] spi: bcm2835: bcm2835_spi_handle_err(): fix NULL pointer deref for non DMA transfers
Date:   Tue, 19 Jul 2022 09:22:35 +0200
Message-Id: <20220719072234.2782764-1-mkl@pengutronix.de>
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
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
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
-- 
2.35.1


