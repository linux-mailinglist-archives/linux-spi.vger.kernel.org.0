Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20CA66B10C
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2019 23:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388864AbfGPVYW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jul 2019 17:24:22 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44789 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728405AbfGPVYV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Jul 2019 17:24:21 -0400
Received: by mail-lf1-f68.google.com with SMTP id r15so9912043lfm.11
        for <linux-spi@vger.kernel.org>; Tue, 16 Jul 2019 14:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0+F7TdvxOkYZVvwFe9Q9elJoRjFjJDD4WE4rkH+y1Qo=;
        b=clGfh2w5Xao51D8g7yP4c/LLmuxF1GTe0zPIo90z4fVH8aKYcMoFzOjDc08RZ/rWQq
         a7rTmCeDsZmDPwyXEhHFXYNVq/ArWL/pNjTLeqWiJxkPwk5V/xmFCG4NWVourE/lUvUe
         dbetimfC8vCtxTaAUMVGfc/TPlhaEBedaWvgQu4iS9q1rSQzYW6+Wy+hoWkVU+WAR1xu
         cMjz9TySAdKLf8dQlrALpmco6aqw5pDjQCSiU9Euxj7YsJbiGyRTSToxkpPHuB3m/rVa
         xSO6NI9+ZuOTqLJZWIGx1iwG0EJDvmXmci54QB6ct9DrOFS0Wkr5SyrDHIV3ANApNVmB
         1sWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0+F7TdvxOkYZVvwFe9Q9elJoRjFjJDD4WE4rkH+y1Qo=;
        b=m4koXhmt07xsd4VMmlNabHzvdoEUXwBsybwQYUMH9GbY8YS0m3Lh/3Df01DTvwgbW1
         foJ5dzuJ9uo3Jqp8HUKxk661KylHG/r5eROEWeRMW/pNuYV2ZOdYA1aRCMqD3EGsJYBI
         qntAZ62AM85WKNsJ1PK/FoZOZsImDLlUtsB89tBUCSimwmGqynzgDf3/6eZQ7x/yaji9
         Jfe90ZA5vFu3tYD4oR2/pBWU/AXq5wgw1/xmSNgqMrAbOBixuGC6tZewyR8pF51CBj/8
         nIklI9dcQ/0Ge+sagdNidnI24Aw8+KJ7/Kd4uehu2f6fzexR5fH3ys7fEDBUYvYb3U+l
         KIzw==
X-Gm-Message-State: APjAAAVCkZUQ364b/C8W27J04dHeM/Ij2veumlaNrXQaX0/UOlKOzbsa
        ApaAjV4NiNaiYAjjBXFGq+3LNg==
X-Google-Smtp-Source: APXvYqyAlJa/0PagaVtrhTjvB9ttCBySaeujSKJxldumyQu4jx2Hd8nx8irIkrP/vYn0rsSojnSVpQ==
X-Received: by 2002:ac2:46d5:: with SMTP id p21mr15456569lfo.133.1563312257931;
        Tue, 16 Jul 2019 14:24:17 -0700 (PDT)
Received: from localhost.bredbandsbolaget (c-22cd225c.014-348-6c756e10.bbcust.telenor.se. [92.34.205.34])
        by smtp.gmail.com with ESMTPSA id r24sm4429028ljb.72.2019.07.16.14.24.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 14:24:16 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH] spi: gpio: Use core CS GPIO handling for everything
Date:   Tue, 16 Jul 2019 23:24:13 +0200
Message-Id: <20190716212413.30974-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The SPI core can handle all CS GPIOs without any problem.
As can be seen from the code in spi_get_gpio_descs()
the core will just get a bunch of chip selects from
the device.

When using GPIO descriptors from a board file, the
process is not any different.

However we need to be carefule about one thing:
devm_gpiod_get_index_optional() passes GPIOD_OUT_LOW
in the core and GPIOD_OUT_HIGH in the spi-gpio driver.
This is because the driver assumes the polarity
inversion is not handled by the core.

We need to revisit commit 9b00bc7b901f
("spi: spi-gpio: Rewrite to use GPIO descriptors")
and make sure all passed descriptors are flagged as
active low for the core, because now they are passed
in as active high and inverted by the driver instead.
The device tree core will enforce active low on
CS gpios, but board files are not that forgiving.

Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-pxa/cm-x300.c            |  2 +-
 arch/arm/mach-s3c24xx/mach-jive.c      |  4 +-
 arch/arm/mach-s3c24xx/mach-qt2410.c    |  2 +-
 arch/arm/mach-s3c64xx/mach-smartq.c    |  2 +-
 arch/mips/alchemy/devboards/db1000.c   |  2 +-
 arch/mips/jz4740/board-qi_lb60.c       |  2 +-
 drivers/misc/eeprom/digsy_mtc_eeprom.c |  2 +-
 drivers/spi/spi-gpio.c                 | 59 ++------------------------
 8 files changed, 12 insertions(+), 63 deletions(-)

diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index 425855f456f2..60ebc5f4041e 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -362,7 +362,7 @@ static struct gpiod_lookup_table cm_x300_spi_gpiod_table = {
 		GPIO_LOOKUP("gpio-pxa", GPIO_LCD_DOUT,
 			    "miso", GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP("gpio-pxa", GPIO_LCD_CS,
-			    "cs", GPIO_ACTIVE_HIGH),
+			    "cs", GPIO_ACTIVE_LOW),
 		{ },
 	},
 };
diff --git a/arch/arm/mach-s3c24xx/mach-jive.c b/arch/arm/mach-s3c24xx/mach-jive.c
index 885e8f12e4b9..66c38472111d 100644
--- a/arch/arm/mach-s3c24xx/mach-jive.c
+++ b/arch/arm/mach-s3c24xx/mach-jive.c
@@ -406,7 +406,7 @@ static struct gpiod_lookup_table jive_lcdspi_gpiod_table = {
 		GPIO_LOOKUP("GPIOB", 8,
 			    "mosi", GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP("GPIOB", 7,
-			    "cs", GPIO_ACTIVE_HIGH),
+			    "cs", GPIO_ACTIVE_LOW),
 		{ },
 	},
 };
@@ -431,7 +431,7 @@ static struct gpiod_lookup_table jive_wm8750_gpiod_table = {
 		GPIO_LOOKUP("GPIOB", 9,
 			    "mosi", GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP("GPIOH", 10,
-			    "cs", GPIO_ACTIVE_HIGH),
+			    "cs", GPIO_ACTIVE_LOW),
 		{ },
 	},
 };
diff --git a/arch/arm/mach-s3c24xx/mach-qt2410.c b/arch/arm/mach-s3c24xx/mach-qt2410.c
index 5d48e5b6e738..61fbd3694257 100644
--- a/arch/arm/mach-s3c24xx/mach-qt2410.c
+++ b/arch/arm/mach-s3c24xx/mach-qt2410.c
@@ -214,7 +214,7 @@ static struct gpiod_lookup_table qt2410_spi_gpiod_table = {
 		GPIO_LOOKUP("GPIOG", 5,
 			    "miso", GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP("GPIOB", 5,
-			    "cs", GPIO_ACTIVE_HIGH),
+			    "cs", GPIO_ACTIVE_LOW),
 		{ },
 	},
 };
diff --git a/arch/arm/mach-s3c64xx/mach-smartq.c b/arch/arm/mach-s3c64xx/mach-smartq.c
index 951208f168e7..f81a85c75247 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq.c
@@ -225,7 +225,7 @@ static struct gpiod_lookup_table smartq_lcd_control_gpiod_table = {
 		GPIO_LOOKUP("GPIOM", 3,
 			    "miso", GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP("GPIOM", 0,
-			    "cs", GPIO_ACTIVE_HIGH),
+			    "cs", GPIO_ACTIVE_LOW),
 		{ },
 	},
 };
diff --git a/arch/mips/alchemy/devboards/db1000.c b/arch/mips/alchemy/devboards/db1000.c
index 2c52ee27b4f2..aa3b5b3d81aa 100644
--- a/arch/mips/alchemy/devboards/db1000.c
+++ b/arch/mips/alchemy/devboards/db1000.c
@@ -424,7 +424,7 @@ static struct gpiod_lookup_table db1100_spi_gpiod_table = {
 		GPIO_LOOKUP("alchemy-gpio2", 7,
 			    "miso", GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP("alchemy-gpio2", 10,
-			    "cs", GPIO_ACTIVE_HIGH),
+			    "cs", GPIO_ACTIVE_LOW),
 		{ },
 	},
 };
diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index 071e9d94eea7..9ea53398c0f1 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -328,7 +328,7 @@ static struct gpiod_lookup_table qi_lb60_spigpio_gpio_table = {
 		GPIO_LOOKUP("GPIOC", 22,
 			    "mosi", GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP("GPIOC", 21,
-			    "cs", GPIO_ACTIVE_HIGH),
+			    "cs", GPIO_ACTIVE_LOW),
 		{ },
 	},
 };
