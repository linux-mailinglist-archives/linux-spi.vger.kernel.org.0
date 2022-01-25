Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902EF49AAB9
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jan 2022 05:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S246018AbiAYDpX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Jan 2022 22:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389783AbiAYB5Y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Jan 2022 20:57:24 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2A5C02B869
        for <linux-spi@vger.kernel.org>; Mon, 24 Jan 2022 17:12:52 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id x11so53663712lfa.2
        for <linux-spi@vger.kernel.org>; Mon, 24 Jan 2022 17:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B9mQc6p0Xq3ZpYYadbm/ocOt7iapEV8bzJfjBbIJIzM=;
        b=lhs9HCeop/Xz7D8m4N14XLx/VbDFoE0VR7FVt28BPtUhdZjqaW01YyGAqe2PUck8+Z
         2pOI2xxDz487Pty6RayqYv62vdKIoVcc5IH8H8/TEXNBsMiKWK6JzcRKdD2SyXh71t0d
         8dv6oxHuVVuWPf3ymrjhyJXFbCqpOiF6ERVG/P839QNQr7ZwZid9NeO98/pHqpb+Wszq
         hs1oku0JN+JefoIhvNfxr4Yailo2Y3dt8yuuQbB8Ehb2IEVsRFJk22IHPvw5UowQRaOw
         bpbarOeezcJz1dCf91bxNzFHQEmoa7wMqr2p61xvqI8UO0xjlVP9nw2V4gpI0EsFYGwb
         UbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B9mQc6p0Xq3ZpYYadbm/ocOt7iapEV8bzJfjBbIJIzM=;
        b=ZJ5wReBQ/7p/Ir+I/viUEEvmgWtLoI2Tzwa/FOIWgsjQ6TsTTAbjyHL797w4UnZ506
         hIOs20TxFEAyfhmSO57OQv9eQG002pc2VuZPzh8SzWmhpfcRot1+Ea6DgfRjYyl3g1Fh
         20/lz5Xlu9Ahu7X529wUyVpCGDAJkoVPieDmRwJwzfnR+glRCn9eIAve8CLqEFM+StB/
         XTUjpBtkO+9PnNHTEaiakTfoO9lsm7Qm9reZlxX0YGjLoKUO60UTvaFlgfjUEQesum5U
         04/M96JajLWQRMO2CxY/ES68CDS8B0E5ydD9g3UoZpvW7xYI6t/3x0KiONmEar0X40Mf
         tM4Q==
X-Gm-Message-State: AOAM533gxKEMdRE+GnzCo2exwdeXVXtKD7tZ+8QsVJZ0l4ChLN76cuDB
        d/LYbmmVwnumYtaEHgw+Xv3eZg==
X-Google-Smtp-Source: ABdhPJyPvZOEF2NPrGTOP2f9WAPNYf5zt4VGIwAZtLuSKCQmWqV0DzGX0125UtEfXtHAV6lvs78WzA==
X-Received: by 2002:a05:6512:2283:: with SMTP id f3mr6500365lfu.198.1643073170483;
        Mon, 24 Jan 2022 17:12:50 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id q5sm1202081lfu.232.2022.01.24.17.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 17:12:49 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH] spi: st-ssc4: Covert to use GPIO descriptors
Date:   Tue, 25 Jan 2022 02:10:47 +0100
Message-Id: <20220125011047.495828-1-linus.walleij@linaro.org>
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
 drivers/spi/spi-st-ssc4.c | 30 ++++--------------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/spi-st-ssc4.c b/drivers/spi/spi-st-ssc4.c
index 6c44dda9ee8c..76478a53b9d8 100644
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
@@ -183,7 +177,6 @@ static int spi_st_setup(struct spi_device *spi)
 	struct spi_st *spi_st = spi_master_get_devdata(spi->master);
 	u32 spi_st_clk, sscbrg, var;
 	u32 hz = spi->max_speed_hz;
-	int cs = spi->cs_gpio;
 	int ret;
 
 	if (!hz)  {
@@ -191,21 +184,11 @@ static int spi_st_setup(struct spi_device *spi)
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
@@ -213,8 +196,7 @@ static int spi_st_setup(struct spi_device *spi)
 	if (sscbrg < 0x07 || sscbrg > BIT(16)) {
 		dev_err(&spi->dev,
 			"baudrate %d outside valid range %d\n", sscbrg, hz);
-		ret = -EINVAL;
-		goto out_free_gpio;
+		return -EINVAL;
 	}
 
 	spi_st->baud = spi_st_clk / (2 * sscbrg);
@@ -263,10 +245,6 @@ static int spi_st_setup(struct spi_device *spi)
 	readl_relaxed(spi_st->base + SSC_RBUF);
 
 	return 0;
-
-out_free_gpio:
-	gpio_free(cs);
-	return ret;
 }
 
 /* Interrupt fired when TX shift register becomes empty */
@@ -309,11 +287,11 @@ static int spi_st_probe(struct platform_device *pdev)
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

