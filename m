Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83254378EDD
	for <lists+linux-spi@lfdr.de>; Mon, 10 May 2021 15:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbhEJNcG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 May 2021 09:32:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:2719 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239834AbhEJMme (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 10 May 2021 08:42:34 -0400
IronPort-SDR: 6Wd4fkcCZsCOriuCgpacZ/v1bOBSkqiKvKf1zH4LjXFzSX29OUgogYxlbSXtxIGDNCcpSqOOLj
 3R7rPbJ476JA==
X-IronPort-AV: E=McAfee;i="6200,9189,9979"; a="198860827"
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="198860827"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 05:41:20 -0700
IronPort-SDR: rtt9vhfU5+g9JjqOKzr2J2nnDMqK3pOD7EfYAKhyyDKziVBAfNCmHts6S1q2YjpxDY7aRZbVGe
 IGHrc5EbebGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="391906311"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 10 May 2021 05:41:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 556BB142; Mon, 10 May 2021 15:41:37 +0300 (EEST)
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
Subject: [PATCH v3 02/14] spi: pxa2xx: Utilize MMIO and physical base from struct ssp_device
Date:   Mon, 10 May 2021 15:41:22 +0300
Message-Id: <20210510124134.24638-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210510124134.24638-1-andriy.shevchenko@linux.intel.com>
References: <20210510124134.24638-1-andriy.shevchenko@linux.intel.com>
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
index 2f5618883ac3..d89db682179d 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -325,7 +325,7 @@ static void lpss_ssp_setup(struct driver_data *drv_data)
 	u32 value;
 
 	config = lpss_get_config(drv_data);
-	drv_data->lpss_base = drv_data->ioaddr + config->offset;
+	drv_data->lpss_base = drv_data->ssp->mmio_base + config->offset;
 
 	/* Enable software chip select control */
 	value = __lpss_ssp_read_priv(drv_data, config->reg_cs_ctrl);
@@ -1733,8 +1733,6 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 
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

