Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13FDA808C5
	for <lists+linux-spi@lfdr.de>; Sun,  4 Aug 2019 02:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbfHDAlB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 3 Aug 2019 20:41:01 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33970 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729372AbfHDAlA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 3 Aug 2019 20:41:00 -0400
Received: by mail-lj1-f195.google.com with SMTP id p17so76166767ljg.1
        for <linux-spi@vger.kernel.org>; Sat, 03 Aug 2019 17:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=83IVBUszXJBDBbbp8swTg62jU4/KejA7UpzPe0S6xm0=;
        b=Bh7MnHYJZl49goeYeBqiYnQPcskpwVWmg8V1GLR4XNU0Ag8CznRicpcqNiDtOVjsJX
         x7x3Ku5PctABAZ7hlhuiIU+dPypZ8LUIlhrxJ5VJJkVvCNrBlyFhuuO3phV273fqwwO5
         D2TqK1a4qC4ktSTEjzQBpsbVbHD4l66lzyZZgzZoU/BS74shvxkBHvTUoIw9za2a3Eya
         h5bx8iFBpP/t0bCzyUVw1zWiRW7JCXUNWIzoFqzK1lkFAJZ9ve6G5DzmSt4NxJzpjo7i
         mjJvTC7ty6KDXaFMyDskhSbQ0XvVKGZUWyoVvETJ8GF5+lMRgmF8GepMDkths/ljM8dL
         DTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=83IVBUszXJBDBbbp8swTg62jU4/KejA7UpzPe0S6xm0=;
        b=JMILtmtTFz4OBZvk9n2yxT1ZPnvUr6u/n89PtiMR8JTbNN5TukKFz3BobERBxIKode
         NdC6wi2H/VwzifF5MMXnXZH3kr4QutwiFTpwrRq9fdSTztvaK2YT90+xamxmBRN7Bu9C
         Dbb2sX1oBRmuWFvhpKLTYf9ejjOfjJ//p3Z0bzhJl2lPfFoiHPlRYbvMYAw4MiTINCh6
         PqsAxnr0QqXfVQNfaYpMcAxva6wBSdCIdKtNeCZ7Gq3QRljvN4pTXBykYK2KFZN6pKx3
         HIkWWjbqSZnGW3zVm2W4AXmOaj3sA4WYTrAuFeab0AmzrIZbH5adyJKRw2tyT1FlNKrf
         KRIQ==
X-Gm-Message-State: APjAAAWY/Gip//fJv0H5GuC9mLndEeZ3cGtgfbHBVTgqYUdN+7FFDQEL
        biz0u1+dKZ7eZheMbW7EzNH/XA==
X-Google-Smtp-Source: APXvYqxD+Z5r+DO33M2OTj+KZ/rbnBZZiu/iWM+krMOc8IkE+sqfU8ExW8SIln5EB5HcVOEznTj6Ew==
X-Received: by 2002:a2e:8696:: with SMTP id l22mr10773261lji.201.1564879257882;
        Sat, 03 Aug 2019 17:40:57 -0700 (PDT)
Received: from localhost.localdomain (c-2ccd225c.014-348-6c756e10.bbcust.telenor.se. [92.34.205.44])
        by smtp.gmail.com with ESMTPSA id k23sm12363158ljg.90.2019.08.03.17.40.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 03 Aug 2019 17:40:56 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lukas Wunner <lukas@wunner.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Martin Sperl <kernel@martin.sperl.org>,
        Chris Boot <bootc@bootc.net>
Subject: [PATCH v4] spi: bcm2835: Convert to use CS GPIO descriptors
Date:   Sun,  4 Aug 2019 02:38:52 +0200
Message-Id: <20190804003852.1312-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

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
---
ChangeLog v3->v4:
- Fix the offset of the chipselect line to be 8 - CS
  as in the original code.
- Use the modified gpiochip_request_own_desc() to set up
  line inversion semantics if need be. Look at the OF
  node of the SPI device for flags.
ChangeLog v2->v3:
- Fix unused variable "err" compile-time message.
ChangeLog RFT->v2:
- Rebased on v5.1-rc1

I would very much appreciate if someone took this for
a ride on top of linux-next (there are some fixes in
the -rcs you need) and see if all still works as expected.
---
 drivers/spi/spi-bcm2835.c | 58 +++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 6f243a90c844..a40c09c553d3 100644
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
 
@@ -930,14 +932,19 @@ static int chip_match_name(struct gpio_chip *chip, void *data)
 
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
@@ -948,29 +955,43 @@ static int bcm2835_spi_setup(struct spi_device *spi)
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
@@ -988,6 +1009,7 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ctlr);
 
+	ctlr->use_gpio_descriptors = true;
 	ctlr->mode_bits = BCM2835_SPI_MODE_BITS;
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctlr->num_chipselect = 3;
-- 
2.21.0

