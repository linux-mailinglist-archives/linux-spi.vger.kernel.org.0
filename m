Return-Path: <linux-spi+bounces-3153-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBD68D4ECB
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 17:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73612287030
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 15:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC0E3DAC06;
	Thu, 30 May 2024 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AgfWg0T4"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28F81862A7;
	Thu, 30 May 2024 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081889; cv=none; b=WfgMoCGyaMcf7oDYuoxeOv3F4cfu7+OSo5xuYPcIbrFrWrFg2YU98OQbwfqjRCgWgXabjLGuWtTkj/9gArcVzXnJoLdDS8cSY9bJJOt+5xIyg6y3h5z4RvEwc3X6V9j6ltZtfJsoFi+Ywaeu73ihEwF/RaKEEIkKeUh2yhRBYHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081889; c=relaxed/simple;
	bh=KHmkxGTrimggz5XiV2P+I49lCexUOiH4Nb0XpNE5VMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pqp/y65JC0yksGr5KZdbckd9BhViB294BBYXLprrV9xEOnhgA1+v0BS81bQlZ9iypkPilzDwpJqtM2jcYKPjpD/Ki9fkJwLoESkJ6/xg1t/08QwB15BVAagtQPPw73cXt+iYL3hs0EOIH/dPvCuMsmmW75/iNoIeLM4o9z9xp0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AgfWg0T4; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717081888; x=1748617888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KHmkxGTrimggz5XiV2P+I49lCexUOiH4Nb0XpNE5VMs=;
  b=AgfWg0T4w7Wsz4TmEAbYFE7+y+mquoIsHbML8lWRVTaxzyjUda/x61+F
   J1BAPthBS1rVZYLTaxP/BAiec5ID5oDggbKKhCpa0Pto9y0TrcnBKPH54
   HcNOWRRL2AfUcXqnx5wq4Cztw2UQG2Te0S+omgPKGFDDXFM6dtWaAmx+y
   W1zkdrzwAAOjv4rYzflnV2mQE1yIF7PpMMx0EEkv7l88OD7rxLiU/h3Pm
   OAZTrTFSwTYK/ttCfupGeWlnytL4roko1fyShQKq51Gi4VrQ9F4sK2VKi
   TYYa61tgXOZjiQSBIhlnX2DG1RgNoIYAMMEZuwK0Vyivsv8wBfSoogPNe
   A==;
X-CSE-ConnectionGUID: vej+lL29TjOOlfY02kNEHg==
X-CSE-MsgGUID: kwD5rdU9SgCTa2CVpD8Z2A==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="31067968"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="31067968"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 08:11:26 -0700
X-CSE-ConnectionGUID: ZmLvxdsRRH2XteUsnIoQpw==
X-CSE-MsgGUID: t+vO54S1RdSW0kg0YoLNBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="73329439"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 30 May 2024 08:11:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 68409679; Thu, 30 May 2024 18:11:19 +0300 (EEST)
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
Subject: [PATCH v2 07/11] spi: pxa2xx: Remove duplicate check
Date: Thu, 30 May 2024 18:10:03 +0300
Message-ID: <20240530151117.1130792-8-andriy.shevchenko@linux.intel.com>
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

The mmio_base can't be NULL at this point. It's either checked
in both pxa_ssp_probe() and pxa2xx_spi_init_ssp() or correctly
provided by PCI core. Hence, remove duplicate check which is
a dead code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 30a829b74a22..9724d9455837 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1441,9 +1441,6 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	if (!ssp)
 		ssp = &platform_info->ssp;
 
-	if (!ssp->mmio_base)
-		return dev_err_probe(dev, -ENODEV, "failed to get SSP\n");
-
 	if (platform_info->is_target)
 		controller = devm_spi_alloc_target(dev, sizeof(*drv_data));
 	else
-- 
2.43.0.rc1.1336.g36b5255a03ac


