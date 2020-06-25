Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4994020A878
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jun 2020 00:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgFYW6I (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 25 Jun 2020 18:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbgFYW6H (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 25 Jun 2020 18:58:07 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE4FC08C5DB
        for <linux-spi@vger.kernel.org>; Thu, 25 Jun 2020 15:58:07 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h19so8291184ljg.13
        for <linux-spi@vger.kernel.org>; Thu, 25 Jun 2020 15:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sQgdyk3y6zB0hASByJVzzEmARHNFTqPRb6Kf1xIGKh0=;
        b=oSfs64PKV38JXFXyuunReN5Z6kVfanjPQbqNiy926u6l8uP8SvoJ6QA1DQLHxjix2Y
         S3IXOYafJgGmvwLB1jbGL7oXyQZMpgGye1p03NHK02AMCX+MltYL/6746tIQNi+rMala
         7zsZ5l9kSGKASL4LWwBu3CZbWjZt4WCTmSznFIGBSCbBDhPb8EUIDxG8s8B6a+TWNrf6
         04EYLlyZWINjRId7DtwXo9XBcVJcVHTJ6oAWSoAowFPoIyX71kIRGtazxNgPp2FFQBZJ
         SXI3lU0TPTwLtGWDvoZgLdHB5QLV5iZv8XG/8WlWpkRpZ50JSNkzMEzQZs5Z30zekbpC
         pvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sQgdyk3y6zB0hASByJVzzEmARHNFTqPRb6Kf1xIGKh0=;
        b=KybAmefhPpqerI5Kd7hBeGGpQgRBf1y1Lvfpihi2Dq5LOblUaTjtZe89eiI6TlHPg9
         o4C6ie8q75eA84iHAVmRprNWaXZeISCiOSwQRK1AzroblQsPqYMPo38TvkvhsvshdQCY
         +cRz5BH1nwb7xSkmi6jddn8qTYHFdAvXh4PprJA3y8QqKvn2kyF/gC5EiSd3+v4um8Rz
         u2v3tbSpSzL4inWqzSTcu9m0AtTkdp9BMs2ySVUycNowveVA/tslXn32RsyjGwLvset6
         MhWkyv2oLTQZyBbF4T1ddLsnriY0+/zpFG1pnFTcuzvJ6HMh8uyP6Gs7ySNmhFiuOtjb
         6d0g==
X-Gm-Message-State: AOAM5311YzzmIlXYhHGuNxuKfOCyWdAQN4jtUZxpHJl55SU0y0m7OcFb
        nnfhCzIUlHSbsGOD1DUzF2GNigxxvNY=
X-Google-Smtp-Source: ABdhPJxQEE90iIe3k36mti5OJlS3Nce21aY87tifTY53+oTxvmRYPwzxpFTry/L6gGVL5y7u1X6lFA==
X-Received: by 2002:a2e:94d0:: with SMTP id r16mr16807227ljh.351.1593125885668;
        Thu, 25 Jun 2020 15:58:05 -0700 (PDT)
Received: from genomnajs.lan (c-d63ee155.152980-0-69706f6e6c79.bbcust.telenor.se. [85.225.62.214])
        by smtp.gmail.com with ESMTPSA id d9sm126976ljc.117.2020.06.25.15.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 15:58:05 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH] spi: npcm-pspi: Convert to use GPIO descriptors
Date:   Fri, 26 Jun 2020 00:57:59 +0200
Message-Id: <20200625225759.273911-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Nuvoton PSPI driver already uses the core to handle GPIO
chip selects but is using the old GPIO number method and
retrieveing the GPIOs in the probe() call.

Switch it over to using GPIO descriptors saving a bunch of
code and modernizing it.

Compile tested med ARMv7 multiplatform config augmented
with the Nuvoton arch and this driver.

Cc: Tomer Maimon <tmaimon77@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-npcm-pspi.c | 28 +---------------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/drivers/spi/spi-npcm-pspi.c b/drivers/spi/spi-npcm-pspi.c
index 87cd0233c60b..56d10c4511db 100644
--- a/drivers/spi/spi-npcm-pspi.c
+++ b/drivers/spi/spi-npcm-pspi.c
@@ -10,8 +10,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
-#include <linux/gpio.h>
-#include <linux/of_gpio.h>
 #include <linux/reset.h>
 
 #include <asm/unaligned.h>
@@ -344,16 +342,9 @@ static int npcm_pspi_probe(struct platform_device *pdev)
 	struct npcm_pspi *priv;
 	struct spi_master *master;
 	unsigned long clk_hz;
-	struct device_node *np = pdev->dev.of_node;
-	int num_cs, i;
-	int csgpio;
 	int irq;
 	int ret;
 
-	num_cs = of_gpio_named_count(np, "cs-gpios");
-	if (num_cs < 0)
-		return num_cs;
-
 	master = spi_alloc_master(&pdev->dev, sizeof(*priv));
 	if (!master)
 		return -ENOMEM;
@@ -418,24 +409,7 @@ static int npcm_pspi_probe(struct platform_device *pdev)
 		npcm_pspi_prepare_transfer_hardware;
 	master->unprepare_transfer_hardware =
 		npcm_pspi_unprepare_transfer_hardware;
-	master->num_chipselect = num_cs;
-
-	for (i = 0; i < num_cs; i++) {
-		csgpio = of_get_named_gpio(np, "cs-gpios", i);
-		if (csgpio < 0) {
-			dev_err(&pdev->dev, "failed to get csgpio#%u\n", i);
-			goto out_disable_clk;
-		}
-		dev_dbg(&pdev->dev, "csgpio#%u = %d\n", i, csgpio);
-		ret = devm_gpio_request_one(&pdev->dev, csgpio,
-					    GPIOF_OUT_INIT_HIGH, DRIVER_NAME);
-		if (ret < 0) {
-			dev_err(&pdev->dev,
-				"failed to configure csgpio#%u %d\n"
-				, i, csgpio);
-			goto out_disable_clk;
-		}
-	}
+	master->use_gpio_descriptors = true;
 
 	/* set to default clock rate */
 	npcm_pspi_set_baudrate(priv, NPCM_PSPI_DEFAULT_CLK);
-- 
2.25.4

