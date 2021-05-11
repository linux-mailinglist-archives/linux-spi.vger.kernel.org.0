Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E337437A93D
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 16:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbhEKO3G (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 10:29:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:14161 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231695AbhEKO26 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 May 2021 10:28:58 -0400
IronPort-SDR: FUL9tQChoJiBkdsmRi5dzy26XSMhGt136kcNPf4aqa+gAzGtj/JMJMcm2eREYcIlUy6fZRY8FI
 WeVOaOYj6mIA==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="186589310"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="186589310"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 07:27:51 -0700
IronPort-SDR: zz2or6VVa38RLBagJ9ktTW3/8WFLjGo50CvmFaYOHFNkv2g6qGK45xVkWOIdv5+CvtSGsNKsW+
 GP/HsY+GK8kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="471139863"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 11 May 2021 07:26:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DED3514B; Tue, 11 May 2021 17:27:12 +0300 (EEST)
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
Subject: [PATCH v4 1/8] spi: pxa2xx: Introduce int_stop_and_reset() helper
Date:   Tue, 11 May 2021 17:27:04 +0300
Message-Id: <20210511142711.23244-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210511142711.23244-1-andriy.shevchenko@linux.intel.com>
References: <20210511142711.23244-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Currently we have three times the same few lines repeated in the code.
Deduplicate them by newly introduced int_stop_and_reset() helper.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 1d4c7f4217ed..5572eec68381 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -620,13 +620,20 @@ static void reset_sccr1(struct driver_data *drv_data)
 	pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg);
 }
 
-static void int_error_stop(struct driver_data *drv_data, const char *msg)
+static void int_stop_and_reset(struct driver_data *drv_data)
 {
-	/* Stop and reset SSP */
+	/* Clear and disable interrupts */
 	write_SSSR_CS(drv_data, drv_data->clear_sr);
 	reset_sccr1(drv_data);
-	if (!pxa25x_ssp_comp(drv_data))
-		pxa2xx_spi_write(drv_data, SSTO, 0);
+	if (pxa25x_ssp_comp(drv_data))
+		return;
+
+	pxa2xx_spi_write(drv_data, SSTO, 0);
+}
+
+static void int_error_stop(struct driver_data *drv_data, const char *msg)
+{
+	int_stop_and_reset(drv_data);
 	pxa2xx_spi_flush(drv_data);
 	pxa2xx_spi_off(drv_data);
 
@@ -638,11 +645,7 @@ static void int_error_stop(struct driver_data *drv_data, const char *msg)
 
 static void int_transfer_complete(struct driver_data *drv_data)
 {
-	/* Clear and disable interrupts */
-	write_SSSR_CS(drv_data, drv_data->clear_sr);
-	reset_sccr1(drv_data);
-	if (!pxa25x_ssp_comp(drv_data))
-		pxa2xx_spi_write(drv_data, SSTO, 0);
+	int_stop_and_reset(drv_data);
 
 	spi_finalize_current_transfer(drv_data->controller);
 }
@@ -1151,11 +1154,7 @@ static int pxa2xx_spi_slave_abort(struct spi_controller *controller)
 {
 	struct driver_data *drv_data = spi_controller_get_devdata(controller);
 
-	/* Stop and reset SSP */
-	write_SSSR_CS(drv_data, drv_data->clear_sr);
-	reset_sccr1(drv_data);
-	if (!pxa25x_ssp_comp(drv_data))
-		pxa2xx_spi_write(drv_data, SSTO, 0);
+	int_stop_and_reset(drv_data);
 	pxa2xx_spi_flush(drv_data);
 	pxa2xx_spi_off(drv_data);
 
-- 
2.30.2

