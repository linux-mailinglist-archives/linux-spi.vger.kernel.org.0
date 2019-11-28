Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C52910C53D
	for <lists+linux-spi@lfdr.de>; Thu, 28 Nov 2019 09:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfK1Ih3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Nov 2019 03:37:29 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33865 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfK1Ih3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 Nov 2019 03:37:29 -0500
Received: by mail-lf1-f65.google.com with SMTP id l18so1357785lfc.1
        for <linux-spi@vger.kernel.org>; Thu, 28 Nov 2019 00:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SPhwT8PnMlXpxw5ygxGJ3XE7+b5kb2zOG+JKAmHXdIw=;
        b=RmzeZgfmUeniMdXw+V73nAoU9vXOooaDR+OfZBFpxFryTDVMAj4Lc8mVIvTuzS9i2r
         n1NfS9SpwUjwtK1lkTI80hT+xkxJRFWxhoBImlY2e6Lf+zUT5KoCSuk7S/JJGOies9PD
         elARO8naQ4L87JTdDqhI83LT/VKGfRF0SfUdttXv/7WFyaBZ3PQqSrGJrGDQ8IlGsw/7
         c69uTGPnE+XcgSgjrU1Lc/uGwvruQgaK+rzb8DEVtJ1r7F/lor5xeeN6tIqPLI8CCVOC
         Zyz1VJsqmmFJCIcwS/1Pgv1+7Z9gFLHcVTRwW9xGOZ/VFhXgio4w0eFJIIff/FQPddO/
         WbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SPhwT8PnMlXpxw5ygxGJ3XE7+b5kb2zOG+JKAmHXdIw=;
        b=BemD9lPwKPeLkE23n1N2v7kw/QxTf6cwehSuES02MUoh0iwh7bCMKGUuYDiiiPa4kI
         gHHBiYNvEOsRTXkZY0emOV7PwcFXfq1edUn2iuRjtC9E073R8BMI4mQdOAAtkfXdWS9A
         sLFixZw9S8B8kSBTMnRJa6F+xNv3zPe36HekyTGO6MNZ5wOe1KP5jN1XgHD7zo9UTGzv
         aeSS9JgeFt/lSpFbB9J/BKsrzkiVa+0D2C+/laOSsOm+DsdC4bdIvfl8eexPBFzZdvej
         +XcwNoHq6pjKRye93Owrdj7rOulB9PU1Tjj5HxF8x12XjidqtppGjvfyKrq0rRVAkLXw
         zaqg==
X-Gm-Message-State: APjAAAUfLZ0STCqzTHxMxCr5bufXrKvvhrBS8CIsnDehLN8ghJGNDXGO
        Eh5XsITo6wbxbUOEe4AuM9VS6w==
X-Google-Smtp-Source: APXvYqw7zYaBayF+3RX4e/L8eQvJYMaac/fo0i6ekCr5i+cd9QBJ6zSLHie/tg0ewygSOfzxfl97qw==
X-Received: by 2002:ac2:4357:: with SMTP id o23mr32178594lfl.51.1574930247027;
        Thu, 28 Nov 2019 00:37:27 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id x193sm3384013lfa.78.2019.11.28.00.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 00:37:25 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 3/3 v3] spi: fsl: Handle the single hardwired chipselect case
Date:   Thu, 28 Nov 2019 09:37:18 +0100
Message-Id: <20191128083718.39177-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128083718.39177-1-linus.walleij@linaro.org>
References: <20191128083718.39177-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Freescale MPC8xxx had a special quirk for handling a
single hardwired chipselect, the case when we're using neither
GPIO nor native chip select: when inspecting the device tree
and finding zero "cs-gpios" on the device node the code would
assume we have a single hardwired chipselect that leaves the
device always selected.

This quirk is not handled by the new core code, so we need
to check the "cs-gpios" explicitly in the driver and set
pdata->max_chipselect = 1 which will later fall through to
the SPI master ->num_chipselect.

Make sure not to assign the chip select handler in this
case: there is no handling needed since the chip is always
selected, and this is what the old code did as well.

Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
Fixes: 0f0581b24bd0 ("spi: fsl: Convert to use CS GPIO descriptors")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Resend with the other patches.
ChangeLog v1->v2:
- Reordered patches.
- Expanded comment a bit.
---
 drivers/spi/spi-fsl-spi.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index c87e9c4506c2..4b70887cf443 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -728,8 +728,18 @@ static int of_fsl_spi_probe(struct platform_device *ofdev)
 			}
 		}
 #endif
-
-		pdata->cs_control = fsl_spi_cs_control;
+		/*
+		 * Handle the case where we have one hardwired (always selected)
+		 * device on the first "chipselect". Else we let the core code
+		 * handle any GPIOs or native chip selects and assign the
+		 * appropriate callback for dealing with the CS lines. This isn't
+		 * supported on the GRLIB variant.
+		 */
+		ret = gpiod_count(dev, "cs");
+		if (ret <= 0)
+			pdata->max_chipselect = 1;
+		else
+			pdata->cs_control = fsl_spi_cs_control;
 	}
 
 	ret = of_address_to_resource(np, 0, &mem);
-- 
2.23.0

