Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A442D78FC2B
	for <lists+linux-spi@lfdr.de>; Fri,  1 Sep 2023 13:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbjIALQC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Sep 2023 07:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242207AbjIALQC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Sep 2023 07:16:02 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A43310E9
        for <linux-spi@vger.kernel.org>; Fri,  1 Sep 2023 04:15:55 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31aeedbb264so1638038f8f.0
        for <linux-spi@vger.kernel.org>; Fri, 01 Sep 2023 04:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693566954; x=1694171754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JXKeOLDoyy5/kC3fUdlXL9lLNwTUvGaVFBeNIEjZIMQ=;
        b=wItsgk2lVTkrdudb0s+W0fc/IXvfIrdODovm3iV3yIeGU0B8aS0yVO5Y4gjKltEMOv
         qfgdcFxiotpvjsTO/4XV9eBw18shHD0PVJSA81IbW8sH6zCh1mjYS7vm1E2/S2hNGHZt
         UICi58i5uRzpMdxsS2lOSqOn2bRUfCo+YbI5Sq7fHBX+SZuTVrGRxhrKfMy1MTXsy7Ro
         sxuth+yutzO9qGFh9nqrekTOJYbLXPhY8VfgCavJOVs+qmRxUt2LP6ht2GMaHWQmTnxP
         lGIca916IXI9/pojYgdxDZvlOaKFCRJftjOBRb+T5TCHP1t5FCzQekLOUVCXDm8Dt6PL
         KqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693566954; x=1694171754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JXKeOLDoyy5/kC3fUdlXL9lLNwTUvGaVFBeNIEjZIMQ=;
        b=lXX14NP0F0DbsvTasEz0JlrfRB72TKiLPzLLMoGwuHViBIr2LkLpdDnMzF7DeMgXI8
         LO7S3M5m7wqrLGsLvBRyB+6/lsYp6FxPyPV2Iy93DsP+IY8DF9lrEIUDp3zClrY+pHFV
         qJBPZzSD97A+JY8YZgwuDtxdhaZetSprNaMKswz7JLULGVvNCMJiJofu3AUokX+yBZta
         4dnRLQ5syw+HbdxosxBVvGohIRAQe+8O7runVbRMIvWaVq9arWl5LWz4Tpp5oDspw/Ne
         iarKoZjaWu4Zmwk2B8+QRopGlFacNxf3CUd7/4OoCYidbo7vPXrD3bt6v/5Bp8HyWldm
         4a1g==
X-Gm-Message-State: AOJu0Yws7h1NFxuqPF9x7hQgy49nP5U5QOFa1mkq1a08cW0LEwvS2Le0
        w/CLwkSck+aU75WQ3y01Mdt0Wg==
X-Google-Smtp-Source: AGHT+IE+Q3n8iF3DTTB+G/JNTL/+AMsHyYDbREZ9/1BFcmOOL2dovB8KiBgpxGdxnlcSGkTBS0CL8g==
X-Received: by 2002:a5d:4e0e:0:b0:316:fc86:28ae with SMTP id p14-20020a5d4e0e000000b00316fc8628aemr1394230wrt.15.1693566953774;
        Fri, 01 Sep 2023 04:15:53 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e94b:1054:6760:aa27])
        by smtp.gmail.com with ESMTPSA id s2-20020a5d4242000000b003197c2316ecsm4943457wrr.112.2023.09.01.04.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 04:15:53 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RFT PATCH v2] spi: bcm2835: reduce the abuse of the GPIO API
Date:   Fri,  1 Sep 2023 13:15:48 +0200
Message-Id: <20230901111548.12733-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Currently the bcm2835 SPI driver uses functions that are available
exclusively to GPIO providers as a way to handle a platform quirk. Let's
use a slightly better alternative that avoids poking around in GPIOLIB's
internals and use GPIO lookup tables.

Link: https://www.spinics.net/lists/linux-gpio/msg36218.html
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
This is only build-tested. It should work, but it would be great if
someone from broadcom could test this.

v1 -> v2:
- don't use devres for managing the GPIO but put it manually in .cleanup()
- add a mailing list link explaining the background of the bug
- fix kerneldoc

 drivers/spi/spi-bcm2835.c | 59 +++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index e7bb2714678a..e06738705075 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -11,6 +11,7 @@
  * spi-atmel.c, Copyright (C) 2006 Atmel Corporation
  */
 
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/debugfs.h>
@@ -26,9 +27,10 @@
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/gpio/consumer.h>
-#include <linux/gpio/machine.h> /* FIXME: using chip internals */
-#include <linux/gpio/driver.h> /* FIXME: using chip internals */
+#include <linux/gpio/machine.h> /* FIXME: using GPIO lookup tables */
 #include <linux/of_irq.h>
+#include <linux/overflow.h>
+#include <linux/slab.h>
 #include <linux/spi/spi.h>
 
 /* SPI register offsets */
