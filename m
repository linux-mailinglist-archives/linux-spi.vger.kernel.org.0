Return-Path: <linux-spi+bounces-3146-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC02C8D4EBD
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 17:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9264728616C
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 15:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F6E183061;
	Thu, 30 May 2024 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZmScHrAw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF1E17D8A0;
	Thu, 30 May 2024 15:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081885; cv=none; b=dqPJGdJK8eX4NxQBlPNda8vM3SzQYKXdRjUIm6hcpHokNS7VPnp3/p6tT/gYHWgygL957nbLL0252vVg/oRdVQeG2OcnNcoRVMrOvxOiwFOapPIdpEsl7htu/2C78xRoaKJUjqHjGJNj5hjyqGYkOt2gtFJT3bpVS1SROP78JgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081885; c=relaxed/simple;
	bh=k3Jy0JpJWn+p7UbeUn2JOtEhZjdt6wmsCwt1uObyvpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpR6kWvYKKv/MUrUP64A7MHT6VVk/E1PHs5k2o/j0/EOBwDcRDIOnf7JS1VfSMvfMkr3Qxeb2FawTBCzyeakL+5AzTdRXma679GGpUaGwbwa1LJw7UhQIAVhC0PjPNlAo10ny76ujBjkekjRGXEsbqrz3DpqE9eYfqzOGf/TjgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZmScHrAw; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717081883; x=1748617883;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k3Jy0JpJWn+p7UbeUn2JOtEhZjdt6wmsCwt1uObyvpA=;
  b=ZmScHrAw3M+hFiIrvptF5EaBYlM8ZCjf81yaddD0i6nMmB09CmPUwAdS
   ALbsn9QOp0vcGiPs711vSG/EKMYQuKJ6j3aZLZbTnnTJCFagIjKIQpckl
   aSPvPxSXiOMue5F5cCJq46Am+ATEJ4bpRaX6Z3TsfLbpVaoDFIlOXoPWR
   OLQXtmPmVa2ViGgCXkXQunJylCUsyk/B1ouSTwPZ8lIYS+8X1V416nIzO
   CsoQgpcH4fYiZw0p/txG6+SkUtDdvY29yhDn+9HfMebEfkaSGEKUcprrn
   OgZo4dY140skcplqGQMtCxceZw1e2kPsixzIBE/pwbuAimB3bbvmGiZx6
   Q==;
X-CSE-ConnectionGUID: 88tGk9vWSoKQV/jRgiKYAA==
X-CSE-MsgGUID: DWqNC1mSRum5pxfG87EjpA==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="31067913"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="31067913"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 08:11:22 -0700
X-CSE-ConnectionGUID: ygWNtsUCSgCvlGSapsJ15A==
X-CSE-MsgGUID: PLdcGkwCRzas9WXXnyuVnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="73329420"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 30 May 2024 08:11:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2268B184; Thu, 30 May 2024 18:11:19 +0300 (EEST)
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
Subject: [PATCH v2 01/11] spi: pxa2xx: Wrap pxa_ssp_request() to be device managed resource
Date: Thu, 30 May 2024 18:09:57 +0300
Message-ID: <20240530151117.1130792-2-andriy.shevchenko@linux.intel.com>
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

In the error path or remove path the reference counter in PXA SSP driver
may be dropped before the other resources, that were allocated after
bumbing the reference counter. This breaks reversed order of freeing and
might have an undesired side effects. Prevent this from happening by
wrapping pxa_ssp_request() to be device managed resource.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 50 +++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index efe76d0c21bb..820a3702447a 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1304,6 +1304,27 @@ pxa2xx_spi_init_ssp(struct platform_device *pdev, struct ssp_device *ssp, enum p
 	return 0;
 }
 
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
 static struct pxa2xx_spi_controller *
 pxa2xx_spi_init_pdata(struct platform_device *pdev)
 {
@@ -1331,11 +1352,11 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 
 		type = (enum pxa_ssp_type)value;
 	} else {
-		ssp = pxa_ssp_request(pdev->id, pdev->name);
-		if (ssp) {
+		ssp = pxa2xx_spi_ssp_request(pdev);
+		if (IS_ERR(ssp))
+			return ERR_CAST(ssp);
+		if (ssp)
 			type = ssp->type;
-			pxa_ssp_free(ssp);
-		}
 	}
 
 	/* Validate the SSP type correctness */
@@ -1420,7 +1441,9 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	}
 	dev_dbg(dev, "DMA burst size set to %u\n", platform_info->dma_burst_size);
 
-	ssp = pxa_ssp_request(pdev->id, pdev->name);
+	ssp = pxa2xx_spi_ssp_request(pdev);
+	if (IS_ERR(ssp))
+		return PTR_ERR(ssp);
 	if (!ssp)
 		ssp = &platform_info->ssp;
 
@@ -1431,11 +1454,9 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 		controller = devm_spi_alloc_target(dev, sizeof(*drv_data));
 	else
 		controller = devm_spi_alloc_host(dev, sizeof(*drv_data));
+	if (!controller)
+		return dev_err_probe(dev, -ENOMEM, "cannot alloc spi_controller\n");
 
-	if (!controller) {
-		status = dev_err_probe(dev, -ENOMEM, "cannot alloc spi_controller\n");
-		goto out_error_controller_alloc;
-	}
 	drv_data = spi_controller_get_devdata(controller);
 	drv_data->controller = controller;
 	drv_data->controller_info = platform_info;
@@ -1486,10 +1507,8 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 
 	status = request_irq(ssp->irq, ssp_int, IRQF_SHARED, dev_name(dev),
 			drv_data);
-	if (status < 0) {
-		dev_err_probe(dev, status, "cannot get IRQ %d\n", ssp->irq);
-		goto out_error_controller_alloc;
-	}
+	if (status < 0)
+		return dev_err_probe(dev, status, "cannot get IRQ %d\n", ssp->irq);
 
 	/* Setup DMA if requested */
 	if (platform_info->enable_dma) {
@@ -1619,8 +1638,6 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	pxa2xx_spi_dma_release(drv_data);
 	free_irq(ssp->irq, drv_data);
 
-out_error_controller_alloc:
-	pxa_ssp_free(ssp);
 	return status;
 }
 
@@ -1646,9 +1663,6 @@ static void pxa2xx_spi_remove(struct platform_device *pdev)
 
 	/* Release IRQ */
 	free_irq(ssp->irq, drv_data);
-
-	/* Release SSP */
-	pxa_ssp_free(ssp);
 }
 
 static int pxa2xx_spi_suspend(struct device *dev)
-- 
2.43.0.rc1.1336.g36b5255a03ac


