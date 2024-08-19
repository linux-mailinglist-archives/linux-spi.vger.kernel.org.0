Return-Path: <linux-spi+bounces-4236-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 518BD9574F6
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 21:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840EF1C20754
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 19:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551EB1D54CA;
	Mon, 19 Aug 2024 19:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iHs3wOji"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1C11DD38D;
	Mon, 19 Aug 2024 19:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724097040; cv=none; b=EJPcq0IdBNgzWgKAd1boyO2X7lD8CrlkkF97JFkCKc9VrxxoXkR1t9j31wr6cgvuJFW3LpTZYi750pQLxRJShrLwdbsb+3SVk4V7BOL1dXu7K1ulRDXFdt9fYhIkQRHEg6Ero+mlAjj13FK2n3MRQza6o2OpJwu3mNXN1h1lkqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724097040; c=relaxed/simple;
	bh=zNWlPg/XHG5JWYhe5V1kit6lAimfd3NUN45yFbpmsic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T/Q/HYyU6yp1rZv+Cd/xUn6Bg9LNqaMYTe75wQiyJ4OBByax+t01p4NSHKAUXzJDzc8IdYr1Nhhf17CALPWfzj2AkvLeMgP0FZjPh2jS6GrStKv7B4T/Sn3u3Lf7CZAWm/n5TGVJm+cgze3b7dpTuJ7cZa3upvtxIwHtViWKfdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iHs3wOji; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724097038; x=1755633038;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zNWlPg/XHG5JWYhe5V1kit6lAimfd3NUN45yFbpmsic=;
  b=iHs3wOji7GxosCOIGbW/mH6okku3yHNzI7CCpxYPphjv8sbg0VJ8V8ia
   DNDCIChJmj4cijGRDMALAXsHWN+VUgftAYlR69LbND9GhMaBC/6UT5JNO
   fA/mVsPaXKRd39QfMT4fgqmErvT/Lb+izeXqis2qss548LXufPFDu+z8M
   xuUZIzer0N8vLKNYzBNCXHOvxLMHRrB50qj6pOyNan6xHar2/cgMqqn41
   3VH1olvmUs6s39Ssy2TS0lIPfsA/Kntlkc4H2W+qAmEvmC3h3vLpNieBE
   kGFo/k008z9LGXqhOfQDfnnWyjkeMg1Paz5NNU3ocwkBNHGN927wHSuxO
   A==;
X-CSE-ConnectionGUID: sM/NX568Qyen/1zRmfikgw==
X-CSE-MsgGUID: xrS1dxDZQkCOoSRts6nvRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="33749348"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="33749348"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 12:50:35 -0700
X-CSE-ConnectionGUID: CZXDIhLvTo6ZxdyfevMK1Q==
X-CSE-MsgGUID: oozUtGoHTdyslmO18BNXUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="60460687"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 19 Aug 2024 12:50:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DACCC2D8; Mon, 19 Aug 2024 22:50:32 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] Revert "spi: ppc4xx: handle irq_of_parse_and_map() errors"
Date: Mon, 19 Aug 2024 22:50:29 +0300
Message-ID: <20240819195029.2388397-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit f1011ba20b83da3ee70dcb4a6d9d282a718916fa.

The commit had been applied twice as
  0f245463b01e ("spi: ppc4xx: handle irq_of_parse_and_map() errors")
and
  f1011ba20b83 ("spi: ppc4xx: handle irq_of_parse_and_map() errors")

Revert the latter one.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-ppc4xx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index 6071f83dd9c8..8f6309f32de0 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -416,9 +416,6 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 		goto free_host;
 	hw->irqnum = ret;
 
-	if (hw->irqnum <= 0)
-		goto free_host;
-
 	ret = request_irq(hw->irqnum, spi_ppc4xx_int,
 			  0, "spi_ppc4xx_of", (void *)hw);
 	if (ret) {
-- 
2.43.0.rc1.1336.g36b5255a03ac