@@ -83,6 +85,7 @@ MODULE_PARM_DESC(polling_limit_us,
  * struct bcm2835_spi - BCM2835 SPI controller
  * @regs: base address of register map
  * @clk: core clock, divided to calculate serial clock
+ * @cs_gpio: chip-select GPIO descriptor
  * @clk_hz: core clock cached speed
  * @irq: interrupt, signals TX FIFO empty or RX FIFO ¾ full
  * @tfr: SPI transfer currently processed
@@ -117,6 +120,7 @@ MODULE_PARM_DESC(polling_limit_us,
 struct bcm2835_spi {
 	void __iomem *regs;
 	struct clk *clk;
+	struct gpio_desc *cs_gpio;
 	unsigned long clk_hz;
 	int irq;
 	struct spi_transfer *tfr;
@@ -1156,15 +1160,11 @@ static void bcm2835_spi_handle_err(struct spi_controller *ctlr,
 	bcm2835_spi_reset_hw(bs);
 }
 
-static int chip_match_name(struct gpio_chip *chip, void *data)
-{
-	return !strcmp(chip->label, data);
-}
-
 static void bcm2835_spi_cleanup(struct spi_device *spi)
 {
 	struct bcm2835_spidev *target = spi_get_ctldata(spi);
 	struct spi_controller *ctlr = spi->controller;
+	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
 
 	if (target->clear_rx_desc)
 		dmaengine_desc_free(target->clear_rx_desc);
@@ -1175,6 +1175,9 @@ static void bcm2835_spi_cleanup(struct spi_device *spi)
 				 sizeof(u32),
 				 DMA_TO_DEVICE);
 
+	gpiod_put(bs->cs_gpio);
+	spi_set_csgpiod(spi, 0, NULL);
+
 	kfree(target);
 }
 
@@ -1221,7 +1224,7 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 	struct spi_controller *ctlr = spi->controller;
 	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
 	struct bcm2835_spidev *target = spi_get_ctldata(spi);
-	struct gpio_chip *chip;
+	struct gpiod_lookup_table *lookup __free(kfree) = NULL;
 	int ret;
 	u32 cs;
 
@@ -1288,29 +1291,37 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 	}
 
 	/*
-	 * Translate native CS to GPIO
+	 * TODO: The code below is a slightly better alternative to the utter
+	 * abuse of the GPIO API that I found here before. It creates a
+	 * temporary lookup table, assigns it to the SPI device, gets the GPIO
+	 * descriptor and then releases the lookup table.
 	 *
-	 * FIXME: poking around in the gpiolib internals like this is
-	 * not very good practice. Find a way to locate the real problem
-	 * and fix it. Why is the GPIO descriptor in spi->cs_gpiod
-	 * sometimes not assigned correctly? Erroneous device trees?
+	 * More on the problem that it addresses:
+	 *   https://www.spinics.net/lists/linux-gpio/msg36218.html
 	 */
+	lookup = kzalloc(struct_size(lookup, table, 1), GFP_KERNEL);
+	if (!lookup) {
+		ret = -ENOMEM;
+		goto err_cleanup;
+	}
 
-	/* get the gpio chip for the base */
-	chip = gpiochip_find("pinctrl-bcm2835", chip_match_name);
-	if (!chip)
-		return 0;
+	lookup->dev_id = dev_name(&spi->dev);
+	lookup->table[0].key = "pinctrl-bcm2835";
+	lookup->table[0].chip_hwnum = (8 - (spi_get_chipselect(spi, 0)));
+	lookup->table[0].con_id = "cs";
+	lookup->table[0].flags = GPIO_LOOKUP_FLAGS_DEFAULT;
 
-	spi_set_csgpiod(spi, 0, gpiochip_request_own_desc(chip,
-							  8 - (spi_get_chipselect(spi, 0)),
-							  DRV_NAME,
-							  GPIO_LOOKUP_FLAGS_DEFAULT,
-							  GPIOD_OUT_LOW));
-	if (IS_ERR(spi_get_csgpiod(spi, 0))) {
-		ret = PTR_ERR(spi_get_csgpiod(spi, 0));
+	gpiod_add_lookup_table(lookup);
+
+	bs->cs_gpio = gpiod_get(&spi->dev, "cs", GPIOD_OUT_LOW);
+	gpiod_remove_lookup_table(lookup);
+	if (IS_ERR(bs->cs_gpio)) {
+		ret = PTR_ERR(bs->cs_gpio);
 		goto err_cleanup;
 	}
 
+	spi_set_csgpiod(spi, 0, bs->cs_gpio);
+
 	/* and set up the "mode" and level */
 	dev_info(&spi->dev, "setting up native-CS%i to use GPIO\n",
 		 spi_get_chipselect(spi, 0));
-- 
2.39.2

