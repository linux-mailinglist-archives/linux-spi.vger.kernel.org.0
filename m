Return-Path: <linux-spi+bounces-3154-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312528D4ECD
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 17:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DABC2287130
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 15:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21353DAC18;
	Thu, 30 May 2024 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M1/c2tLJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B975D18629A;
	Thu, 30 May 2024 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081889; cv=none; b=UB9U6jh6wZkIMoW12YrUj1WdzHwwqNxoufIopzBSeC3/7MG9+cH9gWyc5o7lJKea0OcU+F/Ny/Eh0za7MshZFcjaoiv3RF/kYjeOh0WCyOEhFWVp2oNS7gp1GC/gRZMzpTe8rKLuT42lowi/GXQW2fz+G44v3Vx9a4EfGhedCgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081889; c=relaxed/simple;
	bh=7g0FrtRJTKHe6RD7B4mm9xOD9+Ic1TmeKGG546OwPqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLAY0cTt4g1EfvdLa24VA23XEj6GMEdRO0mlMwpzwppEUMuvneLFJmEjiNulR5gbvRnnvlEzFAjM3nQJiNfX/ymxImFnwwvxBaXzsv+WGPuUywYccu3N2csdes43/uWnLWtK/QdeZJYx5l6Lb48OFaOWdoROeLERbj30OBn2FAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M1/c2tLJ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717081888; x=1748617888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7g0FrtRJTKHe6RD7B4mm9xOD9+Ic1TmeKGG546OwPqo=;
  b=M1/c2tLJGgUyPOMOzPvKptWOnKEHzcZUJPOsab9Qv40a4ZT3ee2tnIeJ
   lLK4PIv0X9aAzsw2g41YzoUUKqYb3V0TxNltPdcQDvHFvLZw3wHTtuj6C
   CD+ZqVGlO4KoWuEFxPIXBvfao3eNRtfnY58hRBbdg2duBrXnjH8ujcXVY
   oxyhpczhN5Yz2UZ6j9yMW3ONECgWytXqIFme0iz7bnUrpQG8aozriG9wJ
   Wr6fXGAU7jRBF6TaIHcwmtOHvxvxCqwKMHmd0a1tm/EluofXx9z5lcZes
   qELeD9yHF58VlkXpHHC6fteT5sCLrpVkG0dYidiWTfhDZuRB5L2EQOHTT
   w==;
X-CSE-ConnectionGUID: RyQuOvnbSsi7pe6myj0UCA==
X-CSE-MsgGUID: /cqcRdJ0RVerC6cI+bbWCQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="31093065"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="31093065"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 08:11:26 -0700
X-CSE-ConnectionGUID: k9Eha/fGTpeqrsW1X+0gig==
X-CSE-MsgGUID: G+4ZTQb/TfC1x49tTGutPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="40288504"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 30 May 2024 08:11:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8E19774F; Thu, 30 May 2024 18:11:19 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v2 11/11] spi: pxa2xx: Convert PCI driver to use spi-pxa2xx code directly
Date: Thu, 30 May 2024 18:10:07 +0300
Message-ID: <20240530151117.1130792-12-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240530151117.1130792-1-andriy.shevchenko@linux.intel.com>
References: <20240530151117.1130792-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI driver has an additional device layer for enumeration.
Remove that layer and use spi-pxa2xx code directly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-pci.c | 39 ++++++++++++------------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 6d2efdb0e95f..616d032f1a89 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -10,8 +10,7 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/pci.h>
-#include <linux/platform_device.h>
-#include <linux/property.h>
+#include <linux/pm.h>
 #include <linux/sprintf.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -265,10 +264,8 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 		const struct pci_device_id *ent)
 {
 	const struct pxa_spi_info *info;
-	struct platform_device_info pi;
 	int ret;
-	struct platform_device *pdev;
-	struct pxa2xx_spi_controller spi_pdata;
+	struct pxa2xx_spi_controller *pdata;
 	struct ssp_device *ssp;
 
 	ret = pcim_enable_device(dev);
@@ -279,15 +276,17 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	if (ret)
 		return ret;
 
-	memset(&spi_pdata, 0, sizeof(spi_pdata));
+	pdata = devm_kzalloc(&dev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
 
-	ssp = &spi_pdata.ssp;
+	ssp = &pdata->ssp;
 	ssp->dev = &dev->dev;
 	ssp->phys_base = pci_resource_start(dev, 0);
 	ssp->mmio_base = pcim_iomap_table(dev)[0];
 
 	info = (struct pxa_spi_info *)ent->driver_data;
-	ret = info->setup(dev, &spi_pdata);
+	ret = info->setup(dev, pdata);
 	if (ret)
 		return ret;
 
@@ -298,28 +297,12 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 		return ret;
 	ssp->irq = pci_irq_vector(dev, 0);
 
-	memset(&pi, 0, sizeof(pi));
-	pi.fwnode = dev_fwnode(&dev->dev);
-	pi.parent = &dev->dev;
-	pi.name = "pxa2xx-spi";
-	pi.id = ssp->port_id;
-	pi.data = &spi_pdata;
-	pi.size_data = sizeof(spi_pdata);
-
-	pdev = platform_device_register_full(&pi);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
-
-	pci_set_drvdata(dev, pdev);
-
-	return 0;
+	return pxa2xx_spi_probe(&dev->dev, ssp);
 }
 
 static void pxa2xx_spi_pci_remove(struct pci_dev *dev)
 {
-	struct platform_device *pdev = pci_get_drvdata(dev);
-
-	platform_device_unregister(pdev);
+	pxa2xx_spi_remove(&dev->dev);
 }
 
 static const struct pci_device_id pxa2xx_spi_pci_devices[] = {
@@ -341,6 +324,9 @@ MODULE_DEVICE_TABLE(pci, pxa2xx_spi_pci_devices);
 static struct pci_driver pxa2xx_spi_pci_driver = {
 	.name           = "pxa2xx_spi_pci",
 	.id_table       = pxa2xx_spi_pci_devices,
+	.driver = {
+		.pm	= pm_ptr(&pxa2xx_spi_pm_ops),
+	},
 	.probe          = pxa2xx_spi_pci_probe,
 	.remove         = pxa2xx_spi_pci_remove,
 };
@@ -349,4 +335,5 @@ module_pci_driver(pxa2xx_spi_pci_driver);
 
 MODULE_DESCRIPTION("CE4100/LPSS PCI-SPI glue code for PXA's driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(SPI_PXA2xx);
 MODULE_AUTHOR("Sebastian Andrzej Siewior <bigeasy@linutronix.de>");
-- 
2.43.0.rc1.1336.g36b5255a03ac


