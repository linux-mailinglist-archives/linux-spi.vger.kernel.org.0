Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9885D11751A
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2019 20:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfLITAX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Dec 2019 14:00:23 -0500
Received: from foss.arm.com ([217.140.110.172]:42668 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbfLITAX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Dec 2019 14:00:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CE09328;
        Mon,  9 Dec 2019 11:00:22 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DB5F3F6CF;
        Mon,  9 Dec 2019 11:00:21 -0800 (PST)
Date:   Mon, 09 Dec 2019 19:00:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     zhengbin <zhengbin13@huawei.com>
Cc:     broonie@kernel.org, Hulk Robot <hulkci@huawei.com>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        zhengbin13@huawei.com
Subject: Applied "spi/topcliff-pch: Remove unneeded semicolon" to the spi tree
In-Reply-To: <1574909512-24260-1-git-send-email-zhengbin13@huawei.com>
Message-Id: <applied-1574909512-24260-1-git-send-email-zhengbin13@huawei.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi/topcliff-pch: Remove unneeded semicolon

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

From 10e413faa72c6f728ead2c6cc140f834af7bee8d Mon Sep 17 00:00:00 2001
From: zhengbin <zhengbin13@huawei.com>
Date: Thu, 28 Nov 2019 10:51:52 +0800
Subject: [PATCH] spi/topcliff-pch: Remove unneeded semicolon

Fixes coccicheck warning:

drivers/spi/spi-topcliff-pch.c:866:47-48: Unneeded semicolon
drivers/spi/spi-topcliff-pch.c:881:53-54: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
Link: https://lore.kernel.org/r/1574909512-24260-1-git-send-email-zhengbin13@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-topcliff-pch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 223353fa2d8a..d7ea6af74743 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -863,7 +863,7 @@ static void pch_spi_request_dma(struct pch_spi_data *data, int bpw)
 	/* Set Tx DMA */
 	param = &dma->param_tx;
 	param->dma_dev = &dma_dev->dev;
-	param->chan_id = data->ch * 2; /* Tx = 0, 2 */;
+	param->chan_id = data->ch * 2; /* Tx = 0, 2 */
 	param->tx_reg = data->io_base_addr + PCH_SPDWR;
 	param->width = width;
 	chan = dma_request_channel(mask, pch_spi_filter, param);
@@ -878,7 +878,7 @@ static void pch_spi_request_dma(struct pch_spi_data *data, int bpw)
 	/* Set Rx DMA */
 	param = &dma->param_rx;
 	param->dma_dev = &dma_dev->dev;
-	param->chan_id = data->ch * 2 + 1; /* Rx = Tx + 1 */;
+	param->chan_id = data->ch * 2 + 1; /* Rx = Tx + 1 */
 	param->rx_reg = data->io_base_addr + PCH_SPDRR;
 	param->width = width;
 	chan = dma_request_channel(mask, pch_spi_filter, param);
-- 
2.20.1

