Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C43365D84
	for <lists+linux-spi@lfdr.de>; Tue, 20 Apr 2021 18:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhDTQlH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Apr 2021 12:41:07 -0400
Received: from mga14.intel.com ([192.55.52.115]:2752 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233086AbhDTQlG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 20 Apr 2021 12:41:06 -0400
IronPort-SDR: VMHlKsX62VMGx0R24znkRU/AizGnCKSNK8NKhGajntnrWi9+9Bj73QAWMXkb3ruSpKaTe6eDrN
 uZaaWEvQNFFg==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="195098091"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="195098091"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 09:40:35 -0700
IronPort-SDR: G61wqN5XiqE8jobXA0CAhMiGLIhvP0DaVzO0/7C3Hc5f1GMBPsjDGfbra2Sk7+pxZk4ViXTnzj
 kI+brYE3ysag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="613828718"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 20 Apr 2021 09:40:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 45434BB; Tue, 20 Apr 2021 19:40:44 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] spi: Make error handling of gpiod_count() call cleaner
Date:   Tue, 20 Apr 2021 19:40:40 +0300
Message-Id: <20210420164040.40055-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Each time we call spi_get_gpio_descs() the num_chipselect is overwritten
either by new value or by the old one. This is an extra operation in case
gpiod_count() returns an error. Besides that it slashes the error handling
of gpiod_count().

Refactor the code to make error handling of gpiod_count() call cleaner.

Note, that gpiod_count() never returns 0, take this into account as well.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: reformulated commit message and dropped Fixes tag
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

