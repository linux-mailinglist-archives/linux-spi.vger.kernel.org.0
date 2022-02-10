Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD934B195F
	for <lists+linux-spi@lfdr.de>; Fri, 11 Feb 2022 00:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345616AbiBJXWA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Feb 2022 18:22:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345604AbiBJXWA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Feb 2022 18:22:00 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30005F59
        for <linux-spi@vger.kernel.org>; Thu, 10 Feb 2022 15:21:59 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id bx31so10277622ljb.0
        for <linux-spi@vger.kernel.org>; Thu, 10 Feb 2022 15:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/aIbhnomlEF/FdF0+4AwP7w+SjthzWsOPqa0K5BVtrk=;
        b=kY4CrxcFv2QQk2ZMSgQyrXlZG5slCffl7Px/zXOdORMAX/dP2pCOr80YouCymb8uZd
         gFfyhbFOw8mt+jF84GYuqPOECgnaXTZ2At3ZpQcyz0VfoorOUgZUrPko3QtqzaTTyadS
         jntToj2eY0+uiUdhe8L9qRmHXrmwO/4MaDvMhzAlkQsptpTDRydLruXzodhMHj5kP2hJ
         WsQU98jlf7L5AxOy/4cu7a2sabaPyDBJf8khiguMglem+l/8iwYSFtaUZ82d4XcyHXqE
         6y8SinrAK3R9+fDsct3HpTq4Gemsc595GmsjMlTgf+Fd1dMliGOknvXckQnJ8h1HJVSY
         NMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/aIbhnomlEF/FdF0+4AwP7w+SjthzWsOPqa0K5BVtrk=;
        b=BfHtda/NvGKlpeTMyI+2koyHqpFIlWe4rMBV4zoGiOojYNDlSZkk+Vza7VE8JsUwIa
         s+u2D6rTewdtesAz6ceExBhdy87aU3tnVWjAxWfdxBRPEokqwoZNyYplRvtscqCHE7FV
         /zzhNzwDPHJWJKNNpWkErfIDqgekCySh6PTCEsrJY2EcItaSFuqNM9vNHYmGUGMPoJ1W
         8Nzc3PPTNYklx4UB7gZ6NVKY5kpJjLOm8AiNp99Y1VDBVTorkIMkdA8s57vH1TEcbj43
         1oy82odiinLGiodRmKbqmOF5sdV2lShhwmLbBnueJKD0culBNSgfKeaI9K4F5y2aS0Jg
         Dxrw==
X-Gm-Message-State: AOAM532gtSSSRXTSjqrKnpusx14TiuRFaZTPtx7rvXcXYtLlgP/s4NHE
        5VviRLMiGlhxWM+0IxatnwQTrKLSZma66x9G
X-Google-Smtp-Source: ABdhPJzWFfXbM2Xv5DPIhyNQNqiUEyiDLVMk/aRPOi2JA0U+gVpOQAQUuxO+ObBndNEFIttWIkDjcA==
X-Received: by 2002:a2e:9b5a:: with SMTP id o26mr6658084ljj.186.1644535318228;
        Thu, 10 Feb 2022 15:21:58 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id bq1sm1473186lfb.58.2022.02.10.15.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 15:21:57 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] spi: Retire legacy GPIO handling
Date:   Fri, 11 Feb 2022 00:19:54 +0100
Message-Id: <20220210231954.807904-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

All drivers using GPIOs as chip select have been rewritten to use
GPIO descriptors passing the ->use_gpio_descriptors flag. Retire
the code and fields used by the legacy GPIO API.

Do not drop the ->use_gpio_descriptors flag: it now only indicates
that we want to use GPIOs in addition to native chip selects.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
As far as I can tell all prerequisite patches are in
the SPI tree, the patch is a bit invasive so look
close at it. It builds fine in my tests.
---
 drivers/spi/spi.c       | 125 +++++++++-------------------------------
 include/linux/spi/spi.h |  14 +----
 2 files changed, 30 insertions(+), 109 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 4599b121d744..9afb159d6053 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -18,7 +18,6 @@
 #include <linux/mod_devicetable.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
-#include <linux/of_gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_domain.h>
@@ -549,7 +548,6 @@ static struct spi_device *spi_alloc_device(struct spi_controller *ctlr)
 	spi->dev.parent = &ctlr->dev;
 	spi->dev.bus = &spi_bus_type;
 	spi->dev.release = spidev_release;
-	spi->cs_gpio = -ENOENT;
 	spi->mode = ctlr->buswidth_override_bits;
 
 	spin_lock_init(&spi->statistics.lock);
@@ -612,11 +610,8 @@ static int __spi_add_device(struct spi_device *spi)
 		return -ENODEV;
 	}
 
-	/* Descriptors take precedence */
 	if (ctlr->cs_gpiods)
 		spi->cs_gpiod = ctlr->cs_gpiods[spi->chip_select];
