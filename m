Return-Path: <linux-spi+bounces-11637-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB47C8FF6B
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 20:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 374613ABFB2
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 19:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5C9303C8F;
	Thu, 27 Nov 2025 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G9NhiC2w"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D69A302175;
	Thu, 27 Nov 2025 19:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764270039; cv=none; b=gJwJtNXgkEnBtO6TKzX0I33Kb61gc9ZQ2sRy4z9HTkuJGbyeHu+a2uVIv789sl40GCFRN5Sq4s/d0QPGe3gEYcD37DuzNeKTT8d5fQBobUCH4/7ioByY7ixIPNdgoS0MMSAsWmvsKVIlbYMDb/Qe7jG/1ez0Cm4ejw+Zr6qLt0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764270039; c=relaxed/simple;
	bh=4lakAawu+tT5I/1TAhrOXAulcIoD9+FM7nbBSisAF7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n/wU5l8Y/BgjQ2tY0BDky8FqoDGLJjbceNOwShfxAsDUziAe0RKGxa8JWPi/e5rOP4df+KsqwyMeNLvWfK3urwBg1reqVe9X0RPxToqwngoFDQvzWABUfY8bosa6ZaUS14WagP47Q4ylDnC2W08uwWqLsFnhwCxekR4+wInFjXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G9NhiC2w; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764270037; x=1795806037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4lakAawu+tT5I/1TAhrOXAulcIoD9+FM7nbBSisAF7s=;
  b=G9NhiC2w69jwsD9lsRL7EfidM9FEm++hAJPZDMjUFFcN8qehlDS2iKZP
   jblCOaz3GsvQh5Zfd1Cw08y9iKfI6hsK2LI99nsb2VtpjOjuj5NXfOQrs
   85fuow/FKSneFuPBs31xJ3bCvCZYZ7FSvS2OVZOG1cfOB956vkMyf2dCO
   iV/PA/tBLg56tEsAENXkGRmsShqPtNFiGpQRRv7cp1iaHOF+nGL+hAbjz
   s46GmYRCv7a8jHpaVeqCldOs5CGsm9mY60UnRE/+QDD9QukSrUgrjKWuL
   f8WStO+vJD77kaxuTwAmCS8Qz+Ri7urYfstDuyqahDbHzrXzAxoip1/W4
   w==;
X-CSE-ConnectionGUID: JazK1PUASrqaT3/nsbzLZw==
X-CSE-MsgGUID: fMJwBSR2TzCiISY9S/dUpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66480314"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="66480314"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 11:00:36 -0800
X-CSE-ConnectionGUID: Sd+N2V3LQESNTOJcpFdMQg==
X-CSE-MsgGUID: 7LHwIba6SpSoQMrMTqeV0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="193312329"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 27 Nov 2025 11:00:35 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 4E104A5; Thu, 27 Nov 2025 20:00:32 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 6/6] spi: microchip-core: Remove unneeded PM related macro
Date: Thu, 27 Nov 2025 19:59:03 +0100
Message-ID: <20251127190031.2998705-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251127190031.2998705-1-andriy.shevchenko@linux.intel.com>
References: <20251127190031.2998705-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Static declaration by default are 0 or NULL, no need to initialise
them explicitly. Remove unneeded PM related macro.

Reviewed-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-microchip-core-spi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-microchip-core-spi.c
index d37e193e282f..2f4b21ad56a7 100644
--- a/drivers/spi/spi-microchip-core-spi.c
+++ b/drivers/spi/spi-microchip-core-spi.c
@@ -403,8 +403,6 @@ static void mchp_corespi_remove(struct platform_device *pdev)
 	mchp_corespi_disable(spi);
 }
 
-#define MICROCHIP_SPI_PM_OPS (NULL)
-
 /*
  * Platform driver data structure
  */
@@ -421,7 +419,6 @@ static struct platform_driver mchp_corespi_driver = {
 	.probe = mchp_corespi_probe,
 	.driver = {
 		.name = "microchip-corespi",
-		.pm = MICROCHIP_SPI_PM_OPS,
 		.of_match_table = of_match_ptr(mchp_corespi_dt_ids),
 	},
 	.remove = mchp_corespi_remove,
-- 
2.50.1


