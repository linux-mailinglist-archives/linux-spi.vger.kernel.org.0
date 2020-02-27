Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F77D17234E
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2020 17:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgB0Q0B (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Feb 2020 11:26:01 -0500
Received: from mga12.intel.com ([192.55.52.136]:62468 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729169AbgB0Q0B (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 27 Feb 2020 11:26:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 08:26:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,492,1574150400"; 
   d="scan'208";a="317834825"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 27 Feb 2020 08:25:58 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1CB6714B; Thu, 27 Feb 2020 18:25:56 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] spi: pxa2xx: Introduce is_mmp2_ssp() helper
Date:   Thu, 27 Feb 2020 18:25:56 +0200
Message-Id: <20200227162556.3152-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Introduce is_mmp2_ssp() helper to be consistent with the rest
helper function to distinguish SSP type.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 19d43c7ed1a0..b9db6bbd03e0 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -185,6 +185,11 @@ static bool is_quark_x1000_ssp(const struct driver_data *drv_data)
 	return drv_data->ssp_type == QUARK_X1000_SSP;
 }
 
+static bool is_mmp2_ssp(const struct driver_data *drv_data)
+{
+	return drv_data->ssp_type == MMP2_SSP;
+}
+
 static u32 pxa2xx_spi_get_ssrc1_change_mask(const struct driver_data *drv_data)
 {
 	switch (drv_data->ssp_type) {
@@ -463,8 +468,8 @@ int pxa2xx_spi_flush(struct driver_data *drv_data)
 
 static void pxa2xx_spi_off(struct driver_data *drv_data)
 {
-	/* On MMP, disabling SSE seems to corrupt the rx fifo */
-	if (drv_data->ssp_type == MMP2_SSP)
+	/* On MMP, disabling SSE seems to corrupt the Rx FIFO */
+	if (is_mmp2_ssp(drv_data))
 		return;
 
 	pxa2xx_spi_write(drv_data, SSCR0,
@@ -1070,7 +1075,7 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *controller,
 	    || (pxa2xx_spi_read(drv_data, SSCR1) & change_mask)
 	    != (cr1 & change_mask)) {
 		/* stop the SSP, and update the other bits */
-		if (drv_data->ssp_type != MMP2_SSP)
+		if (!is_mmp2_ssp(drv_data))
 			pxa2xx_spi_write(drv_data, SSCR0, cr0 & ~SSCR0_SSE);
 		if (!pxa25x_ssp_comp(drv_data))
 			pxa2xx_spi_write(drv_data, SSTO, chip->timeout);
@@ -1084,7 +1089,7 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *controller,
 			pxa2xx_spi_write(drv_data, SSTO, chip->timeout);
 	}
 
-	if (drv_data->ssp_type == MMP2_SSP) {
+	if (is_mmp2_ssp(drv_data)) {
 		u8 tx_level = (pxa2xx_spi_read(drv_data, SSSR)
 					& SSSR_TFL_MASK) >> 8;
 
-- 
2.25.0

