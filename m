Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF03E57CDC0
	for <lists+linux-spi@lfdr.de>; Thu, 21 Jul 2022 16:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiGUOe7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 Jul 2022 10:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiGUOe7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 Jul 2022 10:34:59 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70A5C85D56;
        Thu, 21 Jul 2022 07:34:56 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,289,1654527600"; 
   d="scan'208";a="126919306"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 21 Jul 2022 23:34:55 +0900
Received: from localhost.localdomain (unknown [10.226.92.81])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id BE0364001B66;
        Thu, 21 Jul 2022 23:34:52 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-spi@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3] spi: spi-rspi: Fix PIO fallback on RZ platforms
Date:   Thu, 21 Jul 2022 15:34:49 +0100
Message-Id: <20220721143449.879257-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

RSPI IP on RZ/{A, G2L} SoC's has the same signal for both interrupt
and DMA transfer request. Setting DMARS register for DMA transfer
makes the signal to work as a DMA transfer request signal and
subsequent interrupt requests to the interrupt controller
are masked.

PIO fallback does not work as interrupt signal is disabled.

This patch fixes this issue by re-enabling the interrupts by
calling dmaengine_synchronize().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * dmaengine_synchronize() called unconditionally and removed need_dmar_clr.
v1->v2:
 * Fixed the typo need_dmar_clr->rspi->ops->need_dmar_clr.
---
 drivers/spi/spi-rspi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 7a014eeec2d0..411b1307b7fd 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -613,6 +613,10 @@ static int rspi_dma_transfer(struct rspi_data *rspi, struct sg_table *tx,
 					       rspi->dma_callbacked, HZ);
 	if (ret > 0 && rspi->dma_callbacked) {
 		ret = 0;
+		if (tx)
+			dmaengine_synchronize(rspi->ctlr->dma_tx);
+		if (rx)
+			dmaengine_synchronize(rspi->ctlr->dma_rx);
 	} else {
 		if (!ret) {
 			dev_err(&rspi->ctlr->dev, "DMA timeout\n");
-- 
2.25.1

