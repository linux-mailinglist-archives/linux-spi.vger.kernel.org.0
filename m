Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D78851204D9
	for <lists+linux-spi@lfdr.de>; Mon, 16 Dec 2019 13:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfLPMGL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Dec 2019 07:06:11 -0500
Received: from foss.arm.com ([217.140.110.172]:52522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727385AbfLPMGJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 16 Dec 2019 07:06:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D1641FB;
        Mon, 16 Dec 2019 04:06:09 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38A773F719;
        Mon, 16 Dec 2019 04:06:08 -0800 (PST)
Date:   Mon, 16 Dec 2019 12:06:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     alexandre.torgue@st.com, baohua@kernel.org, broonie@kernel.org,
        f.fainelli@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>, mcoquelin.stm32@gmail.com,
        nsaenzjulienne@suse.de, rjui@broadcom.com, sbranden@broadcom.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org, vkoul@kernel.org
Subject: Applied "spi: sirf: Use dma_request_chan() instead dma_request_slave_channel()" to the spi tree
In-Reply-To: <20191212135550.4634-7-peter.ujfalusi@ti.com>
Message-Id: <applied-20191212135550.4634-7-peter.ujfalusi@ti.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: sirf: Use dma_request_chan() instead dma_request_slave_channel()

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.6

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

From 401abb764abb6e42f539528e02127457eb0c5b32 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 12 Dec 2019 15:55:47 +0200
Subject: [PATCH] spi: sirf: Use dma_request_chan() instead
 dma_request_slave_channel()

dma_request_slave_channel() is a wrapper on top of dma_request_chan()
eating up the error code.

By using dma_request_chan() directly the driver can support deferred
probing against DMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/20191212135550.4634-7-peter.ujfalusi@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sirf.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index e1e639191557..8419e6722e17 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -1126,16 +1126,16 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 	sspi->bitbang.master->dev.of_node = pdev->dev.of_node;
 
 	/* request DMA channels */
-	sspi->rx_chan = dma_request_slave_channel(&pdev->dev, "rx");
-	if (!sspi->rx_chan) {
+	sspi->rx_chan = dma_request_chan(&pdev->dev, "rx");
+	if (IS_ERR(sspi->rx_chan)) {
 		dev_err(&pdev->dev, "can not allocate rx dma channel\n");
-		ret = -ENODEV;
+		ret = PTR_ERR(sspi->rx_chan);
 		goto free_master;
 	}
-	sspi->tx_chan = dma_request_slave_channel(&pdev->dev, "tx");
-	if (!sspi->tx_chan) {
+	sspi->tx_chan = dma_request_chan(&pdev->dev, "tx");
+	if (IS_ERR(sspi->tx_chan)) {
 		dev_err(&pdev->dev, "can not allocate tx dma channel\n");
-		ret = -ENODEV;
+		ret = PTR_ERR(sspi->tx_chan);
 		goto free_rx_dma;
 	}
 
-- 
2.20.1

