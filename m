Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3C53CCED0
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jul 2021 09:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbhGSHvd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Jul 2021 03:51:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:14956 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234892AbhGSHva (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 19 Jul 2021 03:51:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10049"; a="296571128"
X-IronPort-AV: E=Sophos;i="5.84,251,1620716400"; 
   d="scan'208";a="296571128"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 00:48:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,251,1620716400"; 
   d="scan'208";a="495724107"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 19 Jul 2021 00:48:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id ACDFC23A; Mon, 19 Jul 2021 10:48:46 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v1 2/3] spi: pxa2xx: Reset DMA bits in CR1 in reset_sccr1()
Date:   Mon, 19 Jul 2021 10:48:41 +0300
Message-Id: <20210719074842.36060-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719074842.36060-1-andriy.shevchenko@linux.intel.com>
References: <20210719074842.36060-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In order to allow reset_sccr1() to be reused in DMA paths,
reset DMA bits in CR1 in this function.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 7c4c8179a329..833eb52ed305 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -595,7 +595,7 @@ static int u32_reader(struct driver_data *drv_data)
 static void reset_sccr1(struct driver_data *drv_data)
 {
 	struct chip_data *chip = spi_get_ctldata(drv_data->controller->cur_msg->spi);
-	u32 mask = drv_data->int_cr1;
+	u32 mask = drv_data->int_cr1 | drv_data->dma_cr1;
 
 	switch (drv_data->ssp_type) {
 	case QUARK_X1000_SSP:
-- 
2.30.2

