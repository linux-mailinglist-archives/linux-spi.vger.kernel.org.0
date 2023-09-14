Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1135579F7AD
	for <lists+linux-spi@lfdr.de>; Thu, 14 Sep 2023 04:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjINCLv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Sep 2023 22:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjINBzz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Sep 2023 21:55:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F481FF9;
        Wed, 13 Sep 2023 18:55:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A5DC433C8;
        Thu, 14 Sep 2023 01:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694656541;
        bh=gXVhJOHHu42wAbkHvrobBuAxMZhcTwxM0j4OPJEY6D0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qG71OHQbCaL+Ti3zHuIzIPYGVRd66+PjwUbFGa3ApuSX6nVQebACo4fUqJs0KEp4Z
         k+SkH3r8R4IK5c+6DmKI0Oy8BkmjmALWRqYHgJIctNuxwnDCCkY9PBfvpq/gxwUuYG
         AiAw1Ko4OfmWKqTy7Z3xvcpEuKiS/wLUa9yQR6HE7Wk9CMcvNbgwDBfi17MVEnnBLd
         vRjI+C2IFMh27iM4FQCDBZCP9krp8XsWFrYpnjIED2Tmbrqpzm+uGHZ44fBRWf+qVc
         6FJJDqOs2x5c1GyaaXM2wNhB9WGfmmP5wVdf7QbqdpHzrYPfaWx0aTMQ6f0uqGSxEF
         B4vsSPIPxQSLA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tobias Schramm <t.schramm@manjaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 2/3] spi: sun6i: reduce DMA RX transfer width to single byte
Date:   Wed, 13 Sep 2023 21:55:35 -0400
Message-Id: <20230914015536.51984-2-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914015536.51984-1-sashal@kernel.org>
References: <20230914015536.51984-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.131
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Tobias Schramm <t.schramm@manjaro.org>

[ Upstream commit 171f8a49f212e87a8b04087568e1b3d132e36a18 ]

Through empirical testing it has been determined that sometimes RX SPI
transfers with DMA enabled return corrupted data. This is down to single
or even multiple bytes lost during DMA transfer from SPI peripheral to
memory. It seems the RX FIFO within the SPI peripheral can become
confused when performing bus read accesses wider than a single byte to it
during an active SPI transfer.

This patch reduces the width of individual DMA read accesses to the
RX FIFO to a single byte to mitigate that issue.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
Link: https://lore.kernel.org/r/20230827152558.5368-2-t.schramm@manjaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-sun6i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 23ad052528dbe..2bfe87873edb3 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -200,7 +200,7 @@ static int sun6i_spi_prepare_dma(struct sun6i_spi *sspi,
 		struct dma_slave_config rxconf = {
 			.direction = DMA_DEV_TO_MEM,
 			.src_addr = sspi->dma_addr_rx,
-			.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
+			.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE,
 			.src_maxburst = 8,
 		};
 
-- 
2.40.1

