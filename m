Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A573A45AC38
	for <lists+linux-spi@lfdr.de>; Tue, 23 Nov 2021 20:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbhKWTao (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Nov 2021 14:30:44 -0500
Received: from mga17.intel.com ([192.55.52.151]:55618 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233580AbhKWTao (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 23 Nov 2021 14:30:44 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="215821128"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="215821128"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 11:27:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="553557295"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 23 Nov 2021 11:27:33 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E9A6B1AD; Tue, 23 Nov 2021 21:27:36 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH v1 2/3] spi: pxa2xx: Get rid of unused ->cs_control()
Date:   Tue, 23 Nov 2021 21:27:22 +0200
Message-Id: <20211123192723.44537-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211123192723.44537-1-andriy.shevchenko@linux.intel.com>
References: <20211123192723.44537-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Since the last user of the custom ->cs_control() gone, we may get rid of
this legacy API completely.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/spi/pxa2xx.rst   | 29 +++--------------------------
 arch/arm/mach-pxa/stargate2.c  |  2 +-
 drivers/spi/spi-pxa2xx.c       | 18 ------------------
 drivers/spi/spi-pxa2xx.h       |  3 ---
 include/linux/spi/pxa2xx_spi.h |  4 ----
 5 files changed, 4 insertions(+), 52 deletions(-)

diff --git a/Documentation/spi/pxa2xx.rst b/Documentation/spi/pxa2xx.rst
index 6312968acfe9..dfc7673ed15d 100644
--- a/Documentation/spi/pxa2xx.rst
+++ b/Documentation/spi/pxa2xx.rst
@@ -102,7 +102,7 @@ device. All fields are optional.
 	u8 dma_burst_size;
 	u32 timeout;
 	u8 enable_loopback;
-	void (*cs_control)(u32 command);
+	int gpio_cs;
   };
 
 The "pxa2xx_spi_chip.tx_threshold" and "pxa2xx_spi_chip.rx_threshold" fields are
@@ -133,11 +133,6 @@ into internal loopback mode.  In this mode the SSP controller internally
 connects the SSPTX pin to the SSPRX pin.  This is useful for initial setup
 testing.
 
-The "pxa2xx_spi_chip.cs_control" field is used to point to a board specific
-function for asserting/deasserting a slave device chip select.  If the field is
-NULL, the pxa2xx_spi master controller driver assumes that the SSP port is
-configured to use GPIO or SSPFRM instead.
-
 NOTE: the SPI driver cannot control the chip select if SSPFRM is used, so the
 chipselect is dropped after each spi_transfer.  Most devices need chip select
 asserted around the complete message. Use SSPFRM as a GPIO (through a descriptor)
@@ -152,30 +147,12 @@ field. Below is a sample configuration using the PXA255 NSSP.
 
 ::
 
-  /* Chip Select control for the CS8415A SPI slave device */
-  static void cs8415a_cs_control(u32 command)
-  {
-	if (command & PXA2XX_CS_ASSERT)
-		GPCR(2) = GPIO_bit(2);
-	else
-		GPSR(2) = GPIO_bit(2);
-  }
-
-  /* Chip Select control for the CS8405A SPI slave device */
-  static void cs8405a_cs_control(u32 command)
-  {
-	if (command & PXA2XX_CS_ASSERT)
-		GPCR(3) = GPIO_bit(3);
-	else
-		GPSR(3) = GPIO_bit(3);
-  }
-
   static struct pxa2xx_spi_chip cs8415a_chip_info = {
 	.tx_threshold = 8, /* SSP hardward FIFO threshold */
 	.rx_threshold = 8, /* SSP hardward FIFO threshold */
 	.dma_burst_size = 8, /* Byte wide transfers used so 8 byte bursts */
 	.timeout = 235, /* See Intel documentation */
-	.cs_control = cs8415a_cs_control, /* Use external chip select */
+	.gpio_cs = 2, /* Use external chip select */
   };
 
   static struct pxa2xx_spi_chip cs8405a_chip_info = {
@@ -183,7 +160,7 @@ field. Below is a sample configuration using the PXA255 NSSP.
 	.rx_threshold = 8, /* SSP hardward FIFO threshold */
 	.dma_burst_size = 8, /* Byte wide transfers used so 8 byte bursts */
 	.timeout = 235, /* See Intel documentation */
-	.cs_control = cs8405a_cs_control, /* Use external chip select */
+	.gpio_cs = 3, /* Use external chip select */
   };
 
   static struct spi_board_info streetracer_spi_board_info[] __initdata = {
diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
index 7ad627465768..8ca02ec1d44c 100644
--- a/arch/arm/mach-pxa/stargate2.c
+++ b/arch/arm/mach-pxa/stargate2.c
@@ -347,7 +347,7 @@ static struct pxa2xx_spi_controller pxa_ssp_master_2_info = {
 };
 
 /* An upcoming kernel change will scrap SFRM usage so these
- * drivers have been moved to use gpio's via cs_control */
+ * drivers have been moved to use GPIOs */
 static struct pxa2xx_spi_chip staccel_chip_info = {
 	.tx_threshold = 8,
 	.rx_threshold = 8,
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index ee3297dd532e..24196156c609 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -427,7 +427,6 @@ static void lpss_ssp_cs_control(struct spi_device *spi, bool enable)
 
 static void cs_assert(struct spi_device *spi)
 {
-	struct chip_data *chip = spi_get_ctldata(spi);
 	struct driver_data *drv_data =
 		spi_controller_get_devdata(spi->controller);
 
@@ -436,18 +435,12 @@ static void cs_assert(struct spi_device *spi)
 		return;
 	}
 
-	if (chip->cs_control) {
-		chip->cs_control(PXA2XX_CS_ASSERT);
-		return;
-	}
-
 	if (is_lpss_ssp(drv_data))
 		lpss_ssp_cs_control(spi, true);
 }
 
 static void cs_deassert(struct spi_device *spi)
 {
-	struct chip_data *chip = spi_get_ctldata(spi);
 	struct driver_data *drv_data =
 		spi_controller_get_devdata(spi->controller);
 	unsigned long timeout;
@@ -461,11 +454,6 @@ static void cs_deassert(struct spi_device *spi)
 	       !time_after(jiffies, timeout))
 		cpu_relax();
 
-	if (chip->cs_control) {
-		chip->cs_control(PXA2XX_CS_DEASSERT);
-		return;
-	}
-
 	if (is_lpss_ssp(drv_data))
 		lpss_ssp_cs_control(spi, false);
 }
@@ -1204,12 +1192,6 @@ static int setup_cs(struct spi_device *spi, struct chip_data *chip,
 	 */
 	cleanup_cs(spi);
 
-	/* If ->cs_control() is provided, ignore GPIO chip select */
-	if (chip_info->cs_control) {
-		chip->cs_control = chip_info->cs_control;
-		return 0;
-	}
-
 	if (gpio_is_valid(chip_info->gpio_cs)) {
 		int gpio = chip_info->gpio_cs;
 		int err;
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 4d77f4de6eda..45cdbbc71c4b 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -49,7 +49,6 @@ struct driver_data {
 	int (*write)(struct driver_data *drv_data);
 	int (*read)(struct driver_data *drv_data);
 	irqreturn_t (*transfer_handler)(struct driver_data *drv_data);
-	void (*cs_control)(u32 command);
 
 	void __iomem *lpss_base;
 
@@ -67,8 +66,6 @@ struct chip_data {
 	u32 threshold;
 	u16 lpss_rx_threshold;
 	u16 lpss_tx_threshold;
-
-	void (*cs_control)(u32 command);
 };
 
 static inline u32 pxa2xx_spi_read(const struct driver_data *drv_data, u32 reg)
diff --git a/include/linux/spi/pxa2xx_spi.h b/include/linux/spi/pxa2xx_spi.h
index eaab121ee575..42e06bfbc2a4 100644
--- a/include/linux/spi/pxa2xx_spi.h
+++ b/include/linux/spi/pxa2xx_spi.h
@@ -9,9 +9,6 @@
 
 #include <linux/pxa2xx_ssp.h>
 
-#define PXA2XX_CS_ASSERT (0x01)
-#define PXA2XX_CS_DEASSERT (0x02)
-
 struct dma_chan;
 
 /*
@@ -47,7 +44,6 @@ struct pxa2xx_spi_chip {
 	u32 timeout;
 	u8 enable_loopback;
 	int gpio_cs;
-	void (*cs_control)(u32 command);
 };
 
 #if defined(CONFIG_ARCH_PXA) || defined(CONFIG_ARCH_MMP)
-- 
2.33.0

