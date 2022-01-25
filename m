Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C776D49AABB
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jan 2022 05:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S246109AbiAYDpo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Jan 2022 22:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1321042AbiAYDPf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Jan 2022 22:15:35 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F66C055A88
        for <linux-spi@vger.kernel.org>; Mon, 24 Jan 2022 17:00:43 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id q22so5690054ljh.7
        for <linux-spi@vger.kernel.org>; Mon, 24 Jan 2022 17:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HT+85qiSCYA+l/i8E2iqfYN+1FiMfhetPuwvW7hTUpQ=;
        b=BayROC5JfRCyIyNImRnr1/JgWn2sSYA3o4aZ+oieJDYUiMwIoFWC2knwfmt0aTKqUK
         7E69UXgBKpEI9RSx7PbRmHDFpS9Ocm7GGOo8GIZwc2hqqcfetHoawNnuv/TPeUxUPQrY
         orXdK608fVZxLVnLOuZvkuVncoZNDPevMZJojUYJ40aBhXey6jbAsvxigp1E8t6vTbAY
         OJxn+mWQx0NraSBXSaIcr/GPJNj5HY/j8sfL8P18fZCr5vlyFSIxXlpd8CNe+Wl548bV
         k3UVCr81MYvNihN2/yvuta8KEw9fPLFshfjG6a/z0k0DVl1UZ9e6jU9q8jQDqAKQamK4
         6TMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HT+85qiSCYA+l/i8E2iqfYN+1FiMfhetPuwvW7hTUpQ=;
        b=aGmNE29vc2yAId7yNYrD1iuXqVKHuMdWT1ev1pBOmHxEYa92XiKLrc+fVlmQq465yQ
         oue76UKdVplAEwmnX3NTSoAVAkrsnGuQWUdP3Spr1bdrUFIfidJy4YLT13BT1BPoTMyy
         pn6M0PwOFBr+ErlgGxSCjEYMPkzEO/o7wbtkatjbGDCocwB9vpZOlTVf7A2V6hqRMzSf
         OezNfvmd/lL15ynIF37yc7b9AjRhr5jNrLrhKxmuoQv/8wGxDU0zAMEXtJEuY8ZpiYNO
         ja8E1DzRwLl1Sz9PsM/nngWI1YLikiPBRro+N80o0hCziFNvl5cGYaSAQm2gHUuhT6bJ
         DMrg==
X-Gm-Message-State: AOAM530cSCr3SC/++O2Lqk4965tVzEczjBScrcphoq4dgaETTxG/w4Gv
        Jy1QwOYmjB2KpDcxe/uWn5KiEg==
X-Google-Smtp-Source: ABdhPJxMYkYiuxQqZTkATiWl5XPv0YlN9PuaA4x3RSagLOQE04EueqPfOYzXaYHfxiCfLbVmYeW75w==
X-Received: by 2002:a05:651c:547:: with SMTP id q7mr13182599ljp.187.1643072441253;
        Mon, 24 Jan 2022 17:00:41 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id bt5sm1324374lfb.38.2022.01.24.17.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 17:00:40 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2] spi: pxa2xx_spi: Convert to use GPIO descriptors
Date:   Tue, 25 Jan 2022 01:58:36 +0100
Message-Id: <20220125005836.494807-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This converts the PXA2xx SPI driver to use GPIO descriptors
exclusively to retrieve GPIO chip select lines.

The device tree and ACPI paths of the driver already use
descriptors, hence ->use_gpio_descriptors is already set and
this codepath is well tested.

Convert all the PXA boards providing chip select GPIOs as
platform data and drop the old GPIO chipselect handling in
favor of the core managing it exclusively.

Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-arm-kernel@lists.infradead.org
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Drop a dangling err variable and some code which is now
  unused as we don't set up the GPIO lines in the driver
  anymore. (Found by the kernel test robot.)
