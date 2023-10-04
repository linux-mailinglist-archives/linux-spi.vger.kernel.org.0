Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B157B8AC8
	for <lists+linux-spi@lfdr.de>; Wed,  4 Oct 2023 20:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244524AbjJDSjU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Oct 2023 14:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244516AbjJDSjT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Oct 2023 14:39:19 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA7EC6
        for <linux-spi@vger.kernel.org>; Wed,  4 Oct 2023 11:39:15 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32615eaa312so151904f8f.2
        for <linux-spi@vger.kernel.org>; Wed, 04 Oct 2023 11:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696444753; x=1697049553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QA+Y3LssOPJ3KAADHkTgfkM+4lfsQSRUByKy5qehR+I=;
        b=l0c7FjqSkm9u34rUPxY50qEdwFtPVWe0pfCN73L/g90h14reeFXkfq3V3kq6XpAFN4
         Xh264Z3qgcHbFveEmK7lTjC2G54+t63+iCtOQV8zdSnZFX9ZVr3QxPfNSetxah0l/nTK
         Pl0anrgN+hkecZNIoPP4WKa6MMM4nBOiaAG6k2CfmbFroaFlUhGRFCSWCgLXjNcUxddi
         vUu/++ICtomys5urCSyWUQgsJ1u95bkvSJUfa2mwo5+F+8+aR+6NgK7HAs7XwDZt/5mJ
         ejQ0QfZ+IqV+9fCZXCL8QQ4VyVPXhNCoq0WPQR4rwnXRKfYZd3OElvzs57nFRuz1L9je
         sqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696444753; x=1697049553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QA+Y3LssOPJ3KAADHkTgfkM+4lfsQSRUByKy5qehR+I=;
        b=fsRnhriV+VKC+FDZJkIAwqS4iTkAbbz1JZw8/iBF9jP8Vt5AMKr1DHYs49xakHkJfI
         QgzXwkBZNoB5BVEBRLFJikdbZ3+DV3xGA71raKPaYlNk6bE6mhJrTtZRBr3LOee6POx0
         UVIf61gHhO/g6XQVgQ5Z+AwBl2dhkvxgoqyNJwu+z2rZ/PgRB7xTQkYPSxT4N4IxWWs9
         Z4jm1EvWQMaOm7nY628Ht7O1Fyk11W5Q6e5r6H5+xDH22XoxM6rQ65bM4B22AjP+IeVk
         vQrYYzTWnjTfEKiqrLX2mpdwRjxmvlI2JXKf624VIQ/1WNtl8mEDavKiTjdz6reEYMMQ
         2bnA==
X-Gm-Message-State: AOJu0YyQZDqPPW6bRrXwwkXrClzgRVhAf+8nhE270/ewJONU0REaZ5a+
        zxVYX0x51XK+wrNBnQ3oBM/qFQ==
X-Google-Smtp-Source: AGHT+IFHrJt9Llwwm5JxoO+o1/3XuyhHZP01x1HpnwvYcsCqaaDIXZfPsR/EwAiRfDvwXntresVquA==
X-Received: by 2002:adf:fdd0:0:b0:321:6fe4:d4eb with SMTP id i16-20020adffdd0000000b003216fe4d4ebmr2878576wrs.2.1696444753110;
        Wed, 04 Oct 2023 11:39:13 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4cd6:4440:32bb:f50d])
        by smtp.gmail.com with ESMTPSA id s21-20020a7bc395000000b004064cd71aa8sm2109950wmj.34.2023.10.04.11.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 11:39:12 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] spi: bcm2835: add a sentinel at the end of the lookup array
Date:   Wed,  4 Oct 2023 20:39:06 +0200
Message-Id: <20231004183906.97845-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

GPIOLIB expects the array of lookup entries to be terminated with an
empty member. We need to increase the size of the variable length array
in the lookup table by 1.

Fixes: 21f252cd29f0 ("spi: bcm2835: reduce the abuse of the GPIO API")
Reported-by: Hans de Goede <hdegoede@redhat.com>
Closes: https://lore.kernel.org/lkml/29764d46-8d3d-9794-bbde-d7928a91cbb5@redhat.com/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/spi/spi-bcm2835.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index c9078fee3662..e709887eb2a9 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1299,7 +1299,7 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 	 * More on the problem that it addresses:
 	 *   https://www.spinics.net/lists/linux-gpio/msg36218.html
 	 */
-	lookup = kzalloc(struct_size(lookup, table, 1), GFP_KERNEL);
+	lookup = kzalloc(struct_size(lookup, table, 2), GFP_KERNEL);
 	if (!lookup) {
 		ret = -ENOMEM;
 		goto err_cleanup;
-- 
2.39.2