-	else if (ctlr->cs_gpios)
-		spi->cs_gpio = ctlr->cs_gpios[spi->chip_select];
 
 	/*
 	 * Drivers may modify this initial i/o setup, but will
@@ -945,39 +940,30 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 	spi->controller->last_cs_enable = enable;
 	spi->controller->last_cs_mode_high = spi->mode & SPI_CS_HIGH;
 
-	if ((spi->cs_gpiod || gpio_is_valid(spi->cs_gpio) ||
-	    !spi->controller->set_cs_timing) && !activate) {
+	if ((spi->cs_gpiod || !spi->controller->set_cs_timing) && !activate) {
 		spi_delay_exec(&spi->cs_hold, NULL);
 	}
 
 	if (spi->mode & SPI_CS_HIGH)
 		enable = !enable;
 
-	if (spi->cs_gpiod || gpio_is_valid(spi->cs_gpio)) {
+	if (spi->cs_gpiod) {
 		if (!(spi->mode & SPI_NO_CS)) {
-			if (spi->cs_gpiod) {
-				/*
-				 * Historically ACPI has no means of the GPIO polarity and
-				 * thus the SPISerialBus() resource defines it on the per-chip
-				 * basis. In order to avoid a chain of negations, the GPIO
-				 * polarity is considered being Active High. Even for the cases
-				 * when _DSD() is involved (in the updated versions of ACPI)
-				 * the GPIO CS polarity must be defined Active High to avoid
-				 * ambiguity. That's why we use enable, that takes SPI_CS_HIGH
-				 * into account.
-				 */
-				if (has_acpi_companion(&spi->dev))
-					gpiod_set_value_cansleep(spi->cs_gpiod, !enable);
-				else
-					/* Polarity handled by GPIO library */
-					gpiod_set_value_cansleep(spi->cs_gpiod, activate);
-			} else {
-				/*
-				 * Invert the enable line, as active low is
-				 * default for SPI.
-				 */
-				gpio_set_value_cansleep(spi->cs_gpio, !enable);
-			}
+			/*
+			 * Historically ACPI has no means of the GPIO polarity and
+			 * thus the SPISerialBus() resource defines it on the per-chip
+			 * basis. In order to avoid a chain of negations, the GPIO
+			 * polarity is considered being Active High. Even for the cases
+			 * when _DSD() is involved (in the updated versions of ACPI)
+			 * the GPIO CS polarity must be defined Active High to avoid
+			 * ambiguity. That's why we use enable, that takes SPI_CS_HIGH
+			 * into account.
+			 */
+			if (has_acpi_companion(&spi->dev))
+				gpiod_set_value_cansleep(spi->cs_gpiod, !enable);
+			else
+				/* Polarity handled by GPIO library */
+				gpiod_set_value_cansleep(spi->cs_gpiod, activate);
 		}
 		/* Some SPI masters need both GPIO CS & slave_select */
 		if ((spi->controller->flags & SPI_MASTER_GPIO_SS) &&
@@ -987,8 +973,7 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 		spi->controller->set_cs(spi, !enable);
 	}
 
