Return-Path: <linux-spi+bounces-3148-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F61E8D4EC1
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 17:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407521C23DDA
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 15:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B16183977;
	Thu, 30 May 2024 15:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QMnHOawy"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CB1183069;
	Thu, 30 May 2024 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081886; cv=none; b=L0Eq7JrRjvJewebE2hEaC0lcaibtbOAMz8dvrYY5lPix7AE2MUrBiQDu8XpFfxcC9uNd1Yym1w+qhKCRloSONWTOS6uzTPeJc0yxWEdMzeko1HxCwCSO5hu7fHy0a8dzTJDvnM088QbyMpyvw50uPJKPg41FISHtYq8oySz3JrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081886; c=relaxed/simple;
	bh=xuQ6DZkTEDRxFoGQhloOJPIufIaUVMudZOmQbEL7V4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lm/tP6lVYWg+yrKUPzBk2fbfGr9wkyLgfaG8gdjp4ignsFwwIAuf6Bh84I9We+u3kdlSkrnr/rDh9VElusEsX92TuFj0xo2bu1EWCplOXfkRhYIFl+p/cAxVETsKh+jBC616D5izq/GASyl+7aWHmBcJs+84ujZP8n01Rn34OUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QMnHOawy; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717081885; x=1748617885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xuQ6DZkTEDRxFoGQhloOJPIufIaUVMudZOmQbEL7V4Q=;
  b=QMnHOawylzn5BpobWuukWsrntADyQKpMT//9lujXVWwgSSv+ozPvoXh/
   WVdt6zd+f62f4+vc595dCuSpcW6puTe0dkLzpIYqMaItnw/T1U7HOzBjB
   sdKt04hQo/idrHa3RpkhmIP7smXbxfMkNAZVTcM3Hm4cV1/AbpcfdxDSl
   Z+88XSm3/2s39Cx0wyTJAJN2FuEajeOqmz+h76jHbYgg8h5XZ1/4c8OZj
   tn3y0/0RxgLNtcJK+mx2PcsuXA6BVRF7gDr9m4ShzhGkH9VSKfOFQAwRr
   rPs+KwnA4BEtMH6BDSgQ4c3wU07qxmM8yyX6e/izVfO/30SgOhI8k4jn2
   w==;
X-CSE-ConnectionGUID: igPybMNDQHGXLEI0PLk+wg==
X-CSE-MsgGUID: 6j5A4VV8TyaimG7B+w1d6w==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="31067931"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="31067931"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 08:11:22 -0700
X-CSE-ConnectionGUID: RHkbdXUlRvKwVAoxgpxB+g==
X-CSE-MsgGUID: wsKMsGyIQ363d/2wS2JSeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="73329421"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 30 May 2024 08:11:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2C1252DC; Thu, 30 May 2024 18:11:19 +0300 (EEST)
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
Subject: [PATCH v2 02/11] spi: pxa2xx: Reorganize the SSP type retrieval
Date: Thu, 30 May 2024 18:09:58 +0300
Message-ID: <20240530151117.1130792-3-andriy.shevchenko@linux.intel.com>
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

The old Intel platforms, such as Intel Braswell, also provide
the property of SSP type. Reorganize the pxa2xx_spi_init_pdata()
to take that into account.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 820a3702447a..f4dc113768cd 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1331,19 +1331,21 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	struct pxa2xx_spi_controller *pdata;
 	struct device *dev = &pdev->dev;
 	struct device *parent = dev->parent;
+	const void *match = device_get_match_data(dev);
 	enum pxa_ssp_type type = SSP_UNDEFINED;
-	struct ssp_device *ssp = NULL;
-	const void *match;
+	struct ssp_device *ssp;
 	bool is_lpss_priv;
 	u32 num_cs = 1;
 	int status;
 
-	is_lpss_priv = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lpss_priv");
-
-	match = device_get_match_data(dev);
-	if (match)
-		type = (uintptr_t)match;
-	else if (is_lpss_priv) {
+	ssp = pxa2xx_spi_ssp_request(pdev);
+	if (IS_ERR(ssp))
+		return ERR_CAST(ssp);
+	if (ssp) {
+		type = ssp->type;
+	} else if (match) {
+		type = (enum pxa_ssp_type)(uintptr_t)match;
+	} else {
 		u32 value;
 
 		status = device_property_read_u32(dev, "intel,spi-pxa2xx-type", &value);
@@ -1351,12 +1353,6 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 			return ERR_PTR(status);
 
 		type = (enum pxa_ssp_type)value;
-	} else {
-		ssp = pxa2xx_spi_ssp_request(pdev);
-		if (IS_ERR(ssp))
-			return ERR_CAST(ssp);
-		if (ssp)
-			type = ssp->type;
 	}
 
 	/* Validate the SSP type correctness */
@@ -1368,6 +1364,7 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 		return ERR_PTR(-ENOMEM);
 
 	/* Platforms with iDMA 64-bit */
+	is_lpss_priv = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lpss_priv");
 	if (is_lpss_priv) {
 		pdata->tx_param = parent;
 		pdata->rx_param = parent;
-- 
2.43.0.rc1.1336.g36b5255a03ac


