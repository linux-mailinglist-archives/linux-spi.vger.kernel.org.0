Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288B7382E37
	for <lists+linux-spi@lfdr.de>; Mon, 17 May 2021 16:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237696AbhEQOFC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 May 2021 10:05:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:59401 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237698AbhEQOEz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 17 May 2021 10:04:55 -0400
IronPort-SDR: RMV/LUNUA+Cf4mF+OUmvDSqgsk5GxRJz2s0PY5LMzRU/3023wjwb8aSN6QzWilKz4SS6ufoAqz
 x8soKToGfaLg==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="197388012"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="197388012"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 07:03:36 -0700
IronPort-SDR: A9TCXsoFi4Y4oPVncf/BNgR2xI6V6hl0tFWU40gl3f57FeOgTgro3mZKzK6i4hHTGlWgO8Umut
 PjluE9Rk7C5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="432671162"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 17 May 2021 07:03:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 23FF6752; Mon, 17 May 2021 17:03:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v1 3/9] spi: pxa2xx: Switch to use SPI core GPIO (legacy) CS handling
Date:   Mon, 17 May 2021 17:03:45 +0300
Message-Id: <20210517140351.901-4-andriy.shevchenko@linux.intel.com>
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
 drivers/spi/spi-pxa2xx.c | 59 ++++++++++++++++++----------------------
 drivers/spi/spi-pxa2xx.h | 12 ++++----
 2 files changed, 32 insertions(+), 39 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index d19cea4ed946..1a0bcd3bac1f 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -441,11 +441,6 @@ static void cs_assert(struct spi_device *spi)
 		return;
 	}
 
-	if (chip->gpiod_cs) {
-		gpiod_set_value(chip->gpiod_cs, chip->gpio_cs_inverted);
-		return;
-	}
-
 	if (is_lpss_ssp(drv_data))
 		lpss_ssp_cs_control(spi, true);
 }
@@ -471,11 +466,6 @@ static void cs_deassert(struct spi_device *spi)
 		return;
 	}
 
-	if (chip->gpiod_cs) {
-		gpiod_set_value(chip->gpiod_cs, !chip->gpio_cs_inverted);
-		return;
-	}
-
 	if (is_lpss_ssp(drv_data))
 		lpss_ssp_cs_control(spi, false);
 }
@@ -1195,11 +1185,19 @@ static int pxa2xx_spi_unprepare_transfer(struct spi_controller *controller)
 	return 0;
 }
 
+static void cleanup_cs(struct spi_device *spi)
+{
+	if (!gpio_is_valid(spi->cs_gpio))
+		return;
+
+	gpio_free(spi->cs_gpio);
+	spi->cs_gpio = -ENOENT;
+}
+
 static int setup_cs(struct spi_device *spi, struct chip_data *chip,
 		    struct pxa2xx_spi_chip *chip_info)
 {
-	struct gpio_desc *gpiod;
-	int err = 0;
+	struct driver_data *drv_data = spi_controller_get_devdata(spi->controller);
 
 	if (chip == NULL)
 		return 0;
@@ -1207,13 +1205,13 @@ static int setup_cs(struct spi_device *spi, struct chip_data *chip,
 	if (chip_info == NULL)
 		return 0;
 
+	if (drv_data->ssp_type == CE4100_SSP)
+		return 0;
+
 	/* NOTE: setup() can be called multiple times, possibly with
 	 * different chip_info, release previously requested GPIO
 	 */
-	if (chip->gpiod_cs) {
-		gpiod_put(chip->gpiod_cs);
-		chip->gpiod_cs = NULL;
-	}
+	cleanup_cs(spi);
 
 	/* If (*cs_control) is provided, ignore GPIO chip select */
 	if (chip_info->cs_control) {
@@ -1222,21 +1220,25 @@ static int setup_cs(struct spi_device *spi, struct chip_data *chip,
 	}
 
 	if (gpio_is_valid(chip_info->gpio_cs)) {
-		err = gpio_request(chip_info->gpio_cs, "SPI_CS");
+		int gpio = chip_info->gpio_cs;
+		int err;
+
+		err = gpio_request(gpio, "SPI_CS");
 		if (err) {
-			dev_err(&spi->dev, "failed to request chip select GPIO%d\n",
-				chip_info->gpio_cs);
+			dev_err(&spi->dev, "failed to request chip select GPIO%d\n", gpio);
 			return err;
 		}
 
-		gpiod = gpio_to_desc(chip_info->gpio_cs);
-		chip->gpiod_cs = gpiod;
-		chip->gpio_cs_inverted = spi->mode & SPI_CS_HIGH;
+		err = gpio_direction_output(gpio, !(spi->mode & SPI_CS_HIGH));
+		if (err) {
+			gpio_free(gpio);
+			return err;
+		}
 
-		err = gpiod_direction_output(gpiod, !chip->gpio_cs_inverted);
+		spi->cs_gpio = gpio;
 	}
 
-	return err;
+	return 0;
 }
 
 static int setup(struct spi_device *spi)
@@ -1411,15 +1413,8 @@ static int setup(struct spi_device *spi)
 static void cleanup(struct spi_device *spi)
 {
 	struct chip_data *chip = spi_get_ctldata(spi);
-	struct driver_data *drv_data =
-		spi_controller_get_devdata(spi->controller);
-
-	if (!chip)
-		return;
-
-	if (drv_data->ssp_type != CE4100_SSP && chip->gpiod_cs)
-		gpiod_put(chip->gpiod_cs);
 
+	cleanup_cs(spi);
 	kfree(chip);
 }
 
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 672dfd4863cc..a91fe6edb275 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -62,19 +62,17 @@ struct chip_data {
 	u32 dds_rate;
 	u32 timeout;
 	u8 n_bytes;
+	u8 enable_dma;
 	u32 dma_burst_size;
-	u32 threshold;
 	u32 dma_threshold;
+	u32 threshold;
 	u16 lpss_rx_threshold;
 	u16 lpss_tx_threshold;
-	u8 enable_dma;
-	union {
-		struct gpio_desc *gpiod_cs;
-		unsigned int frm;
-	};
-	int gpio_cs_inverted;
+
 	int (*write)(struct driver_data *drv_data);
 	int (*read)(struct driver_data *drv_data);
+
+	unsigned int frm;
 	void (*cs_control)(u32 command);
 };
 
-- 
2.30.2

