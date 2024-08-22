Return-Path: <linux-spi+bounces-4265-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F4B95B3F0
	for <lists+linux-spi@lfdr.de>; Thu, 22 Aug 2024 13:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E2BD1F242AC
	for <lists+linux-spi@lfdr.de>; Thu, 22 Aug 2024 11:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BA91C9425;
	Thu, 22 Aug 2024 11:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hmVS/XRc"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0402F1C9422;
	Thu, 22 Aug 2024 11:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724326459; cv=none; b=bwFyrGPQ5N85WGx6acccmRwXudMspcQPtFrF8olO9jRRO9TdK98aZK5pzXUiLWZ+0s1nBTvMgIh+8GaEXGGt85LeEqh/qQrtDpJ2tYDSih8UbiM9wyEY/rSpBumk6eFh9tC1zcgbF/77KuaLkUJ+SeSXkSywlPWpqk6a1l5VBPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724326459; c=relaxed/simple;
	bh=ks4Cl3uJ9vYL8M58M6kStg4d+FEUG4oB1hhFIymCAHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIH6zPUVPkzmTqcpYhz29neE6ET4upBJafVOL/DKnS54LEMFKK1rpPWM/lJoSGRrNtNMLmX76zesYM6hWdiinMCb5I0SVAdSi4bWZhZUMUy1bMUzE7BAMj+kDTbf9Llh/IeZclMBIFNY3eDmzRfY9eBjqVdVO/JiobQP+KrzAt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hmVS/XRc; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724326458; x=1755862458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ks4Cl3uJ9vYL8M58M6kStg4d+FEUG4oB1hhFIymCAHc=;
  b=hmVS/XRcQxRyMYuKe8ZV/wnU1QqOoBu7XGJXXGWlhPu/tTio3UHX21s5
   i7B3iTSMgGcT9y3OTfLB//gJkHOwT5SuOVqKWrp3AhxkogdU0PrHAgiYf
   i7Ao5k9Q9SfrGuDfJ/zGGrU2RBtMNHB6f9ng0FHx5iMCWm//rpn94/cn6
   3vx+m4ohHI7dXuyS7yJ6BdNXcBtYebtqEqiYhVs/KL/jEKjDev4M/L2AV
   N7K+755nH4zbiegFR/ZAidCNTGNu9Rx/LF41i+vrHKEATi1CpOutkejBo
   NGsgsee+KZSAaR2GgQmuBCXRtpKK9L22tG2P3/uTz6VvW6vKsSByIo/vE
   Q==;
X-CSE-ConnectionGUID: pMI3NK3hR+SdHrPbIOEB7w==
X-CSE-MsgGUID: 0q/jOhAFRl6DRwNTanfuAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22547598"
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="22547598"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 04:34:13 -0700
X-CSE-ConnectionGUID: CtLCHmiVTFKdXXXJ2yNGhA==
X-CSE-MsgGUID: WisIL1XDQy2hdYJ3ifFTSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="61566048"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 22 Aug 2024 04:34:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A84052F2; Thu, 22 Aug 2024 14:34:09 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v1 2/2] spi: pxa2xx: Move PM runtime handling to the glue drivers
Date: Thu, 22 Aug 2024 14:30:54 +0300
Message-ID: <20240822113408.750831-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240822113408.750831-1-andriy.shevchenko@linux.intel.com>
References: <20240822113408.750831-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI and platform buses have different defaults for runtime PM.
In particular PCI probe is assumed to be called when PM runtime
is enabled by the PCI core. In this case if we try enable it again
the PM runtime complaints with

    pxa2xx_spi_pci 0000:00:07.0: Unbalanced pm_runtime_enable!

Fix this by moving PM runtime handling from the SPI PXA2xx core
to the glue drivers.

Fixes: cc160697a576 ("spi: pxa2xx: Convert PCI driver to use spi-pxa2xx code directly")
Fixes: 3d8f037fbcab ("spi: pxa2xx: Move platform driver to a separate file")
Fixes: 20ade9b9771c ("spi: pxa2xx: Extract pxa2xx_spi_platform_*() callbacks")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-pci.c      | 15 ++++++++++++++-
 drivers/spi/spi-pxa2xx-platform.c | 22 ++++++++++++++++++++--
 drivers/spi/spi-pxa2xx.c          | 15 +--------------
 3 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index c98bb214b6ae..cc8dcf782399 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/pm.h>
