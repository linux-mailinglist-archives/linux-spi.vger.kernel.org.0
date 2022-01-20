Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF8349449F
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jan 2022 01:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345560AbiATA2I (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Jan 2022 19:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344860AbiATA2I (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Jan 2022 19:28:08 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C26CC061574
        for <linux-spi@vger.kernel.org>; Wed, 19 Jan 2022 16:28:07 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id m3so15276555lfu.0
        for <linux-spi@vger.kernel.org>; Wed, 19 Jan 2022 16:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tVzKwuqBVpquvDZTm7oLOf52IZ804sPtU0S2L3eALEE=;
        b=etjOl2MHCbdqC1BAWyaDanrMnlTeQXnGfj7yYuPH+tiOukIF60NAHBdQB6OM5Sd+Of
         2bNwRmjUhCKrNCO0Iq9Coi30RruRLWbNMKVFBjjHTY8fkJO0nCX8eUhZlOmgkZsgm6aN
         YPRYKjbxkgFeX7VZqgDQM5oGs/TbFRt7OntXv6y6f5xdCSYumuYYD1j7VIPY0EKvZOoo
         Ylkllt2+EibTXx7vDnZJgmC+To46+S5yiGD9ItauHFtGdyBTe6cTMjdA9evhRiqQ7B4A
         Owooph2ALPgK5N13UuOW2v/3Uv8tv1go7NA99IEE1+C5fDIbRur2q90GFrUvt1FOQt2J
         /SCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tVzKwuqBVpquvDZTm7oLOf52IZ804sPtU0S2L3eALEE=;
        b=JaB94W7YsQ5PVg12tW0UzCS5uQbrxv/+rSjrrTgBtoUF6lDILnBz2/uc9F3iWSev/4
         g/Ha2L2jQ4Bo8blqYrVXgAc3vCKUbF3KcFQ5yZdr2F5zvQI0g2zAFRM0MddEM3mmgQEx
         phjPpxZeC9WNvhd0jDSfe0e8EeBfxmqZEJgOGeauucCm6tcmeHgHCIHB/2s6D+EF8cUx
         WSzs7MLHu8oH78UJt7svgbijpmqJMg+3pOlIsid3pfvM8uVxH5W0Vfvmzbo668GSScMo
         T3uVGBBniIukhgg8Jzd3KiYOFr2xcBUvfdqKnseprm7yYIrp25EmsGDotttW/JKb1e7M
         MRbQ==
X-Gm-Message-State: AOAM531qQ7ibPE90vkbFs6ckeFXTWDU6cbZGzx3zN01mAv76MHlXmMnz
        7kBoMSXNW0s1ts9cWNsZVWUA2Q==
X-Google-Smtp-Source: ABdhPJx9UWUrsd1T4YFK31jeFGRUF2l+IoRJ6FCxNfgn3/oDB4KbJFS76YqvnC7ro7kux/8Sk8ruew==
X-Received: by 2002:a05:6512:3d9e:: with SMTP id k30mr29336643lfv.342.1642638485852;
        Wed, 19 Jan 2022 16:28:05 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id t17sm109656lja.132.2022.01.19.16.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 16:28:04 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Anatolij Gustschin <agust@denx.de>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] spi: mpc512x-psc: Convert to use GPIO descriptors
Date:   Thu, 20 Jan 2022 01:26:00 +0100
Message-Id: <20220120002600.216667-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This driver is already relying on the core to provide
valid GPIO numbers in spi->cs_gpio through
of_spi_get_gpio_numbers(), so we can switch to letting
the core use GPIO descriptors instead.

The driver was assigning a local function to the custom
chipselect callback, but I chose to just open code the
gpiod setting instead, this is easier to read.

The only platform that overrides the cs_control callback
is the mpc832x_rdb.

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Anatolij Gustschin <agust@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Stop trying to use the core per-transfer CS handling,
  keep the old code intact around this and just deal with
  the GPIO descriptors.

I can't really compile any PPC code, I just hope I coded
this right...
---
 drivers/spi/spi-mpc512x-psc.c | 46 ++++++++++++++---------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 78a9bca8cc68..8a488d8e4c1b 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -23,7 +23,6 @@
 #include <linux/clk.h>
 #include <linux/spi/spi.h>
 #include <linux/fsl_devices.h>
-#include <linux/gpio.h>
 #include <asm/mpc52xx_psc.h>
 
 enum {
@@ -128,17 +127,28 @@ static void mpc512x_psc_spi_activate_cs(struct spi_device *spi)
 	out_be32(psc_addr(mps, ccr), ccr);
 	mps->bits_per_word = cs->bits_per_word;
 
-	if (mps->cs_control && gpio_is_valid(spi->cs_gpio))
-		mps->cs_control(spi, (spi->mode & SPI_CS_HIGH) ? 1 : 0);
+	if (cs->gpiod) {
+		if (mps->cs_control)
+			/* boardfile override */
+			mps->cs_control(spi, (spi->mode & SPI_CS_HIGH) ? 1 : 0);
+		else
+			/* gpiolib will deal with the inversion */
+			gpiod_set_value(spi->cs_gpiod, 1);
+	}
 }
 
 static void mpc512x_psc_spi_deactivate_cs(struct spi_device *spi)
 {
 	struct mpc512x_psc_spi *mps = spi_master_get_devdata(spi->master);
 
-	if (mps->cs_control && gpio_is_valid(spi->cs_gpio))
-		mps->cs_control(spi, (spi->mode & SPI_CS_HIGH) ? 0 : 1);
-
+	if (spi->cs_gpiod) {
+		if (mps->cs_control)
+			/* boardfile override */
+			mps->cs_control(spi, (spi->mode & SPI_CS_HIGH) ? 0 : 1);
+		else
+			/* gpiolib will deal with the inversion */
+			gpiod_set_value(spi->cs_gpiod, 0);
+	}
 }
 
 /* extract and scale size field in txsz or rxsz */
@@ -373,18 +383,6 @@ static int mpc512x_psc_spi_setup(struct spi_device *spi)
 		if (!cs)
 			return -ENOMEM;
 
-		if (gpio_is_valid(spi->cs_gpio)) {
-			ret = gpio_request(spi->cs_gpio, dev_name(&spi->dev));
-			if (ret) {
-				dev_err(&spi->dev, "can't get CS gpio: %d\n",
-					ret);
-				kfree(cs);
-				return ret;
-			}
-			gpio_direction_output(spi->cs_gpio,
-					spi->mode & SPI_CS_HIGH ? 0 : 1);
-		}
-
 		spi->controller_state = cs;
 	}
 
