Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10121C74E4
	for <lists+linux-spi@lfdr.de>; Wed,  6 May 2020 17:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbgEFPad (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 6 May 2020 11:30:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:59816 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729776AbgEFPad (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 6 May 2020 11:30:33 -0400
IronPort-SDR: stPsDCmSVnyFvaX5IgyZqqUe5hYBlJjKMjbIrBdEfr8HK56k47Blg8j0KXyw9LR1TVoODlKr8B
 C+5KGerodn6g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 08:30:31 -0700
IronPort-SDR: vv8MJzdTIMzt1vgmKUSEyCXLDWpvQUr++RoJmvAs+IGSPQw7tThZcIDJjyTI3wM1hczKyQg9ug
 usjpOQonVe6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,359,1583222400"; 
   d="scan'208";a="434925810"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 06 May 2020 08:30:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 56609109; Wed,  6 May 2020 18:30:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/8] spi: dw: Move interrupt.h to spi-dw.h who is user of it
Date:   Wed,  6 May 2020 18:30:20 +0300
Message-Id: <20200506153025.21441-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200506153025.21441-1-andriy.shevchenko@linux.intel.com>
References: <20200506153025.21441-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The actual user of interrupt.h is spi-dw.h and not bus drivers.
Move header there.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-dw-mmio.c | 1 -
 drivers/spi/spi-dw-pci.c  | 1 -
 drivers/spi/spi-dw.h      | 1 +
 3 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index abd3bb5e52dba..fc3577b07a1ee 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -7,7 +7,6 @@
 
 #include <linux/clk.h>
 #include <linux/err.h>
-#include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index 12c131b5fb4ec..172a9f2996316 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -5,7 +5,6 @@
  * Copyright (c) 2009, 2014 Intel Corporation.
  */
 
-#include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 8fe724279d158..aeed49b4a444a 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -2,6 +2,7 @@
 #ifndef DW_SPI_HEADER_H
 #define DW_SPI_HEADER_H
 
+#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/scatterlist.h>
 
-- 
2.26.2

