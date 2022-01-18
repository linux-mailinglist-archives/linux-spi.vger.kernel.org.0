Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095D3491976
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jan 2022 03:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242836AbiARCyJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Jan 2022 21:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345311AbiARCim (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Jan 2022 21:38:42 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A923C061778
        for <linux-spi@vger.kernel.org>; Mon, 17 Jan 2022 18:35:11 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b14so46411789lff.3
        for <linux-spi@vger.kernel.org>; Mon, 17 Jan 2022 18:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9NY6N7G1IuqvhT8lNA29Gyx0ppaKBFNdVc52hk5T3xo=;
        b=SMAy+Tp3CGjtqzH5gAATsxQr1D2GQDcx8jMZpPpLBWTuDfYL7blVFBQd0opFgwIkId
         vj32eWMi+kRWtu3LtOwqaygpBFa6uDqO3M29wXBheEdISRGLnX5aN7AdtcECfhYew5jZ
         DfX/5aMW5vzIBDE/fGD/W0oRow5IwoDnbHr2wVBE6QakMPpbZIFJsn9H04TU+ywtypPw
         KsjOIeW2gd9Z+QOB04Kfcw4mjDB2DbwGvLd+XmLLLOBJHahdn9VQ5Q1RnL/w+Powvo99
         Gle2OlD+YKMnpOAsgePMvi+E7gVgHlHD5DZU3xCfrbvrYbCFIhX+r2h5+tHzqM4VHKuE
         Ny3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9NY6N7G1IuqvhT8lNA29Gyx0ppaKBFNdVc52hk5T3xo=;
        b=7S3e0WPPLECY4fdXkMtLGJh+TOybUbliwmo08/o7+ArJJ4AHxgLgpL1xTEgafx2TUG
         0BeRee7300it2Bmn+5UlKrz3yJL9YR4t0WDGggOWZ1draVpFBnu29IuCYDw05pL6Tqvr
         eK35GbhxLa2M8pIpICCYXWldgJWctwTgc0nWwFq0NR0mxRXBLjUkq0pjklogDC0iJUkz
         KlHuaDw6D0rFWEFeZ/3UU6GGboMaDTcQqRWbAqCbq1bfeqZW1XZVnWfA+vdYJtZw7E0b
         iyYwQwO/2h0iOx0iRBsk2zDs0us33EFmv1uOglwiADMbFrFt0rLNZ1vesXnfrbHOlpU6
         JehA==
X-Gm-Message-State: AOAM533izPK+e+nPGBbIaKwX6PuuHHWidiZ6fzJkoXH0gCS4fg+IcuJh
        4Z+VxCL20KBBHpX3ELh+Tw4Mag==
X-Google-Smtp-Source: ABdhPJwyliVhj5NDncxJX9H2FjKLo2EkRGUAonKMQ/S317sG6c6NYS2sN+NpaG37iNLfBPvwRKMhqw==
X-Received: by 2002:a2e:a913:: with SMTP id j19mr19311821ljq.412.1642473309564;
        Mon, 17 Jan 2022 18:35:09 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id bp19sm1540707lfb.279.2022.01.17.18.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 18:35:08 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH] spi: s3c64xx: Convert to use GPIO descriptors
Date:   Tue, 18 Jan 2022 03:33:03 +0100
Message-Id: <20220118023303.104419-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Convert the S3C64xx SPI host to use GPIO descriptors.

In the process we tear out some unused code in the machine,
such as the unused config options for SPI controller 1 and
2. New systems should use the device tree boot to enable these
SPI hosts.

We drop the ability to pass a custom pin config function
to the device while registering since nothing was using this.

Provide GPIO descriptor tables for the one user with CS
0 and 1.

Cc: linux-samsung-soc@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc: Sylwester Nawrocki <snawrocki@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-s3c/Kconfig                 | 12 ----
 arch/arm/mach-s3c/devs.c                  | 77 +----------------------
 arch/arm/mach-s3c/mach-crag6410-module.c  | 13 ----
 arch/arm/mach-s3c/mach-crag6410.c         | 13 +++-
 arch/arm/mach-s3c/setup-spi-s3c64xx.c     |  9 ---
 arch/arm/mach-s3c/spi-core-s3c24xx.h      |  6 --
 drivers/spi/spi-s3c64xx.c                 | 50 ++++-----------
 include/linux/platform_data/spi-s3c64xx.h | 16 +----
 8 files changed, 27 insertions(+), 169 deletions(-)