- Drop excess newline.
- Collect Jonathan's ACK.
---
 Documentation/spi/pxa2xx.rst   |  3 --
 arch/arm/mach-pxa/corgi.c      | 26 ++++++--------
 arch/arm/mach-pxa/hx4700.c     | 10 +++++-
 arch/arm/mach-pxa/icontrol.c   | 26 +++++++++++---
 arch/arm/mach-pxa/littleton.c  | 10 +++++-
 arch/arm/mach-pxa/magician.c   | 12 +++++--
 arch/arm/mach-pxa/poodle.c     | 14 +++++---
 arch/arm/mach-pxa/spitz.c      | 26 ++++++--------
 arch/arm/mach-pxa/stargate2.c  | 20 +++++++++--
 arch/arm/mach-pxa/z2.c         | 20 +++++++++--
 drivers/spi/spi-pxa2xx.c       | 63 +---------------------------------
 include/linux/spi/pxa2xx_spi.h |  1 -
 12 files changed, 117 insertions(+), 114 deletions(-)

diff --git a/Documentation/spi/pxa2xx.rst b/Documentation/spi/pxa2xx.rst
index 6347580826be..716f65d87d04 100644
--- a/Documentation/spi/pxa2xx.rst
+++ b/Documentation/spi/pxa2xx.rst
@@ -101,7 +101,6 @@ device. All fields are optional.
 	u8 rx_threshold;
 	u8 dma_burst_size;
 	u32 timeout;
-	int gpio_cs;
   };
 
 The "pxa2xx_spi_chip.tx_threshold" and "pxa2xx_spi_chip.rx_threshold" fields are
@@ -146,7 +145,6 @@ field. Below is a sample configuration using the PXA255 NSSP.
 	.rx_threshold = 8, /* SSP hardward FIFO threshold */
 	.dma_burst_size = 8, /* Byte wide transfers used so 8 byte bursts */
 	.timeout = 235, /* See Intel documentation */
