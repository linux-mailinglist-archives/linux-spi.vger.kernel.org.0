Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178A320A651
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jun 2020 22:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406905AbgFYUDD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 25 Jun 2020 16:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406569AbgFYUDC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 25 Jun 2020 16:03:02 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167D1C08C5C1
        for <linux-spi@vger.kernel.org>; Thu, 25 Jun 2020 13:03:02 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id n23so7913905ljh.7
        for <linux-spi@vger.kernel.org>; Thu, 25 Jun 2020 13:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sE87Cw3X9MeLrKDxNI5r4OSmsh4JdfF/FGu6WUM7TIk=;
        b=LZlcgKMyUqtC4j7/zAAB/0/6IbzkFH7Tb7rz9/1tlTkAIqlpOaoQLM3YBI4Pdwq58e
         0qRr3GhKq+v9k/3zz1ZgFtco9BBABBA+uP5ANNG8wzDz0kkl3ZfHfNwGstIcS4Z+qptc
         gjLQmZzFlTS8m/PjGZwph4y3rz0Tlg8p6Vxp1llQQzsyKxqN31TvIwqs6Jhd86eenhqv
         J5MqelzOUHXp4R1oaK2nkl8n+Xiwv1QDTUYtxADrLNwvsfRrMVffACGGtCAjx4Uk8sPc
         tmWqo9EIqJqSwRqmdl9RhfQ4qfn1EdseA7tl50dLUWqAlZoNT8jc569QttlwvdgfuexW
         IK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sE87Cw3X9MeLrKDxNI5r4OSmsh4JdfF/FGu6WUM7TIk=;
        b=RwUw1c47jlXd56RbWM7dgTGwD85v/00DvbS4w54kn4pjRNSA7M6/aP0upgzKi2Gxez
         v3p2oDfkPt1kzb+Lbu+SszaxmEyhdls/XKp3oUjUycqOFyOZajMVqpNcDnL+E3Jec6mj
         ZQGk1pqhkV1hRgKZDYoS5S2AcqhZZzONVBwZCC+mOMRGF1d6AXyzYp542N737cJNy/AB
         90WHMX56HjZqBXjIn54j4uzLPNB9184q9I8+AevRrW1w/uvGPf9gJQWMbDHDZnHWIZ5X
         lv5fx5wOz6xr1HwiCSEvJ57QE82ijF4eVWfAxwUR39DnReUrPStaCAaeNtOLLOECw9cf
         0Gzw==
X-Gm-Message-State: AOAM532o5L5qx+E25gmVJiyUO/GY6aqGbjEohznSluDuU8y9eQQKmoOk
        P/2kSYYoT939aSfDfjzUBGv2pldaEzY=
X-Google-Smtp-Source: ABdhPJzVr3g6LZMSqHrg6lLKWh7x4Y3T8bzzwhaWCpsdhDrCgUrRHYMTUXkRcAGgS2ME9XtmqB+WbQ==
X-Received: by 2002:a2e:751a:: with SMTP id q26mr16239311ljc.258.1593115380233;
        Thu, 25 Jun 2020 13:03:00 -0700 (PDT)
Received: from genomnajs.lan (c-d63ee155.152980-0-69706f6e6c79.bbcust.telenor.se. [85.225.62.214])
        by smtp.gmail.com with ESMTPSA id w6sm5012143ljw.11.2020.06.25.13.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 13:02:59 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Robin Gong <yibin.gong@nxp.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH] spi: imx/fsl-lpspi: Convert to GPIO descriptors
Date:   Thu, 25 Jun 2020 22:02:52 +0200
Message-Id: <20200625200252.207614-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This converts the two Freescale i.MX SPI drivers
Freescale i.MX (CONFIG_SPI_IMX) and Freescale i.MX LPSPI
(CONFIG_SPI_FSL_LPSPI) to use GPIO descriptors handled in
the SPI core for GPIO chip selects whether defined in
the device tree or a board file.

The reason why both are converted at the same time is
that they were both using the same platform data and
platform device population helpers when using
board files intertwining the code so this gives a cleaner
cut.

The platform device creation was passing a platform data
container from each boardfile down to the driver using
struct spi_imx_master from <linux/platform_data/spi-imx.h>,
but this was only conveying the number of chipselects and
an int * array of the chipselect GPIO numbers.

The imx27 and imx31 platforms had code passing the
now-unused platform data when creating the platform devices,
this has been repurposed to pass around GPIO descriptor
tables. The platform data struct that was just passing an
array of integers and number of chip selects for the GPIO
lines has been removed.

