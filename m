Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B9F1AB02F
	for <lists+linux-spi@lfdr.de>; Wed, 15 Apr 2020 19:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411591AbgDOR6Y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Apr 2020 13:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2411581AbgDOR6T (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Apr 2020 13:58:19 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5E6C061A0C
        for <linux-spi@vger.kernel.org>; Wed, 15 Apr 2020 10:58:17 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id k28so3325007lfe.10
        for <linux-spi@vger.kernel.org>; Wed, 15 Apr 2020 10:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nzpcy1NONnpuTpQomH7DRwvMl5tjLj9Jb2RuGzAzVzQ=;
        b=Rhq1W4O5RgO0QbKAyndh8EFeCIRnRannyee9s7/D7S7MrlemzLLJe1sauYIufdBpwB
         rjnRHdOb/q5f4u2K1mE2l2jQcNorj07q88mFwIy4kMoF/xstjg1ThQ8IvSgZ0hss2zPC
         FWfB9V09cmvl8pUKh8xZzHPNrX954f+AVFCEy/RVbBaKWXvbTRzQKaeOljazdniv+coy
         ZS3xbh4gqp+YYYItJGV3TVG5521gi3tqgh67dS/Q7T3m7Le4j0zG3Kyv+sdCSgjeo+Ck
         reFojxo7g+BiGskDmnCOWnRdbkpMQzWVqYVBSRPctH63vMmLtaHDnCLIelS8/3la2XBt
         vdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nzpcy1NONnpuTpQomH7DRwvMl5tjLj9Jb2RuGzAzVzQ=;
        b=UdZ5hYbWQZW9OQHLkpr0YGQnh22tFv+eky+2SJKLW5I9MJl384lxDQNk/V7kuusBIh
         s+jLSxhNSObqHHLgjdThjAYcfyh/xXAHgjwdwtTeyw3B4oJZUYR8zeYNK4rFVVC2u5qu
         moIwaXSiRuqtC4r6y87DIZ2lX/MtCBCLZabxhY5J/cymXiQVeO3d3ktVlrxe7eVePBa5
         hBc2ysCi7Y8dp7vZHyfbDW3xgwx97JV9pSJ7woELs70EvcWTUGrM0OUHZegC33oyf0An
         YWXigmSx7d/7hc/FCfTlSJo9bQmnIIeE2GoZVyKxFTlJ/+0ULW9kn0Mp0/pjVnFwt4Mc
         AVJA==
X-Gm-Message-State: AGi0PubppmkOF9nphml8/IVaOqV7c5ZpLCfntVXdrhPNgJWxkUfRfthI
        ofKOWyK2HrmXe0ca4+vVDymd0A==
X-Google-Smtp-Source: APiQypLdnRBxk7EHTzo2pD9rDVs1dsegrkFo3Cp3M+3xAl/bMXp2h4BpVftzYureSE8PWXrAqJv8lw==
X-Received: by 2002:ac2:489b:: with SMTP id x27mr3846150lfc.60.1586973495664;
        Wed, 15 Apr 2020 10:58:15 -0700 (PDT)
Received: from localhost.localdomain (c-f3d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.243])
        by smtp.gmail.com with ESMTPSA id 1sm5758710ljw.91.2020.04.15.10.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 10:58:15 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Tomas Paukrt <tomaspaukrt@email.cz>,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>
Subject: [PATCH] spi: orion: Convert to use GPIO descriptors
Date:   Wed, 15 Apr 2020 19:56:13 +0200
Message-Id: <20200415175613.220767-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This converts the Orion SPI master to use GPIO descriptors.
The SPI core will obtain and manage the CS GPIOs, if any
are defined.

I make one sematic change: when a certain chip select is using
a GPIO line instead of the native CS I simply just enable the
1:1 mapped native CS that would have been used if the GPIO
was not there. As we set the SPI_MASTER_GPIO_SS the .set_cs()
callback will be called for all chip selects whether native
or not, and the important thing for the driver is that the
previous native chip select (if any) is deasserted, which
other chip select is asserted instead does not really matter.

The previous code went to great lengths to ascertain that the
first hw CS which was hiding behind a GPIO line was used for
all cases when the line is not using native chip select but
this should not matter at all, just use the one "underneath"
the GPIO at all times.

When a GPIO is used for CS, the SPI_CS_HIGH flag is enforced,
so the native chip select is also inverted. But that should
not matter since we are not using it anyways.

Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Tomas Paukrt <tomaspaukrt@email.cz>
Cc: Jan Kundrát <jan.kundrat@cesnet.cz>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
People using Orion SPI: please test this, I think it works
fine.
---
 drivers/spi/spi-orion.c | 70 ++++++++++-------------------------------
 1 file changed, 16 insertions(+), 54 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 1f59beb7d27e..43f73db22f21 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -17,10 +17,8 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <linux/clk.h>
 #include <linux/sizes.h>
-#include <linux/gpio.h>
 #include <asm/unaligned.h>
 
 #define DRIVER_NAME			"orion_spi"
