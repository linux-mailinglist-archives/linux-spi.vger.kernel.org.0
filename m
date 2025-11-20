Return-Path: <linux-spi+bounces-11406-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FE7C74349
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 14:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id EC47930BB8
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 13:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4F3340A4C;
	Thu, 20 Nov 2025 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2UaiMPMD"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517FE33F390
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763645069; cv=none; b=uxml84H9OYtJwYjdGqp/iUvPggsrO1Tmqvlw73C3n7qy1uhOvgBouLZh49nmP1muS+jMqo3LAY9vge8x1Crh5is4UTHX9Wud507kIT/FSihYzGY34EQaP7SG01vw98k9KO3QkklOGxSBbFlTo/TeHOY3rNsipZHmp450/hzzEkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763645069; c=relaxed/simple;
	bh=TmnPwRPKxNqDK4kqJf7gkqi9ML3vw5hcnCB0TrZwF+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IHiWsDwuriLFI/WBzWgMQPdBnXgx6UoM1393MdrM/YGtyDllaVAyzBHQWnPp3F2yiEHrIgxCtpJ3H3c28NnDUq7Dq+RRjgi1e/QMvyUeaTel9rfNmkwDbYnBGMt/nIINTrBZSv2qmCit6s0xN1+dI/bEW+Yt8OrXdF8DT2QvTIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2UaiMPMD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4775ae77516so9796215e9.1
        for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 05:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763645061; x=1764249861; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4XjD0ueSQIVGxSnWq5N3fbydIO3JRz9g8LzIgvZUmG8=;
        b=2UaiMPMD8sG8UssyS9sKwozsoxbZT8fNWYYFijsRQiLud51+TaXDixljGfwhTBoa0B
         2YBSDAKvAvu1SLUCiJT0RXEO8x1mr9TxGSZcAxcrezztXGDejcuLEe3J1R/v3ZLfewdH
         Q9AKIaFlNvY6+x4PCwF/BWkKr9mxR0TAv1viTY/0kc7dE4Le3FJ+YI2L4yCNGbRnomLt
         JeovOk8QV8nAWMqPYjDpuKtQr8TojLC028raL9gMgnB2TbVKpdRT04+Hr+DyOgY8ybMn
         IgXMB8c9Xl2L29SVcYx9/dUiI4ozgwJNGkaeBrJlnU71Z2kYLaa7ut/5GaaHZKa67Vj8
         vvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763645061; x=1764249861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4XjD0ueSQIVGxSnWq5N3fbydIO3JRz9g8LzIgvZUmG8=;
        b=C3zTaZZ4BYIyqUEqtBDAJL8oUTc71TIymPDeJsJ5VmU09HlMezdZzmP+DqC+O9Kv6k
         kisilA2d3cKPAlWfS+jpmO9h0sVfkhe+GSwpCh09vcxHhdpoXmV4NxsVGwv1PKcaffkg
         EHXGJJhdYIN2TCLGRO75uD3DCD4Gd8q0YtKpuIjpX6RldVgVULH+642418xt+31HSOed
         v5YV183K7AkDDNBKY6/4G40DfdUGS+G8yWnbFPG95eMGko4TnFMuM8+Qbun7AOSKbc5o
         rEY/3y/O6sKSb407YfkIFIWzAnzd58lxrgspiRBRkNmzm7nJY9Vv1hjtf7/LywTtGvPN
         +cSw==
X-Forwarded-Encrypted: i=1; AJvYcCWCrHySx4z3NjKmSsoFkg2ull1qeeB6zoPoTc5+2xKVBPZ3aNPxv/RS8ozyEoz4oldhN3jNErZ5j9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCP4bge30U9IEvnxOmyOm8XMEDweArrUSYcQMn9SZInfcGW2D1
	oNKGZ04qEvHEBRRHVUwPyhcasqNuYS7QMJzomw4kBspRpAun2bxMSL+hwCspFnt0zwY=
