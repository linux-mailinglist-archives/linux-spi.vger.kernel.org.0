Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5372937A8E6
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 16:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhEKOTB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 10:19:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:39655 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231874AbhEKOS6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 May 2021 10:18:58 -0400
IronPort-SDR: VBW2aSppZNLuaiXwd0aCJfvTSzpRhLkeKNgYG7BB5kjJjWFqSVr+rUxjy3VLy4BhrdYAqJKI7x
 iPBpoo4kWB2w==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="179045752"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="179045752"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 07:17:10 -0700
IronPort-SDR: sMTBIb3UrfRSQTkkHtDsfXe51LMmb48wvkl4bfyOyhDfveDi3YwAl1tAqrPJBG1QCBQk31LH4U
 YBeBMQaF6GGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="621829411"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 11 May 2021 07:17:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 75D003F6; Tue, 11 May 2021 17:17:27 +0300 (EEST)
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
Subject: [PATCH v3 4/8] spi: pxa2xx: Extract clear_SSCR1_bits() helper
Date:   Tue, 11 May 2021 17:17:21 +0300
Message-Id: <20210511141725.32097-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210511141725.32097-1-andriy.shevchenko@linux.intel.com>
References: <20210511141725.32097-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There are few places that repeat the logic of "clear some bits in SSCR1".
Extract clear_SSCR1_bits() helper to deduplicate that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-dma.c | 4 +---
 drivers/spi/spi-pxa2xx.c     | 7 ++-----
 drivers/spi/spi-pxa2xx.h     | 5 +++++
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index 5ca01ad7f460..e581027e99f9 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -41,9 +41,7 @@ static void pxa2xx_spi_dma_transfer_complete(struct driver_data *drv_data,
 		}
 
 		/* Clear status & disable interrupts */
-		pxa2xx_spi_write(drv_data, SSCR1,
-				 pxa2xx_spi_read(drv_data, SSCR1)
-				 & ~drv_data->dma_cr1);
+		clear_SSCR1_bits(drv_data, drv_data->dma_cr1);
 		write_SSSR_CS(drv_data, drv_data->clear_sr);
 		if (!pxa25x_ssp_comp(drv_data))
 			pxa2xx_spi_write(drv_data, SSTO, 0);
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 54eaa048651f..3a4ad16614f7 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -733,8 +733,7 @@ static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
 static void handle_bad_msg(struct driver_data *drv_data)
 {
 	pxa2xx_spi_off(drv_data);
-	pxa2xx_spi_write(drv_data, SSCR1,
-			 pxa2xx_spi_read(drv_data, SSCR1) & ~drv_data->int_cr1);
+	clear_SSCR1_bits(drv_data, drv_data->int_cr1);
 	if (!pxa25x_ssp_comp(drv_data))
 		pxa2xx_spi_write(drv_data, SSTO, 0);
 	write_SSSR_CS(drv_data, drv_data->clear_sr);
@@ -1161,9 +1160,7 @@ static void pxa2xx_spi_handle_err(struct spi_controller *controller,
 	pxa2xx_spi_off(drv_data);
 	/* Clear and disable interrupts and service requests */
 	write_SSSR_CS(drv_data, drv_data->clear_sr);
-	pxa2xx_spi_write(drv_data, SSCR1,
-			 pxa2xx_spi_read(drv_data, SSCR1)
-			 & ~(drv_data->int_cr1 | drv_data->dma_cr1));
+	clear_SSCR1_bits(drv_data, drv_data->int_cr1 | drv_data->dma_cr1);
 	if (!pxa25x_ssp_comp(drv_data))
 		pxa2xx_spi_write(drv_data, SSTO, 0);
 
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 739e264feaa6..ed63f7165cd8 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -105,6 +105,11 @@ static inline int pxa25x_ssp_comp(struct driver_data *drv_data)
 	}
 }
 
+static inline void clear_SSCR1_bits(const struct driver_data *drv_data, u32 bits)
+{
+	pxa2xx_spi_write(drv_data, SSCR1, pxa2xx_spi_read(drv_data, SSCR1) & ~bits);
+}
+
 static inline void write_SSSR_CS(struct driver_data *drv_data, u32 val)
 {
 	if (drv_data->ssp_type == CE4100_SSP ||
-- 
2.30.2

