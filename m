Return-Path: <linux-spi+bounces-6633-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B364DA28B91
	for <lists+linux-spi@lfdr.de>; Wed,  5 Feb 2025 14:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC4A3A7466
	for <lists+linux-spi@lfdr.de>; Wed,  5 Feb 2025 13:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3123982D98;
	Wed,  5 Feb 2025 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cfPBMriY"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE1978F41;
	Wed,  5 Feb 2025 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738761695; cv=none; b=Pc9LKtKJOdYNcE/UPytQ0jfIsZ3zs+OgfQET+lYqd9P/csUzYvt2DeqqUtcSLMXAqTo+vLRcuVMF01WTLWXjc/lWbf93hs5jQyyx69XNsPn9Xj3MeNI35vwYkIEs4QH2Rk5RKaFqv3FNZK+9y43hSkEpc521XGfKoTty0qwFmXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738761695; c=relaxed/simple;
	bh=hz3OU/cb9sPwt8Lyl1TUVPPz9LqumzBzVsrk/Nq98Jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YspPeKDob4PEQCjBHZWejHnWzSztFccl3ZDOh92pXLSq353bniZJHHUWrMTTkwMBShhj7jkD0/29+QiZh7A4mrSZ5R92iMjmN84EjwwsfIcx6ORHcahzkSnE+3xzglWyapp1aEAkpulABuaOLTinO/+I9oGvBwNiyXjHS1Eo4uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cfPBMriY; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738761693; x=1770297693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hz3OU/cb9sPwt8Lyl1TUVPPz9LqumzBzVsrk/Nq98Jo=;
  b=cfPBMriYOmT/1dt8ZrkOG/PRbHaYdZ3y9kEZTGOxFHK4nb6Esq2t0vHz
   DGj5parV63pvLkv4vIbeio1n4XSEZCL3Pet3pusoSkChF9tGLiiTg7wJP
   nArU0NdH/BVni9M+swVnL+0gNyQuk7vQUjsH7tfucUwzOTQzYOE9q1f9R
   SpKMeVziGxhciONwJ/vBX9F/agME8RnCNHG4p7W8F41E2BbW8gjGQPzdQ
   Ue+lA3PGYeqDUp6LTkyWaTR7EtkG6I5QCUk4VaF94taxJYoWSCVYiBXGa
   Ab2OsKxCj6x0S1aK+L4eXGrq3XpUt+NC9KAsz4o2YRyDUJttcDxRpl2+B
   w==;
X-CSE-ConnectionGUID: zrMj0W/jQsuST/u1TuwItQ==
X-CSE-MsgGUID: 1xE1B1FyTwWvWlV4lRlxzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39437076"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="39437076"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 05:21:31 -0800
X-CSE-ConnectionGUID: NcGzS3iWRtGhQMv/xujAMQ==
X-CSE-MsgGUID: XLNr6UVUTKun8ckhYsQAPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110748760"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 05 Feb 2025 05:21:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6B71110D; Wed, 05 Feb 2025 15:21:28 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 2/2] spi: gpio: Support a single always-selected device
Date: Wed,  5 Feb 2025 15:19:20 +0200
Message-ID: <20250205132127.742750-3-andriy.shevchenko@linux.intel.com>
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

The generic SPI code, the SPI GPIO driver functions support
a single always-connected device cases. The only impediment
is that board instantiation prevents that from happening.
Update spi_gpio_probe_pdata() checks to support the mentioned
hardware setup.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-gpio.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 80a1aed42951..405deb6677c1 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -313,15 +313,14 @@ static int spi_gpio_probe_pdata(struct platform_device *pdev,
 	struct spi_gpio *spi_gpio = spi_controller_get_devdata(host);
 	int i;
 
-	if (!pdata || !pdata->num_chipselect)
+	if (!pdata)
 		return -ENODEV;
 
-	/*
-	 * The host needs to think there is a chipselect even if not
-	 * connected
-	 */
-	host->num_chipselect = pdata->num_chipselect ?: 1;
+	/* It's just one always-selected device, fine to continue */
+	if (!pdata->num_chipselect)
+		return 0;
 
+	host->num_chipselect = pdata->num_chipselect;
 	spi_gpio->cs_gpios = devm_kcalloc(dev, host->num_chipselect,
 					  sizeof(*spi_gpio->cs_gpios),
 					  GFP_KERNEL);
-- 
2.43.0.rc1.1336.g36b5255a03ac


