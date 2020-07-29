Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5C2232727
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jul 2020 23:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgG2VvD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jul 2020 17:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2VvD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jul 2020 17:51:03 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B7EC061794
        for <linux-spi@vger.kernel.org>; Wed, 29 Jul 2020 14:51:03 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id r19so26646970ljn.12
        for <linux-spi@vger.kernel.org>; Wed, 29 Jul 2020 14:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uhXnQZb72OVE/KwqsuLeJrGhAwOKk910rOtvCQvzHic=;
        b=wwuW2GJ5EwJebvjdUC1IyZ4tAhKBxGAcjcJhLfBkZALkm8/oVCQwNet64/fJYCZxT8
         YnzKUdxY846I/wT9ercq6OwiKDk7N5dHPffCEBCrjQF0libGWs+2V6vIBNA93sPdYnmp
         BLAcIPf2rjOerZmVvug7LUQCKLUrSDMvteyeiDxplvoc+tN9nOOvgd6Q6jb3fTpxycP9
         +qmGHZuVrziEFDtGxsEsTbSNXCOGkptKeqY38SsZvlnkpWR/Jah1SLSAWS1Gr41t+C5f
         hPtyzblnDDVGAo39828sq9pGwQFXvw+GuVJLVJ5txNVSXe3Bw4GpRt99AdxEb3gMJhXu
         3GmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uhXnQZb72OVE/KwqsuLeJrGhAwOKk910rOtvCQvzHic=;
        b=H62qFj8enltlfVlUUkco//1sTbKKRG3GKeUZpQypfuuQsil+r72aWL2kTIruz/9ii4
         UppniSDUSG9ycX+VrX4aw13TvPrnGG0lZ7Tv2s3UmRMl6IxC0fk6muJhuRcwV1X4fJR2
         bO6NBljudzOWdhtUySquzHFVkkRemaeB0WAQ31eY0AV28TCzRXJGXqRLcdjAhybAIznX
         n7KOLV5fjPiO81BFPF0Yk+DB2zABBMHgVDP9TbygT7H4g+pwxK4j5oDNu55Lg97rt+rb
         HSy8dhWKR1t03m0cOXr3mX6IcYBQK9F/sVXlAevkxplUh/VWL2RuCykZjMNbSdryJLO7
         g2Eg==
X-Gm-Message-State: AOAM530NPIcUNUwa3WH/w1KLWtZpZeDi1DWk7jWIYb3q3dk+fdZi63pj
        DHOnXjNG0DoBtlYAVE/W28I97+yS0PWqGg==
X-Google-Smtp-Source: ABdhPJxdd3PW8C1IiQ6SV9NjccnlNvV8yssiFDq3ZAiPQyG4RqGmaxoZdYHyPC79nL4YfW7I02D9sg==
X-Received: by 2002:a2e:961a:: with SMTP id v26mr164311ljh.467.1596059461464;
        Wed, 29 Jul 2020 14:51:01 -0700 (PDT)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id l26sm721262lfj.22.2020.07.29.14.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 14:50:59 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Anatolij Gustschin <agust@denx.de>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] spi: mpc512x-psc: Convert to use GPIO descriptors
Date:   Wed, 29 Jul 2020 23:48:17 +0200
Message-Id: <20200729214817.478834-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200729214817.478834-1-linus.walleij@linaro.org>
References: <20200729214817.478834-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This driver is already relying on the core to provide
valid GPIO numbers in spi->cs_gpio through
of_spi_get_gpio_numbers(), so we can switch to letting
the core use GPIO descriptors instead.

Make sure that the .set_cs() is always called, as some controller
set-up is also needed.

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Anatolij Gustschin <agust@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-mpc512x-psc.c | 33 +++++++--------------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 35313a77f977..dd8bba408301 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -23,7 +23,6 @@
 #include <linux/clk.h>
 #include <linux/spi/spi.h>
 #include <linux/fsl_devices.h>
-#include <linux/gpio.h>
 #include <asm/mpc52xx_psc.h>
 
 enum {
@@ -99,7 +98,7 @@ static void mpc512x_psc_spi_set_cs(struct spi_device *spi, bool enable)
 	u16 bclkdiv;
 
 	if (!enable) {
-		if (mps->cs_control && gpio_is_valid(spi->cs_gpio))
+		if (mps->cs_control && spi->cs_gpiod)
 			mps->cs_control(spi, (spi->mode & SPI_CS_HIGH) ? 0 : 1);
 		return;
 	}
@@ -134,7 +133,7 @@ static void mpc512x_psc_spi_set_cs(struct spi_device *spi, bool enable)
 	out_be32(psc_addr(mps, ccr), ccr);
 	mps->bits_per_word = cs->bits_per_word;
 
-	if (mps->cs_control && gpio_is_valid(spi->cs_gpio))
+	if (mps->cs_control && spi->cs_gpiod)
 		mps->cs_control(spi, (spi->mode & SPI_CS_HIGH) ? 1 : 0);
 }
 
@@ -358,18 +357,6 @@ static int mpc512x_psc_spi_setup(struct spi_device *spi)
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
 
@@ -381,8 +368,6 @@ static int mpc512x_psc_spi_setup(struct spi_device *spi)
 
 static void mpc512x_psc_spi_cleanup(struct spi_device *spi)
 {
-	if (gpio_is_valid(spi->cs_gpio))
-		gpio_free(spi->cs_gpio);
 	kfree(spi->controller_state);
 }
 
@@ -461,11 +446,6 @@ static irqreturn_t mpc512x_psc_spi_isr(int irq, void *dev_id)
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
@@ -485,10 +465,8 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	mps->type = (int)of_device_get_match_data(dev);
 	mps->irq = irq;
 
-	if (pdata == NULL) {
-		mps->cs_control = mpc512x_spi_cs_control;
-	} else {
-		mps->cs_control = pdata->cs_control;
+	if (pdata) {
+		mps->cs_control = pdata->cs_control;x
 		master->bus_num = pdata->bus_num;
 		master->num_chipselect = pdata->max_chipselect;
 	}
@@ -499,6 +477,9 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	master->transfer_one_message = mpc512x_psc_spi_msg_xfer;
 	master->unprepare_transfer_hardware = mpc512x_psc_spi_unprep_xfer_hw;
 	master->set_cs = mpc512x_psc_spi_set_cs;
+	/* This makes sure our custom .set_cs() is always called */
+	master->flags = SPI_MASTER_GPIO_SS;
+	master->use_gpio_descriptors = true;
 	master->cleanup = mpc512x_psc_spi_cleanup;
 	master->dev.of_node = dev->of_node;
 
-- 
2.26.2

