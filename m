Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDC9365DA4
	for <lists+linux-spi@lfdr.de>; Tue, 20 Apr 2021 18:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbhDTQop (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Apr 2021 12:44:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:3030 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232916AbhDTQoo (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 20 Apr 2021 12:44:44 -0400
IronPort-SDR: LkK24RjWW/QGpmSByTyb66ASZuDCqrhh92aV16xH9hQKy7Fy6CNMKML/ygnLNB1mtVO690J0er
 L0KUEplSYGoA==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="195098657"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="195098657"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 09:44:12 -0700
IronPort-SDR: HcaxeBXaOCRlZFWSlqoRGIc79xOi2yvB/OxQoB+GpZUB16je5aAAJ/a238bGskr4zNq0cYrISu
 NC+0XunhHXxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="427063562"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 20 Apr 2021 09:44:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7FBAD103; Tue, 20 Apr 2021 19:44:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/2] spi: Avoid undefined behaviour when counting unused native CSs
Date:   Tue, 20 Apr 2021 19:44:25 +0300
Message-Id: <20210420164425.40287-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210420164425.40287-1-andriy.shevchenko@linux.intel.com>
References: <20210420164425.40287-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

ffz(), that has been used to count unused native CSs,
might cause undefined behaviour when called against ~0U.
To fix that, open code it with ffs(~value) - 1.

Fixes: 7d93aecdb58d ("spi: Add generic support for unused native cs with cs-gpios")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: decoded UB abbreviation (Mark)
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

