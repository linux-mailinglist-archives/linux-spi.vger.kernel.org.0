Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD8E6808C2
	for <lists+linux-spi@lfdr.de>; Sun,  4 Aug 2019 02:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbfHDAhp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 3 Aug 2019 20:37:45 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37301 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729420AbfHDAhp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 3 Aug 2019 20:37:45 -0400
Received: by mail-lf1-f68.google.com with SMTP id c9so55352618lfh.4
        for <linux-spi@vger.kernel.org>; Sat, 03 Aug 2019 17:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k4fPec1ZMrof5O8+Iw9iMzlfBvwpOif9EEyaTKz5PQY=;
        b=jlvWoMHrM71WAI/BTTRe4UNM0tJcJwiDVtVJ1MSFfOiUqQ2Zlp8d3XgpfglP90Jg1i
         cp0kN/2gqwjKIrVBSZc0s/ZY2P+1357wy/juwXGeuuGx5p7TYNc0mcZB++4FBBX5QHGT
         1/1ZkYRIYKYkQfyWTTWaDzKX3xXMfBsSmVfkUEn4/f+coA33V1gsKlY5JEcqFvEaaWs8
         MDdugXdg3bjKhyew0Jbkrs0cJjoFb/fLQL+LFnTkQqWh69pCQBuEotSc+reP6MpQFyVh
         vyE5xAzuKzydOizby3ognejNUf6n7zb6ay2joDFI4tZIK6AofdVdIPEtVABtUgY64I+5
         DSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k4fPec1ZMrof5O8+Iw9iMzlfBvwpOif9EEyaTKz5PQY=;
        b=EHZsVp6GWgK+pHpWMIGNAdCrOgZbxW/cR84PRLvY9E62amjsZ9QFlGtwbUhg16V4XS
         3Hd0O28ZlAgxAt8Vw9q3x1II8X7aEQXpVSm4ZXJkurFg9fwxof+UEAzqkGIA2o+gyI9+
         1Wuow4c5kO4NnzmBSaYr/gT+ZgGzDFEOgjRvZHPy5Qw20Siu6VUbRgASr9acDf0gcWY+
         uoO5oXDWZf7BHk+wGXHAiXqbe3pBjUP3suob6wi/BGLnTrmoD8fckVT5PT402e4bAbI6
         YYZm6M2yz5adaIazciFMTqwzg1o2YTzTMZ5c8r1SvSOZ/f2Vfa+je/VmRSlzo2DLfLmW
         ZCag==
X-Gm-Message-State: APjAAAXSAJ62x0Ym4bj7M/wnj5MCmuYqOLGRagQo5pVoqHcEWpOz4d/I
        afBgujQvMfBFP/cHX1EU7YqPiQ==
X-Google-Smtp-Source: APXvYqwlD9WclpD9YpyNplViDl+15+OVMJ5LaUsYrGGRyNeUcFrnGOCHsZrORuaB94uXS2vbFh20Iw==
X-Received: by 2002:a19:4a50:: with SMTP id x77mr23174803lfa.91.1564879062355;
        Sat, 03 Aug 2019 17:37:42 -0700 (PDT)
Received: from localhost.localdomain (c-2ccd225c.014-348-6c756e10.bbcust.telenor.se. [92.34.205.44])
        by smtp.gmail.com with ESMTPSA id e26sm16048603ljl.33.2019.08.03.17.37.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 03 Aug 2019 17:37:41 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Cc:     linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH v2] spi: fsl: Convert to use CS GPIO descriptors
Date:   Sun,  4 Aug 2019 02:35:39 +0200
Message-Id: <20190804003539.985-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This converts the Freescale SPI master driver to use GPIO
descriptors for chip select handling.

The Freescale (fsl) driver has a lot of quirks to look up
"gpios" rather than "cs-gpios" from the device tree.
After the prior patch that will make gpiolib return the
GPIO descriptor for "gpios" in response to a request for
"cs-gpios", this code can be cut down quite a bit.

The driver has custom handling of chip select rather
than using the core (which may be possible but not
done in this patch) so it still needs to refer directly
to spi->cs_gpiod to set the chip select.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rebased on v5.3-rc1
---
 drivers/spi/spi-fsl-lib.h |   3 -
 drivers/spi/spi-fsl-spi.c | 193 +++++---------------------------------
 2 files changed, 25 insertions(+), 171 deletions(-)

diff --git a/drivers/spi/spi-fsl-lib.h b/drivers/spi/spi-fsl-lib.h
index 3576167283dc..015a1abb6a84 100644
--- a/drivers/spi/spi-fsl-lib.h
+++ b/drivers/spi/spi-fsl-lib.h
@@ -91,9 +91,6 @@ static inline u32 mpc8xxx_spi_read_reg(__be32 __iomem *reg)
 
 struct mpc8xxx_spi_probe_info {
 	struct fsl_spi_platform_data pdata;
-	int ngpios;
-	int *gpios;
-	bool *alow_flags;
 	__be32 __iomem *immr_spi_cs;
 };
 
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 1d9b33aa1a3b..4b80ace1d137 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -18,7 +18,7 @@
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/fsl_devices.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
@@ -28,7 +28,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/of_gpio.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
@@ -481,32 +480,6 @@ static int fsl_spi_setup(struct spi_device *spi)
 		return retval;
 	}
 
