Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D807B493137
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jan 2022 00:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350181AbiARXLp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jan 2022 18:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238171AbiARXLo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jan 2022 18:11:44 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27512C061574
        for <linux-spi@vger.kernel.org>; Tue, 18 Jan 2022 15:11:44 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id x7so1576758lfu.8
        for <linux-spi@vger.kernel.org>; Tue, 18 Jan 2022 15:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Bm2nPAuwxeCFPmiIYaA5fzTlNyHiNLpSwXtgJN/oWM=;
        b=LdjruFMFY9jpV632S7ZYCaW3mY92iGtGAvHxxP74GZyFYtF7kPqcgsXYOwtrWS0ITN
         nvSGhzk0V5tfMsra/SsvQg3OX2BHvxF/4fwfSsOg3q3HdjvAqCahmPb+OS1KPiDQu7O4
         i90b5CMOmS+D7IfhMdZqpBEP67W1oEH/eD3AnMGNlch4j+gjRwR221YqWFRIJMBQqJKB
         fK1LWeMMReYSl598FQE7Nv63wZUt1GWFrtR/DktQCeAeWNQIzqM944D+imF09VBPFTcn
         k+dkICuCW7drTRXULil7J/zn4MczV6AdAT8eyVg+NHcLmDLZC1JjGWMYnBydHAfHkx8J
         moMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Bm2nPAuwxeCFPmiIYaA5fzTlNyHiNLpSwXtgJN/oWM=;
        b=nL1neQthRWKEuod+d6FK84rFURXw2wOTMwZjOwHH15sTv/g+YCwJz7qJogPaQyHTZb
         uJ2KdpRXc1QfFHkaadSVj4WiL5yicbF9Uawui+8e7ErAFe2zjArZ4b6zrO1nm7X66kvO
         haP4D9xed2RKFbz9YxEkd+yYAY8jYwM1DCEm3GGmINkqlj3ig9Zae7YxAKKdxY/Z6h49
         rf0fPOAMZ8IRxVTEH5YazAfLlpkQKgwe7zwXz9WukJp08w2K/qTCFw82Bh3qt+0Yk3LX
         4ozJaVdLKDUXY4jrVOyB3FibCsinfQ+7ctJUCwB6lo+Yk6b03psjYMptFmS5WyjBill7
         BsIw==
X-Gm-Message-State: AOAM5303lKqf1GKZkwIr1I+MuVyPsbnIfHZbONUVLKfXp7dkL1H2qmaz
        yZSZlQj4oNQTbAe2Lg28L68hJg==
X-Google-Smtp-Source: ABdhPJyIjPeWj8EN7+5bQPMcoMvZ8W9HimKbKvwvvjK9wGVyhZKW+58TNps+DjuhFzK9kzi1aLBn6w==
X-Received: by 2002:a2e:8854:: with SMTP id z20mr412207ljj.343.1642547502481;
        Tue, 18 Jan 2022 15:11:42 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id k9sm1374938lfg.121.2022.01.18.15.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 15:11:41 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH 3/3 v3] spi: s3c64xx: Convert to use GPIO descriptors
Date:   Wed, 19 Jan 2022 00:09:15 +0100
Message-Id: <20220118230915.157797-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220118230915.157797-1-linus.walleij@linaro.org>
References: <20220118230915.157797-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Convert the S3C64xx SPI host to use GPIO descriptors.

Provide GPIO descriptor tables for the one user with CS
0 and 1.

Cc: linux-samsung-soc@vger.kernel.org
Cc: Sylwester Nawrocki <snawrocki@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Make sure to write a zero to the fb_delay if unused.
- Drop changes to chipselect data comments.
- Collect Review tags.
ChangeLog v1->v2:
- Split off code cleaning to separate patches
---
 arch/arm/mach-s3c/mach-crag6410-module.c  | 13 ------
 arch/arm/mach-s3c/mach-crag6410.c         | 11 +++++
 drivers/spi/spi-s3c64xx.c                 | 53 ++++++-----------------
 include/linux/platform_data/spi-s3c64xx.h |  2 -
 4 files changed, 24 insertions(+), 55 deletions(-)

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
index 41f0aba2d2fd..e3e0fe897bcc 100644
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
@@ -856,6 +865,8 @@ static void __init crag6410_machine_init(void)
 	i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
 
 	samsung_keypad_set_platdata(&crag6410_keypad_data);
+
+	gpiod_add_lookup_table(&crag_spi0_gpiod_table);
 	s3c64xx_spi0_set_platdata(0, 2);
 
 	pwm_add_table(crag6410_pwm_lookup, ARRAY_SIZE(crag6410_pwm_lookup));
diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 8755cd85e83c..3e42cdb19d27 100644
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
 
@@ -656,7 +654,11 @@ static int s3c64xx_spi_prepare_message(struct spi_master *master,
 	struct s3c64xx_spi_csinfo *cs = spi->controller_data;
 
 	/* Configure feedback delay */
-	writel(cs->fb_delay & 0x3, sdd->regs + S3C64XX_SPI_FB_CLK);
+	if (!cs)
+		/* No delay if not defined */
+		writel(0, sdd->regs + S3C64XX_SPI_FB_CLK);
+	else
+		writel(cs->fb_delay & 0x3, sdd->regs + S3C64XX_SPI_FB_CLK);
 
 	return 0;
 }
@@ -830,34 +832,16 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
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
 
@@ -909,11 +893,9 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 	/* setup() returns with device de-selected */
 	s3c64xx_spi_set_cs(spi, false);
 
-	if (gpio_is_valid(spi->cs_gpio))
-		gpio_free(spi->cs_gpio);
 	spi_set_ctldata(spi, NULL);
 
-err_gpio_req:
+	/* This was dynamically allocated on the DT path */
 	if (spi->dev.of_node)
 		kfree(cs);
 
@@ -924,19 +906,9 @@ static void s3c64xx_spi_cleanup(struct spi_device *spi)
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
@@ -1131,6 +1103,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	master->prepare_message = s3c64xx_spi_prepare_message;
 	master->transfer_one = s3c64xx_spi_transfer_one;
 	master->num_chipselect = sci->num_cs;
+	master->use_gpio_descriptors = true;
 	master->dma_alignment = 8;
 	master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(16) |
 					SPI_BPW_MASK(8);
diff --git a/include/linux/platform_data/spi-s3c64xx.h b/include/linux/platform_data/spi-s3c64xx.h
index 10890a4b55b9..5df1ace6d2c9 100644
--- a/include/linux/platform_data/spi-s3c64xx.h
+++ b/include/linux/platform_data/spi-s3c64xx.h
@@ -16,7 +16,6 @@ struct platform_device;
  * struct s3c64xx_spi_csinfo - ChipSelect description
  * @fb_delay: Slave specific feedback delay.
  *            Refer to FB_CLK_SEL register definition in SPI chapter.
- * @line: Custom 'identity' of the CS line.
  *
  * This is per SPI-Slave Chipselect information.
  * Allocate and initialize one in machine init code and make the
@@ -24,7 +23,6 @@ struct platform_device;
  */
 struct s3c64xx_spi_csinfo {
 	u8 fb_delay;
-	unsigned line;
 };
 
 /**
-- 
2.34.1

