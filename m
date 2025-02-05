Return-Path: <linux-spi+bounces-6632-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1D1A28B8F
	for <lists+linux-spi@lfdr.de>; Wed,  5 Feb 2025 14:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC4063A0759
	for <lists+linux-spi@lfdr.de>; Wed,  5 Feb 2025 13:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9445C7FBA2;
	Wed,  5 Feb 2025 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MaBH0N/7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA91FA32;
	Wed,  5 Feb 2025 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738761693; cv=none; b=VE4x07FElXQhyNIg5iySvDWjk/i3lHdATOoAdhM6LPxbNJbc9uHimNp3lNlL+aW7GphXLj2xFbyqb0qLC/Qw2QIlUzB37KcMIxdaACJ0vtrr1ZRGfbRtXPlLv3jOuM88dZKNvGHkB1+upeNsjXsWEDbbg7muACxKfMiVvMVQf8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738761693; c=relaxed/simple;
	bh=q3ZvTAGyFoSB9Csq2EHLzEZAkH+xinpw5FLRmfYT10Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sHCXixAHJC28yJ9vTtN8KzEzqfzm1e6U0mO81VgujrLESXN5Ln0HMaYMeMty39pTCoLVQC5NLVTURJr+TSVhR8/PSe5617hE/mnOpAz9Eei78mFv0gNhZkBw04yHOcvOPao5fFoEFFKQu5nRCMRHJNGS0xhmD5BoCvV6wge6C/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MaBH0N/7; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738761692; x=1770297692;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q3ZvTAGyFoSB9Csq2EHLzEZAkH+xinpw5FLRmfYT10Q=;
  b=MaBH0N/7sqXmL6O/wAYateoUsGLkczYSkUhTFYmq/oVCm4ZXBuOET7Vc
   nNVkhKXgZDWlOLc7BdZtVmUAWQ1s+bfZS+ibY5+pGB4hKOxPfFkG5P1HT
   C83Dc8aBU36tu2otShpSeS75mT9R9YnwPeeMNBM3zTy00ai8KcmUVyPJG
   dYxQNMS9Ob86g89t+rgXMMzcugXi94xfRwqmF0/2FIb+vvl0c9UvBFnLN
   JTMY65QmYsWWI7eKswTubJZbZQ/Tn4N0fUMih7cfl02MfN3a946+ZYHsp
   /J9O+RyFrFDAG5BKQeEXYQYsmOHkyjC+2KDYs87ow6sRwAclcME++Mr9C
   A==;
X-CSE-ConnectionGUID: fcYGSq4+TTO9DpLRutNpeQ==
X-CSE-MsgGUID: A5OoZdfzQtKR5fO60oU8BQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="38532063"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="38532063"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 05:21:31 -0800
X-CSE-ConnectionGUID: HGMvhVmdQ5y9u4OeQr8eyg==
X-CSE-MsgGUID: JeB8TT/nR6i7dw4Yv/JvZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111785208"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 05 Feb 2025 05:21:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4E93A10A; Wed, 05 Feb 2025 15:21:28 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 0/2] spi: gpio: Enable a single always-selected device
Date: Wed,  5 Feb 2025 15:19:18 +0200
Message-ID: <20250205132127.742750-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable a single always-selected device hardware setup for SPI GPIO driver,
so some custom SPI bitbang code may be replaced with the generic implementation
in the future (e.g. Up Board FPGA driver).

Andy Shevchenko (2):
  spi: gpio: Remove stale documentation part
  spi: gpio: Support a single always-selected device

 drivers/spi/spi-gpio.c | 45 +++++++-----------------------------------
 1 file changed, 7 insertions(+), 38 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


