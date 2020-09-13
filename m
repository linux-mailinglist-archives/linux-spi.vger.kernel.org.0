Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7DA267FC0
	for <lists+linux-spi@lfdr.de>; Sun, 13 Sep 2020 16:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgIMOUK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 13 Sep 2020 10:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbgIMOUI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 13 Sep 2020 10:20:08 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85350C06174A
        for <linux-spi@vger.kernel.org>; Sun, 13 Sep 2020 07:20:07 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id n133so14456988qkn.11
        for <linux-spi@vger.kernel.org>; Sun, 13 Sep 2020 07:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Sc2ucwApAgbapLFwUU7U5vvbOcGFmFEAcEBxHT7jzJY=;
        b=DEhuqCmAL+IOG3/PsF1Ij35CnOoDYI+nRfpBp6aCzlKamEH8x7x0RBLYDUADjggJb6
         A/8R2EZ/1EvUsKQy/z/8KvZDHCFyIPG9UPxXTRZzroeSFsywNM8thWr131pgBrADsX6j
         aPLmjj4YQibszPbvIlSy/CFronDjAioqWtcR/tD9EHZfS3EpbdVjWJqfsKuGRXy30vFd
         PIIWm37fStXcT+isIQCqsbJ3J5vBBiHFrquZ6yawA0xfsgbK0JMdHT1gIck8KaooRRhm
         Hsa5XNemIhYBH6bSNQVnA9g+k9SbdvHSI64KPPSzIj6Y6951AIsPhe/fLAm0Y8bK3JKA
         lNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Sc2ucwApAgbapLFwUU7U5vvbOcGFmFEAcEBxHT7jzJY=;
        b=TFo0J+BkMF79ckdaHvwJpUej5qwkZvS2nqdV+OaiLMkHhZjpdiypjJ4Y4E9EdR5Npx
         8Z0AjC2fvQ0OwBQiiVpmqZW4apmr3lF3jiZDVA3MNbs4mHBuCinAgmPbh0CjmT1VnoaY
         9UZCwgLTCSUDTLMC9FiawtnOBTP1KCL9K2b2WbybAhz6z0yHDL684lsgqYr3E/NPCdlE
         S+bqVFkOHUSWyuOcSZhk5TPUlrPRe8t0K+Yqzt2tzbtR8/IZrfdsYsQYiFSofvfQRIzn
         /4MaIoNQAsb4y2S9fOnGnw4T5KOVrN4fhmBpXueWG3EvlfCd8pkDuVk3o1mb3oLT1u7R
         Heew==
X-Gm-Message-State: AOAM530XCpK32dv9mF01WfmtzZIs+6Rc6kbYj+mU522g58fgg0XPYh8R
        X15/XKFC3KZ0bV3edk29dmUl66ECJfA=
X-Google-Smtp-Source: ABdhPJyUkLNYpUbV0Smoh5cnEK8yS6UZD3sZTTPSKR01Het6kujALAKUME95tOihyeu0BO9TBoxHuA==
X-Received: by 2002:a05:620a:200d:: with SMTP id c13mr8850589qka.499.1600006798642;
        Sun, 13 Sep 2020 07:19:58 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:640:9cc0:878:419e:8021])
        by smtp.gmail.com with ESMTPSA id f8sm11739891qkb.123.2020.09.13.07.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 07:19:57 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     broonie@kernel.org
Cc:     matthias.schiffer@ew.tq-group.com, linux-spi@vger.kernel.org,
        shawnguo@kernel.org, kernel@pengutronix.de, linux-imx@nxp.com,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] spi: imx: Fix the number of chipselects count
Date:   Sun, 13 Sep 2020 11:19:37 -0300
Message-Id: <20200913141937.11588-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On an imx6q-sabresd board, which has one single GPIO chipselect used
for SPI, the SPI core now reports that it has 3 chipselects.

This happens since commit 8cdcd8aeee281 ("spi: imx/fsl-lpspi: Convert to
GPIO descriptors"), which assigned master->num_chipselect as 3 when
'num-cs' is absent.

However, 'num-cs' property is not used in any in-tree devicetree, leading
to an incorrect count of chipselects.

Fix the number of chipselects count by only assigning
master->num_chipselect in the unlikely case when the "cs-gpios" property
is absent.

Print a warning in this case, since using native chipselects in
several i.MX SoCs is known to be problematic.

While at it, use 4 as the maximum number of native chip-select supported
by this controller.

Fixes: 8cdcd8aeee281 ("spi: imx/fsl-lpspi: Convert to GPIO descriptors")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/spi/spi-imx.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 197f60632072..968c868cf17f 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -13,6 +13,7 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_gpio.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -1581,7 +1582,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	const struct spi_imx_devtype_data *devtype_data = of_id ? of_id->data :
 		(struct spi_imx_devtype_data *)pdev->id_entry->driver_data;
 	bool slave_mode;
-	u32 val;
+	int num_cs_gpios;
 
 	slave_mode = devtype_data->has_slavemode &&
 			of_property_read_bool(np, "spi-slave");
@@ -1613,16 +1614,12 @@ static int spi_imx_probe(struct platform_device *pdev)
 
 	spi_imx->devtype_data = devtype_data;
 
-	/*
-	 * Get number of chip selects from device properties. This can be
-	 * coming from device tree or boardfiles, if it is not defined,
-	 * a default value of 3 chip selects will be used, as all the legacy
-	 * board files have <= 3 chip selects.
-	 */
-	if (!device_property_read_u32(&pdev->dev, "num-cs", &val))
-		master->num_chipselect = val;
-	else
-		master->num_chipselect = 3;
+	num_cs_gpios = gpiod_count(&pdev->dev, "cs");
+	if ((num_cs_gpios == 0) || (num_cs_gpios == -ENOENT)) {
+		dev_warn(&pdev->dev,
+			 "cs-gpios not found. Using native chipselect with this SPI controller is known to be problematic\n");
+		master->num_chipselect = 4;
+	}
 
 	spi_imx->bitbang.setup_transfer = spi_imx_setupxfer;
 	spi_imx->bitbang.txrx_bufs = spi_imx_transfer;
-- 
2.17.1

