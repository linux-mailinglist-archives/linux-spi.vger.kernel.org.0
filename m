Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBB1310C953
	for <lists+linux-spi@lfdr.de>; Thu, 28 Nov 2019 14:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfK1NTB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Nov 2019 08:19:01 -0500
Received: from foss.arm.com ([217.140.110.172]:35296 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfK1NTA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 28 Nov 2019 08:19:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15CA130E;
        Thu, 28 Nov 2019 05:19:00 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89C923F52E;
        Thu, 28 Nov 2019 05:18:59 -0800 (PST)
Date:   Thu, 28 Nov 2019 13:18:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "gpio: Handle counting of Freescale chipselects" to the spi tree
In-Reply-To: <20191128083718.39177-2-linus.walleij@linaro.org>
Message-Id: <applied-20191128083718.39177-2-linus.walleij@linaro.org>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   gpio: Handle counting of Freescale chipselects

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

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

From 71b8f600b034c7f5780f6fb311dabfe331c64feb Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Nov 2019 09:37:17 +0100
Subject: [PATCH] gpio: Handle counting of Freescale chipselects

We have a special quirk to handle the Freescale
nonstandard SPI chipselect GPIOs in the gpiolib-of.c
file, but it currently only handles the case where
the GPIOs are actually requested (gpiod_*get()).

We also need to handle that the SPI core attempts
to count the GPIOs before use, and that needs a
similar quirk in the OF part of the library.

Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
Fixes: 0f0581b24bd0 ("spi: fsl: Convert to use CS GPIO descriptors")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Link: https://lore.kernel.org/r/20191128083718.39177-2-linus.walleij@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/gpio/gpiolib-of.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 1eea2c6c2e1d..4b19e7e26b90 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -23,6 +23,29 @@
 #include "gpiolib.h"
 #include "gpiolib-of.h"
 
+/**
+ * of_gpio_spi_cs_get_count() - special GPIO counting for SPI
+ * Some elder GPIO controllers need special quirks. Currently we handle
+ * the Freescale GPIO controller with bindings that doesn't use the
+ * established "cs-gpios" for chip selects but instead rely on
+ * "gpios" for the chip select lines. If we detect this, we redirect
+ * the counting of "cs-gpios" to count "gpios" transparent to the
+ * driver.
+ */
+int of_gpio_spi_cs_get_count(struct device *dev, const char *con_id)
+{
+	struct device_node *np = dev->of_node;
+
+	if (!IS_ENABLED(CONFIG_SPI_MASTER))
+		return 0;
+	if (!con_id || strcmp(con_id, "cs"))
+		return 0;
+	if (!of_device_is_compatible(np, "fsl,spi") &&
+	    !of_device_is_compatible(np, "aeroflexgaisler,spictrl"))
+		return 0;
+	return of_gpio_named_count(np, "gpios");
+}
+
 /*
  * This is used by external users of of_gpio_count() from <linux/of_gpio.h>
  *
@@ -35,6 +58,10 @@ int of_gpio_get_count(struct device *dev, const char *con_id)
 	char propname[32];
 	unsigned int i;
 
+	ret = of_gpio_spi_cs_get_count(dev, con_id);
+	if (ret > 0)
+		return ret;
+
 	for (i = 0; i < ARRAY_SIZE(gpio_suffixes); i++) {
 		if (con_id)
 			snprintf(propname, sizeof(propname), "%s-%s",
-- 
2.20.1

