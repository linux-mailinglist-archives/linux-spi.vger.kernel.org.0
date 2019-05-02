Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9C21115F
	for <lists+linux-spi@lfdr.de>; Thu,  2 May 2019 04:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfEBCUa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 May 2019 22:20:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56604 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfEBCTH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 May 2019 22:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=UCd5PvISpjx6MWF5+BmECaXInU42js58B4pjqnsk864=; b=bBKj7O+BnLNV
        xND2O0l4u5/I5B9ChdTjX0Nldz82WcCBeZ0yDiwwDokSEVPRxIhsy3NDLl6OBcduLvWMqDuyV0dvi
        e3VHGF0RXUl1UycVhtU09tk6iSDZOp2CM/Y9oKZcVnVAoIMLuzDqWqHfbYbbUynlpbsfNF2ox6EOR
        95mok=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM1JO-0005vR-Uv; Thu, 02 May 2019 02:19:03 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id D8D0C441D3F; Thu,  2 May 2019 03:18:59 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: ep93xx: Convert to use CS GPIO descriptors" to the spi tree
In-Reply-To: <20190420110559.4947-1-linus.walleij@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190502021859.D8D0C441D3F@finisterre.ee.mobilebroadband>
Date:   Thu,  2 May 2019 03:18:59 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: ep93xx: Convert to use CS GPIO descriptors

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.2

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

From 1dfbf334f12361ebe6269c5918328b755ee960c7 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 20 Apr 2019 13:05:59 +0200
Subject: [PATCH] spi: ep93xx: Convert to use CS GPIO descriptors

This converts the EP93xx SPI master driver to use GPIO
descriptors for chip select handling.

EP93xx was using platform data to pass in GPIO lines,
by converting all board files to use GPIO descriptor
tables the core will look up the GPIO lines from the
SPI device in the same manner as for device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm/mach-ep93xx/edb93xx.c           | 13 +++++++---
 arch/arm/mach-ep93xx/simone.c            | 11 +++++---
 arch/arm/mach-ep93xx/ts72xx.c            | 25 ++++++++++++------
 arch/arm/mach-ep93xx/vision_ep9307.c     | 15 ++++++-----
 drivers/spi/spi-ep93xx.c                 | 32 +++++-------------------
 include/linux/platform_data/spi-ep93xx.h |  4 ---
 6 files changed, 48 insertions(+), 52 deletions(-)

diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index 8e89ec8b6f0f..34e18e9556d9 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -29,6 +29,7 @@
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
 #include <linux/spi/spi.h>
+#include <linux/gpio/machine.h>
 
 #include <sound/cs4271.h>
 
@@ -105,13 +106,16 @@ static struct spi_board_info edb93xx_spi_board_info[] __initdata = {
 	},
 };
 
-static int edb93xx_spi_chipselects[] __initdata = {
-	EP93XX_GPIO_LINE_EGPIO6,
+static struct gpiod_lookup_table edb93xx_spi_cs_gpio_table = {
+	.dev_id = "ep93xx-spi.0",
+	.table = {
+		GPIO_LOOKUP("A", 6, "cs", GPIO_ACTIVE_LOW),
+		{ },
+	},
 };
 
 static struct ep93xx_spi_info edb93xx_spi_info __initdata = {
-	.chipselect	= edb93xx_spi_chipselects,
-	.num_chipselect	= ARRAY_SIZE(edb93xx_spi_chipselects),
+	/* Intentionally left blank */
 };
 
 static void __init edb93xx_register_spi(void)
@@ -123,6 +127,7 @@ static void __init edb93xx_register_spi(void)
 	else if (machine_is_edb9315a())
 		edb93xx_cs4271_data.gpio_nreset = EP93XX_GPIO_LINE_EGPIO14;
 
+	gpiod_add_lookup_table(&edb93xx_spi_cs_gpio_table);
 	ep93xx_register_spi(&edb93xx_spi_info, edb93xx_spi_board_info,
 			    ARRAY_SIZE(edb93xx_spi_board_info));
 }
diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
index 80ccb984d521..f0f38c0dba52 100644
--- a/arch/arm/mach-ep93xx/simone.c
+++ b/arch/arm/mach-ep93xx/simone.c
@@ -77,13 +77,15 @@ static struct spi_board_info simone_spi_devices[] __initdata = {
  * low between multi-message command blocks. From v1.4, it uses a GPIO instead.
  * v1.3 parts will still work, since the signal on SFRMOUT is automatic.
  */
-static int simone_spi_chipselects[] __initdata = {
-	EP93XX_GPIO_LINE_EGPIO1,
+static struct gpiod_lookup_table simone_spi_cs_gpio_table = {
+	.dev_id = "ep93xx-spi.0",
+	.table = {
+		GPIO_LOOKUP("A", 1, "cs", GPIO_ACTIVE_LOW),
+		{ },
+	},
 };
 
 static struct ep93xx_spi_info simone_spi_info __initdata = {
-	.chipselect	= simone_spi_chipselects,
-	.num_chipselect	= ARRAY_SIZE(simone_spi_chipselects),
 	.use_dma = 1,
 };
 
@@ -113,6 +115,7 @@ static void __init simone_init_machine(void)
 	ep93xx_register_i2c(simone_i2c_board_info,
 			    ARRAY_SIZE(simone_i2c_board_info));
 	gpiod_add_lookup_table(&simone_mmc_spi_gpio_table);
+	gpiod_add_lookup_table(&simone_spi_cs_gpio_table);
 	ep93xx_register_spi(&simone_spi_info, simone_spi_devices,
 			    ARRAY_SIZE(simone_spi_devices));
 	simone_register_audio();
diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index 85b74ac943f0..a3a20c83c6b8 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -22,6 +22,7 @@
 #include <linux/spi/mmc_spi.h>
 #include <linux/mmc/host.h>
 #include <linux/platform_data/spi-ep93xx.h>
+#include <linux/gpio/machine.h>
 
 #include <mach/gpio-ep93xx.h>
 #include <mach/hardware.h>
@@ -269,13 +270,15 @@ static struct spi_board_info bk3_spi_board_info[] __initdata = {
  * The all work is performed automatically by !SPI_FRAME (SFRM1) and
  * goes through CPLD
  */
-static int bk3_spi_chipselects[] __initdata = {
-	EP93XX_GPIO_LINE_F(3),
+static struct gpiod_lookup_table bk3_spi_cs_gpio_table = {
+	.dev_id = "ep93xx-spi.0",
+	.table = {
+		GPIO_LOOKUP("F", 3, "cs", GPIO_ACTIVE_LOW),
+		{ },
+	},
 };
 
 static struct ep93xx_spi_info bk3_spi_master __initdata = {
-	.chipselect	= bk3_spi_chipselects,
-	.num_chipselect = ARRAY_SIZE(bk3_spi_chipselects),
 	.use_dma	= 1,
 };
 
@@ -316,13 +319,17 @@ static struct spi_board_info ts72xx_spi_devices[] __initdata = {
 	},
 };
 
-static int ts72xx_spi_chipselects[] __initdata = {
-	EP93XX_GPIO_LINE_F(2),		/* DIO_17 */
+static struct gpiod_lookup_table ts72xx_spi_cs_gpio_table = {
+	.dev_id = "ep93xx-spi.0",
+	.table = {
+		/* DIO_17 */
+		GPIO_LOOKUP("F", 2, "cs", GPIO_ACTIVE_LOW),
+		{ },
+	},
 };
 
 static struct ep93xx_spi_info ts72xx_spi_info __initdata = {
-	.chipselect	= ts72xx_spi_chipselects,
-	.num_chipselect	= ARRAY_SIZE(ts72xx_spi_chipselects),
+	/* Intentionally left blank */
 };
 
 static void __init ts72xx_init_machine(void)
@@ -339,6 +346,7 @@ static void __init ts72xx_init_machine(void)
 	if (board_is_ts7300())
 		platform_device_register(&ts73xx_fpga_device);
 #endif
+	gpiod_add_lookup_table(&ts72xx_spi_cs_gpio_table);
 	ep93xx_register_spi(&ts72xx_spi_info, ts72xx_spi_devices,
 			    ARRAY_SIZE(ts72xx_spi_devices));
 }
@@ -398,6 +406,7 @@ static void __init bk3_init_machine(void)
 
 	ep93xx_register_eth(&ts72xx_eth_data, 1);
 
+	gpiod_add_lookup_table(&bk3_spi_cs_gpio_table);
 	ep93xx_register_spi(&bk3_spi_master, bk3_spi_board_info,
 			    ARRAY_SIZE(bk3_spi_board_info));
 
diff --git a/arch/arm/mach-ep93xx/vision_ep9307.c b/arch/arm/mach-ep93xx/vision_ep9307.c
index 767ee64628dc..f95a644769e4 100644
--- a/arch/arm/mach-ep93xx/vision_ep9307.c
+++ b/arch/arm/mach-ep93xx/vision_ep9307.c
@@ -245,15 +245,17 @@ static struct spi_board_info vision_spi_board_info[] __initdata = {
 	},
 };
 
-static int vision_spi_chipselects[] __initdata = {
-	EP93XX_GPIO_LINE_EGPIO6,
-	EP93XX_GPIO_LINE_EGPIO7,
-	EP93XX_GPIO_LINE_G(2),
+static struct gpiod_lookup_table vision_spi_cs_gpio_table = {
+	.dev_id = "ep93xx-spi.0",
+	.table = {
+		GPIO_LOOKUP_IDX("A", 6, "cs", 0, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("A", 7, "cs", 1, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("G", 2, "cs", 2, GPIO_ACTIVE_LOW),
+		{ },
+	},
 };
 
 static struct ep93xx_spi_info vision_spi_master __initdata = {
-	.chipselect	= vision_spi_chipselects,
-	.num_chipselect	= ARRAY_SIZE(vision_spi_chipselects),
 	.use_dma	= 1,
 };
 
@@ -295,6 +297,7 @@ static void __init vision_init_machine(void)
 	ep93xx_register_i2c(vision_i2c_info,
 				ARRAY_SIZE(vision_i2c_info));
 	gpiod_add_lookup_table(&vision_spi_mmc_gpio_table);
+	gpiod_add_lookup_table(&vision_spi_cs_gpio_table);
 	ep93xx_register_spi(&vision_spi_master, vision_spi_board_info,
 				ARRAY_SIZE(vision_spi_board_info));
 	vision_register_i2s();
diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index 79fc3940245a..47e39251bad9 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -28,7 +28,6 @@
 #include <linux/platform_device.h>
 #include <linux/sched.h>
 #include <linux/scatterlist.h>
-#include <linux/gpio.h>
 #include <linux/spi/spi.h>
 
 #include <linux/platform_data/dma-ep93xx.h>
@@ -676,6 +675,7 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 	if (!master)
 		return -ENOMEM;
 
+	master->use_gpio_descriptors = true;
 	master->prepare_transfer_hardware = ep93xx_spi_prepare_hardware;
 	master->unprepare_transfer_hardware = ep93xx_spi_unprepare_hardware;
 	master->prepare_message = ep93xx_spi_prepare_message;
@@ -683,31 +683,11 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 	master->bus_num = pdev->id;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16);
-
-	master->num_chipselect = info->num_chipselect;
-	master->cs_gpios = devm_kcalloc(&master->dev,
-					master->num_chipselect, sizeof(int),
-					GFP_KERNEL);
-	if (!master->cs_gpios) {
-		error = -ENOMEM;
-		goto fail_release_master;
-	}
-
-	for (i = 0; i < master->num_chipselect; i++) {
-		master->cs_gpios[i] = info->chipselect[i];
-
-		if (!gpio_is_valid(master->cs_gpios[i]))
-			continue;
-
-		error = devm_gpio_request_one(&pdev->dev, master->cs_gpios[i],
-					      GPIOF_OUT_INIT_HIGH,
-					      "ep93xx-spi");
-		if (error) {
-			dev_err(&pdev->dev, "could not request cs gpio %d\n",
-				master->cs_gpios[i]);
-			goto fail_release_master;
-		}
-	}
+	/*
+	 * The SPI core will count the number of GPIO descriptors to figure
+	 * out the number of chip selects available on the platform.
+	 */
+	master->num_chipselect = 0;
 
 	platform_set_drvdata(pdev, master);
 
diff --git a/include/linux/platform_data/spi-ep93xx.h b/include/linux/platform_data/spi-ep93xx.h
index eb16c6739ac2..b439f2a896e0 100644
--- a/include/linux/platform_data/spi-ep93xx.h
+++ b/include/linux/platform_data/spi-ep93xx.h
@@ -6,13 +6,9 @@ struct spi_device;
 
 /**
  * struct ep93xx_spi_info - EP93xx specific SPI descriptor
- * @chipselect: array of gpio numbers to use as chip selects
- * @num_chipselect: ARRAY_SIZE(chipselect)
  * @use_dma: use DMA for the transfers
  */
 struct ep93xx_spi_info {
-	int	*chipselect;
-	int	num_chipselect;
 	bool	use_dma;
 };
 
-- 
2.20.1

