Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 149B7A02C3
	for <lists+linux-spi@lfdr.de>; Wed, 28 Aug 2019 15:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfH1NN0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 28 Aug 2019 09:13:26 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37408 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfH1NN0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 28 Aug 2019 09:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=bLMkbp5ARdiwH2HpZoPUrOzoPdkWcvg1pZjWF08BQ5g=; b=fsR+JrcaywTr
        l6bNx7np4Ad0LMcA3zUsOQCUb0MSzvWBqKPl3bs4HqRXEPES4RFMFvMfqvdrPzZpaWjH7iFg4UdjD
        u8ag32MeY5l94Pta1cp9KEQVr9jY6fPIxIwMyNG04Usan0vZ9ZG0iPXQJ+ETj+zjaNTkKYTPVLgpB
        Wm37E=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i2xlH-0004Hh-A2; Wed, 28 Aug 2019 13:13:19 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id B2BE82742B9F; Wed, 28 Aug 2019 14:13:17 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Fabio Estevam <festevam@gmail.com>, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Applied "spi: fsl: Convert to use CS GPIO descriptors" to the spi tree
In-Reply-To: <20190804003539.985-1-linus.walleij@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190828131317.B2BE82742B9F@ypsilon.sirena.org.uk>
Date:   Wed, 28 Aug 2019 14:13:17 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: fsl: Convert to use CS GPIO descriptors

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

From 0f0581b24bd019dfe32878e4c1bde266c7364e02 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 4 Aug 2019 02:35:39 +0200
Subject: [PATCH] spi: fsl: Convert to use CS GPIO descriptors

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
Link: https://lore.kernel.org/r/20190804003539.985-1-linus.walleij@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1

