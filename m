Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5FB8369955
	for <lists+linux-spi@lfdr.de>; Fri, 23 Apr 2021 20:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243504AbhDWSZJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Apr 2021 14:25:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:57703 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243410AbhDWSZI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 23 Apr 2021 14:25:08 -0400
IronPort-SDR: 7CbzUCqZYETUXCvjSwhiJJA9aB6jJibSGlgKonSHIrwzbYu3v9l0E8BxN/rA1CfyiIpbssEm2i
 4q/LFzqA7x9g==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="175599617"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="175599617"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 11:24:29 -0700
IronPort-SDR: PPMozkHLAIBdUAvX8jNtyk1sKmp6UfYQODVmNI0wMvS1Jwy8I7tyuEmC7NH3Prk8/dt6LgkJLq
 I4cgGPhwYKrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="392155981"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 23 Apr 2021 11:24:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 12EF81C8; Fri, 23 Apr 2021 21:24:45 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v2 04/14] spi: pxa2xx: Replace header inclusions by forward declarations
Date:   Fri, 23 Apr 2021 21:24:31 +0300
Message-Id: <20210423182441.50272-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
References: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

When the data structure is only referred by pointer, compiler may not need
to see the contents of the data type. Thus, we may replace header inclusions
by respective forward declarations. Due to above add missed headers as well.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-dma.c   |  4 ++--
 drivers/spi/spi-pxa2xx-pci.c   |  1 +
 drivers/spi/spi-pxa2xx.c       |  2 ++
 drivers/spi/spi-pxa2xx.h       | 18 ++++++++++--------
 include/linux/spi/pxa2xx_spi.h |  2 ++
 5 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index 2e4a49567146..e00dbadd39ec 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -9,11 +9,11 @@
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
-#include <linux/pxa2xx_ssp.h>
 #include <linux/scatterlist.h>
 #include <linux/sizes.h>
-#include <linux/spi/spi.h>
+
 #include <linux/spi/pxa2xx_spi.h>
+#include <linux/spi/spi.h>
 
 #include "spi-pxa2xx.h"
 
diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index f60ed4c62000..5af0a3fbc1b0 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+
 #include <linux/spi/pxa2xx_spi.h>
 
 #include <linux/dmaengine.h>
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index e9dddcbd92f1..0296cbdee848 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -9,6 +9,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/dmaengine.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/gpio/consumer.h>
@@ -25,6 +26,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/slab.h>
+
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/spi/spi.h>
 
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 6724d7e056ce..739e264feaa6 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -7,16 +7,18 @@
 #ifndef SPI_PXA2XX_H
 #define SPI_PXA2XX_H
 
-#include <linux/atomic.h>
-#include <linux/dmaengine.h>
-#include <linux/errno.h>
-#include <linux/io.h>
 #include <linux/interrupt.h>
-#include <linux/pxa2xx_ssp.h>
-#include <linux/scatterlist.h>
+#include <linux/io.h>
+#include <linux/types.h>
 #include <linux/sizes.h>
-#include <linux/spi/spi.h>
-#include <linux/spi/pxa2xx_spi.h>
+
+#include <linux/pxa2xx_ssp.h>
+
+struct gpio_desc;
+struct pxa2xx_spi_controller;
+struct spi_controller;
+struct spi_device;
+struct spi_transfer;
 
 struct driver_data {
 	/* SSP Info */
diff --git a/include/linux/spi/pxa2xx_spi.h b/include/linux/spi/pxa2xx_spi.h
index 31f00c7f4f59..1e0e2f136319 100644
--- a/include/linux/spi/pxa2xx_spi.h
+++ b/include/linux/spi/pxa2xx_spi.h
@@ -5,6 +5,8 @@
 #ifndef __linux_pxa2xx_spi_h
 #define __linux_pxa2xx_spi_h
 
+#include <linux/types.h>
+
 #include <linux/pxa2xx_ssp.h>
 
 #define PXA2XX_CS_ASSERT (0x01)
-- 
2.30.2

