Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F156031C968
	for <lists+linux-spi@lfdr.de>; Tue, 16 Feb 2021 12:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbhBPLKE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Feb 2021 06:10:04 -0500
Received: from mga09.intel.com ([134.134.136.24]:49486 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230049AbhBPLJU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Feb 2021 06:09:20 -0500
IronPort-SDR: F/ONUZqqmfmlElqziYAoT9gvFoUBrv9dl1vGSfft/n1RjT95KIaAACuNsa+zk4AP9X7SS16Bt7
 cBstjTbGBvDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9896"; a="182992613"
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; 
   d="scan'208";a="182992613"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 03:07:47 -0800
IronPort-SDR: yIB21iHD5n0T4QrLFJY27zSx33lUfLBxLL7myxINaHMWDtx4u7jQgkzd8AQb1V3giPoz0+yPrg
 12KxDVBCD1Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; 
   d="scan'208";a="377522912"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 16 Feb 2021 03:07:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1E692169; Tue, 16 Feb 2021 13:07:45 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] spi: butterfly: Switch to use module_parport_driver()
Date:   Tue, 16 Feb 2021 13:07:40 +0200
Message-Id: <20210216110741.1286-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210216110741.1286-1-andriy.shevchenko@linux.intel.com>
References: <20210216110741.1286-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Switch to use module_parport_driver() to reduce boilerplate code.
Note, device_initcall() is a default for module_init().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
v2: added Ack (Mark)
 drivers/spi/spi-butterfly.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/spi/spi-butterfly.c b/drivers/spi/spi-butterfly.c
index 7e71a351f3b7..cceae816cebc 100644
--- a/drivers/spi/spi-butterfly.c
+++ b/drivers/spi/spi-butterfly.c
@@ -317,18 +317,7 @@ static struct parport_driver butterfly_driver = {
 	.detach =	butterfly_detach,
 	.devmodel = true,
 };
-
-static int __init butterfly_init(void)
-{
-	return parport_register_driver(&butterfly_driver);
-}
-device_initcall(butterfly_init);
-
-static void __exit butterfly_exit(void)
-{
-	parport_unregister_driver(&butterfly_driver);
-}
-module_exit(butterfly_exit);
+module_parport_driver(butterfly_driver);
 
 MODULE_DESCRIPTION("Parport Adapter driver for AVR Butterfly");
 MODULE_LICENSE("GPL");
-- 
2.30.0

