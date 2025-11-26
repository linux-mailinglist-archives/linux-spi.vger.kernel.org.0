Return-Path: <linux-spi+bounces-11562-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2644C8885F
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 08:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 803943B4F4F
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 07:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AF23009E2;
	Wed, 26 Nov 2025 07:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bPIXGJXs"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DD92BD597;
	Wed, 26 Nov 2025 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764143766; cv=none; b=MtU8qZtcHQTTSUDLGxgwvncstlIn9eLhInzpycoj3L1GJHr+ytc9YkUQoioyFhjvejo/P6iGbzyfy5bEP4NlkQMCpVXK9ZeUkv8/qUn+q/tvMoHOtsm06Ho91dEu9sjiWdiQ7xHCGkGwaf1s5HzZJ05Q5w8whfmmJGn7aYXRWfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764143766; c=relaxed/simple;
	bh=WpIlFW+rHIItQ6Zy5VuzO39Uv5jKLGU+mvQaSFeRR+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IubKzm48DXs2xwDleYe1IVewG67a1RFoVc9ZmFrD/t9WjODhgzMnN4gFB8jlBd71Q3nPauE+GQrenon2UZBm7dN/BGXLYdTUyERQ6mS0IfOEBJeWRJ6vNip0ep00oXGTXZ1qtnmgm4kypo4yN4YPjDfnezvS3AIzNoZZ3uQwFwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bPIXGJXs; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764143765; x=1795679765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WpIlFW+rHIItQ6Zy5VuzO39Uv5jKLGU+mvQaSFeRR+U=;
  b=bPIXGJXs/gczLb+vvdkCXBXPxDK66HFe2tTO2fX6iu64py3XsEqLMybu
   jOoAlJjmfoSTD9hUGCOJxdKJyOLABH5O9MiEGixbnquXstwWSmjg/7h5h
   S14MQPUUZrYBg3kPOnWHjznDhgX//bK5KYmi/eC6tCxLV7OS97CDE1qZV
   T4KDnfIG46rlq6PKrOKfFkgZwxf/Omkr5LLlfAo0SLZbKuGGn//GdYFSb
   z3O4MFsA0sr1g1Y0qd06VzSzav/eIj58qAKmpBTtsgfG+q1M9Jl7haL9a
   VfzmeHhZ9wR79wSfoRyy+pcw1+04vrcQF8x/y3jxlTlTuUuySUahvvfAK
   Q==;
X-CSE-ConnectionGUID: L5FzSXJkQIOynEPRpqL7Cw==
X-CSE-MsgGUID: Fv8boAA7S/+tZPtaYDOY2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="77538908"
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="77538908"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 23:56:04 -0800
X-CSE-ConnectionGUID: bcqtT2DBT7C8r4EI8R4YLg==
X-CSE-MsgGUID: AZmjadbMS5GmtqvXeyN52g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="197026119"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 25 Nov 2025 23:56:04 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 308BDA6; Wed, 26 Nov 2025 08:56:00 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 6/6] spi: microchip-core: Remove unneeded PM related macro
Date: Wed, 26 Nov 2025 08:54:44 +0100
Message-ID: <20251126075558.2035012-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251126075558.2035012-1-andriy.shevchenko@linux.intel.com>
References: <20251126075558.2035012-1-andriy.shevchenko@linux.intel.com>
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
index 941b7e23eac3..1e62af20d6f2 100644
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
@@ -416,7 +414,6 @@ static struct platform_driver mchp_corespi_driver = {
 	.probe = mchp_corespi_probe,
 	.driver = {
 		.name = "microchip-corespi",
-		.pm = MICROCHIP_SPI_PM_OPS,
 		.of_match_table = of_match_ptr(mchp_corespi_dt_ids),
 	},
 	.remove = mchp_corespi_remove,
-- 
2.50.1


