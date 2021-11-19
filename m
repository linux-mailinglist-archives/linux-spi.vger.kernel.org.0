Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88F545758E
	for <lists+linux-spi@lfdr.de>; Fri, 19 Nov 2021 18:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbhKSRkV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Nov 2021 12:40:21 -0500
Received: from mga18.intel.com ([134.134.136.126]:43417 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236677AbhKSRkV (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 19 Nov 2021 12:40:21 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="221334105"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="221334105"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 09:37:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="673288702"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 19 Nov 2021 09:37:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 34247FD; Fri, 19 Nov 2021 19:37:21 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] spi: deduplicate spi_match_id() in __spi_register_driver()
Date:   Fri, 19 Nov 2021 19:37:17 +0200
Message-Id: <20211119173718.52938-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The same logic is used in spi_match_id() and in the __spi_register_driver().
By switching the former from taking struct spi_device * to const char * as
the second parameter we may deduplicate the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b23e675953e1..dfa06103150e 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -315,11 +315,10 @@ static void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
  * and the sysfs version makes coldplug work too.
  */
 
-static const struct spi_device_id *spi_match_id(const struct spi_device_id *id,
-						const struct spi_device *sdev)
+static const struct spi_device_id *spi_match_id(const struct spi_device_id *id, const char *name)
 {
 	while (id->name[0]) {
-		if (!strcmp(sdev->modalias, id->name))
+		if (!strcmp(name, id->name))
 			return id;
 		id++;
 	}
@@ -330,7 +329,7 @@ const struct spi_device_id *spi_get_device_id(const struct spi_device *sdev)
 {
 	const struct spi_driver *sdrv = to_spi_driver(sdev->dev.driver);
 
-	return spi_match_id(sdrv->id_table, sdev);
+	return spi_match_id(sdrv->id_table, sdev->modalias);
 }
 EXPORT_SYMBOL_GPL(spi_get_device_id);
 
@@ -352,7 +351,7 @@ static int spi_match_device(struct device *dev, struct device_driver *drv)
 		return 1;
 
 	if (sdrv->id_table)
-		return !!spi_match_id(sdrv->id_table, spi);
+		return !!spi_match_id(sdrv->id_table, spi->modalias);
 
 	return strcmp(spi->modalias, drv->name) == 0;
 }
@@ -474,12 +473,8 @@ int __spi_register_driver(struct module *owner, struct spi_driver *sdrv)
 			if (sdrv->id_table) {
 				const struct spi_device_id *spi_id;
 
-				for (spi_id = sdrv->id_table; spi_id->name[0];
-				     spi_id++)
-					if (strcmp(spi_id->name, of_name) == 0)
-						break;
-
-				if (spi_id->name[0])
+				spi_id = spi_match_id(sdrv->id_table, of_name);
+				if (!spi_id)
 					continue;
 			} else {
 				if (strcmp(sdrv->driver.name, of_name) == 0)
-- 
2.33.0

