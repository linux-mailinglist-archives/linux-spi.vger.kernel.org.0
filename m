Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5316A1C74E1
	for <lists+linux-spi@lfdr.de>; Wed,  6 May 2020 17:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbgEFPae (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 6 May 2020 11:30:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:59816 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729815AbgEFPae (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 6 May 2020 11:30:34 -0400
IronPort-SDR: V5n5P5dsP7zJyJM6xZMF+IvjnOgOYr0WC+/i6cahikEr8M/OCqQXQMmRnWBE5aA2wmAAnVuSyA
 ddcqBRkdTDeA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 08:30:30 -0700
IronPort-SDR: etQFNgSDv+Cf8eELm2ZaNWKv97FSIBVhFayYdJZMzOhLaaGmsjG0yK8zBCowf9J+4EvLJ/+4aS
 4HiBaZezItaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,359,1583222400"; 
   d="scan'208";a="248950921"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 06 May 2020 08:30:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 69861167; Wed,  6 May 2020 18:30:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 5/8] spi: dw: Move few headers under #ifdef CONFIG_SPI_DW_MID_DMA
Date:   Wed,  6 May 2020 18:30:22 +0300
Message-Id: <20200506153025.21441-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200506153025.21441-1-andriy.shevchenko@linux.intel.com>
References: <20200506153025.21441-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There is no user of few headers without CONFIG_SPI_DW_MID_DMA being set.
Move them under condition.

While at it, remove unused slab.h there.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-dw-mid.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index 02defb68618d9..64523e68490d7 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -5,15 +5,14 @@
  * Copyright (c) 2009, 2014 Intel Corporation.
  */
 
-#include <linux/dma-mapping.h>
-#include <linux/dmaengine.h>
-#include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/types.h>
 
 #include "spi-dw.h"
 
 #ifdef CONFIG_SPI_DW_MID_DMA
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/irqreturn.h>
 #include <linux/pci.h>
 #include <linux/platform_data/dma-dw.h>
-- 
2.26.2

