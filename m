Return-Path: <linux-spi+bounces-11563-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B38C8886E
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 08:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0234E3B498B
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 07:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F51313544;
	Wed, 26 Nov 2025 07:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bNIp+XlC"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2170629E11B;
	Wed, 26 Nov 2025 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764143767; cv=none; b=Elm4DeyfRDKj8O4hiX6IdVzRIOrDcgjHBhO3ukEe0Lu6PaYWRe09c9WDubtJEhPbGhx4i70DCRQzc87Zh0HlLHWzicXk+vfGj0IeypTITrCZ1Oy/fYBteCawddPQqaHxXA5RqQNcvgidsmDNWWIzBg5NihBdkFq2M5isd9krDH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764143767; c=relaxed/simple;
	bh=gOaG+4SDVGY+HmhaDRgRq09NjgZ1ZjQOWh13MqgATwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B12IxAOB7A2900YpDJi6t4+sGbrLQb3jYsq7UhNC50Q46b7RRc7VyYbe9nne+jR3OHn2PYQiIg4KRQbyqwcog0kCTzGMgsos3BtgKSW9M5xsVergQRJhEUs8bsc65Ch2wL1J/4/yPiUAdcM0cFIGpZjID5R1YsKkRMIl3SrRIgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bNIp+XlC; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764143765; x=1795679765;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gOaG+4SDVGY+HmhaDRgRq09NjgZ1ZjQOWh13MqgATwQ=;
  b=bNIp+XlCE3h7J5pIA9gHRlX85QSP6yK41p1Ypsq/B7qkLYdrEoO02+0w
   yCVG6Jfe3Qc/hzR3qpalrsgk0RrV3J54jJgqXdhcP0FKk/EtXFgltYW8c
   4ZlHKkJO566QAc9/vqdjm+4WM1WAyp1jV/VEYTV9GMeV1n0t+/wTNW0kj
   xRzmkMsuka8GxABcdS+Z1Ly1TIiqi1JtAIRYkK3RWRfIpzaNGnuqeTKQc
   yHVE1hqW9o0YN6KcWsCwa7CBi2kvEbgvPF/MNbySgu86Cb752cKaXBmq6
   99hIaWIvN5WiA1H6rvxxyuT0XobQrybTpHSkv21AstQx2jVRTFjKzoGai
   w==;
X-CSE-ConnectionGUID: Al7PKX00RW6wE/nYOSSJzg==
X-CSE-MsgGUID: zEBxxQ6lR1G/U5JGDSgv9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="65360563"
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="65360563"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 23:56:02 -0800
X-CSE-ConnectionGUID: kGCmWZndQ8WWVBtXy3DXiw==
X-CSE-MsgGUID: gRg/+f9lT6yEdqVt624D/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="192006617"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 25 Nov 2025 23:56:02 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 18DDFA0; Wed, 26 Nov 2025 08:56:00 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/6] spi: microchip-core: Code improvements
Date: Wed, 26 Nov 2025 08:54:38 +0100
Message-ID: <20251126075558.2035012-1-andriy.shevchenko@linux.intel.com>
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

Changelog v2:
- dropped device property agnostic API conversion change (Mark)

Andy Shevchenko (6):
  spi: microchip-core: use min() instead of min_t()
  spi: microchip-core: Refactor FIFO read and write handlers
  spi: microchip-core: Replace dead code (-ENOMEM error message)
  spi: microchip-core: Utilise temporary variable for struct device
  spi: microchip-core: Use SPI_MODE_X_MASK
  spi: microchip-core: Remove unneeded PM related macro

 drivers/spi/spi-microchip-core-spi.c | 96 +++++++++++-----------------
 1 file changed, 38 insertions(+), 58 deletions(-)

-- 
2.50.1


