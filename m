Return-Path: <linux-spi+bounces-3156-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4328D4ED1
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 17:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50BC21C22D39
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 15:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFFC182D34;
	Thu, 30 May 2024 15:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Knbwssup"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C6F1CB306;
	Thu, 30 May 2024 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081890; cv=none; b=gT9e6X6tmuvBZJv9qoJE35dMSAd+VNOOhaSdkoSd65mB5be/6yXcNMTEhDbL4nhBV8dLaNVJd8+bas4N9beyphf4eScqJknXwOW5pS8EpvwI+3O7mYizTl2ZbbINEw9drJW/gMZ50Y3PeRiUsIV1+oirKynpCkPisuZ1nI883nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081890; c=relaxed/simple;
	bh=HYlrU3UBrVhjvXqz3+lbjc1NAwS2xeDgiIYUu3mQpXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ga7cXBg2lxFFOgypDKHW8P12KNqg86CwHRyX4IaDDucpz73FjkDDM2qUUGtSq06GCtUr6p5K476QjEKcRnmKQW0vrK8GbaVIIo4UEUcMMjE8BLrYtYpuc1Oaw1wuDtGOUvpUfZWoIV3moGDeg8S9kBfFGbGWMFJqAxhFSDgu9Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Knbwssup; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717081888; x=1748617888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HYlrU3UBrVhjvXqz3+lbjc1NAwS2xeDgiIYUu3mQpXA=;
  b=KnbwssupSB+Ia7j6j6qhzCoCQg94Z3i0XZjLa7kUs7iWawvBL6M4PIvH
   w0XGOzs+UB+dvoeF4wo7j6QBFAkfRvU2wwZrtQdK3roxlSxJgeWW/Lw9k
   lSrq1+2ULzBaoYrejbekJ7ktImDv2cJI/uS6wmNGiq4YldMe4E7+Szm6O
   HCi/mAsc7W04fGaWeYqdAk5t2YgKe9Yx3angYQLDDkbd1jzqi22PYjy/I
   Js1TQV6yQ63svold9O/1vMLqEafsoQaGAPBflFRUfKqaH/oNsnOZv1Zh/
   putGL+Bk8FnHCLH/1tqWgf1VtnPp05dsOrGt0RrQeEeC43Ndk6e2Yn5XT
   A==;
X-CSE-ConnectionGUID: x49ng7RJSoi905XDkAAEvg==
X-CSE-MsgGUID: hxLyUNShQ+2LpbDiSiR6ew==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="31067974"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="31067974"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 08:11:26 -0700
X-CSE-ConnectionGUID: GLCTZRnDTYmRXgBP/9I+5A==
X-CSE-MsgGUID: VOD612wUSKSb/EIN8wlzzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="73329440"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 30 May 2024 08:11:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 82AB072B; Thu, 30 May 2024 18:11:19 +0300 (EEST)
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
Subject: [PATCH v2 10/11] spi: pxa2xx: Move platform driver to a separate file
Date: Thu, 30 May 2024 18:10:06 +0300
Message-ID: <20240530151117.1130792-11-andriy.shevchenko@linux.intel.com>
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

The spi-pxa2xx.c is bloated with a platform driver code while
pretending to provide a core functionality. Make it real core
library by splitting out the platform driver to a separate file.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/Makefile              |   3 +-
 drivers/spi/spi-pxa2xx-platform.c | 214 +++++++++++++++++++++++++++++
 drivers/spi/spi-pxa2xx.c          | 215 ++----------------------------
 drivers/spi/spi-pxa2xx.h          |   6 +
 4 files changed, 230 insertions(+), 208 deletions(-)
 create mode 100644 drivers/spi/spi-pxa2xx-platform.c

diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index e694254dec04..bcfb6efd88e0 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -107,7 +107,8 @@ obj-$(CONFIG_SPI_PIC32)			+= spi-pic32.o
 obj-$(CONFIG_SPI_PIC32_SQI)		+= spi-pic32-sqi.o
 obj-$(CONFIG_SPI_PL022)			+= spi-pl022.o
 obj-$(CONFIG_SPI_PPC4xx)		+= spi-ppc4xx.o
