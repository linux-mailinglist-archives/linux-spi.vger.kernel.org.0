Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B82A576FEF
	for <lists+linux-spi@lfdr.de>; Sat, 16 Jul 2022 17:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiGPPjm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 16 Jul 2022 11:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPPjl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 16 Jul 2022 11:39:41 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B23F11479;
        Sat, 16 Jul 2022 08:39:40 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.92,277,1650898800"; 
   d="scan'208";a="126373289"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Jul 2022 00:39:39 +0900
Received: from localhost.localdomain (unknown [10.226.92.11])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 30CF340083F7;
        Sun, 17 Jul 2022 00:39:36 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-spi@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] spi: spi-rspi: Add force_dma variable to spi_ops
Date:   Sat, 16 Jul 2022 16:39:34 +0100
Message-Id: <20220716153934.292311-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On RZ/G2L SoCs switching from DMA to interrupt mode, causes timeout
issue as we are not getting Rx interrupt even though SPRF bit is set in
the status register.

But there is no issue if we don't switch between interrupt to DMA mode
or vice versa.

Performance comparison between interrupt and DMA mode on RZ/Five SMARC
platform connected to a display module shows that performance and
CPU utilization is much better with DMA mode compared to interrupt mode
(1->65 fps) and (98->8%).

This patch introduces a variable force_dma to avoid switching between
DMA to interrupt mode for RZ platforms.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/spi/spi-rspi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 7a014eeec2d0..f86b7b53288f 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -249,6 +249,7 @@ struct spi_ops {
 	u16 flags;
 	u16 fifo_size;
 	u8 num_hw_ss;
+	bool force_dma;
 };
 
 static void rspi_set_rate(struct rspi_data *rspi)
@@ -677,7 +678,7 @@ static void qspi_receive_init(const struct rspi_data *rspi)
 static bool __rspi_can_dma(const struct rspi_data *rspi,
 			   const struct spi_transfer *xfer)
 {
-	return xfer->len > rspi->ops->fifo_size;
+	return  rspi->ops->force_dma || (xfer->len > rspi->ops->fifo_size);
 }
 
 static bool rspi_can_dma(struct spi_controller *ctlr, struct spi_device *spi,
@@ -1196,6 +1197,7 @@ static const struct spi_ops rspi_rz_ops = {
 	.flags =		SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX,
 	.fifo_size =		8,	/* 8 for TX, 32 for RX */
 	.num_hw_ss =		1,
+	.force_dma =		true,
 };
 
 static const struct spi_ops qspi_ops = {
-- 
2.25.1

