Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB79412F4B
	for <lists+linux-spi@lfdr.de>; Tue, 21 Sep 2021 09:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhIUHXU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Sep 2021 03:23:20 -0400
Received: from mail.bytesnap.co.uk ([94.198.185.106]:27896 "EHLO
        exch2016.bytesnap.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230157AbhIUHXT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Sep 2021 03:23:19 -0400
Received: from villeb-dev.ByteSnap.local ([10.0.27.55])
        by exch2016.bytesnap.co.uk
        with XWall v3.57 ;
        Tue, 21 Sep 2021 08:21:50 +0100
From:   Ville Baillie <villeb@bytesnap.co.uk>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     Ville Baillie <villeb@bytesnap.co.uk>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] spi: atmel: Fix PDC transfer setup bug
Date:   Tue, 21 Sep 2021 07:21:32 +0000
Message-Id: <20210921072132.21831-1-villeb@bytesnap.co.uk>
X-Mailer: git-send-email 2.17.1
X-XWALL-BCKS: auto
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Commit 5fa5e6dec762 ("spi: atmel: Switch to transfer_one transfer
method") refactored the code and changed a conditional causing
atmel_spi_dma_map_xfer to never be called in PDC mode. This causes the
driver to silently fail.

This patch changes the conditional to match the behaviour of the
previous commit before the refactor.

Signed-off-by: Ville Baillie <villeb@bytesnap.co.uk>
---
 drivers/spi/spi-atmel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 788dcdf25f00..f872cf196c2f 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1301,7 +1301,7 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 	 * DMA map early, for performance (empties dcache ASAP) and
 	 * better fault reporting.
 	 */
-	if ((!master->cur_msg_mapped)
+	if ((!master->cur_msg->is_dma_mapped)
 		&& as->use_pdc) {
 		if (atmel_spi_dma_map_xfer(as, xfer) < 0)
 			return -ENOMEM;
@@ -1381,7 +1381,7 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 		}
 	}
 
-	if (!master->cur_msg_mapped
+	if (!master->cur_msg->is_dma_mapped
 		&& as->use_pdc)
 		atmel_spi_dma_unmap_xfer(master, xfer);
 
-- 
2.17.1