-	if (spi->cs_gpiod || gpio_is_valid(spi->cs_gpio) ||
-	    !spi->controller->set_cs_timing) {
+	if (spi->cs_gpiod || !spi->controller->set_cs_timing) {
 		if (activate)
 			spi_delay_exec(&spi->cs_setup, NULL);
 		else
@@ -2729,46 +2714,6 @@ struct spi_controller *__devm_spi_alloc_controller(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(__devm_spi_alloc_controller);
 
-#ifdef CONFIG_OF
-static int of_spi_get_gpio_numbers(struct spi_controller *ctlr)
-{
-	int nb, i, *cs;
-	struct device_node *np = ctlr->dev.of_node;
-
-	if (!np)
-		return 0;
-
-	nb = of_gpio_named_count(np, "cs-gpios");
-	ctlr->num_chipselect = max_t(int, nb, ctlr->num_chipselect);
-
-	/* Return error only for an incorrectly formed cs-gpios property */
-	if (nb == 0 || nb == -ENOENT)
-		return 0;
-	else if (nb < 0)
-		return nb;
-
-	cs = devm_kcalloc(&ctlr->dev, ctlr->num_chipselect, sizeof(int),
-			  GFP_KERNEL);
-	ctlr->cs_gpios = cs;
-
-	if (!ctlr->cs_gpios)
-		return -ENOMEM;
-
-	for (i = 0; i < ctlr->num_chipselect; i++)
-		cs[i] = -ENOENT;
-
-	for (i = 0; i < nb; i++)
-		cs[i] = of_get_named_gpio(np, "cs-gpios", i);
-
-	return 0;
-}
-#else
-static int of_spi_get_gpio_numbers(struct spi_controller *ctlr)
-{
-	return 0;
-}
-#endif
-
 /**
  * spi_get_gpio_descs() - grab chip select GPIOs for the master
  * @ctlr: The SPI master to grab GPIO descriptors for
@@ -2953,22 +2898,15 @@ int spi_register_controller(struct spi_controller *ctlr)
 	 */
 	dev_set_name(&ctlr->dev, "spi%u", ctlr->bus_num);
 
-	if (!spi_controller_is_slave(ctlr)) {
-		if (ctlr->use_gpio_descriptors) {
-			status = spi_get_gpio_descs(ctlr);
-			if (status)
-				goto free_bus_id;
-			/*
-			 * A controller using GPIO descriptors always
-			 * supports SPI_CS_HIGH if need be.
-			 */
-			ctlr->mode_bits |= SPI_CS_HIGH;
-		} else {
-			/* Legacy code path for GPIOs from DT */
-			status = of_spi_get_gpio_numbers(ctlr);
-			if (status)
-				goto free_bus_id;
-		}
+	if (!spi_controller_is_slave(ctlr) && ctlr->use_gpio_descriptors) {
+		status = spi_get_gpio_descs(ctlr);
+		if (status)
+			goto free_bus_id;
+		/*
+		 * A controller using GPIO descriptors always
+		 * supports SPI_CS_HIGH if need be.
+		 */
+		ctlr->mode_bits |= SPI_CS_HIGH;
 	}
 
 	/*
@@ -3457,12 +3395,6 @@ int spi_setup(struct spi_device *spi)
 	 */
 	bad_bits = spi->mode & ~(spi->controller->mode_bits | SPI_CS_WORD |
 				 SPI_NO_TX | SPI_NO_RX);
-	/*
-	 * Nothing prevents from working with active-high CS in case if it
-	 * is driven by GPIO.
-	 */
-	if (gpio_is_valid(spi->cs_gpio))
-		bad_bits &= ~SPI_CS_HIGH;
 	ugly_bits = bad_bits &
 		    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL |
 		     SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL);
@@ -3588,8 +3520,7 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 	 * cs_change is set for each transfer.
 	 */
 	if ((spi->mode & SPI_CS_WORD) && (!(ctlr->mode_bits & SPI_CS_WORD) ||
-					  spi->cs_gpiod ||
-					  gpio_is_valid(spi->cs_gpio))) {
+					  spi->cs_gpiod)) {
 		size_t maxsize;
 		int ret;
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 7ab3fed7b804..04b09b98d9a8 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -136,9 +136,6 @@ extern int spi_delay_exec(struct spi_delay *_delay, struct spi_transfer *xfer);
  *	for driver coldplugging, and in uevents used for hotplugging
  * @driver_override: If the name of a driver is written to this attribute, then
  *	the device will bind to the named driver and only the named driver.
- * @cs_gpio: LEGACY: gpio number of the chipselect line (optional, -ENOENT when
- *	not using a GPIO line) use cs_gpiod in new drivers by opting in on
- *	the spi_master.
  * @cs_gpiod: gpio descriptor of the chipselect line (optional, NULL when
  *	not using a GPIO line)
  * @word_delay: delay to be inserted between consecutive
@@ -185,7 +182,6 @@ struct spi_device {
 	void			*controller_data;
 	char			modalias[SPI_NAME_SIZE];
 	const char		*driver_override;
-	int			cs_gpio;	/* LEGACY: chip select gpio */
 	struct gpio_desc	*cs_gpiod;	/* chip select gpio desc */
 	struct spi_delay	word_delay; /* inter-word delay */
 	/* CS delays */
@@ -417,17 +413,12 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  *	     controller has native support for memory like operations.
  * @unprepare_message: undo any work done by prepare_message().
  * @slave_abort: abort the ongoing transfer request on an SPI slave controller
- * @cs_gpios: LEGACY: array of GPIO descs to use as chip select lines; one per
- *	CS number. Any individual value may be -ENOENT for CS lines that
- *	are not GPIOs (driven by the SPI controller itself). Use the cs_gpiods
- *	in new drivers.
  * @cs_gpiods: Array of GPIO descs to use as chip select lines; one per CS
  *	number. Any individual value may be NULL for CS lines that
  *	are not GPIOs (driven by the SPI controller itself).
  * @use_gpio_descriptors: Turns on the code in the SPI core to parse and grab
- *	GPIO descriptors rather than using global GPIO numbers grabbed by the
- *	driver. This will fill in @cs_gpiods and @cs_gpios should not be used,
- *	and SPI devices will have the cs_gpiod assigned rather than cs_gpio.
+ *	GPIO descriptors. This will fill in @cs_gpiods and SPI devices will have
+ *	the cs_gpiod assigned if a GPIO line is found for the chipselect.
  * @unused_native_cs: When cs_gpiods is used, spi_register_controller() will
  *	fill in this field with the first unused native CS, to be used by SPI
  *	controller drivers that need to drive a native CS when using GPIO CS.
@@ -641,7 +632,6 @@ struct spi_controller {
 	const struct spi_controller_mem_ops *mem_ops;
 
 	/* gpio chip select */
-	int			*cs_gpios;
 	struct gpio_desc	**cs_gpiods;
 	bool			use_gpio_descriptors;
 	s8			unused_native_cs;
-- 
2.34.1

