Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830323659C5
	for <lists+linux-spi@lfdr.de>; Tue, 20 Apr 2021 15:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbhDTNTc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Apr 2021 09:19:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:44700 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232303AbhDTNTc (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 20 Apr 2021 09:19:32 -0400
IronPort-SDR: 1MGHfaHRFLlOFpZYOYsoR+3V4kqGtRwkDARfxGZ0Jq9uKX7PPEUcAjhGVo+LVUsIHRsuw4KysL
 +8sSAmwUOpTw==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="182635238"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="182635238"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 06:19:00 -0700
IronPort-SDR: 7ohHJHBTs4yR61BAujVsrQwlVfsHlvcPtg7fufCWG7lok+h7eZCxoSzIY0T2YsAFCMOnvJC12r
 czHC3A8dgq4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="445508759"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 20 Apr 2021 06:18:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0A6141A1; Tue, 20 Apr 2021 16:19:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] spi: Don't overwrite num_chipselect with error code
Date:   Tue, 20 Apr 2021 16:19:01 +0300
Message-Id: <20210420131901.80233-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The code currently organized in a way that num_chipselect is overwritten
each time we call spi_get_gpio_descs(). It might be potentially dangerous
in case when the gpiod_count() returns an error code.

Note, that gpiod_count() never returns 0, take this into account as well.

Fixes: f3186dd87669 ("spi: Optionally use GPIO descriptors for CS GPIOs")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 74b2b1dd358b..36c46feab6d4 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2558,13 +2558,14 @@ static int spi_get_gpio_descs(struct spi_controller *ctlr)
 	unsigned int num_cs_gpios = 0;
 
 	nb = gpiod_count(dev, "cs");
-	ctlr->num_chipselect = max_t(int, nb, ctlr->num_chipselect);
-
-	/* No GPIOs at all is fine, else return the error */
-	if (nb == 0 || nb == -ENOENT)
-		return 0;
-	else if (nb < 0)
+	if (nb < 0) {
+		/* No GPIOs at all is fine, else return the error */
+		if (nb == -ENOENT)
+			return 0;
 		return nb;
+	}
+
+	ctlr->num_chipselect = max_t(int, nb, ctlr->num_chipselect);
 
 	cs = devm_kcalloc(dev, ctlr->num_chipselect, sizeof(*cs),
 			  GFP_KERNEL);
-- 
2.30.2

