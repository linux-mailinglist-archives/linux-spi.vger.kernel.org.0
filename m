Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB4E4A54AD
	for <lists+linux-spi@lfdr.de>; Tue,  1 Feb 2022 02:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbiBABcD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 Jan 2022 20:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbiBABcD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 Jan 2022 20:32:03 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2987DC061714
        for <linux-spi@vger.kernel.org>; Mon, 31 Jan 2022 17:32:03 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id c15so21903849ljf.11
        for <linux-spi@vger.kernel.org>; Mon, 31 Jan 2022 17:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hB5+07B9r7ynBxXv08t8CIjFrncWFwL+cy3uuvNxdtU=;
        b=D6ka4taBV6LNMbixPE6fPPzNrzjO4941FZLP0zJMqv/J2Z9XpJbqIThjJcafAq2n3x
         7arCzdKpfMPcubmXypaqRnaQTBvQuQGVogFG00MQj/njBaOO86RkAuuBQgGJN+6yKF1a
         Z1hiYlaN7AI2cAIoJKBA+1EyKbklDHTMTCNIsk6nb9bPDdpf7KR5HxgOMSINN+LuYzL6
         fml07Cw2GQRdABUgp+h/YUdAn6GJIUryc445KBWA9hYesYQDXpMIfXXPPH8J2gAfdF8O
         3qZiUQV44fbXcAOoC1wKw72UtpoBt/juWv9+xrApaUEI8s4v/6P5+65u8tFxCvB93LwQ
         e8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hB5+07B9r7ynBxXv08t8CIjFrncWFwL+cy3uuvNxdtU=;
        b=k0odFVb3xRfZLTO/vtTQcN3mVoMYEmfzw7oo+q0pdpDu4BNl8TcE6MMCGcKkvJYWvv
         MzYjT3TGn6dn2osUDULEQamw+DQrGzptG2glKgkRPybYtrIZpat03VwbMVtc3StetWCb
         UHoW+nRYGTqlLQOKeC1R42WuDrgfhYtE2p4daWfsd2i079pjCSWKbT1CJyw7w/fwVAB1
         uaZyS5gCqmCglAHQ5uU6u3qcPdwtJNcpcHMlEGEyuY+/w45ao56iduziJ5MXMkVPQmS0
         pTyBdBzKCG0m/lMs/uFarb5RUXUQpeg8iLabXLhQFCBjQix7SWbJe8tZ5rmwUyGqpeS+
         Iipw==
X-Gm-Message-State: AOAM533sfKotqydsJX+0gKKgjD8E61TLeXrIq/dShG8KjuprcXWRFURA
        CP+bRuvaYMeKYzVgBzmSKNC94w==
X-Google-Smtp-Source: ABdhPJzMgtC+9ILan039mTUXtCSn4RtiKpiX3kZ2j9QF/JVmnSNhXAnD0CPy3gP8o2kkxA+JZY0Vnw==
X-Received: by 2002:a05:651c:3c7:: with SMTP id f7mr10601142ljp.62.1643679121433;
        Mon, 31 Jan 2022 17:32:01 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id bq32sm3138148lfb.142.2022.01.31.17.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 17:32:00 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lukas Wunner <lukas@wunner.de>,
        Martin Sperl <kernel@martin.sperl.org>
Subject: [PATCH v2] spi: bcm2835aux: Convert to use GPIO descriptors
Date:   Tue,  1 Feb 2022 02:29:56 +0100
Message-Id: <20220201012956.563272-1-linus.walleij@linaro.org>
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
ChangeLog v1->v2:
- Drop an unused "ret" variable that was causing build
  noise.
---
 drivers/spi/spi-bcm2835aux.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 7d709a8c833b..e28521922330 100644
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
@@ -445,25 +444,12 @@ static void bcm2835aux_spi_handle_err(struct spi_master *master,
 
 static int bcm2835aux_spi_setup(struct spi_device *spi)
 {
-	int ret;
-
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
@@ -519,6 +505,7 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 	master->prepare_message = bcm2835aux_spi_prepare_message;
 	master->unprepare_message = bcm2835aux_spi_unprepare_message;
 	master->dev.of_node = pdev->dev.of_node;
+	master->use_gpio_descriptors = true;
 
 	bs = spi_master_get_devdata(master);
 
-- 
2.34.1

