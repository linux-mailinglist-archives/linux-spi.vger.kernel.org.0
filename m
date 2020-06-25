Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564FD20A6B8
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jun 2020 22:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407111AbgFYUV4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 25 Jun 2020 16:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405161AbgFYUVz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 25 Jun 2020 16:21:55 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4BEC08C5C1
        for <linux-spi@vger.kernel.org>; Thu, 25 Jun 2020 13:21:55 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id n24so7941142lji.10
        for <linux-spi@vger.kernel.org>; Thu, 25 Jun 2020 13:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xYgswlYnh711UyVZ0F4dAhoCaz6CsidBkei96d/K4MY=;
        b=Xs1T3V8sGiwF/LlWGTFa85fTIiVpqO9E3ymJ1M3v0oep/zoSkNYbzrMAqbWpdzLtEE
         jCliXdurNvqbWyOsmhmk4RBSu6oIEEFLh4pk/K/+rgrn6Rh5jS71KUTabYriiyrey6Ke
         gtVqMZ9LINSrCoUG4aoGjYPWoUDmkdgnU7b0rAUdz0R+bwOkCWDz0603+Q3c859Rg//H
         dYcuqexJUpeE4XqYWQwMDXD35zpcgUW8NpofGlhq2ZRYe3CLxNOmfJWNieGjWmu3mxVD
         e5ZwyXOzrtgJzXfmAqZmQECRGeQhqET9z5MnfYp6vku9/o5Y3ofo6KVoXjXWtNDWUesn
         ogQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xYgswlYnh711UyVZ0F4dAhoCaz6CsidBkei96d/K4MY=;
        b=UMzFrJIaW072tzgX1XB2a8oe3/kqdfroo9St6BTXD8J/plvLLW/bwmWBYhy/tQT8n7
         rYL8Dsl2/J2njZUXIfO1UeRCoE2is9kUQEmZZMSbC5FrzhrfojQzbgK8pQk9k2E2m/eC
         2DYVqpknRqecDnZdapDzuVgR+yqYwh6UgSBmnNc6KyPb4qCTKDXx6mP1lhOP9v/NH35L
         eTO0AkyWR75PrGl8S9dWe0Z9FBNd0QEiIcHdGQB9bN+XLqNw8zjexNVNYEPielw3TR2R
         JikUPA5dawibducWqzLMwIlAl3F98r/kTg7lwQMVfITCIvLQEsrfQXnZBLaQ20H7G4LT
         mptg==
X-Gm-Message-State: AOAM531hRPDjvw0cXkT8qZSfEctUyM+jaDDXH5IOMmLWcJ/BmLZEgqgv
        NS+3KWgBzdXZliYOLC7OFIcnu5N4+Gk=
X-Google-Smtp-Source: ABdhPJxzUBcc5U65DzzYzxSw5czXlisxCdJT1UK8vKEYpjvV5U1AFgRNXLmxV4G/lfC0ffqAwWMSvA==
X-Received: by 2002:a2e:3808:: with SMTP id f8mr17390178lja.165.1593116513249;
        Thu, 25 Jun 2020 13:21:53 -0700 (PDT)
Received: from genomnajs.lan (c-d63ee155.152980-0-69706f6e6c79.bbcust.telenor.se. [85.225.62.214])
        by smtp.gmail.com with ESMTPSA id t16sm4916822ljo.22.2020.06.25.13.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 13:21:52 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] spi: lantiq-ssc: Convert to use GPIO descriptors
Date:   Thu, 25 Jun 2020 22:21:49 +0200
Message-Id: <20200625202149.209276-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This switches the Lantiq SSC driver over to use GPIO descriptor
handling in the core.

The driver was already utilizing the core to look up and request
GPIOs from the device tree so this is a pretty small change
just switching it over to use descriptors directly instead.

Cc: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-lantiq-ssc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-lantiq-ssc.c b/drivers/spi/spi-lantiq-ssc.c
index 1fd7ee53d451..1cf650e25e31 100644
--- a/drivers/spi/spi-lantiq-ssc.c
+++ b/drivers/spi/spi-lantiq-ssc.c
@@ -15,7 +15,6 @@
 #include <linux/completion.h>
 #include <linux/spinlock.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
 
@@ -391,7 +390,7 @@ static int lantiq_ssc_setup(struct spi_device *spidev)
 	u32 gpocon;
 
 	/* GPIOs are used for CS */
-	if (gpio_is_valid(spidev->cs_gpio))
+	if (spidev->cs_gpiod)
 		return 0;
 
 	dev_dbg(spi->dev, "using internal chipselect %u\n", cs);
@@ -888,6 +887,7 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 
 	master->dev.of_node = pdev->dev.of_node;
 	master->num_chipselect = num_cs;
+	master->use_gpio_descriptors = true;
 	master->setup = lantiq_ssc_setup;
 	master->set_cs = lantiq_ssc_set_cs;
 	master->handle_err = lantiq_ssc_handle_err;
-- 
2.25.4

