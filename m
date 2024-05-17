Return-Path: <linux-spi+bounces-2930-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAA98C8D06
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 21:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBDEFB23686
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 19:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF35A1411F0;
	Fri, 17 May 2024 19:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nbBQAY+A"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3CF140E2F;
	Fri, 17 May 2024 19:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715975631; cv=none; b=XQp3DLe2/5sWvQssRbhAb7ThEYAvwKGs8+HB/l6p19aANrqGys6DVfhpABTWkhjom2POY5SOOPxehE3Xsi7esnjG/Ra0QgmHcalqst9TD32y8NsAVKsgzYr/Oths3ie94dGmuhER0iNa84/EcHlO/joJPRCVJ0Y+L2vbJ9iyHug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715975631; c=relaxed/simple;
	bh=W/bNA4S9nX43IbueQuZhsG1Td45DsiMHiPAvcVuKhwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTtcUbZ32w1reVj+0Ko9lbMulk20oepzOgBGs3s+UKV1t/3iv2TrVtf1V21hPU/jlafPre4iQf7ToQ4ZY7i/l2jW5Z931ipZX7ot78KoLs5oZV1UwDCunLVEobKZZJYWlGkJHyY4QHpwhGjP9OT4nxJjU65M/0dxR2Hb2NZ6OLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nbBQAY+A; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715975631; x=1747511631;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W/bNA4S9nX43IbueQuZhsG1Td45DsiMHiPAvcVuKhwM=;
  b=nbBQAY+ANBIw1Xxiayvrm++f0pE4oDm+WkZ+cSJpjwE5tf6PtDp+9tNM
   NPpBQ2VrcnxUBLnc9TtbOp4loO6dKXcI9J8nUeFIAISb/eFRYtaUYWSei
   LxRgc+fwZRhYmMtFNXqXYXJhjNbyf17toK8pw6wNzduRML9884gkSj2RA
   idSgCESbzsUIcjeDWks0+AHT8U7MiC1b0osqkWFRMyU9YincCWyM2H0No
   t/DEiW6kuSDuwL2TdcdcOXqD/Op9Yvi/3UpCHwkARACmafqS3ImZZLQjM
   RatXTCpFGW2WIFhKd3MNfuEOsJgM/FExhOa23lH8PClDZBc48SVgDJaXy
   Q==;
X-CSE-ConnectionGUID: Z8LSm04dTeqqKJIyorm5Qw==
X-CSE-MsgGUID: JavCBzajRSGQXaE2giRBAg==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="12348655"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="12348655"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 12:53:49 -0700
X-CSE-ConnectionGUID: X5j2mwAORaSWH/dU5mJkTA==
X-CSE-MsgGUID: YbHcHS0jSwufIy8LJM+1HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="31915006"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 17 May 2024 12:53:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2C135412; Fri, 17 May 2024 22:53:45 +0300 (EEST)
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
Subject: [PATCH v1 02/10] spi: pxa2xx: Remove no more needed driver data
Date: Fri, 17 May 2024 22:47:36 +0300
Message-ID: <20240517195344.813032-3-andriy.shevchenko@linux.intel.com>
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

Since the ACPI enumerated devices provide a property with SSP type,
there is no more necessity to bear the copy of them in the ID table.
Drop the driver data in ACPI ID table.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 877fb6d01cd1..dee5513936ec 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1703,12 +1703,12 @@ static const struct dev_pm_ops pxa2xx_spi_pm_ops = {
 };
 
 static const struct acpi_device_id pxa2xx_spi_acpi_match[] = {
-	{ "80860F0E", LPSS_BYT_SSP },
-	{ "8086228E", LPSS_BSW_SSP },
-	{ "INT33C0", LPSS_LPT_SSP },
-	{ "INT33C1", LPSS_LPT_SSP },
-	{ "INT3430", LPSS_LPT_SSP },
-	{ "INT3431", LPSS_LPT_SSP },
+	{ "80860F0E" },
+	{ "8086228E" },
+	{ "INT33C0" },
+	{ "INT33C1" },
+	{ "INT3430" },
+	{ "INT3431" },
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, pxa2xx_spi_acpi_match);
-- 
2.43.0.rc1.1336.g36b5255a03ac


