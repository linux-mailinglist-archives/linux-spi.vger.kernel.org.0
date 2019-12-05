Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1A48113DBD
	for <lists+linux-spi@lfdr.de>; Thu,  5 Dec 2019 10:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfLEJYR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Dec 2019 04:24:17 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40976 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfLEJYQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 5 Dec 2019 04:24:16 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so2687091ljc.8
        for <linux-spi@vger.kernel.org>; Thu, 05 Dec 2019 01:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D9uCZrwGf9mwYn1KVu7Rx2jiXK/Lik/QE6solfXxyZU=;
        b=yieoBa8E4+gqxCQ0Al9z8anqU2PyPQihsPuVX4DX45bNgk8WWqNviy6S3IOTys47Ur
         A6MSiCIXOBho5R5HlgGhH3JIDqMU6jIaXemyImxgNlDUq7MAFkmrkDSamoBJX+lsxj9v
         kZKo1zgdZX1xNMXZbUHWP+zMqnA3QgW6ORtxBcKPIvji+RTFM1OhK84o8FlMKYU27EpT
         jBUdoAMzBkApvl7ZSvHnFUaaCmEGr11sFFbYEyQhFw458znChpP4j+NBZ26Am0GcMzL9
         KYa9L5beHAAPFC/FPX8rRWe1Ym2Jzu11FUbJl7I7kbvu9mCEZaa5mc4A/slpktL7HGg1
         LkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D9uCZrwGf9mwYn1KVu7Rx2jiXK/Lik/QE6solfXxyZU=;
        b=OJPNhUK5daNunVXDJokcZ2G2yGHws81MMrhX+gHHcWSi1B8Fc9fjI+eIZT+e2kWgKW
         srGkzmROzebM4N8UM25aPBaUHN3Y0jG+YBKMg6wO1sNNWdL8ip9mXOhjzCn/CpBJ+SP0
         9voib2ENH4dOMoAL3h3UCTLfHazvHB3zs2TeIVZ3Nj3rVMIhJRSf2kMtdAMe7f6V/Xw/
         XGUOzE6JiaCClJJJtMBEs0pq5MbDfHN2cpS7yd/CD7uRXAGU1Z7ZIdozyJS5Bla3SmKM
         CXyRhmBfGSRBq32y8OxFyJAZyDnin5jnsLDVx/9PcEsavQzurEmYyYqOQMEo14wzxCCm
         K1Ig==
X-Gm-Message-State: APjAAAWOh7lpg3+4XZ+3EcslzraJfBnUwSB14eKULDt2rs4z/kfBFa5h
        +SMM3XeOmHDdp6zKRTnnIQxeZQ==
X-Google-Smtp-Source: APXvYqwoP1letY+ueYeuPcB5Pds8smiMwB3UFyWhVHFFkJHvalugz18zTH+zYthsDE7NwXSMytz7Kg==
X-Received: by 2002:a2e:9a98:: with SMTP id p24mr4894878lji.37.1575537853991;
        Thu, 05 Dec 2019 01:24:13 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id w71sm5422362lff.0.2019.12.05.01.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 01:24:13 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Chou <thomas@wytron.com.tw>
Subject: [PATCH] spi: oc-tiny: Use GPIO descriptors
Date:   Thu,  5 Dec 2019 10:24:11 +0100
Message-Id: <20191205092411.64341-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Switch the OC Tiny driver over to handling CS GPIOs using
GPIO descriptors in the core.

This driver is entirely relying on GPIOs to be used for
chipselect, so let the core pick these out using either
device tree or machine descriptors.

There are no in-tree users of this driver so no board files
need to be patched, out-of-tree boardfiles can use machine
descriptor tables, c.f. commit 1dfbf334f123.

Cc: Thomas Chou <thomas@wytron.com.tw>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
This patch requires the previous patch:
"spi: bitbang: Make chipselect callback optional"
---
 drivers/spi/spi-oc-tiny.c       | 50 +--------------------------------
 include/linux/spi/spi_oc_tiny.h |  4 ---
 2 files changed, 1 insertion(+), 53 deletions(-)

diff --git a/drivers/spi/spi-oc-tiny.c b/drivers/spi/spi-oc-tiny.c
index e2331eb7b47a..9df7c5979c29 100644
--- a/drivers/spi/spi-oc-tiny.c
+++ b/drivers/spi/spi-oc-tiny.c
@@ -20,7 +20,6 @@
 #include <linux/spi/spi_bitbang.h>
 #include <linux/spi/spi_oc_tiny.h>
 #include <linux/io.h>
-#include <linux/gpio.h>
 #include <linux/of.h>
 
 #define DRV_NAME "spi_oc_tiny"
@@ -50,8 +49,6 @@ struct tiny_spi {
 	unsigned int txc, rxc;
 	const u8 *txp;
 	u8 *rxp;
-	int gpio_cs_count;
-	int *gpio_cs;
 };
 
 static inline struct tiny_spi *tiny_spi_to_hw(struct spi_device *sdev)
@@ -66,16 +63,6 @@ static unsigned int tiny_spi_baud(struct spi_device *spi, unsigned int hz)
 	return min(DIV_ROUND_UP(hw->freq, hz * 2), (1U << hw->baudwidth)) - 1;
 }
 
