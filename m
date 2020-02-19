Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0234D16383D
	for <lists+linux-spi@lfdr.de>; Wed, 19 Feb 2020 01:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgBSALa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Feb 2020 19:11:30 -0500
Received: from foss.arm.com ([217.140.110.172]:37340 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgBSALa (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 18 Feb 2020 19:11:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45392FEC;
        Tue, 18 Feb 2020 16:11:29 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCADC3F68F;
        Tue, 18 Feb 2020 16:11:28 -0800 (PST)
Date:   Wed, 19 Feb 2020 00:11:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Hoan Nguyen An <na-hoan@jinso.co.jp>,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: rspi: Add support for LSB-first word order" to the spi tree
In-Reply-To:  <20200218105810.902-3-geert+renesas@glider.be>
Message-Id:  <applied-20200218105810.902-3-geert+renesas@glider.be>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: rspi: Add support for LSB-first word order

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

From c046f8fd83a902866ba3b122e9f57ca1c7de898c Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 18 Feb 2020 11:58:09 +0100
Subject: [PATCH] spi: rspi: Add support for LSB-first word order

All RSPI variants support selecting the word order.
Advertize support for LSB-first order, and act upon the flag being set.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20200218105810.902-3-geert+renesas@glider.be
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rspi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 7a1e6d524f34..aef05f2ac749 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -933,6 +933,8 @@ static int rspi_prepare_message(struct spi_controller *ctlr,
 		rspi->spcmd |= SPCMD_CPOL;
 	if (spi->mode & SPI_CPHA)
 		rspi->spcmd |= SPCMD_CPHA;
+	if (spi->mode & SPI_LSB_FIRST)
+		rspi->spcmd |= SPCMD_LSBF;
 
 	/* Configure slave signal to assert */
 	rspi->spcmd |= SPCMD_SSLA(spi->cs_gpiod ? rspi->ctlr->unused_native_cs
@@ -1255,7 +1257,8 @@ static int rspi_probe(struct platform_device *pdev)
 	ctlr->transfer_one = ops->transfer_one;
 	ctlr->prepare_message = rspi_prepare_message;
 	ctlr->unprepare_message = rspi_unprepare_message;
-	ctlr->mode_bits = SPI_CPHA | SPI_CPOL | SPI_LOOP | ops->extra_mode_bits;
+	ctlr->mode_bits = SPI_CPHA | SPI_CPOL | SPI_LSB_FIRST | SPI_LOOP |
+			  ops->extra_mode_bits;
 	ctlr->flags = ops->flags;
 	ctlr->dev.of_node = pdev->dev.of_node;
 	ctlr->use_gpio_descriptors = true;
-- 
2.20.1

