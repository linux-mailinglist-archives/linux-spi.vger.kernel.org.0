Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354EB36970A
	for <lists+linux-spi@lfdr.de>; Fri, 23 Apr 2021 18:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243005AbhDWQfW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Apr 2021 12:35:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:51170 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242301AbhDWQfU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 23 Apr 2021 12:35:20 -0400
IronPort-SDR: Lcbn2//ya8rsAejpxmiSH2vOSvtyBI3PRTaciQOh2swEuzkq5NGsP/e6h3x9Y8SjyDCT3ZZ8Zb
 FgDQWAycCRaA==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="193979325"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="193979325"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 09:34:43 -0700
IronPort-SDR: gFOnInLtpr118H5FS9N61WsDF0pFMGItxr57URSWM2ZdEl/u0yzSayeCRAR1wweiowyb+EUYR4
 /VSga8nRzIOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="421810613"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 23 Apr 2021 09:34:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C0B021C8; Fri, 23 Apr 2021 19:34:55 +0300 (EEST)
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
Subject: [PATCH v1 05/14] spi: pxa2xx: Consolidate related headers under include/linux/spi
Date:   Fri, 23 Apr 2021 19:34:28 +0300
Message-Id: <20210423163437.89306-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210423163437.89306-1-andriy.shevchenko@linux.intel.com>
References: <20210423163437.89306-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

We have two headers split between include/linux and include/linux/spi.
Consolidated them under SPI realm, i.e. in the latter folder.

Update users accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/input/mouse/navpoint.c       | 3 ++-
 drivers/spi/spi-pxa2xx-dma.c         | 2 --
 drivers/spi/spi-pxa2xx-pci.c         | 1 +
 drivers/spi/spi-pxa2xx.h             | 2 +-
 include/linux/spi/pxa2xx_spi.h       | 9 +++++----
 include/linux/{ => spi}/pxa2xx_ssp.h | 6 +++---
 sound/soc/intel/catpt/dsp.c          | 4 +++-
 sound/soc/pxa/pxa-ssp.c              | 3 ++-
 8 files changed, 17 insertions(+), 13 deletions(-)
 rename include/linux/{ => spi}/pxa2xx_ssp.h (99%)

diff --git a/drivers/input/mouse/navpoint.c b/drivers/input/mouse/navpoint.c
index 4d67575bb276..a0731cfbbafa 100644
--- a/drivers/input/mouse/navpoint.c
+++ b/drivers/input/mouse/navpoint.c
@@ -15,9 +15,10 @@
 #include <linux/input/navpoint.h>
 #include <linux/interrupt.h>
 #include <linux/mutex.h>
-#include <linux/pxa2xx_ssp.h>
 #include <linux/slab.h>
 
+#include <linux/spi/pxa2xx_ssp.h>
+
 /*
  * Synaptics Modular Embedded Protocol: Module Packet Format.
  * Module header byte 2:0 = Length (# bytes that follow)
diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index 32ab7391396d..e00dbadd39ec 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -15,8 +15,6 @@
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/spi/spi.h>
 
-#include <linux/pxa2xx_ssp.h>
-
 #include "spi-pxa2xx.h"
 
 static void pxa2xx_spi_dma_transfer_complete(struct driver_data *drv_data,
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
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 739e264feaa6..b6dae0981b61 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -12,7 +12,7 @@
 #include <linux/types.h>
 #include <linux/sizes.h>
 
-#include <linux/pxa2xx_ssp.h>
+#include <linux/spi/pxa2xx_ssp.h>
 
 struct gpio_desc;
 struct pxa2xx_spi_controller;
diff --git a/include/linux/spi/pxa2xx_spi.h b/include/linux/spi/pxa2xx_spi.h
index 1e0e2f136319..4baae475bd89 100644
--- a/include/linux/spi/pxa2xx_spi.h
+++ b/include/linux/spi/pxa2xx_spi.h
@@ -2,12 +2,12 @@
 /*
  * Copyright (C) 2005 Stephen Street / StreetFire Sound Labs
  */
-#ifndef __linux_pxa2xx_spi_h
-#define __linux_pxa2xx_spi_h
+#ifndef __LINUX_PXA2XX_SPI_H
+#define __LINUX_PXA2XX_SPI_H
 
 #include <linux/types.h>
 
-#include <linux/pxa2xx_ssp.h>
+#include <linux/spi/pxa2xx_ssp.h>
 
 #define PXA2XX_CS_ASSERT (0x01)
 #define PXA2XX_CS_DEASSERT (0x02)
@@ -51,4 +51,5 @@ struct pxa2xx_spi_chip {
 extern void pxa2xx_set_spi_info(unsigned id, struct pxa2xx_spi_controller *info);
 
 #endif
-#endif
+
+#endif	/* __LINUX_PXA2XX_SPI_H */
diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/spi/pxa2xx_ssp.h
similarity index 99%
rename from include/linux/pxa2xx_ssp.h
rename to include/linux/spi/pxa2xx_ssp.h
index 7f73b26ed22e..14b049840faf 100644
--- a/include/linux/pxa2xx_ssp.h
+++ b/include/linux/spi/pxa2xx_ssp.h
@@ -11,8 +11,8 @@
  *       PXA3xx     SSP1, SSP2, SSP3, SSP4
  */
 
-#ifndef __LINUX_SSP_H
-#define __LINUX_SSP_H
+#ifndef __LINUX_PXA2XX_SSP_H
+#define __LINUX_PXA2XX_SSP_H
 
 #include <linux/bits.h>
 #include <linux/compiler_types.h>
@@ -270,4 +270,4 @@ static inline struct ssp_device *pxa_ssp_request_of(const struct device_node *n,
 static inline void pxa_ssp_free(struct ssp_device *ssp) {}
 #endif
 
-#endif
+#endif	/* __LINUX_PXA2XX_SSP_H */
diff --git a/sound/soc/intel/catpt/dsp.c b/sound/soc/intel/catpt/dsp.c
index 9c5fd18f2600..08af8bab8704 100644
--- a/sound/soc/intel/catpt/dsp.c
+++ b/sound/soc/intel/catpt/dsp.c
@@ -9,7 +9,9 @@
 #include <linux/dma-mapping.h>
 #include <linux/firmware.h>
 #include <linux/pci.h>
-#include <linux/pxa2xx_ssp.h>
+
+#include <linux/spi/pxa2xx_ssp.h>
+
 #include "core.h"
 #include "messages.h"
 #include "registers.h"
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index b941adcbb8f9..710c8dbd18bc 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -16,10 +16,11 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/io.h>
-#include <linux/pxa2xx_ssp.h>
 #include <linux/of.h>
 #include <linux/dmaengine.h>
 
+#include <linux/spi/pxa2xx_ssp.h>
+
 #include <asm/irq.h>
 
 #include <sound/core.h>
-- 
2.30.2

