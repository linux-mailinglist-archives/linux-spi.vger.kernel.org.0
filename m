Return-Path: <linux-spi+bounces-7098-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 334B4A5E269
	for <lists+linux-spi@lfdr.de>; Wed, 12 Mar 2025 18:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66EBC17842E
	for <lists+linux-spi@lfdr.de>; Wed, 12 Mar 2025 17:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFF524BC09;
	Wed, 12 Mar 2025 17:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NrxGruL6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC1723F369;
	Wed, 12 Mar 2025 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800022; cv=none; b=fhDiAC07jbzopDobvy7ZbLr/jfIGVvEfVk6JLCcW4OwrVUN4hCfObex+qm3j+uPOnIxsOSxOdO/daE5y3UfhbEk64H2L/J44dwIppuaFQt4eVY5VBwcN2bYCvfIgwoZkg1/XL5Dd2FWe/lftr2ZwFUAih/p0LkjkpJpGovcx9Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800022; c=relaxed/simple;
	bh=+z9ZTMm+ywSW9cK4py+Gn/5A/QzUp5MWoPjCNUGPUuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qtq4UngE8CHpOHrm7WSAQxgeLxTNrZQAijxdXZxxkgpoQL5vobAlx2xgcP8Uf4/UcBZfH1EU9R4EESY606FR3k3pLLtFBZYJ9r5yvQdoX8kMD3geQP2cWOpdthQxQ8HMi//DPcAE/3AP1r7tvHgtAu5TUXL01r/mMSU/lkCafPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NrxGruL6; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741800021; x=1773336021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+z9ZTMm+ywSW9cK4py+Gn/5A/QzUp5MWoPjCNUGPUuY=;
  b=NrxGruL6A/Br9HCgO1rhOBNLasYgoL8he2FxGsi8GM+K/uu9h9lUoWRI
   mrbkqdXGek8v/vELxxIDQsWlwHW31j9MNhdbt3u41ExvAKBSqcsHKkfxj
   ujjpec/ncBeEf/yUjPDHJjAcB0Q0onblMBx+z1ab4aZZZujO9RFUDfbtv
   65J7KzTT/ziem0LRsexRD5IHCGr1exCZ+y/9Ej6YH//BHnFS48d0wdsIU
   AW2bsEQBeYUaLd+A1d/i8aJfqNL46sr9sgOgDSCwaWO9SnnkxjW/+OZIJ
   zjjtYiUJ2kSMUFyVXcKhhzLciN+2cw9fSZ2VCzR9v/bwfFXYBMxsd3xNY
   g==;
X-CSE-ConnectionGUID: fIG1libjTX6GD+YIS+2iHg==
X-CSE-MsgGUID: PdRRRx1eQbSH5Q6TtbZR5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="60290610"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="60290610"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 10:20:20 -0700
X-CSE-ConnectionGUID: zmPXf+zDTiC9R94a2DNpJQ==
X-CSE-MsgGUID: W93TXelxSxipWOsYnxa81g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="125769469"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 12 Mar 2025 10:20:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8CE3B130; Wed, 12 Mar 2025 19:20:17 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Longbin Li <looong.bin@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/2] spi: sg2044-nor: Fully convert to device managed resources
Date: Wed, 12 Mar 2025 19:19:16 +0200
Message-ID: <20250312172016.4070094-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250312172016.4070094-1-andriy.shevchenko@linux.intel.com>
References: <20250312172016.4070094-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver has a wrong order of the cleaning up the resources,
i.e. it first will destroy the mutex and only then free the SPI
which might still use it. Fix this by switching to devm_mutex_init().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-sg2044-nor.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-sg2044-nor.c b/drivers/spi/spi-sg2044-nor.c
index 454153a63b42..e104cac57d41 100644
--- a/drivers/spi/spi-sg2044-nor.c
+++ b/drivers/spi/spi-sg2044-nor.c
@@ -435,7 +435,6 @@ static int sg2044_spifmc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	spifmc = spi_controller_get_devdata(ctrl);
-	dev_set_drvdata(&pdev->dev, ctrl);
 
 	spifmc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(spifmc->clk))
@@ -457,14 +456,15 @@ static int sg2044_spifmc_probe(struct platform_device *pdev)
 	ctrl->mem_ops = &sg2044_spifmc_mem_ops;
 	ctrl->mode_bits = SPI_RX_DUAL | SPI_TX_DUAL | SPI_RX_QUAD | SPI_TX_QUAD;
 
-	mutex_init(&spifmc->lock);
+	ret = devm_mutex_init(&spifmc->lock);
+	if (ret)
+		return ret;
 
 	sg2044_spifmc_init(spifmc);
 	sg2044_spifmc_init_reg(spifmc);
 
 	ret = devm_spi_register_controller(&pdev->dev, ctrl);
 	if (ret) {
-		mutex_destroy(&spifmc->lock);
 		dev_err(&pdev->dev, "spi_register_controller failed\n");
 		return ret;
 	}
@@ -472,13 +472,6 @@ static int sg2044_spifmc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void sg2044_spifmc_remove(struct platform_device *pdev)
-{
-	struct sg2044_spifmc *spifmc = platform_get_drvdata(pdev);
-
-	mutex_destroy(&spifmc->lock);
-}
-
 static const struct of_device_id sg2044_spifmc_match[] = {
 	{ .compatible = "sophgo,sg2044-spifmc-nor" },
 	{ /* sentinel */ }
@@ -491,7 +484,6 @@ static struct platform_driver sg2044_nor_driver = {
 		.of_match_table = sg2044_spifmc_match,
 	},
 	.probe = sg2044_spifmc_probe,
-	.remove = sg2044_spifmc_remove,
 };
 module_platform_driver(sg2044_nor_driver);
 
-- 
2.47.2


