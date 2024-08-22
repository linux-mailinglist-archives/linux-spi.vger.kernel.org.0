Return-Path: <linux-spi+bounces-4264-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C85195B3EE
	for <lists+linux-spi@lfdr.de>; Thu, 22 Aug 2024 13:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519FC1F22A07
	for <lists+linux-spi@lfdr.de>; Thu, 22 Aug 2024 11:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CE51836E2;
	Thu, 22 Aug 2024 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lKg6ccWf"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3EB180A76;
	Thu, 22 Aug 2024 11:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724326455; cv=none; b=RZJJV1d2d1JchI7bC6ipeGEmBjPKj2hp2SLZR/+zxXhEKQ9PjHmjdUeFhNVtE+M+U7CvJgk80/zrKrwYvLzQ11tHk8WX21aeUyUxYNgaMBuNJ4XrpUZLxudhAX7pKoNBKvvTnni8BpNkbdM4yHme8F1wJopo6IQpYGbaDSXKmfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724326455; c=relaxed/simple;
	bh=GoBg7BR26OgjMVYsWRrlxgAARdrI7QH82MB54Rz3waU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oNiagC/QYb8ovO6t+RdL1ybK4wifioYZcRnqINRMWX5VDuEM0E+AGvlGgOUjK1DEnojsd+iPcI+Ish/wcPfW3A6P+RqbbCHNPz3MCncLigg5JGX2H4+s0H5jAb8ydfXRN+bHGc2I0/yLOTEdEUn5PhKU1GdzErWTTDRWP7jnCJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lKg6ccWf; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724326453; x=1755862453;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GoBg7BR26OgjMVYsWRrlxgAARdrI7QH82MB54Rz3waU=;
  b=lKg6ccWf0LOb4WCE7SrRCq02HI0ON2ZBdtS31HGnJzjPylmFfbU4R2DI
   +QC+a+VI1oTOZedEqDpZN+C+iwgBtogI/OVof9jpbjPhpf1tn83ZQf/Rz
   c/Ay/q35qyVE0nT9fkjVu6srNddzh4Q9/Y50OsAR8lrDfENd22NqHwQ2Y
   dZPtTkySbypqWlegQELYExzs6jeII6XbJOCCEJvmoGkZGchIu19MZAjMv
   dLZYeL3/24VmsVMwud/Ye0B0nDmlLhH0fWNdtUkzN0lOCsfZoG2MZ2DmJ
   CletuEfEEFpQ4BPTXMRua1X/9ox7C5GYZ3O+6IirQ3DdLhL0ZMkkZJxn4
   g==;
X-CSE-ConnectionGUID: gU3rGRbnSfWLkln/8ad7Yg==
X-CSE-MsgGUID: 7ysGLB9HQk2EnWkCH0I5vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22888385"
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="22888385"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 04:34:13 -0700
X-CSE-ConnectionGUID: bW6KDPZwQWGCrLtSGUvSWw==
X-CSE-MsgGUID: Gx6r3BN8R5uz0DHmPf3RwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="61442427"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 22 Aug 2024 04:34:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 873762AA; Thu, 22 Aug 2024 14:34:09 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v1 0/2] spi: pxa2xx: Fix module reloading failure
Date: Thu, 22 Aug 2024 14:30:52 +0300
Message-ID: <20240822113408.750831-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After splitting platform and reworking PCI drivers the module
reloading became broken as reported by Hao. Here is the patch
to fix that along with another one that fixes PM runtime workflow
differences between the busses (PCI vs. platform).

This is material for v6.11 as the initial work landed there and we still
have time to fix it before the release.

Andy Shevchenko (2):
  spi: pxa2xx: Do not override dev->platform_data on probe
  spi: pxa2xx: Move PM runtime handling to the glue drivers

 drivers/spi/spi-pxa2xx-pci.c      | 15 ++++++++++++++-
 drivers/spi/spi-pxa2xx-platform.c | 26 +++++++++++++++++++++-----
 drivers/spi/spi-pxa2xx.c          | 20 +++-----------------
 drivers/spi/spi-pxa2xx.h          |  3 ++-
 4 files changed, 40 insertions(+), 24 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


