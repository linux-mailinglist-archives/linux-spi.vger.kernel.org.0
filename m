Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47F8538206
	for <lists+linux-spi@lfdr.de>; Mon, 30 May 2022 16:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237613AbiE3OVe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 30 May 2022 10:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241178AbiE3ORU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 30 May 2022 10:17:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043761146BC;
        Mon, 30 May 2022 06:44:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C871B80D83;
        Mon, 30 May 2022 13:44:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782DDC36AE5;
        Mon, 30 May 2022 13:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653918284;
        bh=irNiHLPnjDX5xM02HqZO7BlPyD+MMDTayUwBSi+oCtk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kmiEZ/UL2yfwSm8616iKA5kxgnBTYKyCnk7QT+hgvotaV3QKdPWauGIZl3z++D6Br
         RM+UD/P0G0RF763r+yULFmdz9j3PAZf9KxJ9Ilpjb9XeSIExJ/4JFvo97GCTrE9/IU
         rl4ssvaF7b/mtpvjR0lmqz5qtM6u+q0vM20UEqiBD2BDxy9acuPdvAMbZ5UM/wiiPo
         ceGJL6gdRrKoiBjxvQB/1xozCqpeW5jJJCJL6FctjEYfy9Ap8geByeJ/AslLNuSHCc
         sJ4XUx/mFW5ALkMZ0jTMB+GjHlUs1z5MqyGvqdHa90d0Q7knig126p4LCS0iBMGDYq
         BzRyaVGSG6VXQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 17/76] spi: spi-rspi: Remove setting {src,dst}_{addr,addr_width} based on DMA direction
Date:   Mon, 30 May 2022 09:43:07 -0400
Message-Id: <20220530134406.1934928-17-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220530134406.1934928-1-sashal@kernel.org>
References: <20220530134406.1934928-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 6f381481a5b236cb53d6de2c49c6ef83a4d0f432 ]

The direction field in the DMA config is deprecated. The rspi driver
sets {src,dst}_{addr,addr_width} based on the DMA direction and
it results in dmaengine_slave_config() failure as RZ DMAC driver
validates {src,dst}_addr_width values independent of DMA direction.

This patch fixes the issue by passing both {src,dst}_{addr,addr_width}
values independent of DMA direction.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Suggested-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20220411173115.6619-1-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-rspi.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index e39fd38f5180..ea03cc589e61 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1107,14 +1107,11 @@ static struct dma_chan *rspi_request_dma_chan(struct device *dev,
 	}
 
 	memset(&cfg, 0, sizeof(cfg));
+	cfg.dst_addr = port_addr + RSPI_SPDR;
+	cfg.src_addr = port_addr + RSPI_SPDR;
+	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
 	cfg.direction = dir;
-	if (dir == DMA_MEM_TO_DEV) {
-		cfg.dst_addr = port_addr;
-		cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
-	} else {
-		cfg.src_addr = port_addr;
-		cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
-	}
 
 	ret = dmaengine_slave_config(chan, &cfg);
 	if (ret) {
@@ -1145,12 +1142,12 @@ static int rspi_request_dma(struct device *dev, struct spi_controller *ctlr,
 	}
 
 	ctlr->dma_tx = rspi_request_dma_chan(dev, DMA_MEM_TO_DEV, dma_tx_id,
-					     res->start + RSPI_SPDR);
+					     res->start);
 	if (!ctlr->dma_tx)
 		return -ENODEV;
 
 	ctlr->dma_rx = rspi_request_dma_chan(dev, DMA_DEV_TO_MEM, dma_rx_id,
-					     res->start + RSPI_SPDR);
+					     res->start);
 	if (!ctlr->dma_rx) {
 		dma_release_channel(ctlr->dma_tx);
 		ctlr->dma_tx = NULL;
-- 
2.35.1

