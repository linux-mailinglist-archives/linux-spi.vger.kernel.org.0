Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4EDE365DA3
	for <lists+linux-spi@lfdr.de>; Tue, 20 Apr 2021 18:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbhDTQop (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Apr 2021 12:44:45 -0400
Received: from mga18.intel.com ([134.134.136.126]:43728 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232504AbhDTQoo (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 20 Apr 2021 12:44:44 -0400
IronPort-SDR: +uMUa0AbBr1Y2cR1OOgMa0eb/mk966i1j3Yg3Xi4LSDCqbqO0RYcVKEpvIN60TkEaENgoDKaII
 y2P2mdW2rWKw==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="183034461"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="183034461"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 09:44:12 -0700
IronPort-SDR: 4FEJkK2qsvZ7J1racoP3GUaZUgoB/YJlN4bSwseSYhTP5f379QjJrMiMxrRnGh6/OGOFB8cNBz
 kSCOi0RFwFTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="454900279"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 20 Apr 2021 09:44:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E0792BB; Tue, 20 Apr 2021 19:44:27 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/2] spi: Allow to have all native CSs in use along with GPIOs
Date:   Tue, 20 Apr 2021 19:44:24 +0300
Message-Id: <20210420164425.40287-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The commit 7d93aecdb58d ("spi: Add generic support for unused native cs
with cs-gpios") excludes the valid case for the controllers that doesn't
need to switch native CS in order to perform the transfer, i.e. when

  0		native
  ...		...
  <n> - 1	native
  <n>		GPIO
  <n> + 1	GPIO
  ...		...

where <n> defines maximum of native CSs supported by the controller.

To allow this, bail out from spi_get_gpio_descs() conditionally for
the controllers which explicitly marked with SPI_MASTER_GPIO_SS.

Fixes: 7d93aecdb58d ("spi: Add generic support for unused native cs with cs-gpios")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
 drivers/spi/spi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 36c46feab6d4..9c3730a9f7d5 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2610,8 +2610,9 @@ static int spi_get_gpio_descs(struct spi_controller *ctlr)
 	}
 
 	ctlr->unused_native_cs = ffz(native_cs_mask);
-	if (num_cs_gpios && ctlr->max_native_cs &&
-	    ctlr->unused_native_cs >= ctlr->max_native_cs) {
+
+	if ((ctlr->flags & SPI_MASTER_GPIO_SS) && num_cs_gpios &&
+	    ctlr->max_native_cs && ctlr->unused_native_cs >= ctlr->max_native_cs) {
 		dev_err(dev, "No unused native chip select available\n");
 		return -EINVAL;
 	}
-- 
2.30.2

