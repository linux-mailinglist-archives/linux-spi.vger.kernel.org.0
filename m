Return-Path: <linux-spi+bounces-11538-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED297C86FCD
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 21:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DFE3B5200
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 20:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6820333C520;
	Tue, 25 Nov 2025 20:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L0hvBRr3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669D733B96F;
	Tue, 25 Nov 2025 20:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764101829; cv=none; b=mlkrww9l+fa54/nkSoefumUjFPejGP78dM7KNG2BQzKm9eXNRJ0fFBnZlpepFxJ/PHhbfyLYsvJ5HZuICV6g8wOARQb6i1MrYT/49uvvhmGNU0Hc2Zon8DtdwLJFVc+wOMSXVqKZsp5yxBA+US2dqD+XFN+vPK5SJERn+3NkvR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764101829; c=relaxed/simple;
	bh=EDgcFOpf3aoa20OJoxvVZuGmOunJzs1WRN5pUegudW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWq2fZrhwLFIEHdsvQMWNFdLhd9rz4zaXW1sHzhAYeWpBh0vKE2B1xJ6Qr42jJQnCY+g6D1Ci2pv68l9uj6hiGei3miM7bbwEAEdFhPx5U30iSQ5qDFhvRh9Kujb6Hu1qc4Lt6lwynkuvHd7jEuiWqFGzauaJh3tRUHYrA4OH6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L0hvBRr3; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764101828; x=1795637828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EDgcFOpf3aoa20OJoxvVZuGmOunJzs1WRN5pUegudW0=;
  b=L0hvBRr3dtrHlAN301YS7PpKNYq50D/puaJ2jHH/WGhjmx4gNwIoHSnv
   0Li2f8pprLJxMFjd7EGPyAnTKiwgOqEzs4vwTrty7v384HywEQw99yKye
   PugFndmTHqByoShD1+vqMmiDX15sPo+A1CN/oMDLZS3a2tFOWXsJ9LOu8
   q0IvaBoud75OTOsUOMxZ1jbhiZmKefWmrLx5QxCKscCEprwStVjDSl9Sa
   hY8+A7ljReAZ/8TK2rD8/m02aQPtXh1xXWrmSgmM0ovES9PeFVBNU9jBo
   4nzB3gBc1kgHXKCof1iNEfrE4Cvh3VXXl4piogHQHTrThXFVqzBVIi6mT
   g==;
X-CSE-ConnectionGUID: aCixAK82TXyeKx0tH0Isuw==
X-CSE-MsgGUID: n0izv5U/T96NqJYIP3GrFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="69990028"
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="69990028"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 12:17:05 -0800
X-CSE-ConnectionGUID: EwdbiN2BTDqJ/iafwBjF5g==
X-CSE-MsgGUID: bkItGjpFRJGAdGwFhSgaGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="223720984"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 25 Nov 2025 12:17:03 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 4B039A2; Tue, 25 Nov 2025 21:17:02 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 2/7] spi: microchip-core: Make use of device properties
Date: Tue, 25 Nov 2025 21:15:32 +0100
Message-ID: <20251125201700.1901959-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251125201700.1901959-1-andriy.shevchenko@linux.intel.com>
References: <20251125201700.1901959-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-microchip-core-spi.c | 36 ++++++++++++++--------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-microchip-core-spi.c
index 08ccdc5f0cc9..d2d1e86568a3 100644
--- a/drivers/spi/spi-microchip-core-spi.c
+++ b/drivers/spi/spi-microchip-core-spi.c
@@ -12,9 +12,10 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/spi/spi.h>
 
 #define MCHP_CORESPI_MAX_CS				(8)
