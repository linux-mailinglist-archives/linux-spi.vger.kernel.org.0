Return-Path: <linux-spi+bounces-3152-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 353408D4ECA
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 17:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ADAFB2167D
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 15:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D181D1CB301;
	Thu, 30 May 2024 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I45hPJ27"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E76718398D;
	Thu, 30 May 2024 15:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081888; cv=none; b=BmEL/GNZQD2p29FswTXneQy+7r3R8pvgkZUBDvd84aGQwAUOuMnPmw/RdXRd3Dwz5RnzKPCzU/YrpEgla9pidG4GbswZ8C35glJLJvk1VS7mPD5R6KO6CfLz2Sp3NMJBWoP23qv1oxQTCKut3ckVmP1/X+9bDkWWCnPDy/d6lxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081888; c=relaxed/simple;
	bh=cyTnsqcupVXst0FyS+yA1egD0GK0RbG+Gy/mnXGgt3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHXMaqzSf1Pi0Uip7ur0wcjze/3PB1+RKQapGpTCym5tJEUlAUrLKRE3TahnlQ1SQPcALFbmJsXDPy1Fl2zyP2LxSj7lw3bT2aq1DiOLqzRfcIXC+ji7Dlbup6TlEa5dXhFRwa2KzFXlE8BemiVpDXCbTU3dup6Upfvk6/cCGfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I45hPJ27; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717081886; x=1748617886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cyTnsqcupVXst0FyS+yA1egD0GK0RbG+Gy/mnXGgt3g=;
  b=I45hPJ2713fkO4tvlkToMiOVMjhUGF/1lO+9VheENaK0KtgG8V/5g6Yf
   xnLmfBfQT0Kvci8nEWxgh22ZJNbP5iqdFA1AZ1RuyM0/QxYuAi5jb1LbQ
   lnU/tR/mGMHl7238SFQUS3a29ntLfc+WalN5lbnS+9swp4oPKX/dnkxie
   4E8xIg7Bvd+osjXjG08giMSwc3jk6e64mpa8XL3PAHjccU04rO5Fkwiet
   lfKnvG4kuUNLmmdgeeG6CM5DuwDnNAjC7P21v6yfr3Y4x+h7ctLutXMjn
   U4WM4aZdQ3PYp1RAt9Y1IPGbT7KmeEr4uMJFvR7qkPOET75safko43nqw
   g==;
X-CSE-ConnectionGUID: 0pZUovU6Rk+fk5N5TUQjWw==
X-CSE-MsgGUID: +IQiDldbTYKztilk0KxyTQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="31067960"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="31067960"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 08:11:25 -0700
X-CSE-ConnectionGUID: TJQT913DSqmlAiaG5MJS2Q==
X-CSE-MsgGUID: OvvpV2LGRful5O8h0mDMvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="73329441"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 30 May 2024 08:11:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 793CA6F1; Thu, 30 May 2024 18:11:19 +0300 (EEST)
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
Subject: [PATCH v2 09/11] spi: pxa2xx: Extract pxa2xx_spi_platform_*() callbacks
Date: Thu, 30 May 2024 18:10:05 +0300
Message-ID: <20240530151117.1130792-10-andriy.shevchenko@linux.intel.com>
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

In preparation of the extracting platform driver from spi-pxa2xx.c
split the probe and remove functions so we have bus independent
and platform device ones.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 52 +++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 3c03a8cd9ee6..74f242e652df 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1413,30 +1413,16 @@ static size_t pxa2xx_spi_max_dma_transfer_size(struct spi_device *spi)
 	return MAX_DMA_LEN;
 }
 
-static int pxa2xx_spi_probe(struct platform_device *pdev)
+static int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp)
 {
-	struct device *dev = &pdev->dev;
 	struct pxa2xx_spi_controller *platform_info;
 	struct spi_controller *controller;
 	struct driver_data *drv_data;
-	struct ssp_device *ssp;
 	const struct lpss_config *config;
 	int status;
 	u32 tmp;
 
 	platform_info = dev_get_platdata(dev);
-	if (!platform_info) {
-		platform_info = pxa2xx_spi_init_pdata(pdev);
-		if (IS_ERR(platform_info))
-			return dev_err_probe(dev, PTR_ERR(platform_info), "missing platform data\n");
-	}
-
-	ssp = pxa2xx_spi_ssp_request(pdev);
-	if (IS_ERR(ssp))
-		return PTR_ERR(ssp);
-	if (!ssp)
-		ssp = &platform_info->ssp;
-
 	if (platform_info->is_target)
 		controller = devm_spi_alloc_target(dev, sizeof(*drv_data));
 	else
@@ -1628,9 +1614,8 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	return status;
 }
 
-static void pxa2xx_spi_remove(struct platform_device *pdev)
+static void pxa2xx_spi_remove(struct device *dev)
 {
-	struct device *dev = &pdev->dev;
 	struct driver_data *drv_data = dev_get_drvdata(dev);
 	struct ssp_device *ssp = drv_data->ssp;
 
@@ -1708,6 +1693,35 @@ static const struct dev_pm_ops pxa2xx_spi_pm_ops = {
 	RUNTIME_PM_OPS(pxa2xx_spi_runtime_suspend, pxa2xx_spi_runtime_resume, NULL)
 };
 
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
 static const struct acpi_device_id pxa2xx_spi_acpi_match[] = {
 	{ "80860F0E" },
 	{ "8086228E" },
@@ -1732,8 +1746,8 @@ static struct platform_driver driver = {
 		.acpi_match_table = pxa2xx_spi_acpi_match,
 		.of_match_table = pxa2xx_spi_of_match,
 	},
-	.probe = pxa2xx_spi_probe,
-	.remove_new = pxa2xx_spi_remove,
+	.probe = pxa2xx_spi_platform_probe,
+	.remove_new = pxa2xx_spi_platform_remove,
 };
 
 static int __init pxa2xx_spi_init(void)
-- 
2.43.0.rc1.1336.g36b5255a03ac


