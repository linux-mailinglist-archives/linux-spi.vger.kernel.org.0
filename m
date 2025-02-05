Return-Path: <linux-spi+bounces-6631-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 086C5A28B8C
	for <lists+linux-spi@lfdr.de>; Wed,  5 Feb 2025 14:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B14D618817DA
	for <lists+linux-spi@lfdr.de>; Wed,  5 Feb 2025 13:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593CC5464E;
	Wed,  5 Feb 2025 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IFtL7rWk"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB4870831;
	Wed,  5 Feb 2025 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738761693; cv=none; b=rodWV8Pd3vHTdd1obTotnPbKvL9dgjccFsqcouF7T79c2O8PZ0K4WMqltFqzzZnh0gIRlhGLAAWhC1PHhMQ9w5sz7LrpVVEdyS/n5ZDtVf0ZxEv5meKn306bsmhZ/BWFpSHWEaHNKS502mcvQvAjIGD+KghSJ4k2bxmYRaAXwyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738761693; c=relaxed/simple;
	bh=PcZF8Mh0I3fiGr3H7noYOcLCJ0x/BNRLrTpQaLtCchU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jXsh70Ng8h421lKNdoT2acG0MAiEff1EoQZgrU7PRI9Di9/UVAposs6qkc9wDGHUQHNHAYnOjqz+yU10NNmttpza8kYWy3HEWLGRzf1ezyZ/CsA3U+auCHJkWOKqkVhwzIdCzqRBPj/Pe/9zqGGW59VYM9Qg4aqnmJAcaWMa2Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IFtL7rWk; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738761691; x=1770297691;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PcZF8Mh0I3fiGr3H7noYOcLCJ0x/BNRLrTpQaLtCchU=;
  b=IFtL7rWkX7RuvGGk4AXXH2JodyHsdLC9NrmCr8wfOFw/j9VegkFZUodd
   5SXioFSza73NER1A425Kl0K8wsRVRqcfHzCRtyXy73oK7gCv+7NbCy4SP
   kl6NLLeX3KPkeNFcsWrec+zR17Uz0qQufF3ceGuO854+kWPjUyS98JzuW
   tErBZpUlb2TpOesLdGDCgb/7miAsUt20NYCMOwUvOVAZjG+i/ro84Xc9y
   ecbGHrAiK5CYx25L4MWDwwJH/V5hJKvXvU/W/LPhEa1Y2s7OU9VuzRn0S
   939KNVXDHVZ9Xr0kfbvMdqghHELbxzIsvttPUrZ9q367eu9+/mODNZuuB
   g==;
X-CSE-ConnectionGUID: H4jlPcCsSEi8NcZpTpaJkA==
X-CSE-MsgGUID: 1JXn8t/aSz+LsEE8EXdaWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39437074"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="39437074"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 05:21:31 -0800
X-CSE-ConnectionGUID: sFgOkWQdR+225rQSQzoQzQ==
X-CSE-MsgGUID: 552QTmBOTsywXkDh/jULfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110748759"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 05 Feb 2025 05:21:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 61B4EEA; Wed, 05 Feb 2025 15:21:28 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/2] spi: gpio: Remove stale documentation part
Date: Wed,  5 Feb 2025 15:19:19 +0200
Message-ID: <20250205132127.742750-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20250205132127.742750-1-andriy.shevchenko@linux.intel.com>
References: <20250205132127.742750-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SPI GPIO driver doesn't support hard coded absolute GPIO numbers
anymore. However, it may still be instantiated from board files with
help of GPIO lookup tables or device properties. Neither of this is
covered by the old part of the documentation, it's the opposite, i.e.
old documentation pretend that antique approach still works. With all
this said, remove stale and confusing part of the documentation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-gpio.c | 34 ++--------------------------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 4f192e013cd6..80a1aed42951 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -39,36 +39,8 @@ struct spi_gpio {
 
 /*----------------------------------------------------------------------*/
 
-/*
- * Because the overhead of going through four GPIO procedure calls
- * per transferred bit can make performance a problem, this code
- * is set up so that you can use it in either of two ways:
- *
- *   - The slow generic way:  set up platform_data to hold the GPIO
- *     numbers used for MISO/MOSI/SCK, and issue procedure calls for
- *     each of them.  This driver can handle several such busses.
- *
- *   - The quicker inlined way:  only helps with platform GPIO code
- *     that inlines operations for constant GPIOs.  This can give
- *     you tight (fast!) inner loops, but each such bus needs a
- *     new driver.  You'll define a new C file, with Makefile and
- *     Kconfig support; the C code can be a total of six lines:
- *
- *		#define DRIVER_NAME	"myboard_spi2"
- *		#define	SPI_MISO_GPIO	119
- *		#define	SPI_MOSI_GPIO	120
- *		#define	SPI_SCK_GPIO	121
- *		#define	SPI_N_CHIPSEL	4
- *		#include "spi-gpio.c"
- */
-
-#ifndef DRIVER_NAME
 #define DRIVER_NAME	"spi_gpio"
 
-#define GENERIC_BITBANG	/* vs tight inlines */
-
-#endif
-
 /*----------------------------------------------------------------------*/
 
 static inline struct spi_gpio *__pure
@@ -341,10 +313,9 @@ static int spi_gpio_probe_pdata(struct platform_device *pdev,
 	struct spi_gpio *spi_gpio = spi_controller_get_devdata(host);
 	int i;
 
-#ifdef GENERIC_BITBANG
 	if (!pdata || !pdata->num_chipselect)
 		return -ENODEV;
-#endif
+
 	/*
 	 * The host needs to think there is a chipselect even if not
 	 * connected
@@ -445,8 +416,6 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	return devm_spi_register_controller(&pdev->dev, host);
 }
 
-MODULE_ALIAS("platform:" DRIVER_NAME);
-
 static const struct of_device_id spi_gpio_dt_ids[] = {
 	{ .compatible = "spi-gpio" },
 	{}
@@ -465,3 +434,4 @@ module_platform_driver(spi_gpio_driver);
 MODULE_DESCRIPTION("SPI host driver using generic bitbanged GPIO ");
 MODULE_AUTHOR("David Brownell");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
2.43.0.rc1.1336.g36b5255a03ac


