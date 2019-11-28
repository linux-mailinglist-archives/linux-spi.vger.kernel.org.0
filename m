Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3B2A10C53C
	for <lists+linux-spi@lfdr.de>; Thu, 28 Nov 2019 09:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfK1Ih0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Nov 2019 03:37:26 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40364 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfK1Ih0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 Nov 2019 03:37:26 -0500
Received: by mail-lf1-f65.google.com with SMTP id y5so6677893lfy.7
        for <linux-spi@vger.kernel.org>; Thu, 28 Nov 2019 00:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AmIR0r6i3Cg87MCPZcep6uMU0wYHv+UUy3ZU/fWShBQ=;
        b=wrwkh5yd8tU1bsHg+6YhL29svZTmdA/hnLqviWH42bjsRzB4AGo4buiTb5jqGSf/wa
         J47Lz8cq1AjuKvD/717Td0LSGeEuvDAGqLOs7gfe7wT2H6/dfKdPBxJFaA5Vxd8X1hVh
         hVhAlpaDz48FrFQDSl1vdQm6hDA9snXF5ApLMCB7NFTIpvgR7Pu/te0xL+WWjvhth6LL
         uwh5Yd3Ie5fxgWe87XNVapiZvBMHOTq3rKcsmO6FUKBmUnXivDOPPrQjXtvOUNjsXlDu
         FJ2wrkMMyOTXIiKfahUiobzvc/dk+lb34ET/4gxwP7eOEUhl1sMQ1jNhC2wPdUZ6PHZE
         HNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AmIR0r6i3Cg87MCPZcep6uMU0wYHv+UUy3ZU/fWShBQ=;
        b=iI3KLUelmB3fT5N5LsBJSZu0trGdRI/c9faI8GL9KIsEVxAuWFpu17KrKxW8uE0yWG
         Yatti1rRvJAk2s+EYDlxZmYINNgUKoDtkHaMIgyo3aJiFitzzV78N/OcSZ5/fmMTK3th
         HQ5yRYA0T6s3O5wu1D61j9GPaFAIqegfSR1LkCFYrQm3SrXgABYgkMX3k+Fwwt6Of2gs
         KDVZe0Fjw47Pjwja3qJG+5ATliB2I3MLyEujPNJ0V/bDXFugTdUkopNa8skipKDCfckC
         Wz1loRFYJ+66/0DzjzhDDAApK3MkiBsEa7dFErnxpxj9BB77soyhYM7OIxeS3JqZnLOJ
         BM/A==
X-Gm-Message-State: APjAAAVL5Rug8Oxx9BSq+C8LE/AxaDczVcbDAToco9B7tD7PyHjQpcB+
        +gl7EbA9xsSBnlK4dDDilMMhYw==
X-Google-Smtp-Source: APXvYqzoims5h4zuPb/cbgkP0a1bfJcXC0Loxx5aTIbp0eauJyAZQi98q8p2BkwFpIT7xPD3kfdwzg==
X-Received: by 2002:ac2:5b0f:: with SMTP id v15mr20076728lfn.99.1574930244455;
        Thu, 28 Nov 2019 00:37:24 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id x193sm3384013lfa.78.2019.11.28.00.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 00:37:23 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 2/3 v3] gpio: Handle counting of Freescale chipselects
Date:   Thu, 28 Nov 2019 09:37:17 +0100
Message-Id: <20191128083718.39177-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128083718.39177-1-linus.walleij@linaro.org>
References: <20191128083718.39177-1-linus.walleij@linaro.org>
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
ChangeLog v2->v3:
- Fixed the bug (I hope) as I was counting the number
  of gpios by checking for "gpios-gpios" and "gpios-gpio"
  rather than "gpios" (ehm...)
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
index 80ea49f570f4..43ffec3a6fbb 100644
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
+	return of_gpio_named_count(np, "gpios");
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

