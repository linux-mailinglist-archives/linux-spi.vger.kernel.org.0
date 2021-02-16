Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26C131C96B
	for <lists+linux-spi@lfdr.de>; Tue, 16 Feb 2021 12:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhBPLLP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Feb 2021 06:11:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:49760 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230166AbhBPLJg (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Feb 2021 06:09:36 -0500
IronPort-SDR: J9wvyt27RbeQ2cHOsPa1XLuhNKgHi9JxSXO5KyscYAk2LFw2yWZFtu3fYjulZgMoFg6PezHQo3
 tv5E8QI7AKmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9896"; a="182992614"
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; 
   d="scan'208";a="182992614"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 03:07:47 -0800
IronPort-SDR: Iej7RUIaQ4Nz/7fArfd+rv/geugQgFE75rKmfPmnREXq02bkfqiEJQX2XwaO00SPpAAJkV5CtB
 2dGSzWaFSrRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; 
   d="scan'208";a="377522914"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 16 Feb 2021 03:07:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2774A2D5; Tue, 16 Feb 2021 13:07:45 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] spi: lm70llp: Switch to use module_parport_driver()
Date:   Tue, 16 Feb 2021 13:07:41 +0200
Message-Id: <20210216110741.1286-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210216110741.1286-1-andriy.shevchenko@linux.intel.com>
References: <20210216110741.1286-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Switch to use module_parport_driver() to reduce boilerplate code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
v2: added Ack (Mark), drop unneeded note from the commit message
 drivers/spi/spi-lm70llp.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/spi/spi-lm70llp.c b/drivers/spi/spi-lm70llp.c
index 174dba29b1dd..f914b8d2043e 100644
--- a/drivers/spi/spi-lm70llp.c
+++ b/drivers/spi/spi-lm70llp.c
@@ -320,18 +320,7 @@ static struct parport_driver spi_lm70llp_drv = {
 	.detach =	spi_lm70llp_detach,
 	.devmodel =	true,
 };
-
-static int __init init_spi_lm70llp(void)
-{
-	return parport_register_driver(&spi_lm70llp_drv);
-}
-module_init(init_spi_lm70llp);
-
-static void __exit cleanup_spi_lm70llp(void)
-{
-	parport_unregister_driver(&spi_lm70llp_drv);
-}
-module_exit(cleanup_spi_lm70llp);
+module_parport_driver(spi_lm70llp_drv);
 
 MODULE_AUTHOR("Kaiwan N Billimoria <kaiwan@designergraphix.com>");
 MODULE_DESCRIPTION(
-- 
2.30.0