-	if (mpc8xxx_spi->type == TYPE_GRLIB) {
-		if (gpio_is_valid(spi->cs_gpio)) {
-			int desel;
-
-			retval = gpio_request(spi->cs_gpio,
-					      dev_name(&spi->dev));
-			if (retval)
-				return retval;
-
-			desel = !(spi->mode & SPI_CS_HIGH);
-			retval = gpio_direction_output(spi->cs_gpio, desel);
-			if (retval) {
-				gpio_free(spi->cs_gpio);
-				return retval;
-			}
-		} else if (spi->cs_gpio != -ENOENT) {
-			if (spi->cs_gpio < 0)
-				return spi->cs_gpio;
-			return -EINVAL;
-		}
-		/* When spi->cs_gpio == -ENOENT, a hole in the phandle list
-		 * indicates to use native chipselect if present, or allow for
-		 * an always selected chip
-		 */
-	}
-
 	/* Initialize chipselect - might be active for SPI_CS_HIGH mode */
 	fsl_spi_chipselect(spi, BITBANG_CS_INACTIVE);
 
@@ -515,12 +488,8 @@ static int fsl_spi_setup(struct spi_device *spi)
 
 static void fsl_spi_cleanup(struct spi_device *spi)
 {
-	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
 	struct spi_mpc8xxx_cs *cs = spi_get_ctldata(spi);
 
-	if (mpc8xxx_spi->type == TYPE_GRLIB && gpio_is_valid(spi->cs_gpio))
-		gpio_free(spi->cs_gpio);
-
 	kfree(cs);
 	spi_set_ctldata(spi, NULL);
 }
@@ -586,8 +555,8 @@ static void fsl_spi_grlib_cs_control(struct spi_device *spi, bool on)
 	u32 slvsel;
 	u16 cs = spi->chip_select;
 