X-Gm-Gg: ASbGncvo8K24yz/KEkg6KJDLnzQpZ5G3Q6CSjUs58vsGYqCFCxoW7s2QjVG4Lyllqtf
	/p+t8z2j/svBsxIO9BREH+iNFjgkkFoEg+sSy0RpEQN6haHr37YgtcgTavKRRnnGiRu5qHlbTOS
	A8YJe3P0gsoPDuYgdJTsxJiobanvxsC24iXckVQQ3no/vCJBt+4w7KysgxmXDI71zeIK84835Ue
	q5mTPg7Bb/qw9h7CQOgW5JVNT0g6m9KRR+FT2QFzl06NziHxcJzHNtEBd2tsb1/qtZJOFagR7Ie
	0Zqd1ohPKPXaR5v14yfydKkPMkt0HuSuYNnC14kmx3E/s89erYCsMmTAmcO9ktjTD0+DjMB7J3B
	JUJELR3s8BtLkRUFu7jMPo53udTX4pW+cG1UL1j134WRRPkgc7RoOa2oLUCTCcbpVuTMfbw+pgS
	y+FbY=
X-Google-Smtp-Source: AGHT+IH6vuUXtQR0V74bFxueAkhlb1rxpZ2IJm5JuJVY/HCjNaVgdMXz0xpHyMcS1GsLh4Ijmud52A==
X-Received: by 2002:a05:600c:154d:b0:475:d8b3:a9d5 with SMTP id 5b1f17b1804b1-477b8953efdmr36167295e9.10.1763645060976;
        Thu, 20 Nov 2025 05:24:20 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:37af:6c1f:28a:47d2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b82cc72dsm46762935e9.1.2025.11.20.05.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 05:24:20 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Nov 2025 14:24:03 +0100
Subject: [PATCH v7 8/9] reset: gpio: convert the driver to using the
 auxiliary bus
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-reset-gpios-swnodes-v7-8-a100493a0f4b@linaro.org>
References: <20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org>
In-Reply-To: <20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Mark Brown <broonie@kernel.org>, 
 Maciej Strozek <mstrozek@opensource.cirrus.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-sound@vger.kernel.org, 
 patches@opensource.cirrus.com, linux-spi@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5143;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=KmSwa9RPZ6TcHq3hcL4F56YB9LD5MmMIEe1ovhHQ/ek=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpHxZ0kT6+RHdf8teKNwn/OCNtuIggjuyI0WJtv
 RrJ4k8WfqaJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaR8WdAAKCRAFnS7L/zaE
 w9oRD/4w+yTXcGQDgBD2AkFNCjVW169CvEZDNpxIWwn8p4/8WKdVbKIRy9ldTYs3xMQsC6SBYmO
 BbuZtGJJkxQsEHA33nRWUBlUTPNbseHPESTeNt8X9QOQX01uwF4t0mcN7v8fZ/h3Bf1XVX3VoeQ
 LtthcPFxv0I16Bxv2roIJvfnwVwYOmYbrnxW91DAiwKTmQ1Y2T/Ajw4rp9EAwqcHmdy2N10vcQR
 IvtulANBhSy3cLRG+afIeKDM2rWV86aFFktjV02p+ffUtfYcCibQeuXc9IegwtjftptH6RxCDUC
 jhg20ItvFg8t25huMvBlzIGB+g90L6gfs8YsBtNuCVnXJ/yXXtGUBf+f+mavGUrbbWgEg1p9bTH
 77wU9lOyKMfw0TLgPCrTXbTchX+0jddQEov2yCVwCpqMmM2MwiIR3xD3ZB9whRouzLXL1xffUG8
 0nL45YdejFVdx/gWaWI2WiW1ptKKgaCdBWkL7d4shrS7m6gkY/YPRt+NkpkQSjH4tyIeUOEfltN
 Wjz/KxArwX3u8m270Sso7GRWpFHi47r4zZ00MI9FgsKQica3Bg/aa2zt1aGypPieOmDKkYpsSeT
 5Igo4lrt+mm2mpDokz3YIuT4Nl8xVSfTIQf1TPFCowUWlW3SEkainSqgbPmT9MItYRj7aRBPv6Z
 +SBs2oQU7YGb/RA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

As the reset-gpio devices are purely virtual and never instantiated from
real firmware nodes, let's convert the driver to using the - more
fitting - auxiliary bus.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/reset/Kconfig      |  1 +
 drivers/reset/core.c       | 14 ++++++--------
 drivers/reset/reset-gpio.c | 19 ++++++++++---------
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 9951dbd50130946952f3bbfc4b97525978f494ae..e158a818fb0897a51af370a8e5ce058e1de3b4ee 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -99,6 +99,7 @@ config RESET_EYEQ
 config RESET_GPIO
 	tristate "GPIO reset controller"
 	depends on GPIOLIB
