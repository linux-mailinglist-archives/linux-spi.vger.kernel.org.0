Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9AB12B01C
	for <lists+linux-spi@lfdr.de>; Fri, 27 Dec 2019 02:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfL0BI7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 26 Dec 2019 20:08:59 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59806 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfL0BI7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 26 Dec 2019 20:08:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=b03zOjt9P+AZI2QZFUJujmUEa0hmUd9esIUWfw7SCxc=; b=O2THKGMod/Ti
        uFel1P6OU4ZmBaSnw5Y4u+es3R34NbLqWbCYEZQDWMvwrtTWom4iNORObduM6CaRb1Qbnbg+5bdW+
        2fUVFJpeWDT8VF4vL5GdYMFc9TqUEYGPxCBi0ULmylOkJa4tqWs16tKrclkWyl6pvfHFKIeDbKIJ4
        Kalew=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ike7b-00049d-NX; Fri, 27 Dec 2019 01:08:55 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 3CC56D01A22; Fri, 27 Dec 2019 01:08:55 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Thomas Chou <thomas@wytron.com.tw>
Subject: Applied "spi: oc-tiny: Use GPIO descriptors" to the spi tree
In-Reply-To: <20191205092411.64341-1-linus.walleij@linaro.org>
Message-Id: <applied-20191205092411.64341-1-linus.walleij@linaro.org>
X-Patchwork-Hint: ignore
Date:   Fri, 27 Dec 2019 01:08:55 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: oc-tiny: Use GPIO descriptors

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.6

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From f03ee2042b2dc46e3452e87324d90f147de4a944 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 5 Dec 2019 10:24:11 +0100
Subject: [PATCH] spi: oc-tiny: Use GPIO descriptors

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
Link: https://lore.kernel.org/r/20191205092411.64341-1-linus.walleij@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1

