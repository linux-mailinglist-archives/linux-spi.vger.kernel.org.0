Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D39B7A02C6
	for <lists+linux-spi@lfdr.de>; Wed, 28 Aug 2019 15:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfH1NN0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 28 Aug 2019 09:13:26 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37472 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfH1NN0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 28 Aug 2019 09:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=5tb+NIh7e3Chvdhnoia3kXhi2ne6P6ItPW05xPdWKoQ=; b=aFfJrtICLWWL
        d4jTfJsRGdSffUvlzmbWRY4J/evl4nwk4uQyZDYLRRRxwjME0OengrQNpEZQE69Q1FS0yvFKiCFhu
        vQl1ztCaGt9/I+EuwPeIMi6HW776BU6NAV14u2UOCLEhhaf5x0Ev+AyerevDxMG7vNZ+/DK/hP0f+
        XCg7c=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i2xlG-0004Hg-Nv; Wed, 28 Aug 2019 13:13:18 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 7B89E2742B61; Wed, 28 Aug 2019 14:13:17 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Chris Boot <bootc@bootc.net>, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Mark Brown <broonie@kernel.org>,
        Martin Sperl <kernel@martin.sperl.org>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: Applied "spi: bcm2835: Convert to use CS GPIO descriptors" to the spi tree
In-Reply-To: <20190804003852.1312-1-linus.walleij@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190828131317.7B89E2742B61@ypsilon.sirena.org.uk>
Date:   Wed, 28 Aug 2019 14:13:17 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: bcm2835: Convert to use CS GPIO descriptors

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

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

From 3bd158c56a56e8767e569d7fbc66efbedc478077 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 4 Aug 2019 02:38:52 +0200
Subject: [PATCH] spi: bcm2835: Convert to use CS GPIO descriptors

This converts the BCM2835 SPI master driver to use GPIO
descriptors for chip select handling.

The BCM2835 driver was relying on the core to drive the
CS high/low so very small changes were needed for this
part. If it managed to request the CS from the device tree
node, all is pretty straight forward.

However for native GPIOs this driver has a quite unorthodox
loopback to request some GPIOs from the SoC GPIO chip by
looking it up from the device tree using gpiochip_find()
and then offseting hard into its numberspace. This has
been augmented a bit by using gpiochip_request_own_desc()
but this code really needs to be verified. If "native CS"
is actually an SoC GPIO, why is it even done this way?
Should this GPIO not just be defined in the device tree
like any other CS GPIO? I'm confused.

Cc: Lukas Wunner <lukas@wunner.de>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Martin Sperl <kernel@martin.sperl.org>
Cc: Chris Boot <bootc@bootc.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20190804003852.1312-1-linus.walleij@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm2835.c | 58 +++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 4b89e0a04ffd..fd2bfb4aa8c3 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -25,7 +25,9 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
+#include <linux/gpio/machine.h> /* FIXME: using chip internals */
+#include <linux/gpio/driver.h> /* FIXME: using chip internals */
 #include <linux/of_irq.h>
 #include <linux/spi/spi.h>
 
@@ -931,14 +933,19 @@ static int chip_match_name(struct gpio_chip *chip, void *data)
 
 static int bcm2835_spi_setup(struct spi_device *spi)
 {
-	int err;
 	struct gpio_chip *chip;
+	enum gpio_lookup_flags lflags;
+
 	/*
 	 * sanity checking the native-chipselects
 	 */
 	if (spi->mode & SPI_NO_CS)
 		return 0;
-	if (gpio_is_valid(spi->cs_gpio))
+	/*
+	 * The SPI core has successfully requested the CS GPIO line from the
+	 * device tree, so we are done.
+	 */
+	if (spi->cs_gpiod)
 		return 0;
 	if (spi->chip_select > 1) {
 		/* error in the case of native CS requested with CS > 1
@@ -949,29 +956,43 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 			"setup: only two native chip-selects are supported\n");
 		return -EINVAL;
 	}
-	/* now translate native cs to GPIO */
+
+	/*
+	 * Translate native CS to GPIO
+	 *
+	 * FIXME: poking around in the gpiolib internals like this is
+	 * not very good practice. Find a way to locate the real problem
+	 * and fix it. Why is the GPIO descriptor in spi->cs_gpiod
+	 * sometimes not assigned correctly? Erroneous device trees?
+	 */
 
 	/* get the gpio chip for the base */
 	chip = gpiochip_find("pinctrl-bcm2835", chip_match_name);
 	if (!chip)
 		return 0;
 
-	/* and calculate the real CS */
-	spi->cs_gpio = chip->base + 8 - spi->chip_select;
+	/*
+	 * Retrieve the corresponding GPIO line used for CS.
+	 * The inversion semantics will be handled by the GPIO core
+	 * code, so we pass GPIOS_OUT_LOW for "unasserted" and
+	 * the correct flag for inversion semantics. The SPI_CS_HIGH
+	 * on spi->mode cannot be checked for polarity in this case
+	 * as the flag use_gpio_descriptors enforces SPI_CS_HIGH.
+	 */
+	if (of_property_read_bool(spi->dev.of_node, "spi-cs-high"))
+		lflags = GPIO_ACTIVE_HIGH;
+	else
+		lflags = GPIO_ACTIVE_LOW;
+	spi->cs_gpiod = gpiochip_request_own_desc(chip, 8 - spi->chip_select,
+						  DRV_NAME,
+						  lflags,
+						  GPIOD_OUT_LOW);
+	if (IS_ERR(spi->cs_gpiod))
+		return PTR_ERR(spi->cs_gpiod);
 
 	/* and set up the "mode" and level */
-	dev_info(&spi->dev, "setting up native-CS%i as GPIO %i\n",
-		 spi->chip_select, spi->cs_gpio);
-
-	/* set up GPIO as output and pull to the correct level */
-	err = gpio_direction_output(spi->cs_gpio,
-				    (spi->mode & SPI_CS_HIGH) ? 0 : 1);
-	if (err) {
-		dev_err(&spi->dev,
-			"could not set CS%i gpio %i as output: %i",
-			spi->chip_select, spi->cs_gpio, err);
-		return err;
-	}
+	dev_info(&spi->dev, "setting up native-CS%i to use GPIO\n",
+		 spi->chip_select);
 
 	return 0;
 }
@@ -989,6 +1010,7 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ctlr);
 
+	ctlr->use_gpio_descriptors = true;
 	ctlr->mode_bits = BCM2835_SPI_MODE_BITS;
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctlr->num_chipselect = 3;
-- 
2.20.1

