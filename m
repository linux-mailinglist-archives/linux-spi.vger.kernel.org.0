Return-Path: <linux-spi+bounces-4178-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B760A9509BE
	for <lists+linux-spi@lfdr.de>; Tue, 13 Aug 2024 18:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E82961C227BB
	for <lists+linux-spi@lfdr.de>; Tue, 13 Aug 2024 16:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17131A7066;
	Tue, 13 Aug 2024 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HRxUxF7D"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDFF1DDD1;
	Tue, 13 Aug 2024 16:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564946; cv=none; b=nTHTbsIyFTrmZqb/gK66AsiU0Zj+7eyOPE7lCsvTjl0PCFgsgpDGGWJ1yIprqVmVP29euX/KKTdyFAHolZXtfInrXAgTPxp5fxgIKGhqVu7D2nUb/yv+NetJkGeskmkUna2WUMmNeAd5s/UXRVpSnIV+tz7b2css+JeHMqXQgtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564946; c=relaxed/simple;
	bh=3AHlG2B/WBFZYYo/igaUVIruv+iD8fdRv1xI5awdYws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J8tJmaf7VBznoqHwz+yAi0uvUZszPHpC5DlViuCJF17SAXUoXmqRDoi4AMzFdckHanxF/UctC+KsSL/y4OBTDdyinED6azXgYig1W5RQPcPkFmrdK2edPhMGpPcdj1AhM9jI399u3Vx8AzXN/oVnAxA5lj+cGKIi3w3dWq64AWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HRxUxF7D; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723564946; x=1755100946;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3AHlG2B/WBFZYYo/igaUVIruv+iD8fdRv1xI5awdYws=;
  b=HRxUxF7Dg4mPdtaywsrtffSMXjPdVS3fsrUsqPzeVIgIWN5qGWOto5TB
   2Ows3hwv5SNOGA8gaFAJZkbM46KM0fD9rZCd5l+miNSFSRlV0FsM+tPAX
   vbDUlr8kSFagphfBFYO0Wt9Lz6N/vsOB/Nt2OgqBZxwqzTXJ0GgIXYywP
   gNfmUqUHP06h9PxSUjqWEbJAlzzkTbQVxqxOkwo13h8YVTvnK1Vi4VQCn
   6HIeSDfT6oIgglT2LLW+oZqQdAbDRkVu95sUKpTCPjJhaHSwqOysBPyGM
   9cn/7/ZRgVF1hyc5yHmdwjxMJ4Zs9qupEYDDg8olPG1D4nFGBq1hWQkUE
   Q==;
X-CSE-ConnectionGUID: lB71HVliRkWGcoRS8a9guw==
X-CSE-MsgGUID: Uw2kH1XFRTS4N6GIWMJWWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21883286"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="21883286"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 09:02:25 -0700
X-CSE-ConnectionGUID: pUJSMR1gTHeZJqLMXe5cIg==
X-CSE-MsgGUID: /Ss//G5lQeGfrPsKsvorIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="59265234"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 13 Aug 2024 09:02:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0CEB718F; Tue, 13 Aug 2024 19:02:21 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] spi: ppc4xx: Avoid returning 0 when failed to parse and map IRQ
Date: Tue, 13 Aug 2024 19:02:20 +0300
Message-ID: <20240813160220.2357338-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

0 is incorrect error code when failed to parse and map IRQ.
Replace OF specific old API for IRQ retrieval with a generic
one to fix this issue.

Fixes: 0f245463b01e ("spi: ppc4xx: handle irq_of_parse_and_map() errors")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-ppc4xx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index 01fdecbf132d..e75a571ae1ba 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -27,7 +27,6 @@
 #include <linux/wait.h>
 #include <linux/platform_device.h>
 #include <linux/of_address.h>
-#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
@@ -412,8 +411,8 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 	}
 
 	/* Request IRQ */
-	hw->irqnum = irq_of_parse_and_map(np, 0);
-	if (hw->irqnum <= 0)
+	hw->irqnum = platform_get_irq(op, 0);
+	if (hw->irqnum < 0)
 		goto free_host;
 
 	ret = request_irq(hw->irqnum, spi_ppc4xx_int,
-- 
2.43.0.rc1.1336.g36b5255a03ac