diff --git a/arch/arm/mach-s3c/Kconfig b/arch/arm/mach-s3c/Kconfig
index 25606e668cf9..1899fc3f44fd 100644
--- a/arch/arm/mach-s3c/Kconfig
+++ b/arch/arm/mach-s3c/Kconfig
@@ -191,18 +191,6 @@ config S3C64XX_DEV_SPI0
 	  Compile in platform device definitions for S3C64XX's type
 	  SPI controller 0
 
-config S3C64XX_DEV_SPI1
-	bool
-	help
-	  Compile in platform device definitions for S3C64XX's type
-	  SPI controller 1
-
-config S3C64XX_DEV_SPI2
-	bool
-	help
-	  Compile in platform device definitions for S3C64XX's type
-	  SPI controller 2
-
 config SAMSUNG_DEV_TS
 	bool
 	help
diff --git a/arch/arm/mach-s3c/devs.c b/arch/arm/mach-s3c/devs.c
index 06dec64848f9..1e266fc24f9b 100644
--- a/arch/arm/mach-s3c/devs.c
+++ b/arch/arm/mach-s3c/devs.c
@@ -1107,8 +1107,7 @@ struct platform_device s3c64xx_device_spi0 = {
 	},
 };
 
-void __init s3c64xx_spi0_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
-						int num_cs)
+void __init s3c64xx_spi0_set_platdata(int src_clk_nr, int num_cs)
 {
 	struct s3c64xx_spi_info pd;
 
@@ -1120,80 +1119,8 @@ void __init s3c64xx_spi0_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
 
 	pd.num_cs = num_cs;
 	pd.src_clk_nr = src_clk_nr;
-	pd.cfg_gpio = (cfg_gpio) ? cfg_gpio : s3c64xx_spi0_cfg_gpio;
+	pd.cfg_gpio = s3c64xx_spi0_cfg_gpio;
 
 	s3c_set_platdata(&pd, sizeof(pd), &s3c64xx_device_spi0);
 }
 #endif /* CONFIG_S3C64XX_DEV_SPI0 */
-
-#ifdef CONFIG_S3C64XX_DEV_SPI1
-static struct resource s3c64xx_spi1_resource[] = {
-	[0] = DEFINE_RES_MEM(S3C_PA_SPI1, SZ_256),
-	[1] = DEFINE_RES_IRQ(IRQ_SPI1),
-};
-
-struct platform_device s3c64xx_device_spi1 = {
-	.name		= "s3c6410-spi",
-	.id		= 1,
-	.num_resources	= ARRAY_SIZE(s3c64xx_spi1_resource),
-	.resource	= s3c64xx_spi1_resource,
-	.dev = {
-		.dma_mask		= &samsung_device_dma_mask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-};
-
-void __init s3c64xx_spi1_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
-						int num_cs)
-{
-	struct s3c64xx_spi_info pd;
-
-	/* Reject invalid configuration */
-	if (!num_cs || src_clk_nr < 0) {
-		pr_err("%s: Invalid SPI configuration\n", __func__);
-		return;
-	}
-
-	pd.num_cs = num_cs;
-	pd.src_clk_nr = src_clk_nr;
-	pd.cfg_gpio = (cfg_gpio) ? cfg_gpio : s3c64xx_spi1_cfg_gpio;
-
-	s3c_set_platdata(&pd, sizeof(pd), &s3c64xx_device_spi1);
-}
-#endif /* CONFIG_S3C64XX_DEV_SPI1 */
-
-#ifdef CONFIG_S3C64XX_DEV_SPI2
-static struct resource s3c64xx_spi2_resource[] = {
-	[0] = DEFINE_RES_MEM(S3C_PA_SPI2, SZ_256),
-	[1] = DEFINE_RES_IRQ(IRQ_SPI2),
-};
-
-struct platform_device s3c64xx_device_spi2 = {
-	.name		= "s3c6410-spi",
-	.id		= 2,
-	.num_resources	= ARRAY_SIZE(s3c64xx_spi2_resource),
-	.resource	= s3c64xx_spi2_resource,
-	.dev = {
-		.dma_mask		= &samsung_device_dma_mask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-};
-
-void __init s3c64xx_spi2_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
-						int num_cs)
-{
-	struct s3c64xx_spi_info pd;
-
-	/* Reject invalid configuration */
-	if (!num_cs || src_clk_nr < 0) {
-		pr_err("%s: Invalid SPI configuration\n", __func__);
-		return;
-	}
-
-	pd.num_cs = num_cs;
-	pd.src_clk_nr = src_clk_nr;
-	pd.cfg_gpio = (cfg_gpio) ? cfg_gpio : s3c64xx_spi2_cfg_gpio;
-
-	s3c_set_platdata(&pd, sizeof(pd), &s3c64xx_device_spi2);
-}
-#endif /* CONFIG_S3C64XX_DEV_SPI2 */
diff --git a/arch/arm/mach-s3c/mach-crag6410-module.c b/arch/arm/mach-s3c/mach-crag6410-module.c
index 407ad493493e..5d1d4b67a4b7 100644
--- a/arch/arm/mach-s3c/mach-crag6410-module.c
+++ b/arch/arm/mach-s3c/mach-crag6410-module.c
@@ -32,10 +32,6 @@
 
 #include "crag6410.h"
 
