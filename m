Return-Path: <linux-spi+bounces-2935-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6F28C8D0D
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 21:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA9B1C23020
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 19:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5781422C7;
	Fri, 17 May 2024 19:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I77hG0Qm"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E1B14198A;
	Fri, 17 May 2024 19:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715975633; cv=none; b=VtZB817mS/CVDuVC0NkQvtenMg50L16rBmDMkOu5QcTH54o4UhXVf7MgndsHLLKTuJZDgcd9UbD9qziqZnzrLekZVP7Ufv1hp2R2BJDLfL1/PCz9+HKUNMc4ZI1QOpWDnH3pR1MqDgPetIZZdifbOUlS6tffPK7pWr3qT6iCaY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715975633; c=relaxed/simple;
	bh=y1UPm7DX7C60ENAe+k+9dpW4n3R67mPRIBKTRmhcBrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NetHaHWPRCBkkTC8h8VyToLgZBKu5EACi+XrMa00ZAYarl6AdAYaPji31LFygTSeXyEx8q5bn2ArCmtKQlfeFeEDXOJ3B4J8O3cnLnek7bw+eva4eN+JoqkrEDXjE3czN44fhk82hog63hUzMzqEZqqh24PKxiF4EPVrzt9HFkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I77hG0Qm; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715975632; x=1747511632;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y1UPm7DX7C60ENAe+k+9dpW4n3R67mPRIBKTRmhcBrk=;
  b=I77hG0QmaMJxkxCyc+h8xqoTkLsOCh5lyNB1ylLL1hQM+l5RO2PFdm0q
   LVWXnWxFFHu5/DJ+06iz3eBfR80EqE+5X80tQ2x3NX24JheytbSPOE6A3
   D8Z58V0FsIWFnAwME65EtPYYfciqDhz92vxVtjvtI+QM7lJG3B+qfY92j
   DjJLn7RXpMVdSt/S8XP9WdTnuL7tVDFWA7E8Im4YMb0tY3tO33xKeH2QJ
   whVb69Nfxd0vvr425mRBXGaF8CzUB8NRS6YitWLoMe96/vFvZ86NG/1PR
   iMtF1zT6XFJW90zErbSZRVJmqZVRYyRguBOiIHafEote0/u0yBfz6bZC0
   g==;
X-CSE-ConnectionGUID: /ou79cBoTaiyflhEbT0oHw==
X-CSE-MsgGUID: vB2Dj5zZTyGd+LIpld5gBA==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="16004917"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="16004917"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 12:53:51 -0700
X-CSE-ConnectionGUID: Wft6TsYRRoSZHbMsnWL+HA==
X-CSE-MsgGUID: fzXitw+FQg2Sx5qys0iupA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="36313506"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 17 May 2024 12:53:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 727D45C5; Fri, 17 May 2024 22:53:45 +0300 (EEST)
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
Subject: [PATCH v1 08/10] spi: pxa2xx: Extract pxa2xx_spi_platform_*() callbacks
Date: Fri, 17 May 2024 22:47:42 +0300
Message-ID: <20240517195344.813032-9-andriy.shevchenko@linux.intel.com>
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

In preparation of the extracting platform driver from spi-pxa2xx.c
split the probe and remove functions so we have bus independent
and platform device ones.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 63 +++++++++++++++++++++++++++-------------
 1 file changed, 43 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 3ea4b9821a8e..f53827d61a21 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1391,28 +1391,16 @@ static size_t pxa2xx_spi_max_dma_transfer_size(struct spi_device *spi)
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
-	ssp = pxa_ssp_request(pdev->id, pdev->name);
-	if (!ssp)
-		ssp = &platform_info->ssp;
-
 	if (platform_info->is_target)
 		controller = devm_spi_alloc_target(dev, sizeof(*drv_data));
 	else
@@ -1610,9 +1598,8 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	return status;
 }
 
-static void pxa2xx_spi_remove(struct platform_device *pdev)
+static void pxa2xx_spi_remove(struct device *dev)
 {
-	struct device *dev = &pdev->dev;
 	struct driver_data *drv_data = dev_get_drvdata(dev);
 	struct ssp_device *ssp = drv_data->ssp;
 
@@ -1633,9 +1620,6 @@ static void pxa2xx_spi_remove(struct platform_device *pdev)
 
 	/* Release IRQ */
 	free_irq(ssp->irq, drv_data);
-
-	/* Release SSP */
-	pxa_ssp_free(ssp);
 }
 
 static int pxa2xx_spi_suspend(struct device *dev)
@@ -1693,6 +1677,45 @@ static const struct dev_pm_ops pxa2xx_spi_pm_ops = {
 	RUNTIME_PM_OPS(pxa2xx_spi_runtime_suspend, pxa2xx_spi_runtime_resume, NULL)
 };
 
+static int pxa2xx_spi_platform_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pxa2xx_spi_controller *platform_info;
+	struct ssp_device *ssp;
+	int status;
+
+	platform_info = dev_get_platdata(dev);
+	if (!platform_info) {
+		platform_info = pxa2xx_spi_init_pdata(pdev);
+		if (IS_ERR(platform_info))
+			return dev_err_probe(dev, PTR_ERR(platform_info), "missing platform data\n");
+
+		dev->platform_data = platform_info;
+
+	}
+
+	ssp = pxa_ssp_request(pdev->id, pdev->name);
+	if (!ssp)
+		ssp = &platform_info->ssp;
+
+	status = pxa2xx_spi_probe(dev, ssp);
+	if (status)
+		pxa_ssp_free(ssp);
+
+	return status;
+}
+
+static void pxa2xx_spi_platform_remove(struct platform_device *pdev)
+{
+	struct driver_data *drv_data = platform_get_drvdata(pdev);
+	struct ssp_device *ssp = drv_data->ssp;
+
+	pxa2xx_spi_remove(&pdev->dev);
+
+	/* Release SSP */
+	pxa_ssp_free(ssp);
+}
+
 static const struct acpi_device_id pxa2xx_spi_acpi_match[] = {
 	{ "80860F0E" },
 	{ "8086228E" },
@@ -1717,8 +1740,8 @@ static struct platform_driver driver = {
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


