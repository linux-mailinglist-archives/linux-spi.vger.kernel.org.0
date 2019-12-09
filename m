Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD01A117518
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2019 20:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfLITAS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Dec 2019 14:00:18 -0500
Received: from foss.arm.com ([217.140.110.172]:42646 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbfLITAS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Dec 2019 14:00:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4330E328;
        Mon,  9 Dec 2019 11:00:17 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B661B3F6CF;
        Mon,  9 Dec 2019 11:00:16 -0800 (PST)
Date:   Mon, 09 Dec 2019 19:00:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: bitbang: Make chipselect callback optional" to the spi tree
In-Reply-To: <20191205091340.59850-1-linus.walleij@linaro.org>
Message-Id: <applied-20191205091340.59850-1-linus.walleij@linaro.org>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: bitbang: Make chipselect callback optional

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

From 4a07b8bcd503c842bcf0171cdbccdfdac3d985c3 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 5 Dec 2019 10:13:40 +0100
Subject: [PATCH] spi: bitbang: Make chipselect callback optional

The ->chipselect() callback on the bit-banged SPI library
master is optional if using GPIO descriptors: when using
descriptors exclusively without any native chipselects,
the core does not even call out the the native ->set_cs()
and therefore ->chipselect() on a bit-banged SPI master
will not even be called in this case.

Make sure to respect the SPI_MASTER_GPIO_SS as used by
e.g. spi-gpio.c though: this setting will make the core
handle the chip select using GPIO descriptors *AND* call
the local chipselect handler.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20191205091340.59850-1-linus.walleij@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bitbang.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index d84e22dd6f9f..68491a8bf7b5 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -329,8 +329,20 @@ static void spi_bitbang_set_cs(struct spi_device *spi, bool enable)
 int spi_bitbang_init(struct spi_bitbang *bitbang)
 {
 	struct spi_master *master = bitbang->master;
+	bool custom_cs;
 
-	if (!master || !bitbang->chipselect)
+	if (!master)
+		return -EINVAL;
+	/*
+	 * We only need the chipselect callback if we are actually using it.
+	 * If we just use GPIO descriptors, it is surplus. If the
+	 * SPI_MASTER_GPIO_SS flag is set, we always need to call the
+	 * driver-specific chipselect routine.
+	 */
+	custom_cs = (!master->use_gpio_descriptors ||
+		     (master->flags & SPI_MASTER_GPIO_SS));
+
+	if (custom_cs && !bitbang->chipselect)
 		return -EINVAL;
 
 	mutex_init(&bitbang->lock);
@@ -344,7 +356,12 @@ int spi_bitbang_init(struct spi_bitbang *bitbang)
 	master->prepare_transfer_hardware = spi_bitbang_prepare_hardware;
 	master->unprepare_transfer_hardware = spi_bitbang_unprepare_hardware;
 	master->transfer_one = spi_bitbang_transfer_one;
-	master->set_cs = spi_bitbang_set_cs;
+	/*
+	 * When using GPIO descriptors, the ->set_cs() callback doesn't even
+	 * get called unless SPI_MASTER_GPIO_SS is set.
+	 */
+	if (custom_cs)
+		master->set_cs = spi_bitbang_set_cs;
 
 	if (!bitbang->txrx_bufs) {
 		bitbang->use_dma = 0;
-- 
2.20.1

