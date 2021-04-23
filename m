Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6541D369967
	for <lists+linux-spi@lfdr.de>; Fri, 23 Apr 2021 20:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243598AbhDWSZR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Apr 2021 14:25:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:3219 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243694AbhDWSZP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 23 Apr 2021 14:25:15 -0400
IronPort-SDR: Qfgq1dUeG4bZRmOfF40/b1Mu3tKEEIld7d0aDkkcKKWEh/e2RTcd3S9ZxihiqorNKqvZQg3UUv
 7kQG1vzEOCRg==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="196224418"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="196224418"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 11:24:38 -0700
IronPort-SDR: U/37f9OoSV0aKrC9Y73c4V0EvRaVfoGxDgZa1EL77k32X3qbOhdmp0U4IOhpT85ap4K4aOERW5
 0V7kdVzh5pCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="424320840"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 23 Apr 2021 11:24:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 676F0B46; Fri, 23 Apr 2021 21:24:45 +0300 (EEST)
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
Subject: [PATCH v2 11/14] spi: pxa2xx: Extract clear_SSCR1_bits() helper
Date:   Fri, 23 Apr 2021 21:24:38 +0300
Message-Id: <20210423182441.50272-12-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
References: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
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
index 4b3237f14ead..58178ba704dc 100644
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