-static void tiny_spi_chipselect(struct spi_device *spi, int is_active)
-{
-	struct tiny_spi *hw = tiny_spi_to_hw(spi);
-
-	if (hw->gpio_cs_count > 0) {
-		gpio_set_value(hw->gpio_cs[spi->chip_select],
-			(spi->mode & SPI_CS_HIGH) ? is_active : !is_active);
-	}
-}
-
 static int tiny_spi_setup_transfer(struct spi_device *spi,
 				   struct spi_transfer *t)
 {
@@ -203,24 +190,10 @@ static int tiny_spi_of_probe(struct platform_device *pdev)
 {
 	struct tiny_spi *hw = platform_get_drvdata(pdev);
 	struct device_node *np = pdev->dev.of_node;
-	unsigned int i;
 	u32 val;
 
 	if (!np)
 		return 0;
-	hw->gpio_cs_count = of_gpio_count(np);
-	if (hw->gpio_cs_count > 0) {
-		hw->gpio_cs = devm_kcalloc(&pdev->dev,
-				hw->gpio_cs_count, sizeof(unsigned int),
-				GFP_KERNEL);
-		if (!hw->gpio_cs)
-			return -ENOMEM;
-	}
-	for (i = 0; i < hw->gpio_cs_count; i++) {
-		hw->gpio_cs[i] = of_get_gpio_flags(np, i, NULL);
-		if (hw->gpio_cs[i] < 0)
-			return -ENODEV;
-	}
 	hw->bitbang.master->dev.of_node = pdev->dev.of_node;
 	if (!of_property_read_u32(np, "clock-frequency", &val))
 		hw->freq = val;
@@ -240,7 +213,6 @@ static int tiny_spi_probe(struct platform_device *pdev)
 	struct tiny_spi_platform_data *platp = dev_get_platdata(&pdev->dev);
 	struct tiny_spi *hw;
 	struct spi_master *master;
-	unsigned int i;
 	int err = -ENODEV;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(struct tiny_spi));
@@ -249,9 +221,9 @@ static int tiny_spi_probe(struct platform_device *pdev)
 
 	/* setup the master state. */
 	master->bus_num = pdev->id;
-	master->num_chipselect = 255;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 	master->setup = tiny_spi_setup;
+	master->use_gpio_descriptors = true;
 
 	hw = spi_master_get_devdata(master);
 	platform_set_drvdata(pdev, hw);
@@ -259,7 +231,6 @@ static int tiny_spi_probe(struct platform_device *pdev)
 	/* setup the state for the bitbang driver */
 	hw->bitbang.master = master;
 	hw->bitbang.setup_transfer = tiny_spi_setup_transfer;
-	hw->bitbang.chipselect = tiny_spi_chipselect;
 	hw->bitbang.txrx_bufs = tiny_spi_txrx_bufs;
 
 	/* find and map our resources */
@@ -279,12 +250,6 @@ static int tiny_spi_probe(struct platform_device *pdev)
 	}
 	/* find platform data */
 	if (platp) {
-		hw->gpio_cs_count = platp->gpio_cs_count;
-		hw->gpio_cs = platp->gpio_cs;
-		if (platp->gpio_cs_count && !platp->gpio_cs) {
-			err = -EBUSY;
-			goto exit;
-		}
 		hw->freq = platp->freq;
 		hw->baudwidth = platp->baudwidth;
 	} else {
@@ -292,13 +257,6 @@ static int tiny_spi_probe(struct platform_device *pdev)
 		if (err)
 			goto exit;
 	}
-	for (i = 0; i < hw->gpio_cs_count; i++) {
-		err = gpio_request(hw->gpio_cs[i], dev_name(&pdev->dev));
-		if (err)
-			goto exit_gpio;
-		gpio_direction_output(hw->gpio_cs[i], 1);
-	}
-	hw->bitbang.master->num_chipselect = max(1, hw->gpio_cs_count);
 
 	/* register our spi controller */
 	err = spi_bitbang_start(&hw->bitbang);
@@ -308,9 +266,6 @@ static int tiny_spi_probe(struct platform_device *pdev)
 
 	return 0;
 
-exit_gpio:
-	while (i-- > 0)
-		gpio_free(hw->gpio_cs[i]);
 exit:
 	spi_master_put(master);
 	return err;
@@ -320,11 +275,8 @@ static int tiny_spi_remove(struct platform_device *pdev)
 {
 	struct tiny_spi *hw = platform_get_drvdata(pdev);
 	struct spi_master *master = hw->bitbang.master;
-	unsigned int i;
 
 	spi_bitbang_stop(&hw->bitbang);
-	for (i = 0; i < hw->gpio_cs_count; i++)
-		gpio_free(hw->gpio_cs[i]);
 	spi_master_put(master);
 	return 0;
 }
diff --git a/include/linux/spi/spi_oc_tiny.h b/include/linux/spi/spi_oc_tiny.h
index a3ecf2feadf2..284872ac130c 100644
--- a/include/linux/spi/spi_oc_tiny.h
+++ b/include/linux/spi/spi_oc_tiny.h
@@ -6,16 +6,12 @@
  * struct tiny_spi_platform_data - platform data of the OpenCores tiny SPI
  * @freq:	input clock freq to the core.
  * @baudwidth:	baud rate divider width of the core.
- * @gpio_cs_count:	number of gpio pins used for chipselect.
- * @gpio_cs:	array of gpio pins used for chipselect.
  *
  * freq and baudwidth are used only if the divider is programmable.
  */
 struct tiny_spi_platform_data {
 	unsigned int freq;
 	unsigned int baudwidth;
-	unsigned int gpio_cs_count;
-	int *gpio_cs;
 };
 
 #endif /* _LINUX_SPI_SPI_OC_TINY_H */
-- 
2.23.0

