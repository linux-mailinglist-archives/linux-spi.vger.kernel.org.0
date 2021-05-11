Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9FA37A8E4
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 16:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbhEKOS6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 10:18:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:39655 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231865AbhEKOS4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 May 2021 10:18:56 -0400
IronPort-SDR: xQYZR05sT0X3pP7/7Zx6BRgYjn6PbMOtieB5luTp7hYxlD2q+5DcIKrRHB3JtF5YakoBRSjjeM
 TZM4nJro9Dyw==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="179045750"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="179045750"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 07:17:10 -0700
IronPort-SDR: uvFXafhaw0WRoH46aZGCCdW7NGMorzpXPP/JV+4TespEr+mPtDjyYC2T100SoCLEh6nEn6bE02
 o1IairPYtxKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="621829408"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 11 May 2021 07:17:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6413C338; Tue, 11 May 2021 17:17:27 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v3 2/8] spi: pxa2xx: Use pxa_ssp_enable()/pxa_ssp_disable() in the driver
Date:   Tue, 11 May 2021 17:17:19 +0300
Message-Id: <20210511141725.32097-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210511141725.32097-1-andriy.shevchenko@linux.intel.com>
References: <20210511141725.32097-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There are few places that repeat the logic of pxa_ssp_enable() and
pxa_ssp_disable(). Use them instead of open coded variants.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-dma.c |  4 +---
 drivers/spi/spi-pxa2xx.c     | 36 ++++++++++++++++++------------------
 include/linux/pxa2xx_ssp.h   | 16 ++++++++++++++++
 sound/soc/pxa/pxa-ssp.c      | 16 ----------------
 4 files changed, 35 insertions(+), 37 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index e00dbadd39ec..5ca01ad7f460 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -50,9 +50,7 @@ static void pxa2xx_spi_dma_transfer_complete(struct driver_data *drv_data,
 
 		if (error) {
 			/* In case we got an error we disable the SSP now */
-			pxa2xx_spi_write(drv_data, SSCR0,
-					 pxa2xx_spi_read(drv_data, SSCR0)
-					 & ~SSCR0_SSE);
+			pxa_ssp_disable(drv_data->ssp);
 			msg->status = -EIO;
 		}
 
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 087c84e605b9..a27f51f5db65 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -286,13 +286,11 @@ static u32 pxa2xx_configure_sscr0(const struct driver_data *drv_data,
 	case QUARK_X1000_SSP:
 		return clk_div
 			| QUARK_X1000_SSCR0_Motorola
-			| QUARK_X1000_SSCR0_DataSize(bits > 32 ? 8 : bits)
-			| SSCR0_SSE;
+			| QUARK_X1000_SSCR0_DataSize(bits > 32 ? 8 : bits);
 	default:
 		return clk_div
 			| SSCR0_Motorola
 			| SSCR0_DataSize(bits > 16 ? bits - 16 : bits)
-			| SSCR0_SSE
 			| (bits > 16 ? SSCR0_EDSS : 0);
 	}
 }
@@ -498,8 +496,7 @@ static void pxa2xx_spi_off(struct driver_data *drv_data)
 	if (is_mmp2_ssp(drv_data))
 		return;
 
-	pxa2xx_spi_write(drv_data, SSCR0,
-			 pxa2xx_spi_read(drv_data, SSCR0) & ~SSCR0_SSE);
+	pxa_ssp_disable(drv_data->ssp);
 }
 
 static int null_writer(struct driver_data *drv_data)
@@ -1098,25 +1095,26 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *controller,
 	    (pxa2xx_spi_read(drv_data, DDS_RATE) != chip->dds_rate))
 		pxa2xx_spi_write(drv_data, DDS_RATE, chip->dds_rate);
 
+	/* Stop the SSP */
+	if (!is_mmp2_ssp(drv_data))
+		pxa_ssp_disable(drv_data->ssp);
+
+	if (!pxa25x_ssp_comp(drv_data))
+		pxa2xx_spi_write(drv_data, SSTO, chip->timeout);
+
 	/* see if we need to reload the config registers */
 	if ((pxa2xx_spi_read(drv_data, SSCR0) != cr0)
 	    || (pxa2xx_spi_read(drv_data, SSCR1) & change_mask)
 	    != (cr1 & change_mask)) {
-		/* stop the SSP, and update the other bits */
-		if (!is_mmp2_ssp(drv_data))
-			pxa2xx_spi_write(drv_data, SSCR0, cr0 & ~SSCR0_SSE);
-		if (!pxa25x_ssp_comp(drv_data))
-			pxa2xx_spi_write(drv_data, SSTO, chip->timeout);
 		/* first set CR1 without interrupt and service enables */
 		pxa2xx_spi_write(drv_data, SSCR1, cr1 & change_mask);
-		/* restart the SSP */
+		/* Update the other bits */
 		pxa2xx_spi_write(drv_data, SSCR0, cr0);
-
-	} else {
-		if (!pxa25x_ssp_comp(drv_data))
-			pxa2xx_spi_write(drv_data, SSTO, chip->timeout);
 	}
 
