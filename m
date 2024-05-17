Return-Path: <linux-spi+bounces-2928-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7228C8D00
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 21:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C0FF1C222A4
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 19:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69988140E2E;
	Fri, 17 May 2024 19:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lZlmtNKH"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E7713DDB0;
	Fri, 17 May 2024 19:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715975630; cv=none; b=n59YJpdKu7d0QpimQXVHkKwSEGx+CILxDLDdV0LlBInW+I70HylHfuQk41TshUmltNVmvTyvXy7b8bDZW6ImWLVBH3DVhFSj3swTCAqIzM05llDkQF1N2Q5xpcVOWWpqzi4g0UiplED1Ypxn+wa0S7mkBikdhswlSECqoM81VcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715975630; c=relaxed/simple;
	bh=jyYGQlzaUy8BwNeOWGIhenb9cBWqNz5Bb5cNI/enzAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFsDsBeYDm+l6CrXZdMSKJc9xCvdCjZ9zDc2vUviS1XDutiKpJwCtqayCWrb/5yabwM2ilxrdAu41MfQa1rGKtPPW0W5B9M6url3S1ffquhJ+iCE+h2xQjWS+ZfPUxE30gW23JhTus1wdo9fuSF326lGNGTEzvSpALpB0X3tojk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lZlmtNKH; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715975629; x=1747511629;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jyYGQlzaUy8BwNeOWGIhenb9cBWqNz5Bb5cNI/enzAQ=;
  b=lZlmtNKHkMN7YT+Kv4LG2P71kOUDICgLtI85Y/erorTJJzHcgrj8Gtx7
   iyzmGvuIkwP7kqNHvUVMO+CjLMXReQnSfdc32S9yjsdJXBpHikINagEFS
   RbQzVO5mLwdTAT5bZ6IRxa3sQIocU58DDZwy+pErKidZ3CN/cjhbFD6DD
   HxM72xZEtUqeCBmBZhu+lsFe5l3XvgEtrmccg1UTxUsyBk4NN3EsYkf9L
   mtVrjieJ4ZGqu0KcGLtHQ4KinhqnaeVYLR+6O5Xe9uvNAkM3Ck1+FFvFk
   vG0mMQaPzx7Gb4UrvPWwNKemyv/UzzMYuayWpAvh9DqoNUXW9pE8Y1ec4
   w==;
X-CSE-ConnectionGUID: KTC5qtx9SlGdtkTjb6A25w==
X-CSE-MsgGUID: LRi5uRXuT0+FCjeXuwWWdQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="12348646"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="12348646"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 12:53:49 -0700
X-CSE-ConnectionGUID: a2vzALrrSBuLGdm6o6BN0Q==
X-CSE-MsgGUID: fu+sBTnTR22Wj8TvwYEG/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="31915005"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 17 May 2024 12:53:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1FC47118; Fri, 17 May 2024 22:53:45 +0300 (EEST)
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
Subject: [PATCH v1 01/10] spi: pxa2xx: Reorganize the SSP type retrieval
Date: Fri, 17 May 2024 22:47:35 +0300
Message-ID: <20240517195344.813032-2-andriy.shevchenko@linux.intel.com>
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

The old Intel platforms, such as Intel Braswell, also provide
the property of SSP type. Reorganize the pxa2xx_spi_init_pdata()
to take that into account.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index efe76d0c21bb..877fb6d01cd1 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1310,19 +1310,20 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	struct pxa2xx_spi_controller *pdata;
 	struct device *dev = &pdev->dev;
 	struct device *parent = dev->parent;
+	const void *match = device_get_match_data(dev);
 	enum pxa_ssp_type type = SSP_UNDEFINED;
 	struct ssp_device *ssp = NULL;
-	const void *match;
 	bool is_lpss_priv;
 	u32 num_cs = 1;
 	int status;
 
-	is_lpss_priv = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lpss_priv");
-
-	match = device_get_match_data(dev);
-	if (match)
-		type = (uintptr_t)match;
-	else if (is_lpss_priv) {
+	ssp = pxa_ssp_request(pdev->id, pdev->name);
+	if (ssp) {
+		type = ssp->type;
+		pxa_ssp_free(ssp);
+	} else if (match) {
+		type = (enum pxa_ssp_type)(uintptr_t)match;
+	} else {
 		u32 value;
 
 		status = device_property_read_u32(dev, "intel,spi-pxa2xx-type", &value);
@@ -1330,12 +1331,6 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 			return ERR_PTR(status);
 
 		type = (enum pxa_ssp_type)value;
-	} else {
-		ssp = pxa_ssp_request(pdev->id, pdev->name);
-		if (ssp) {
-			type = ssp->type;
-			pxa_ssp_free(ssp);
-		}
 	}
 
 	/* Validate the SSP type correctness */
@@ -1347,6 +1342,7 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 		return ERR_PTR(-ENOMEM);
 
 	/* Platforms with iDMA 64-bit */
+	is_lpss_priv = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lpss_priv");
 	if (is_lpss_priv) {
 		pdata->tx_param = parent;
 		pdata->rx_param = parent;
-- 
2.43.0.rc1.1336.g36b5255a03ac


