Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E4F32C6E7
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 02:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236765AbhCDAaS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Mar 2021 19:30:18 -0500
Received: from mga01.intel.com ([192.55.52.88]:16872 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356571AbhCCKrp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 3 Mar 2021 05:47:45 -0500
IronPort-SDR: gcYlS7q+Kn0ts8+weWNUoUryCMuOveFCE9ljsz+tzPTMgTZONYpeneKuTQtTR5+V3q4OHOeXU+
 U2FWND0sgHow==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="206833510"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="206833510"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 01:18:21 -0800
IronPort-SDR: x4qll68f1qKzE/mO1wM9dYjUNY5uiabN43HLRt81uuD/69MrqvYxWljJkUROf+dRKUogBTUJCu
 OAH+gmOfAaCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="435956918"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 03 Mar 2021 01:17:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 366B0F4; Wed,  3 Mar 2021 11:16:58 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 3/3] spi: lm70llp: Switch to use module_parport_driver()
Date:   Wed,  3 Mar 2021 11:16:42 +0200
Message-Id: <20210303091642.23929-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210303091642.23929-1-andriy.shevchenko@linux.intel.com>
References: <20210303091642.23929-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Switch to use module_parport_driver() to reduce boilerplate code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
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
2.30.1

