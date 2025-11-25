Return-Path: <linux-spi+bounces-11535-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5343C86FAC
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 21:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2772E3AFDE5
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 20:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C398C33BBA1;
	Tue, 25 Nov 2025 20:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XWc9QPjy"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FE033AD9F;
	Tue, 25 Nov 2025 20:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764101827; cv=none; b=NckLV0YsqAzcyKp+6QXigqkXmujcSSFGN/mcNjS3L1jEARZlcO6NysGkxzI9ACqQrtRGZXl54SxC8W5dEsR5rrOC6QoCG5Z0nj26n43Ur1vktIPUT7E6QLV0XC1/lyIGkGdeHpWHZ7ego40Cg7tFb06b27bw/y6Rz8bhjIxmJo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764101827; c=relaxed/simple;
	bh=vFaF1g5B8Q7aSUcTFGv8j9c9zXCldsjAYWwcBxi1wDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hny1yoi88tH4j81JcRkN9U8oMFZskQZtUK4QPo2Ke9k5emaYyBZmBFYcf7xNrQagFVniehmI6ka0jmpUQL/Sw/VPwEdPX+QwqD5nEpFKbstNHlF213Sq7WMaDo+uL8ZhhEjXL6RdH+OwYeg23klgk1eqQWgCXzUaAqiokcdGVXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XWc9QPjy; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764101826; x=1795637826;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vFaF1g5B8Q7aSUcTFGv8j9c9zXCldsjAYWwcBxi1wDw=;
  b=XWc9QPjyDBYv9vz8qUvroIXQJE6cvVFEp7wQFLP8n45u9K5KGulqnyov
   CKYgMKGGPtR3Z25f4YcLmCQZvxVteWb3bpwP4Fjutq8Cacvh2dQeHUe+F
   o1VHt/+Wd/ocYKNPW5AFsG+ol8NAAdIsxabwi0d6cccK6WYBM7l/LcrR+
   mdxIy4BUjgBaJLMkxTmf75K6JCLtzgrOSzoXDncAwELuE6oyWpUWX2LXv
   UL1uWwYs34ipvfw576xag5OH4cR0XyCNBdyiPDlIHartqTIlZ6FcnzSqk
   nH5IF4LiJoE7SEk8n3K/yEvP2OH00Uo+2ClXceD7ygQKyfNFQpjKehVwJ
   w==;
X-CSE-ConnectionGUID: HLK1yy4cQbqGZs9kJypsBw==
X-CSE-MsgGUID: jrzmB/DMRiOjkCZlnqDj4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="53699524"
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="53699524"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 12:17:05 -0800
X-CSE-ConnectionGUID: Le4minPJSduAG+vD8u9dRA==
X-CSE-MsgGUID: mMNGVEAGQ6OC3N4ZaiNspg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="192836170"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 25 Nov 2025 12:17:03 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 43981A0; Tue, 25 Nov 2025 21:17:02 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 0/7] spi: microchip-core: Code improvements
Date: Tue, 25 Nov 2025 21:15:30 +0100
Message-ID: <20251125201700.1901959-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While reading some other stuff, I noticed that this driver may
be improved. Here is the set of refactoring and cleaning it up.

Andy Shevchenko (7):
  spi: microchip-core: use min() instead of min_t()
  spi: microchip-core: Make use of device properties
  spi: microchip-core: Refactor FIFO read and write handlers
  spi: microchip-core: Replace dead code (-ENOMEM error message)
  spi: microchip-core: Utilise temporary variable for struct device
  spi: microchip-core: Use SPI_MODE_X_MASK
  spi: microchip-core: Remove unneeded PM related macro

 drivers/spi/spi-microchip-core-spi.c | 113 +++++++++++----------------
 1 file changed, 46 insertions(+), 67 deletions(-)

-- 
2.50.1


