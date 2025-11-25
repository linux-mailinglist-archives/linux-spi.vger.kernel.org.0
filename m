Return-Path: <linux-spi+bounces-11536-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5287BC86FC4
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 21:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E6D3B48B3
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 20:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AEF33C18C;
	Tue, 25 Nov 2025 20:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hcL7USQz"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D695E33B958;
	Tue, 25 Nov 2025 20:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764101828; cv=none; b=Tnun8Oqw/4qirXLk17mFUjqGN6Pftiu0ifkrOI4P7LVE+Zri01gu5EI9pBm4GqJGmZGBYccz21NXjNJIZsRbbzrf8eXaG9U29a7MYA4Gky64Gd89X8Tayxc/F4GOQs4nXwRb7HHR5eVS1P+ZbeDOgICGbznX1VFcUp1kVGP3hWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764101828; c=relaxed/simple;
	bh=g7W+a0KDvDNZx8EWxNLukegMDKmdtcKPYfpsSu925Os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FdflcZg6ueQ6aaI5p4HIX/KrDoKY2l0O/Cm3oNkZ2IeCI5xdINlk5MLNh+z82jggNH9GjVfiSEAIgMUcnf96aOKAFT+XTGy7yopNKKaY5spJszlFcda/Bl/ye86c75c/fDOHbE51G506iN9PXrJp2HyZ304oP4xYV873f/Xp43s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hcL7USQz; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764101827; x=1795637827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g7W+a0KDvDNZx8EWxNLukegMDKmdtcKPYfpsSu925Os=;
  b=hcL7USQznq6U2ldIS2mqHcvvW1blToKWnjRpZpa+IzLbmQYcZjlC21An
   ArtnZ8C6NEFU3wkZCPHedw2lb5NTLSnA48ak/77QAZzgNQRzY7VwRYr9L
   NCjt6WKCmZxGHZsvNHzh+/6uGttQpV95ECAGlUDVHLYbRpmLpStyYJ1s4
   63EMAUnLS8mKBME487FNgiKhzaTvzcvWwoU/lWM9jAn2LWH5diVNhvnih
   BunT1OVfgGhM1Ucf7xynEwTzMO2LONwi1k369uHEmMIUXFIuW3/PW8+jV
   pc0Qq3qBgINAFIBN2K7IEflUd9oa/3ELcTwSjMyd9CV3Owi+ED4+xDRq5
   g==;
X-CSE-ConnectionGUID: ePeINc8TSKSbrgZE4xNXKg==
X-CSE-MsgGUID: 16907jWjS2i+NVRwmnUi4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="69990026"
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="69990026"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 12:17:05 -0800
X-CSE-ConnectionGUID: 3wUjezJsTHSVB77fsgUjLA==
X-CSE-MsgGUID: ZrBFGRlCQT+Og3T8FVdqyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="223720982"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 25 Nov 2025 12:17:03 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 533B0A4; Tue, 25 Nov 2025 21:17:02 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 4/7] spi: microchip-core: Replace dead code (-ENOMEM error message)
Date: Tue, 25 Nov 2025 21:15:34 +0100
Message-ID: <20251125201700.1901959-5-andriy.shevchenko@linux.intel.com>
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

First of all, the convention in the kernel that we do not issue
error messages for -ENOMEM. Second, it's ignored by dev_err_probe().
Replace dead code by a simple return statement.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-microchip-core-spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-microchip-core-spi.c
index 9620aa886912..dbbfb395c272 100644
--- a/drivers/spi/spi-microchip-core-spi.c
+++ b/drivers/spi/spi-microchip-core-spi.c
@@ -295,8 +295,7 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 
 	host = devm_spi_alloc_host(&pdev->dev, sizeof(*spi));
 	if (!host)
-		return dev_err_probe(&pdev->dev, -ENOMEM,
-				     "unable to allocate host for SPI controller\n");
+		return -ENOMEM;
 
 	platform_set_drvdata(pdev, host);
 
-- 
2.50.1


