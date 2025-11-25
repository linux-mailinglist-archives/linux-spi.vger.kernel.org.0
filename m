Return-Path: <linux-spi+bounces-11541-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC50DC86FCA
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 21:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0BBB034E981
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 20:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066D533DEFB;
	Tue, 25 Nov 2025 20:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OXcu6u6H"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DB833C501;
	Tue, 25 Nov 2025 20:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764101830; cv=none; b=hAJq5elLNMcomUtB1UtMbVxvhoK5eYtdbCN1t3hPROoOxH68IM07Fj11vwjcmSBaXyqBIbJW10mi3VqiyUqZAJZXiTrtjJRe26CMpcjvRSJpX/GoKEuns93UnpiYHO3uqiO4IYphbDBBr4ifeVOH1gztbY+930FWyLM6IIs5C74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764101830; c=relaxed/simple;
	bh=dVygpC8z48vE1wJBxn3Ie6b0CmMawZBV6k+F8SVts2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSnwSzOi9DpQ5gThEMWQ2ZG5ZBtEsgo5xUifKlF6IWxeY6+cPHF/Vv0PavTHF4WNaiRCK8j/Dc8iSr+Zq7eqTzUIpPZDkncaZVm7G49ikrHH8QcC3op2iJ1dMDgeUTnuzm7KmGiZjAU4wcFvmJajvI2AsjwU0fsq062VOG2is7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OXcu6u6H; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764101829; x=1795637829;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dVygpC8z48vE1wJBxn3Ie6b0CmMawZBV6k+F8SVts2M=;
  b=OXcu6u6HWHXDi2HRIva3nEbobR/DHHOzLdAuIo2NPh0Uq/hiOXzmUJn6
   Q1/RM20nG+V8qJDe3NYJ2v3mvNyeWvIEFvtu9WaRoV1m2MH7I4Y8nEq0k
   QJlvp8bWnXl3usx/iwUBpss3Y9l04gkRaySPLAY5nqo2bs6asMUUZW0Ns
   xT1af0l9gg2PRedPjpAi124SSoxLvzZg+S5JuNZun6Upw/4nFigvhAwEy
   bOEsrJvqStVjQ7xfSUzV+2lDG4/754jYR92yV1eYFc/dqfVs81e7FufjY
   e3qFFnyPSbPaPtMSiZsSgZ72vU5fEXKsLzUId0dCNsmBTZfHkouYHkLpk
   w==;
X-CSE-ConnectionGUID: bvjVzgF/QSexsnIe8OB67w==
X-CSE-MsgGUID: rKUO/oTGSo+hIYEPKin6nA==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="69990038"
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="69990038"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 12:17:07 -0800
X-CSE-ConnectionGUID: ftkyYuzzRmGy3iSy6b2AQQ==
X-CSE-MsgGUID: pBcYdko0T3ule96QtWrxPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="223720991"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 25 Nov 2025 12:17:05 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 5EA55A7; Tue, 25 Nov 2025 21:17:02 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 7/7] spi: microchip-core: Remove unneeded PM related macro
Date: Tue, 25 Nov 2025 21:15:37 +0100
Message-ID: <20251125201700.1901959-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251125201700.1901959-1-andriy.shevchenko@linux.intel.com>
References: <20251125201700.1901959-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Static declaration by default are 0 or NULL, no need to initialise
them explicitly. Remove unneeded PM related macro.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-microchip-core-spi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-microchip-core-spi.c
index 2d7ee556eafd..d09daa25984c 100644
--- a/drivers/spi/spi-microchip-core-spi.c
+++ b/drivers/spi/spi-microchip-core-spi.c
@@ -398,8 +398,6 @@ static void mchp_corespi_remove(struct platform_device *pdev)
 	mchp_corespi_disable(spi);
 }
 
-#define MICROCHIP_SPI_PM_OPS (NULL)
-
 /*
  * Platform driver data structure
  */
@@ -414,7 +412,6 @@ static struct platform_driver mchp_corespi_driver = {
 	.probe = mchp_corespi_probe,
 	.driver = {
 		.name = "microchip-corespi",
-		.pm = MICROCHIP_SPI_PM_OPS,
 		.of_match_table = mchp_corespi_dt_ids,
 	},
 	.remove = mchp_corespi_remove,
-- 
2.50.1