-static struct s3c64xx_spi_csinfo wm0010_spi_csinfo = {
-	.line = S3C64XX_GPC(3),
-};
-
 static struct wm0010_pdata wm0010_pdata = {
 	.gpio_reset = S3C64XX_GPN(6),
 	.reset_active_high = 1, /* Active high for Glenfarclas Rev 2 */
@@ -49,7 +45,6 @@ static struct spi_board_info wm1253_devs[] = {
 		.chip_select	= 0,
 		.mode		= SPI_MODE_0,
 		.irq		= S3C_EINT(4),
-		.controller_data = &wm0010_spi_csinfo,
 		.platform_data = &wm0010_pdata,
 	},
 };
@@ -62,7 +57,6 @@ static struct spi_board_info balblair_devs[] = {
 		.chip_select	= 0,
 		.mode		= SPI_MODE_0,
 		.irq		= S3C_EINT(4),
-		.controller_data = &wm0010_spi_csinfo,
 		.platform_data = &wm0010_pdata,
 	},
 };
@@ -229,10 +223,6 @@ static struct arizona_pdata wm5102_reva_pdata = {
 	},
 };
 
-static struct s3c64xx_spi_csinfo codec_spi_csinfo = {
-	.line = S3C64XX_GPN(5),
-};
-
 static struct spi_board_info wm5102_reva_spi_devs[] = {
 	[0] = {
 		.modalias	= "wm5102",
@@ -242,7 +232,6 @@ static struct spi_board_info wm5102_reva_spi_devs[] = {
 		.mode		= SPI_MODE_0,
 		.irq		= GLENFARCLAS_PMIC_IRQ_BASE +
 				  WM831X_IRQ_GPIO_2,
-		.controller_data = &codec_spi_csinfo,
 		.platform_data = &wm5102_reva_pdata,
 	},
 };
@@ -275,7 +264,6 @@ static struct spi_board_info wm5102_spi_devs[] = {
 		.mode		= SPI_MODE_0,
 		.irq		= GLENFARCLAS_PMIC_IRQ_BASE +
 				  WM831X_IRQ_GPIO_2,
-		.controller_data = &codec_spi_csinfo,
 		.platform_data = &wm5102_pdata,
 	},
 };
@@ -298,7 +286,6 @@ static struct spi_board_info wm5110_spi_devs[] = {
 		.mode		= SPI_MODE_0,
 		.irq		= GLENFARCLAS_PMIC_IRQ_BASE +
 				  WM831X_IRQ_GPIO_2,
-		.controller_data = &codec_spi_csinfo,
 		.platform_data = &wm5102_reva_pdata,
 	},
 };