-	if (gpio_is_valid(spi->cs_gpio)) {
-		gpio_set_value(spi->cs_gpio, on);
+	if (spi->cs_gpiod) {
+		gpiod_set_value(spi->cs_gpiod, on);
 	} else if (cs < mpc8xxx_spi->native_chipselects) {
 		slvsel = mpc8xxx_spi_read_reg(&reg_base->slvsel);
 		slvsel = on ? (slvsel | (1 << cs)) : (slvsel & ~(1 << cs));
@@ -718,139 +687,19 @@ static struct spi_master * fsl_spi_probe(struct device *dev,
 
 static void fsl_spi_cs_control(struct spi_device *spi, bool on)
 {
-	struct device *dev = spi->dev.parent->parent;
-	struct fsl_spi_platform_data *pdata = dev_get_platdata(dev);
-	struct mpc8xxx_spi_probe_info *pinfo = to_of_pinfo(pdata);
-	u16 cs = spi->chip_select;
-
-	if (cs < pinfo->ngpios) {
-		int gpio = pinfo->gpios[cs];
-		bool alow = pinfo->alow_flags[cs];
-
-		gpio_set_value(gpio, on ^ alow);
+	if (spi->cs_gpiod) {
+		gpiod_set_value(spi->cs_gpiod, on);
 	} else {
-		if (WARN_ON_ONCE(cs > pinfo->ngpios || !pinfo->immr_spi_cs))
+		struct device *dev = spi->dev.parent->parent;
+		struct fsl_spi_platform_data *pdata = dev_get_platdata(dev);
+		struct mpc8xxx_spi_probe_info *pinfo = to_of_pinfo(pdata);
+
+		if (WARN_ON_ONCE(!pinfo->immr_spi_cs))
 			return;
 		iowrite32be(on ? SPI_BOOT_SEL_BIT : 0, pinfo->immr_spi_cs);
 	}
 }
 
-static int of_fsl_spi_get_chipselects(struct device *dev)
-{
-	struct device_node *np = dev->of_node;
-	struct fsl_spi_platform_data *pdata = dev_get_platdata(dev);
-	struct mpc8xxx_spi_probe_info *pinfo = to_of_pinfo(pdata);
-	bool spisel_boot = IS_ENABLED(CONFIG_FSL_SOC) &&
-		of_property_read_bool(np, "fsl,spisel_boot");
-	int ngpios;
-	int i = 0;
-	int ret;
-
-	ngpios = of_gpio_count(np);
-	ngpios = max(ngpios, 0);
-	if (ngpios == 0 && !spisel_boot) {
-		/*
-		 * SPI w/o chip-select line. One SPI device is still permitted
-		 * though.
-		 */
-		pdata->max_chipselect = 1;
-		return 0;
-	}
-
-	pinfo->ngpios = ngpios;
-	pinfo->gpios = kmalloc_array(ngpios, sizeof(*pinfo->gpios),
-				     GFP_KERNEL);
-	if (!pinfo->gpios)
-		return -ENOMEM;
-	memset(pinfo->gpios, -1, ngpios * sizeof(*pinfo->gpios));
-
-	pinfo->alow_flags = kcalloc(ngpios, sizeof(*pinfo->alow_flags),
-				    GFP_KERNEL);
-	if (!pinfo->alow_flags) {
-		ret = -ENOMEM;
-		goto err_alloc_flags;
-	}
-
-	for (; i < ngpios; i++) {
-		int gpio;
-		enum of_gpio_flags flags;
-
-		gpio = of_get_gpio_flags(np, i, &flags);
-		if (!gpio_is_valid(gpio)) {
-			dev_err(dev, "invalid gpio #%d: %d\n", i, gpio);
-			ret = gpio;
-			goto err_loop;
-		}
-
-		ret = gpio_request(gpio, dev_name(dev));
-		if (ret) {
-			dev_err(dev, "can't request gpio #%d: %d\n", i, ret);
-			goto err_loop;
-		}
-
-		pinfo->gpios[i] = gpio;
-		pinfo->alow_flags[i] = flags & OF_GPIO_ACTIVE_LOW;
-
-		ret = gpio_direction_output(pinfo->gpios[i],
-					    pinfo->alow_flags[i]);
-		if (ret) {
-			dev_err(dev,
-				"can't set output direction for gpio #%d: %d\n",
-				i, ret);
-			goto err_loop;
-		}
-	}
-
-#if IS_ENABLED(CONFIG_FSL_SOC)
-	if (spisel_boot) {
-		pinfo->immr_spi_cs = ioremap(get_immrbase() + IMMR_SPI_CS_OFFSET, 4);
-		if (!pinfo->immr_spi_cs) {
-			ret = -ENOMEM;
-			i = ngpios - 1;
-			goto err_loop;
-		}
-	}
-#endif
-
-	pdata->max_chipselect = ngpios + spisel_boot;
-	pdata->cs_control = fsl_spi_cs_control;
-
-	return 0;
-
-err_loop:
-	while (i >= 0) {
-		if (gpio_is_valid(pinfo->gpios[i]))
-			gpio_free(pinfo->gpios[i]);
-		i--;
-	}
-
-	kfree(pinfo->alow_flags);
-	pinfo->alow_flags = NULL;
-err_alloc_flags:
-	kfree(pinfo->gpios);
-	pinfo->gpios = NULL;
-	return ret;
-}
-
-static int of_fsl_spi_free_chipselects(struct device *dev)
-{
-	struct fsl_spi_platform_data *pdata = dev_get_platdata(dev);
-	struct mpc8xxx_spi_probe_info *pinfo = to_of_pinfo(pdata);
-	int i;
-
-	if (!pinfo->gpios)
-		return 0;
-
-	for (i = 0; i < pdata->max_chipselect; i++) {
-		if (gpio_is_valid(pinfo->gpios[i]))
-			gpio_free(pinfo->gpios[i]);
-	}
-
-	kfree(pinfo->gpios);
-	kfree(pinfo->alow_flags);
-	return 0;
-}
-
 static int of_fsl_spi_probe(struct platform_device *ofdev)
 {
 	struct device *dev = &ofdev->dev;
@@ -866,9 +715,21 @@ static int of_fsl_spi_probe(struct platform_device *ofdev)
 
 	type = fsl_spi_get_type(&ofdev->dev);
 	if (type == TYPE_FSL) {
-		ret = of_fsl_spi_get_chipselects(dev);
-		if (ret)
-			goto err;
+		struct fsl_spi_platform_data *pdata = dev_get_platdata(dev);
+#if IS_ENABLED(CONFIG_FSL_SOC)
+		struct mpc8xxx_spi_probe_info *pinfo = to_of_pinfo(pdata);
+		bool spisel_boot = of_property_read_bool(np, "fsl,spisel_boot");
+
+		if (spisel_boot) {
+			pinfo->immr_spi_cs = ioremap(get_immrbase() + IMMR_SPI_CS_OFFSET, 4);
+			if (!pinfo->immr_spi_cs) {
+				ret = -ENOMEM;
+				goto err;
+			}
+		}
+#endif
+
+		pdata->cs_control = fsl_spi_cs_control;
 	}
 
 	ret = of_address_to_resource(np, 0, &mem);
@@ -891,8 +752,6 @@ static int of_fsl_spi_probe(struct platform_device *ofdev)
 
 err:
 	irq_dispose_mapping(irq);
-	if (type == TYPE_FSL)
-		of_fsl_spi_free_chipselects(dev);
 	return ret;
 }
 
@@ -902,8 +761,6 @@ static int of_fsl_spi_remove(struct platform_device *ofdev)
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(master);
 
 	fsl_spi_cpm_free(mpc8xxx_spi);
-	if (mpc8xxx_spi->type == TYPE_FSL)
-		of_fsl_spi_free_chipselects(&ofdev->dev);
 	return 0;
 }
 
-- 
2.21.0

