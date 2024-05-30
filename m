Return-Path: <linux-spi+bounces-3149-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B838D4EC4
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 17:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 675F01F24CB3
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 15:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2DC186299;
	Thu, 30 May 2024 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dVqKUWX2"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E479183092;
	Thu, 30 May 2024 15:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081887; cv=none; b=V1IFi6Y9dEWRgKamt5x6uc057e/nrHACsAb7bRO5NwZ0wEGRnkxEztn3QMNu5NArcqgDtgXvlRaf5Us8qZ4c2htuh2ptHDNOQM9824QapIxMdFTi1JpzYBiLGWqqWECWYyxWCpHOo9jGATvRYbo8xgtIQ5CJh5uPD883UuhOjwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081887; c=relaxed/simple;
	bh=M+NbhDPEqKAfXCCJumrA9VHagNYen39iF9Q6cbbh/Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+R/ltuLp9CVC0qiVtXOEZGcD4r08kFFnShRShxu+Zw22JAEe/qjGbkFiUrqDauiZ2Cy3Obx0hs2vmmUBOCLGdLkMpHLHcC37xgENMj1A7sQ20UV5mdu9lKTSM6hOfTZzi4lc4E+4WyHpK2W7nUoakkN10y6HjH4bxhnHrdLS30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dVqKUWX2; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717081886; x=1748617886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M+NbhDPEqKAfXCCJumrA9VHagNYen39iF9Q6cbbh/Yc=;
  b=dVqKUWX2xg8zg9bUpbFtGs5szUbFxp1CjO4CU8QNjIymmM+UVw9bG+tc
   xAVCB21KKhdChaiOWN8KYbcmYKbANh3UJrfNC10PVCBsqRBUPk+ql7qsw
   n5K/eLFnTm0TJ8P/wCTeDdp/h4TlSKLK3WFK838Ji6ncGpPnVgUaj/oMS
   8kE6pgFu4gObBw9yLnFwEEObs6REb0OkT8s8KSriwkTMaWi7aF36NJczD
   wMipWgK7nYlpBdrlpYJ2sGdG/iqeq2QI0VinvWqsxbfQ7NUFu68ArAHGl
   kdu9c7yYxvSEIXuuBNJq6i0Wo5zxIRNoFk3JfD0026c4q5FrHOLwEiACF
   A==;
X-CSE-ConnectionGUID: RVvFNXKdSAKoKYSPSHFGow==
X-CSE-MsgGUID: kxOZJfLTTOSTRar7dxAGXw==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="31093050"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="31093050"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 08:11:25 -0700
X-CSE-ConnectionGUID: qt//DRy9Sc+BayjLWr0qfw==
X-CSE-MsgGUID: 55oDytf2S8+9oqMNTbMdmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="40288502"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 30 May 2024 08:11:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 57AEF6AB; Thu, 30 May 2024 18:11:19 +0300 (EEST)
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
Subject: [PATCH v2 05/11] spi: pxa2xx: Utilise temporary variable for struct device
Date: Thu, 30 May 2024 18:10:01 +0300
Message-ID: <20240530151117.1130792-6-andriy.shevchenko@linux.intel.com>
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

We have a temporary variable to keep a pointer to struct device.
Utilise it where it makes sense.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 53815aab41aa..19ee7739f4bd 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1606,13 +1606,13 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 		}
 	}
 
-	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
-	pm_runtime_use_autosuspend(&pdev->dev);
-	pm_runtime_set_active(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(dev, 50);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
 
 	/* Register with the SPI framework */
-	platform_set_drvdata(pdev, drv_data);
+	dev_set_drvdata(dev, drv_data);
 	status = spi_register_controller(controller);
 	if (status) {
 		dev_err_probe(dev, status, "problem registering SPI controller\n");
@@ -1622,7 +1622,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	return status;
 
 out_error_pm_runtime_enabled:
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_disable(dev);
 
 out_error_clock_enabled:
 	clk_disable_unprepare(ssp->clk);
@@ -1636,10 +1636,11 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 
 static void pxa2xx_spi_remove(struct platform_device *pdev)
 {
-	struct driver_data *drv_data = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	struct driver_data *drv_data = dev_get_drvdata(dev);
 	struct ssp_device *ssp = drv_data->ssp;
 
-	pm_runtime_get_sync(&pdev->dev);
+	pm_runtime_get_sync(dev);
 
 	spi_unregister_controller(drv_data->controller);
 
@@ -1651,8 +1652,8 @@ static void pxa2xx_spi_remove(struct platform_device *pdev)
 	if (drv_data->controller_info->enable_dma)
 		pxa2xx_spi_dma_release(drv_data);
 
-	pm_runtime_put_noidle(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(dev);
+	pm_runtime_disable(dev);
 
 	/* Release IRQ */
 	free_irq(ssp->irq, drv_data);
-- 
2.43.0.rc1.1336.g36b5255a03ac


