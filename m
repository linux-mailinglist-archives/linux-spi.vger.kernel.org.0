Return-Path: <linux-spi+bounces-7606-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B14A8B026
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 08:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F40D3B89B9
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 06:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F76022B8AD;
	Wed, 16 Apr 2025 06:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F7ve+6hs"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8D8221550;
	Wed, 16 Apr 2025 06:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744784421; cv=none; b=Adz2PPLHi+F3cu0MkkXXmZGtMzOLJ5jwAKVgyJXwqsaA9y9gBWVfBmmmksVJ80Ebvea2EUzvWD2m0VKK5sqhcXOWZ7S1IS/p5SXl12wBDDX3INKqaSEHZYBRskfV1NEMj5Oq5U2uZUnHJmYlPDW6rUjXNU5FsT+YGmcH428rmpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744784421; c=relaxed/simple;
	bh=YNzxg2Cgltshvv/jkfeOT+fz/8OO2VlMUUBbnoXm6YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjSMXM5nY35pe2n4RWAFiIUGnHTPBVI7zDbDJ2KyURdfadIaKoLzOGnDNozcaGKorKyeLr1qoUqA+7vXpivTsdYruXovLvtOyewJD9w8/2jT4MfEAoG8VnyZP9fN6WvlusOMvCLgmwYjB3bdXw8PekZZv8jE873L25HkpC4Oqis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F7ve+6hs; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744784419; x=1776320419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YNzxg2Cgltshvv/jkfeOT+fz/8OO2VlMUUBbnoXm6YE=;
  b=F7ve+6hs30KBpwK5p1Ew1CmmiH7n4967dLEFj2RG0elZg2Aug9HKivsy
   D4oQeXUgg/bQq9CaEhWpVhftxqUwgt2SOGp/ZC9Xmt4rl4Ugq91re3Liu
   pqhGtWoQhYjzn2Gs8ase+m7+LeNqwDF6aN4GEwdZF4iwXg6EOT3ZWe0ZM
   K5pcszg0m+HQbQjZfSaxeX0bKpBf1JUNy5tZFkwVc2GbrH5kf7id+Tu+C
   yrczLrS64XdSA2bUSugmTgZQVBjJ28k73wkWZpgVAn5ArnA2kprntdONP
   +/o5pgp/uwTJTNq/BhlX9JDopeNwhTxyABViGQR4xh0ef4V6xVTUw19Mu
   g==;
X-CSE-ConnectionGUID: LB7KzGOhTC2RMnFD+WaE4g==
X-CSE-MsgGUID: cLCVIE9WQhqnzo09OUfbeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46405991"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="46405991"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 23:20:17 -0700
X-CSE-ConnectionGUID: sVIb5phKRlmO3eZa18OBKg==
X-CSE-MsgGUID: MdCkcPh5S8OnZPLFAHmngg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="134442374"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 15 Apr 2025 23:20:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A0FC1481; Wed, 16 Apr 2025 09:20:14 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v1 2/2] spi: dw: Use spi_bpw_to_bytes() helper
Date: Wed, 16 Apr 2025 09:16:35 +0300
Message-ID: <20250416062013.1826421-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250416062013.1826421-1-andriy.shevchenko@linux.intel.com>
References: <20250416062013.1826421-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use existing helper to get amount of bytes (as power-of-two value)
from bits per word.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-dw-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 941ecc6f59f8..b3b883cb9541 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -423,7 +423,7 @@ static int dw_spi_transfer_one(struct spi_controller *host,
 	int ret;
 
 	dws->dma_mapped = 0;
-	dws->n_bytes = roundup_pow_of_two(BITS_TO_BYTES(transfer->bits_per_word));
+	dws->n_bytes = spi_bpw_to_bytes(transfer->bits_per_word);
 	dws->tx = (void *)transfer->tx_buf;
 	dws->tx_len = transfer->len / dws->n_bytes;
 	dws->rx = transfer->rx_buf;
-- 
2.47.2


