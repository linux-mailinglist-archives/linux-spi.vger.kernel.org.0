Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAAE1346EB
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jan 2020 17:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbgAHP7S (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jan 2020 10:59:18 -0500
Received: from foss.arm.com ([217.140.110.172]:46734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729270AbgAHP7R (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 8 Jan 2020 10:59:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B10731B;
        Wed,  8 Jan 2020 07:59:17 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA70A3F534;
        Wed,  8 Jan 2020 07:59:16 -0800 (PST)
Date:   Wed, 08 Jan 2020 15:59:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Chris Brandt <chris.brandt@renesas.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>
Subject: Applied "spi: rspi: Use dev_warn_once() instead of open-coding" to the spi tree
In-Reply-To: <20200102133822.29346-4-geert+renesas@glider.be>
Message-Id: <applied-20200102133822.29346-4-geert+renesas@glider.be>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: rspi: Use dev_warn_once() instead of open-coding

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

From 1bec84ddd85ae7a2b1df5fef3a5c7e5c44cbe36e Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 2 Jan 2020 14:38:19 +0100
Subject: [PATCH] spi: rspi: Use dev_warn_once() instead of open-coding

Use the helper introduced by commit e135303bd5bebcd2 ("device: Add
dev_<level>_once variants") instead of open-coding the same operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20200102133822.29346-4-geert+renesas@glider.be
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rspi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 74a12f4dee84..e54a25f848ea 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -620,9 +620,8 @@ static int rspi_dma_transfer(struct rspi_data *rspi, struct sg_table *tx,
 		dmaengine_terminate_all(rspi->ctlr->dma_rx);
 no_dma_rx:
 	if (ret == -EAGAIN) {
-		pr_warn_once("%s %s: DMA not available, falling back to PIO\n",
-			     dev_driver_string(&rspi->ctlr->dev),
-			     dev_name(&rspi->ctlr->dev));
+		dev_warn_once(&rspi->ctlr->dev,
+			      "DMA not available, falling back to PIO\n");
 	}
 	return ret;
 }
-- 
2.20.1

