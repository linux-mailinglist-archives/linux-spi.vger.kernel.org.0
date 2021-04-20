Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7106D365ADE
	for <lists+linux-spi@lfdr.de>; Tue, 20 Apr 2021 16:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhDTOKY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Apr 2021 10:10:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:23728 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231758AbhDTOKX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 20 Apr 2021 10:10:23 -0400
IronPort-SDR: RLsquzDJdRXzztuUTP43U04QwuCFXN5apyf/5Tb8RqSLMe5sF3Ytv52VGDmNeRhpRaHBai/Fja
 FLilMUFn+4lg==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="216102618"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="216102618"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 07:09:51 -0700
IronPort-SDR: PFU2atH3rryrxPMT9IJGqTU/Vl1E3KmeCFnpTxqKMsVVjAfXhWHOT+804ZaFB5egC4mnSXTMT+
 X5A17VQI6hVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="391031403"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 20 Apr 2021 07:09:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CDEE31A1; Tue, 20 Apr 2021 17:10:07 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] spi: Avoid potential UB when counting unused native CSs
Date:   Tue, 20 Apr 2021 17:10:04 +0300
Message-Id: <20210420141004.59936-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210420141004.59936-1-andriy.shevchenko@linux.intel.com>
References: <20210420141004.59936-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

ffz(), that has been used to count unused native CSs, might produce UB
when called against ~0U. To fix that, open code it with ffs(~value) - 1.

Fixes: 7d93aecdb58d ("spi: Add generic support for unused native cs with cs-gpios")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9c3730a9f7d5..01f95bee2ac8 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2609,7 +2609,7 @@ static int spi_get_gpio_descs(struct spi_controller *ctlr)
 		native_cs_mask |= BIT(i);
 	}
 
-	ctlr->unused_native_cs = ffz(native_cs_mask);
+	ctlr->unused_native_cs = ffs(~native_cs_mask) - 1;
 
 	if ((ctlr->flags & SPI_MASTER_GPIO_SS) && num_cs_gpios &&
 	    ctlr->max_native_cs && ctlr->unused_native_cs >= ctlr->max_native_cs) {
-- 
2.30.2

