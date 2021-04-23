Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6AB369956
	for <lists+linux-spi@lfdr.de>; Fri, 23 Apr 2021 20:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243546AbhDWSZJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Apr 2021 14:25:09 -0400
Received: from mga07.intel.com ([134.134.136.100]:38428 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243438AbhDWSZI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 23 Apr 2021 14:25:08 -0400
IronPort-SDR: oriG92j3RWf8M1Cfao5c+NL6bGxvoW1eadStatyfq1AldHWx/dStSKYGbSCJ3uMQMoeZwHj1n8
 qKprb1LyEUOw==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="260067644"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="260067644"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 11:24:29 -0700
IronPort-SDR: 1r4hx0fceWsBWHixekScdI8nwQg/+tTFYCPK6BTIhZMugd2qAIp3vMzHq2Etf2mZK9XoOHXMZG
 XUZlX4PpvsbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="428481590"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 23 Apr 2021 11:24:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E677713C; Fri, 23 Apr 2021 21:24:44 +0300 (EEST)
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
Subject: [PATCH v2 02/14] spi: pxa2xx: Utilize MMIO and physical base from struct ssp_device
Date:   Fri, 23 Apr 2021 21:24:29 +0300
Message-Id: <20210423182441.50272-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
References: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

We have a duplication of MMIO and physical base addresses in
the struct driver_data, get rid of it and reuse members from
struct ssp_device instead.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-dma.c |  4 ++--
 drivers/spi/spi-pxa2xx.c     |  4 +---
 drivers/spi/spi-pxa2xx.h     | 14 ++++----------
 3 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index 37567bc7a523..3b27f356a18f 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -94,14 +94,14 @@ pxa2xx_spi_dma_prepare_one(struct driver_data *drv_data,
 	cfg.direction = dir;
 
 	if (dir == DMA_MEM_TO_DEV) {
-		cfg.dst_addr = drv_data->ssdr_physical;
+		cfg.dst_addr = drv_data->ssp->phys_base + SSDR;
 		cfg.dst_addr_width = width;
 		cfg.dst_maxburst = chip->dma_burst_size;
 
 		sgt = &xfer->tx_sg;
 		chan = drv_data->controller->dma_tx;
 	} else {
-		cfg.src_addr = drv_data->ssdr_physical;
+		cfg.src_addr = drv_data->ssp->phys_base + SSDR;
 		cfg.src_addr_width = width;
 		cfg.src_maxburst = chip->dma_burst_size;
 
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 0ef22045b006..82df028c4a71 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -325,7 +325,7 @@ static void lpss_ssp_setup(struct driver_data *drv_data)
 	u32 value;
 
 	config = lpss_get_config(drv_data);
-	drv_data->lpss_base = drv_data->ioaddr + config->offset;
+	drv_data->lpss_base = drv_data->ssp->mmio_base + config->offset;
 
 	/* Enable software chip select control */
 	value = __lpss_ssp_read_priv(drv_data, config->reg_cs_ctrl);
@@ -1729,8 +1729,6 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 
 	drv_data->ssp_type = ssp->type;
 
-	drv_data->ioaddr = ssp->mmio_base;
-	drv_data->ssdr_physical = ssp->phys_base + SSDR;
 	if (pxa25x_ssp_comp(drv_data)) {
 		switch (drv_data->ssp_type) {
 		case QUARK_X1000_SSP:
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 1400472bc986..ad9980ebefa6 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -33,10 +33,6 @@ struct driver_data {
 	/* PXA hookup */
 	struct pxa2xx_spi_controller *controller_info;
 
-	/* SSP register addresses */
-	void __iomem *ioaddr;
-	phys_addr_t ssdr_physical;
-
 	/* SSP masks*/
 	u32 dma_cr1;
 	u32 int_cr1;
@@ -87,16 +83,14 @@ struct chip_data {
 	void (*cs_control)(u32 command);
 };
 
-static inline u32 pxa2xx_spi_read(const struct driver_data *drv_data,
-				  unsigned reg)
+static inline u32 pxa2xx_spi_read(const struct driver_data *drv_data, u32 reg)
 {
-	return __raw_readl(drv_data->ioaddr + reg);
+	return pxa_ssp_read_reg(drv_data->ssp, reg);
 }
 
-static  inline void pxa2xx_spi_write(const struct driver_data *drv_data,
-				     unsigned reg, u32 val)
+static inline void pxa2xx_spi_write(const struct driver_data *drv_data, u32 reg, u32 val)
 {
-	__raw_writel(val, drv_data->ioaddr + reg);
+	pxa_ssp_write_reg(drv_data->ssp, reg, val);
 }
 
 #define DMA_ALIGNMENT		8
-- 
2.30.2

