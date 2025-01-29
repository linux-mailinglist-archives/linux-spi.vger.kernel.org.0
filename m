Return-Path: <linux-spi+bounces-6568-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3E4A22051
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jan 2025 16:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 620F71881E47
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jan 2025 15:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F1A1DD0C7;
	Wed, 29 Jan 2025 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dOe4iBIc"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4057315B102;
	Wed, 29 Jan 2025 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738164570; cv=none; b=YsRFPzmo2TesQbl1Y9xgOmd5/gcGOZvatyxACYCyj4S3RLYAOrrw/TPeu0VavlBLOQUVZg8euf94hDZiVtVuqarvZp6TIBbsf+qIbdl+5VwOlnTI/sHi5nkECcFSY0q2SB1AGTtibacHfBbgZVpqL8SkCTV+MMV0HHyztygOJXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738164570; c=relaxed/simple;
	bh=tahrGUmgDtGa4nBvClGplFM3TQ4RKaORu/R0GFfHaAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bKdTSrwI6qjfy2YOM6WZESqa9Sjru7r7ZhA+0RBEJdrI6t598+ht1qvSRf/TVGSytTfIH+7WHEjGP7NeZbgLbksmreeF+QmMuHIfY8+fs7uzeSmxUqFsfRkCgWQJ9ADgaYGwpLxxj9IjE2eX9YWEAocZTiT8x83XDkXkSTk6Pi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dOe4iBIc; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738164569; x=1769700569;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tahrGUmgDtGa4nBvClGplFM3TQ4RKaORu/R0GFfHaAQ=;
  b=dOe4iBIcO2LJL2PpdzcxxMx0eBZG16/1Nr6/Q4JRWKFUVYW7Xv8ILMhH
   0Vc4gjcY2+H/sjf0ebyiXezbQOjlS51NmA81gHyBo0bCxIHeiECpiTFQ4
   WbidoGM7hhfdu6OImZI97DRK8dIBV7bcjCWqQuieMArBqaAMBLJ9luwmS
   +ztVdTqDFSliBeUjHrYzcawqSvh59JJh248nZoqc55OUGvGuXuiax2SAX
   u6eZIc+/R6VEu01eABYmC6r7cSZi5cv2TAUNA1i6avnfZN4krz8U51Ted
   AlE+Pi2V41eEGVQsLU3cuwqthb7rJgEhgHa5ByVDszCGnosUNzQ+HWCCr
   Q==;
X-CSE-ConnectionGUID: MjoNWlWDShy3ini3IocuRw==
X-CSE-MsgGUID: UdkRJ/4HRiWhf8ZumuuLcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="37880260"
X-IronPort-AV: E=Sophos;i="6.13,243,1732608000"; 
   d="scan'208";a="37880260"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 07:29:29 -0800
X-CSE-ConnectionGUID: 1PVgaFsITW6CwErNdzbuqg==
X-CSE-MsgGUID: jojpA8rVRoejbA6HYe0sAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="146260483"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 29 Jan 2025 07:29:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E1FDBF1C; Wed, 29 Jan 2025 17:29:25 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] spi: realtek-rtl-snand: Drop unneeded assignment for cache_type
Date: Wed, 29 Jan 2025 17:29:25 +0200
Message-ID: <20250129152925.1804071-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

REGCACHE_NONE is the default type of the cache when not provided.
Drop unneeded explicit assignment to it.

Note, it's defined to 0, and if ever be redefined, it will break
literally a lot of the drivers, so it very unlikely to happen.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-realtek-rtl-snand.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-realtek-rtl-snand.c b/drivers/spi/spi-realtek-rtl-snand.c
index cd0484041147..741cf2af3e91 100644
--- a/drivers/spi/spi-realtek-rtl-snand.c
+++ b/drivers/spi/spi-realtek-rtl-snand.c
@@ -364,7 +364,6 @@ static int rtl_snand_probe(struct platform_device *pdev)
 		.reg_bits	= 32,
 		.val_bits	= 32,
 		.reg_stride	= 4,
-		.cache_type	= REGCACHE_NONE,
 	};
 	int irq, ret;
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


