Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793F4365AE5
	for <lists+linux-spi@lfdr.de>; Tue, 20 Apr 2021 16:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbhDTOKh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Apr 2021 10:10:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:53108 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232419AbhDTOKf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 20 Apr 2021 10:10:35 -0400
IronPort-SDR: X4tCb9eVx4pjQFVv0FnOBAExSrdA//gp6io9ZMZblrX0B6fXnxjdQE4f5GPbwqJ5gjvjp1uAb0
 QeTzjv5P340A==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="259468037"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="259468037"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 07:09:51 -0700
IronPort-SDR: UmPkwVtWtavJxWHRYc0BdlzeZAJ6Sp97XNjuWI65xaZIdb7lsBQ3jE1gEFYEh5SUyv5E5/UX7+
 BwrBwfbbbHiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="616908757"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 20 Apr 2021 07:09:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 698AF11F; Tue, 20 Apr 2021 17:10:06 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] spi: Allow to have all native CSs in use along with GPIOs
Date:   Tue, 20 Apr 2021 17:10:03 +0300
Message-Id: <20210420141004.59936-1-andriy.shevchenko@linux.intel.com>
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

