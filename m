Return-Path: <linux-spi+bounces-5702-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D52B9C9375
	for <lists+linux-spi@lfdr.de>; Thu, 14 Nov 2024 21:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0B72B26551
	for <lists+linux-spi@lfdr.de>; Thu, 14 Nov 2024 20:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453141AA785;
	Thu, 14 Nov 2024 20:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lm2O/Ybe"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370C01ABED9;
	Thu, 14 Nov 2024 20:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731617458; cv=none; b=E6dq2SWStJrb5Lhd/F7yWHvg0h41bpqTfejxOHWR70fgkh0y7hsNWuSnjudl4skbyusf1rI2NZXbqd+ieow00kCMcgot+vJc++wcqEADWUoLPQnPMSE8S/cXxgoQQtXG6CRaufPjCFFtOm0yZqjH8gTccQ+BLsSvWb7ette2KMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731617458; c=relaxed/simple;
	bh=FaMr7tIRWXDZ6ad3xtZlphSFUCsG4u9u+xXqtA7b6kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QAgrN6dHSLfW5V9MVKpqEGAudrOP8BWhG+Vv8PCZvvImJ33RnJkBqfNd5ljw9v9iXmnfDcs9Hdlsz7Qqg6m8nXgfDu/YosuRpdQhMdC/gua4KzIuHU99eCQR9BQyh91F/B2sLrApGv3nqD05WooyIy/cFIF6HnPjTra83UYnmVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lm2O/Ybe; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731617456; x=1763153456;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FaMr7tIRWXDZ6ad3xtZlphSFUCsG4u9u+xXqtA7b6kQ=;
  b=Lm2O/YbeB3tzhPM7AQjXorc9icEumM4ByorhSRk7W024/fFP8VzPJ8NP
   xTRJxGoYfslYRrs7G6h3TYRFpRs1YSk4z5KK4r86rXMl60cgSGR8kO2LB
   SzTdTdIFq2W+UsC27SagYNatHyFzMUnwIMJBy+WyYQFXEyq+V4BWBK1nO
   QUUBEgkDJMioFaFeWGHy/MqzbaEpcC2Y6dRU3zU/CsttPVzEie5QSDquY
   BWnye3bl6E9LGB8SDZBGD6i0VpmdaPWGRAvBvnRmBo92Djq8tLFCge8gI
   vayruRyw+zfosjCFRUwiTshQVI0dPf47niX5WO7OvZp64VtF6b4zQ5eo/
   Q==;
X-CSE-ConnectionGUID: Jc/b5speRUCaPOZfgHtcvA==
X-CSE-MsgGUID: pzwlX8lnTcGOoMbiKkxspg==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="42981041"
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="42981041"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 12:50:55 -0800
X-CSE-ConnectionGUID: 1DMG7JpXQAa95Fox4xXQUg==
X-CSE-MsgGUID: DWR2Ow4ZQDe6dEMKqKk43A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="92402975"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 14 Nov 2024 12:50:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C8BA6380; Thu, 14 Nov 2024 22:50:52 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/1] spi: sc18is602: Switch to generic firmware properties and drop of_match_ptr()
Date: Thu, 14 Nov 2024 22:50:51 +0200
Message-ID: <20241114205051.3747458-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This enables using the driver with other firmware types such as ACPI
via PRP0001.

Also part of a general attempt to move drivers over to generic properties
to avoid opportunities for cut and paste.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-sc18is602.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-sc18is602.c b/drivers/spi/spi-sc18is602.c
index eecf9ea95ae3..1627aa66c965 100644
--- a/drivers/spi/spi-sc18is602.c
+++ b/drivers/spi/spi-sc18is602.c
@@ -7,13 +7,15 @@
 
 #include <linux/kernel.h>
 #include <linux/err.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/spi/spi.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
 #include <linux/pm_runtime.h>
-#include <linux/of.h>
 #include <linux/platform_data/sc18is602.h>
+#include <linux/property.h>
+
 #include <linux/gpio/consumer.h>
 
 enum chips { sc18is602, sc18is602b, sc18is603 };
@@ -236,9 +238,7 @@ static int sc18is602_setup(struct spi_device *spi)
 
 static int sc18is602_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct device *dev = &client->dev;
-	struct device_node *np = dev->of_node;
 	struct sc18is602_platform_data *pdata = dev_get_platdata(dev);
 	struct sc18is602 *hw;
 	struct spi_controller *host;
@@ -251,8 +251,9 @@ static int sc18is602_probe(struct i2c_client *client)
 	if (!host)
 		return -ENOMEM;
 
+	device_set_node(&host->dev, dev_fwnode(dev));
+
 	hw = spi_controller_get_devdata(host);
-	i2c_set_clientdata(client, hw);
 
 	/* assert reset and then release */
 	hw->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
@@ -265,11 +266,7 @@ static int sc18is602_probe(struct i2c_client *client)
 	hw->dev = dev;
 	hw->ctrl = 0xff;
 
-	if (client->dev.of_node)
-		hw->id = (uintptr_t)of_device_get_match_data(&client->dev);
-	else
-		hw->id = id->driver_data;
-
+	hw->id = (uintptr_t)i2c_get_match_data(client);
 	switch (hw->id) {
 	case sc18is602:
 	case sc18is602b:
@@ -278,28 +275,21 @@ static int sc18is602_probe(struct i2c_client *client)
 		break;
 	case sc18is603:
 		host->num_chipselect = 2;
-		if (pdata) {
+		if (pdata)
 			hw->freq = pdata->clock_frequency;
-		} else {
-			const __be32 *val;
-			int len;
-
-			val = of_get_property(np, "clock-frequency", &len);
-			if (val && len >= sizeof(__be32))
-				hw->freq = be32_to_cpup(val);
-		}
+		else
+			device_property_read_u32(dev, "clock-frequency", &hw->freq);
 		if (!hw->freq)
 			hw->freq = SC18IS602_CLOCK;
 		break;
 	}
-	host->bus_num = np ? -1 : client->adapter->nr;
+	host->bus_num = dev_fwnode(dev) ? -1 : client->adapter->nr;
 	host->mode_bits = SPI_CPHA | SPI_CPOL | SPI_LSB_FIRST;
 	host->bits_per_word_mask = SPI_BPW_MASK(8);
 	host->setup = sc18is602_setup;
 	host->transfer_one_message = sc18is602_transfer_one;
 	host->max_transfer_size = sc18is602_max_transfer_size;
 	host->max_message_size = sc18is602_max_transfer_size;
-	host->dev.of_node = np;
 	host->min_speed_hz = hw->freq / 128;
 	host->max_speed_hz = hw->freq / 4;
 
@@ -314,7 +304,7 @@ static const struct i2c_device_id sc18is602_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, sc18is602_id);
 
-static const struct of_device_id sc18is602_of_match[] __maybe_unused = {
+static const struct of_device_id sc18is602_of_match[] = {
 	{
 		.compatible = "nxp,sc18is602",
 		.data = (void *)sc18is602
@@ -334,7 +324,7 @@ MODULE_DEVICE_TABLE(of, sc18is602_of_match);
 static struct i2c_driver sc18is602_driver = {
 	.driver = {
 		.name = "sc18is602",
-		.of_match_table = of_match_ptr(sc18is602_of_match),
+		.of_match_table = sc18is602_of_match,
 	},
 	.probe = sc18is602_probe,
 	.id_table = sc18is602_id,
-- 
2.43.0.rc1.1336.g36b5255a03ac


