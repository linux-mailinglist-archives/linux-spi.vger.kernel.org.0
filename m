Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A862610AC21
	for <lists+linux-spi@lfdr.de>; Wed, 27 Nov 2019 09:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfK0Iqs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Nov 2019 03:46:48 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43297 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfK0Iqs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Nov 2019 03:46:48 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so314213ljm.10
        for <linux-spi@vger.kernel.org>; Wed, 27 Nov 2019 00:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mvGi+7LNladFF/x34uf1YF7R09YmjPS9HkXbfVBy+MA=;
        b=izU2az3ZMe879sBcKpahyjAVbZMqEnTkxED1Uvk+oueNXHh1bK1KVWJXf/wurxFIxG
         Q77sJ9w6xBoUZ2mUVBnqR0ZbAnPFYUqtXQk/7Jix5nK/FX/2ExhBs4q1MqkjMkrvNnFY
         BLy3+tdKGgl7mYADSH2eI82Tzen6hJLu8s0VeSaIswH2zCnQyoR0df5AfBGn4IZV6NDf
         mefiYpe/Ll0f5aoDcUlkbREzGO1h8xScqu9X6Bl50tbTf6AgTyoApyjnrhgPQ52Iop+X
         IeyGnyn40L6Rf70aPAfCPhLrnLsb+vMeoIQpSKxBNL3jP5xRfafu3O4NRb/oPanb0H4z
         AivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mvGi+7LNladFF/x34uf1YF7R09YmjPS9HkXbfVBy+MA=;
        b=H1F1g+zaNhbFjqwHIT1VWsk1XhTI05SiyLDlCjFWioRLNJR4Omfw5LUgRuBFr9rTev
         6T5J9SmsiWWjB7lU97voAhwj+oRLWZX3t0zLPXEmju7DgX98tcCD4P4/vEh1qx2lc+7z
         k5c1tjNPdWq51JiSbcYiCRSZXYrwa5gSAXnUeq3w7P93WtE9JBenzT9f5r9sgUwiNdJp
         gdh8HqEBkCKFHCErlvoVuYoiAzYXQwLQDshCuslWYBZfiXEPDwIkHJuEX1CSFDsiysFM
         1gboPek9f5rpGabH7s4HKst0FZKgJByMIK57yMixfwk1ce0UxXxslkUZTVbln4ySbrl4
         1tXA==
X-Gm-Message-State: APjAAAXxUl0rkEFYC/Bq4M6+7KkGnQ4Pwr3vrCpZv86QICevxu9T1kG4
        4HZdkMC1cIJnyEq5Dy7wM1AgDg==
X-Google-Smtp-Source: APXvYqyKN+IlH+EjAEGS1IzsSsipK0OOOi56fXwpT7gkBXXo27TJJul1ylnQCzRsn+R8+BCunmOosg==
X-Received: by 2002:a2e:9083:: with SMTP id l3mr30750187ljg.127.1574844405069;
        Wed, 27 Nov 2019 00:46:45 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id b85sm6635663lfg.25.2019.11.27.00.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 00:46:43 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] spi: fsl: Handle the single hardwired chipselect case
Date:   Wed, 27 Nov 2019 09:46:40 +0100
Message-Id: <20191127084640.105054-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.23.0
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
 drivers/spi/spi-fsl-spi.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 114801a32371..f2188192bf76 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -727,8 +727,17 @@ static int of_fsl_spi_probe(struct platform_device *ofdev)
 			}
 		}
 #endif
-
-		pdata->cs_control = fsl_spi_cs_control;
+		/*
+		 * Handle the case where we have one hardwired (always selected)
+		 * device on the first "chipselect". Else we let the core code
+		 * handle any GPIOs or native chip selects and assign the
+		 * appropriate callback for dealing with the CS lines.
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

