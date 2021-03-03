Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282D032C6E5
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 02:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349976AbhCDAaR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Mar 2021 19:30:17 -0500
Received: from mga11.intel.com ([192.55.52.93]:56415 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351711AbhCCKrW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 3 Mar 2021 05:47:22 -0500
IronPort-SDR: wzjZjHaZeWo7fNwnzKgvlyRtNLH4qPrdLxQIsoGkn55xiReaiO9HT3ws76aYkOWeAMEgbTclzJ
 w0Q5ZsNh5TBA==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="183768262"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="183768262"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 01:16:57 -0800
IronPort-SDR: X7GnzVR7l94NygCRBXx3DEslwh+5xN3BNprdvyowD8nBcrufaFrfoyQQJ/nltU78wtpG5AT7ll
 3ZpQmuan/k/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="600075825"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 03 Mar 2021 01:16:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8FBC513A; Wed,  3 Mar 2021 11:16:54 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 1/3] parport: Introduce module_parport_driver() helper macro
Date:   Wed,  3 Mar 2021 11:16:40 +0200
Message-Id: <20210303091642.23929-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210303091642.23929-1-andriy.shevchenko@linux.intel.com>
References: <20210303091642.23929-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Introduce module_parport_driver() helper macro to reduce boilerplate
in the existing and new code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 include/linux/parport.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/parport.h b/include/linux/parport.h
index f981f794c850..1c16ffb8b908 100644
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
+	module_driver(__parport_driver, parport_register_driver, parport_unregister_driver)
+
 /* If parport_register_driver doesn't fit your needs, perhaps
  * parport_find_xxx does. */
 extern struct parport *parport_find_number (int);
-- 
2.30.1