+	select AUXILIARY_BUS
 	help
 	  This enables a generic reset controller for resets attached via
 	  GPIOs.  Typically for OF platforms this driver expects "reset-gpios"
diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 50ff078dea7fd84d59e505fc1f607f593ec6381f..1f5f8d85dc16142da3e3a9988f2737c83550cb2f 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -7,6 +7,7 @@
 
 #include <linux/acpi.h>
 #include <linux/atomic.h>
+#include <linux/auxiliary_bus.h>
 #include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -18,7 +19,6 @@
 #include <linux/kref.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/reset-controller.h>
 #include <linux/slab.h>
@@ -852,7 +852,7 @@ static int __reset_add_reset_gpio_lookup(struct gpio_device *gdev, int id,
 	if (!lookup)
 		return -ENOMEM;
 
-	lookup->dev_id = kasprintf(GFP_KERNEL, "reset-gpio.%d", id);
+	lookup->dev_id = kasprintf(GFP_KERNEL, "reset.gpio.%d", id);
 	if (!lookup->dev_id)
 		return -ENOMEM;
 
@@ -873,7 +873,7 @@ static int __reset_add_reset_gpio_lookup(struct gpio_device *gdev, int id,
 static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 {
 	struct reset_gpio_lookup *rgpio_dev;
-	struct platform_device *pdev;
+	struct auxiliary_device *adev;
 	int id, ret;
 
 	/*
@@ -929,11 +929,9 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 	 * Hold reference as long as rgpio_dev memory is valid.
 	 */
 	of_node_get(rgpio_dev->of_args.np);
-	pdev = platform_device_register_data(gpio_device_to_device(gdev),
-					     "reset-gpio", id,
-					     &rgpio_dev->of_args,
-					     sizeof(rgpio_dev->of_args));
-	ret = PTR_ERR_OR_ZERO(pdev);
+	adev = auxiliary_device_create(gpio_device_to_device(gdev), "reset",
+				       "gpio", &rgpio_dev->of_args, id);
+	ret = PTR_ERR_OR_ZERO(adev);
 	if (ret)
 		goto err_put;
 
diff --git a/drivers/reset/reset-gpio.c b/drivers/reset/reset-gpio.c
index 2290b25b6703536f2245f15cab870bd7092d3453..e5512b3b596b5290af20e5fdd99a38f81e670d2b 100644
--- a/drivers/reset/reset-gpio.c
+++ b/drivers/reset/reset-gpio.c
@@ -1,10 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/auxiliary_bus.h>
 #include <linux/gpio/consumer.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 
 struct reset_gpio_priv {
@@ -61,9 +61,10 @@ static void reset_gpio_of_node_put(void *data)
 	of_node_put(data);
 }
 
-static int reset_gpio_probe(struct platform_device *pdev)
+static int reset_gpio_probe(struct auxiliary_device *adev,
+			    const struct auxiliary_device_id *id)
 {
-	struct device *dev = &pdev->dev;
+	struct device *dev = &adev->dev;
 	struct of_phandle_args *platdata = dev_get_platdata(dev);
 	struct reset_gpio_priv *priv;
 	int ret;
@@ -75,7 +76,7 @@ static int reset_gpio_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, &priv->rc);
+	auxiliary_set_drvdata(adev, &priv->rc);
 
 	priv->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(priv->reset))
@@ -99,20 +100,20 @@ static int reset_gpio_probe(struct platform_device *pdev)
 	return devm_reset_controller_register(dev, &priv->rc);
 }
 
-static const struct platform_device_id reset_gpio_ids[] = {
-	{ .name = "reset-gpio", },
+static const struct auxiliary_device_id reset_gpio_ids[] = {
+	{ .name = "reset.gpio" },
 	{}
 };
-MODULE_DEVICE_TABLE(platform, reset_gpio_ids);
+MODULE_DEVICE_TABLE(auxiliary, reset_gpio_ids);
 
-static struct platform_driver reset_gpio_driver = {
+static struct auxiliary_driver reset_gpio_driver = {
 	.probe		= reset_gpio_probe,
 	.id_table	= reset_gpio_ids,
 	.driver	= {
 		.name = "reset-gpio",
 	},
 };
-module_platform_driver(reset_gpio_driver);
+module_auxiliary_driver(reset_gpio_driver);
 
 MODULE_AUTHOR("Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>");
 MODULE_DESCRIPTION("Generic GPIO reset driver");

-- 
2.51.0


