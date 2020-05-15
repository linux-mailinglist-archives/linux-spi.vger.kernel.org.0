Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68FC1D5570
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 18:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgEOQCV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 12:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726246AbgEOQCV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 May 2020 12:02:21 -0400
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ee9:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4B1C061A0C
        for <linux-spi@vger.kernel.org>; Fri, 15 May 2020 09:02:20 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id B3168102EDAE9;
        Fri, 15 May 2020 18:02:18 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 7AA466029E64;
        Fri, 15 May 2020 18:02:18 +0200 (CEST)
X-Mailbox-Line: From ac79f1e3d6fd9a1f5e0cb4008c43b98ea70be3c2 Mon Sep 17 00:00:00 2001
Message-Id: <ac79f1e3d6fd9a1f5e0cb4008c43b98ea70be3c2.1589557526.git.lukas@wunner.de>
In-Reply-To: <cover.1589557526.git.lukas@wunner.de>
References: <cover.1589557526.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 15 May 2020 17:58:04 +0200
Subject: [PATCH 4/5] spi: bcm2835: Tear down DMA before turning off SPI
 controller
To:     Mark Brown <broonie@kernel.org>
Cc:     "Nicolas Saenz Julienne" <nsaenzjulienne@suse.de>,
        Martin Sperl <kernel@martin.sperl.org>,
        linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On unbind of the BCM2835 SPI driver, the SPI controller is disabled
first and the DMA channels are terminated and torn down afterwards.

This seems backwards:  In the theoretical case that DMA is active,
it might try to fill the SPI FIFOs even after the controller has
been disabled.

Reverse the order, thereby mirroring what's done on ->probe().

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/spi/spi-bcm2835.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 06d2782d38ec..20d8581fdf88 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1380,14 +1380,14 @@ static int bcm2835_spi_remove(struct platform_device *pdev)
 
 	spi_unregister_controller(ctlr);
 
+	bcm2835_dma_release(ctlr, bs);
+
 	/* Clear FIFOs, and disable the HW block */
 	bcm2835_wr(bs, BCM2835_SPI_CS,
 		   BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX);
 
 	clk_disable_unprepare(bs->clk);
 
-	bcm2835_dma_release(ctlr, bs);
-
 	return 0;
 }
 
-- 
2.26.2