+#include <linux/pm_runtime.h>
 #include <linux/sprintf.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -297,11 +298,23 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 		return ret;
 	ssp->irq = pci_irq_vector(dev, 0);
 
-	return pxa2xx_spi_probe(&dev->dev, ssp, pdata);
+	ret = pxa2xx_spi_probe(&dev->dev, ssp, pdata);
+	if (ret)
+		return ret;
+
+	pm_runtime_set_autosuspend_delay(&dev->dev, 50);
+	pm_runtime_use_autosuspend(&dev->dev);
+	pm_runtime_put_autosuspend(&dev->dev);
+	pm_runtime_allow(&dev->dev);
+
+	return 0;
 }
 
 static void pxa2xx_spi_pci_remove(struct pci_dev *dev)
 {
+	pm_runtime_forbid(&dev->dev);
+	pm_runtime_get_noresume(&dev->dev);
+
 	pxa2xx_spi_remove(&dev->dev);
 }
 
diff --git a/drivers/spi/spi-pxa2xx-platform.c b/drivers/spi/spi-pxa2xx-platform.c
index f9504cddc7ba..595af9fa4e0f 100644
--- a/drivers/spi/spi-pxa2xx-platform.c
+++ b/drivers/spi/spi-pxa2xx-platform.c
@@ -7,6 +7,7 @@
 #include <linux/init.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/types.h>
 
@@ -142,6 +143,7 @@ static int pxa2xx_spi_platform_probe(struct platform_device *pdev)
 	struct pxa2xx_spi_controller *platform_info;
 	struct device *dev = &pdev->dev;
 	struct ssp_device *ssp;
+	int ret;
 
 	platform_info = dev_get_platdata(dev);
 	if (!platform_info) {
@@ -156,12 +158,28 @@ static int pxa2xx_spi_platform_probe(struct platform_device *pdev)
 	if (!ssp)
 		ssp = &platform_info->ssp;
 
-	return pxa2xx_spi_probe(dev, ssp, platform_info);
+	pm_runtime_set_autosuspend_delay(dev, 50);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	ret = pxa2xx_spi_probe(dev, ssp, platform_info);
+	if (ret)
+		pm_runtime_disable(dev);
+
+	return ret;
 }
 
 static void pxa2xx_spi_platform_remove(struct platform_device *pdev)
 {
-	pxa2xx_spi_remove(&pdev->dev);
+	struct device *dev = &pdev->dev;
+
+	pm_runtime_get_sync(dev);
+
+	pxa2xx_spi_remove(dev);
+
+	pm_runtime_put_noidle(dev);
+	pm_runtime_disable(dev);
 }
 
 static const struct acpi_device_id pxa2xx_spi_acpi_match[] = {
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index e3a95adc5279..bf1f34b0ffc8 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1449,24 +1449,16 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 		}
 	}
 
-	pm_runtime_set_autosuspend_delay(dev, 50);
-	pm_runtime_use_autosuspend(dev);
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
-
 	/* Register with the SPI framework */
 	dev_set_drvdata(dev, drv_data);
 	status = spi_register_controller(controller);
 	if (status) {
 		dev_err_probe(dev, status, "problem registering SPI controller\n");
-		goto out_error_pm_runtime_enabled;
+		goto out_error_clock_enabled;
 	}
 
 	return status;
 
-out_error_pm_runtime_enabled:
-	pm_runtime_disable(dev);
-
 out_error_clock_enabled:
 	clk_disable_unprepare(ssp->clk);
 
@@ -1483,8 +1475,6 @@ void pxa2xx_spi_remove(struct device *dev)
 	struct driver_data *drv_data = dev_get_drvdata(dev);
 	struct ssp_device *ssp = drv_data->ssp;
 
-	pm_runtime_get_sync(dev);
-
 	spi_unregister_controller(drv_data->controller);
 
 	/* Disable the SSP at the peripheral and SOC level */
@@ -1495,9 +1485,6 @@ void pxa2xx_spi_remove(struct device *dev)
 	if (drv_data->controller_info->enable_dma)
 		pxa2xx_spi_dma_release(drv_data);
 
-	pm_runtime_put_noidle(dev);
-	pm_runtime_disable(dev);
-
 	/* Release IRQ */
 	free_irq(ssp->irq, drv_data);
 }
-- 
2.43.0.rc1.1336.g36b5255a03ac


