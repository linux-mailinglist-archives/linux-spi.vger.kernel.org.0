Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB22D1204B4
	for <lists+linux-spi@lfdr.de>; Mon, 16 Dec 2019 13:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfLPMF7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Dec 2019 07:05:59 -0500
Received: from foss.arm.com ([217.140.110.172]:52446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbfLPMF7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 16 Dec 2019 07:05:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9B9D1FB;
        Mon, 16 Dec 2019 04:05:58 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A5D33F719;
        Mon, 16 Dec 2019 04:05:58 -0800 (PST)
Date:   Mon, 16 Dec 2019 12:05:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sunny Luo <sunny.luo@amlogic.com>
Subject: Applied "spi: meson-spicc: Use GPIO descriptors" to the spi tree
In-Reply-To: <20191205083915.27650-1-linus.walleij@linaro.org>
Message-Id: <applied-20191205083915.27650-1-linus.walleij@linaro.org>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: meson-spicc: Use GPIO descriptors

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

From cd8fb859a84c1c4f985a582b79050116d2c30c47 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 5 Dec 2019 09:39:15 +0100
Subject: [PATCH] spi: meson-spicc: Use GPIO descriptors

Instead of grabbing GPIOs using the legacy interface and
handling them in the setup callback, just let the core
grab and use the GPIOs using descriptors.

Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Sunny Luo <sunny.luo@amlogic.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://lore.kernel.org/r/20191205083915.27650-1-linus.walleij@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-meson-spicc.c | 25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index f3f10443f9e2..7f5680fe2568 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -19,7 +19,6 @@
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/reset.h>
-#include <linux/gpio.h>
 
 /*
  * The Meson SPICC controller could support DMA based transfers, but is not
@@ -467,35 +466,14 @@ static int meson_spicc_unprepare_transfer(struct spi_master *master)
 
 static int meson_spicc_setup(struct spi_device *spi)
 {
-	int ret = 0;
-
 	if (!spi->controller_state)
 		spi->controller_state = spi_master_get_devdata(spi->master);
-	else if (gpio_is_valid(spi->cs_gpio))
-		goto out_gpio;
-	else if (spi->cs_gpio == -ENOENT)
-		return 0;
-
-	if (gpio_is_valid(spi->cs_gpio)) {
-		ret = gpio_request(spi->cs_gpio, dev_name(&spi->dev));
-		if (ret) {
-			dev_err(&spi->dev, "failed to request cs gpio\n");
-			return ret;
-		}
-	}
-
-out_gpio:
-	ret = gpio_direction_output(spi->cs_gpio,
-			!(spi->mode & SPI_CS_HIGH));
 
-	return ret;
+	return 0;
 }
 
 static void meson_spicc_cleanup(struct spi_device *spi)
 {
-	if (gpio_is_valid(spi->cs_gpio))
-		gpio_free(spi->cs_gpio);
-
 	spi->controller_state = NULL;
 }
 
@@ -564,6 +542,7 @@ static int meson_spicc_probe(struct platform_device *pdev)
 	master->prepare_message = meson_spicc_prepare_message;
 	master->unprepare_transfer_hardware = meson_spicc_unprepare_transfer;
 	master->transfer_one = meson_spicc_transfer_one;
+	master->use_gpio_descriptors = true;
 
 	/* Setup max rate according to the Meson GX datasheet */
 	if ((rate >> 2) > SPICC_MAX_FREQ)
-- 
2.20.1

