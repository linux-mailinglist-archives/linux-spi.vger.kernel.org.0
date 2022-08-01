Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840B85870D6
	for <lists+linux-spi@lfdr.de>; Mon,  1 Aug 2022 21:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbiHATD7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Aug 2022 15:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbiHATDY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 1 Aug 2022 15:03:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFFC39B8F;
        Mon,  1 Aug 2022 12:02:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37B4FB81647;
        Mon,  1 Aug 2022 19:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54541C433D7;
        Mon,  1 Aug 2022 19:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659380573;
        bh=PYfW4qUNcV0ql8wYHgPWd/Nrk4am9nAFnFvDd23OFxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ejLVUnnOKEVC5jPibvjUHB63sON3CuE7lbJmdDYnPoBdiK2M6oloRHOk/ZtSDN4Y2
         0jRQ+m6B4FodsXresVGajUQCI7dgUZUMsdasbn+bIf5EQMejjF0MxWu5cU3107KIgs
         io4FvlxyZEe0WeHTuyXtF0Wt2FMYCkOwTB4BpM17pu9eI8biVMomMGQ87tD8Y/Wvp+
         5hRcTbzGU0BFXkwwtOzqnbfKdFRoKd2CEwZZdNKvk+KVHEgZk+DrK9Fjumvhw2cRw0
         ZBiagHduiVTq/+m8JWNO8TZdUOIvJoxLV/KmuI4pGK+pPZnGRFwSbvgSrjzfnfckvO
         IweUieLEstMSQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 4/8] spi: spi-rspi: Fix PIO fallback on RZ platforms
Date:   Mon,  1 Aug 2022 15:02:39 -0400
Message-Id: <20220801190243.3818811-4-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220801190243.3818811-1-sashal@kernel.org>
References: <20220801190243.3818811-1-sashal@kernel.org>
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
index d575c935e9f0..f634a405382c 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -612,6 +612,10 @@ static int rspi_dma_transfer(struct rspi_data *rspi, struct sg_table *tx,
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

