Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A20931C2EE
	for <lists+linux-spi@lfdr.de>; Mon, 15 Feb 2021 21:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhBOUZw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Feb 2021 15:25:52 -0500
Received: from mga01.intel.com ([192.55.52.88]:42876 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229608AbhBOUZw (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Feb 2021 15:25:52 -0500
IronPort-SDR: 4jq+leocXXYeE1mUhzbFTBfq3VuxqQl8hQrJr4MrFrBhsQ798wxsvmtTMqXXauRvIuDXzPRKj4
 QJhzovO4meUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9896"; a="201938400"
X-IronPort-AV: E=Sophos;i="5.81,181,1610438400"; 
   d="scan'208";a="201938400"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2021 12:24:05 -0800
IronPort-SDR: N/DJxi9ju3HnN0vg9+yV6ehvsQzRl035SkGZCZzBSDexMjdidAo0+hfrCa/51G5TUFviSzkDpK
 mXvee+MfI7Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,181,1610438400"; 
   d="scan'208";a="591533223"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 15 Feb 2021 12:24:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8EB0512B; Mon, 15 Feb 2021 22:24:03 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/3] parport: Introduce module_parport_driver() helper macro
Date:   Mon, 15 Feb 2021 22:23:51 +0200
Message-Id: <20210215202353.18515-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Introduce module_parport_driver() helper macro to reduce boilerplate
in the existing and new code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/parport.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/parport.h b/include/linux/parport.h
index f981f794c850..af9b707d9b54 100644
--- a/include/linux/parport.h
+++ b/include/linux/parport.h
@@ -332,9 +332,19 @@ int __must_check __parport_register_driver(struct parport_driver *,
 	__parport_register_driver(driver, THIS_MODULE, KBUILD_MODNAME)
 
 /* Unregister a high-level driver. */
-extern void parport_unregister_driver (struct parport_driver *);
 void parport_unregister_driver(struct parport_driver *);
 
+/**
+ * module_parport_driver() - Helper macro for registering a modular parport driver
+ * @__parport_driver: struct parport_driver to be used
+ *
+ * Helper macro for parport drivers which do not do anything special in module
+ * init and exit. This eliminates a lot of boilerplate. Each module may only
+ * use this macro once, and calling it replaces module_init() and module_exit().
+ */
+#define module_parport_driver(__parport_driver) \
+	module_driver(__parport_driver, parport_add_driver, parport_del_driver)
+
 /* If parport_register_driver doesn't fit your needs, perhaps
  * parport_find_xxx does. */
 extern struct parport *parport_find_number (int);
-- 
2.30.0

