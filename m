Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D422031C96F
	for <lists+linux-spi@lfdr.de>; Tue, 16 Feb 2021 12:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhBPLL5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Feb 2021 06:11:57 -0500
Received: from mga05.intel.com ([192.55.52.43]:36591 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230171AbhBPLLU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Feb 2021 06:11:20 -0500
IronPort-SDR: Xc8wtMyjr+79jtNgaACrzDoOzmAIG6VHN3HJOVNABnQvhsb7+BOn+hdjZNAYpLrDrGWVDp3vst
 SBxA+a0GJGXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9896"; a="267705908"
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; 
   d="scan'208";a="267705908"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 03:07:47 -0800
IronPort-SDR: u+q53oNoCbELQJ1jYWb5CE66uod0DukWLUxwHEjP1+ollnjegC/VTvd23HsE7fW8JzmvI2eXXs
 ACzNoTLTUA8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; 
   d="scan'208";a="418038625"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 16 Feb 2021 03:07:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 157991F1; Tue, 16 Feb 2021 13:07:44 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] parport: Introduce module_parport_driver() helper macro
Date:   Tue, 16 Feb 2021 13:07:39 +0200
Message-Id: <20210216110741.1286-1-andriy.shevchenko@linux.intel.com>
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
v2: fixed typo in the macro
 include/linux/parport.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/parport.h b/include/linux/parport.h
index 1fb508c19e83..54539b80021e 100644
--- a/include/linux/parport.h
+++ b/include/linux/parport.h
@@ -301,9 +301,19 @@ int __must_check __parport_register_driver(struct parport_driver *,
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
+	module_driver(__parport_driver, parport_register_driver, parport_unregister_driver)
+
 /* If parport_register_driver doesn't fit your needs, perhaps
  * parport_find_xxx does. */
 extern struct parport *parport_find_number (int);
-- 
2.30.0

