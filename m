Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7E14593DA
	for <lists+linux-spi@lfdr.de>; Mon, 22 Nov 2021 18:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbhKVRUs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Nov 2021 12:20:48 -0500
Received: from mga07.intel.com ([134.134.136.100]:4278 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235487AbhKVRUs (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 22 Nov 2021 12:20:48 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="298243738"
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="298243738"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 09:17:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="589417269"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Nov 2021 09:17:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8A1AAB8; Mon, 22 Nov 2021 19:17:23 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/3] spi: Deduplicate spi_match_id() in __spi_register_driver()
Date:   Mon, 22 Nov 2021 19:17:19 +0200
Message-Id: <20211122171721.61553-1-andriy.shevchenko@linux.intel.com>
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
v2: no changes
 drivers/spi/spi.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index fdd530b150a7..9d19d9bae253 100644
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

