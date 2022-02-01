Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DAB4A54A6
	for <lists+linux-spi@lfdr.de>; Tue,  1 Feb 2022 02:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiBAB3A (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 Jan 2022 20:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiBAB27 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 Jan 2022 20:28:59 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F9CC061714
        for <linux-spi@vger.kernel.org>; Mon, 31 Jan 2022 17:28:59 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id bu18so30595529lfb.5
        for <linux-spi@vger.kernel.org>; Mon, 31 Jan 2022 17:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mgjC0puvphJrK1+sZ7kmtCaIi+v4//DuYs9Wlhj5+x4=;
        b=mZzld/x0t4VMUvL+b86yIHMdjR2+pZcNI5ug+4D7FjM8uUiR4C+jO4brspVcs974a5
         0StUsBjxERaUkRHFqRGIJMeuMEHoUNU18OwR8imKfDwHPuWrkAri8x5NoJs/8oInzDkT
         l0SDWQlCi4ITOhRbhG3tW8g1FkIv8jyRgAAtUkX3mou/4xXMXzoToUEmDalO5QWp/8lg
         IhGcBNqKHInXYPpKUp/VGONu+dr2bHGHxjKiu0Nqv1Fm/qi94D3CQNcIIzxLAMDK7OQE
         RaEU8fcrnwCWBaN5zxBqyFLXw6MIosvZC3clGuuRc9RnX/1V4kBjNm9JNa42DInHtZ5Z
         dWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mgjC0puvphJrK1+sZ7kmtCaIi+v4//DuYs9Wlhj5+x4=;
        b=VFLu8kNcmBq1gDNxQ2m742bjQOg1BlEd80n2UuA2kiEdvhe5ig167Q4lG42pvEuqU1
         cKV+4eE6IK/IUv6gMJGw1sSGMKjtUY9ORypTB5Csvawzn2ncdiMW7ZGgtsQcqkVj/nZ8
         ZE0Jup2N9ie1boQ1b7be4YHLUJGeix7WgQi4xs9a09bLsTYxlaWppsSBBN1kV0D6vci6
         0jwOp2UO2nU8KoJtwgitNYN89SJBIfTDXrrsRD76S7XdCEkZcaKqJqQBLFutzRrk2gYJ
         SgqPmF9Cc6sAalN6T65Bq4UFTytA42gBit0VL8AlLzz8oB51BOl0XGlF06+/KZYfMfzR
         zYJA==
X-Gm-Message-State: AOAM532OrS4QkRXvKWeo1QU8JsM3+qBRg02MoVX0mr/j4gsNFtVt4l/G
        9Ycbpnnhm6zGIg/lC/sK/gIKMA==
X-Google-Smtp-Source: ABdhPJzFXvFRkmVj2P+FfHBUs1zEDumg9e1LVYfWePaNo/4nCO2R1AokjQ/t0Z7sQY0V3Wz3qjgatQ==
X-Received: by 2002:a05:6512:1390:: with SMTP id p16mr17446916lfa.31.1643678937680;
        Mon, 31 Jan 2022 17:28:57 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id w17sm2332582lfa.33.2022.01.31.17.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 17:28:57 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2] spi: st-ssc4: Covert to use GPIO descriptors
Date:   Tue,  1 Feb 2022 02:26:54 +0100
Message-Id: <20220201012654.562578-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This switches the ST SSC SPI controller to use GPIO
descriptors from the core instead of GPIO numbers.
It is already using the core parsing of GPIO numbers
so the switch is pretty straight-forward.

Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Get rid of a dangling "ret" variable causing build
  noise.
---
 drivers/spi/spi-st-ssc4.c | 31 ++++---------------------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/spi-st-ssc4.c b/drivers/spi/spi-st-ssc4.c
index 6c44dda9ee8c..843be803696b 100644
--- a/drivers/spi/spi-st-ssc4.c
+++ b/drivers/spi/spi-st-ssc4.c
@@ -17,7 +17,6 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/of_irq.h>
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
@@ -171,11 +170,6 @@ static int spi_st_transfer_one(struct spi_master *master,
 	return t->len;
 }
 
-static void spi_st_cleanup(struct spi_device *spi)
-{
-	gpio_free(spi->cs_gpio);
-}
-
 /* the spi->mode bits understood by this driver: */
 #define MODEBITS  (SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST | SPI_LOOP | SPI_CS_HIGH)
 static int spi_st_setup(struct spi_device *spi)
@@ -183,29 +177,17 @@ static int spi_st_setup(struct spi_device *spi)
 	struct spi_st *spi_st = spi_master_get_devdata(spi->master);
 	u32 spi_st_clk, sscbrg, var;
 	u32 hz = spi->max_speed_hz;
-	int cs = spi->cs_gpio;
-	int ret;
 
 	if (!hz)  {
 		dev_err(&spi->dev, "max_speed_hz unspecified\n");
 		return -EINVAL;
 	}
 
-	if (!gpio_is_valid(cs)) {
-		dev_err(&spi->dev, "%d is not a valid gpio\n", cs);
+	if (!spi->cs_gpiod) {
+		dev_err(&spi->dev, "no valid gpio assigned\n");
 		return -EINVAL;
 	}
 
-	ret = gpio_request(cs, dev_name(&spi->dev));
-	if (ret) {
-		dev_err(&spi->dev, "could not request gpio:%d\n", cs);
-		return ret;
-	}
-
-	ret = gpio_direction_output(cs, spi->mode & SPI_CS_HIGH);
-	if (ret)
-		goto out_free_gpio;
-
 	spi_st_clk = clk_get_rate(spi_st->clk);
 
 	/* Set SSC_BRF */
@@ -213,8 +195,7 @@ static int spi_st_setup(struct spi_device *spi)
 	if (sscbrg < 0x07 || sscbrg > BIT(16)) {
 		dev_err(&spi->dev,
 			"baudrate %d outside valid range %d\n", sscbrg, hz);
-		ret = -EINVAL;
-		goto out_free_gpio;
+		return -EINVAL;
 	}
 
 	spi_st->baud = spi_st_clk / (2 * sscbrg);
@@ -263,10 +244,6 @@ static int spi_st_setup(struct spi_device *spi)
 	readl_relaxed(spi_st->base + SSC_RBUF);
 
 	return 0;
-
-out_free_gpio:
-	gpio_free(cs);
-	return ret;
 }
 
 /* Interrupt fired when TX shift register becomes empty */
@@ -309,11 +286,11 @@ static int spi_st_probe(struct platform_device *pdev)
 	master->dev.of_node		= np;
 	master->mode_bits		= MODEBITS;
 	master->setup			= spi_st_setup;
-	master->cleanup			= spi_st_cleanup;
 	master->transfer_one		= spi_st_transfer_one;
 	master->bits_per_word_mask	= SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
 	master->auto_runtime_pm		= true;
 	master->bus_num			= pdev->id;
+	master->use_gpio_descriptors	= true;
 	spi_st				= spi_master_get_devdata(master);
 
 	spi_st->clk = devm_clk_get(&pdev->dev, "ssc");
-- 
2.34.1

