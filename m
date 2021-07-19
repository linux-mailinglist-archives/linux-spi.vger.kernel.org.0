Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026483CCED2
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jul 2021 09:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbhGSHve (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Jul 2021 03:51:34 -0400
Received: from mga09.intel.com ([134.134.136.24]:1357 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234895AbhGSHva (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 19 Jul 2021 03:51:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10049"; a="211006924"
X-IronPort-AV: E=Sophos;i="5.84,251,1620716400"; 
   d="scan'208";a="211006924"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 00:48:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,251,1620716400"; 
   d="scan'208";a="499800520"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Jul 2021 00:48:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 408BF24D; Mon, 19 Jul 2021 10:48:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v1 3/3] spi: pxa2xx: Reuse int_stop_and_reset() in couple of places
Date:   Mon, 19 Jul 2021 10:48:42 +0300
Message-Id: <20210719074842.36060-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719074842.36060-1-andriy.shevchenko@linux.intel.com>
References: <20210719074842.36060-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Reuse int_stop_and_reset() in couple of places.

While at it, change the order of the int_stop_and_reset() and pxa2xx_spi_off()
to be in align with the similar flow in int_error_stop().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 833eb52ed305..19a2d1ea7d42 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -722,11 +722,8 @@ static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
 
 static void handle_bad_msg(struct driver_data *drv_data)
 {
+	int_stop_and_reset(drv_data);
 	pxa2xx_spi_off(drv_data);
-	clear_SSCR1_bits(drv_data, drv_data->int_cr1);
-	if (!pxa25x_ssp_comp(drv_data))
-		pxa2xx_spi_write(drv_data, SSTO, 0);
-	write_SSSR_CS(drv_data, drv_data->clear_sr);
 
 	dev_err(drv_data->ssp->dev, "bad message state in interrupt handler\n");
 }
@@ -1154,13 +1151,10 @@ static void pxa2xx_spi_handle_err(struct spi_controller *controller,
 {
 	struct driver_data *drv_data = spi_controller_get_devdata(controller);
 
+	int_stop_and_reset(drv_data);
+
 	/* Disable the SSP */
 	pxa2xx_spi_off(drv_data);
-	/* Clear and disable interrupts and service requests */
-	write_SSSR_CS(drv_data, drv_data->clear_sr);
-	clear_SSCR1_bits(drv_data, drv_data->int_cr1 | drv_data->dma_cr1);
-	if (!pxa25x_ssp_comp(drv_data))
-		pxa2xx_spi_write(drv_data, SSTO, 0);
 
 	/*
 	 * Stop the DMA if running. Note DMA callback handler may have unset
-- 
2.30.2

