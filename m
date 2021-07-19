Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2BE3CCED1
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jul 2021 09:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbhGSHve (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Jul 2021 03:51:34 -0400
Received: from mga04.intel.com ([192.55.52.120]:42170 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234932AbhGSHva (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 19 Jul 2021 03:51:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10049"; a="209106661"
X-IronPort-AV: E=Sophos;i="5.84,251,1620716400"; 
   d="scan'208";a="209106661"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 00:48:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,251,1620716400"; 
   d="scan'208";a="414231101"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 19 Jul 2021 00:48:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8728E103; Mon, 19 Jul 2021 10:48:45 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v1 1/3] spi: pxa2xx: Convert reset_sccr1() to use pxa2xx_spi_update()
Date:   Mon, 19 Jul 2021 10:48:40 +0300
Message-Id: <20210719074842.36060-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Convert reset_sccr1() to use pxa2xx_spi_update().
It will help for further improvements.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 974e30744b83..7c4c8179a329 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -594,24 +594,22 @@ static int u32_reader(struct driver_data *drv_data)
 
 static void reset_sccr1(struct driver_data *drv_data)
 {
-	struct chip_data *chip =
-		spi_get_ctldata(drv_data->controller->cur_msg->spi);
-	u32 sccr1_reg;
+	struct chip_data *chip = spi_get_ctldata(drv_data->controller->cur_msg->spi);
+	u32 mask = drv_data->int_cr1;
 
-	sccr1_reg = pxa2xx_spi_read(drv_data, SSCR1) & ~drv_data->int_cr1;
 	switch (drv_data->ssp_type) {
 	case QUARK_X1000_SSP:
-		sccr1_reg &= ~QUARK_X1000_SSCR1_RFT;
+		mask |= QUARK_X1000_SSCR1_RFT;
 		break;
 	case CE4100_SSP:
-		sccr1_reg &= ~CE4100_SSCR1_RFT;
+		mask |= CE4100_SSCR1_RFT;
 		break;
 	default:
-		sccr1_reg &= ~SSCR1_RFT;
+		mask |= SSCR1_RFT;
 		break;
 	}
-	sccr1_reg |= chip->threshold;
-	pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg);
+
+	pxa2xx_spi_update(drv_data, SSCR1, mask, chip->threshold);
 }
 
 static void int_stop_and_reset(struct driver_data *drv_data)
-- 
2.30.2

