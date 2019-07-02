Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6AE5D009
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jul 2019 15:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfGBNFC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jul 2019 09:05:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40424 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbfGBNE7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Jul 2019 09:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=38bKnnsp+5AITcDf4hxZ2pCsTbrl84ROyPJJ2wW7PyA=; b=COcR2mRLcBND
        WC+jmOzdVImhYr+jlehSdet8VzLgps3Yz8YYKPRUwMj4t9hoqIhieJaIL9DdNhBkUGWx5AHonP6kM
        Z7CDE6hVKe26/k97473ZCK2+xNGpq4JBChLPzaVi4lZO22P24LYZyFoUFizhtd4/1YW3QoHK28DQf
        N47/0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hiISt-0002Od-3A; Tue, 02 Jul 2019 13:04:55 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 8891D440049; Tue,  2 Jul 2019 14:04:54 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: gpio: Fix handling of CS GPIO for DT systems" to the spi tree
In-Reply-To: <20190701172517.31641-1-linus.walleij@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190702130454.8891D440049@finisterre.sirena.org.uk>
Date:   Tue,  2 Jul 2019 14:04:54 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: gpio: Fix handling of CS GPIO for DT systems

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.2

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

From 83ce8ad482f64159155b605add18eb130b6a03fc Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 1 Jul 2019 19:25:17 +0200
Subject: [PATCH] spi: gpio: Fix handling of CS GPIO for DT systems

This reverts commit 249e2632dcd0509b8f8f296f5aabf4d48dfd6da8.

After this commit drivers/net/dsa/vitesse-vsc73xx.c stopped
working. Apparently CS is not working because the reads
from the device is just returning just 1:s or just 0:s at
all bisection points, so it is a complete regression and
I think spi-gpio CS is essentially broken.  [No other reports?
A bit concerning... --- broonie]

The revert had to be hand-crafted to preserve all the other
cleanup and changes to this driver, but now it works.

I'm sad to revert the change because it is a nice cleanup
but with the short time before v5.2 is released this is
probably the best idea, so we can figure out the right way
to do this in the next kernel cycle.

Fixes: 249e2632dcd0 ("spi: gpio: Don't request CS GPIO in DT use-case")
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-gpio.c | 137 +++++++++++++++++++++++------------------
 1 file changed, 78 insertions(+), 59 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 487ee55d26f7..45f3c196cc60 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -45,6 +45,7 @@ struct spi_gpio {
 	struct gpio_desc		*miso;
 	struct gpio_desc		*mosi;
 	struct gpio_desc		**cs_gpios;
+	bool				has_cs;
 };
 
 /*----------------------------------------------------------------------*/
@@ -214,7 +215,7 @@ static void spi_gpio_chipselect(struct spi_device *spi, int is_active)
 		gpiod_set_value_cansleep(spi_gpio->sck, spi->mode & SPI_CPOL);
 
 	/* Drive chip select line, if we have one */
