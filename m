Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4069B69D00
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jul 2019 22:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbfGOUp4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jul 2019 16:45:56 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46171 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729574AbfGOUp4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Jul 2019 16:45:56 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so17669702ljg.13
        for <linux-spi@vger.kernel.org>; Mon, 15 Jul 2019 13:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZYBOs3aLnhuf2faNdh8yo+pXx5Re8ii69AgHIOGgYXM=;
        b=xXQ84woWd6JtRurNXZ+LWho0SzsWefI+syk6IeKlgUlmeeUzs2BjNwuqUnKZRddNm8
         R/8MscBULhDQ1LucF1wVgpmPD8/8h5jeWM0nMeujOR+KiL/JYABHQvqO+DmUCKXmJd3W
         8NGP3HVRZDsy5/Q5qSkwGTa4n5cCwOH9BxJhC+D6ekrNFgmjbIGDlEAJvUlaDOrcCcBz
         0kuXdZAxbkGS4LgqZV6J3UWgk3Hy86LFvW+88jvM96vIadGu6OQ1SMHAOgV1VtEQDbCx
         /HIym52XN0QAkAKAwAcY4Jk1wKEAu2GCw956zXsOW8N4785cyOzUwmZLAh/IspxzWyv/
         vLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZYBOs3aLnhuf2faNdh8yo+pXx5Re8ii69AgHIOGgYXM=;
        b=P80NQLjN26A7uYR0xTERo5xWAEU7MAzSkFO1dFZmo3pUYSqJ05uG/U4olpgl/unfQG
         lxsZULFRV7+imryPjZ1i4VBV63la3emUfUQLzJ5p0Q0+AMbAZBAUeE0N5sszmMMqoojq
         qpmRwoaKF3gIGkCXb3ZmVc5gJpymM7g1+wk7K3lvbw2e0VqHI7OWP8uLQ6wQhE86ybV9
         jdwfUbDKgdAREV0es1e1BOhQLLS4K/PezPGz4VC+zHAkj7cDAly+5UaI+ZDkmAb97Xcg
         b5YeUITsDhzu/nmxEeVIxxtkr0QdOOX0IxCh80S/vkbnP04H3r0XdXwJ6uBpBkjFCsFf
         GNEQ==
X-Gm-Message-State: APjAAAV0yjSRmIBBILo2ppQdKSRBjxnOGWU+KbRQLE1YwVQRVtBPXg32
        DeTG0eJAil6Y0faOCYn7RCiZXA==
X-Google-Smtp-Source: APXvYqycBzyi6XjJyj5PoLiqzXEqn1fJu1mTyuzyCrEWAPx1KE6EEg0I/5C7kPkBB2DAM4DfT3Zgbg==
X-Received: by 2002:a2e:5b0f:: with SMTP id p15mr14682754ljb.82.1563223554303;
        Mon, 15 Jul 2019 13:45:54 -0700 (PDT)
Received: from localhost.bredbandsbolaget (c-22cd225c.014-348-6c756e10.bbcust.telenor.se. [92.34.205.34])
        by smtp.gmail.com with ESMTPSA id b1sm3338326ljj.26.2019.07.15.13.45.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 13:45:53 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-gpio@vger.kernel.org
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] Revert "gpio/spi: Fix spi-gpio regression on active high CS"
Date:   Mon, 15 Jul 2019 22:45:29 +0200
Message-Id: <20190715204529.9539-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This reverts commit fbbf145a0e0a0177e089c52275fbfa55763e7d1d.

It seems I was misguided in my fixup, which was working at the
time but did not work on the final v5.2.

The patch tried to avoid a quirk the gpiolib code not to treat
"spi-gpio" CS gpios "special" by enforcing them to be active
low, in the belief that since the "spi-gpio" driver was
parsing the device tree on its own, it did not care to inspect
the "spi-cs-high" attribute on the device nodes.

That's wrong. The SPI core was inspecting them inside the
of_spi_parse_dt() funtion and setting SPI_CS_HIGH on the
nodes, and the driver inspected this flag when driving the
line.

As of now, the core handles the GPIO and it will consistently
set the GPIO descriptor to 1 to enable CS, strictly requireing
the gpiolib to invert it. And the gpiolib should indeed
enforce active low on the CS line.

Device trees should of course put the right flag on the GPIO
handles, but it used to not matter. If we don't enforce active
low on "gpio-gpio" we may run into ABI backward compatibility
issues, so revert this.

Cc: linux-spi@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
I am sorry that this at one point fixed a problem for me, it
doesn't anymore and I don't know why it ever did. :(
---
 drivers/gpio/gpiolib-of.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index f974075ff00e..a8f02f551d6b 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -118,15 +118,8 @@ static void of_gpio_flags_quirks(struct device_node *np,
 	 * Legacy handling of SPI active high chip select. If we have a
 	 * property named "cs-gpios" we need to inspect the child node
 	 * to determine if the flags should have inverted semantics.
-	 *
-	 * This does not apply to an SPI device named "spi-gpio", because
-	 * these have traditionally obtained their own GPIOs by parsing
-	 * the device tree directly and did not respect any "spi-cs-high"
-	 * property on the SPI bus children.
 	 */
-	if (IS_ENABLED(CONFIG_SPI_MASTER) &&
-	    !strcmp(propname, "cs-gpios") &&
-	    !of_device_is_compatible(np, "spi-gpio") &&
+	if (IS_ENABLED(CONFIG_SPI_MASTER) && !strcmp(propname, "cs-gpios") &&
 	    of_property_read_bool(np, "cs-gpios")) {
 		struct device_node *child;
 		u32 cs;
-- 
2.21.0