The number of chipselects used to be passed from the board
file, because this number also limits the number of native
chipselects that the platform can use. To deal with this we
just augment the i.MX (CONFIG_SPI_IMX) driver to support 3
chipselects if the platform does not define "num-cs" as a
device property (such as from the device tree). This covers
all the legacy boards as these use <= 3 native chip selects
(or GPIO lines, and in that case the number of chip selects
is determined by the core from the number of available
GPIO lines). Any new boards should use device tree, so
this is a reasonable simplification to cover all old
boards.

The LPSPI driver never assigned the number of chipselects
and thus always fall back to the core default of 1 chip
select if no GPIOs are defined in the device tree.

The Freescale i.MX driver was already partly utilizing
the SPI core to obtain the GPIO numbers from the device tree,
so this completes the transtion to let the core handle all
of it.

All board files and the core i.MX boardfile registration
code is augmented to account for these changes.

This has been compile-tested with the imx_v4_v5_defconfig
and the imx_v6_v7_defconfig.

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Robin Gong <yibin.gong@nxp.com>
Cc: Trent Piepho <tpiepho@impinj.com>
Cc: Clark Wang <xiaoning.wang@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-imx/devices-imx27.h            | 10 +--
 arch/arm/mach-imx/devices-imx31.h            | 10 +--
 arch/arm/mach-imx/devices/devices-common.h   |  5 +-
 arch/arm/mach-imx/devices/platform-spi_imx.c |  9 +-
 arch/arm/mach-imx/mach-mx27_3ds.c            | 40 ++++++---
 arch/arm/mach-imx/mach-mx31_3ds.c            | 13 +--
 arch/arm/mach-imx/mach-mx31lilly.c           | 14 +--
 arch/arm/mach-imx/mach-mx31lite.c            | 19 +---
 arch/arm/mach-imx/mach-mx31moboard.c         | 12 +--
 arch/arm/mach-imx/mach-pca100.c              | 21 +++--
 arch/arm/mach-imx/mach-pcm037_eet.c          |  7 +-
 drivers/spi/spi-fsl-lpspi.c                  | 47 +---------
 drivers/spi/spi-imx.c                        | 92 ++++----------------
 include/linux/platform_data/spi-imx.h        | 33 -------
 14 files changed, 88 insertions(+), 244 deletions(-)
 delete mode 100644 include/linux/platform_data/spi-imx.h

diff --git a/arch/arm/mach-imx/devices-imx27.h b/arch/arm/mach-imx/devices-imx27.h
index f89f4ae0e1ca..583a1d773d68 100644
--- a/arch/arm/mach-imx/devices-imx27.h
+++ b/arch/arm/mach-imx/devices-imx27.h
@@ -75,11 +75,11 @@ extern const struct imx_mxc_w1_data imx27_mxc_w1_data;
 	imx_add_mxc_w1(&imx27_mxc_w1_data)
 
 extern const struct imx_spi_imx_data imx27_cspi_data[];
-#define imx27_add_cspi(id, pdata)	\
-	imx_add_spi_imx(&imx27_cspi_data[id], pdata)
-#define imx27_add_spi_imx0(pdata)	imx27_add_cspi(0, pdata)
-#define imx27_add_spi_imx1(pdata)	imx27_add_cspi(1, pdata)
-#define imx27_add_spi_imx2(pdata)	imx27_add_cspi(2, pdata)
+#define imx27_add_cspi(id, gtable) \
+	imx_add_spi_imx(&imx27_cspi_data[id], gtable)
+#define imx27_add_spi_imx0(gtable)	imx27_add_cspi(0, gtable)
+#define imx27_add_spi_imx1(gtable)	imx27_add_cspi(1, gtable)
+#define imx27_add_spi_imx2(gtable)	imx27_add_cspi(2, gtable)
 
 extern const struct imx_pata_imx_data imx27_pata_imx_data;
 #define imx27_add_pata_imx() \
diff --git a/arch/arm/mach-imx/devices-imx31.h b/arch/arm/mach-imx/devices-imx31.h
index 5a4ba35a47ed..f7cc62372532 100644
--- a/arch/arm/mach-imx/devices-imx31.h
+++ b/arch/arm/mach-imx/devices-imx31.h
@@ -69,11 +69,11 @@ extern const struct imx_mxc_w1_data imx31_mxc_w1_data;
 	imx_add_mxc_w1(&imx31_mxc_w1_data)
 
 extern const struct imx_spi_imx_data imx31_cspi_data[];