@@ -98,7 +96,6 @@ struct orion_spi {
 	struct clk              *clk;
 	struct clk              *axi_clk;
 	const struct orion_spi_dev *devdata;
-	int			unused_hw_gpio;
 
 	struct orion_child_options	child[ORION_NUM_CHIPSELECTS];
 };
@@ -325,20 +322,27 @@ orion_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 static void orion_spi_set_cs(struct spi_device *spi, bool enable)
 {
 	struct orion_spi *orion_spi;
-	int cs;
 
 	orion_spi = spi_master_get_devdata(spi->master);
 
-	if (gpio_is_valid(spi->cs_gpio))
-		cs = orion_spi->unused_hw_gpio;
-	else
-		cs = spi->chip_select;
-
+	/*
+	 * If this line is using a GPIO to control chip select, this internal
+	 * .set_cs() function will still be called, so we clear any previous
+	 * chip select. The CS we activate will not have any elecrical effect,
+	 * as it is handled by a GPIO, but that doesn't matter. What we need
+	 * is to deassert the old chip select and assert some other chip select.
+	 */
 	orion_spi_clrbits(orion_spi, ORION_SPI_IF_CTRL_REG, ORION_SPI_CS_MASK);
 	orion_spi_setbits(orion_spi, ORION_SPI_IF_CTRL_REG,
-				ORION_SPI_CS(cs));
+			  ORION_SPI_CS(spi->chip_select));
 
-	/* Chip select logic is inverted from spi_set_cs */
+	/*
+	 * Chip select logic is inverted from spi_set_cs(). For lines using a
+	 * GPIO to do chip select SPI_CS_HIGH is enforced and inversion happens
+	 * in the GPIO library, but we don't care about that, because in those
+	 * cases we are dealing with an unused native CS anyways so the polarity
+	 * doesn't matter.
+	 */
 	if (!enable)
 		orion_spi_setbits(orion_spi, ORION_SPI_IF_CTRL_REG, 0x1);
 	else
@@ -503,9 +507,6 @@ static int orion_spi_transfer_one(struct spi_master *master,
 
 static int orion_spi_setup(struct spi_device *spi)
 {
-	if (gpio_is_valid(spi->cs_gpio)) {
-		gpio_direction_output(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
-	}
 	return orion_spi_setup_transfer(spi, NULL);
 }
 
@@ -622,13 +623,13 @@ static int orion_spi_probe(struct platform_device *pdev)
 	master->setup = orion_spi_setup;
 	master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
 	master->auto_runtime_pm = true;
+	master->use_gpio_descriptors = true;
 	master->flags = SPI_MASTER_GPIO_SS;
 
 	platform_set_drvdata(pdev, master);
 
 	spi = spi_master_get_devdata(master);
 	spi->master = master;
-	spi->unused_hw_gpio = -1;
 
 	of_id = of_match_device(orion_spi_of_match_table, &pdev->dev);
 	devdata = (of_id) ? of_id->data : &orion_spi_dev_data;
@@ -683,7 +684,6 @@ static int orion_spi_probe(struct platform_device *pdev)
 	for_each_available_child_of_node(pdev->dev.of_node, np) {
 		struct orion_direct_acc *dir_acc;
 		u32 cs;
-		int cs_gpio;
 
 		/* Get chip-select number from the "reg" property */
 		status = of_property_read_u32(np, "reg", &cs);
@@ -694,44 +694,6 @@ static int orion_spi_probe(struct platform_device *pdev)
 			continue;
 		}
 
-		/*
-		 * Initialize the CS GPIO:
-		 * - properly request the actual GPIO signal
-		 * - de-assert the logical signal so that all GPIO CS lines
-		 *   are inactive when probing for slaves
-		 * - find an unused physical CS which will be driven for any
-		 *   slave which uses a CS GPIO
-		 */
-		cs_gpio = of_get_named_gpio(pdev->dev.of_node, "cs-gpios", cs);
-		if (cs_gpio > 0) {
-			char *gpio_name;
-			int cs_flags;
-
-			if (spi->unused_hw_gpio == -1) {
-				dev_info(&pdev->dev,
-					"Selected unused HW CS#%d for any GPIO CSes\n",
-					cs);
-				spi->unused_hw_gpio = cs;
-			}
-
-			gpio_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
-					"%s-CS%d", dev_name(&pdev->dev), cs);
-			if (!gpio_name) {
-				status = -ENOMEM;
-				goto out_rel_axi_clk;
-			}
-
-			cs_flags = of_property_read_bool(np, "spi-cs-high") ?
-				GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH;
-			status = devm_gpio_request_one(&pdev->dev, cs_gpio,
-					cs_flags, gpio_name);
-			if (status) {
-				dev_err(&pdev->dev,
-					"Can't request GPIO for CS %d\n", cs);
-				goto out_rel_axi_clk;
-			}
-		}
-
 		/*
 		 * Check if an address is configured for this SPI device. If
 		 * not, the MBus mapping via the 'ranges' property in the 'soc'
-- 
2.25.2

