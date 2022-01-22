Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6B04968CE
	for <lists+linux-spi@lfdr.de>; Sat, 22 Jan 2022 01:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiAVAfI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Jan 2022 19:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiAVAfI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Jan 2022 19:35:08 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794ECC06173B
        for <linux-spi@vger.kernel.org>; Fri, 21 Jan 2022 16:35:07 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id w7so2496544ljw.11
        for <linux-spi@vger.kernel.org>; Fri, 21 Jan 2022 16:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=654Szygw/tZcaYl4fUeQ1fdXpz986cxMelGUP0eFVWE=;
        b=kO+vT7xRfvKRAVm6xVSTdpfUIQb+G16JImVW23N94jR6Ad7kuIMKeYyPqaVmXWlFPn
         84Yt1MgnQUsvw5j8tsKdowqXHYdLm8HeCL/B2EmiDO26BNSo58aiAYlwglra2NFItWKj
         W89oBTEdTh3CPrP1sB+W/y1vU1v4QZdknjLx0sFh1kelCaHB6krYBDTXZ61DqsdqCa2L
         2F61ojZkLhzINH/48wewo6GSZNkSe7YGHapRTyg8b4PRwpIBuLbVncnQOjjsnwE9zA3e
         6J2hg+Q/ogHywJhPReXT+TZ0BV0iWgF1lbEm9SlXuDl5CY7HFi+QsJpVfjZkmmqq5sOV
         EtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=654Szygw/tZcaYl4fUeQ1fdXpz986cxMelGUP0eFVWE=;
        b=3/fI+MrD7IHi/PafJ7s2/6y+ksIwq0uTsx/gdiKQPmeLvKPNGwrYZhQhNk0F/Bmx0c
         r9j+i3tK7kzJqxdTygr7PO06JNQpz2O7DKwh/+4qg0a8Kl6pcCE0I6VPv8mSPJW+EaPo
         QSh/8Fnl4x/MalsskyMuT4rCAQwJ/uAdvaT9SNoyDvpBopOPIaVCiAXPknCypI/gXYG4
         Mp0ECr6Qweti+DiW+LHpSeIXn1GEDUIn0xlHkFA+Qy+T2f3+0cJ3TsvDDlM32julZf2p
         YLrtC8eKF7xLqM5GiJn6z7ebJLVRPFDr2ht8n8MzpaUP1M0dmv07AARSha/GEN9aYftG
         aIEw==
X-Gm-Message-State: AOAM5319Ry3Gt8ZhHxg0kKnaIv7FRnXNb2bimB/NuP3qYVQtePbv/xqG
        J1D93cO3jSPSWdijsU/wssJU8w==
X-Google-Smtp-Source: ABdhPJwfw+/zewjqFmpFXLYiPOoriWdawrGuqa104Va27XOeLFhg/jIK1aTOWXdR+gKsHrbGWTEllw==
X-Received: by 2002:a2e:b74c:: with SMTP id k12mr4513921ljo.206.1642811705806;
        Fri, 21 Jan 2022 16:35:05 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id b7sm85257lfi.125.2022.01.21.16.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 16:35:05 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Mason Zhang <Mason.Zhang@mediatek.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Hess <peter.hess@ph-home.de>,
        Leilk Liu <leilk.liu@mediatek.com>
Subject: [PATCH] spi: mt65xx: Convert to GPIO descriptors
Date:   Sat, 22 Jan 2022 01:33:02 +0100
Message-Id: <20220122003302.374304-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The MT65xx driver was already relying on the core to get some
GPIO line numbers so it can be (hopefully) trivially converted
to use descriptors instead.

Cc: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc: Mason Zhang <Mason.Zhang@mediatek.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Peter Hess <peter.hess@ph-home.de>
Cc: Leilk Liu <leilk.liu@mediatek.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-mt65xx.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index a15de10ee286..4f49b2e93ca7 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -12,7 +12,7 @@
 #include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/spi-mt65xx.h>
 #include <linux/pm_runtime.h>
@@ -605,8 +605,9 @@ static int mtk_spi_setup(struct spi_device *spi)
 	if (!spi->controller_data)
 		spi->controller_data = (void *)&mtk_default_chip_info;
 
-	if (mdata->dev_comp->need_pad_sel && gpio_is_valid(spi->cs_gpio))
-		gpio_direction_output(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
+	if (mdata->dev_comp->need_pad_sel && spi->cs_gpiod)
+		/* CS de-asserted, gpiolib will handle inversion */
+		gpiod_direction_output(spi->cs_gpiod, 0);
 
 	return 0;
 }
@@ -730,6 +731,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	master->can_dma = mtk_spi_can_dma;
 	master->setup = mtk_spi_setup;
 	master->set_cs_timing = mtk_spi_set_hw_cs_timing;
+	master->use_gpio_descriptors = true;
 
 	of_id = of_match_node(mtk_spi_of_match, pdev->dev.of_node);
 	if (!of_id) {
@@ -853,25 +855,12 @@ static int mtk_spi_probe(struct platform_device *pdev)
 			goto err_disable_runtime_pm;
 		}
 
-		if (!master->cs_gpios && master->num_chipselect > 1) {
+		if (!master->cs_gpiods && master->num_chipselect > 1) {
 			dev_err(&pdev->dev,
 				"cs_gpios not specified and num_chipselect > 1\n");
 			ret = -EINVAL;
 			goto err_disable_runtime_pm;
 		}
-
-		if (master->cs_gpios) {
-			for (i = 0; i < master->num_chipselect; i++) {
-				ret = devm_gpio_request(&pdev->dev,
-							master->cs_gpios[i],
-							dev_name(&pdev->dev));
-				if (ret) {
-					dev_err(&pdev->dev,
-						"can't get CS GPIO %i\n", i);
-					goto err_disable_runtime_pm;
-				}
-			}
-		}
 	}
 
 	if (mdata->dev_comp->dma_ext)
-- 
2.34.1

