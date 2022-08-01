Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E385870BB
	for <lists+linux-spi@lfdr.de>; Mon,  1 Aug 2022 21:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbiHATCt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Aug 2022 15:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbiHATCi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 1 Aug 2022 15:02:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804162FFFE;
        Mon,  1 Aug 2022 12:02:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27419B81629;
        Mon,  1 Aug 2022 19:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2564EC433D7;
        Mon,  1 Aug 2022 19:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659380553;
        bh=DnYtPbjqI8A7s1DpXgqq9UjiYSjr7NuAbLDSButeqbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=boKslA5vqRuQ5Z0JYsQ/D8t0LHmiRTAN424PQx9ptIv5XyOHdiCuDE5Jfnp9AQqRm
         PbmPB4WX6ahPUkGBmTSdSyoqhLhKEPx4rJj2W841vjCQVB2mk6EbMpwKmzlCeoMZ74
         90moez1bkSXdxstvUI+GQ7kU36pix3fJeqCbK5N4PIyHkxbyXULVlVG+jnFoVSesPP
         XutcxH6fe9Swc1KRK3LFhc7lCBjYbUN3vHOHfEmiTUuTQf+gYTc3+uJrtDt7SXTDbA
         wAPBo82jLdGY4t0Q8etNQsLR/EhOdBmIRjNK4UJmk1lGxY+WuFBj34sSiyaWCTo7vr
         OsciX+qAMxGow==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.18 05/10] spi: spi-rspi: Fix PIO fallback on RZ platforms
Date:   Mon,  1 Aug 2022 15:02:17 -0400
Message-Id: <20220801190222.3818378-5-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220801190222.3818378-1-sashal@kernel.org>
References: <20220801190222.3818378-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit b620aa3a7be346f04ae7789b165937615c6ee8d3 ]

RSPI IP on RZ/{A, G2L} SoC's has the same signal for both interrupt
and DMA transfer request. Setting DMARS register for DMA transfer
makes the signal to work as a DMA transfer request signal and
subsequent interrupt requests to the interrupt controller
are masked.

PIO fallback does not work as interrupt signal is disabled.

This patch fixes this issue by re-enabling the interrupts by
calling dmaengine_synchronize().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20220721143449.879257-1-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.35.1

