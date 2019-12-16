Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 271351204B5
	for <lists+linux-spi@lfdr.de>; Mon, 16 Dec 2019 13:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfLPMGB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Dec 2019 07:06:01 -0500
Received: from foss.arm.com ([217.140.110.172]:52456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbfLPMGB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 16 Dec 2019 07:06:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 290FA1FB;
        Mon, 16 Dec 2019 04:06:01 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 779503F719;
        Mon, 16 Dec 2019 04:06:00 -0800 (PST)
Date:   Mon, 16 Dec 2019 12:05:59 +0000
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
Subject: Applied "spi: stm32: Use dma_request_chan() instead dma_request_slave_channel()" to the spi tree
In-Reply-To: <20191212135550.4634-10-peter.ujfalusi@ti.com>
Message-Id: <applied-20191212135550.4634-10-peter.ujfalusi@ti.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: stm32: Use dma_request_chan() instead dma_request_slave_channel()

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

From 0a454258febb73e4c60d7f5d9a02d1a8c64fdfb8 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 12 Dec 2019 15:55:50 +0200
Subject: [PATCH] spi: stm32: Use dma_request_chan() instead
 dma_request_slave_channel()

dma_request_slave_channel() is a wrapper on top of dma_request_chan()
eating up the error code.

By using dma_request_chan() directly the driver can support deferred
probing against DMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/20191212135550.4634-10-peter.ujfalusi@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 7d75632c4151..e041f9c4ec47 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1879,17 +1879,29 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	master->transfer_one = stm32_spi_transfer_one;
 	master->unprepare_message = stm32_spi_unprepare_msg;
 
-	spi->dma_tx = dma_request_slave_channel(spi->dev, "tx");
-	if (!spi->dma_tx)
+	spi->dma_tx = dma_request_chan(spi->dev, "tx");
+	if (IS_ERR(spi->dma_tx)) {
+		ret = PTR_ERR(spi->dma_tx);
+		spi->dma_tx = NULL;
+		if (ret == -EPROBE_DEFER)
+			goto err_clk_disable;
+
 		dev_warn(&pdev->dev, "failed to request tx dma channel\n");
-	else
+	} else {
 		master->dma_tx = spi->dma_tx;
+	}
+
+	spi->dma_rx = dma_request_chan(spi->dev, "rx");
+	if (IS_ERR(spi->dma_rx)) {
+		ret = PTR_ERR(spi->dma_rx);
+		spi->dma_rx = NULL;
+		if (ret == -EPROBE_DEFER)
+			goto err_dma_release;
 
-	spi->dma_rx = dma_request_slave_channel(spi->dev, "rx");
-	if (!spi->dma_rx)
 		dev_warn(&pdev->dev, "failed to request rx dma channel\n");
-	else
+	} else {
 		master->dma_rx = spi->dma_rx;
+	}
 
 	if (spi->dma_tx || spi->dma_rx)
 		master->can_dma = stm32_spi_can_dma;
@@ -1901,26 +1913,26 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "spi master registration failed: %d\n",
 			ret);
-		goto err_dma_release;
+		goto err_pm_disable;
 	}
 
 	if (!master->cs_gpiods) {
 		dev_err(&pdev->dev, "no CS gpios available\n");
 		ret = -EINVAL;
-		goto err_dma_release;
+		goto err_pm_disable;
 	}
 
 	dev_info(&pdev->dev, "driver initialized\n");
 
 	return 0;
 
+err_pm_disable:
+	pm_runtime_disable(&pdev->dev);
 err_dma_release:
 	if (spi->dma_tx)
 		dma_release_channel(spi->dma_tx);
 	if (spi->dma_rx)
 		dma_release_channel(spi->dma_rx);
-
-	pm_runtime_disable(&pdev->dev);
 err_clk_disable:
 	clk_disable_unprepare(spi->clk);
 err_master_put:
-- 
2.20.1

