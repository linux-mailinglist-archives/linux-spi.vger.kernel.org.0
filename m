Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782CC32C6ED
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 02:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbhCDAa1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Mar 2021 19:30:27 -0500
Received: from mga04.intel.com ([192.55.52.120]:40801 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357397AbhCCKtl (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 3 Mar 2021 05:49:41 -0500
IronPort-SDR: x+OvfQ8kh9yE037ElUIzsaBKYWSxr6BKdPxAlElRkJfpNR3NAFAvsTsYQmpc1wnfJ48AvbhatQ
 Fl9LMYay4hkA==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="184731228"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="184731228"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 01:16:57 -0800
IronPort-SDR: HlrOf6E20vkvsulGkFFHov5kbYGgScgOU705rG0tVprAQJlL53Chwuhqnj8YK/T275m/+SyAx/
 5Sl1CPw8OKrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="383914452"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 03 Mar 2021 01:16:55 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 47207F4; Wed,  3 Mar 2021 11:16:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 2/3] spi: butterfly: Switch to use module_parport_driver()
Date:   Wed,  3 Mar 2021 11:16:41 +0200
Message-Id: <20210303091642.23929-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210303091642.23929-1-andriy.shevchenko@linux.intel.com>
References: <20210303091642.23929-1-andriy.shevchenko@linux.intel.com>
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
2.30.1

