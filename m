Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECB8D187D67
	for <lists+linux-spi@lfdr.de>; Tue, 17 Mar 2020 10:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbgCQJtV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Mar 2020 05:49:21 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36571 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgCQJtV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Mar 2020 05:49:21 -0400
Received: by mail-lf1-f67.google.com with SMTP id s1so16588386lfd.3
        for <linux-spi@vger.kernel.org>; Tue, 17 Mar 2020 02:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9wHbA9HIp23+mD+yWGT8H34SQ9iLNArpwfIOkFM8rkg=;
        b=FkQjyrOkmDzrU5MvSPu4zl/terdGVDY/kFz23X1UyFvn+GPo3rWMivZLmtKy2YvgMK
         6I9hUx+miHlhRus45FbnkdST3r674Njqpr2Y7xaljTS58c11v5obmU9BK6wbSSvDAfcJ
         TgBau8cw87C48gOLWe+cDY9bAOL4MWFlrebBhN4PIfww+GchhdDpolCN4zxVTjXEXtec
         HL+PqPfpNMpKNBFqR2FBAxaR3q6UVnH0SOOfQAyDkjqc3CsPtRIi7ZfP3nudA6EiB1QV
         ENqe0wpVGOCR36UQELKmyTx1hM/1tkWPt1HkbFws+6p3bwAfIOU90nYKQ6FR0zC8uFFJ
         tnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9wHbA9HIp23+mD+yWGT8H34SQ9iLNArpwfIOkFM8rkg=;
        b=RhOSV0+E0SkAg+PrIOyIUgRbepnYKSC1DpnwaXD0qU/Rsc6qQl57gw0WLB9hBF89uB
         pn33brmCNSyGsGWfp5Wg7Y0T2Tmo5N0n/F5dER7zeKPARWk/vH0CV5n1DhhQGazfhYeq
         ZvocoldJa9Ew1Fd3Rs8b4XQVC9HIBQHlK7RGMNUxJM+E8U/KY6elxgpE64jr7mEbZFFC
         Sij269ueKILwmcBgEJVvhyi4BtRwku/rcLXXjqgNJojkxvinWWE7Vg0JCljIF3wQf8RA
         udcAz24KDtvv0a6HTKSQKQ5dDCQCuV8lTKiK32Fc7VG2jC0ryiwPk6DfRrNwqu/7GeQP
         52Hw==
X-Gm-Message-State: ANhLgQ2Zy0lLfhS12y6mJfe0pth68wzVK1MACj0emJwT+dXL0QiZk23V
        RgRg8pyalqyApunZO1XjxJlcdIxMUXs8rA==
X-Google-Smtp-Source: ADFU+vv7/+2rsC25rhoyf2B2+lGM7Pc+K0SPXYqISQKCyhha8LgUorwh4USwHks0n2NF6qSSDO9ukw==
X-Received: by 2002:a05:6512:3e9:: with SMTP id n9mr1145475lfq.25.1584438556917;
        Tue, 17 Mar 2020 02:49:16 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id z17sm1939043ljm.19.2020.03.17.02.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 02:49:16 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] spi: efm32: Convert to use GPIO descriptors
Date:   Tue, 17 Mar 2020 10:49:14 +0100
Message-Id: <20200317094914.331932-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This switches the EFM32 driver over to use the GPIO descriptor
handling in the core. The GPIO handling in this driver is
pretty simplistic so this should just work. Drop the GPIO headers
and insert the implicitly included <linux/of.h> header.

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-efm32.c | 44 +++--------------------------------------
 1 file changed, 3 insertions(+), 41 deletions(-)

diff --git a/drivers/spi/spi-efm32.c b/drivers/spi/spi-efm32.c
index 64d4c441b641..ea6e4a7b3feb 100644
--- a/drivers/spi/spi-efm32.c
+++ b/drivers/spi/spi-efm32.c
@@ -6,14 +6,13 @@
 #include <linux/io.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
-#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/module.h>
-#include <linux/of_gpio.h>
 #include <linux/platform_data/efm32-spi.h>
+#include <linux/of.h>
 
 #define DRIVER_NAME "efm32-spi"
 
@@ -82,9 +81,6 @@ struct efm32_spi_ddata {
 	const u8 *tx_buf;
 	u8 *rx_buf;
 	unsigned tx_len, rx_len;
-
-	/* chip selects */
-	unsigned csgpio[];
 };
 
 #define ddata_to_dev(ddata)	(&(ddata->bitbang.master->dev))
@@ -102,14 +98,6 @@ static u32 efm32_spi_read32(struct efm32_spi_ddata *ddata, unsigned offset)
 	return readl_relaxed(ddata->base + offset);
 }
 
-static void efm32_spi_chipselect(struct spi_device *spi, int is_on)
-{
-	struct efm32_spi_ddata *ddata = spi_master_get_devdata(spi->master);
-	int value = !(spi->mode & SPI_CS_HIGH) == !(is_on == BITBANG_CS_ACTIVE);
-
-	gpio_set_value(ddata->csgpio[spi->chip_select], value);
-}
-
 static int efm32_spi_setup_transfer(struct spi_device *spi,
 		struct spi_transfer *t)
 {
@@ -320,17 +308,11 @@ static int efm32_spi_probe(struct platform_device *pdev)
 	int ret;
 	struct spi_master *master;
 	struct device_node *np = pdev->dev.of_node;
-	int num_cs, i;
 
 	if (!np)
 		return -EINVAL;
 
-	num_cs = of_gpio_named_count(np, "cs-gpios");
-	if (num_cs < 0)
-		return num_cs;
-
-	master = spi_alloc_master(&pdev->dev,
-			sizeof(*ddata) + num_cs * sizeof(unsigned));
+	master = spi_alloc_master(&pdev->dev, sizeof(*ddata));
 	if (!master) {
 		dev_dbg(&pdev->dev,
 				"failed to allocate spi master controller\n");
@@ -340,14 +322,13 @@ static int efm32_spi_probe(struct platform_device *pdev)
 
 	master->dev.of_node = pdev->dev.of_node;
 
-	master->num_chipselect = num_cs;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16);
+	master->use_gpio_descriptors = true;
 
 	ddata = spi_master_get_devdata(master);
 
 	ddata->bitbang.master = master;
-	ddata->bitbang.chipselect = efm32_spi_chipselect;
 	ddata->bitbang.setup_transfer = efm32_spi_setup_transfer;
 	ddata->bitbang.txrx_bufs = efm32_spi_txrx_bufs;
 
@@ -361,25 +342,6 @@ static int efm32_spi_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	for (i = 0; i < num_cs; ++i) {
-		ret = of_get_named_gpio(np, "cs-gpios", i);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "failed to get csgpio#%u (%d)\n",
-					i, ret);
-			goto err;
-		}
-		ddata->csgpio[i] = ret;
-		dev_dbg(&pdev->dev, "csgpio#%u = %u\n", i, ddata->csgpio[i]);
-		ret = devm_gpio_request_one(&pdev->dev, ddata->csgpio[i],
-				GPIOF_OUT_INIT_LOW, DRIVER_NAME);
-		if (ret < 0) {
-			dev_err(&pdev->dev,
-					"failed to configure csgpio#%u (%d)\n",
-					i, ret);
-			goto err;
-		}
-	}
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		ret = -ENODEV;
-- 
2.24.1

