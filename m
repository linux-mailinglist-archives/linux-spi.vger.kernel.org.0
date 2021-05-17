Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D79D382E40
	for <lists+linux-spi@lfdr.de>; Mon, 17 May 2021 16:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237762AbhEQOFH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 May 2021 10:05:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:23534 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237713AbhEQOE5 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 17 May 2021 10:04:57 -0400
IronPort-SDR: 8xupKhuqiq+WjysfLhT6/B6iyX6GPvEph5dmMGArZnuOMB+CF67NQ0oE5EvMGY6QRE3jezxXck
 mvTK2QQI/u+w==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="200520349"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="200520349"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 07:03:35 -0700
IronPort-SDR: ra3EH4SshMfmEpy459eTUxAUQltPVBJomcfuUC/XDRrMVGERWqwyaNGnE7xuFlTvpqCQl4Z2BQ
 lnV+8M1GHHzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="543710114"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 17 May 2021 07:03:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 182CC662; Mon, 17 May 2021 17:03:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v1 2/9] spi: pxa2xx: Switch to use SPI core GPIO (descriptor) CS handling
Date:   Mon, 17 May 2021 17:03:44 +0300
Message-Id: <20210517140351.901-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210517140351.901-1-andriy.shevchenko@linux.intel.com>
References: <20210517140351.901-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SPI core has been already providing the GPIO CS handling. Use it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 51 +++-------------------------------------
 drivers/spi/spi-pxa2xx.h |  3 ---
 2 files changed, 3 insertions(+), 51 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 38eef9033468..d19cea4ed946 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1198,25 +1198,12 @@ static int pxa2xx_spi_unprepare_transfer(struct spi_controller *controller)
 static int setup_cs(struct spi_device *spi, struct chip_data *chip,
 		    struct pxa2xx_spi_chip *chip_info)
 {
-	struct driver_data *drv_data =
-		spi_controller_get_devdata(spi->controller);
 	struct gpio_desc *gpiod;
 	int err = 0;
 
 	if (chip == NULL)
 		return 0;
 
-	if (drv_data->cs_gpiods) {
-		gpiod = drv_data->cs_gpiods[spi->chip_select];
-		if (gpiod) {
-			chip->gpiod_cs = gpiod;
-			chip->gpio_cs_inverted = spi->mode & SPI_CS_HIGH;
-			gpiod_set_value(gpiod, chip->gpio_cs_inverted);
-		}
-
-		return 0;
-	}
-
 	if (chip_info == NULL)
 		return 0;
 
@@ -1430,8 +1417,7 @@ static void cleanup(struct spi_device *spi)
 	if (!chip)
 		return;
 
-	if (drv_data->ssp_type != CE4100_SSP && !drv_data->cs_gpiods &&
-	    chip->gpiod_cs)
+	if (drv_data->ssp_type != CE4100_SSP && chip->gpiod_cs)
 		gpiod_put(chip->gpiod_cs);
 
 	kfree(chip);
@@ -1682,7 +1668,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	struct driver_data *drv_data;
 	struct ssp_device *ssp;
 	const struct lpss_config *config;
-	int status, count;
+	int status;
 	u32 tmp;
 
 	platform_info = dev_get_platdata(dev);
@@ -1861,38 +1847,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 		}
 	}
 	controller->num_chipselect = platform_info->num_chipselect;
-
-	count = gpiod_count(&pdev->dev, "cs");
-	if (count > 0) {
-		int i;
-
-		controller->num_chipselect = max_t(int, count,
-			controller->num_chipselect);
-
-		drv_data->cs_gpiods = devm_kcalloc(&pdev->dev,
-			controller->num_chipselect, sizeof(struct gpio_desc *),
-			GFP_KERNEL);
-		if (!drv_data->cs_gpiods) {
-			status = -ENOMEM;
-			goto out_error_clock_enabled;
-		}
-
-		for (i = 0; i < controller->num_chipselect; i++) {
-			struct gpio_desc *gpiod;
-
-			gpiod = devm_gpiod_get_index(dev, "cs", i, GPIOD_ASIS);
-			if (IS_ERR(gpiod)) {
-				/* Means use native chip select */
-				if (PTR_ERR(gpiod) == -ENOENT)
-					continue;
-
-				status = PTR_ERR(gpiod);
-				goto out_error_clock_enabled;
-			} else {
-				drv_data->cs_gpiods[i] = gpiod;
-			}
-		}
-	}
+	controller->use_gpio_descriptors = true;
 
 	if (platform_info->is_slave) {
 		drv_data->gpiod_ready = devm_gpiod_get_optional(dev,
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 5c6a5e0f249e..672dfd4863cc 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -53,9 +53,6 @@ struct driver_data {
 
 	void __iomem *lpss_base;
 
-	/* GPIOs for chip selects */
-	struct gpio_desc **cs_gpiods;
-
 	/* Optional slave FIFO ready signal */
 	struct gpio_desc *gpiod_ready;
 };
-- 
2.30.2