-#define imx31_add_cspi(id, pdata)	\
-	imx_add_spi_imx(&imx31_cspi_data[id], pdata)
-#define imx31_add_spi_imx0(pdata)	imx31_add_cspi(0, pdata)
-#define imx31_add_spi_imx1(pdata)	imx31_add_cspi(1, pdata)
-#define imx31_add_spi_imx2(pdata)	imx31_add_cspi(2, pdata)
+#define imx31_add_cspi(id, gtable) \
+	imx_add_spi_imx(&imx31_cspi_data[id], gtable)
+#define imx31_add_spi_imx0(gtable)	imx31_add_cspi(0, gtable)
+#define imx31_add_spi_imx1(gtable)	imx31_add_cspi(1, gtable)
+#define imx31_add_spi_imx2(gtable)	imx31_add_cspi(2, gtable)
 
 extern const struct imx_pata_imx_data imx31_pata_imx_data;
 #define imx31_add_pata_imx() \
diff --git a/arch/arm/mach-imx/devices/devices-common.h b/arch/arm/mach-imx/devices/devices-common.h
index 2a685adec1df..f8f3e4967c31 100644
--- a/arch/arm/mach-imx/devices/devices-common.h
+++ b/arch/arm/mach-imx/devices/devices-common.h
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/init.h>
+#include <linux/gpio/machine.h>
 #include <linux/platform_data/dma-imx-sdma.h>
 
 extern struct device mxc_aips_bus;
@@ -276,7 +277,6 @@ struct platform_device *__init imx_add_sdhci_esdhc_imx(
 		const struct imx_sdhci_esdhc_imx_data *data,
 		const struct esdhc_platform_data *pdata);
 
-#include <linux/platform_data/spi-imx.h>
 struct imx_spi_imx_data {
 	const char *devid;
 	int id;
@@ -285,8 +285,7 @@ struct imx_spi_imx_data {
 	int irq;
 };
 struct platform_device *__init imx_add_spi_imx(
-		const struct imx_spi_imx_data *data,
-		const struct spi_imx_master *pdata);
+	const struct imx_spi_imx_data *data, struct gpiod_lookup_table *gtable);
 
 struct platform_device *imx_add_imx_dma(char *name, resource_size_t iobase,
 					int irq, int irq_err);
diff --git a/arch/arm/mach-imx/devices/platform-spi_imx.c b/arch/arm/mach-imx/devices/platform-spi_imx.c
index f2cafa52c187..27747bf628a3 100644
--- a/arch/arm/mach-imx/devices/platform-spi_imx.c
+++ b/arch/arm/mach-imx/devices/platform-spi_imx.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2009-2010 Pengutronix
  * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
  */
+#include <linux/gpio/machine.h>
 #include "../hardware.h"
 #include "devices-common.h"
 
@@ -57,8 +58,7 @@ const struct imx_spi_imx_data imx35_cspi_data[] __initconst = {
 #endif /* ifdef CONFIG_SOC_IMX35 */
 
 struct platform_device *__init imx_add_spi_imx(
-		const struct imx_spi_imx_data *data,
-		const struct spi_imx_master *pdata)
+	const struct imx_spi_imx_data *data, struct gpiod_lookup_table *gtable)
 {
 	struct resource res[] = {
 		{
@@ -71,7 +71,8 @@ struct platform_device *__init imx_add_spi_imx(
 			.flags = IORESOURCE_IRQ,
 		},
 	};
-
+	if (gtable)
+		gpiod_add_lookup_table(gtable);
 	return imx_add_platform_device(data->devid, data->id,
-			res, ARRAY_SIZE(res), pdata, sizeof(*pdata));
+			res, ARRAY_SIZE(res), NULL, 0);
 }
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 1da5f07952ac..2db4475b7f85 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -303,18 +303,34 @@ static struct imx_ssi_platform_data mx27_3ds_ssi_pdata = {
 };
 
 /* SPI */