-spi-pxa2xx-platform-objs		:= spi-pxa2xx.o spi-pxa2xx-dma.o
+obj-$(CONFIG_SPI_PXA2XX)		+= spi-pxa2xx-core.o
+spi-pxa2xx-core-y			:= spi-pxa2xx.o spi-pxa2xx-dma.o
 obj-$(CONFIG_SPI_PXA2XX)		+= spi-pxa2xx-platform.o
 obj-$(CONFIG_SPI_PXA2XX_PCI)		+= spi-pxa2xx-pci.o
 obj-$(CONFIG_SPI_QCOM_GENI)		+= spi-geni-qcom.o
diff --git a/drivers/spi/spi-pxa2xx-platform.c b/drivers/spi/spi-pxa2xx-platform.c
new file mode 100644
index 000000000000..98a8ceb7db6f
--- /dev/null
+++ b/drivers/spi/spi-pxa2xx-platform.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/acpi.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/types.h>
+
+#include "spi-pxa2xx.h"
+
+static bool pxa2xx_spi_idma_filter(struct dma_chan *chan, void *param)
+{
+	return param == chan->device->dev;
+}
+
+static int
+pxa2xx_spi_init_ssp(struct platform_device *pdev, struct ssp_device *ssp, enum pxa_ssp_type type)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	int status;
+	u64 uid;
+
+	ssp->mmio_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(ssp->mmio_base))
+		return PTR_ERR(ssp->mmio_base);
+
+	ssp->phys_base = res->start;
+
+	ssp->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(ssp->clk))
+		return PTR_ERR(ssp->clk);
+
+	ssp->irq = platform_get_irq(pdev, 0);
+	if (ssp->irq < 0)
+		return ssp->irq;
+
+	ssp->type = type;
+	ssp->dev = dev;
+
+	status = acpi_dev_uid_to_integer(ACPI_COMPANION(dev), &uid);
+	if (status)
+		ssp->port_id = -1;
+	else
+		ssp->port_id = uid;
+
+	return 0;
+}
+
+static void pxa2xx_spi_ssp_release(void *ssp)
+{
+	pxa_ssp_free(ssp);
+}
+
+static struct ssp_device *pxa2xx_spi_ssp_request(struct platform_device *pdev)
+{
+	struct ssp_device *ssp;
+	int status;
+
+	ssp = pxa_ssp_request(pdev->id, pdev->name);
+	if (!ssp)
+		return ssp;
+
+	status = devm_add_action_or_reset(&pdev->dev, pxa2xx_spi_ssp_release, ssp);
+	if (status)
+		return ERR_PTR(status);
+
+	return ssp;
+}
+
+static struct pxa2xx_spi_controller *
+pxa2xx_spi_init_pdata(struct platform_device *pdev)
+{
+	struct pxa2xx_spi_controller *pdata;
+	struct device *dev = &pdev->dev;
+	struct device *parent = dev->parent;
+	const void *match = device_get_match_data(dev);
+	enum pxa_ssp_type type = SSP_UNDEFINED;
+	struct ssp_device *ssp;
+	bool is_lpss_priv;
+	u32 num_cs = 1;
+	int status;
+
+	ssp = pxa2xx_spi_ssp_request(pdev);
+	if (IS_ERR(ssp))
+		return ERR_CAST(ssp);
+	if (ssp) {
+		type = ssp->type;
+	} else if (match) {
+		type = (enum pxa_ssp_type)(uintptr_t)match;
+	} else {
+		u32 value;
+
+		status = device_property_read_u32(dev, "intel,spi-pxa2xx-type", &value);
+		if (status)
+			return ERR_PTR(status);
+
+		type = (enum pxa_ssp_type)value;
+	}
+
+	/* Validate the SSP type correctness */
+	if (!(type > SSP_UNDEFINED && type < SSP_MAX))
+		return ERR_PTR(-EINVAL);
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	/* Platforms with iDMA 64-bit */
+	is_lpss_priv = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lpss_priv");
+	if (is_lpss_priv) {
+		pdata->tx_param = parent;
+		pdata->rx_param = parent;
+		pdata->dma_filter = pxa2xx_spi_idma_filter;
+	}
+
+	/* Read number of chip select pins, if provided */
+	device_property_read_u32(dev, "num-cs", &num_cs);
+
+	pdata->num_chipselect = num_cs;
+	pdata->is_target = device_property_read_bool(dev, "spi-slave");
+	pdata->enable_dma = true;
+	pdata->dma_burst_size = 1;
+
+	/* If SSP has been already enumerated, use it */
+	if (ssp)
+		return pdata;
+
+	status = pxa2xx_spi_init_ssp(pdev, &pdata->ssp, type);
+	if (status)
+		return ERR_PTR(status);
+
+	return pdata;
+}
+
+static int pxa2xx_spi_platform_probe(struct platform_device *pdev)
+{
+	struct pxa2xx_spi_controller *platform_info;
+	struct device *dev = &pdev->dev;
+	struct ssp_device *ssp;
+
+	platform_info = dev_get_platdata(dev);
+	if (!platform_info) {
+		platform_info = pxa2xx_spi_init_pdata(pdev);
+		if (IS_ERR(platform_info))
+			return dev_err_probe(dev, PTR_ERR(platform_info), "missing platform data\n");
+
+		dev->platform_data = platform_info;
+	}
+
+	ssp = pxa2xx_spi_ssp_request(pdev);
+	if (IS_ERR(ssp))
+		return PTR_ERR(ssp);
+	if (!ssp)
+		ssp = &platform_info->ssp;
+
+	return pxa2xx_spi_probe(dev, ssp);
+}
+
+static void pxa2xx_spi_platform_remove(struct platform_device *pdev)
+{
+	pxa2xx_spi_remove(&pdev->dev);
+}
+
+static const struct acpi_device_id pxa2xx_spi_acpi_match[] = {
+	{ "80860F0E" },
+	{ "8086228E" },
+	{ "INT33C0" },
+	{ "INT33C1" },
+	{ "INT3430" },
+	{ "INT3431" },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, pxa2xx_spi_acpi_match);
+
+static const struct of_device_id pxa2xx_spi_of_match[] = {
+	{ .compatible = "marvell,mmp2-ssp", .data = (void *)MMP2_SSP },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pxa2xx_spi_of_match);
+
+static struct platform_driver driver = {
+	.driver = {
+		.name	= "pxa2xx-spi",
+		.pm	= pm_ptr(&pxa2xx_spi_pm_ops),
+		.acpi_match_table = pxa2xx_spi_acpi_match,
+		.of_match_table = pxa2xx_spi_of_match,
+	},
+	.probe = pxa2xx_spi_platform_probe,
+	.remove_new = pxa2xx_spi_platform_remove,
+};
+
+static int __init pxa2xx_spi_init(void)
+{
+	return platform_driver_register(&driver);
+}
+subsys_initcall(pxa2xx_spi_init);
+
+static void __exit pxa2xx_spi_exit(void)
+{
+	platform_driver_unregister(&driver);
+}
+module_exit(pxa2xx_spi_exit);
+
+MODULE_AUTHOR("Stephen Street");
+MODULE_DESCRIPTION("PXA2xx SSP SPI Controller platform driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(SPI_PXA2xx);
+MODULE_ALIAS("platform:pxa2xx-spi");
+MODULE_SOFTDEP("pre: dw_dmac");
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 74f242e652df..1fb30201459f 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2013, 2021 Intel Corporation
  */
 
-#include <linux/acpi.h>
 #include <linux/atomic.h>
 #include <linux/bitops.h>
 #include <linux/bug.h>
@@ -14,15 +13,12 @@
 #include <linux/dmaengine.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
-#include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/math64.h>
 #include <linux/minmax.h>
-#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/slab.h>
@@ -32,11 +28,6 @@
 
 #include "spi-pxa2xx.h"
 
-MODULE_AUTHOR("Stephen Street");
-MODULE_DESCRIPTION("PXA2xx SSP SPI Controller");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:pxa2xx-spi");
-
 #define TIMOUT_DFLT		1000
 
 /*
@@ -1263,131 +1254,6 @@ static void cleanup(struct spi_device *spi)
 	kfree(chip);
 }
 
-static bool pxa2xx_spi_idma_filter(struct dma_chan *chan, void *param)
-{
-	return param == chan->device->dev;
-}
-
-static int
-pxa2xx_spi_init_ssp(struct platform_device *pdev, struct ssp_device *ssp, enum pxa_ssp_type type)
-{
-	struct device *dev = &pdev->dev;
-	struct resource *res;
-	int status;
-	u64 uid;
-
-	ssp->mmio_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-	if (IS_ERR(ssp->mmio_base))
-		return PTR_ERR(ssp->mmio_base);
-
-	ssp->phys_base = res->start;
-
-	ssp->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(ssp->clk))
-		return PTR_ERR(ssp->clk);
-
-	ssp->irq = platform_get_irq(pdev, 0);
-	if (ssp->irq < 0)
-		return ssp->irq;
-
-	ssp->type = type;
-	ssp->dev = dev;
-
-	status = acpi_dev_uid_to_integer(ACPI_COMPANION(dev), &uid);
-	if (status)
-		ssp->port_id = -1;
-	else
-		ssp->port_id = uid;
-
-	return 0;
-}
-
-static void pxa2xx_spi_ssp_release(void *ssp)
-{
-	pxa_ssp_free(ssp);
-}
-
-static struct ssp_device *pxa2xx_spi_ssp_request(struct platform_device *pdev)
-{
-	struct ssp_device *ssp;
-	int status;
-
-	ssp = pxa_ssp_request(pdev->id, pdev->name);
-	if (!ssp)
-		return ssp;
-
-	status = devm_add_action_or_reset(&pdev->dev, pxa2xx_spi_ssp_release, ssp);
-	if (status)
-		return ERR_PTR(status);
-
-	return ssp;
-}
-
-static struct pxa2xx_spi_controller *
-pxa2xx_spi_init_pdata(struct platform_device *pdev)
-{
-	struct pxa2xx_spi_controller *pdata;
-	struct device *dev = &pdev->dev;
-	struct device *parent = dev->parent;
-	const void *match = device_get_match_data(dev);
-	enum pxa_ssp_type type = SSP_UNDEFINED;
-	struct ssp_device *ssp;
-	bool is_lpss_priv;
-	u32 num_cs = 1;
-	int status;
-
-	ssp = pxa2xx_spi_ssp_request(pdev);
-	if (IS_ERR(ssp))
-		return ERR_CAST(ssp);
-	if (ssp) {
-		type = ssp->type;
-	} else if (match) {
-		type = (enum pxa_ssp_type)(uintptr_t)match;
-	} else {
-		u32 value;
-
-		status = device_property_read_u32(dev, "intel,spi-pxa2xx-type", &value);
-		if (status)
-			return ERR_PTR(status);
-
-		type = (enum pxa_ssp_type)value;
-	}
-
-	/* Validate the SSP type correctness */
-	if (!(type > SSP_UNDEFINED && type < SSP_MAX))
-		return ERR_PTR(-EINVAL);
-
-	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata)
-		return ERR_PTR(-ENOMEM);
-
-	/* Platforms with iDMA 64-bit */
-	is_lpss_priv = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lpss_priv");
-	if (is_lpss_priv) {
-		pdata->tx_param = parent;
-		pdata->rx_param = parent;
-		pdata->dma_filter = pxa2xx_spi_idma_filter;
-	}
-
-	/* Read number of chip select pins, if provided */
-	device_property_read_u32(dev, "num-cs", &num_cs);
-
-	pdata->num_chipselect = num_cs;
-	pdata->is_target = device_property_read_bool(dev, "spi-slave");
-	pdata->enable_dma = true;
-	pdata->dma_burst_size = 1;
-
-	/* If SSP has been already enumerated, use it */
-	if (ssp)
-		return pdata;
-
-	status = pxa2xx_spi_init_ssp(pdev, &pdata->ssp, type);
-	if (status)
-		return ERR_PTR(status);
-
-	return pdata;
-}
-
 static int pxa2xx_spi_fw_translate_cs(struct spi_controller *controller,
 				      unsigned int cs)
 {
@@ -1413,7 +1279,7 @@ static size_t pxa2xx_spi_max_dma_transfer_size(struct spi_device *spi)
 	return MAX_DMA_LEN;
 }
 
