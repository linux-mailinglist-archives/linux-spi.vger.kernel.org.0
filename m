Return-Path: <linux-spi+bounces-2926-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3578C8CED
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 21:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B30C1C2269E
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 19:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAC6141987;
	Fri, 17 May 2024 19:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LlsXsMjN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5601411C8;
	Fri, 17 May 2024 19:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715974974; cv=none; b=tJV21R8ltPG21o0BI9oA9cnT2LW2Qu2JmzXt6yYfAnh4+mBiD/Z1n2arWZmMy6VFebNAKVsjlAokGRqXParygC2q07SxgAvPdsOQKPMkZguus6iaMxyI3UEZU4rw7gKDg0a8iWJ7lkE6AW8AI2BoNJuoownjh+UC6zyMTwgk6+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715974974; c=relaxed/simple;
	bh=tth4i9z4tN9bpsaaew9NWOzq4W2ulOpkhRXHXUekINA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQjGWfiCVyI4eswhncEN28viOvgEQGwrg0cdTIJJJcw0L4nhXGb6dtskgnA9+gIsc/iYRZLSmae3IivWakJXiWhRZ2LDtRHmlezbqBdVsMq2o9PccApKkRV4Fnun8daOz38mTnJYAL+FO29rWDh0REOn8pghHbN3Jsv+hs2R08A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LlsXsMjN; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715974974; x=1747510974;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=tth4i9z4tN9bpsaaew9NWOzq4W2ulOpkhRXHXUekINA=;
  b=LlsXsMjNymHpaXeIW4e1xUuxKQQo7mGdiTRTxFA10N56n/NH99LrVsNl
   NA42cf/hO22LrWqApuTEDK2bZEuauioWu8avUO/Xckej4EWCWrhC8NzJ0
   X+OHtGtuiwcTfkbPwtgUhhgBY2bzHJvYWyAYlG5IlcM3lcLEnSlT8JL5Q
   fDB58VNjnVn4Y6Zkozcn9yP5Yz0eETgiM+u2/QAVAs9f0TSgZLbJu+6Wc
   s1Bi7v9MoFeU5kaWwlELFpUd8iTbE0ewKaKRs2JYpLszY0M9cqb2sxJHe
   38JQuZYAD6iD8AMmwM9h+rs9n8WYM8KGVyQN4Q0bYBcb5CBi7D8cptugL
   A==;
X-CSE-ConnectionGUID: v8mnb8CNT1iKQr609v54Kg==
X-CSE-MsgGUID: O7Jth8EjRc2iEBMIM1tzlg==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="12284445"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="12284445"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 12:42:50 -0700
X-CSE-ConnectionGUID: Z6FEC964SjqsKys5UHAxBQ==
X-CSE-MsgGUID: K0JXPaHlRHiud2vEUOkpuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="31877131"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 17 May 2024 12:42:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6291E2D2; Fri, 17 May 2024 22:42:47 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] spi: gpio: Use traditional pattern when checking error codes
Date: Fri, 17 May 2024 22:42:02 +0300
Message-ID: <20240517194246.747427-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240517194246.747427-1-andriy.shevchenko@linux.intel.com>
References: <20240517194246.747427-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of 'if (!ret)' switch to "check for the error first" rule.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-gpio.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index abf426711c22..36c587be9e28 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -239,8 +239,8 @@ static void spi_gpio_chipselect(struct spi_device *spi, int is_active)
 static int spi_gpio_setup(struct spi_device *spi)
 {
 	struct gpio_desc	*cs;
-	int			status = 0;
 	struct spi_gpio		*spi_gpio = spi_to_spi_gpio(spi);
+	int ret;
 
 	/*
 	 * The CS GPIOs have already been
@@ -248,15 +248,14 @@ static int spi_gpio_setup(struct spi_device *spi)
 	 */
 	if (spi_gpio->cs_gpios) {
 		cs = spi_gpio->cs_gpios[spi_get_chipselect(spi, 0)];
-		if (!spi->controller_state && cs)
-			status = gpiod_direction_output(cs,
-						  !(spi->mode & SPI_CS_HIGH));
+		if (!spi->controller_state && cs) {
+			ret = gpiod_direction_output(cs, !(spi->mode & SPI_CS_HIGH));
+			if (ret)
+				return ret;
+		}
 	}
 
-	if (!status)
-		status = spi_bitbang_setup(spi);
-
-	return status;
+	return spi_bitbang_setup(spi);
 }
 
 static int spi_gpio_set_direction(struct spi_device *spi, bool output)
-- 
2.43.0.rc1.1336.g36b5255a03ac


