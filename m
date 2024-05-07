Return-Path: <linux-spi+bounces-2759-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0277D8BE42F
	for <lists+linux-spi@lfdr.de>; Tue,  7 May 2024 15:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B153F2860FF
	for <lists+linux-spi@lfdr.de>; Tue,  7 May 2024 13:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68C21C9EC3;
	Tue,  7 May 2024 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YwNkzfoV"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF81E15F3F6;
	Tue,  7 May 2024 13:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715088011; cv=none; b=jxN3netLzXN4Ct+abGw1bX8elQvg/B+Rk0j8fMZwK5r9tjJXEK4D3mWhIN0AT1+fxBjGXTbChrwaf4JjQsgqDQQiZ9IuyK9toDBU4JvVCxR0tH9uZNxhMjpglqJEGKedcv8/u4zp1E+objfb8JP8+TpnPP43gLXqgD3UUHqH9mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715088011; c=relaxed/simple;
	bh=ctEUTWkOz0M61/Oed2P4vk68TSJ0CbLXA3dtwZlhqsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bA5bY3r48BS0wKVAPx/fmCxtV36wE028UK2G0brjZ2Xd6j6tH7VSJ5rIypybcJtdshspGW3UpxqfR3e/eMAzwZ/qg9qvNg0kbKhdsrF1VTIiRQMPIYXnN6jPlE6LsIaaZiWz+Cz5nHGRGXu3DpFmeJXa/Z2QQNyfywflfVF2pJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YwNkzfoV; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715088010; x=1746624010;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ctEUTWkOz0M61/Oed2P4vk68TSJ0CbLXA3dtwZlhqsM=;
  b=YwNkzfoVr9VVFwz+YRLhxl1emRiDzrijYQFRen0nr+l7a5oehjyodY2d
   ldEGumuoHpz6QH1AEcr6x63LWf7j1PrRiPDMAkjW/whQPTnE6XMfuGIx1
   +eroYiBSM9vwl8v/VpaWOhVNr9m5ZX3GNp1gKFsPXWC8aEIyNgzMS0TJH
   jt+qrdMUU6PMZFMqZY6vY4dOZgMpmRJcsblWbg8QljSu263awsnwLzCFq
   4fuUxEKkUFD+ntZ3nRv8g8SJ1mSWnI9C01FXIGgkDgfFlpayXsqFtIGiA
   sTmcmy8UGlj3dNOrEN4iyQ1KmOnc3Im+Q5Ks1CBCk/RC/yCJ+UgyJPJI9
   Q==;
X-CSE-ConnectionGUID: e9oyy2C0Q+q9rbn2/6xGyg==
X-CSE-MsgGUID: ml7AxcetS9ek4k6+5SFjPQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10731907"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="10731907"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 06:20:09 -0700
X-CSE-ConnectionGUID: vMnVIVLMTvyiHsGoD8eD/w==
X-CSE-MsgGUID: dCrFu1KbTR6fIYsba6ab2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="28580029"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 07 May 2024 06:20:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C98F5178; Tue, 07 May 2024 16:20:06 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v1 1/1] spi: pxa2xx: Drop the stale entry in documentation TOC
Date: Tue,  7 May 2024 16:20:02 +0300
Message-ID: <20240507132002.71938-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation had been removed, so should TOC entry.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 2d069c11e822 ("spi: pxa2xx: Remove outdated documentation")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/spi/index.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/spi/index.rst b/Documentation/spi/index.rst
index 06c34ea11bcf..824ce42ed4f0 100644
--- a/Documentation/spi/index.rst
+++ b/Documentation/spi/index.rst
@@ -10,7 +10,6 @@ Serial Peripheral Interface (SPI)
    spi-summary
    spidev
    butterfly
-   pxa2xx
    spi-lm70llp
    spi-sc18is602
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


