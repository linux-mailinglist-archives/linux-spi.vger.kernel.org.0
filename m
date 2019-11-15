Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1F5EFDD8B
	for <lists+linux-spi@lfdr.de>; Fri, 15 Nov 2019 13:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfKOMZh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 Nov 2019 07:25:37 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33738 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbfKOMZg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 Nov 2019 07:25:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=kyNPL9BTT9yQcgUAvfrPqLzEhAgkeo4CS7uU8kJl5W0=; b=jpFGFZ0NG7To
        KqRlr7C3kgh3xxpTdqnih45/Z09V4wtjawyZw9Y85at+Akx3qRFDN52eydsWrTjBG/H02cHAFpAPZ
        nwkgRWIM8NrgR19ZUcXJqSA0rY+mWV2CbTQU9W6+W0mKB3pmKRm/i3VoefTfFYs2WEIExlEHLdINN
        YJK/0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iVaf6-0000MD-Gf; Fri, 15 Nov 2019 12:25:16 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 02B9127415A7; Fri, 15 Nov 2019 12:25:15 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     agross@kernel.org, alexandre.belloni@bootlin.com, andi@etezian.org,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        jonathanh@nvidia.com, kgene@kernel.org, krzk@kernel.org,
        ldewangan@nvidia.com, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, radu_nicolae.pirea@upb.ro,
        s.hauer@pengutronix.de, shawnguo@kernel.org,
        thierry.reding@gmail.com, vkoul@kernel.org
Subject: Applied "spi: imx: Use dma_request_chan() directly for channel request" to the spi tree
In-Reply-To: <20191113094256.1108-5-peter.ujfalusi@ti.com>
X-Patchwork-Hint: ignore
Message-Id: <20191115122516.02B9127415A7@ypsilon.sirena.org.uk>
Date:   Fri, 15 Nov 2019 12:25:15 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: imx: Use dma_request_chan() directly for channel request

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

From 5d3aa9ccf40cdc9b94d1a708d11de9062e2d9eed Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Wed, 13 Nov 2019 11:42:51 +0200
Subject: [PATCH] spi: imx: Use dma_request_chan() directly for channel request

dma_request_slave_channel_reason() is:
#define dma_request_slave_channel_reason(dev, name) \
	dma_request_chan(dev, name)

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/20191113094256.1108-5-peter.ujfalusi@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 09c9a1edb2c6..49f0099db0cb 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1272,7 +1272,7 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 	spi_imx->wml = spi_imx->devtype_data->fifo_size / 2;
 
 	/* Prepare for TX DMA: */
-	master->dma_tx = dma_request_slave_channel_reason(dev, "tx");
+	master->dma_tx = dma_request_chan(dev, "tx");
 	if (IS_ERR(master->dma_tx)) {
 		ret = PTR_ERR(master->dma_tx);
 		dev_dbg(dev, "can't get the TX DMA channel, error %d!\n", ret);
@@ -1281,7 +1281,7 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 	}
 
 	/* Prepare for RX : */
-	master->dma_rx = dma_request_slave_channel_reason(dev, "rx");
+	master->dma_rx = dma_request_chan(dev, "rx");
 	if (IS_ERR(master->dma_rx)) {
 		ret = PTR_ERR(master->dma_rx);
 		dev_dbg(dev, "can't get the RX DMA channel, error %d\n", ret);
-- 
2.20.1