-	if (spi_gpio->cs_gpios) {
+	if (spi_gpio->has_cs) {
 		struct gpio_desc *cs = spi_gpio->cs_gpios[spi->chip_select];
 
 		/* SPI chip selects are normally active-low */
@@ -232,12 +233,10 @@ static int spi_gpio_setup(struct spi_device *spi)
 	 * The CS GPIOs have already been
 	 * initialized from the descriptor lookup.
 	 */
-	if (spi_gpio->cs_gpios) {
-		cs = spi_gpio->cs_gpios[spi->chip_select];
-		if (!spi->controller_state && cs)
-			status = gpiod_direction_output(cs,
-						  !(spi->mode & SPI_CS_HIGH));
-	}
+	cs = spi_gpio->cs_gpios[spi->chip_select];
+	if (!spi->controller_state && cs)
+		status = gpiod_direction_output(cs,
+						!(spi->mode & SPI_CS_HIGH));
 
 	if (!status)
 		status = spi_bitbang_setup(spi);
@@ -288,8 +287,12 @@ static void spi_gpio_cleanup(struct spi_device *spi)
  * floating signals.  (A weak pulldown would save power too, but many
  * drivers expect to see all-ones data as the no slave "response".)
  */
-static int spi_gpio_request(struct device *dev, struct spi_gpio *spi_gpio)
+static int spi_gpio_request(struct device *dev,
+			    struct spi_gpio *spi_gpio,
+			    unsigned int num_chipselects)
 {
+	int i;
+
 	spi_gpio->mosi = devm_gpiod_get_optional(dev, "mosi", GPIOD_OUT_LOW);
 	if (IS_ERR(spi_gpio->mosi))
 		return PTR_ERR(spi_gpio->mosi);
@@ -302,6 +305,13 @@ static int spi_gpio_request(struct device *dev, struct spi_gpio *spi_gpio)
 	if (IS_ERR(spi_gpio->sck))
 		return PTR_ERR(spi_gpio->sck);
 
+	for (i = 0; i < num_chipselects; i++) {
+		spi_gpio->cs_gpios[i] = devm_gpiod_get_index(dev, "cs",
+							     i, GPIOD_OUT_HIGH);
+		if (IS_ERR(spi_gpio->cs_gpios[i]))
+			return PTR_ERR(spi_gpio->cs_gpios[i]);
+	}
+
 	return 0;
 }
 
@@ -312,55 +322,44 @@ static const struct of_device_id spi_gpio_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, spi_gpio_dt_ids);
 
-static int spi_gpio_probe_dt(struct platform_device *pdev,
-			     struct spi_master *master)
+static int spi_gpio_probe_dt(struct platform_device *pdev)
 {
-	master->dev.of_node = pdev->dev.of_node;
-	master->use_gpio_descriptors = true;
-
-	return 0;
-}
-#else
-static inline int spi_gpio_probe_dt(struct platform_device *pdev,
-				    struct spi_master *master)
-{
-	return 0;
-}
-#endif
-
-static int spi_gpio_probe_pdata(struct platform_device *pdev,
-				struct spi_master *master)
-{
-	struct device *dev = &pdev->dev;
-	struct spi_gpio_platform_data *pdata = dev_get_platdata(dev);
-	struct spi_gpio *spi_gpio = spi_master_get_devdata(master);
-	int i;
+	int ret;
+	u32 tmp;
+	struct spi_gpio_platform_data	*pdata;
+	struct device_node *np = pdev->dev.of_node;
+	const struct of_device_id *of_id =
+			of_match_device(spi_gpio_dt_ids, &pdev->dev);
 
-#ifdef GENERIC_BITBANG
-	if (!pdata || !pdata->num_chipselect)
-		return -ENODEV;
-#endif
-	/*
-	 * The master needs to think there is a chipselect even if not
-	 * connected
-	 */
-	master->num_chipselect = pdata->num_chipselect ?: 1;
+	if (!of_id)
+		return 0;
 
-	spi_gpio->cs_gpios = devm_kcalloc(dev, master->num_chipselect,
-					  sizeof(*spi_gpio->cs_gpios),
-					  GFP_KERNEL);
-	if (!spi_gpio->cs_gpios)
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
 		return -ENOMEM;
 
-	for (i = 0; i < master->num_chipselect; i++) {
-		spi_gpio->cs_gpios[i] = devm_gpiod_get_index(dev, "cs", i,
-							     GPIOD_OUT_HIGH);
-		if (IS_ERR(spi_gpio->cs_gpios[i]))
-			return PTR_ERR(spi_gpio->cs_gpios[i]);
+
+	ret = of_property_read_u32(np, "num-chipselects", &tmp);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "num-chipselects property not found\n");
+		goto error_free;
 	}
 
+	pdata->num_chipselect = tmp;
+	pdev->dev.platform_data = pdata;
+
+	return 1;
+
+error_free:
+	devm_kfree(&pdev->dev, pdata);
+	return ret;
+}
+#else
+static inline int spi_gpio_probe_dt(struct platform_device *pdev)
+{
 	return 0;
 }
+#endif
 
 static void spi_gpio_put(void *data)
 {
@@ -372,11 +371,22 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	int				status;
 	struct spi_master		*master;
 	struct spi_gpio			*spi_gpio;
+	struct spi_gpio_platform_data	*pdata;
 	struct device			*dev = &pdev->dev;
 	struct spi_bitbang		*bb;
-	const struct of_device_id	*of_id;
+	bool use_of = 0;
 
-	of_id = of_match_device(spi_gpio_dt_ids, &pdev->dev);
+	status = spi_gpio_probe_dt(pdev);
+	if (status < 0)
+		return status;
+	if (status > 0)
+		use_of = 1;
+
+	pdata = dev_get_platdata(dev);
+#ifdef GENERIC_BITBANG
+	if (!pdata || (!use_of && !pdata->num_chipselect))
+		return -ENODEV;
+#endif
 
 	master = spi_alloc_master(dev, sizeof(*spi_gpio));
 	if (!master)
@@ -386,17 +396,22 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	if (status)
 		return status;
 
-	if (of_id)
-		status = spi_gpio_probe_dt(pdev, master);
-	else
-		status = spi_gpio_probe_pdata(pdev, master);
+	spi_gpio = spi_master_get_devdata(master);
 
-	if (status)
-		return status;
+	spi_gpio->cs_gpios = devm_kcalloc(dev,
+				pdata->num_chipselect,
+				sizeof(*spi_gpio->cs_gpios),
+				GFP_KERNEL);
+	if (!spi_gpio->cs_gpios)
+		return -ENOMEM;
 
-	spi_gpio = spi_master_get_devdata(master);
+	platform_set_drvdata(pdev, spi_gpio);
+
+	/* Determine if we have chip selects connected */
+	spi_gpio->has_cs = !!pdata->num_chipselect;
 
-	status = spi_gpio_request(dev, spi_gpio);
+	status = spi_gpio_request(dev, spi_gpio,
+				  pdata->num_chipselect);
 	if (status)
 		return status;
 
@@ -414,9 +429,13 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	}
 
 	master->bus_num = pdev->id;
+	/* The master needs to think there is a chipselect even if not connected */
+	master->num_chipselect = spi_gpio->has_cs ? pdata->num_chipselect : 1;
 	master->setup = spi_gpio_setup;
 	master->cleanup = spi_gpio_cleanup;
-
+#ifdef CONFIG_OF
+	master->dev.of_node = dev->of_node;
+#endif
 	bb = &spi_gpio->bitbang;
 	bb->master = master;
 	bb->chipselect = spi_gpio_chipselect;
-- 
2.20.1

