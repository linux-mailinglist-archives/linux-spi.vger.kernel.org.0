Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A5F4967F2
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jan 2022 23:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiAUWnc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Jan 2022 17:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiAUWnc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Jan 2022 17:43:32 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D017FC06173B
        for <linux-spi@vger.kernel.org>; Fri, 21 Jan 2022 14:43:31 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id a28so6614705lfl.7
        for <linux-spi@vger.kernel.org>; Fri, 21 Jan 2022 14:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/qCdmK9xD3uQH9zkCKfN+SiEDJjVMDSPCdTFLlRdNFQ=;
        b=zToSlTXmHM32C8W3M+B9mCtB/QyBf+3/QEyOn3iXr5tcugjOHgZL0Im1nkm07C7XBp
         q/GipdxD4Zj/PXw9OCuFOCioXTN9xG6L6qA60dFeuhkhqhJlobIpLeahyIMeJsJ72VcZ
         99nuEyYVEgvrgw7RMMbAzofM7oCBZXAHSbZF/2KsQ4GaRlTbNeLJVFiM/7ArQOf77nFp
         VK6PudBPKaw+gZp36tljbOT2wEOJ52W++dYOpcPuq97L0d/2gL6tH+ZfcxyOg8lE+J8o
         lnDu99jGk7REjvcZgyQfbD134QXskNBD4ORiO85vu49x68llIvZuSelV6cOJler9JbZ9
         569w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/qCdmK9xD3uQH9zkCKfN+SiEDJjVMDSPCdTFLlRdNFQ=;
        b=48CGO3THC7zb5mYnU93Kh8IKhK3t5wctc9az8FSyWAECeJJdR6XiDeH+s2hDAVmNzu
         f+xaN1UMCV0s0He+s1Px4wn/exqzCzpMTcTRzTj3yDEg0Fv7F4UArw/geOxknc9ke1Aa
         JM7nB8nmf+iRsry8ddJQCbr7nLWTYYflt5+ZuTd+6zGjqUT1IF3eGy5cIz0w3clxOQsm
         2WsQ+W4M+wD7oiivsoLiY/1hYqCaW4SxzDUeX62b4YqYXCZNWa33gkOi0CsPwYFPcKJS
         s7yFK2/wK5h6RArOC+PT8sZyVKO88FLqg1umrYa3SYka2sOyCwOb0pUOQdES0ver1pSL
         a0Lw==
X-Gm-Message-State: AOAM530Rav7c2ZetADtxylfmYm8nvtxUOb8/XuEWa45j9FFw6qYKHWQG
        nb5booR9Gnvfbixq1a47lik6bJz9Uumxiw==
X-Google-Smtp-Source: ABdhPJxH3nsBlvwHaCq2TYXSeX/2ttqM84xWeIDvZ8LHmdC5+WsldhXwS19DD58TgswjFQb7M0/fHw==
X-Received: by 2002:a05:6512:20ca:: with SMTP id u10mr5095790lfr.71.1642805010123;
        Fri, 21 Jan 2022 14:43:30 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id s16sm381195lfr.300.2022.01.21.14.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 14:43:29 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lukas Wunner <lukas@wunner.de>,
        Martin Sperl <kernel@martin.sperl.org>
Subject: [PATCH] spi: bcm2835aux: Convert to use GPIO descriptors
Date:   Fri, 21 Jan 2022 23:41:26 +0100
Message-Id: <20220121224126.312227-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This one is pretty straight forward to switch over, the driver
already relies on inspecting cs_gpio just check cs_gpiod instead
and stop the special handling of requesting the GPIO and stuff
the core will take care of.

Cc: Lukas Wunner <lukas@wunner.de>
Cc: Martin Sperl <kernel@martin.sperl.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-bcm2835aux.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 7d709a8c833b..af795700e31a 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -22,7 +22,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <linux/of_irq.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
@@ -450,20 +449,9 @@ static int bcm2835aux_spi_setup(struct spi_device *spi)
 	/* sanity check for native cs */
 	if (spi->mode & SPI_NO_CS)
 		return 0;
-	if (gpio_is_valid(spi->cs_gpio)) {
-		/* with gpio-cs set the GPIO to the correct level
-		 * and as output (in case the dt has the gpio not configured
-		 * as output but native cs)
-		 */
-		ret = gpio_direction_output(spi->cs_gpio,
-					    (spi->mode & SPI_CS_HIGH) ? 0 : 1);
-		if (ret)
-			dev_err(&spi->dev,
-				"could not set gpio %i as output: %i\n",
-				spi->cs_gpio, ret);
-
-		return ret;
-	}
+
+	if (spi->cs_gpiod)
+		return 0;
 
 	/* for dt-backwards compatibility: only support native on CS0
 	 * known things not supported with broken native CS:
@@ -519,6 +507,7 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 	master->prepare_message = bcm2835aux_spi_prepare_message;
 	master->unprepare_message = bcm2835aux_spi_unprepare_message;
 	master->dev.of_node = pdev->dev.of_node;
+	master->use_gpio_descriptors = true;
 
 	bs = spi_master_get_devdata(master);
 
-- 
2.34.1

