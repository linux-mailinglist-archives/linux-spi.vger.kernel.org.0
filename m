Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 191DE10ACB6
	for <lists+linux-spi@lfdr.de>; Wed, 27 Nov 2019 10:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfK0Jkg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Nov 2019 04:40:36 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:47009 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfK0Jkg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Nov 2019 04:40:36 -0500
Received: by mail-lj1-f196.google.com with SMTP id e9so23658438ljp.13
        for <linux-spi@vger.kernel.org>; Wed, 27 Nov 2019 01:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tTTAEtE2wY2oHf3GzlilCh9PFVO17TbKK86LOFQY+Tg=;
        b=DwspxD201GISdJxtKpeY095XpU/OxDzpuRhcAMD4PpBigTrf+zdm4OPdSrXic24WN7
         vtPt4t1lI1jtgNTrEoZXHDG7PUmYLcMAYjvidvv4OlPyDgAS+WNGwpey25vPCFReOSHo
         8nMP8oHewjA44h90zZr1WPaN6kjqrDYtJUV0ig06qoxKDZt1PUBsxFE3Uv/Kt055h7Ss
         WlSRQLmaQC1h/duTt80IHm21/inDAwoKBAWBocC7LxSACuV9yoU1Ci7E8aIUi/Z3mYaz
         fV4f/vy4rIVtV3mVFit8Kj5FgsItbUQlTYAvypltBIHyhaRWaVBhgAC+NhsC3rXdzmhF
         nkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tTTAEtE2wY2oHf3GzlilCh9PFVO17TbKK86LOFQY+Tg=;
        b=IOTAjCVjMJqTYldeAv4iPjI1VRXgGv6R6IW7zQKQagyaAGSCo+VZKeEaI5PED+smbE
         02S8fiucGoKWMQ3ZOrLFjaGsS2rM5BY0F7lghRhABINEuTDObFQuMVQa6pKmhbQVqu9V
         9fnhT34QMSJjLVGpuUdf+YIcxnkDfv+QhTwCDU9v/UHN5whEIWD8RGH4wYctBuDlwx/a
         NDxo23/xjKS27Lch/2G11xx6sw8WY8BQAlDk/vHFUDvlBDYEiD7Vi064eNpQRDTRJ6Ir
         1NXgs577C6xH+QNa4pxwZP+jmaWaQBBCcIXGwk/yZTRJQ/ShIwjVc+14+U1+3O6MSX7Y
         o2pw==
X-Gm-Message-State: APjAAAWRq/jsF8ijJkzZ17dyXIZ/0FRreMFYMsCgkWR0Gm2fiJG/hkMG
        0U0wHAaGMZ4NmyP63fx7O4Ah6g==
X-Google-Smtp-Source: APXvYqxosKwpUMt3hX0x/XeOctftbPj2OiJyjGIY1AeUTw6YZPzPVuJtWz4lSZtWXrD12Fl5Ce12Ww==
X-Received: by 2002:a2e:3a15:: with SMTP id h21mr30205923lja.256.1574847634086;
        Wed, 27 Nov 2019 01:40:34 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id z20sm7007682ljj.85.2019.11.27.01.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 01:40:33 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] gpio: Handle counting of Freescale chipselects
Date:   Wed, 27 Nov 2019 10:40:31 +0100
Message-Id: <20191127094031.140736-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.23.0
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
Mark: I will merge this through the GPIO tree if
it fixes the problem.
---
 drivers/gpio/gpiolib-of.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 80ea49f570f4..33e16fa17bd8 100644
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
+	if (strcmp(con_id, "cs"))
+		return 0;
+	if (!of_device_is_compatible(np, "fsl,spi") &&
+	    !of_device_is_compatible(np, "aeroflexgaisler,spictrl"))
+		return 0;
+	return of_gpio_get_count(dev, NULL);
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

