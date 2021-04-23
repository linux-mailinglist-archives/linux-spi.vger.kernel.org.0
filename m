Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E728A369966
	for <lists+linux-spi@lfdr.de>; Fri, 23 Apr 2021 20:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243597AbhDWSZQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Apr 2021 14:25:16 -0400
Received: from mga17.intel.com ([192.55.52.151]:21993 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243688AbhDWSZN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 23 Apr 2021 14:25:13 -0400
IronPort-SDR: K5HyO81VL6UREkyY949B8rcZNfnY6e6RXwdMzB78Nj45Cc5cZy93UljbMZsHwXUonBO8dccJhr
 NH24vV8GDj9g==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="176235450"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="176235450"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 11:24:35 -0700
IronPort-SDR: BiUAX/woJ2CsWWo5xQ1NpwsTDZLeRZGuwQzgL0rcgUuF9Lszhl+CE5Uk1cPKrHoZTMf9Dj1hQe
 L4zSuoDDIlOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="402266298"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 23 Apr 2021 11:24:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1EC921FC; Fri, 23 Apr 2021 21:24:45 +0300 (EEST)
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
Subject: [PATCH v2 05/14] spi: pxa2xx: Unify ifdeffery used in the headers
Date:   Fri, 23 Apr 2021 21:24:32 +0300
Message-Id: <20210423182441.50272-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
References: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The two headers have quite different ifdeffery to prevent multiple inclusion.
Unify them with the pattern that in particular reflects their location.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/pxa2xx_ssp.h     | 6 +++---
 include/linux/spi/pxa2xx_spi.h | 7 ++++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/pxa2xx_ssp.h
index 7f73b26ed22e..14b049840faf 100644
--- a/include/linux/pxa2xx_ssp.h
+++ b/include/linux/pxa2xx_ssp.h
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
diff --git a/include/linux/spi/pxa2xx_spi.h b/include/linux/spi/pxa2xx_spi.h
index 1e0e2f136319..12ef04d0896d 100644
--- a/include/linux/spi/pxa2xx_spi.h
+++ b/include/linux/spi/pxa2xx_spi.h
@@ -2,8 +2,8 @@
 /*
  * Copyright (C) 2005 Stephen Street / StreetFire Sound Labs
  */
-#ifndef __linux_pxa2xx_spi_h
-#define __linux_pxa2xx_spi_h
+#ifndef __LINUX_SPI_PXA2XX_SPI_H
+#define __LINUX_SPI_PXA2XX_SPI_H
 
 #include <linux/types.h>
 
@@ -51,4 +51,5 @@ struct pxa2xx_spi_chip {
 extern void pxa2xx_set_spi_info(unsigned id, struct pxa2xx_spi_controller *info);
 
 #endif
-#endif
+
+#endif	/* __LINUX_SPI_PXA2XX_SPI_H */
-- 
2.30.2

