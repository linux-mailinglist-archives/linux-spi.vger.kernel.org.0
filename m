Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25896369719
	for <lists+linux-spi@lfdr.de>; Fri, 23 Apr 2021 18:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243213AbhDWQf0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Apr 2021 12:35:26 -0400
Received: from mga12.intel.com ([192.55.52.136]:48596 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243184AbhDWQfZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 23 Apr 2021 12:35:25 -0400
IronPort-SDR: xnVEGQKuIxN+AG4rIVqlipaCNujQGVDK7Nmk+SDnRRFpMthjSV/swJErAddEgZkIM5hYSKGARz
 GSlba72Jk01w==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="175581964"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="175581964"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 09:34:46 -0700
IronPort-SDR: 6xA0Mi8CKiWMRG1KFusnYfYvVd0Nn/aRW2ePEoUSML/Gts2GCVKhplyi1dpKECTZOjZ4ksZtLZ
 Mi2OGIt5NjzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="614764930"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 23 Apr 2021 09:34:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 30C5B52A; Fri, 23 Apr 2021 19:34:58 +0300 (EEST)
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
Subject: [PATCH v1 10/14] spi: pxa2xx: Extract pxa2xx_spi_update() helper
Date:   Fri, 23 Apr 2021 19:34:33 +0300
Message-Id: <20210423163437.89306-10-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210423163437.89306-1-andriy.shevchenko@linux.intel.com>
References: <20210423163437.89306-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There are few places that repeat the logic of "update if changed".
Extract pxa2xx_spi_update() helper to deduplicate that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index f85c7439757c..4b3237f14ead 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -200,6 +200,12 @@ static bool is_mmp2_ssp(const struct driver_data *drv_data)
 	return drv_data->ssp_type == MMP2_SSP;
 }
 
+static void pxa2xx_spi_update(const struct driver_data *drv_data, u32 reg, u32 mask, u32 value)
+{
+	if ((pxa2xx_spi_read(drv_data, reg) & mask) != value)
+		pxa2xx_spi_write(drv_data, reg, value & mask);
+}
+
 static u32 pxa2xx_spi_get_ssrc1_change_mask(const struct driver_data *drv_data)
 {
 	switch (drv_data->ssp_type) {
@@ -1081,19 +1087,12 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *controller,
 			dma_mapped ? "DMA" : "PIO");
 
 	if (is_lpss_ssp(drv_data)) {
-		if ((pxa2xx_spi_read(drv_data, SSIRF) & 0xff)
-		    != chip->lpss_rx_threshold)
-			pxa2xx_spi_write(drv_data, SSIRF,
-					 chip->lpss_rx_threshold);
-		if ((pxa2xx_spi_read(drv_data, SSITF) & 0xffff)
-		    != chip->lpss_tx_threshold)
-			pxa2xx_spi_write(drv_data, SSITF,
-					 chip->lpss_tx_threshold);
+		pxa2xx_spi_update(drv_data, SSIRF, GENMASK(7, 0), chip->lpss_rx_threshold);
+		pxa2xx_spi_update(drv_data, SSITF, GENMASK(15, 0), chip->lpss_tx_threshold);
 	}
 
-	if (is_quark_x1000_ssp(drv_data) &&
-	    (pxa2xx_spi_read(drv_data, DDS_RATE) != chip->dds_rate))
-		pxa2xx_spi_write(drv_data, DDS_RATE, chip->dds_rate);
+	if (is_quark_x1000_ssp(drv_data))
+		pxa2xx_spi_update(drv_data, DDS_RATE, GENMASK(23, 0), chip->dds_rate);
 
 	/* Stop the SSP */
 	if (!is_mmp2_ssp(drv_data))
@@ -1102,15 +1101,11 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *controller,
 	if (!pxa25x_ssp_comp(drv_data))
 		pxa2xx_spi_write(drv_data, SSTO, chip->timeout);
 
+	/* first set CR1 without interrupt and service enables */
+	pxa2xx_spi_update(drv_data, SSCR1, change_mask, cr1);
+
 	/* see if we need to reload the config registers */
-	if ((pxa2xx_spi_read(drv_data, SSCR0) != cr0)
-	    || (pxa2xx_spi_read(drv_data, SSCR1) & change_mask)
-	    != (cr1 & change_mask)) {
-		/* first set CR1 without interrupt and service enables */
-		pxa2xx_spi_write(drv_data, SSCR1, cr1 & change_mask);
-		/* Update the other bits */
-		pxa2xx_spi_write(drv_data, SSCR0, cr0);
-	}
+	pxa2xx_spi_update(drv_data, SSCR0, GENMASK(31, 0), cr0);
 
 	/* Restart the SSP */
 	pxa_ssp_enable(drv_data->ssp);
-- 
2.30.2

