Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 263A210B0AB
	for <lists+linux-spi@lfdr.de>; Wed, 27 Nov 2019 14:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfK0Ny2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Nov 2019 08:54:28 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46239 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfK0Ny2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Nov 2019 08:54:28 -0500
Received: by mail-lf1-f68.google.com with SMTP id a17so17206687lfi.13
        for <linux-spi@vger.kernel.org>; Wed, 27 Nov 2019 05:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OmjuVawMhvfVD9JOPWyCm3fewK5I8v6LD5uaG6j2MhM=;
        b=fj1gtrBw/+KHGWourkrK2BexXQtWwQO6TEvDijehjCAUBZRzPtpWiONgne8uaVlPNL
         +sxrWRQobCmSBcRcYIuSUhsPuyFDSKCDgWZDMO6Juu673NcXquk/IfarAB0H6T3JBi1V
         o7aClwqZiiy35WtXtwtMJXN58kWCKOnZJRZXLB04DXh2zV9ToYPpZBJtabcDcgcX4t12
         6fzXFFlHiLx6fZqRQ51sNIdVrWoIZaupC2pkFIvPwxmIJ0onVlB60MbaUyiO5XzinOoE
         d0PE+OlOBw99h8SQDYG5HkyhnRWu3YoDX/Q8rW20NRuJHb+SdoNNkV2A0HqIxJMan6jM
         IBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OmjuVawMhvfVD9JOPWyCm3fewK5I8v6LD5uaG6j2MhM=;
        b=LGytNFo7yZuuyANCwmLPQssbjLdH5u5lFkrpdfu3xTKnxbTgb1X2Xp3bekSZ6VKEsO
         aUaaSE4ornaBOtBgz0VJAuMarTeAcJsB0n7lSqujuZOyT8PdQt9O6l0sQi5NDPRcS/Oq
         QAyoD0Sd+mlmfeI2+jzSaSYTsBqRm0lR70XcuAN+wz4xZytF/6VwGvEG0O4cSStb57tT
         f7VWmSJYozmm8SUyPQrFpnL+AJX3B6S2PcznBHjs3h2eSHdDAZKynj3YFZ3RtYx/qUcz
         mHIgTzx0yB3bbrsmemJMabMKefD2H2GGpBEFc3Svav0DcPIVRD/gXYD1MY5aVScY6pPW
         6+KA==
X-Gm-Message-State: APjAAAVc3hrJBGBgHKb7HIlSZUxm3yz4guoOU/pvMBG0Yd0bFQSAiDza
        IvSRNhhblVNrumLAGGSZVUUVlQ==
X-Google-Smtp-Source: APXvYqwJ1jbbJMIu5K7QbN703ikVZ96WfMsH9zjZHYd3+3Sd5a69DUJH+JIdG0d7HJdwwyOnbsvtFg==
X-Received: by 2002:ac2:5c09:: with SMTP id r9mr26635541lfp.136.1574862866457;
        Wed, 27 Nov 2019 05:54:26 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id j18sm2343561lfh.6.2019.11.27.05.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 05:54:24 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 3/3 v2] spi: fsl: Handle the single hardwired chipselect case
Date:   Wed, 27 Nov 2019 14:54:10 +0100
Message-Id: <20191127135410.156430-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191127135410.156430-1-linus.walleij@linaro.org>
References: <20191127135410.156430-1-linus.walleij@linaro.org>
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

