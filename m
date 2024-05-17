Return-Path: <linux-spi+bounces-2932-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D36C8C8D08
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 21:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609651C22CE3
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 19:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817E11420A0;
	Fri, 17 May 2024 19:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aozAbQc3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ED41411CD;
	Fri, 17 May 2024 19:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715975632; cv=none; b=Mk8EA40drkFFi0yqJY2maA6FqW6FMrHxY+8IFpPDMYhy7Lt4IURYSsoHCnMosohVRHFOsA1XwnwPit5i6Wn7cLKnmcmyJjD523J9cyUhwZooTUptPWFR3bIOrzk/bgN2prx1HiCZGcKTdN16dnCNX+hmF1gSNTl807jimJ7mGug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715975632; c=relaxed/simple;
	bh=BSnLfbcsr/85SV1zF6LHyE/lUsFxpD7yZqhfm3fFi44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZKWAzQInPc3cpA791iQULAuJpGVrgUsKW7IOIzEsmDFfLutieN7E7bGZFY20omyF57NTgwD0GtOciZk+VYC8eQHKs125Z9bD21bKtQq0N7q12IPtyXv2ElJw+qlgtXoRMuWg3U5Z14DgC8KQlyGbaWITm+1dmVrCzIOflnSSmTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aozAbQc3; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715975631; x=1747511631;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BSnLfbcsr/85SV1zF6LHyE/lUsFxpD7yZqhfm3fFi44=;
  b=aozAbQc3vCgI51Deos0J9RV55dTGjJTstWaXzikfsQmz5GA8MHoN78VE
   i0O4TmfIOu/IENvKGGX+u1tC89luIXdNcm8tAnGqwPAqSdgMA/6mfB1mk
   u3GEky1LjmzdjcHuyuCNvZ7yVyAmWvq1/mGBXCcTPWLz4eGHvP7zP+8BA
   y8WmLSfwr1ojDLtYLk64SO/Xwi5iTShPRY1gDaS+ALlsYvszp+QWY6V13
   +FKbhwRBIJyL7Sirpm7GyKtKX73WSvhgAs3TfZ2TNiA5pNnH31lJ0En21
   NGQkEFY5gjIjoGlLtYCdtLA8Mad3kViu3frkukB6h1TV9crAA33K10F3j
   Q==;
X-CSE-ConnectionGUID: FFQm7Rn7S9Obs6YkvJZIzA==
X-CSE-MsgGUID: tPB6ZrxTQeiayNofFnfWRQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="16004911"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="16004911"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 12:53:48 -0700
X-CSE-ConnectionGUID: pduLhhlYTfCkrnhRFpgZRw==
X-CSE-MsgGUID: XHQJUAJIReinYs/nbLnjZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="36313503"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 17 May 2024 12:53:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 44DC14A3; Fri, 17 May 2024 22:53:45 +0300 (EEST)
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
Subject: [PATCH v1 04/10] spi: pxa2xx: Utilise temporary variable for struct device
Date: Fri, 17 May 2024 22:47:38 +0300
Message-ID: <20240517195344.813032-5-andriy.shevchenko@linux.intel.com>
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

We have a temporary variable to keep a pointer to struct device.
Utilise it where it makes sense.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index e7087228505e..56ff296925b7 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1586,13 +1586,13 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
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
@@ -1602,7 +1602,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	return status;
 
 out_error_pm_runtime_enabled:
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_disable(dev);
 
 out_error_clock_enabled:
 	clk_disable_unprepare(ssp->clk);
@@ -1618,10 +1618,11 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 
 static void pxa2xx_spi_remove(struct platform_device *pdev)
 {
-	struct driver_data *drv_data = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	struct driver_data *drv_data = dev_get_drvdata(dev);
 	struct ssp_device *ssp = drv_data->ssp;
 
-	pm_runtime_get_sync(&pdev->dev);
+	pm_runtime_get_sync(dev);
 
 	spi_unregister_controller(drv_data->controller);
 
@@ -1633,8 +1634,8 @@ static void pxa2xx_spi_remove(struct platform_device *pdev)
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


