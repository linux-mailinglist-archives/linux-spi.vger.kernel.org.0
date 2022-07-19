Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D1857A259
	for <lists+linux-spi@lfdr.de>; Tue, 19 Jul 2022 16:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235040AbiGSOtn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 Jul 2022 10:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239452AbiGSOtR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 Jul 2022 10:49:17 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C2BEEAC;
        Tue, 19 Jul 2022 07:49:16 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.92,284,1650898800"; 
   d="scan'208";a="126656675"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 19 Jul 2022 23:49:16 +0900
Received: from localhost.localdomain (unknown [10.226.92.160])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 27854400C4DD;
        Tue, 19 Jul 2022 23:49:12 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-spi@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 2/2] spi: spi-rspi: Add need_dmar_clr to spi_ops
Date:   Tue, 19 Jul 2022 15:49:06 +0100
Message-Id: <20220719144906.382548-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220719144906.382548-1-biju.das.jz@bp.renesas.com>
References: <20220719144906.382548-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

RSPI IP on RZ/{A, G2L} SoC's has the same signal for both interrupt and
DMA transfer request. Setting DMARS register for DMA transfer
makes the signal to work as a DMA transfer request signal and
subsequent interrupt requests to the interrupt controller
are masked.

Currently, DMA to interrupt mode switching does not work because of this
masking.

This patch adds need_dmar_clr device configuration flag to spi_ops
and it makes the signal to work as an interrupt request by clearing
DMARS after DMA callback.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/spi/spi-rspi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 7a014eeec2d0..8637be53bb8d 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -249,6 +249,7 @@ struct spi_ops {
 	u16 flags;
 	u16 fifo_size;
 	u8 num_hw_ss;
+	bool need_dmar_clr;
 };
 
 static void rspi_set_rate(struct rspi_data *rspi)
@@ -613,6 +614,12 @@ static int rspi_dma_transfer(struct rspi_data *rspi, struct sg_table *tx,
 					       rspi->dma_callbacked, HZ);
 	if (ret > 0 && rspi->dma_callbacked) {
 		ret = 0;
+		if (need_dmar_clr) {
+			if (tx)
+				dmaengine_synchronize(rspi->ctlr->dma_tx);
+			if (rx)
+				dmaengine_synchronize(rspi->ctlr->dma_rx);
+		}
 	} else {
 		if (!ret) {
 			dev_err(&rspi->ctlr->dev, "DMA timeout\n");
@@ -1196,6 +1203,7 @@ static const struct spi_ops rspi_rz_ops = {
 	.flags =		SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX,
 	.fifo_size =		8,	/* 8 for TX, 32 for RX */
 	.num_hw_ss =		1,
+	.need_dmar_clr =	true,
 };
 
 static const struct spi_ops qspi_ops = {
-- 
2.25.1