+	/* Restart the SSP */
+	pxa_ssp_enable(drv_data->ssp);
+
 	if (is_mmp2_ssp(drv_data)) {
 		u8 tx_level = (pxa2xx_spi_read(drv_data, SSSR)
 					& SSSR_TFL_MASK) >> 8;
@@ -1786,8 +1784,9 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 		controller->min_speed_hz =
 			DIV_ROUND_UP(controller->max_speed_hz, 512);
 
+	pxa_ssp_disable(ssp);
+
 	/* Load default SSP configuration */
-	pxa2xx_spi_write(drv_data, SSCR0, 0);
 	switch (drv_data->ssp_type) {
 	case QUARK_X1000_SSP:
 		tmp = QUARK_X1000_SSCR1_RxTresh(RX_THRESH_QUARK_X1000_DFLT) |
@@ -1928,7 +1927,7 @@ static int pxa2xx_spi_remove(struct platform_device *pdev)
 	spi_unregister_controller(drv_data->controller);
 
 	/* Disable the SSP at the peripheral and SOC level */
-	pxa2xx_spi_write(drv_data, SSCR0, 0);
+	pxa_ssp_disable(ssp);
 	clk_disable_unprepare(ssp->clk);
 
 	/* Release DMA */
@@ -1957,7 +1956,8 @@ static int pxa2xx_spi_suspend(struct device *dev)
 	status = spi_controller_suspend(drv_data->controller);
 	if (status != 0)
 		return status;
-	pxa2xx_spi_write(drv_data, SSCR0, 0);
+
+	pxa_ssp_disable(ssp);
 
 	if (!pm_runtime_suspended(dev))
 		clk_disable_unprepare(ssp->clk);
diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/pxa2xx_ssp.h
index 1b6c1a0922bd..fdfbe17e15f4 100644
--- a/include/linux/pxa2xx_ssp.h
+++ b/include/linux/pxa2xx_ssp.h
@@ -254,6 +254,22 @@ static inline u32 pxa_ssp_read_reg(struct ssp_device *dev, u32 reg)
 	return __raw_readl(dev->mmio_base + reg);
 }
 
+static inline void pxa_ssp_enable(struct ssp_device *ssp)
+{
+	u32 sscr0;
+
+	sscr0 = pxa_ssp_read_reg(ssp, SSCR0) | SSCR0_SSE;
+	pxa_ssp_write_reg(ssp, SSCR0, sscr0);
+}
+
+static inline void pxa_ssp_disable(struct ssp_device *ssp)
+{
+	u32 sscr0;
+
+	sscr0 = pxa_ssp_read_reg(ssp, SSCR0) & ~SSCR0_SSE;
+	pxa_ssp_write_reg(ssp, SSCR0, sscr0);
+}
+
 #if IS_ENABLED(CONFIG_PXA_SSP)
 struct ssp_device *pxa_ssp_request(int port, const char *label);
 void pxa_ssp_free(struct ssp_device *);
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index b941adcbb8f9..939e7e28486a 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -61,22 +61,6 @@ static void dump_registers(struct ssp_device *ssp)
 		 pxa_ssp_read_reg(ssp, SSACD));
 }
 
-static void pxa_ssp_enable(struct ssp_device *ssp)
-{
-	uint32_t sscr0;
-
-	sscr0 = __raw_readl(ssp->mmio_base + SSCR0) | SSCR0_SSE;
-	__raw_writel(sscr0, ssp->mmio_base + SSCR0);
-}
-
-static void pxa_ssp_disable(struct ssp_device *ssp)
-{
-	uint32_t sscr0;
-
-	sscr0 = __raw_readl(ssp->mmio_base + SSCR0) & ~SSCR0_SSE;
-	__raw_writel(sscr0, ssp->mmio_base + SSCR0);
-}
-
 static void pxa_ssp_set_dma_params(struct ssp_device *ssp, int width4,
 			int out, struct snd_dmaengine_dai_dma_data *dma)
 {
-- 
2.30.2

