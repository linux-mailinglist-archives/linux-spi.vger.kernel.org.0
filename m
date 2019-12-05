Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1012C113D2E
	for <lists+linux-spi@lfdr.de>; Thu,  5 Dec 2019 09:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfLEIjY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Dec 2019 03:39:24 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40213 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfLEIjY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 5 Dec 2019 03:39:24 -0500
Received: by mail-lj1-f196.google.com with SMTP id s22so2536973ljs.7
        for <linux-spi@vger.kernel.org>; Thu, 05 Dec 2019 00:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dPHiHGXLMtKVJTTyfi/3YxEjRXA4p9wO3aFux+3B+/g=;
        b=uTQIIcF2OCM1e2YXyMsMVVJroHV4lOHDTBOb7sCpH3haeVpQM6/pxy4dQLoqKeKifH
         auSEHB+2woVLrd5QQuqyHLTcDmMenumq52ovvPDMJg5CzQ6dfD0jtDol8GMs/y3G18lb
         7XOcZX8qr1wgXzyoP0hTUiFkkxwK+tNdohOLN53v8ARArOEvWct7R80c5OTvWhvTiO0K
         HoUDCqOMDWqC/nBwNOj5E5S28JHze2bAqN6ELXsopVgJLc3RjwFpO+QH1k4SqzTc6av/
         xn9zqIFC4lCbn5SczvoCFzHZsuMVBNOwWqeErTHnSjaEWswPlbv48oxDfnX+3Uc0YBMc
         a8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dPHiHGXLMtKVJTTyfi/3YxEjRXA4p9wO3aFux+3B+/g=;
        b=AL0zb0UjpxAeL/l9zR4w5p8XYkMJqauJwKGGUY1VLbnf3rSya+howpNkLFXLXp+M1N
         gZ1PugDnNZkcaSbpKkdD7NNaeiOusoJmC3fPXBTwsnciBp71LT7bZCTxscp8/ZKdnS6F
         LJ3SpPcKVi2U8wXVIHfsXSB2S0UncAVnobPnCahHXLuDGPSRg/iHgRTQ1rffJyBkBWnx
         I+RQR1np+4Su0RWbM8uMSmu65MaMu+j+mXyL90S/ehagZ+L+ultXbDJkU7/aafHbxflQ
         RL5AwyHVRAKTLtEqnllq3l/nxhEAaEQ0meR9//Uw93tBq8DfswQSSIKw3F0coraMkpMn
         fd0A==
X-Gm-Message-State: APjAAAVl4eHROcp9N9OMalpioHD30ZKGVRdzf+b2avkJ/JQlH1MKQLaT
        z+7edtvIyzsus9B5Fiy3i4r4xw==
X-Google-Smtp-Source: APXvYqzqmPfCoJgn5CqGaRUTdA1Riz3Iu0wLCl24+vYd0ZLWMJ9Su50rVWsc5QiVq1JCS0dZGUWy1Q==
X-Received: by 2002:a2e:9a93:: with SMTP id p19mr4748927lji.158.1575535161997;
        Thu, 05 Dec 2019 00:39:21 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id c6sm4565532lfi.47.2019.12.05.00.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 00:39:20 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sunny Luo <sunny.luo@amlogic.com>
Subject: [PATCH] spi: meson-spicc: Use GPIO descriptors
Date:   Thu,  5 Dec 2019 09:39:15 +0100
Message-Id: <20191205083915.27650-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Instead of grabbing GPIOs using the legacy interface and
handling them in the setup callback, just let the core
grab and use the GPIOs using descriptors.

Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Sunny Luo <sunny.luo@amlogic.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-meson-spicc.c | 25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index f3f10443f9e2..7f5680fe2568 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -19,7 +19,6 @@
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/reset.h>
-#include <linux/gpio.h>
 
 /*
  * The Meson SPICC controller could support DMA based transfers, but is not
@@ -467,35 +466,14 @@ static int meson_spicc_unprepare_transfer(struct spi_master *master)
 
 static int meson_spicc_setup(struct spi_device *spi)
 {
-	int ret = 0;
-
 	if (!spi->controller_state)
 		spi->controller_state = spi_master_get_devdata(spi->master);
-	else if (gpio_is_valid(spi->cs_gpio))
-		goto out_gpio;
-	else if (spi->cs_gpio == -ENOENT)
-		return 0;
-
-	if (gpio_is_valid(spi->cs_gpio)) {
-		ret = gpio_request(spi->cs_gpio, dev_name(&spi->dev));
-		if (ret) {
-			dev_err(&spi->dev, "failed to request cs gpio\n");
-			return ret;
-		}
-	}
-
-out_gpio:
-	ret = gpio_direction_output(spi->cs_gpio,
-			!(spi->mode & SPI_CS_HIGH));
 
-	return ret;
+	return 0;
 }
 
 static void meson_spicc_cleanup(struct spi_device *spi)
 {
-	if (gpio_is_valid(spi->cs_gpio))
-		gpio_free(spi->cs_gpio);
-
 	spi->controller_state = NULL;
 }
 
@@ -564,6 +542,7 @@ static int meson_spicc_probe(struct platform_device *pdev)
 	master->prepare_message = meson_spicc_prepare_message;
 	master->unprepare_transfer_hardware = meson_spicc_unprepare_transfer;
 	master->transfer_one = meson_spicc_transfer_one;
+	master->use_gpio_descriptors = true;
 
 	/* Setup max rate according to the Meson GX datasheet */
 	if ((rate >> 2) > SPICC_MAX_FREQ)
-- 
2.23.0