diff --git a/arch/arm/mach-s3c/mach-crag6410.c b/arch/arm/mach-s3c/mach-crag6410.c
index 4a12c75d407f..e3e0fe897bcc 100644
--- a/arch/arm/mach-s3c/mach-crag6410.c
+++ b/arch/arm/mach-s3c/mach-crag6410.c
@@ -825,6 +825,15 @@ static const struct gpio_led_platform_data gpio_leds_pdata = {
 
 static struct dwc2_hsotg_plat crag6410_hsotg_pdata;
 
+static struct gpiod_lookup_table crag_spi0_gpiod_table = {
+	.dev_id = "s3c6410-spi.0",
+	.table = {
+		GPIO_LOOKUP_IDX("GPIOC", 3, "cs", 0, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("GPION", 5, "cs", 1, GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
 static void __init crag6410_machine_init(void)
 {
 	/* Open drain IRQs need pullups */
@@ -856,7 +865,9 @@ static void __init crag6410_machine_init(void)
 	i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
 
 	samsung_keypad_set_platdata(&crag6410_keypad_data);
-	s3c64xx_spi0_set_platdata(NULL, 0, 2);
+
+	gpiod_add_lookup_table(&crag_spi0_gpiod_table);
+	s3c64xx_spi0_set_platdata(0, 2);
 
 	pwm_add_table(crag6410_pwm_lookup, ARRAY_SIZE(crag6410_pwm_lookup));
 	platform_add_devices(crag6410_devices, ARRAY_SIZE(crag6410_devices));
diff --git a/arch/arm/mach-s3c/setup-spi-s3c64xx.c b/arch/arm/mach-s3c/setup-spi-s3c64xx.c
index efcf78d41585..497aff71c29c 100644
--- a/arch/arm/mach-s3c/setup-spi-s3c64xx.c
+++ b/arch/arm/mach-s3c/setup-spi-s3c64xx.c
@@ -16,12 +16,3 @@ int s3c64xx_spi0_cfg_gpio(void)
 	return 0;
 }
 #endif
-
-#ifdef CONFIG_S3C64XX_DEV_SPI1
-int s3c64xx_spi1_cfg_gpio(void)
-{
-	s3c_gpio_cfgall_range(S3C64XX_GPC(4), 3,
-				S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
-	return 0;
-}
-#endif
diff --git a/arch/arm/mach-s3c/spi-core-s3c24xx.h b/arch/arm/mach-s3c/spi-core-s3c24xx.h
index 057667469cc3..919c5fd0c9af 100644
--- a/arch/arm/mach-s3c/spi-core-s3c24xx.h
+++ b/arch/arm/mach-s3c/spi-core-s3c24xx.h
@@ -16,12 +16,6 @@ static inline void s3c24xx_spi_setname(char *name)
 #ifdef CONFIG_S3C64XX_DEV_SPI0
 	s3c64xx_device_spi0.name = name;
 #endif
-#ifdef CONFIG_S3C64XX_DEV_SPI1
-	s3c64xx_device_spi1.name = name;
-#endif
-#ifdef CONFIG_S3C64XX_DEV_SPI2
-	s3c64xx_device_spi2.name = name;
-#endif
 }
 
 #endif /* __PLAT_S3C_SPI_CORE_S3C24XX_H */
diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 8755cd85e83c..5e03c9144bfe 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -13,10 +13,8 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
-#include <linux/gpio.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 
 #include <linux/platform_data/spi-s3c64xx.h>
 
@@ -655,6 +653,9 @@ static int s3c64xx_spi_prepare_message(struct spi_master *master,
 	struct spi_device *spi = msg->spi;
 	struct s3c64xx_spi_csinfo *cs = spi->controller_data;
 
+	if (!cs)
+		return 0;
+
 	/* Configure feedback delay */
 	writel(cs->fb_delay & 0x3, sdd->regs + S3C64XX_SPI_FB_CLK);
 
@@ -830,34 +831,16 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 	if (spi->dev.of_node) {
 		cs = s3c64xx_get_slave_ctrldata(spi);
 		spi->controller_data = cs;
-	} else if (cs) {
-		/* On non-DT platforms the SPI core will set spi->cs_gpio
-		 * to -ENOENT. The GPIO pin used to drive the chip select
-		 * is defined by using platform data so spi->cs_gpio value
-		 * has to be override to have the proper GPIO pin number.
-		 */
-		spi->cs_gpio = cs->line;
 	}
 
-	if (IS_ERR_OR_NULL(cs)) {
+	/* NULL is fine, we just avoid using the FB delay (=0) */
+	if (IS_ERR(cs)) {
 		dev_err(&spi->dev, "No CS for SPI(%d)\n", spi->chip_select);
 		return -ENODEV;
 	}
 
-	if (!spi_get_ctldata(spi)) {
-		if (gpio_is_valid(spi->cs_gpio)) {
-			err = gpio_request_one(spi->cs_gpio, GPIOF_OUT_INIT_HIGH,
-					       dev_name(&spi->dev));
-			if (err) {
-				dev_err(&spi->dev,
-					"Failed to get /CS gpio [%d]: %d\n",
-					spi->cs_gpio, err);
-				goto err_gpio_req;
-			}
-		}
-
+	if (!spi_get_ctldata(spi))
 		spi_set_ctldata(spi, cs);
-	}
 
 	pm_runtime_get_sync(&sdd->pdev->dev);
 
@@ -909,11 +892,9 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 	/* setup() returns with device de-selected */
 	s3c64xx_spi_set_cs(spi, false);
 
-	if (gpio_is_valid(spi->cs_gpio))
-		gpio_free(spi->cs_gpio);
 	spi_set_ctldata(spi, NULL);
 
-err_gpio_req:
+	/* This was dynamically allocated on the DT path */
 	if (spi->dev.of_node)
 		kfree(cs);
 
@@ -924,19 +905,9 @@ static void s3c64xx_spi_cleanup(struct spi_device *spi)
 {
 	struct s3c64xx_spi_csinfo *cs = spi_get_ctldata(spi);
 
-	if (gpio_is_valid(spi->cs_gpio)) {
-		gpio_free(spi->cs_gpio);
-		if (spi->dev.of_node)
-			kfree(cs);
-		else {
-			/* On non-DT platforms, the SPI core sets
-			 * spi->cs_gpio to -ENOENT and .setup()
-			 * overrides it with the GPIO pin value
-			 * passed using platform data.
-			 */
-			spi->cs_gpio = -ENOENT;
-		}
-	}
+	/* This was dynamically allocated on the DT path */
+	if (spi->dev.of_node)
+		kfree(cs);
 
 	spi_set_ctldata(spi, NULL);
 }
@@ -1131,6 +1102,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	master->prepare_message = s3c64xx_spi_prepare_message;
 	master->transfer_one = s3c64xx_spi_transfer_one;
 	master->num_chipselect = sci->num_cs;
+	master->use_gpio_descriptors = true;
 	master->dma_alignment = 8;
 	master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(16) |
 					SPI_BPW_MASK(8);
diff --git a/include/linux/platform_data/spi-s3c64xx.h b/include/linux/platform_data/spi-s3c64xx.h
index 773daf7915a3..391f4dc68742 100644
--- a/include/linux/platform_data/spi-s3c64xx.h
+++ b/include/linux/platform_data/spi-s3c64xx.h
@@ -16,15 +16,13 @@ struct platform_device;
  * struct s3c64xx_spi_csinfo - ChipSelect description
  * @fb_delay: Slave specific feedback delay.
  *            Refer to FB_CLK_SEL register definition in SPI chapter.
- * @line: Custom 'identity' of the CS line.
  *
- * This is per SPI-Slave Chipselect information.
+ * This is per SPI-Slave FB delay information.
  * Allocate and initialize one in machine init code and make the
  * spi_board_info.controller_data point to it.
  */
 struct s3c64xx_spi_csinfo {
 	u8 fb_delay;
-	unsigned line;
 };
 
 /**
@@ -43,26 +41,16 @@ struct s3c64xx_spi_info {
 /**
  * s3c64xx_spi_set_platdata - SPI Controller configure callback by the board
  *				initialization code.
- * @cfg_gpio: Pointer to gpio setup function.
  * @src_clk_nr: Clock the SPI controller is to use to generate SPI clocks.
  * @num_cs: Number of elements in the 'cs' array.
  *
  * Call this from machine init code for each SPI Controller that
  * has some chips attached to it.
  */
-extern void s3c64xx_spi0_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
-						int num_cs);
-extern void s3c64xx_spi1_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
-						int num_cs);
-extern void s3c64xx_spi2_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
-						int num_cs);
+extern void s3c64xx_spi0_set_platdata(int src_clk_nr, int num_cs);
 
 /* defined by architecture to configure gpio */
 extern int s3c64xx_spi0_cfg_gpio(void);
-extern int s3c64xx_spi1_cfg_gpio(void);
-extern int s3c64xx_spi2_cfg_gpio(void);
 
 extern struct s3c64xx_spi_info s3c64xx_spi0_pdata;
-extern struct s3c64xx_spi_info s3c64xx_spi1_pdata;
-extern struct s3c64xx_spi_info s3c64xx_spi2_pdata;
 #endif /*__SPI_S3C64XX_H */
-- 
2.34.1

