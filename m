Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 966A1113D14
	for <lists+linux-spi@lfdr.de>; Thu,  5 Dec 2019 09:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbfLEIeG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Dec 2019 03:34:06 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46404 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfLEIeG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 5 Dec 2019 03:34:06 -0500
Received: by mail-lf1-f66.google.com with SMTP id f15so984445lfl.13
        for <linux-spi@vger.kernel.org>; Thu, 05 Dec 2019 00:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l+LXiAZo+p2jX4CDBSkkdqDUl9e7K876Ci6DzEwwKCE=;
        b=CsF9xFv+vVBB3IE3qCg80fClCyEP9ZEnX3xgICmF78TSdw5qOlxewHqTeCkL9HQQ5b
         zIFjHc9KH4uib3qmnCIR4fEhaf1kHZYzYSf+Olu+fyP1uWMW1oRcT/cCC6sUqrsjDdjL
         pIRgzMJkbJ0BCIlnCz9L4ceF+AOpwoy91cC4A0cTVCs3E8fIzqbar69WaAmg4qTjwRDv
         70hlZPtgaCZaQ7bTLW5IGIEkEPrspeU8LRNTSIMS59ZRJFiRB6bww6iRMiA5t0+E5GYV
         /1sHjv6KvVi5aCyPx1TG2HoGH56OJ3vBAxTiAydj3lpmKEn010CUN0HsN9Y6HmHgN+wP
         huzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l+LXiAZo+p2jX4CDBSkkdqDUl9e7K876Ci6DzEwwKCE=;
        b=NionlpXID9l9jnzndWggSppgan8B6rE1wkSFfN+4yJxr3c8SDAVjuJFbVS7DVPuY1K
         V+OC7TI4/7rycttvqkfQC1gl3jqAhu02ZNmDrAOU6Ava0bAaGmb871/iVm2MYqY1sqw8
         TY9ZBG+aGlu46vRae1mqfZBk+9nmb+XCHNr+mzwO1tb66g84TsFj7YbL0MNMGDzAAhEe
         KfYP2vK++8fkPFQE/m5lLqYKzTGiUHGrjS0BRFuJcOB3nOe7ysMn6DxgRSbHc2CqhLAj
         cOU7RKOlr6jC1po3n8Vv5jv/IntzuMecCUl84Bn5mBepfsNVgmhl6g/46pLuhwTOUVb1
         sfuw==
X-Gm-Message-State: APjAAAVUQQAKNmDP5m2PObxB04csCj9t2V9U9jwzFv4bDJ7bDYxeEhXx
        MZhogPhUxRkofIjSnA/54FslPA==
X-Google-Smtp-Source: APXvYqzZvfPO1ltpPTZHFAP4eZC/GcfMQRcioHWjM032IBD4IJGw0TE92xEZ2Auy2Vg+SdA2ANPO4Q==
X-Received: by 2002:a19:8a06:: with SMTP id m6mr4045846lfd.99.1575534844271;
        Thu, 05 Dec 2019 00:34:04 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id z13sm4511090ljh.21.2019.12.05.00.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 00:34:03 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Cezary Gapinski <cezary.gapinski@gmail.com>
Subject: [PATCH] spi: stm32: Switch to use GPIO descriptors for CS
Date:   Thu,  5 Dec 2019 09:34:01 +0100
Message-Id: <20191205083401.27077-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This switches the STM32 SPI driver over to using GPIO
descriptors for chip select. Instead of the callbacks for
picking the GPIO lines using the legacy API we just let
the core handle it all using descriptors.

Cc: Fabien Dessenne <fabien.dessenne@st.com>
Cc: Amelie Delaunay <amelie.delaunay@st.com>
Cc: Cezary Gapinski <cezary.gapinski@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-stm32.c | 47 +++--------------------------------------
 1 file changed, 3 insertions(+), 44 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index b222ce8d083e..7d75632c4151 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -9,7 +9,6 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
-#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
@@ -973,29 +972,6 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-/**
- * stm32_spi_setup - setup device chip select
- */
-static int stm32_spi_setup(struct spi_device *spi_dev)
-{
-	int ret = 0;
-
-	if (!gpio_is_valid(spi_dev->cs_gpio)) {
-		dev_err(&spi_dev->dev, "%d is not a valid gpio\n",
-			spi_dev->cs_gpio);
-		return -EINVAL;
-	}
-
-	dev_dbg(&spi_dev->dev, "%s: set gpio%d output %s\n", __func__,
-		spi_dev->cs_gpio,
-		(spi_dev->mode & SPI_CS_HIGH) ? "low" : "high");
-
-	ret = gpio_direction_output(spi_dev->cs_gpio,
-				    !(spi_dev->mode & SPI_CS_HIGH));
-
-	return ret;
-}
-
 /**
  * stm32_spi_prepare_msg - set up the controller to transfer a single message
  */
@@ -1810,7 +1786,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct stm32_spi *spi;
 	struct resource *res;
-	int i, ret;
+	int ret;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(struct stm32_spi));
 	if (!master) {
@@ -1898,7 +1874,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	master->bits_per_word_mask = spi->cfg->get_bpw_mask(spi);
 	master->max_speed_hz = spi->clk_rate / spi->cfg->baud_rate_div_min;
 	master->min_speed_hz = spi->clk_rate / spi->cfg->baud_rate_div_max;
-	master->setup = stm32_spi_setup;
+	master->use_gpio_descriptors = true;
 	master->prepare_message = stm32_spi_prepare_msg;
 	master->transfer_one = stm32_spi_transfer_one;
 	master->unprepare_message = stm32_spi_unprepare_msg;
@@ -1928,29 +1904,12 @@ static int stm32_spi_probe(struct platform_device *pdev)
 		goto err_dma_release;
 	}
 
-	if (!master->cs_gpios) {
+	if (!master->cs_gpiods) {
 		dev_err(&pdev->dev, "no CS gpios available\n");
 		ret = -EINVAL;
 		goto err_dma_release;
 	}
 
-	for (i = 0; i < master->num_chipselect; i++) {
-		if (!gpio_is_valid(master->cs_gpios[i])) {
-			dev_err(&pdev->dev, "%i is not a valid gpio\n",
-				master->cs_gpios[i]);
-			ret = -EINVAL;
-			goto err_dma_release;
-		}
-
-		ret = devm_gpio_request(&pdev->dev, master->cs_gpios[i],
-					DRIVER_NAME);
-		if (ret) {
-			dev_err(&pdev->dev, "can't get CS gpio %i\n",
-				master->cs_gpios[i]);
-			goto err_dma_release;
-		}
-	}
-
 	dev_info(&pdev->dev, "driver initialized\n");
 
 	return 0;
-- 
2.23.0

