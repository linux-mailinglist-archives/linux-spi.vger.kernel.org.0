Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19F99A7782
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2019 01:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfICXTA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Sep 2019 19:19:00 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41780 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfICXS7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Sep 2019 19:18:59 -0400
Received: by mail-pl1-f195.google.com with SMTP id m9so8640655pls.8;
        Tue, 03 Sep 2019 16:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hAmHof5HSYuYAUNCiL3ISHJlEemOn6yRBu9YZMQZqPc=;
        b=Bz1I0OTlqz2IoLpCYGYgb1LSAEBFeQi1RlyBJUQcPySBSoouYlGdoh4vmyb5BJgYLU
         6/3vw4RyGQgIBAQhjO0tLroffsJegDWjJ3gbKS4IqfpWic6gJFYCG5iSkEWlKqsOliBw
         xGrQ0qPsjrd5cQJ/6Pr8RyyQ3iQr2DFDVwD1GlIkDOW1VhOJMo6qasyGNrrJUH1n0k8V
         KYZm6QWXwl8xHb2Dqrqfsz7s2NOFHgO0u8VWYnp3KEY1vwZOjt4207zx1gIEaOKUCJ7u
         qaoE5YJWM43R4frGNRZQjhqO1FCWdUyfJD4ky27ZAPJyMX4nBFkwQTHo6wpezFqpwdfD
         DSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hAmHof5HSYuYAUNCiL3ISHJlEemOn6yRBu9YZMQZqPc=;
        b=pu90uH54CliPNFGV96/gHX39MEmUEJVVN+EziUhZTilQgfUyB9jtYwdlXZqpXqjZjm
         NQR9pfzOgCBIHpbP7Kpo9CnDkz+xFhLcz05e5YxfMf2lyEke0YTjUncrOUYS/wLajDQ8
         qClXyWMToN25xagfTBnuE5rS0wLQ6tc1zZiE2KiP4qJKg4KbxgvZSCK3xpY9/RxA0RDm
         N+rfP+nvfPG1qWGBpkTYx0urF3n4nuQv3QnreOtG2NrQLbfUKuS9Y3484SJq2lPjczuW
         uY6SINI+JRF/WbMCF9cJ6XOCvYC2LGFm1emvMtlcca4Vc+GI1nybR2K2OYz/F3AQlOYV
         xc1Q==
X-Gm-Message-State: APjAAAWB0O2rUqJ57PA9Wg1Bx3pK8O+I0UU7zMjTn84u51AeyQSXiScu
        IGGLRvbop8rXeQoe2kNCN04=
X-Google-Smtp-Source: APXvYqze4lacj4Iix2KiSq3/g6RLQ/Q4EuaBlhKRfCw7Dt/xtfK8GI1PVrQ2rKRgfIRsPRjy4caUXw==
X-Received: by 2002:a17:902:5a1:: with SMTP id f30mr38620237plf.64.1567552738880;
        Tue, 03 Sep 2019 16:18:58 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id z12sm20840701pfg.21.2019.09.03.16.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 16:18:58 -0700 (PDT)
Date:   Tue, 3 Sep 2019 16:18:56 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gpiolib: of: fix fallback quirks handling
Message-ID: <20190903231856.GA165165@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

We should only try to execute fallback quirks handling when previous
call returned -ENOENT, and not when we did not get -EPROBE_DEFER.
The other errors should be treated as hard errors: we did find the GPIO
description, but for some reason we failed to handle it properly.

The fallbacks should only be executed when previous handlers returned
-ENOENT, which means the mapping/description was not found.

Also let's remove the explicit deferral handling when iterating through
GPIO suffixes: it is not needed anymore as we will not be calling
fallbacks for anything but -ENOENT.

Fixes: df451f83e1fc ("gpio: of: fix Freescale SPI CS quirk handling")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index b034abe59f28..b45b39c48a34 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -457,36 +457,27 @@ struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
 
 		desc = of_get_named_gpiod_flags(dev->of_node, prop_name, idx,
 						&of_flags);
-		/*
-		 * -EPROBE_DEFER in our case means that we found a
-		 * valid GPIO property, but no controller has been
-		 * registered so far.
-		 *
-		 * This means we don't need to look any further for
-		 * alternate name conventions, and we should really
-		 * preserve the return code for our user to be able to
-		 * retry probing later.
-		 */
-		if (IS_ERR(desc) && PTR_ERR(desc) == -EPROBE_DEFER)
-			return desc;
 
-		if (!IS_ERR(desc) || (PTR_ERR(desc) != -ENOENT))
+		if (!IS_ERR(desc) || PTR_ERR(desc) != -ENOENT)
 			break;
 	}
 
-	/* Special handling for SPI GPIOs if used */
-	if (IS_ERR(desc))
+	if (IS_ERR(desc) && PTR_ERR(desc) == -ENOENT) {
+		/* Special handling for SPI GPIOs if used */
 		desc = of_find_spi_gpio(dev, con_id, &of_flags);
-	if (IS_ERR(desc) && PTR_ERR(desc) != -EPROBE_DEFER) {
+	}
+
+	if (IS_ERR(desc) && PTR_ERR(desc) == -ENOENT) {
 		/* This quirk looks up flags and all */
 		desc = of_find_spi_cs_gpio(dev, con_id, idx, flags);
 		if (!IS_ERR(desc))
 			return desc;
 	}
 
-	/* Special handling for regulator GPIOs if used */
-	if (IS_ERR(desc) && PTR_ERR(desc) != -EPROBE_DEFER)
+	if (IS_ERR(desc) && PTR_ERR(desc) == -ENOENT) {
+		/* Special handling for regulator GPIOs if used */
 		desc = of_find_regulator_gpio(dev, con_id, &of_flags);
+	}
 
 	if (IS_ERR(desc))
 		return desc;
-- 
2.23.0.187.g17f5b7556c-goog


-- 
Dmitry