@@ -396,8 +394,6 @@ static int mpc512x_psc_spi_setup(struct spi_device *spi)
 
 static void mpc512x_psc_spi_cleanup(struct spi_device *spi)
 {
-	if (gpio_is_valid(spi->cs_gpio))
-		gpio_free(spi->cs_gpio);
 	kfree(spi->controller_state);
 }
 
@@ -476,11 +472,6 @@ static irqreturn_t mpc512x_psc_spi_isr(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-static void mpc512x_spi_cs_control(struct spi_device *spi, bool onoff)
-{
-	gpio_set_value(spi->cs_gpio, onoff);
-}
-
 static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 					      u32 size, unsigned int irq)
 {
@@ -500,9 +491,7 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	mps->type = (int)of_device_get_match_data(dev);
 	mps->irq = irq;
 
-	if (pdata == NULL) {
-		mps->cs_control = mpc512x_spi_cs_control;
-	} else {
+	if (pdata) {
 		mps->cs_control = pdata->cs_control;
 		master->bus_num = pdata->bus_num;
 		master->num_chipselect = pdata->max_chipselect;
@@ -513,6 +502,7 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	master->prepare_transfer_hardware = mpc512x_psc_spi_prep_xfer_hw;
 	master->transfer_one_message = mpc512x_psc_spi_msg_xfer;
 	master->unprepare_transfer_hardware = mpc512x_psc_spi_unprep_xfer_hw;
+	master->use_gpio_descriptors = true;
 	master->cleanup = mpc512x_psc_spi_cleanup;
 	master->dev.of_node = dev->of_node;
 
-- 
2.34.1

