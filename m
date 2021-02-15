Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C1231C2FC
	for <lists+linux-spi@lfdr.de>; Mon, 15 Feb 2021 21:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhBOU1Q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Feb 2021 15:27:16 -0500
Received: from mga01.intel.com ([192.55.52.88]:42876 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229862AbhBOU1M (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Feb 2021 15:27:12 -0500
IronPort-SDR: Q0wn2qfksJLnRk12ZTudbBvEY0DNOR6Yl5otUQ5lc1vlpL8hlZDn4zBu8dMwBLwp0322brKy3u
 Y/pB3I6YVR9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9896"; a="201938401"
X-IronPort-AV: E=Sophos;i="5.81,181,1610438400"; 
   d="scan'208";a="201938401"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2021 12:24:06 -0800
IronPort-SDR: iPDvkAKrC8anhouVHKVKLXY878MuMJJWUW6LfD5QkRemXJtK3fxjitakRsJ37ok+QxOjpMbByq
 AFSJ6/aqVVUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,181,1610438400"; 
   d="scan'208";a="591533224"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 15 Feb 2021 12:24:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 99B09F2; Mon, 15 Feb 2021 22:24:03 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 2/3] spi: butterfly: Switch to use module_parport_driver()
Date:   Mon, 15 Feb 2021 22:23:52 +0200
Message-Id: <20210215202353.18515-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210215202353.18515-1-andriy.shevchenko@linux.intel.com>
References: <20210215202353.18515-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Switch to use module_parport_driver() to reduce boilerplate code.
Note, device_initcall() is a default for module_init().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
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

