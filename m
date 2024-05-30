Return-Path: <linux-spi+bounces-3150-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BAC8D4EC5
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 17:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C976286D34
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 15:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2101862A6;
	Thu, 30 May 2024 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EA7ZgozL"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D4E183980;
	Thu, 30 May 2024 15:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081887; cv=none; b=ICxELE5ndVayJMLc92gqfxXy6RlemN2JjvvS0wy9y8NdswdYsnY3SoUIBJiZstCiuuI9XRmET/dlUp00MeX4k/479Xd5RQg54qy3sy71GbvnovJdnD84mWyxAO+xqIC+BXuA1u4ugsLrGxi4ke8y2giHAYb9Qn2vFmaXmIkzuBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081887; c=relaxed/simple;
	bh=YN44JYZqoEKQIIQ+HPXBPHzx9SDRMV97fZqyIcUXYdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oorUHBUy1jR+vG3kTTB17MHOo8dasK/b+36yJQrolUg51jPhZWTqbOtiLwWVsa5KTm4HuUjb8XJ+gIWD7/Dzg1un11tgT/sLOpTOOz6qHhU0f8uGan9wuwotdWzqStbHzAg42vSh6sFDuOXOhbKFhQfts7z0qNsulJZI/tdAQR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EA7ZgozL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717081886; x=1748617886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YN44JYZqoEKQIIQ+HPXBPHzx9SDRMV97fZqyIcUXYdE=;
  b=EA7ZgozLJMcJKCzKyI4/NpdG+wfYwgAz6n/FEXXi3ikB46RJfrFmCul8
   53P1XDHV/Ymn1NUDLx98EFatBUVA8i9e3hGKuXPn2xcynC8pQHVgiTfY7
   JPkQWMoGojjGGyG+KT5rS0gUH5PCRpeSk0ZasDJRpzRa41mTNvNYEeTn4
   kSqJCVqOov+2pq/7nyJ6VM0JRTnPvKAiZuU8s1hhx8VBdp9ZZqZJF9hEs
   93NlObs/RGeR3uhu8XYgWT4w4bMckrmUgQeKhf1vpfGMGJrHfv3uhlN77
   Hk+O7a4h/ud4pdfTFLcKuJyWILkI3/6lSe0o2DrpQjtFiWuJZJ8YJ3FTq
   A==;
X-CSE-ConnectionGUID: tDhQ02EAT3uRY4b1VUgk4w==
X-CSE-MsgGUID: knrqNqEBT+SeyLYKr6ab4w==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="31067948"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="31067948"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 08:11:25 -0700
X-CSE-ConnectionGUID: s1k/pvsFTLmW63bqcbIURg==
X-CSE-MsgGUID: ZULTayxvTv6OSYz0zy9cQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="73329437"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 30 May 2024 08:11:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 7677D700; Thu, 30 May 2024 18:11:19 +0300 (EEST)
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
Subject: [PATCH v2 08/11] spi: pxa2xx: Remove superflous check for Intel Atom SoCs
Date: Thu, 30 May 2024 18:10:04 +0300
Message-ID: <20240530151117.1130792-9-andriy.shevchenko@linux.intel.com>
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

pxa2xx_spi_fw_translate_cs() checks for the ACPI companion device
presence along with the SSP type. But the SSP type is uniquely
determines the case. Hence remove the superflous check.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 9724d9455837..3c03a8cd9ee6 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1393,23 +1393,19 @@ static int pxa2xx_spi_fw_translate_cs(struct spi_controller *controller,
 {
 	struct driver_data *drv_data = spi_controller_get_devdata(controller);
 
-	if (has_acpi_companion(drv_data->ssp->dev)) {
-		switch (drv_data->ssp_type) {
-		/*
-		 * For Atoms the ACPI DeviceSelection used by the Windows
-		 * driver starts from 1 instead of 0 so translate it here
-		 * to match what Linux expects.
-		 */
-		case LPSS_BYT_SSP:
-		case LPSS_BSW_SSP:
-			return cs - 1;
+	switch (drv_data->ssp_type) {
+	/*
+	 * For some of Intel Atoms the ACPI DeviceSelection used by the Windows
+	 * driver starts from 1 instead of 0 so translate it here to match what
+	 * Linux expects.
+	 */
+	case LPSS_BYT_SSP:
+	case LPSS_BSW_SSP:
+		return cs - 1;
 
-		default:
-			break;
-		}
+	default:
+		return cs;
 	}
-
-	return cs;
 }
 
 static size_t pxa2xx_spi_max_dma_transfer_size(struct spi_device *spi)
-- 
2.43.0.rc1.1336.g36b5255a03ac


