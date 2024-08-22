Return-Path: <linux-spi+bounces-4266-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9D095B3F2
	for <lists+linux-spi@lfdr.de>; Thu, 22 Aug 2024 13:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C1761F23CF2
	for <lists+linux-spi@lfdr.de>; Thu, 22 Aug 2024 11:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D1D1C9430;
	Thu, 22 Aug 2024 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XG+r0S8L"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9251C9426;
	Thu, 22 Aug 2024 11:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724326461; cv=none; b=P9aphHKCczc23MKZKfQPgDtoq67MIoJQUcLao5v7MBsKb450+WrznjZ8diRZeXH5Yta9HHje3r7b3gMsuMdjMtQBvGarHkjU0R9P1DQqtf6G1dR7uvRXfHYkVe/nuEnIecX+BPPtnSiLqnSbKIQsmiIZI8ssBoOJ7HNnVvCp3QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724326461; c=relaxed/simple;
	bh=b0Zy460fRKKLuxb9DRCTkqckSrkfUegLFAgVrZNZEhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TRRtrw1lMbPx+8rljHv7KjrKPrXbqjjaoMWej32uyD0DPDV0TAoCf9lgmavesJq2/1c8p8YCMiaAubY76bzroZZEvIgyXyINqyZk2fy3G7ehcgnU6cLlRJ+PlikLPfWHSIZ8USxoCLj0iKyw9LDizii3j0Jb/6A4CxUboq4vmN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XG+r0S8L; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724326459; x=1755862459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b0Zy460fRKKLuxb9DRCTkqckSrkfUegLFAgVrZNZEhs=;
  b=XG+r0S8LA7vgtRDHzkvRlMNooAzs4eb5DPjibcZfe+eQeE+HPfHhozQ3
   fUH0ikKwGTTErFuZm67XXNaJCfppVe24Hkp9sT4TG1C1VfNFCXVhF/JkG
   8NaMACPYmUfTcHOqd6s8U91KZbqifJ+0pikTF0ci+OqOmPMo4IC15vYxn
   0BpGWjVDZVv5Xg+OAGyMOwaD5R28cd94A7/F67sSkdX7Ygsx3f/sHnGeO
   4E418tqUfaFvJApM0UUYj/TCG2VSBrBkpbSeTN716b6e56/eocX4p6BJD
   yDV9JcqPK6a2YFTb9XnPBo9+HdZXQ0FaTJSbkjwnll/EQJSWnBS3O7fO8
   g==;
X-CSE-ConnectionGUID: Cy7nqBYsR/+4ualbrYBE7Q==
X-CSE-MsgGUID: jxTA2nrVTmWoIFV6ULfEUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22547604"
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="22547604"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 04:34:13 -0700
X-CSE-ConnectionGUID: 1dgtJN+9Se6cxFzk8J55kg==
X-CSE-MsgGUID: mSHf4CnBTbOCXCt3+uGGgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="61566056"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 22 Aug 2024 04:34:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 95EE7268; Thu, 22 Aug 2024 14:34:09 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Hao Ma <hao.ma@intel.com>
Subject: [PATCH v1 1/2] spi: pxa2xx: Do not override dev->platform_data on probe
Date: Thu, 22 Aug 2024 14:30:53 +0300
Message-ID: <20240822113408.750831-2-andriy.shevchenko@linux.intel.com>
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

The platform_data field may be supplied by legacy board code.
In other cases we override it, and module remove and probe cycle
will crash the kernel since it will carry a stale pointer.

Fix this by supplying a third argument to the pxa2xx_spi_probe()
and avoid overriding dev->platform_data.

Reported-by: Hao Ma <hao.ma@intel.com>
Fixes: cc160697a576 ("spi: pxa2xx: Convert PCI driver to use spi-pxa2xx code directly")
Fixes: 3d8f037fbcab ("spi: pxa2xx: Move platform driver to a separate file")
Fixes: 20ade9b9771c ("spi: pxa2xx: Extract pxa2xx_spi_platform_*() callbacks")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-pci.c      | 2 +-
 drivers/spi/spi-pxa2xx-platform.c | 6 ++----
 drivers/spi/spi-pxa2xx.c          | 5 ++---
 drivers/spi/spi-pxa2xx.h          | 3 ++-
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 616d032f1a89..c98bb214b6ae 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -297,7 +297,7 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 		return ret;
 	ssp->irq = pci_irq_vector(dev, 0);
 
-	return pxa2xx_spi_probe(&dev->dev, ssp);
+	return pxa2xx_spi_probe(&dev->dev, ssp, pdata);
 }
 
 static void pxa2xx_spi_pci_remove(struct pci_dev *dev)
diff --git a/drivers/spi/spi-pxa2xx-platform.c b/drivers/spi/spi-pxa2xx-platform.c
index 98a8ceb7db6f..f9504cddc7ba 100644
--- a/drivers/spi/spi-pxa2xx-platform.c
+++ b/drivers/spi/spi-pxa2xx-platform.c
@@ -63,7 +63,7 @@ static struct ssp_device *pxa2xx_spi_ssp_request(struct platform_device *pdev)
 
 	ssp = pxa_ssp_request(pdev->id, pdev->name);
 	if (!ssp)
-		return ssp;
+		return NULL;
 
 	status = devm_add_action_or_reset(&pdev->dev, pxa2xx_spi_ssp_release, ssp);
 	if (status)
@@ -148,8 +148,6 @@ static int pxa2xx_spi_platform_probe(struct platform_device *pdev)
 		platform_info = pxa2xx_spi_init_pdata(pdev);
 		if (IS_ERR(platform_info))
 			return dev_err_probe(dev, PTR_ERR(platform_info), "missing platform data\n");
-
-		dev->platform_data = platform_info;
 	}
 
 	ssp = pxa2xx_spi_ssp_request(pdev);
@@ -158,7 +156,7 @@ static int pxa2xx_spi_platform_probe(struct platform_device *pdev)
 	if (!ssp)
 		ssp = &platform_info->ssp;
 
-	return pxa2xx_spi_probe(dev, ssp);
+	return pxa2xx_spi_probe(dev, ssp, platform_info);
 }
 
 static void pxa2xx_spi_platform_remove(struct platform_device *pdev)
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 16b96eb176cd..e3a95adc5279 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1277,16 +1277,15 @@ static size_t pxa2xx_spi_max_dma_transfer_size(struct spi_device *spi)
 	return MAX_DMA_LEN;
 }
 
-int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp)
+int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
+		     struct pxa2xx_spi_controller *platform_info)
 {
-	struct pxa2xx_spi_controller *platform_info;
 	struct spi_controller *controller;
 	struct driver_data *drv_data;
 	const struct lpss_config *config;
 	int status;
 	u32 tmp;
 
-	platform_info = dev_get_platdata(dev);
 	if (platform_info->is_target)
 		controller = devm_spi_alloc_target(dev, sizeof(*drv_data));
 	else
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index a470d3d634d3..447be0369384 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -132,7 +132,8 @@ extern void pxa2xx_spi_dma_stop(struct driver_data *drv_data);
 extern int pxa2xx_spi_dma_setup(struct driver_data *drv_data);
 extern void pxa2xx_spi_dma_release(struct driver_data *drv_data);
 
-int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp);
+int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
+		     struct pxa2xx_spi_controller *platform_info);
 void pxa2xx_spi_remove(struct device *dev);
 
 extern const struct dev_pm_ops pxa2xx_spi_pm_ops;
-- 
2.43.0.rc1.1336.g36b5255a03ac


