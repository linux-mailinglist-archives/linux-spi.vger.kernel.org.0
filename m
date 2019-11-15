Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B70FCFDD9F
	for <lists+linux-spi@lfdr.de>; Fri, 15 Nov 2019 13:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfKOM0C (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 Nov 2019 07:26:02 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33488 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfKOMZ3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 Nov 2019 07:25:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=QN4aYBjvPkYWcAEdyVdCD60J+0aOlMsoc1odzZylDvY=; b=HlDYky63BVWE
        xiYEScODyHPKkmDKxC9aQ84WkNBRAde9qVkfxAYoRwTD5rGqehP9jdghXR85TOTcbH2RlotY95xj4
        xLRqZ4guJty9FOhO0IZRRRjd6IDIFIDmoJ9nUXDqrlpqlPwkSHnbu1biwEQF3sgMgQx96Du8U2Zc8
        udpqE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iVaf5-0000Lw-FI; Fri, 15 Nov 2019 12:25:15 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id E3EF42741609; Fri, 15 Nov 2019 12:25:14 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     agross@kernel.org, alexandre.belloni@bootlin.com, andi@etezian.org,
        Andi Shyti <andi@etezian.org>, bjorn.andersson@linaro.org,
        broonie@kernel.org, jonathanh@nvidia.com, kgene@kernel.org,
        krzk@kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        ldewangan@nvidia.com, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, radu_nicolae.pirea@upb.ro,
        s.hauer@pengutronix.de, shawnguo@kernel.org,
        thierry.reding@gmail.com, vkoul@kernel.org
Subject: Applied "spi: s3c64xx: Use dma_request_chan() directly for channel request" to the spi tree
In-Reply-To: <20191113094256.1108-8-peter.ujfalusi@ti.com>
X-Patchwork-Hint: ignore
Message-Id: <20191115122514.E3EF42741609@ypsilon.sirena.org.uk>
Date:   Fri, 15 Nov 2019 12:25:14 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: s3c64xx: Use dma_request_chan() directly for channel request

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

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

From df1b0141788527c032a9851c0589a1712d7e46b8 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Wed, 13 Nov 2019 11:42:54 +0200
Subject: [PATCH] spi: s3c64xx: Use dma_request_chan() directly for channel
 request

dma_request_slave_channel_reason() is:
#define dma_request_slave_channel_reason(dev, name) \
	dma_request_chan(dev, name)

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Andi Shyti <andi@etezian.org>
Link: https://lore.kernel.org/r/20191113094256.1108-8-peter.ujfalusi@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-s3c64xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 7b7151ec14c8..cf67ea60dc0e 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1154,15 +1154,13 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 
 	if (!is_polling(sdd)) {
 		/* Acquire DMA channels */
-		sdd->rx_dma.ch = dma_request_slave_channel_reason(&pdev->dev,
-								  "rx");
+		sdd->rx_dma.ch = dma_request_chan(&pdev->dev, "rx");
 		if (IS_ERR(sdd->rx_dma.ch)) {
 			dev_err(&pdev->dev, "Failed to get RX DMA channel\n");
 			ret = PTR_ERR(sdd->rx_dma.ch);
 			goto err_disable_io_clk;
 		}
-		sdd->tx_dma.ch = dma_request_slave_channel_reason(&pdev->dev,
-								  "tx");
+		sdd->tx_dma.ch = dma_request_chan(&pdev->dev, "tx");
 		if (IS_ERR(sdd->tx_dma.ch)) {
 			dev_err(&pdev->dev, "Failed to get TX DMA channel\n");
 			ret = PTR_ERR(sdd->tx_dma.ch);
-- 
2.20.1

