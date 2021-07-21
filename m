Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D0D3D0EAA
	for <lists+linux-spi@lfdr.de>; Wed, 21 Jul 2021 14:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbhGULeV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Jul 2021 07:34:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:58922 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231680AbhGULeU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 21 Jul 2021 07:34:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="296983574"
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="296983574"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 05:14:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="576673333"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jul 2021 05:14:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 197EE103; Wed, 21 Jul 2021 15:15:22 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v1 1/1] spi: pxa2xx: Adapt reset_sccr1() to the case when no message available
Date:   Wed, 21 Jul 2021 15:15:20 +0300
Message-Id: <20210721121520.62605-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In some cases reset_sccr1() can be called when no message available.
This means that there is no associated chip to receive that message
and hence no threshold needs to be set. Adapt the function to such
cases.

Fixes: 3bbdc083262d ("spi: pxa2xx: Reuse int_stop_and_reset() in couple of places")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 793cb80f92c7..2b4d633dd9df 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -594,8 +594,15 @@ static int u32_reader(struct driver_data *drv_data)
 
 static void reset_sccr1(struct driver_data *drv_data)
 {
-	struct chip_data *chip = spi_get_ctldata(drv_data->controller->cur_msg->spi);
-	u32 mask = drv_data->int_cr1 | drv_data->dma_cr1;
+	u32 mask = drv_data->int_cr1 | drv_data->dma_cr1, threshold;
+	struct chip_data *chip;
+
+	if (drv_data->controller->cur_msg) {
+		chip = spi_get_ctldata(drv_data->controller->cur_msg->spi);
+		threshold = chip->threshold;
+	} else {
+		threshold = 0;
+	}
 
 	switch (drv_data->ssp_type) {
 	case QUARK_X1000_SSP:
@@ -609,7 +616,7 @@ static void reset_sccr1(struct driver_data *drv_data)
 		break;
 	}
 
-	pxa2xx_spi_update(drv_data, SSCR1, mask, chip->threshold);
+	pxa2xx_spi_update(drv_data, SSCR1, mask, threshold);
 }
 
 static void int_stop_and_reset(struct driver_data *drv_data)
-- 
2.30.2

