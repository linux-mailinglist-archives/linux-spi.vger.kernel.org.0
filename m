Return-Path: <linux-spi+bounces-2934-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 698D88C8D0C
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 21:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0725B1F24C84
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 19:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1591422AE;
	Fri, 17 May 2024 19:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W1qFJX54"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30B31411EF;
	Fri, 17 May 2024 19:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715975633; cv=none; b=M1AEoJuxrPOxA8T1UrqfrtZwGzUneMg7kHtD0FOi/XXuJYW30g7m3GbySCMHtWPX7dbdDnDwwu6boiYRaE6MPilmpY0LfupZc+YZVFy49vzFFzZ+vUPd+bNc6DkcUexGS8/7AstC7+0Z23dEhFrYAR3c0DPQfbZRuGLKzRowOO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715975633; c=relaxed/simple;
	bh=HBWQ6IuxWBHRAQ4QfisCUK6oqXawkSugTUNHrkfwhz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrQ17yALuro5kCS+t9jrXy03OY7kgcd/Q/J7Td8UOzkTU6NvqUC3BrOLTAmhiOReJKA3BfFiqoLgK6dODi8bcjdxe3aMDicYU+gkmq5cnDLZa1wcH/5V9czJkdLsUNRNVIdUSymkzAAPCHPnjErQ+g1JOtCP9ziMYc9ZVUqTELg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W1qFJX54; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715975632; x=1747511632;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HBWQ6IuxWBHRAQ4QfisCUK6oqXawkSugTUNHrkfwhz4=;
  b=W1qFJX54bryzba+zXLwPbYrk+AlguQXnfsKxFVzUmbHOI0f6bNoMdY6S
   ZLPshec/x0EQ/IJtCrbtKUnafVV2nsP98QtPUgMVAnFaTqFUvD52iwOLA
   nOneIwJnAZHM69qSXH1TFIOwwGNyoXOsPGWkRb8jXJ3Es7lFsUah6tsCY
   MqK0Kt0DiYm0m8YYnh87XgzXuh0MmVjGtj6u/4l+afpucxRCj4sTn5Tr+
   g00cBK5E7FSFJqvpz9zyDW8g7lx2bn49oF/roSQmNLpBabG2H2nsQmj4J
   Zl7mvZb5t1ySPAnPzUDsXW+Icc3xcv7i1a1hDcekKbXqpiQ7MVZZFpKl0
   Q==;
X-CSE-ConnectionGUID: Bd3saI1qRk6xqIaEh+4Ybw==
X-CSE-MsgGUID: vj1vER+fT1eq6gJ3vN2HYQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="12348672"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="12348672"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 12:53:52 -0700
X-CSE-ConnectionGUID: MMr9Eq2ETEidSEtteES/3Q==
X-CSE-MsgGUID: 6mSVDHLuRYSdn73/LP21pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="31915015"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 17 May 2024 12:53:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5945253A; Fri, 17 May 2024 22:53:45 +0300 (EEST)
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
Subject: [PATCH v1 06/10] spi: pxa2xx: Remove duplicate check
Date: Fri, 17 May 2024 22:47:40 +0300
Message-ID: <20240517195344.813032-7-andriy.shevchenko@linux.intel.com>
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

The mmio_base can't be NULL at this point. It's either checked
in both pxa_ssp_probe() and pxa2xx_spi_init_ssp() or correctly
provided by PCI core. Hence, remove duplicate check which is
a dead code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 6bbeb1d09ed9..cd28b798b53b 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1417,9 +1417,6 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
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


