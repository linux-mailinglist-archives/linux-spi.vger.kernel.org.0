Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46EB131C2F0
	for <lists+linux-spi@lfdr.de>; Mon, 15 Feb 2021 21:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhBOUZw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Feb 2021 15:25:52 -0500
Received: from mga11.intel.com ([192.55.52.93]:43311 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229697AbhBOUZv (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Feb 2021 15:25:51 -0500
IronPort-SDR: xgF9sfYHzz/84FV6BJ2S2fw1m68TheuzgseFJSpk8sB+jG8rxqz/prWQWH6Ff1y5UFDxTN35Nf
 jLBXPx9PLH6A==
X-IronPort-AV: E=McAfee;i="6000,8403,9896"; a="179250744"
X-IronPort-AV: E=Sophos;i="5.81,181,1610438400"; 
   d="scan'208";a="179250744"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2021 12:24:06 -0800
IronPort-SDR: Ml0NcUWidTqS14GEPavJ4dHHxhFQW6fl0Nen4JfKNLRuy4XuVkWSGqWYtqpM6ts5TVpgSD/ntJ
 60HghMMU4o6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,181,1610438400"; 
   d="scan'208";a="425626297"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 15 Feb 2021 12:24:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A42D51F1; Mon, 15 Feb 2021 22:24:03 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 3/3] spi: lm70llp: Switch to use module_parport_driver()
Date:   Mon, 15 Feb 2021 22:23:53 +0200
Message-Id: <20210215202353.18515-3-andriy.shevchenko@linux.intel.com>
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

