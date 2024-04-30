Return-Path: <linux-spi+bounces-2647-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 738518B6B10
	for <lists+linux-spi@lfdr.de>; Tue, 30 Apr 2024 09:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0EC31F2259B
	for <lists+linux-spi@lfdr.de>; Tue, 30 Apr 2024 07:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA2B1C291;
	Tue, 30 Apr 2024 07:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lWEjZLfR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C2E2C184
	for <linux-spi@vger.kernel.org>; Tue, 30 Apr 2024 07:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714460643; cv=none; b=pzTdkp6qpgE1YmX4mZQe65xus59lfWt+/ohnCGZC4MSClRUOOJ+GaCA1Q8qsKld6PDMq8OxOGSNZgUep6cIkPH0jgZFUic1nJjVPePF/mp/yc+OOS7oUGoz02a9Q8KumFfzDF7EHgTbemWZBnP6XO7VyVk6EnQjO9TZt2worsJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714460643; c=relaxed/simple;
	bh=vdUPsMOwCHqb5JL3PZ6m7cOn71ZF9nAaN/WgxbULW3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U7SCN75bcNCA7X0bojVUtqCdKXGPVuklmiC9JVJl3V+5AEnETarv5rth1fxRynN3Eoev3rxXwmQYe7AgdsALzhSA1g0ajhczMvQsx5WgsG03gSJFITwSGf/r5o65DP1ymuW4CUfm25vJsXLwAOMcT+bGWU6NgxXK19JsswbEMKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lWEjZLfR; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-61b4cbb8834so53535227b3.0
        for <linux-spi@vger.kernel.org>; Tue, 30 Apr 2024 00:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714460640; x=1715065440; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KoVXdJHVeZxp0h1BU5LvQei6P82WebLM3hF8pbM4pmY=;
        b=lWEjZLfRkW8q7cMcejBct3ufTfBXCRjn1mrsF536/BC6eeByfLzvRb6tPDRgnQYG6w
         6slNF8/QNnWIg3bqhbjQ7T1zyLqLljO2vb5Ar4/Piq9l/ehDPfEVfxr7bfhUHi7h8Yro
         XJKTD6w0EYqlJ8oa9RX3AjG6UwJrRuDeyP2tmxQRyyZhcc0fc4TBGMGTNm2mB3I8ShKS
         SMvroiUiIhk5xHxZHrQKQHF/jEbBMxr+mm1dx0KSGRXeK3ranyl0syOHbc4HyW0F7/KB
         uR7/zOYw+KvFmyirof2jY0AZNeAKfqPiaG5nBwYpj6rwSZBTDbw1p1SlI8D4Jm2NmTN7
         N0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714460640; x=1715065440;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KoVXdJHVeZxp0h1BU5LvQei6P82WebLM3hF8pbM4pmY=;
        b=ggN1dMw7guq+MA2G8HddIm6jC7yD3NM8SWH3UdYaChszHhHmkvZl4MeNYTmNzTrfwS
         e9Ybh1gi2ecleVnYWqVcQIpggpB1TZJIRRXVdbgSU4diGwAB1duK0DV8uLSoGhERT913
         81Y9x+8SzQs/Ns/p0c3PSr05RxViCUABAf/rrHVhlw96fKJUCtcPG5bOmXTiT9DTaXYd
         HKZGqlFU3TlMo7XvcIZ8bDypIUGaX5DYR9i61IrBebuLJaaKj5Uuiln51mwRdhY4NKMg
         N1hzIggbIMnu1jujvwOWnWe4b/nRdaWx2WsMr/MZ08aNC2XmSL5ltTZ5EUOEXid0yyf3
         5Ayw==
X-Forwarded-Encrypted: i=1; AJvYcCXEzUwCeyd/C3qBietYxGJ/rLLAz0FkwStIyEw0ewEycuoAtWOBl8klp75HyCeMyiRv2SMf+L6B8MGye4jSjSkNEjLOeiTWXZUb
X-Gm-Message-State: AOJu0Yz+19roe3LRWO4OG040SXt0pW3JmIlwwHxf11Y3oUOSVwc6Hcaa
	/6inphfoWsfGyEOqKM/ltx8hTjpfWhKoD/aL+6vblo9XeYv8xNGDadR8dMCKpXM=
