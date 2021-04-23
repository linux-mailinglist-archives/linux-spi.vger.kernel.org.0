Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69AD8369708
	for <lists+linux-spi@lfdr.de>; Fri, 23 Apr 2021 18:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242908AbhDWQfW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Apr 2021 12:35:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:32277 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242270AbhDWQfU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 23 Apr 2021 12:35:20 -0400
IronPort-SDR: kUJADS3wGWKTbHe1Wc/3dmLDIxR/lg2ijsws94tDsA2B7Mt578vVrqH9d5rcesrKwx29XknphH
 DGRVM5hJF3MA==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="196156380"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="196156380"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 09:34:41 -0700
IronPort-SDR: Fnp6XJyjPOVuGzZXWASJSa6rGuChm3tt8Ek21juLcavIioV2Bfd/myVGMPXqN30W0Yy1qCCgbq
 VfWpPwX7cD1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="525064569"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 23 Apr 2021 09:34:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 493C317E; Fri, 23 Apr 2021 19:34:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v1 04/14] spi: pxa2xx: Replace header inclusions by forward declarations
Date:   Fri, 23 Apr 2021 19:34:27 +0300
Message-Id: <20210423163437.89306-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210423163437.89306-1-andriy.shevchenko@linux.intel.com>
References: <20210423163437.89306-1-andriy.shevchenko@linux.intel.com>
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
 drivers/spi/spi-pxa2xx-dma.c   |  6 ++++--
 drivers/spi/spi-pxa2xx.c       |  2 ++
 drivers/spi/spi-pxa2xx.h       | 18 ++++++++++--------
 include/linux/spi/pxa2xx_spi.h |  2 ++
 4 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index 2e4a49567146..32ab7391396d 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -9,11 +9,13 @@
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
+
+#include <linux/pxa2xx_ssp.h>
 
 #include "spi-pxa2xx.h"
 
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

