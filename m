Return-Path: <linux-spi+bounces-11656-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EDDC92FA4
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 19:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C057734ECFB
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 18:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CB82D4814;
	Fri, 28 Nov 2025 18:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W7iOr+r5"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7712C21E8;
	Fri, 28 Nov 2025 18:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764356124; cv=none; b=RjdHH0OX2R0orsdecRO0BGbRmo0wghq2+kUXZpZp5QYfTAqu1rUmNrXpac+CqAhuHdDYSQjf/rOVKEPq5IxN6eTIXVqeTvcJpUw2aBivfYoB96SV7yC41Qjx4xq3l82pjsWc0/l15ewSiWodzXWLCKApUr3FRXAG/G5RWhx2wcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764356124; c=relaxed/simple;
	bh=7pjj0HOo51rH302CE+zNUdYttcd94eWKqHleihVdlr0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jOfvfblalUFViH5IxH5TA3+xkUM8LW1SilKa/nMPahWIOlrOGCNVwU3F15N2H9a0CxsgyW0IidCdojiPBYiFDlchbkb/QCxeuZvcuM/H4eF1xpCZWwE5j8soIpvXVMYxLaW2UNA+soWr3uB3Yd5Vqfo5h/qrSte6hK4aJ8qGMDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W7iOr+r5; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764356123; x=1795892123;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7pjj0HOo51rH302CE+zNUdYttcd94eWKqHleihVdlr0=;
  b=W7iOr+r5zNon5/ZwHQ/tgT+wN0/0ocxO0kRBn1vTewA07y1HmtAm5NOf
   tVpke0l46NNGGhgnb5oGBQ+enSWp2bYkfqGESMscPQoJ1NHq9AEwVIV61
   AKD9yGtilPxhN/32BDk2LtNtBysirAJSydU5E0ilu4y3N15voTuBeiVdd
   s1ubDtY21jx5XyVJlc+TTe4dp4ll7yBPdXz9nHROXxmIqGBZcNOsUGDlp
   hSImSmUgwBTrmHI7x52i1G6C/zgt1kRr+7fsRakRp6BDpU0yytIBdUmj/
   1NHcud4nGBnsdy3bN950o7gUs2UnBH7depMwHh9dzSb1xknn6sbZrfVQf
   g==;
X-CSE-ConnectionGUID: RDR5WjNWRq+FTB8Q7OwypA==
X-CSE-MsgGUID: PP1Y0E/MTZimx2yHOxHYew==
X-IronPort-AV: E=McAfee;i="6800,10657,11627"; a="77856767"
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="77856767"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 10:55:22 -0800
X-CSE-ConnectionGUID: m0uvi7MiQY2PpxNqLXULPg==
X-CSE-MsgGUID: 9ke+ghsHQCSV+tyeRgMR9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="230801964"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 28 Nov 2025 10:55:20 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 87B1F9F; Fri, 28 Nov 2025 19:55:19 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] spi: microchip-core: Code improvements (part 2)
Date: Fri, 28 Nov 2025 19:52:38 +0100
Message-ID: <20251128185518.3989250-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is the second part of the set of refactoring and cleaning it up.

Changelog v4:
- collected tags (Prajna)
- dropped applied patches
- added a new patch 2

v3: <20251127190031.2998705-1-andriy.shevchenko@linux.intel.com>

Changelog v3:
- collected tags (Prajna)
- restored dummy read in TX-only transfers

v2: <20251126075558.2035012-1-andriy.shevchenko@linux.intel.com>

Changelog v2:
- dropped device property agnostic API conversion change (Mark)

Andy Shevchenko (2):
  spi: microchip-core: Refactor FIFO read and write handlers
  spi: microchip-core: use XOR instead of ANDNOT to simplify the logic

 drivers/spi/spi-microchip-core-spi.c | 33 +++++++++++-----------------
 1 file changed, 13 insertions(+), 20 deletions(-)

-- 
2.50.1