X-Google-Smtp-Source: AGHT+IHXJG0jZ+ap33XuddrE18N0BzMWLMOPQO8fdp8ZhqWudDeBaHWjUjCu0mS4rRaJ83Ykfd81Tw==
X-Received: by 2002:a05:690c:690f:b0:615:1413:95c1 with SMTP id if15-20020a05690c690f00b00615141395c1mr12191954ywb.19.1714460640536;
        Tue, 30 Apr 2024 00:04:00 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id z11-20020a05622a124b00b00437b4048972sm10610674qtx.18.2024.04.30.00.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 00:04:00 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 30 Apr 2024 09:03:49 +0200
Subject: [PATCH 3/3] ARM: spitz: Use software nodes for the ADS7846
 touchscreen
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-gpio-leds-miscarm-v1-3-9c94d7711f6c@linaro.org>
References: <20240430-gpio-leds-miscarm-v1-0-9c94d7711f6c@linaro.org>
In-Reply-To: <20240430-gpio-leds-miscarm-v1-0-9c94d7711f6c@linaro.org>
To: Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.13.0

Convert the Spitz to use software nodes for SPI CS and the
ADS7846 touchscreen following the pattern used in the TI
platforms.

The Spitz is the only user of the wait_for_sync() callback in
the platform data, so define that this is a separate GPIO
in the device tree bindings (previous patch) and handle this
directly inside the ADS7846 driver instead.

Add some infrastructure to the PXA boardfile common code to
handle software nodes attached to the SPI bus instead of
platform data.

The SPI core will investigate the numner of GPIO handles to
figure out the number of chipselects used on the platform, so
no explicit encoding of the number of the number of chipselects
is needed.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-pxa/devices.c         | 16 ++++++++
 arch/arm/mach-pxa/spitz.c           | 75 +++++++++++++++++++------------------
 drivers/input/touchscreen/ads7846.c | 31 ++++++++++-----
 include/linux/spi/ads7846.h         |  1 -
 include/linux/spi/pxa2xx_spi.h      |  2 +
 5 files changed, 78 insertions(+), 47 deletions(-)

diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 661b3fc43275..e0e21cb97f71 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -9,6 +9,7 @@
 #include <linux/dmaengine.h>
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/platform_data/i2c-pxa.h>
+#include <linux/property.h>
 #include <linux/soc/pxa/cpu.h>
 
 #include "udc.h"
@@ -682,6 +683,21 @@ void __init pxa2xx_set_spi_info(unsigned id, struct pxa2xx_spi_controller *info)
 	platform_device_add(pd);
 }
 
