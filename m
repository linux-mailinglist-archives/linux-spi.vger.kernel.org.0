Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 776D810B0A8
	for <lists+linux-spi@lfdr.de>; Wed, 27 Nov 2019 14:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfK0NyZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Nov 2019 08:54:25 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35663 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfK0NyZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Nov 2019 08:54:25 -0500
Received: by mail-lj1-f193.google.com with SMTP id j6so15571638lja.2
        for <linux-spi@vger.kernel.org>; Wed, 27 Nov 2019 05:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ze5hvXCplepJyWjwgkySScV2FO5TtWlZUcDiUJMYMsA=;
        b=ZCGKYWsiinnFBhR/ovPRoqpJ/8qXeVhMLeaVJqOoLLtY27y18Jgl9k7T/cKKtZMB4a
         VrbOK7iw0tueIbg5MRQAWVKXQEHoc/CofCoQmbIRpV9+oI09ZpN/zddGl/kCYDF4R7hG
         JxYdioLqxcYKl2UxjQrDA41oSTHVobiWPAHokFH3/ARoiRk6fdfsO0mcT87r0dVKcKyT
         r6S03KPMvdgLhfFOC3Dp66wvZJOeKhsNycoN6YEpKMxKKDqnoe8Hw5uS81bTr1hhN6SH
         hSpvUqo6o0aWplpDR2yzWKEQQkigJUXULDvnl2YxMhxF6nslImbWIawkYG4bL2snPPod
         ql9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ze5hvXCplepJyWjwgkySScV2FO5TtWlZUcDiUJMYMsA=;
        b=UEV7AdppGJOueGJkxvbQmg4yYYDkWOCBVxEcb79BqUDLpt6xnm/at9zeyj2dJkTwI3
         F3QWneCNOnDKfl2g/cJArAXZ1MGEL0vpVwAD0T5xzEvcGdjEWqHw1iOP1NYux0MMq5De
         Kyy1i/BaqDPLhh6HBo9PYE5t02y/+wBlAioTjFe9DffAcxyZMl8xW+XI3ZrK5B8j3T4d
         YSQIUsIPeGOCFbMVS+ARVj7VGZwG1E/NXhjE6Y9ffa2mYxgswzE3WOfKtxrz8jmhGHXG
         WFkRSYeaTM7u3EuyF7PYjMV3JQEwi98WGOTnEf2enRvAdc1gImMofaAZHvwTK0Xp7J0U
         ptag==
X-Gm-Message-State: APjAAAVoIB4/ITfcI3dIHhu9IXz0JLECFpPZ4j0zDXP0DhzPjch0RZ4Y
        q3L65K8Lda+uXcosLsVsG98C4w==
X-Google-Smtp-Source: APXvYqy5G9Qe61FwrBDY81vBK9yvLEcm322VcPBc8TfK5f0dS83aglr8v/6o8ZgLLooHFAe6c2T7BQ==
X-Received: by 2002:a2e:2201:: with SMTP id i1mr17841502lji.110.1574862862903;
        Wed, 27 Nov 2019 05:54:22 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id j18sm2343561lfh.6.2019.11.27.05.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 05:54:21 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 2/3 v2] gpio: Handle counting of Freescale chipselects
Date:   Wed, 27 Nov 2019 14:54:09 +0100
Message-Id: <20191127135410.156430-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191127135410.156430-1-linus.walleij@linaro.org>
References: <20191127135410.156430-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

We have a special quirk to handle the Freescale
nonstandard SPI chipselect GPIOs in the gpiolib-of.c
file, but it currently only handles the case where
the GPIOs are actually requested (gpiod_*get()).

We also need to handle that the SPI core attempts
to count the GPIOs before use, and that needs a
similar quirk in the OF part of the library.

Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
Fixes: 0f0581b24bd0 ("spi: fsl: Convert to use CS GPIO descriptors")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Hardcode the quirk to look for "gpios" as this is all
  we support and else the call would just recurse back
  and fail again.
- Provide a proper NULL check so we don't upset strcmp().

Mark: I change my mind, better to keep the patches
together, once Christophe has it working with my
patch stack let's just merge all of it.
---
 drivers/gpio/gpiolib-of.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 80ea49f570f4..ae8b296160bf 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -23,6 +23,29 @@
 #include "gpiolib.h"
 #include "gpiolib-of.h"
 
+/**
+ * of_gpio_spi_cs_get_count() - special GPIO counting for SPI
+ * Some elder GPIO controllers need special quirks. Currently we handle
+ * the Freescale GPIO controller with bindings that doesn't use the
+ * established "cs-gpios" for chip selects but instead rely on
+ * "gpios" for the chip select lines. If we detect this, we redirect
+ * the counting of "cs-gpios" to count "gpios" transparent to the
+ * driver.
+ */
+int of_gpio_spi_cs_get_count(struct device *dev, const char *con_id)
+{
+	struct device_node *np = dev->of_node;
+
+	if (!IS_ENABLED(CONFIG_SPI_MASTER))
+		return 0;
+	if (!con_id || strcmp(con_id, "cs"))
+		return 0;
+	if (!of_device_is_compatible(np, "fsl,spi") &&
+	    !of_device_is_compatible(np, "aeroflexgaisler,spictrl"))
+		return 0;
+	return of_gpio_get_count(dev, "gpios");
+}
+
 /*
  * This is used by external users of of_gpio_count() from <linux/of_gpio.h>
  *
@@ -35,6 +58,10 @@ int of_gpio_get_count(struct device *dev, const char *con_id)
 	char propname[32];
 	unsigned int i;
 
+	ret = of_gpio_spi_cs_get_count(dev, con_id);
+	if (ret > 0)
+		return ret;
+
 	for (i = 0; i < ARRAY_SIZE(gpio_suffixes); i++) {
 		if (con_id)
 			snprintf(propname, sizeof(propname), "%s-%s",
-- 
2.23.0

