Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3034968E6
	for <lists+linux-spi@lfdr.de>; Sat, 22 Jan 2022 01:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiAVAux (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Jan 2022 19:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiAVAuw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Jan 2022 19:50:52 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C076C06173B
        for <linux-spi@vger.kernel.org>; Fri, 21 Jan 2022 16:50:51 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id k7so2535756lji.7
        for <linux-spi@vger.kernel.org>; Fri, 21 Jan 2022 16:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HGpUF12jdfhtE2Axmf64xifJBTmaB3b/GxoI4KJDpi4=;
        b=YVoDNv9wkJsBaKp68HNIjtvd/tPjXT1H9k3doDzZLtLIpqFK0z+UpRn0/eOFCtFjU9
         KctjKw1Cis713iqrb5fPKVupJgRqnYOIDZbSGvKnIfet5ydxeDnrCTvjEpT2rNcNMvQK
         Ie5HrTOSDfgKQBvi91xVI/iWY8XWykBggKZUqskdQ5oRYjHdB2eUGpwTezcqd271kZSf
         byQgId9jsfXjMjdGRr6R3BvQhBPRiE2i1FYT0yTrRH2gDUtRBFDjTG9tzu7gW6Y4Dzvx
         FoA/Ubf7CljyzrGK1LrTYZXnjL27GMpvd/4fXCYx0FkC2A/hJf25VfMOmS0BCWtcCiCZ
         tfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HGpUF12jdfhtE2Axmf64xifJBTmaB3b/GxoI4KJDpi4=;
        b=7bQaWvZ9St2UqEac9kD/cCaP5Hi7jDp0gLz55cZjHfVS0/J+pys0SS3LCxjEYISZzl
         lCIBw18DY6BW8+EjyZLXTpdMotALGw3NV3+tUtc4VW9ModPUfK63Czra6ESZbETJawCf
         kTtgmwE2GQJ8gdmYr5hTJ0lAuyHvwfLvEAL90z+6GH3UioXy+cDuHOfbp8o9F6jpGAop
         3j2plngTTytXSKLFRY4ph8dFSZld52e0Fqkbb6Smhp0uKBuka1PRbKX3igWq5gOYonoO
         XyvD70PR9NmpFjqX3rq1LTOPWwXo0yJlxQqdOSLd9JOb8AlF16l2gYpvo+ecfDbHuOve
         3k/Q==
X-Gm-Message-State: AOAM532lDA6AwNcGz8rkwlOVq9B24D7+tkjjN0/6arsYSM+DMolmbXMF
        RZvLuDyvSoSienu5FyfJQRZ5jhtRrHF7mA==
X-Google-Smtp-Source: ABdhPJwKqaEGoQsONMpGd67gKBbQq1sPNHuWnMX7W5YJVROk5xhjIHJULwds6nLv1oFB14B22HteOA==
X-Received: by 2002:a2e:874f:: with SMTP id q15mr4819926ljj.137.1642812649576;
        Fri, 21 Jan 2022 16:50:49 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id y23sm306906ljy.127.2022.01.21.16.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 16:50:49 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Purna Chandra Mandal <purna.mandal@microchip.com>
Subject: [PATCH] spi: pic32: Convert to use GPIO descriptors
Date:   Sat, 22 Jan 2022 01:48:46 +0100
Message-Id: <20220122004846.374930-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The driver already relies on the core looking up GPIO lines
from the core, so this is trivial to switch over to using
GPIO descriptors.

Cc: Purna Chandra Mandal <purna.mandal@microchip.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-pic32.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index f86433b29260..7e5c09a7d489 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -591,18 +591,16 @@ static int pic32_spi_setup(struct spi_device *spi)
 	 * unreliable/erroneous SPI transactions.
 	 * To avoid that we will always handle /CS by toggling GPIO.
 	 */
-	if (!gpio_is_valid(spi->cs_gpio))
+	if (!spi->cs_gpiod)
 		return -EINVAL;
 
-	gpio_direction_output(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
-
 	return 0;
 }
 
 static void pic32_spi_cleanup(struct spi_device *spi)
 {
-	/* de-activate cs-gpio */
-	gpio_direction_output(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
+	/* de-activate cs-gpio, gpiolib will handle inversion */
+	gpiod_direction_output(spi->cs_gpiod, 0);
 }
 
 static int pic32_spi_dma_prep(struct pic32_spi *pic32s, struct device *dev)
@@ -784,6 +782,7 @@ static int pic32_spi_probe(struct platform_device *pdev)
 	master->unprepare_message	= pic32_spi_unprepare_message;
 	master->prepare_transfer_hardware	= pic32_spi_prepare_hardware;
 	master->unprepare_transfer_hardware	= pic32_spi_unprepare_hardware;
+	master->use_gpio_descriptors = true;
 
 	/* optional DMA support */
 	ret = pic32_spi_dma_prep(pic32s, &pdev->dev);
-- 
2.34.1

