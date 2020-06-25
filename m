Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B2F20A67A
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jun 2020 22:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407076AbgFYUOb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 25 Jun 2020 16:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406983AbgFYUOa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 25 Jun 2020 16:14:30 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E370C08C5C1
        for <linux-spi@vger.kernel.org>; Thu, 25 Jun 2020 13:14:30 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id c11so3910904lfh.8
        for <linux-spi@vger.kernel.org>; Thu, 25 Jun 2020 13:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cOOG0dpEOffBjseoi1YjATO6CBoVo7fEFEkfhiQPdy8=;
        b=aqicq1Cx2FmkhvshvL+wsPW55/g+rvOg2mOcbBavnzNkoOkUi3qigNKAJke4Y8sGos
         SAr8MIqsDf7zGUWS92FUNJUShi4F55OmkaWz9yfv8x5a/eGEwaD3IkbRcE2YLDlhjndj
         oJeZ3XGm1tYctPKMwya1nYGVsufXI7fFfWhN/0XaNSAgX9ZM6WLEKlqs8UfULsyR1xSN
         HErFGfizqBGo/5dQh8PiPpnMVqNAYRw0/xL3tyVFlIgVsgRv/QScZD6jvGgyYMSw7BnG
         kDEHfmij+vQHQn5Kkyw+zB+XGKnWiWrewKSYKrlo6au4YR4UudPFUK2/0Cs998Ob1lq+
         KZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cOOG0dpEOffBjseoi1YjATO6CBoVo7fEFEkfhiQPdy8=;
        b=RhXNLeapLSzvnaKUzYnI067RbuChfLqs+Dp4iMNg2AO3sqpm4tsGL3mSI13LfZYGje
         fvMkvUO76KaKeakMQDVdGN+/pyN98t63Sv0iHzKTgWYDBqOYAkxk6zJNVRhkPQA7Hixv
         kAwU6cSjdWympqo/V5kLpIc+A9jTIkZrQQn8ev2x16AZqnfrWJP1DHIGxNDSqQhLcCn0
         yDsK1qWC7VKPG9YRU/FX0WUaHJ+R3t+KS4Gi/bmJxaH+1VPQ1VIqdlxiyzuyPH23KNm/
         JJfEH8BVHGozKLwBz3tTh/+kAYNj+PjdxhsXjc3vfXHJqmcfPOZuuPkdIFgL85/RPLi5
         eOqg==
X-Gm-Message-State: AOAM5326B9DA3+DIJJOxndbMW08n8HQh15A5fJDUVWxSAixuNuOm941/
        WHiHstHDDP4FxCOgzCPPzVqMaQ==
X-Google-Smtp-Source: ABdhPJz0WoN4QeH6ZbJ0xFKMCjtyas9vkK6wDXinP2NVGG19uCQFQUSrHwzZsA/aCW7UjJtEaSDSKA==
X-Received: by 2002:a19:4143:: with SMTP id o64mr19187962lfa.157.1593116068739;
        Thu, 25 Jun 2020 13:14:28 -0700 (PDT)
Received: from genomnajs.lan (c-d63ee155.152980-0-69706f6e6c79.bbcust.telenor.se. [85.225.62.214])
        by smtp.gmail.com with ESMTPSA id u7sm7206991lfi.45.2020.06.25.13.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 13:14:27 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Ionela Voinescu <ionela.voinescu@imgtec.com>,
        Sifan Naeem <sifan.naeem@imgtec.com>
Subject: [PATCH] spi: img-spfi: Convert to use GPIO descriptors
Date:   Thu, 25 Jun 2020 22:14:22 +0200
Message-Id: <20200625201422.208640-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This converts the IMG SPFI SPI driver to use GPIO descriptors
as obtained from the core instead of GPIO numbers.

The driver was already relying on the core code to look up
the GPIO numbers from the device tree and allocate memory for
storing state etc. By moving to use descriptors handled by
the core we can delete the setup/cleanup functions and
the device state handler that were only dealing with this.

Cc: Ionela Voinescu <ionela.voinescu@imgtec.com>
Cc: Sifan Naeem <sifan.naeem@imgtec.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-img-spfi.c | 56 +-------------------------------------
 1 file changed, 1 insertion(+), 55 deletions(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index 8543f5ed1099..b068537375d6 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -9,7 +9,6 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
-#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -102,10 +101,6 @@ struct img_spfi {
 	bool rx_dma_busy;
 };
 
-struct img_spfi_device_data {
-	bool gpio_requested;
-};
-
 static inline u32 spfi_readl(struct img_spfi *spfi, u32 reg)
 {
 	return readl(spfi->regs + reg);
@@ -442,54 +437,6 @@ static int img_spfi_unprepare(struct spi_master *master,
 	return 0;
 }
 
-static int img_spfi_setup(struct spi_device *spi)
-{
-	int ret = -EINVAL;
-	struct img_spfi_device_data *spfi_data = spi_get_ctldata(spi);
-
-	if (!spfi_data) {
-		spfi_data = kzalloc(sizeof(*spfi_data), GFP_KERNEL);
-		if (!spfi_data)
-			return -ENOMEM;
-		spfi_data->gpio_requested = false;
-		spi_set_ctldata(spi, spfi_data);
-	}
-	if (!spfi_data->gpio_requested) {
-		ret = gpio_request_one(spi->cs_gpio,
-				       (spi->mode & SPI_CS_HIGH) ?
-				       GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH,
-				       dev_name(&spi->dev));
-		if (ret)
-			dev_err(&spi->dev, "can't request chipselect gpio %d\n",
-				spi->cs_gpio);
-		else
-			spfi_data->gpio_requested = true;
-	} else {
-		if (gpio_is_valid(spi->cs_gpio)) {
-			int mode = ((spi->mode & SPI_CS_HIGH) ?
-				    GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH);
-
-			ret = gpio_direction_output(spi->cs_gpio, mode);
-			if (ret)
-				dev_err(&spi->dev, "chipselect gpio %d setup failed (%d)\n",
-					spi->cs_gpio, ret);
-		}
-	}
-	return ret;
-}
-
-static void img_spfi_cleanup(struct spi_device *spi)
-{
-	struct img_spfi_device_data *spfi_data = spi_get_ctldata(spi);
-
-	if (spfi_data) {
-		if (spfi_data->gpio_requested)
-			gpio_free(spi->cs_gpio);
-		kfree(spfi_data);
-		spi_set_ctldata(spi, NULL);
-	}
-}
-
 static void img_spfi_config(struct spi_master *master, struct spi_device *spi,
 			    struct spi_transfer *xfer)
 {
@@ -659,12 +606,11 @@ static int img_spfi_probe(struct platform_device *pdev)
 			master->max_speed_hz = max_speed_hz;
 	}
 
-	master->setup = img_spfi_setup;
-	master->cleanup = img_spfi_cleanup;
 	master->transfer_one = img_spfi_transfer_one;
 	master->prepare_message = img_spfi_prepare;
 	master->unprepare_message = img_spfi_unprepare;
 	master->handle_err = img_spfi_handle_err;
+	master->use_gpio_descriptors = true;
 
 	spfi->tx_ch = dma_request_chan(spfi->dev, "tx");
 	if (IS_ERR(spfi->tx_ch)) {
-- 
2.25.4

