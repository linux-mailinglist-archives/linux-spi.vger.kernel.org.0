Return-Path: <linux-spi+bounces-7110-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36497A5F21B
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 12:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3558F1892634
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 11:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4288026657B;
	Thu, 13 Mar 2025 11:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YZXe7lAg"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB56264617;
	Thu, 13 Mar 2025 11:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741864471; cv=none; b=PzjrKKsLnK2AsV+lJMPfj2NoG/F4g6SW1SIYfdUc9CBtLYQWgcSb354WwtrBWnWofarB/pN6Szx5OxfIfcOdUsrFnNzdjsGJpz20Opb1Kb2swyOQny11YmPtPrXV+HjJibuwU2s1zUkkJeb+E1+kXFTh3hYe1dTZiZTEHMLnK5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741864471; c=relaxed/simple;
	bh=AiAMIkIYVbOm1ncyqzGZpuRKpcbX2blbIdRGHAh49Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cX1cfeB0qubUOZVq4wz7XrSxSuAeJIg9LEC22FSUwSA8GZy8Q69Pk34WcfUBWySAVK7zZzz5uQ/D1jCmk/8RGps88z5f8m+wESgdQW+BInXffFMBMofavwSwqOdPHbJs6v2MZDFHo6/EGmS9DgSKbegLhLAGRvPU07weaUWWKLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YZXe7lAg; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741864470; x=1773400470;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AiAMIkIYVbOm1ncyqzGZpuRKpcbX2blbIdRGHAh49Ds=;
  b=YZXe7lAgfTb3i1CLYgzCV7cRTKN2e8pw865JGqnII9A4mM2WMriy+QiP
   vHnvY9Iu49jbLWbhdYQeAN6oLbHkTgd/5l9SAgfni9BVlDuZD4gaSuwlM
   JuyHtTDfDiStg7B1XLFXipsUrgRQpD0LYlKri1tzhCum9bSsezk0re4QQ
   9bsaEKMYSTdn0s+3BmUQuFFxbsvToG7Ibs0NfEsHzAuPf9goma7faCMfJ
   QUuIQ1dTKXNjohZNWfg/VhJMK4/bCl4AmkRSV1JoQvTnpy+VMLjmIBlBf
   MZP6/MmBMRc35qYgZKWbKdpv5LrB7bXhGlxv1MbhaEQZy9Abp18F2dyG4
   Q==;
X-CSE-ConnectionGUID: Livby1rZROK0gqAxkOG+zA==
X-CSE-MsgGUID: sTnmoUoAQYSpiys2ItOvOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="53612348"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="53612348"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 04:14:29 -0700
X-CSE-ConnectionGUID: V6yT945oTh6QLswtR8vgSQ==
X-CSE-MsgGUID: GZRwkNqFTiOtMCrAGFYhjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="144104385"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 13 Mar 2025 04:14:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 73AFE214; Thu, 13 Mar 2025 13:14:26 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Longbin Li <looong.bin@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 1/2] spi: sg2044-nor: Fully convert to device managed resources
Date: Thu, 13 Mar 2025 13:12:59 +0200
Message-ID: <20250313111423.322775-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250313111423.322775-1-andriy.shevchenko@linux.intel.com>
References: <20250313111423.322775-1-andriy.shevchenko@linux.intel.com>
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
 drivers/spi/spi-sg2044-nor.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-sg2044-nor.c b/drivers/spi/spi-sg2044-nor.c
index 454153a63b42..95822f2fc521 100644
--- a/drivers/spi/spi-sg2044-nor.c
+++ b/drivers/spi/spi-sg2044-nor.c
@@ -425,6 +425,7 @@ static void sg2044_spifmc_init(struct sg2044_spifmc *spifmc)
 
 static int sg2044_spifmc_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct spi_controller *ctrl;
 	struct sg2044_spifmc *spifmc;
 	void __iomem *base;
@@ -435,7 +436,6 @@ static int sg2044_spifmc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	spifmc = spi_controller_get_devdata(ctrl);
-	dev_set_drvdata(&pdev->dev, ctrl);
 
 	spifmc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(spifmc->clk))
@@ -457,14 +457,15 @@ static int sg2044_spifmc_probe(struct platform_device *pdev)
 	ctrl->mem_ops = &sg2044_spifmc_mem_ops;
 	ctrl->mode_bits = SPI_RX_DUAL | SPI_TX_DUAL | SPI_RX_QUAD | SPI_TX_QUAD;
 
-	mutex_init(&spifmc->lock);
+	ret = devm_mutex_init(dev, &spifmc->lock);
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
@@ -472,13 +473,6 @@ static int sg2044_spifmc_probe(struct platform_device *pdev)
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
@@ -491,7 +485,6 @@ static struct platform_driver sg2044_nor_driver = {
 		.of_match_table = sg2044_spifmc_match,
 	},
 	.probe = sg2044_spifmc_probe,
-	.remove = sg2044_spifmc_remove,
 };
 module_platform_driver(sg2044_nor_driver);
 
-- 
2.47.2


