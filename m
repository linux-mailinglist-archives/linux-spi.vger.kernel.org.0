Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB31B5C1EF
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2019 19:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbfGARZq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Jul 2019 13:25:46 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46189 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbfGARZq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 1 Jul 2019 13:25:46 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so14025722ljg.13
        for <linux-spi@vger.kernel.org>; Mon, 01 Jul 2019 10:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YwvMPY077x2xjVlR4TXWeWzMKnsAAJ9OWSd/bo+8wa8=;
        b=s8U8YdZhxJjumvqJY/qvVyVvJv2HoAsl0bQnmR/fdzOKd7nHYJ56I0JuIaaS3Tit63
         6F4vSnMfnZmSHFmk/widuJextgcJtS84TvMnfwgM+Bx+V5fcTq36zufy9w5l373P/7Bv
         578v3xipOKSjSYy9rP1ojlplmq5EnJE4ST4scy7sKeFbjwlGsI3xltE439F3qRSRSDXP
         U0PuwtCU2z6VhDpPkNUYjGLydbbe4CgkdJWof44ISaxc9bMdInsC9UovOqt2x1wESAFt
         VtFuYXextOpr8ENSrVffPY/U4Sh43ib4J40AI2D/wosFbAOKC7lFaEOZp28H864njF+K
         0Y6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YwvMPY077x2xjVlR4TXWeWzMKnsAAJ9OWSd/bo+8wa8=;
        b=sybEHY/L7ACrOprgTTb27LLCass6+/FJ7SVEkBzcpt/Cs386szNl0iLEoQ7n0fztrB
         x/8LnAHyCkoYX5M6FEobPUJ/G5LLpEm8tcfLGotHuGciGICYSad7Z+hX8BHqKgj76vuQ
         P99zi0zGkJqjA36JMXO+sUYKzEdERHtHBDBuD9izN0rQiHLK4OFwsyh+UGqwS6HLS9x8
         vYZzEtbxCG1yrF0qWo+NBPXInrPPoPEw4bkMJOjdOyXOyVK2Y0l7d0IFCBVrCqMV3YWg
         6NQ/gQEBxpCk17uu/H9m/NZhbfSxbhS4wDAxCVLjUAnEz1d2c+zNJCBrv6Iz5DQOl2TK
         sO8A==
X-Gm-Message-State: APjAAAWGn6KYl3Uo3UG5qG5gPMqylY2XKJgwqIYrR/+X134Wvb3BeOlW
        shlnnctR9BLjGRhjCevICCDyrQ==
X-Google-Smtp-Source: APXvYqwzXMou0PbEq2okkk6P5LSDp6FHGS9eBbw1VyOe8SgwYD8PDRU6itDDBCaw1bpcxzTrkVfJoQ==
X-Received: by 2002:a2e:7604:: with SMTP id r4mr14756942ljc.225.1562001943406;
        Mon, 01 Jul 2019 10:25:43 -0700 (PDT)
Received: from localhost.bredbandsbolaget (c-22cd225c.014-348-6c756e10.bbcust.telenor.se. [92.34.205.34])
        by smtp.gmail.com with ESMTPSA id w15sm3740386ljh.0.2019.07.01.10.25.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 10:25:41 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH] Revert "spi: gpio: Don't request CS GPIO in DT use-case"
Date:   Mon,  1 Jul 2019 19:25:17 +0200
Message-Id: <20190701172517.31641-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This reverts commit 249e2632dcd0509b8f8f296f5aabf4d48dfd6da8.

After this commit drivers/net/dsa/vitesse-vsc73xx.c stopped
working. Apparently CS is not working because the reads
from the device is just returning just 1:s or just 0:s at
all bisection points, so it is a complete regression and
I think spi-gpio CS is essentially broken.

The revert had to be hand-crafted to preserve all the other
cleanup and changes to this driver, but now it works.

I'm sad to revert the change because it is a nice cleanup
but with the short time before v5.2 is released this is
probably the best idea, so we can figure out the right way
to do this in the next kernel cycle.

Fixes: 249e2632dcd0 ("spi: gpio: Don't request CS GPIO in DT use-case")
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-gpio.c | 137 +++++++++++++++++++++++------------------
 1 file changed, 78 insertions(+), 59 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index eca9d52ecf65..7cf800efef93 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -36,6 +36,7 @@ struct spi_gpio {
 	struct gpio_desc		*miso;
 	struct gpio_desc		*mosi;
 	struct gpio_desc		**cs_gpios;
+	bool				has_cs;
 };
 
 /*----------------------------------------------------------------------*/
@@ -205,7 +206,7 @@ static void spi_gpio_chipselect(struct spi_device *spi, int is_active)
 		gpiod_set_value_cansleep(spi_gpio->sck, spi->mode & SPI_CPOL);
 
 	/* Drive chip select line, if we have one */
-	if (spi_gpio->cs_gpios) {
+	if (spi_gpio->has_cs) {
 		struct gpio_desc *cs = spi_gpio->cs_gpios[spi->chip_select];
 
 		/* SPI chip selects are normally active-low */
@@ -223,12 +224,10 @@ static int spi_gpio_setup(struct spi_device *spi)
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
@@ -279,8 +278,12 @@ static void spi_gpio_cleanup(struct spi_device *spi)
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
@@ -293,6 +296,13 @@ static int spi_gpio_request(struct device *dev, struct spi_gpio *spi_gpio)
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
 
@@ -303,55 +313,44 @@ static const struct of_device_id spi_gpio_dt_ids[] = {
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
@@ -363,11 +362,22 @@ static int spi_gpio_probe(struct platform_device *pdev)
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
@@ -377,17 +387,22 @@ static int spi_gpio_probe(struct platform_device *pdev)
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
 
@@ -405,9 +420,13 @@ static int spi_gpio_probe(struct platform_device *pdev)
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
2.21.0

