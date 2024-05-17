Return-Path: <linux-spi+bounces-2938-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0E98C8D15
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 21:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8861C231E8
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 19:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8526142E60;
	Fri, 17 May 2024 19:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fnP194dF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB3B1422C2;
	Fri, 17 May 2024 19:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715975635; cv=none; b=Dpj1qPRs0fZCZOysM3eV/lSnLNe+iofdLDh77lnkvCPaJUtO1/54rinqr1I/d3rNbqjmr/cmLrT5YVfBMiUUx2jSoMtUwT0M+J5TMFZZyS97QCjmP3WrvSRFIklQCncUDMpKuLQFhDrFl/V2GcPYWE63I1vl8Oo2+GM4Q8nsZsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715975635; c=relaxed/simple;
	bh=7g0FrtRJTKHe6RD7B4mm9xOD9+Ic1TmeKGG546OwPqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MyYkheVq/8utgxU9O8bJPJK7IHgEadkopgRKAteBPivjNbo7Nxns47zYUspoMqVao3G3+ugB9RPPNJj/tDYIizJOfiiXxRvnuSwHa+T1BnGF6vEpSLkhzDHfZcyc0keb+DTExXC1dsNPBBLK47D8NWiAbXDcBhYEyoUhx2hm8ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fnP194dF; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715975634; x=1747511634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7g0FrtRJTKHe6RD7B4mm9xOD9+Ic1TmeKGG546OwPqo=;
  b=fnP194dFcpGHhuXxLHJCbPM0ZKbn9HMX4PqssY2Clon1vYM+njKUETY8
   w7Cz60C16PBse+ZZbV5e06aTJpxK6JDf4saUnyb4PeEsrXl/dozUOcR+I
   zxKCJCWAoz6CWvhYkdd7uRChu9+wKXhe+Xcj3TB4m+yhCkNowgIEe1JWi
   SJFWhxQR53DzdJkc1FwVukgFyIDOAJM2NTk7Y/Ok6ifowBQ7LOzbLe4cp
   rY8cWNHPo15GOPvcZCM/teFnO4GIoifroRpHWOgCKAqad3PaEc1JfO92M
   KSawEB2NA4s2IzBAQB3qC4l5pLBQYpxQfnop8bj0ovMMkmNohIYaLzveE
   Q==;
X-CSE-ConnectionGUID: c43CvMwlSwCMsBfmL8z82Q==
X-CSE-MsgGUID: s8FwEi0GSkaayeMsQc5uew==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="12348686"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="12348686"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 12:53:52 -0700
X-CSE-ConnectionGUID: PSNZlpLGT0GsLptac8sf7w==
X-CSE-MsgGUID: 6JKeLPUWTwmH9hdkS/K0yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="31915018"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 17 May 2024 12:53:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 831C4656; Fri, 17 May 2024 22:53:45 +0300 (EEST)
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
Subject: [PATCH v1 10/10] spi: pxa2xx: Convert PCI driver to use spi-pxa2xx code directly
Date: Fri, 17 May 2024 22:47:44 +0300
Message-ID: <20240517195344.813032-11-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240517195344.813032-1-andriy.shevchenko@linux.intel.com>
References: <20240517195344.813032-1-andriy.shevchenko@linux.intel.com>
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