-static int spi1_chipselect[] = {SPI1_SS0};
-
-static const struct spi_imx_master spi1_pdata __initconst = {
-	.chipselect	= spi1_chipselect,
-	.num_chipselect	= ARRAY_SIZE(spi1_chipselect),
+static struct gpiod_lookup_table mx27_spi1_gpiod_table = {
+	.dev_id = "imx27-cspi.0", /* Actual device name for spi1 */
+	.table = {
+		/*
+		 * The i.MX27 has the i.MX21 GPIO controller, the SPI1 CS GPIO
+		 * SPI1_SS0 is numbered IMX_GPIO_NR(4, 28).
+		 *
+		 * This is in "bank 4" which is subtracted by one in the macro
+		 * so this is actually bank 3 on "imx21-gpio.3".
+		 */
+		GPIO_LOOKUP_IDX("imx21-gpio.3", 28, "cs", 0, GPIO_ACTIVE_LOW),
+		{ },
+	},
 };
 
-static int spi2_chipselect[] = {SPI2_SS0};
-
-static const struct spi_imx_master spi2_pdata __initconst = {
-	.chipselect	= spi2_chipselect,
-	.num_chipselect	= ARRAY_SIZE(spi2_chipselect),
+static struct gpiod_lookup_table mx27_spi2_gpiod_table = {
+	.dev_id = "imx27-cspi.1", /* Actual device name for spi2 */
+	.table = {
+		/*
+		 * The i.MX27 has the i.MX21 GPIO controller, the SPI2 CS GPIO
+		 * SPI2_SS0 is numbered IMX_GPIO_NR(4, 21).
+		 *
+		 * This is in "bank 4" which is subtracted by one in the macro
+		 * so this is actually bank 3 on "imx21-gpio.3".
+		 */
+		GPIO_LOOKUP_IDX("imx21-gpio.3", 21, "cs", 0, GPIO_ACTIVE_LOW),
+		{ },
+	},
 };
 
 static struct imx_fb_videomode mx27_3ds_modes[] = {
@@ -397,8 +413,8 @@ static void __init mx27pdk_init(void)
 	imx27_add_imx_keypad(&mx27_3ds_keymap_data);
 	imx27_add_imx2_wdt();
 
-	imx27_add_spi_imx1(&spi2_pdata);
-	imx27_add_spi_imx0(&spi1_pdata);
+	imx27_add_spi_imx1(&mx27_spi2_gpiod_table);
+	imx27_add_spi_imx0(&mx27_spi1_gpiod_table);
 
 	imx27_add_imx_i2c(0, &mx27_3ds_i2c0_data);
 	imx27_add_imx_fb(&mx27_3ds_fb_data);
diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
index e81386190479..23e63d3b4c6a 100644
--- a/arch/arm/mach-imx/mach-mx31_3ds.c
+++ b/arch/arm/mach-imx/mach-mx31_3ds.c
@@ -378,15 +378,6 @@ static struct imx_ssi_platform_data mx31_3ds_ssi_pdata = {
 	.flags = IMX_SSI_DMA | IMX_SSI_NET,
 };
 
-/* SPI */
-static const struct spi_imx_master spi0_pdata __initconst = {
-	.num_chipselect	= 3,
-};
-
-static const struct spi_imx_master spi1_pdata __initconst = {
-	.num_chipselect	= 3,
-};
-
 static struct spi_board_info mx31_3ds_spi_devs[] __initdata = {
 	{
 		.modalias	= "mc13783",
@@ -561,14 +552,14 @@ static void __init mx31_3ds_init(void)
 	imx31_add_imx_uart0(&uart_pdata);
 	imx31_add_mxc_nand(&mx31_3ds_nand_board_info);
 
-	imx31_add_spi_imx1(&spi1_pdata);
+	imx31_add_spi_imx1(NULL);
 
 	imx31_add_imx_keypad(&mx31_3ds_keymap_data);
 
 	imx31_add_imx2_wdt();
 	imx31_add_imx_i2c0(&mx31_3ds_i2c0_data);
 
-	imx31_add_spi_imx0(&spi0_pdata);
+	imx31_add_spi_imx0(NULL);
 	imx31_add_ipu_core();
 	imx31_add_mx3_sdc_fb(&mx3fb_pdata);
 
diff --git a/arch/arm/mach-imx/mach-mx31lilly.c b/arch/arm/mach-imx/mach-mx31lilly.c
index 8f725248299e..4b955ccc92cd 100644
--- a/arch/arm/mach-imx/mach-mx31lilly.c
+++ b/arch/arm/mach-imx/mach-mx31lilly.c
@@ -215,16 +215,6 @@ static void __init lilly1131_usb_init(void)
 		imx31_add_mxc_ehci_hs(2, &usbh2_pdata);
 }
 
-/* SPI */
-
-static const struct spi_imx_master spi0_pdata __initconst = {
-	.num_chipselect = 3,
-};
-
-static const struct spi_imx_master spi1_pdata __initconst = {
-	.num_chipselect = 3,
-};
-
 static struct mc13xxx_platform_data mc13783_pdata __initdata = {
 	.flags = MC13XXX_USE_RTC | MC13XXX_USE_TOUCHSCREEN,
 };
@@ -281,8 +271,8 @@ static void __init mx31lilly_board_init(void)
 	mxc_iomux_alloc_pin(MX31_PIN_CSPI2_SS1__SS1, "SPI2_SS1");
 	mxc_iomux_alloc_pin(MX31_PIN_CSPI2_SS2__SS2, "SPI2_SS2");
 
-	imx31_add_spi_imx0(&spi0_pdata);
-	imx31_add_spi_imx1(&spi1_pdata);
+	imx31_add_spi_imx0(NULL);
+	imx31_add_spi_imx1(NULL);
 
 	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 }
diff --git a/arch/arm/mach-imx/mach-mx31lite.c b/arch/arm/mach-imx/mach-mx31lite.c
index c0055f57c02d..aaccf52f7ac1 100644
--- a/arch/arm/mach-imx/mach-mx31lite.c
+++ b/arch/arm/mach-imx/mach-mx31lite.c
@@ -73,11 +73,6 @@ static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
-/* SPI */
-static const struct spi_imx_master spi0_pdata __initconst = {
-	.num_chipselect	= 3,
-};
-
 static const struct mxc_nand_platform_data
 mx31lite_nand_board_info __initconst  = {
 	.width = 1,
@@ -111,16 +106,6 @@ static struct platform_device smsc911x_device = {
 	},
 };
 
-/*
- * SPI
- *
- * The MC13783 is the only hard-wired SPI device on the module.
- */
-
-static const struct spi_imx_master spi1_pdata __initconst = {
-	.num_chipselect	= 1,
-};
-
 static struct mc13xxx_platform_data mc13783_pdata __initdata = {
 	.flags = MC13XXX_USE_RTC,
 };
@@ -246,13 +231,13 @@ static void __init mx31lite_init(void)
 				      "mx31lite");
 
 	imx31_add_imx_uart0(&uart_pdata);
-	imx31_add_spi_imx0(&spi0_pdata);
+	imx31_add_spi_imx0(NULL);
 
 	/* NOR and NAND flash */
 	platform_device_register(&physmap_flash_device);
 	imx31_add_mxc_nand(&mx31lite_nand_board_info);
 
-	imx31_add_spi_imx1(&spi1_pdata);
+	imx31_add_spi_imx1(NULL);
 
 	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 }
diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index 36f08f45b0ca..96845a4eaf57 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -143,10 +143,6 @@ static const struct imxi2c_platform_data moboard_i2c1_data __initconst = {
 	.bitrate = 100000,
 };
 
-static const struct spi_imx_master moboard_spi1_pdata __initconst = {
-	.num_chipselect	= 3,
-};
-
 static struct regulator_consumer_supply sdhc_consumers[] = {
 	{
 		.dev_name = "imx31-mmc.0",
@@ -287,10 +283,6 @@ static struct spi_board_info moboard_spi_board_info[] __initdata = {
 	},
 };
 
-static const struct spi_imx_master moboard_spi2_pdata __initconst = {
-	.num_chipselect	= 2,
-};
-
 #define SDHC1_CD IOMUX_TO_GPIO(MX31_PIN_ATA_CS0)
 #define SDHC1_WP IOMUX_TO_GPIO(MX31_PIN_ATA_CS1)
 
@@ -514,8 +506,8 @@ static void __init mx31moboard_init(void)
 	imx31_add_imx_i2c0(&moboard_i2c0_data);
 	imx31_add_imx_i2c1(&moboard_i2c1_data);
 
-	imx31_add_spi_imx1(&moboard_spi1_pdata);
-	imx31_add_spi_imx2(&moboard_spi2_pdata);
+	imx31_add_spi_imx1(NULL);
+	imx31_add_spi_imx2(NULL);
 
 	mx31moboard_init_cam();
 
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index 2e28e1b5cddf..27a3678e0658 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -14,6 +14,7 @@
 #include <linux/irq.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
 
@@ -188,11 +189,19 @@ static struct spi_board_info pca100_spi_board_info[] __initdata = {
 	},
 };
 
-static int pca100_spi_cs[] = {SPI1_SS0, SPI1_SS1};
-
-static const struct spi_imx_master pca100_spi0_data __initconst = {
-	.chipselect	= pca100_spi_cs,
-	.num_chipselect = ARRAY_SIZE(pca100_spi_cs),
+static struct gpiod_lookup_table pca100_spi0_gpiod_table = {
+	.dev_id = "imx27-cspi.0", /* Actual device name for spi0 */
+	.table = {
+		/*
+		 * The i.MX27 has the i.MX21 GPIO controller, port D is
+		 * bank 3 and thus named "imx21-gpio.3".
+		 * SPI1_SS0 is GPIO_PORTD + 28
+		 * SPI1_SS1 is GPIO_PORTD + 27
+		 */
+		GPIO_LOOKUP_IDX("imx21-gpio.3", 28, "cs", 0, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("imx21-gpio.3", 27, "cs", 1, GPIO_ACTIVE_LOW),
+		{ },
+	},
 };
 
 static void pca100_ac97_warm_reset(struct snd_ac97 *ac97)
@@ -362,7 +371,7 @@ static void __init pca100_init(void)
 	mxc_gpio_mode(GPIO_PORTD | 27 | GPIO_GPIO | GPIO_IN);
 	spi_register_board_info(pca100_spi_board_info,
 				ARRAY_SIZE(pca100_spi_board_info));
-	imx27_add_spi_imx0(&pca100_spi0_data);
+	imx27_add_spi_imx0(&pca100_spi0_gpiod_table);
 
 	imx27_add_imx_fb(&pca100_fb_data);
 
diff --git a/arch/arm/mach-imx/mach-pcm037_eet.c b/arch/arm/mach-imx/mach-pcm037_eet.c
index 51f5142920cf..8b0e03a595c1 100644
--- a/arch/arm/mach-imx/mach-pcm037_eet.c
+++ b/arch/arm/mach-imx/mach-pcm037_eet.c
@@ -52,11 +52,6 @@ static struct spi_board_info pcm037_spi_dev[] = {
 	},
 };
 
-/* Platform Data for MXC CSPI */
-static const struct spi_imx_master pcm037_spi1_pdata __initconst = {
-	.num_chipselect = 2,
-};
-
 /* GPIO-keys input device */
 static struct gpio_keys_button pcm037_gpio_keys[] = {
 	{
@@ -163,7 +158,7 @@ int __init pcm037_eet_init_devices(void)
 
 	/* SPI */
 	spi_register_board_info(pcm037_spi_dev, ARRAY_SIZE(pcm037_spi_dev));
-	imx31_add_spi_imx0(&pcm037_spi1_pdata);
+	imx31_add_spi_imx0(NULL);
 
 	imx_add_gpio_keys(&pcm037_gpio_keys_platform_data);
 
diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 1552b28b9515..38b44446c947 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -11,7 +11,6 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -19,11 +18,9 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/dma-imx.h>
-#include <linux/platform_data/spi-imx.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
@@ -224,20 +221,6 @@ static int lpspi_unprepare_xfer_hardware(struct spi_controller *controller)
 	return 0;
 }
 
-static int fsl_lpspi_prepare_message(struct spi_controller *controller,
-				     struct spi_message *msg)
-{
-	struct fsl_lpspi_data *fsl_lpspi =
-					spi_controller_get_devdata(controller);
-	struct spi_device *spi = msg->spi;
-	int gpio = fsl_lpspi->chipselect[spi->chip_select];
-
-	if (gpio_is_valid(gpio))
-		gpio_direction_output(gpio, spi->mode & SPI_CS_HIGH ? 0 : 1);
-
-	return 0;
-}
-
 static void fsl_lpspi_write_tx_fifo(struct fsl_lpspi_data *fsl_lpspi)
 {
 	u8 txfifo_cnt;
@@ -831,13 +814,10 @@ static int fsl_lpspi_init_rpm(struct fsl_lpspi_data *fsl_lpspi)
 
 static int fsl_lpspi_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	struct fsl_lpspi_data *fsl_lpspi;
 	struct spi_controller *controller;
-	struct spi_imx_master *lpspi_platform_info =
-		dev_get_platdata(&pdev->dev);
 	struct resource *res;
-	int i, ret, irq;
+	int ret, irq;
 	u32 temp;
 	bool is_slave;
 
@@ -867,6 +847,8 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	controller->dev.of_node = pdev->dev.of_node;
 	controller->bus_num = pdev->id;
 	controller->slave_abort = fsl_lpspi_slave_abort;
+	if (!fsl_lpspi->is_slave)
+		controller->use_gpio_descriptors = true;
 
 	ret = devm_spi_register_controller(&pdev->dev, controller);
 	if (ret < 0) {
@@ -874,29 +856,6 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 		goto out_controller_put;
 	}
 
-	if (!fsl_lpspi->is_slave) {
-		for (i = 0; i < controller->num_chipselect; i++) {
-			int cs_gpio = of_get_named_gpio(np, "cs-gpios", i);
-
-			if (!gpio_is_valid(cs_gpio) && lpspi_platform_info)
-				cs_gpio = lpspi_platform_info->chipselect[i];
-
-			fsl_lpspi->chipselect[i] = cs_gpio;
-			if (!gpio_is_valid(cs_gpio))
-				continue;
-
-			ret = devm_gpio_request(&pdev->dev,
-						fsl_lpspi->chipselect[i],
-						DRIVER_NAME);
-			if (ret) {
-				dev_err(&pdev->dev, "can't get cs gpios\n");
-				goto out_controller_put;
-			}
-		}
-		controller->cs_gpios = fsl_lpspi->chipselect;
-		controller->prepare_message = fsl_lpspi_prepare_message;
-	}
-
 	init_completion(&fsl_lpspi->xfer_done);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index b7a85e3fe1c1..05562524de38 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -8,7 +8,6 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -21,10 +20,9 @@
 #include <linux/types.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
+#include <linux/property.h>
 
 #include <linux/platform_data/dma-imx.h>
-#include <linux/platform_data/spi-imx.h>
 
 #define DRIVER_NAME "spi_imx"
 
@@ -723,7 +721,7 @@ static int mx31_prepare_transfer(struct spi_imx_data *spi_imx,
 		reg |= MX31_CSPICTRL_POL;
 	if (spi->mode & SPI_CS_HIGH)
 		reg |= MX31_CSPICTRL_SSPOL;
-	if (!gpio_is_valid(spi->cs_gpio))
+	if (!spi->cs_gpiod)
 		reg |= (spi->chip_select) <<
 			(is_imx35_cspi(spi_imx) ? MX35_CSPICTRL_CS_SHIFT :
 						  MX31_CSPICTRL_CS_SHIFT);
@@ -824,7 +822,7 @@ static int mx21_prepare_transfer(struct spi_imx_data *spi_imx,
 		reg |= MX21_CSPICTRL_POL;
 	if (spi->mode & SPI_CS_HIGH)
 		reg |= MX21_CSPICTRL_SSPOL;
-	if (!gpio_is_valid(spi->cs_gpio))
+	if (!spi->cs_gpiod)
 		reg |= spi->chip_select << MX21_CSPICTRL_CS_SHIFT;
 
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
@@ -1056,20 +1054,6 @@ static const struct of_device_id spi_imx_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, spi_imx_dt_ids);
 
-static void spi_imx_chipselect(struct spi_device *spi, int is_active)
-{
-	int active = is_active != BITBANG_CS_INACTIVE;
-	int dev_is_lowactive = !(spi->mode & SPI_CS_HIGH);
-
-	if (spi->mode & SPI_NO_CS)
-		return;
-
-	if (!gpio_is_valid(spi->cs_gpio))
-		return;
-
-	gpio_set_value(spi->cs_gpio, dev_is_lowactive ^ active);
-}
-
 static void spi_imx_set_burst_len(struct spi_imx_data *spi_imx, int n_bits)
 {
 	u32 ctrl;
@@ -1540,15 +1524,6 @@ static int spi_imx_setup(struct spi_device *spi)
 	dev_dbg(&spi->dev, "%s: mode %d, %u bpw, %d hz\n", __func__,
 		 spi->mode, spi->bits_per_word, spi->max_speed_hz);
 
-	if (spi->mode & SPI_NO_CS)
-		return 0;
-
-	if (gpio_is_valid(spi->cs_gpio))
-		gpio_direction_output(spi->cs_gpio,
-				      spi->mode & SPI_CS_HIGH ? 0 : 1);
-
-	spi_imx_chipselect(spi, BITBANG_CS_INACTIVE);
-
 	return 0;
 }
 
@@ -1606,20 +1581,14 @@ static int spi_imx_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *of_id =
 			of_match_device(spi_imx_dt_ids, &pdev->dev);
-	struct spi_imx_master *mxc_platform_info =
-			dev_get_platdata(&pdev->dev);
 	struct spi_master *master;
 	struct spi_imx_data *spi_imx;
 	struct resource *res;
-	int i, ret, irq, spi_drctl;
+	int ret, irq, spi_drctl;
 	const struct spi_imx_devtype_data *devtype_data = of_id ? of_id->data :
 		(struct spi_imx_devtype_data *)pdev->id_entry->driver_data;
 	bool slave_mode;
-
-	if (!np && !mxc_platform_info) {
-		dev_err(&pdev->dev, "can't get the platform data\n");
-		return -EINVAL;
-	}
+	u32 val;
 
 	slave_mode = devtype_data->has_slavemode &&
 			of_property_read_bool(np, "spi-slave");
@@ -1642,6 +1611,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
 	master->bus_num = np ? -1 : pdev->id;
+	master->use_gpio_descriptors = true;
 
 	spi_imx = spi_master_get_devdata(master);
 	spi_imx->bitbang.master = master;
@@ -1650,28 +1620,17 @@ static int spi_imx_probe(struct platform_device *pdev)
 
 	spi_imx->devtype_data = devtype_data;
 
-	/* Get number of chip selects, either platform data or OF */
-	if (mxc_platform_info) {
-		master->num_chipselect = mxc_platform_info->num_chipselect;
-		if (mxc_platform_info->chipselect) {
-			master->cs_gpios = devm_kcalloc(&master->dev,
-				master->num_chipselect, sizeof(int),
-				GFP_KERNEL);
-			if (!master->cs_gpios)
-				return -ENOMEM;
-
-			for (i = 0; i < master->num_chipselect; i++)
-				master->cs_gpios[i] = mxc_platform_info->chipselect[i];
-		}
-	} else {
-		u32 num_cs;
-
-		if (!of_property_read_u32(np, "num-cs", &num_cs))
-			master->num_chipselect = num_cs;
-		/* If not preset, default value of 1 is used */
-	}
+	/*
+	 * Get number of chip selects from device properties. This can be
+	 * coming from device tree or boardfiles, if it is not defined,
+	 * a default value of 3 chip selects will be used, as all the legacy
+	 * board files have <= 3 chip selects.
+	 */
+	if (!device_property_read_u32(&pdev->dev, "num-cs", &val))
+		master->num_chipselect = val;
+	else
+		master->num_chipselect = 3;
 
-	spi_imx->bitbang.chipselect = spi_imx_chipselect;
 	spi_imx->bitbang.setup_transfer = spi_imx_setupxfer;
 	spi_imx->bitbang.txrx_bufs = spi_imx_transfer;
 	spi_imx->bitbang.master->setup = spi_imx_setup;
@@ -1756,31 +1715,12 @@ static int spi_imx_probe(struct platform_device *pdev)
 		goto out_clk_put;
 	}
 
-	/* Request GPIO CS lines, if any */
-	if (!spi_imx->slave_mode && master->cs_gpios) {
-		for (i = 0; i < master->num_chipselect; i++) {
-			if (!gpio_is_valid(master->cs_gpios[i]))
-				continue;
-
-			ret = devm_gpio_request(&pdev->dev,
-						master->cs_gpios[i],
-						DRIVER_NAME);
-			if (ret) {
-				dev_err(&pdev->dev, "Can't get CS GPIO %i\n",
-					master->cs_gpios[i]);
-				goto out_spi_bitbang;
-			}
-		}
-	}
-
 	dev_info(&pdev->dev, "probed\n");
 
 	clk_disable(spi_imx->clk_ipg);
 	clk_disable(spi_imx->clk_per);
 	return ret;
 
-out_spi_bitbang:
-	spi_bitbang_stop(&spi_imx->bitbang);
 out_clk_put:
 	clk_disable_unprepare(spi_imx->clk_ipg);
 out_put_per:
diff --git a/include/linux/platform_data/spi-imx.h b/include/linux/platform_data/spi-imx.h
deleted file mode 100644
index 328f670d10bd..000000000000
--- a/include/linux/platform_data/spi-imx.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef __MACH_SPI_H_
-#define __MACH_SPI_H_
-
-/*
- * struct spi_imx_master - device.platform_data for SPI controller devices.
- * @chipselect: Array of chipselects for this master or NULL.  Numbers >= 0
- *              mean GPIO pins, -ENOENT means internal CSPI chipselect
- *              matching the position in the array.  E.g., if chipselect[1] =
- *              -ENOENT then a SPI slave using chip select 1 will use the
- *              native SS1 line of the CSPI.  Omitting the array will use
- *              all native chip selects.
-
- *              Normally you want to use gpio based chip selects as the CSPI
- *              module tries to be intelligent about when to assert the
- *              chipselect:  The CSPI module deasserts the chipselect once it
- *              runs out of input data.  The other problem is that it is not
- *              possible to mix between high active and low active chipselects
- *              on one single bus using the internal chipselects.
- *              Unfortunately, on some SoCs, Freescale decided to put some
- *              chipselects on dedicated pins which are not usable as gpios,
- *              so we have to support the internal chipselects.
- *
- * @num_chipselect: If @chipselect is specified, ARRAY_SIZE(chipselect),
- *                  otherwise the number of native chip selects.
- */
-struct spi_imx_master {
-	int	*chipselect;
-	int	num_chipselect;
-};
-
-#endif /* __MACH_SPI_H_*/
-- 
2.25.4

