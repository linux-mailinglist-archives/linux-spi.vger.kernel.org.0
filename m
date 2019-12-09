Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28F5E117519
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2019 20:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfLITAU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Dec 2019 14:00:20 -0500
Received: from foss.arm.com ([217.140.110.172]:42654 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbfLITAU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Dec 2019 14:00:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3018D328;
        Mon,  9 Dec 2019 11:00:20 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3666F3F6CF;
        Mon,  9 Dec 2019 11:00:19 -0800 (PST)
Date:   Mon, 09 Dec 2019 19:00:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Amelie Delaunay <amelie.delaunay@st.com>,
        Cezary Gapinski <cezary.gapinski@gmail.com>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: stm32: Switch to use GPIO descriptors for CS" to the spi tree
In-Reply-To: <20191205083401.27077-1-linus.walleij@linaro.org>
Message-Id: <applied-20191205083401.27077-1-linus.walleij@linaro.org>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: stm32: Switch to use GPIO descriptors for CS

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

From 8a6553ecdf976d6a34664bd491f0ea74a15aa982 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 5 Dec 2019 09:34:01 +0100
Subject: [PATCH] spi: stm32: Switch to use GPIO descriptors for CS

This switches the STM32 SPI driver over to using GPIO
descriptors for chip select. Instead of the callbacks for
picking the GPIO lines using the legacy API we just let
the core handle it all using descriptors.

Cc: Fabien Dessenne <fabien.dessenne@st.com>
Cc: Amelie Delaunay <amelie.delaunay@st.com>
Cc: Cezary Gapinski <cezary.gapinski@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20191205083401.27077-1-linus.walleij@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32.c | 47 +++--------------------------------------
 1 file changed, 3 insertions(+), 44 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index b222ce8d083e..7d75632c4151 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -9,7 +9,6 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
-#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
@@ -973,29 +972,6 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-/**
- * stm32_spi_setup - setup device chip select
- */
-static int stm32_spi_setup(struct spi_device *spi_dev)
-{
-	int ret = 0;
-
-	if (!gpio_is_valid(spi_dev->cs_gpio)) {
-		dev_err(&spi_dev->dev, "%d is not a valid gpio\n",
-			spi_dev->cs_gpio);
-		return -EINVAL;
-	}
-
-	dev_dbg(&spi_dev->dev, "%s: set gpio%d output %s\n", __func__,
-		spi_dev->cs_gpio,
-		(spi_dev->mode & SPI_CS_HIGH) ? "low" : "high");
-
-	ret = gpio_direction_output(spi_dev->cs_gpio,
-				    !(spi_dev->mode & SPI_CS_HIGH));
-
-	return ret;
-}
-
 /**
  * stm32_spi_prepare_msg - set up the controller to transfer a single message
  */
@@ -1810,7 +1786,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct stm32_spi *spi;
 	struct resource *res;
-	int i, ret;
+	int ret;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(struct stm32_spi));
 	if (!master) {
@@ -1898,7 +1874,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	master->bits_per_word_mask = spi->cfg->get_bpw_mask(spi);
 	master->max_speed_hz = spi->clk_rate / spi->cfg->baud_rate_div_min;
 	master->min_speed_hz = spi->clk_rate / spi->cfg->baud_rate_div_max;
-	master->setup = stm32_spi_setup;
+	master->use_gpio_descriptors = true;
 	master->prepare_message = stm32_spi_prepare_msg;
 	master->transfer_one = stm32_spi_transfer_one;
 	master->unprepare_message = stm32_spi_unprepare_msg;
@@ -1928,29 +1904,12 @@ static int stm32_spi_probe(struct platform_device *pdev)
 		goto err_dma_release;
 	}
 
-	if (!master->cs_gpios) {
+	if (!master->cs_gpiods) {
 		dev_err(&pdev->dev, "no CS gpios available\n");
 		ret = -EINVAL;
 		goto err_dma_release;
 	}
 
-	for (i = 0; i < master->num_chipselect; i++) {
-		if (!gpio_is_valid(master->cs_gpios[i])) {
-			dev_err(&pdev->dev, "%i is not a valid gpio\n",
-				master->cs_gpios[i]);
-			ret = -EINVAL;
-			goto err_dma_release;
-		}
-
-		ret = devm_gpio_request(&pdev->dev, master->cs_gpios[i],
-					DRIVER_NAME);
-		if (ret) {
-			dev_err(&pdev->dev, "can't get CS gpio %i\n",
-				master->cs_gpios[i]);
-			goto err_dma_release;
-		}
-	}
-
 	dev_info(&pdev->dev, "driver initialized\n");
 
 	return 0;
-- 
2.20.1