diff --git a/drivers/misc/eeprom/digsy_mtc_eeprom.c b/drivers/misc/eeprom/digsy_mtc_eeprom.c
index f1f766b70965..c058eaff0385 100644
--- a/drivers/misc/eeprom/digsy_mtc_eeprom.c
+++ b/drivers/misc/eeprom/digsy_mtc_eeprom.c
@@ -69,7 +69,7 @@ static struct gpiod_lookup_table eeprom_spi_gpiod_table = {
 		GPIO_LOOKUP("gpio@b00", GPIO_EEPROM_DO,
 			    "miso", GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP("gpio@b00", GPIO_EEPROM_CS,
-			    "cs", GPIO_ACTIVE_HIGH),
+			    "cs", GPIO_ACTIVE_LOW),
 		{ },
 	},
 };
diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 9eb82150666e..4309832221b1 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -35,7 +35,6 @@ struct spi_gpio {
 	struct gpio_desc		*sck;
 	struct gpio_desc		*miso;
 	struct gpio_desc		*mosi;
-	struct gpio_desc		**cs_gpios;
 };
 
 /*----------------------------------------------------------------------*/
@@ -203,37 +202,6 @@ static void spi_gpio_chipselect(struct spi_device *spi, int is_active)
 	/* set initial clock line level */
 	if (is_active)
 		gpiod_set_value_cansleep(spi_gpio->sck, spi->mode & SPI_CPOL);
-
-	/* Drive chip select line, if we have one */
-	if (spi_gpio->cs_gpios) {
-		struct gpio_desc *cs = spi_gpio->cs_gpios[spi->chip_select];
-
-		/* SPI chip selects are normally active-low */
-		gpiod_set_value_cansleep(cs, (spi->mode & SPI_CS_HIGH) ? is_active : !is_active);
-	}
-}
-
-static int spi_gpio_setup(struct spi_device *spi)
-{
-	struct gpio_desc	*cs;
-	int			status = 0;
-	struct spi_gpio		*spi_gpio = spi_to_spi_gpio(spi);
-
-	/*
-	 * The CS GPIOs have already been
-	 * initialized from the descriptor lookup.
-	 */
-	if (spi_gpio->cs_gpios) {
-		cs = spi_gpio->cs_gpios[spi->chip_select];
-		if (!spi->controller_state && cs)
-			status = gpiod_direction_output(cs,
-						  !(spi->mode & SPI_CS_HIGH));
-	}
-
-	if (!status)
-		status = spi_bitbang_setup(spi);
-
-	return status;
 }
 
 static int spi_gpio_set_direction(struct spi_device *spi, bool output)
@@ -264,11 +232,6 @@ static int spi_gpio_set_direction(struct spi_device *spi, bool output)
 	return 0;
 }
 
-static void spi_gpio_cleanup(struct spi_device *spi)
-{
-	spi_bitbang_cleanup(spi);
-}
-
 /*
  * It can be convenient to use this driver with pins that have alternate
  * functions associated with a "native" SPI controller if a driver for that
@@ -324,8 +287,6 @@ static int spi_gpio_probe_pdata(struct platform_device *pdev,
 {
 	struct device *dev = &pdev->dev;
 	struct spi_gpio_platform_data *pdata = dev_get_platdata(dev);
-	struct spi_gpio *spi_gpio = spi_master_get_devdata(master);
-	int i;
 
 #ifdef GENERIC_BITBANG
 	if (!pdata || !pdata->num_chipselect)
@@ -335,20 +296,8 @@ static int spi_gpio_probe_pdata(struct platform_device *pdev,
 	 * The master needs to think there is a chipselect even if not
 	 * connected
 	 */
-	master->num_chipselect = pdata->num_chipselect ?: 1;
-
-	spi_gpio->cs_gpios = devm_kcalloc(dev, master->num_chipselect,
-					  sizeof(*spi_gpio->cs_gpios),
-					  GFP_KERNEL);
-	if (!spi_gpio->cs_gpios)
-		return -ENOMEM;
-
-	for (i = 0; i < master->num_chipselect; i++) {
-		spi_gpio->cs_gpios[i] = devm_gpiod_get_index(dev, "cs", i,
-							     GPIOD_OUT_HIGH);
-		if (IS_ERR(spi_gpio->cs_gpios[i]))
-			return PTR_ERR(spi_gpio->cs_gpios[i]);
-	}
+	master->num_chipselect = pdata->num_chipselect ? : 1;
+	master->use_gpio_descriptors = true;
 
 	return 0;
 }
@@ -405,8 +354,8 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	}
 
 	master->bus_num = pdev->id;
-	master->setup = spi_gpio_setup;
-	master->cleanup = spi_gpio_cleanup;
+	master->setup = spi_bitbang_setup;
+	master->cleanup = spi_bitbang_cleanup;
 
 	bb = &spi_gpio->bitbang;
 	bb->master = master;
-- 
2.21.0

