Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94BC31760D
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2019 12:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfEHKeS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 May 2019 06:34:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59364 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfEHKeS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 May 2019 06:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=5XX6yQwWLlHH3i6hXnK8Nh0JB85+4JdaLeEd/oN5bak=; b=Ryv6B6KJvKip
        Yr6+OPtL0vJu1hWewaMYdus0SKmvm9gLodp3sqYolTMw+a28cOU22u1q5wCkHDIpeZCfwqpP/asaI
        42Ii1ED1Xe10k482gZn4rYmBeeagDH2LPGd3hL4ay1WvQwfnWlH/76mcqs+u0AUAhVvBFCy1bWEaC
        AbVfE=;
Received: from [61.199.190.11] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOJto-0007t9-RK; Wed, 08 May 2019 10:34:09 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 5C7EB440010; Wed,  8 May 2019 11:33:58 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Vicente Bergas <vicencb@gmail.com>
Subject: Applied "spi: rockchip: turn down tx dma bursts" to the spi tree
In-Reply-To:  <20190412105320.2924-1-kernel@esmil.dk>
X-Patchwork-Hint: ignore
Message-Id: <20190508103358.5C7EB440010@finisterre.sirena.org.uk>
Date:   Wed,  8 May 2019 11:33:58 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: rockchip: turn down tx dma bursts

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 47300728fb213486a830565d2af49da967c9d16a Mon Sep 17 00:00:00 2001
From: Emil Renner Berthing <kernel@esmil.dk>
Date: Fri, 12 Apr 2019 12:53:20 +0200
Subject: [PATCH] spi: rockchip: turn down tx dma bursts

This fixes tx and bi-directional dma transfers on rk3399-gru-kevin.

It seems the SPI fifo must have room for 2 bursts when the dma_tx_req
signal is generated or it might skip some words. This in turn makes
the rx dma channel never complete for bi-directional transfers.

Fix it by setting tx burst length to fifo_len / 4 and the dma
watermark to fifo_len / 2.

However the rk3399 TRM says (sic):
"DMAC support incrementing-address burst and fixed-address burst. But in
the case of access SPI and UART at byte or halfword size, DMAC only
support fixed-address burst and the address must be aligned to word."

So this relies on fifo_len being a multiple of 16 such that the
burst length (= fifo_len / 4) is a multiple of 4 and the addresses
will be word-aligned.

Fixes: dcfc861d24ec ("spi: rockchip: adjust dma watermark and burstlen")
Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rockchip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 3912526ead66..19f6a76f1c07 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -425,7 +425,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
 			.direction = DMA_MEM_TO_DEV,
 			.dst_addr = rs->dma_addr_tx,
 			.dst_addr_width = rs->n_bytes,
-			.dst_maxburst = rs->fifo_len / 2,
+			.dst_maxburst = rs->fifo_len / 4,
 		};
 
 		dmaengine_slave_config(master->dma_tx, &txconf);
@@ -526,7 +526,7 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 	else
 		writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_RXFTLR);
 
-	writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_DMATDLR);
+	writel_relaxed(rs->fifo_len / 2, rs->regs + ROCKCHIP_SPI_DMATDLR);
 	writel_relaxed(0, rs->regs + ROCKCHIP_SPI_DMARDLR);
 	writel_relaxed(dmacr, rs->regs + ROCKCHIP_SPI_DMACR);
 
-- 
2.20.1

