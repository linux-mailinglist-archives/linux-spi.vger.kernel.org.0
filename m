Return-Path: <linux-spi+bounces-3147-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F708D4EC0
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 17:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928841F2489A
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 15:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CB5183091;
	Thu, 30 May 2024 15:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yc01nAOy"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C5617F51A;
	Thu, 30 May 2024 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081886; cv=none; b=pDTxdPE5IiCbzOvjYY3dQoCSIpA69Q8aQhL0BdLCfvt3ndlJjJT6k0CSt57vbetXo91OEvOIGuet1eWijceIByrZ417/u9/MfNtqXZgTbv8MSU2GhjPgQh//7Yg45GJHWNi3k0HObyRmEWO1MKj29UvEkLmJ43apWNJ8xAGJ/rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081886; c=relaxed/simple;
	bh=Iq9RkCVt6cK9FjvsEVBSiepSsecDquk00YCQe7trEiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rgA0Tsz6AmcLV7MkBq/Rk5gPKma2rBLO5qg52Vg4Wcumik6NwUJ3cyIuP38vBwDnEgQvLVvXdOh7nikqa67oAwcTQOLAG06R8okcSe7YxkY4pZDbKmdDDK5RO1isEatRuwh2j7Umwj1r3eYpIFX2u+uz5VNxOLUM/BLz16jg/do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yc01nAOy; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717081885; x=1748617885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Iq9RkCVt6cK9FjvsEVBSiepSsecDquk00YCQe7trEiE=;
  b=Yc01nAOyIL4YHSCkTUI2NORVogqajT1LmMnQAhmIRoeYA2Kfe15IOjIX
   haQswrBt5DW9/dApS1Ps4PZN5VETL9udDKASummTWWMiEq5ZLN/0Eez5W
   rNAbtwR6DC7Es7sYBHvGqZY4kobccChWRM4CBtHjA3h3dRreAaVjcoovc
   4K99M8EV670Apap2pQ8G/8TZsINV+Jo7Yg0uGJTp8pv1hq6N6yNLwEvku
   akL+GkD/wC7XLLboLIcA7bZNO1gQvM60hxZ+sGLYL7bNDDb6spGuoQbao
   LHU920cZyg4EmMpNXGYUNYaKIbh0RGmsMQTqrvlBihzoDT+9SxiAERWR2
   g==;
X-CSE-ConnectionGUID: SHa4VpxOSDK0jhih79Jh5g==
X-CSE-MsgGUID: VWUWFameSkGAO3zRYH+CXw==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="31093039"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="31093039"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 08:11:22 -0700
X-CSE-ConnectionGUID: G8o5fUUqTo2Es22qCMzxKg==
X-CSE-MsgGUID: /TE0xF6cRluJM0rR4Vu7wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="40288500"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 30 May 2024 08:11:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4322937D; Thu, 30 May 2024 18:11:19 +0300 (EEST)
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
Subject: [PATCH v2 04/11] spi: pxa2xx: Remove hard coded number of chip select pins
Date: Thu, 30 May 2024 18:10:00 +0300
Message-ID: <20240530151117.1130792-5-andriy.shevchenko@linux.intel.com>
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

Remove hard coded number of chip select pins for Intel Braswell.
This comes via property.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index b62a613378e0..53815aab41aa 100644
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
@@ -1594,8 +1592,6 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
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


