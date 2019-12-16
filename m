Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 782681204C4
	for <lists+linux-spi@lfdr.de>; Mon, 16 Dec 2019 13:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfLPMGP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Dec 2019 07:06:15 -0500
Received: from foss.arm.com ([217.140.110.172]:52576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727655AbfLPMGO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 16 Dec 2019 07:06:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 245E11FB;
        Mon, 16 Dec 2019 04:06:14 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 712433F719;
        Mon, 16 Dec 2019 04:06:13 -0800 (PST)
Date:   Mon, 16 Dec 2019 12:06:12 +0000
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
Subject: Applied "spi: img-spfi: Use dma_request_chan() instead dma_request_slave_channel()" to the spi tree
In-Reply-To: <20191212135550.4634-5-peter.ujfalusi@ti.com>
Message-Id: <applied-20191212135550.4634-5-peter.ujfalusi@ti.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: img-spfi: Use dma_request_chan() instead dma_request_slave_channel()

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

From 6bfbf4d0aa0c5ebfd4442e1200b21565703e90ed Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 12 Dec 2019 15:55:45 +0200
Subject: [PATCH] spi: img-spfi: Use dma_request_chan() instead
 dma_request_slave_channel()

dma_request_slave_channel() is a wrapper on top of dma_request_chan()
eating up the error code.

By using dma_request_chan() directly the driver can support deferred
probing against DMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/20191212135550.4634-5-peter.ujfalusi@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-img-spfi.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index f4a8f470aecc..8543f5ed1099 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -666,8 +666,22 @@ static int img_spfi_probe(struct platform_device *pdev)
 	master->unprepare_message = img_spfi_unprepare;
 	master->handle_err = img_spfi_handle_err;
 
-	spfi->tx_ch = dma_request_slave_channel(spfi->dev, "tx");
-	spfi->rx_ch = dma_request_slave_channel(spfi->dev, "rx");
+	spfi->tx_ch = dma_request_chan(spfi->dev, "tx");
+	if (IS_ERR(spfi->tx_ch)) {
+		ret = PTR_ERR(spfi->tx_ch);
+		spfi->tx_ch = NULL;
+		if (ret == -EPROBE_DEFER)
+			goto disable_pm;
+	}
+
+	spfi->rx_ch = dma_request_chan(spfi->dev, "rx");
+	if (IS_ERR(spfi->rx_ch)) {
+		ret = PTR_ERR(spfi->rx_ch);
+		spfi->rx_ch = NULL;
+		if (ret == -EPROBE_DEFER)
+			goto disable_pm;
+	}
+
 	if (!spfi->tx_ch || !spfi->rx_ch) {
 		if (spfi->tx_ch)
 			dma_release_channel(spfi->tx_ch);
-- 
2.20.1