-static int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp)
+int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp)
 {
 	struct pxa2xx_spi_controller *platform_info;
 	struct spi_controller *controller;
@@ -1613,8 +1479,9 @@ static int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp)
 
 	return status;
 }
+EXPORT_SYMBOL_NS_GPL(pxa2xx_spi_probe, SPI_PXA2xx);
 
-static void pxa2xx_spi_remove(struct device *dev)
+void pxa2xx_spi_remove(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
 	struct ssp_device *ssp = drv_data->ssp;
@@ -1637,6 +1504,7 @@ static void pxa2xx_spi_remove(struct device *dev)
 	/* Release IRQ */
 	free_irq(ssp->irq, drv_data);
 }
+EXPORT_SYMBOL_NS_GPL(pxa2xx_spi_remove, SPI_PXA2xx);
 
 static int pxa2xx_spi_suspend(struct device *dev)
 {
@@ -1688,78 +1556,11 @@ static int pxa2xx_spi_runtime_resume(struct device *dev)
 	return clk_prepare_enable(drv_data->ssp->clk);
 }
 
-static const struct dev_pm_ops pxa2xx_spi_pm_ops = {
+EXPORT_NS_GPL_DEV_PM_OPS(pxa2xx_spi_pm_ops, SPI_PXA2xx) = {
 	SYSTEM_SLEEP_PM_OPS(pxa2xx_spi_suspend, pxa2xx_spi_resume)
 	RUNTIME_PM_OPS(pxa2xx_spi_runtime_suspend, pxa2xx_spi_runtime_resume, NULL)
 };
 
-static int pxa2xx_spi_platform_probe(struct platform_device *pdev)
-{
-	struct pxa2xx_spi_controller *platform_info;
-	struct device *dev = &pdev->dev;
-	struct ssp_device *ssp;
-
-	platform_info = dev_get_platdata(dev);
-	if (!platform_info) {
-		platform_info = pxa2xx_spi_init_pdata(pdev);
-		if (IS_ERR(platform_info))
-			return dev_err_probe(dev, PTR_ERR(platform_info), "missing platform data\n");
-
-		dev->platform_data = platform_info;
-	}
-
-	ssp = pxa2xx_spi_ssp_request(pdev);
-	if (IS_ERR(ssp))
-		return PTR_ERR(ssp);
-	if (!ssp)
-		ssp = &platform_info->ssp;
-
-	return pxa2xx_spi_probe(dev, ssp);
-}
-
-static void pxa2xx_spi_platform_remove(struct platform_device *pdev)
-{
-	pxa2xx_spi_remove(&pdev->dev);
-}
-
-static const struct acpi_device_id pxa2xx_spi_acpi_match[] = {
-	{ "80860F0E" },
-	{ "8086228E" },
-	{ "INT33C0" },
-	{ "INT33C1" },
-	{ "INT3430" },
-	{ "INT3431" },
-	{}
-};
-MODULE_DEVICE_TABLE(acpi, pxa2xx_spi_acpi_match);
-
-static const struct of_device_id pxa2xx_spi_of_match[] = {
-	{ .compatible = "marvell,mmp2-ssp", .data = (void *)MMP2_SSP },
-	{}
-};
-MODULE_DEVICE_TABLE(of, pxa2xx_spi_of_match);
-
-static struct platform_driver driver = {
-	.driver = {
-		.name	= "pxa2xx-spi",
-		.pm	= pm_ptr(&pxa2xx_spi_pm_ops),
-		.acpi_match_table = pxa2xx_spi_acpi_match,
-		.of_match_table = pxa2xx_spi_of_match,
-	},
-	.probe = pxa2xx_spi_platform_probe,
-	.remove_new = pxa2xx_spi_platform_remove,
-};
-
-static int __init pxa2xx_spi_init(void)
-{
-	return platform_driver_register(&driver);
-}
-subsys_initcall(pxa2xx_spi_init);
-
-static void __exit pxa2xx_spi_exit(void)
-{
-	platform_driver_unregister(&driver);
-}
-module_exit(pxa2xx_spi_exit);
-
-MODULE_SOFTDEP("pre: dw_dmac");
+MODULE_AUTHOR("Stephen Street");
+MODULE_DESCRIPTION("PXA2xx SSP SPI Controller core driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 93e1e471e1c6..a470d3d634d3 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -14,6 +14,7 @@
 
 #include <linux/pxa2xx_ssp.h>
 
+struct device;
 struct gpio_desc;
 
 /*
@@ -131,4 +132,9 @@ extern void pxa2xx_spi_dma_stop(struct driver_data *drv_data);
 extern int pxa2xx_spi_dma_setup(struct driver_data *drv_data);
 extern void pxa2xx_spi_dma_release(struct driver_data *drv_data);
 
+int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp);
+void pxa2xx_spi_remove(struct device *dev);
+
+extern const struct dev_pm_ops pxa2xx_spi_pm_ops;
+
 #endif /* SPI_PXA2XX_H */
-- 
2.43.0.rc1.1336.g36b5255a03ac


