Return-Path: <linux-spi+bounces-7099-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2280FA5E26A
	for <lists+linux-spi@lfdr.de>; Wed, 12 Mar 2025 18:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61C8189D28C
	for <lists+linux-spi@lfdr.de>; Wed, 12 Mar 2025 17:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916C124DFFC;
	Wed, 12 Mar 2025 17:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F2WErT8m"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABA323A9B4;
	Wed, 12 Mar 2025 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800022; cv=none; b=Qx+qm+juXWCrux7jyDxZFT6kq7CWnHrVkW0wgC4VAKk5YJpRGlegxdQAA2fzmcfZ4Wr09Lqw26Yrnimbd2t+4aLOAhKacEkS6xzFIBNMMbC9ZxOAudQJy8EDR17O9t9N18tCUKp9GraC8VNKl4cwtfHa9qi6WLPbDk/OQ4QBb5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800022; c=relaxed/simple;
	bh=DSY/0ZYdgoOqfhegeeH5tpLBcAHVsHe199It4fxl4ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBZfK7KH4G3wlS41Vu6+lvGGCClGzNnSdXGQSErX3fTmmfVhW8BZXqBuHPJWRyLAPOpxS/nrknC5TDTUwZl71cqOYbUeBK0qwp6HP2ot1A11a2LbRE/VHTlDBzp4qACgmCLWiatwgTICMfJ5a5sp+Mkz8Hr3TXjdO0gEFrw3Jkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F2WErT8m; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741800021; x=1773336021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DSY/0ZYdgoOqfhegeeH5tpLBcAHVsHe199It4fxl4ng=;
  b=F2WErT8mb0BbJFbwY6IhPQUfj7lqJp/pIzMcoF186EQ0bucCCTF4Vk2t
   DoWSCKBDnqsTFHYP2Ef+ciXujz1k6e4cf8ev+90E2a9A5A8dtMBiAVq9o
   x0T1HXpIGj4/UWIXhu96mQvxM8UqaVhsokIrVz2cayCH4L310DYxJ+ZRT
   8++mgvcLlakHbYF9Fo5pWdx8D9w7cVxBMCKPO5QpEFkY7Pang4Tr0Ffmu
   JxnI7yS7HkU+W5lFKSK7iGfERaHkfnype0aSTmehmT+KuuyMsj4JppmvG
   +bfSK0bX1hf6E4/l8F+EsL9VlGYF+1Y0t5El17KyX99VuArWO38Gy1Zm2
   w==;
X-CSE-ConnectionGUID: 8T+GjSXSSDqvRka2nEWajw==
X-CSE-MsgGUID: YOPMO1odQbiJ6lneMBx2HA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="60437576"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="60437576"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 10:20:20 -0700
X-CSE-ConnectionGUID: 2tPf249mTYO4jMnqB0k1Gg==
X-CSE-MsgGUID: 8ky2A82DQCmlItJRwbczBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="125337215"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 12 Mar 2025 10:20:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9F395214; Wed, 12 Mar 2025 19:20:17 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Longbin Li <looong.bin@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 2/2] spi: sg2044-nor: Convert to dev_err_probe()
Date: Wed, 12 Mar 2025 19:19:17 +0200
Message-ID: <20250312172016.4070094-3-andriy.shevchenko@linux.intel.com>
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

One of the cases in sg2044_spifmc_probe() may be converted to use
dev_err_probe(). Do it.

While at it, use local device pointer in all such calls and drop
unneeded __func__ parameter as dev_err_probe() is assumed to be called
only during probe phase.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-sg2044-nor.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-sg2044-nor.c b/drivers/spi/spi-sg2044-nor.c
index e104cac57d41..572792a59195 100644
--- a/drivers/spi/spi-sg2044-nor.c
+++ b/drivers/spi/spi-sg2044-nor.c
@@ -425,6 +425,7 @@ static void sg2044_spifmc_init(struct sg2044_spifmc *spifmc)
 
 static int sg2044_spifmc_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct spi_controller *ctrl;
 	struct sg2044_spifmc *spifmc;
 	void __iomem *base;
@@ -438,9 +439,7 @@ static int sg2044_spifmc_probe(struct platform_device *pdev)
 
 	spifmc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(spifmc->clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(spifmc->clk),
-				     "%s: Cannot get and enable AHB clock\n",
-				     __func__);
+		return dev_err_probe(dev, PTR_ERR(spifmc->clk), "Cannot get and enable AHB clock\n");
 
 	spifmc->dev = &pdev->dev;
 	spifmc->ctrl = ctrl;
@@ -464,10 +463,8 @@ static int sg2044_spifmc_probe(struct platform_device *pdev)
 	sg2044_spifmc_init_reg(spifmc);
 
 	ret = devm_spi_register_controller(&pdev->dev, ctrl);
-	if (ret) {
-		dev_err(&pdev->dev, "spi_register_controller failed\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "spi_register_controller failed\n");
 
 	return 0;
 }
-- 
2.47.2


