Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC58720A8A2
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jun 2020 01:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403984AbgFYXNC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 25 Jun 2020 19:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407700AbgFYXNB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 25 Jun 2020 19:13:01 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1965EC08C5C1
        for <linux-spi@vger.kernel.org>; Thu, 25 Jun 2020 16:13:01 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id t9so4133628lfl.5
        for <linux-spi@vger.kernel.org>; Thu, 25 Jun 2020 16:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8l/4qnt5t8nkFw+DlUPZ4RXWogUlkAdw7ImexBI0ikI=;
        b=IBKFFdB1A9rgQj5qLECj4YGrtznXMmNs1xQ2l57LiWgCW4He0mUH6+oAF4jP0OgRKV
         cLd0AVGMJd/i3FpiNY5jSKTS3E2qteXfPN5/cPGWC+TDVr1oghCZYYs2H++3H9EIB3Kq
         Hjb1vSJJdXZAq7J5AW/lzSj1ZGKodpdGM0TTWxRuQLk2NoSu9oxd6JQxbpXipfxOX0a0
         FmX8am3sTO0/hRFzJ3pT0ipywWTEwihaC+HONP55IwfQU3bkwXoR48hbcpojn4XWbCSI
         rR3w/KWgs7OZC0maM13ReKfc4bZQNe/R7B+QNs7ioUzNritb3PqCi3NexYQQkHH57qJE
         0vkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8l/4qnt5t8nkFw+DlUPZ4RXWogUlkAdw7ImexBI0ikI=;
        b=QJSrinumSt86RGMGHfL1rSrSs9sELAZwGA9VIgLABlmS5yf75Hke3tIQISKH3QPbUW
         Jfbn293g71qzoDgL4r5bjt9iR+/dQQMfv9kUHkAiBYmbWDKqTfhi7SqnPa3Jis3cRmRo
         rZtZwsM/9/51hD3GvY4g4X3cH/hjdr4pVPbWPEiXRZjRaeR4nJIb3Yzfvl8Vgi+EenOM
         GO4fRNEGNSXcPejfUiqwOlhGMWkwKq+LNaiBN/loCBicaolwgqUabK7UrKPc/+onWeAJ
         KI6pJ/p3k6vodNhPDr2ZpKBtEiEI5dzTo+QHZ1ryC3rnF4Nx6sTb3OE3Ho6gTXyVQUOX
         Ldvg==
X-Gm-Message-State: AOAM533AWRM5XdJFPzudLuFsXuy5zdZVc1aDtcMuC7UR1iicyHtUtQaA
        wuyACl5OnefxYB7amjcozSaMww==
X-Google-Smtp-Source: ABdhPJyykQEs4yJ6jWyHPkP7TG+MV83/orei/U2wDZYisD57NjpghSYESBu06Z40mYZ2fxF9GXAL4A==
X-Received: by 2002:a19:14e:: with SMTP id 75mr208475lfb.7.1593126779559;
        Thu, 25 Jun 2020 16:12:59 -0700 (PDT)
Received: from genomnajs.lan (c-d63ee155.152980-0-69706f6e6c79.bbcust.telenor.se. [85.225.62.214])
        by smtp.gmail.com with ESMTPSA id m15sm1973156ljp.45.2020.06.25.16.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 16:12:59 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        David Lechner <david@lechnology.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH] spi: omap2-mcspi: Convert to use GPIO descriptors
Date:   Fri, 26 Jun 2020 01:12:57 +0200
Message-Id: <20200625231257.280615-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The OMAP2 MCSPI has some kind of half-baked GPIO CS support:
it includes code like this:

  if (gpio_is_valid(spi->cs_gpio)) {
        ret = gpio_request(spi->cs_gpio, dev_name(&spi->dev));
	(...)

But it doesn't parse the "cs-gpios" attribute in the device
tree to count the number of GPIOs or pick out the GPIO numbers
and put these in the SPI master's .cs_gpios property.

We complete the implementation of supporting CS GPIOs
from the device tree and switch it over to use the SPI core
for this.

Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: David Lechner <david@lechnology.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-omap2-mcspi.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index e9e256718ef4..1c9478e6e5d9 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -27,7 +27,6 @@
 #include <linux/iopoll.h>
 
 #include <linux/spi/spi.h>
-#include <linux/gpio.h>
 
 #include <linux/platform_data/spi-omap2-mcspi.h>
 
@@ -1043,16 +1042,6 @@ static int omap2_mcspi_setup(struct spi_device *spi)
 		spi->controller_state = cs;
 		/* Link this to context save list */
 		list_add_tail(&cs->node, &ctx->cs);
-
-		if (gpio_is_valid(spi->cs_gpio)) {
-			ret = gpio_request(spi->cs_gpio, dev_name(&spi->dev));
-			if (ret) {
-				dev_err(&spi->dev, "failed to request gpio\n");
-				return ret;
-			}
-			gpio_direction_output(spi->cs_gpio,
-					 !(spi->mode & SPI_CS_HIGH));
-		}
 	}
 
 	ret = pm_runtime_get_sync(mcspi->dev);
@@ -1080,9 +1069,6 @@ static void omap2_mcspi_cleanup(struct spi_device *spi)
 
 		kfree(cs);
 	}
-
-	if (gpio_is_valid(spi->cs_gpio))
-		gpio_free(spi->cs_gpio);
 }
 
 static irqreturn_t omap2_mcspi_irq_handler(int irq, void *data)
@@ -1152,7 +1138,7 @@ static int omap2_mcspi_transfer_one(struct spi_master *master,
 
 	omap2_mcspi_set_enable(spi, 0);
 
-	if (gpio_is_valid(spi->cs_gpio))
+	if (spi->cs_gpiod)
 		omap2_mcspi_set_cs(spi, spi->mode & SPI_CS_HIGH);
 
 	if (par_override ||
@@ -1241,7 +1227,7 @@ static int omap2_mcspi_transfer_one(struct spi_master *master,
 
 	omap2_mcspi_set_enable(spi, 0);
 
-	if (gpio_is_valid(spi->cs_gpio))
+	if (spi->cs_gpiod)
 		omap2_mcspi_set_cs(spi, !(spi->mode & SPI_CS_HIGH));
 
 	if (mcspi->fifo_depth > 0 && t)
@@ -1431,6 +1417,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	master->dev.of_node = node;
 	master->max_speed_hz = OMAP2_MCSPI_MAX_FREQ;
 	master->min_speed_hz = OMAP2_MCSPI_MAX_FREQ >> 15;
+	master->use_gpio_descriptors = true;
 
 	platform_set_drvdata(pdev, master);
 
-- 
2.25.4

