Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBE045AC3C
	for <lists+linux-spi@lfdr.de>; Tue, 23 Nov 2021 20:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbhKWTbG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Nov 2021 14:31:06 -0500
Received: from mga06.intel.com ([134.134.136.31]:27007 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233580AbhKWTbG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 23 Nov 2021 14:31:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="295918208"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="295918208"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 11:27:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="597220906"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 23 Nov 2021 11:27:37 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8DD8FB8; Tue, 23 Nov 2021 21:27:41 +0200 (EET)
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
Subject: [PATCH v1 3/3] spi: pxa2xx: Get rid of unused enable_loopback member
Date:   Tue, 23 Nov 2021 21:27:23 +0200
Message-Id: <20211123192723.44537-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211123192723.44537-1-andriy.shevchenko@linux.intel.com>
References: <20211123192723.44537-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There is no user of the enable_loopback member in the struct pxa2xx_spi_chip.
Remote this legacy member completely.

The mentioned in the documentation the testing phase can be performed with
spidev_test tool.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/spi/pxa2xx.rst   | 6 ------
 drivers/spi/spi-pxa2xx.c       | 5 ++---
 include/linux/spi/pxa2xx_spi.h | 1 -
 3 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/Documentation/spi/pxa2xx.rst b/Documentation/spi/pxa2xx.rst
index dfc7673ed15d..6347580826be 100644
--- a/Documentation/spi/pxa2xx.rst
+++ b/Documentation/spi/pxa2xx.rst
@@ -101,7 +101,6 @@ device. All fields are optional.
 	u8 rx_threshold;
 	u8 dma_burst_size;
 	u32 timeout;
-	u8 enable_loopback;
 	int gpio_cs;
   };
 
@@ -128,11 +127,6 @@ dependent on the SPI bus speed ("spi_board_info.max_speed_hz") and the specific
 slave device.  Please note that the PXA2xx SSP 1 does not support trailing byte
 timeouts and must busy-wait any trailing bytes.
 
-The "pxa2xx_spi_chip.enable_loopback" field is used to place the SSP porting
-into internal loopback mode.  In this mode the SSP controller internally
-connects the SSPTX pin to the SSPRX pin.  This is useful for initial setup
-testing.
-
 NOTE: the SPI driver cannot control the chip select if SSPFRM is used, so the
 chipselect is dropped after each spi_transfer.  Most devices need chip select
 asserted around the complete message. Use SSPFRM as a GPIO (through a descriptor)
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 24196156c609..b3186bd0c2a8 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1289,7 +1289,6 @@ static int setup(struct spi_device *spi)
 	chip_info = spi->controller_data;
 
 	/* chip_info isn't always needed */
-	chip->cr1 = 0;
 	if (chip_info) {
 		if (chip_info->timeout)
 			chip->timeout = chip_info->timeout;
@@ -1300,9 +1299,9 @@ static int setup(struct spi_device *spi)
 		if (chip_info->rx_threshold)
 			rx_thres = chip_info->rx_threshold;
 		chip->dma_threshold = 0;
-		if (chip_info->enable_loopback)
-			chip->cr1 = SSCR1_LBM;
 	}
+
+	chip->cr1 = 0;
 	if (spi_controller_is_slave(drv_data->controller)) {
 		chip->cr1 |= SSCR1_SCFR;
 		chip->cr1 |= SSCR1_SCLKDIR;
diff --git a/include/linux/spi/pxa2xx_spi.h b/include/linux/spi/pxa2xx_spi.h
index 42e06bfbc2a4..ca74dce36706 100644
--- a/include/linux/spi/pxa2xx_spi.h
+++ b/include/linux/spi/pxa2xx_spi.h
@@ -42,7 +42,6 @@ struct pxa2xx_spi_chip {
 	u8 rx_threshold;
 	u8 dma_burst_size;
 	u32 timeout;
-	u8 enable_loopback;
 	int gpio_cs;
 };
 
-- 
2.33.0

