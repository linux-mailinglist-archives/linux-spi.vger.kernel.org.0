Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A730D45A97F
	for <lists+linux-spi@lfdr.de>; Tue, 23 Nov 2021 18:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236958AbhKWRDr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Nov 2021 12:03:47 -0500
Received: from mga04.intel.com ([192.55.52.120]:50938 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237871AbhKWRDq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 23 Nov 2021 12:03:46 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="233783122"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="233783122"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 09:00:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="591257201"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Nov 2021 09:00:33 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 301331AD; Tue, 23 Nov 2021 19:00:36 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH v3 1/3] spi: Fix condition in the __spi_register_driver()
Date:   Tue, 23 Nov 2021 19:00:32 +0200
Message-Id: <20211123170034.41253-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The recent commit 3f07657506df ("spi: deduplicate spi_match_id()
in __spi_register_driver()") inadvertently inverted a condition
that provokes a (harmless) warning:

  WARNING KERN SPI driver mtd_dataflash has no spi_device_id for atmel,at45

Restore logic to avoid such warning to be issued.

Fixes: 3f07657506df ("spi: deduplicate spi_match_id() in __spi_register_driver()")
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: a fix-patch instead of previously applied one (Jon)
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9d19d9bae253..15688acc952c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -474,7 +474,7 @@ int __spi_register_driver(struct module *owner, struct spi_driver *sdrv)
 				const struct spi_device_id *spi_id;
 
 				spi_id = spi_match_id(sdrv->id_table, of_name);
-				if (!spi_id)
+				if (spi_id)
 					continue;
 			} else {
 				if (strcmp(sdrv->driver.name, of_name) == 0)
-- 
2.33.0

