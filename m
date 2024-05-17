Return-Path: <linux-spi+bounces-2931-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA2E8C8D07
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 21:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CBF41C2239F
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 19:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F48A1411FF;
	Fri, 17 May 2024 19:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DoN+pkcU"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977E0140E4D;
	Fri, 17 May 2024 19:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715975632; cv=none; b=DwBqx+oAopSyGY2sWA4c0Q5e8lOWfV1n/12LAS4aB78ZuPPphCTNA2oG1RkAuFVByKWXlGs7wuDo0WuoGJ2Jrse0x0pJ8SGyUvt3W3ccM90hvEEKElvIwlkJyfv0CEBBuq8B8HSVn9paShnThHXQlKIH9XUZRMCPmTQ5BSe/N0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715975632; c=relaxed/simple;
	bh=0gIMmyJJTI2Ipz0HBjg4zm0dtXuKg8fOksHpUFhIUT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MwhKLT67LjVeq45/lq0lkZ5hGRTtMwnVvHeS/gjfHh3gCljFrQTiwQ1cE9Xoxbi98edgZ/MWzfwRBtIwIS77s4PDZTpBUZdfFy5CG3lQRhK2Nc6WvaMAoZ3nnmHJ1ucEc0lefnDOI/Sg6YrOIiR2M6faahnG9TKfwitnRKNuyV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DoN+pkcU; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715975630; x=1747511630;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0gIMmyJJTI2Ipz0HBjg4zm0dtXuKg8fOksHpUFhIUT8=;
  b=DoN+pkcUQWe/a+4QvDupuIQm4702lvGmm7fyytDacl09mV0fr/XFkJJf
   gATP0iNUm9cAKL8lIquntFpj+5g1xkM2UoQkxoGs0WwPCwIRRFC0IjTM1
   r8zWYElyIXwhW6ByTbJh9cY4zP7O1ewCuu3SJuJ26NhrJkB1QqkqO4RG6
   dyiJQzk/4rDzgvGblBhUi91a90p+XRko4itpuR0mEmcXQcVvKJBvuT8zd
   0czyQoStVmD8TJYOUy14t9yHDS1eNciLa+RyL3X+jqY6vROjd4Ep/7kU6
   U3kJ3zOfJFgvCRO58xckCsaafsFJb8qsJZ1onUZ5wHJ3aw0W7p/TmemSO
   g==;
X-CSE-ConnectionGUID: quSNOe/aQUiq8EiVahdhXQ==
X-CSE-MsgGUID: VcfRgHXhRlWeMASrXzBLQg==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="16004899"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="16004899"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 12:53:48 -0700
X-CSE-ConnectionGUID: pbsSzbLrRxSzszoL9NFkNg==
X-CSE-MsgGUID: zYbAUfGpSa6EtnedYR+6CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="36313502"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 17 May 2024 12:53:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3856B44E; Fri, 17 May 2024 22:53:45 +0300 (EEST)
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
Subject: [PATCH v1 03/10] spi: pxa2xx: Remove hard coded number of chip select pins
Date: Fri, 17 May 2024 22:47:37 +0300
Message-ID: <20240517195344.813032-4-andriy.shevchenko@linux.intel.com>
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

Remove hard coded number of chip select pins for Intel Braswell.
This comes via property.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index dee5513936ec..e7087228505e 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -99,7 +99,6 @@ struct lpss_config {
 	/* Chip select control */
 	unsigned cs_sel_shift;
 	unsigned cs_sel_mask;
-	unsigned cs_num;
 	/* Quirks */
 	unsigned cs_clk_stays_gated : 1;
 };
@@ -137,7 +136,6 @@ static const struct lpss_config lpss_platforms[] = {
 		.tx_threshold_hi = 224,
 		.cs_sel_shift = 2,
 		.cs_sel_mask = 1 << 2,
-		.cs_num = 2,
 	},
 	{	/* LPSS_SPT_SSP */
 		.offset = 0x200,
@@ -1574,8 +1572,6 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 			tmp &= LPSS_CAPS_CS_EN_MASK;
 			tmp >>= LPSS_CAPS_CS_EN_SHIFT;
 			platform_info->num_chipselect = ffz(tmp);
-		} else if (config->cs_num) {
-			platform_info->num_chipselect = config->cs_num;
 		}
 	}
 	controller->num_chipselect = platform_info->num_chipselect;
-- 
2.43.0.rc1.1336.g36b5255a03ac