-	.gpio_cs = 2, /* Use external chip select */
   };
 
   static struct pxa2xx_spi_chip cs8405a_chip_info = {
@@ -154,7 +152,6 @@ field. Below is a sample configuration using the PXA255 NSSP.
 	.rx_threshold = 8, /* SSP hardward FIFO threshold */
 	.dma_burst_size = 8, /* Byte wide transfers used so 8 byte bursts */
 	.timeout = 235, /* See Intel documentation */
-	.gpio_cs = 3, /* Use external chip select */
   };
 
   static struct spi_board_info streetracer_spi_board_info[] __initdata = {
diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index 593c7f793da5..44659fbc37ba 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -530,6 +530,16 @@ static struct pxa2xx_spi_controller corgi_spi_info = {
 	.num_chipselect	= 3,
 };
 
+static struct gpiod_lookup_table corgi_spi_gpio_table = {
+	.dev_id = "pxa2xx-spi.1",
+	.table = {
+		GPIO_LOOKUP_IDX("gpio-pxa", CORGI_GPIO_ADS7846_CS, "cs", 0, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-pxa", CORGI_GPIO_LCDCON_CS, "cs", 1, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-pxa", CORGI_GPIO_MAX1111_CS, "cs", 2, GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
 static void corgi_wait_for_hsync(void)
 {
 	while (gpio_get_value(CORGI_GPIO_HSYNC))
@@ -548,10 +558,6 @@ static struct ads7846_platform_data corgi_ads7846_info = {
 	.wait_for_sync		= corgi_wait_for_hsync,
 };
 
-static struct pxa2xx_spi_chip corgi_ads7846_chip = {
-	.gpio_cs	= CORGI_GPIO_ADS7846_CS,
-};
-
 static void corgi_bl_kick_battery(void)
 {
 	void (*kick_batt)(void);
@@ -580,14 +586,6 @@ static struct corgi_lcd_platform_data corgi_lcdcon_info = {
 	.kick_battery		= corgi_bl_kick_battery,
 };
 
-static struct pxa2xx_spi_chip corgi_lcdcon_chip = {
-	.gpio_cs	= CORGI_GPIO_LCDCON_CS,
-};
-
-static struct pxa2xx_spi_chip corgi_max1111_chip = {
-	.gpio_cs	= CORGI_GPIO_MAX1111_CS,
-};
-
 static struct spi_board_info corgi_spi_devices[] = {
 	{
 		.modalias	= "ads7846",
@@ -595,7 +593,6 @@ static struct spi_board_info corgi_spi_devices[] = {
 		.bus_num	= 1,
 		.chip_select	= 0,
 		.platform_data	= &corgi_ads7846_info,
-		.controller_data= &corgi_ads7846_chip,
 		.irq		= PXA_GPIO_TO_IRQ(CORGI_GPIO_TP_INT),
 	}, {
 		.modalias	= "corgi-lcd",
@@ -603,18 +600,17 @@ static struct spi_board_info corgi_spi_devices[] = {
 		.bus_num	= 1,
 		.chip_select	= 1,
 		.platform_data	= &corgi_lcdcon_info,
-		.controller_data= &corgi_lcdcon_chip,
 	}, {
 		.modalias	= "max1111",
 		.max_speed_hz	= 450000,
 		.bus_num	= 1,
 		.chip_select	= 2,
-		.controller_data= &corgi_max1111_chip,
 	},
 };
 
 static void __init corgi_init_spi(void)
 {
+	gpiod_add_lookup_table(&corgi_spi_gpio_table);
 	pxa2xx_set_spi_info(1, &corgi_spi_info);
 	gpiod_add_lookup_table(&corgi_lcdcon_gpio_table);
 	spi_register_board_info(ARRAY_AND_SIZE(corgi_spi_devices));
diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index 1d4c5db54be2..e1870fbb19e7 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -616,7 +616,6 @@ static struct pxa2xx_spi_chip tsc2046_chip = {
 	.tx_threshold = 1,
 	.rx_threshold = 2,
 	.timeout      = 64,
-	.gpio_cs      = GPIO88_HX4700_TSC2046_CS,
 };
 
 static struct spi_board_info tsc2046_board_info[] __initdata = {
@@ -635,6 +634,14 @@ static struct pxa2xx_spi_controller pxa_ssp2_master_info = {
 	.enable_dma     = 1,
 };
 
+static struct gpiod_lookup_table pxa_ssp2_gpio_table = {
+	.dev_id = "pxa2xx-spi.2",
+	.table = {
+		GPIO_LOOKUP_IDX("gpio-pxa", GPIO88_HX4700_TSC2046_CS, "cs", 0, GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
 /*
  * External power
  */
@@ -896,6 +903,7 @@ static void __init hx4700_init(void)
 	pxa_set_i2c_info(NULL);
 	i2c_register_board_info(0, ARRAY_AND_SIZE(i2c_board_info));
 	i2c_register_board_info(1, ARRAY_AND_SIZE(pi2c_board_info));
+	gpiod_add_lookup_table(&pxa_ssp2_gpio_table);
 	pxa2xx_set_spi_info(2, &pxa_ssp2_master_info);
 	spi_register_board_info(ARRAY_AND_SIZE(tsc2046_board_info));
 
diff --git a/arch/arm/mach-pxa/icontrol.c b/arch/arm/mach-pxa/icontrol.c
index 04a12523cdee..753fe166ab68 100644
--- a/arch/arm/mach-pxa/icontrol.c
+++ b/arch/arm/mach-pxa/icontrol.c
@@ -13,7 +13,7 @@
 #include <linux/irq.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
-#include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -42,7 +42,6 @@ static struct pxa2xx_spi_chip mcp251x_chip_info1 = {
 	.rx_threshold   = 128,
 	.dma_burst_size = 8,
 	.timeout        = 235,
-	.gpio_cs        = ICONTROL_MCP251x_nCS1
 };
 
 static struct pxa2xx_spi_chip mcp251x_chip_info2 = {
@@ -50,7 +49,6 @@ static struct pxa2xx_spi_chip mcp251x_chip_info2 = {
 	.rx_threshold   = 128,
 	.dma_burst_size = 8,
 	.timeout        = 235,
-	.gpio_cs        = ICONTROL_MCP251x_nCS2
 };
 
 static struct pxa2xx_spi_chip mcp251x_chip_info3 = {
@@ -58,7 +56,6 @@ static struct pxa2xx_spi_chip mcp251x_chip_info3 = {
 	.rx_threshold   = 128,
 	.dma_burst_size = 8,
 	.timeout        = 235,
-	.gpio_cs        = ICONTROL_MCP251x_nCS3
 };
 
 static struct pxa2xx_spi_chip mcp251x_chip_info4 = {
@@ -66,7 +63,6 @@ static struct pxa2xx_spi_chip mcp251x_chip_info4 = {
 	.rx_threshold   = 128,
 	.dma_burst_size = 8,
 	.timeout        = 235,
-	.gpio_cs        = ICONTROL_MCP251x_nCS4
 };
 
 static const struct property_entry mcp251x_properties[] = {
@@ -143,6 +139,24 @@ struct platform_device pxa_spi_ssp4 = {
 	}
 };
 
+static struct gpiod_lookup_table pxa_ssp3_gpio_table = {
+	.dev_id = "pxa2xx-spi.3",
+	.table = {
+		GPIO_LOOKUP_IDX("gpio-pxa", ICONTROL_MCP251x_nCS1, "cs", 0, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-pxa", ICONTROL_MCP251x_nCS2, "cs", 1, GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
+static struct gpiod_lookup_table pxa_ssp4_gpio_table = {
+	.dev_id = "pxa2xx-spi.4",
+	.table = {
+		GPIO_LOOKUP_IDX("gpio-pxa", ICONTROL_MCP251x_nCS3, "cs", 0, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-pxa", ICONTROL_MCP251x_nCS4, "cs", 1, GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
 static struct platform_device *icontrol_spi_devices[] __initdata = {
 	&pxa_spi_ssp3,
 	&pxa_spi_ssp4,
@@ -175,6 +189,8 @@ static mfp_cfg_t mfp_can_cfg[] __initdata = {
 static void __init icontrol_can_init(void)
 {
 	pxa3xx_mfp_config(ARRAY_AND_SIZE(mfp_can_cfg));
+	gpiod_add_lookup_table(&pxa_ssp3_gpio_table);
+	gpiod_add_lookup_table(&pxa_ssp4_gpio_table);
 	platform_add_devices(ARRAY_AND_SIZE(icontrol_spi_devices));
 	spi_register_board_info(ARRAY_AND_SIZE(mcp251x_board_info));
 }
diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index 793f61375ee8..73f5953b3bb6 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -195,7 +195,6 @@ static struct pxa2xx_spi_controller littleton_spi_info = {
 static struct pxa2xx_spi_chip littleton_tdo24m_chip = {
 	.rx_threshold	= 1,
 	.tx_threshold	= 1,
-	.gpio_cs	= LITTLETON_GPIO_LCD_CS,
 };
 
 static struct spi_board_info littleton_spi_devices[] __initdata = {
@@ -208,8 +207,17 @@ static struct spi_board_info littleton_spi_devices[] __initdata = {
 	},
 };
 
+static struct gpiod_lookup_table littleton_spi_gpio_table = {
+	.dev_id = "pxa2xx-spi.2",
+	.table = {
+		GPIO_LOOKUP_IDX("gpio-pxa", LITTLETON_GPIO_LCD_CS, "cs", 0, GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
 static void __init littleton_init_spi(void)
 {
+	gpiod_add_lookup_table(&littleton_spi_gpio_table);
 	pxa2xx_set_spi_info(2, &littleton_spi_info);
 	spi_register_board_info(ARRAY_AND_SIZE(littleton_spi_devices));
 }
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index cd9fa465b9b2..200fd35168e0 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -938,8 +938,6 @@ struct pxa2xx_spi_chip tsc2046_chip_info = {
 	.tx_threshold	= 1,
 	.rx_threshold	= 2,
 	.timeout	= 64,
-	/* NOTICE must be GPIO, incompatibility with hw PXA SPI framing */
-	.gpio_cs	= GPIO14_MAGICIAN_TSC2046_CS,
 };
 
 static struct pxa2xx_spi_controller magician_spi_info = {
@@ -947,6 +945,15 @@ static struct pxa2xx_spi_controller magician_spi_info = {
 	.enable_dma	= 1,
 };
 
+static struct gpiod_lookup_table magician_spi_gpio_table = {
+	.dev_id = "pxa2xx-spi.2",
+	.table = {
+		/* NOTICE must be GPIO, incompatibility with hw PXA SPI framing */
+		GPIO_LOOKUP_IDX("gpio-pxa", GPIO14_MAGICIAN_TSC2046_CS, "cs", 0, GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
 static struct spi_board_info ads7846_spi_board_info[] __initdata = {
 	{
 		.modalias		= "ads7846",
@@ -1031,6 +1038,7 @@ static void __init magician_init(void)
 	} else
 		pr_err("LCD detection: CPLD mapping failed\n");
 
+	gpiod_add_lookup_table(&magician_spi_gpio_table);
 	pxa2xx_set_spi_info(2, &magician_spi_info);
 	spi_register_board_info(ARRAY_AND_SIZE(ads7846_spi_board_info));
 
diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index 3a4ecc3c8f8b..58cfa434afde 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -197,6 +197,14 @@ static struct pxa2xx_spi_controller poodle_spi_info = {
 	.num_chipselect	= 1,
 };
 
+static struct gpiod_lookup_table poodle_spi_gpio_table = {
+	.dev_id = "pxa2xx-spi.1",
+	.table = {
+		GPIO_LOOKUP_IDX("gpio-pxa", POODLE_GPIO_TP_CS, "cs", 0, GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
 static struct ads7846_platform_data poodle_ads7846_info = {
 	.model			= 7846,
 	.vref_delay_usecs	= 100,
@@ -205,23 +213,19 @@ static struct ads7846_platform_data poodle_ads7846_info = {
 	.gpio_pendown		= POODLE_GPIO_TP_INT,
 };
 
-static struct pxa2xx_spi_chip poodle_ads7846_chip = {
-	.gpio_cs		= POODLE_GPIO_TP_CS,
-};
-
 static struct spi_board_info poodle_spi_devices[] = {
 	{
 		.modalias	= "ads7846",
 		.max_speed_hz	= 10000,
 		.bus_num	= 1,
 		.platform_data	= &poodle_ads7846_info,
-		.controller_data= &poodle_ads7846_chip,
 		.irq		= PXA_GPIO_TO_IRQ(POODLE_GPIO_TP_INT),
 	},
 };
 
 static void __init poodle_init_spi(void)
 {
+	gpiod_add_lookup_table(&poodle_spi_gpio_table);
 	pxa2xx_set_spi_info(1, &poodle_spi_info);
 	spi_register_board_info(ARRAY_AND_SIZE(poodle_spi_devices));
 }
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 371008e9bb02..a648e7094e84 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -510,10 +510,6 @@ static struct ads7846_platform_data spitz_ads7846_info = {
 	.wait_for_sync		= spitz_ads7846_wait_for_hsync,
 };
 
-static struct pxa2xx_spi_chip spitz_ads7846_chip = {
-	.gpio_cs		= SPITZ_GPIO_ADS7846_CS,
-};
-
 static void spitz_bl_kick_battery(void)
 {
 	void (*kick_batt)(void);
@@ -555,14 +551,6 @@ static struct corgi_lcd_platform_data spitz_lcdcon_info = {
 	.kick_battery		= spitz_bl_kick_battery,
 };
 
-static struct pxa2xx_spi_chip spitz_lcdcon_chip = {
-	.gpio_cs	= SPITZ_GPIO_LCDCON_CS,
-};
-
-static struct pxa2xx_spi_chip spitz_max1111_chip = {
-	.gpio_cs	= SPITZ_GPIO_MAX1111_CS,
-};
-
 static struct spi_board_info spitz_spi_devices[] = {
 	{
 		.modalias		= "ads7846",
@@ -570,7 +558,6 @@ static struct spi_board_info spitz_spi_devices[] = {
 		.bus_num		= 2,
 		.chip_select		= 0,
 		.platform_data		= &spitz_ads7846_info,
-		.controller_data	= &spitz_ads7846_chip,
 		.irq			= PXA_GPIO_TO_IRQ(SPITZ_GPIO_TP_INT),
 	}, {
 		.modalias		= "corgi-lcd",
@@ -578,13 +565,11 @@ static struct spi_board_info spitz_spi_devices[] = {
 		.bus_num		= 2,
 		.chip_select		= 1,
 		.platform_data		= &spitz_lcdcon_info,
-		.controller_data	= &spitz_lcdcon_chip,
 	}, {
 		.modalias		= "max1111",
 		.max_speed_hz		= 450000,
 		.bus_num		= 2,
 		.chip_select		= 2,
-		.controller_data	= &spitz_max1111_chip,
 	},
 };
 
@@ -592,6 +577,16 @@ static struct pxa2xx_spi_controller spitz_spi_info = {
 	.num_chipselect	= 3,
 };
 
+static struct gpiod_lookup_table spitz_spi_gpio_table = {
+	.dev_id = "pxa2xx-spi.2",
+	.table = {
+		GPIO_LOOKUP_IDX("gpio-pxa", SPITZ_GPIO_ADS7846_CS, "cs", 0, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-pxa", SPITZ_GPIO_LCDCON_CS, "cs", 1, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-pxa", SPITZ_GPIO_MAX1111_CS, "cs", 2, GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
 static void __init spitz_spi_init(void)
 {
 	if (machine_is_akita())
@@ -599,6 +594,7 @@ static void __init spitz_spi_init(void)
 	else
 		gpiod_add_lookup_table(&spitz_lcdcon_gpio_table);
 
+	gpiod_add_lookup_table(&spitz_spi_gpio_table);
 	pxa2xx_set_spi_info(2, &spitz_spi_info);
 	spi_register_board_info(ARRAY_AND_SIZE(spitz_spi_devices));
 }
diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
index 8ca02ec1d44c..b43e2f4536a5 100644
--- a/arch/arm/mach-pxa/stargate2.c
+++ b/arch/arm/mach-pxa/stargate2.c
@@ -346,6 +346,22 @@ static struct pxa2xx_spi_controller pxa_ssp_master_2_info = {
 	.num_chipselect = 1,
 };
 
+static struct gpiod_lookup_table pxa_ssp1_gpio_table = {
+	.dev_id = "pxa2xx-spi.1",
+	.table = {
+		GPIO_LOOKUP_IDX("gpio-pxa", 24, "cs", 0, GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
+static struct gpiod_lookup_table pxa_ssp3_gpio_table = {
+	.dev_id = "pxa2xx-spi.3",
+	.table = {
+		GPIO_LOOKUP_IDX("gpio-pxa", 39, "cs", 0, GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
 /* An upcoming kernel change will scrap SFRM usage so these
  * drivers have been moved to use GPIOs */
 static struct pxa2xx_spi_chip staccel_chip_info = {
@@ -353,7 +369,6 @@ static struct pxa2xx_spi_chip staccel_chip_info = {
 	.rx_threshold = 8,
 	.dma_burst_size = 8,
 	.timeout = 235,
-	.gpio_cs = 24,
 };
 
 static struct pxa2xx_spi_chip cc2420_info = {
@@ -361,7 +376,6 @@ static struct pxa2xx_spi_chip cc2420_info = {
 	.rx_threshold = 8,
 	.dma_burst_size = 8,
 	.timeout = 235,
-	.gpio_cs = 39,
 };
 
 static struct spi_board_info spi_board_info[] __initdata = {
@@ -410,6 +424,8 @@ static void __init imote2_stargate2_init(void)
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
 
+	gpiod_add_lookup_table(&pxa_ssp1_gpio_table);
+	gpiod_add_lookup_table(&pxa_ssp3_gpio_table);
 	pxa2xx_set_spi_info(1, &pxa_ssp_master_0_info);
 	pxa2xx_set_spi_info(2, &pxa_ssp_master_1_info);
 	pxa2xx_set_spi_info(3, &pxa_ssp_master_2_info);
diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index 8e74fbb0a96e..7eaeda269927 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -570,7 +570,6 @@ static struct pxa2xx_spi_chip z2_lbs_chip_info = {
 	.rx_threshold	= 8,
 	.tx_threshold	= 8,
 	.timeout	= 1000,
-	.gpio_cs	= GPIO24_ZIPITZ2_WIFI_CS,
 };
 
 static struct libertas_spi_platform_data z2_lbs_pdata = {
@@ -584,7 +583,6 @@ static struct pxa2xx_spi_chip lms283_chip_info = {
 	.rx_threshold	= 1,
 	.tx_threshold	= 1,
 	.timeout	= 64,
-	.gpio_cs	= GPIO88_ZIPITZ2_LCD_CS,
 };
 
 static struct gpiod_lookup_table lms283_gpio_table = {
@@ -624,8 +622,26 @@ static struct pxa2xx_spi_controller pxa_ssp2_master_info = {
 	.num_chipselect	= 1,
 };
 
+static struct gpiod_lookup_table pxa_ssp1_gpio_table = {
+	.dev_id = "pxa2xx-spi.1",
+	.table = {
+		GPIO_LOOKUP_IDX("gpio-pxa", GPIO24_ZIPITZ2_WIFI_CS, "cs", 0, GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
+static struct gpiod_lookup_table pxa_ssp2_gpio_table = {
+	.dev_id = "pxa2xx-spi.2",
+	.table = {
+		GPIO_LOOKUP_IDX("gpio-pxa", GPIO88_ZIPITZ2_LCD_CS, "cs", 0, GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
 static void __init z2_spi_init(void)
 {
+	gpiod_add_lookup_table(&pxa_ssp1_gpio_table);
+	gpiod_add_lookup_table(&pxa_ssp2_gpio_table);
 	pxa2xx_set_spi_info(1, &pxa_ssp1_master_info);
 	pxa2xx_set_spi_info(2, &pxa_ssp2_master_info);
 	gpiod_add_lookup_table(&lms283_gpio_table);
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index e88f86274eeb..abb9f0ffd377 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -13,7 +13,6 @@
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/gpio/consumer.h>
-#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
@@ -1163,57 +1162,6 @@ static int pxa2xx_spi_unprepare_transfer(struct spi_controller *controller)
 	return 0;
 }
 
-static void cleanup_cs(struct spi_device *spi)
-{
-	if (!gpio_is_valid(spi->cs_gpio))
-		return;
-
-	gpio_free(spi->cs_gpio);
-	spi->cs_gpio = -ENOENT;
-}
-
-static int setup_cs(struct spi_device *spi, struct chip_data *chip,
-		    struct pxa2xx_spi_chip *chip_info)
-{
-	struct driver_data *drv_data = spi_controller_get_devdata(spi->controller);
-
-	if (chip == NULL)
-		return 0;
-
-	if (chip_info == NULL)
-		return 0;
-
-	if (drv_data->ssp_type == CE4100_SSP)
-		return 0;
-
-	/*
-	 * NOTE: setup() can be called multiple times, possibly with
-	 * different chip_info, release previously requested GPIO.
-	 */
-	cleanup_cs(spi);
-
-	if (gpio_is_valid(chip_info->gpio_cs)) {
-		int gpio = chip_info->gpio_cs;
-		int err;
-
-		err = gpio_request(gpio, "SPI_CS");
-		if (err) {
-			dev_err(&spi->dev, "failed to request chip select GPIO%d\n", gpio);
-			return err;
-		}
-
-		err = gpio_direction_output(gpio, !(spi->mode & SPI_CS_HIGH));
-		if (err) {
-			gpio_free(gpio);
-			return err;
-		}
-
-		spi->cs_gpio = gpio;
-	}
-
-	return 0;
-}
-
 static int setup(struct spi_device *spi)
 {
 	struct pxa2xx_spi_chip *chip_info;
@@ -1222,7 +1170,6 @@ static int setup(struct spi_device *spi)
 	struct driver_data *drv_data =
 		spi_controller_get_devdata(spi->controller);
 	uint tx_thres, tx_hi_thres, rx_thres;
-	int err;
 
 	switch (drv_data->ssp_type) {
 	case QUARK_X1000_SSP:
@@ -1365,21 +1312,13 @@ static int setup(struct spi_device *spi)
 
 	spi_set_ctldata(spi, chip);
 
-	if (drv_data->ssp_type == CE4100_SSP)
-		return 0;
-
-	err = setup_cs(spi, chip, chip_info);
-	if (err)
-		kfree(chip);
-
-	return err;
+	return 0;
 }
 
 static void cleanup(struct spi_device *spi)
 {
 	struct chip_data *chip = spi_get_ctldata(spi);
 
-	cleanup_cs(spi);
 	kfree(chip);
 }
 
diff --git a/include/linux/spi/pxa2xx_spi.h b/include/linux/spi/pxa2xx_spi.h
index ca74dce36706..4658e7801b42 100644
--- a/include/linux/spi/pxa2xx_spi.h
+++ b/include/linux/spi/pxa2xx_spi.h
@@ -42,7 +42,6 @@ struct pxa2xx_spi_chip {
 	u8 rx_threshold;
 	u8 dma_burst_size;
 	u32 timeout;
-	int gpio_cs;
 };
 
 #if defined(CONFIG_ARCH_PXA) || defined(CONFIG_ARCH_MMP)
-- 
2.34.1