@@ -296,6 +297,7 @@ static int mchp_corespi_transfer_one(struct spi_controller *host,
 static int mchp_corespi_probe(struct platform_device *pdev)
 {
 	const char *protocol = "motorola";
+	struct device *dev = &pdev->dev;
 	struct spi_controller *host;
 	struct mchp_corespi *spi;
 	struct resource *res;
@@ -310,7 +312,7 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, host);
 
-	if (of_property_read_u32(pdev->dev.of_node, "num-cs", &num_cs))
+	if (device_property_read_u32(dev, "num-cs", &num_cs))
 		num_cs = MCHP_CORESPI_MAX_CS;
 
 	/*
@@ -318,20 +320,18 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 	 * CoreSPI can be configured for Motorola, TI or NSC.
 	 * The current driver supports only Motorola mode.
 	 */
-	ret = of_property_read_string(pdev->dev.of_node, "microchip,protocol-configuration",
-				      &protocol);
-	if (ret && ret != -EINVAL)
-		return dev_err_probe(&pdev->dev, ret, "Error reading protocol-configuration\n");
-	if (strcmp(protocol, "motorola") != 0)
-		return dev_err_probe(&pdev->dev, -EINVAL,
-				     "CoreSPI: protocol '%s' not supported by this driver\n",
-				      protocol);
+	ret = device_property_match_property_string(dev, "microchip,protocol-configuration",
+						    &protocol, 1);
+	if (ret == -ENOENT)
+		return dev_err_probe(dev, ret, "CoreSPI: protocol is not supported by this driver\n");
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Error reading protocol-configuration\n");
 
 	/*
 	 * Motorola mode (0-3): CFG_MOT_MODE
 	 * Mode is fixed in the IP configurator.
 	 */
-	ret = of_property_read_u32(pdev->dev.of_node, "microchip,motorola-mode", &mode);
+	ret = device_property_read_u32(dev, "microchip,motorola-mode", &mode);
 	if (ret)
 		mode = MCHP_CORESPI_DEFAULT_MOTOROLA_MODE;
 	else if (mode > 3)
@@ -343,7 +343,7 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 	 * The hardware allows frame sizes <= APB data width.
 	 * However, this driver currently only supports 8-bit frames.
 	 */
-	ret = of_property_read_u32(pdev->dev.of_node, "microchip,frame-size", &frame_size);
+	ret = device_property_read_u32(dev, "microchip,frame-size", &frame_size);
 	if (!ret && frame_size != 8)
 		return dev_err_probe(&pdev->dev, -EINVAL,
 				     "CoreSPI: frame size %u not supported by this driver\n",
@@ -355,7 +355,7 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 	 * To prevent CS deassertion when TX FIFO drains, the ssel-active property
 	 * keeps CS asserted for the full SPI transfer.
 	 */
-	assert_ssel = of_property_read_bool(pdev->dev.of_node, "microchip,ssel-active");
+	assert_ssel = device_property_read_bool(dev, "microchip,ssel-active");
 	if (!assert_ssel)
 		return dev_err_probe(&pdev->dev, -EINVAL,
 				     "hardware must enable 'microchip,ssel-active' to keep CS asserted for the SPI transfer\n");
@@ -369,9 +369,10 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	host->transfer_one = mchp_corespi_transfer_one;
 	host->set_cs = mchp_corespi_set_cs;
-	host->dev.of_node = pdev->dev.of_node;
 
-	ret = of_property_read_u32(pdev->dev.of_node, "fifo-depth", &spi->fifo_depth);
+	device_set_node(&host->dev, dev_fwnode(dev));
+
+	ret = device_property_read_u32(dev, "fifo-depth", &spi->fifo_depth);
 	if (ret)
 		spi->fifo_depth = MCHP_CORESPI_DEFAULT_FIFO_DEPTH;
 
@@ -421,24 +422,23 @@ static void mchp_corespi_remove(struct platform_device *pdev)
  * Platform driver data structure
  */
 
-#if defined(CONFIG_OF)
 static const struct of_device_id mchp_corespi_dt_ids[] = {
 	{ .compatible = "microchip,corespi-rtl-v5" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mchp_corespi_dt_ids);
-#endif
 
 static struct platform_driver mchp_corespi_driver = {
 	.probe = mchp_corespi_probe,
 	.driver = {
 		.name = "microchip-corespi",
 		.pm = MICROCHIP_SPI_PM_OPS,
-		.of_match_table = of_match_ptr(mchp_corespi_dt_ids),
+		.of_match_table = mchp_corespi_dt_ids,
 	},
 	.remove = mchp_corespi_remove,
 };
 module_platform_driver(mchp_corespi_driver);
+
 MODULE_DESCRIPTION("Microchip CoreSPI controller driver");
 MODULE_AUTHOR("Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>");
 MODULE_LICENSE("GPL");
-- 
2.50.1