+void __init pxa2xx_set_spi_node(unsigned id, const struct property_entry *props)
+{
+	struct platform_device *pd;
+
+	pd = platform_device_alloc("pxa2xx-spi", id);
+	if (pd == NULL) {
+		printk(KERN_ERR "pxa2xx-spi: failed to allocate device id %d\n",
+		       id);
+		return;
+	}
+
+	device_create_managed_software_node(&pd->dev, props, NULL);
+	platform_device_add(pd);
+}
+
 static struct resource pxa_dma_resource[] = {
 	[0] = {
 		.start	= 0x40000000,
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 36aec5ea7218..bc93ceed0022 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -14,6 +14,7 @@
 #include <linux/gpio_keys.h>
 #include <linux/gpio.h>
 #include <linux/gpio/machine.h>
+#include <linux/gpio/property.h>
 #include <linux/leds.h>
 #include <linux/i2c.h>
 #include <linux/platform_data/i2c-pxa.h>
@@ -28,6 +29,7 @@
 #include <linux/input/matrix_keypad.h>
 #include <linux/regulator/machine.h>
 #include <linux/io.h>
+#include <linux/property.h>
 #include <linux/reboot.h>
 #include <linux/memblock.h>
 
@@ -128,6 +130,15 @@ static unsigned long spitz_pin_config[] __initdata = {
 	GPIO1_GPIO | WAKEUP_ON_EDGE_FALL,	/* SPITZ_GPIO_RESET */
 };
 
+static const struct software_node pxa_gpiochip_node = {
+	.name = "gpio-pxa",
+};
+
+static const struct software_node *spitz_gpiochip_nodes[] = {
+	&pxa_gpiochip_node,
+	/* TODO: add the GPIO expander nodes here */
+	NULL
+};
 
 /******************************************************************************
  * Scoop GPIO expander
@@ -500,31 +511,23 @@ static inline void spitz_leds_init(void) {}
  * SSP Devices
  ******************************************************************************/
 #if defined(CONFIG_SPI_PXA2XX) || defined(CONFIG_SPI_PXA2XX_MODULE)
-static void spitz_ads7846_wait_for_hsync(void)
-{
-	while (gpio_get_value(SPITZ_GPIO_HSYNC))
-		cpu_relax();
-
-	while (!gpio_get_value(SPITZ_GPIO_HSYNC))
-		cpu_relax();
-}
 
-static struct ads7846_platform_data spitz_ads7846_info = {
-	.model			= 7846,
-	.vref_delay_usecs	= 100,
-	.x_plate_ohms		= 419,
-	.y_plate_ohms		= 486,
-	.pressure_max		= 1024,
-	.wait_for_sync		= spitz_ads7846_wait_for_hsync,
+static const struct property_entry spitz_ads7846_props[] = {
+	PROPERTY_ENTRY_STRING("compatible", "ti,ads7846"),
+	PROPERTY_ENTRY_U32("touchscreen-max-pressure", 1024),
+	PROPERTY_ENTRY_U16("ti,x-plate-ohms", 419),
+	PROPERTY_ENTRY_U16("ti,y-plate-ohms", 486),
+	PROPERTY_ENTRY_U16("ti,vref-delay-usecs", 100),
+	PROPERTY_ENTRY_GPIO("pendown-gpios", &pxa_gpiochip_node,
+			    SPITZ_GPIO_TP_INT, GPIO_ACTIVE_LOW),
+	PROPERTY_ENTRY_GPIO("ti,hsync-gpios", &pxa_gpiochip_node,
+			    SPITZ_GPIO_HSYNC, GPIO_ACTIVE_LOW),
+	{ }
 };
 
-static struct gpiod_lookup_table spitz_ads7846_gpio_table = {
-	.dev_id = "spi2.0",
-	.table = {
-		GPIO_LOOKUP("gpio-pxa", SPITZ_GPIO_TP_INT,
-			    "pendown", GPIO_ACTIVE_LOW),
-		{ }
-	},
+static const struct software_node spitz_ads7846_swnode = {
+	.name = "ads7846",
+	.properties = spitz_ads7846_props,
 };
 
 static struct gpiod_lookup_table spitz_lcdcon_gpio_table = {
@@ -563,8 +566,7 @@ static struct spi_board_info spitz_spi_devices[] = {
 		.max_speed_hz		= 1200000,
 		.bus_num		= 2,
 		.chip_select		= 0,
-		.platform_data		= &spitz_ads7846_info,
-		.irq			= PXA_GPIO_TO_IRQ(SPITZ_GPIO_TP_INT),
+		.swnode			= &spitz_ads7846_swnode,
 	}, {
 		.modalias		= "corgi-lcd",
 		.max_speed_hz		= 50000,
@@ -579,18 +581,18 @@ static struct spi_board_info spitz_spi_devices[] = {
 	},
 };
 
-static struct pxa2xx_spi_controller spitz_spi_info = {
-	.num_chipselect	= 3,
+static const struct software_node_ref_args spitz_spi_gpio_refs[] = {
+	SOFTWARE_NODE_REFERENCE(&pxa_gpiochip_node, SPITZ_GPIO_ADS7846_CS,
+				GPIO_ACTIVE_LOW),
+	SOFTWARE_NODE_REFERENCE(&pxa_gpiochip_node, SPITZ_GPIO_LCDCON_CS,
+				GPIO_ACTIVE_LOW),
+	SOFTWARE_NODE_REFERENCE(&pxa_gpiochip_node, SPITZ_GPIO_MAX1111_CS,
+				GPIO_ACTIVE_LOW),
 };
 
-static struct gpiod_lookup_table spitz_spi_gpio_table = {
-	.dev_id = "spi2",
-	.table = {
-		GPIO_LOOKUP_IDX("gpio-pxa", SPITZ_GPIO_ADS7846_CS, "cs", 0, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("gpio-pxa", SPITZ_GPIO_LCDCON_CS, "cs", 1, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("gpio-pxa", SPITZ_GPIO_MAX1111_CS, "cs", 2, GPIO_ACTIVE_LOW),
-		{ },
-	},
+static const struct property_entry spitz_spi_props[] = {
+	PROPERTY_ENTRY_REF_ARRAY("gpios", spitz_spi_gpio_refs),
+	{ }
 };
 
 static void __init spitz_spi_init(void)
@@ -600,9 +602,7 @@ static void __init spitz_spi_init(void)
 	else
 		gpiod_add_lookup_table(&spitz_lcdcon_gpio_table);
 
-	gpiod_add_lookup_table(&spitz_ads7846_gpio_table);
-	gpiod_add_lookup_table(&spitz_spi_gpio_table);
-	pxa2xx_set_spi_info(2, &spitz_spi_info);
+	pxa2xx_set_spi_node(2, spitz_spi_props);
 	spi_register_board_info(ARRAY_AND_SIZE(spitz_spi_devices));
 }
 #else
@@ -1007,6 +1007,7 @@ static void spitz_restart(enum reboot_mode mode, const char *cmd)
 
 static void __init spitz_init(void)
 {
+	software_node_register_node_group(spitz_gpiochip_nodes);
 	init_gpio_reset(SPITZ_GPIO_ON_RESET, 1, 0);
 	pm_power_off = spitz_poweroff;
 
diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index d2bbb436a77d..af02f70e66fc 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -138,8 +138,7 @@ struct ads7846 {
 	void			*filter_data;
 	int			(*get_pendown_state)(void);
 	struct gpio_desc	*gpio_pendown;
-
-	void			(*wait_for_sync)(void);
+	struct gpio_desc	*gpio_hsync;
 };
 
 enum ads7846_filter {
@@ -634,10 +633,6 @@ ATTRIBUTE_GROUPS(ads784x);
 
 /*--------------------------------------------------------------------------*/
 
-static void null_wait_for_sync(void)
-{
-}
-
 static int ads7846_debounce_filter(void *ads, int data_idx, int *val)
 {
 	struct ads7846 *ts = ads;
@@ -790,6 +785,23 @@ static int ads7846_filter(struct ads7846 *ts)
 	return 0;
 }
 
+static void ads7846_wait_for_hsync(struct ads7846 *ts)
+{
+	if (!ts->gpio_hsync)
+		return;
+
+	/*
+	 * Wait for HSYNC to assert the line should be flagged
+	 * as active low so here we are waiting for it to assert
+	 */
+	while (!gpiod_get_value(ts->gpio_hsync))
+		cpu_relax();
+
+	/* Then we wait for it do de-assert */
+	while (gpiod_get_value(ts->gpio_hsync))
+		cpu_relax();
+}
+
 static void ads7846_read_state(struct ads7846 *ts)
 {
 	struct ads7846_packet *packet = ts->packet;
@@ -800,8 +812,7 @@ static void ads7846_read_state(struct ads7846 *ts)
 	packet->last_cmd_idx = 0;
 
 	while (true) {
-		ts->wait_for_sync();
-
+		ads7846_wait_for_hsync(ts);
 		m = &ts->msg[msg_idx];
 		error = spi_sync(ts->spi, m);
 		if (error) {
@@ -1258,7 +1269,9 @@ static int ads7846_probe(struct spi_device *spi)
 		ts->penirq_recheck_delay_usecs =
 				pdata->penirq_recheck_delay_usecs;
 
-	ts->wait_for_sync = pdata->wait_for_sync ? : null_wait_for_sync;
+	ts->gpio_hsync = devm_gpiod_get_optional(dev, "ti,hsync", GPIOD_IN);
+	if (IS_ERR(ts->gpio_hsync))
+		return PTR_ERR(ts->gpio_hsync);
 
 	snprintf(ts->phys, sizeof(ts->phys), "%s/input0", dev_name(dev));
 	snprintf(ts->name, sizeof(ts->name), "ADS%d Touchscreen", ts->model);
diff --git a/include/linux/spi/ads7846.h b/include/linux/spi/ads7846.h
index a04c1c34c344..fa7c4f119023 100644
--- a/include/linux/spi/ads7846.h
+++ b/include/linux/spi/ads7846.h
@@ -38,7 +38,6 @@ struct ads7846_platform_data {
 	int	gpio_pendown_debounce;	/* platform specific debounce time for
 					 * the gpio_pendown */
 	int	(*get_pendown_state)(void);
-	void	(*wait_for_sync)(void);
 	bool	wakeup;
 	unsigned long irq_flags;
 };
diff --git a/include/linux/spi/pxa2xx_spi.h b/include/linux/spi/pxa2xx_spi.h
index ca2cd4e30ead..d166d4469fec 100644
--- a/include/linux/spi/pxa2xx_spi.h
+++ b/include/linux/spi/pxa2xx_spi.h
@@ -6,6 +6,7 @@
 #define __LINUX_SPI_PXA2XX_SPI_H
 
 #include <linux/dmaengine.h>
+#include <linux/property.h>
 #include <linux/types.h>
 
 #include <linux/pxa2xx_ssp.h>
@@ -50,6 +51,7 @@ struct pxa2xx_spi_chip {
 #include <linux/clk.h>
 
 extern void pxa2xx_set_spi_info(unsigned id, struct pxa2xx_spi_controller *info);
+void pxa2xx_set_spi_node(unsigned id, const struct property_entry *props);
 
 #endif
 

-- 
2.44.0


