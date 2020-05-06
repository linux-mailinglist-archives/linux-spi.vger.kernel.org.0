Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12AE11C74DF
	for <lists+linux-spi@lfdr.de>; Wed,  6 May 2020 17:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbgEFPac (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 6 May 2020 11:30:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:9527 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729754AbgEFPac (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 6 May 2020 11:30:32 -0400
IronPort-SDR: GKBVvaLaG9/PW/eLubkm8w5BZw1WRYSrH+LTjmLik9LntKjdkbOOEY525D1+h6HqxVBN1cWh4C
 W053r39wUX6A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 08:30:28 -0700
IronPort-SDR: gzlXxg5oD0UuZEcvZ6xGTwHUuUYtOfG8fWOxZ7KQv/5YwdMF7MHNFVa36uq1pk4gsSt6syCKcJ
 S5Jm7UBPIwSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,359,1583222400"; 
   d="scan'208";a="278263113"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 06 May 2020 08:30:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 64A4C1FD; Wed,  6 May 2020 18:30:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/8] spi: dw: Downgrade interrupt.h to irqreturn.h where appropriate
Date:   Wed,  6 May 2020 18:30:21 +0300
Message-Id: <20200506153025.21441-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200506153025.21441-1-andriy.shevchenko@linux.intel.com>
References: <20200506153025.21441-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

spi-dw-mid.c along with spi-dw.h are direct users of irqreturn.h
and nothing else is being used from interrupt.h. So, switch them
to use the former instead of latter one.

While here, move the header under #ifdef CONFIG_SPI_DW_MID_DMA
in spi-dw-mid.c.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-dw-mid.c | 2 +-
 drivers/spi/spi-dw.h     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index 86d9f79267f05..02defb68618d9 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -7,7 +7,6 @@
 
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
-#include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/types.h>
@@ -15,6 +14,7 @@
 #include "spi-dw.h"
 
 #ifdef CONFIG_SPI_DW_MID_DMA
+#include <linux/irqreturn.h>
 #include <linux/pci.h>
 #include <linux/platform_data/dma-dw.h>
 
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index aeed49b4a444a..5e1e78210d8d4 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -2,7 +2,7 @@
 #ifndef DW_SPI_HEADER_H
 #define DW_SPI_HEADER_H
 
-#include <linux/interrupt.h>
+#include <linux/irqreturn.h>
 #include <linux/io.h>
 #include <linux/scatterlist.h>
 
-- 
2.26.2

