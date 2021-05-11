Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2CB37A8E2
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 16:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhEKOSx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 10:18:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:26618 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231857AbhEKOSo (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 May 2021 10:18:44 -0400
IronPort-SDR: jmA9C+LOCtHum1XJMp9NvJwsqE0Yvlf2X0EQKgu86nfgudExLe3b7SFqYYJvYrZNcVQZA3LKU1
 nUii6VYd1g1Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="284942940"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="284942940"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 07:17:09 -0700
IronPort-SDR: rltezOshwPEL1HjTshwq+B93Ge7Bess4eDVheq5rUKGaIAbuOgua2MiQt2glJdWstG+h6yjB87
 djWCiM2n+g6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="399331159"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 11 May 2021 07:17:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6D00A3C0; Tue, 11 May 2021 17:17:27 +0300 (EEST)
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
Subject: [PATCH v3 3/8] spi: pxa2xx: Extract pxa2xx_spi_update() helper
Date:   Tue, 11 May 2021 17:17:20 +0300
Message-Id: <20210511141725.32097-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210511141725.32097-1-andriy.shevchenko@linux.intel.com>
References: <20210511141725.32097-1-andriy.shevchenko@linux.intel.com>
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
index a27f51f5db65..54eaa048651f 100644
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

