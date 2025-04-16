Return-Path: <linux-spi+bounces-7605-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD6EA8B024
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 08:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 115157ABD3C
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 06:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A721E2206BF;
	Wed, 16 Apr 2025 06:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l+0zX8sb"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D702320FA86;
	Wed, 16 Apr 2025 06:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744784419; cv=none; b=tOw0lhG8k3cDgmKT1uL1jwVmWLgEz7oUuQnaRhJLgphnqi5ZJTQ3+GbEAh/HB9/sMyIE7sgtd4AYY8bQ/jYAz5ggHILmBKHBvvxfztnwAPDRw6qOfLuSddOg5/mGyZBLGD0kRaY6VUTZctzgCInEQ59AkNJcmyg76hWYfjwku7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744784419; c=relaxed/simple;
	bh=4kmwb9dXL3O2oS9J19dBHttxKGBeEUUdyD1x4oHpKaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGxg23GYbUipteqlc13q6B6BpiotN3oLAY4ljVSfGobWAzvWulYekt8TTanx6oWwYA7tilzbc8zVLkY7CNGnkVOVlMzHBauQkgtuxtn2i3Y1NFPD683jOCCrTOVq0y8LIGnE45J9EqSVvtBlZQ4PvtYuUnlyr3SSHVs6nWUwBTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l+0zX8sb; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744784418; x=1776320418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4kmwb9dXL3O2oS9J19dBHttxKGBeEUUdyD1x4oHpKaY=;
  b=l+0zX8sbbwDV1AAa2O2kpJFZIMhWvP/FoXB4b0Bsdl5CxvID03TKzpto
   e1NCB62ohd/jVmauYBbUkYTXiCzmGVG0uGJJlj2YXtRfojR8DK54zm9j4
   PgQuwl74uA0cwZrZOBTPToaECETep7BG54RtQZNnrTaGuGRNPKY+pZRjt
   z0K+gAsiEYWNgevc0zIgyKSEHt+SSHkMnwR264CS3lrMTEc0BHXUJEPCD
   9W/sSgIMrKbcCt9uvCIcy/fmGbHDuywdM/+ka/+sBqj/wXb07ZCjUd6V8
   wg6D2jAF/1rP2bM4v5nAJ7W+b8pnv6H/dPp689NOrs/GTwI04m2kLpMRB
   w==;
X-CSE-ConnectionGUID: YqizNpI7Tm2xRzdiw/t0YQ==
X-CSE-MsgGUID: AeI6E/yDTgeR/jgUBuAFZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46405988"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="46405988"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 23:20:17 -0700
X-CSE-ConnectionGUID: T0bIX/iSR6mA+EEbB/42hg==
X-CSE-MsgGUID: 4E3GD2QNR4iHwrXTzaaIqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="134442373"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 15 Apr 2025 23:20:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8DF11F4; Wed, 16 Apr 2025 09:20:14 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v1 1/2] spi: Add spi_bpw_to_bytes() helper and use it
Date: Wed, 16 Apr 2025 09:16:34 +0300
Message-ID: <20250416062013.1826421-2-andriy.shevchenko@linux.intel.com>
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

This helper converts the given bits per word to bytes. The result
will always be power-of-two (e.g. for 37 bits it returns 8 bytes)
or 0 for 0 input.

There are a couple of cases in SPI that are using the same approach
and at least one more (in IIO) would benefit of it. Add a helper
for everyone.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c       |  2 +-
 include/linux/spi/spi.h | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b0e7702951fe..1bc0fdbb1bd7 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3800,7 +3800,7 @@ int spi_split_transfers_maxwords(struct spi_controller *ctlr,
 		size_t maxsize;
 		int ret;
 
-		maxsize = maxwords * roundup_pow_of_two(BITS_TO_BYTES(xfer->bits_per_word));
+		maxsize = maxwords * spi_bpw_to_bytes(xfer->bits_per_word);
 		if (xfer->len > maxsize) {
 			ret = __spi_split_transfer_maxsize(ctlr, msg, &xfer,
 							   maxsize);
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 834a09bd8ccc..abfc7f5e19e4 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1340,6 +1340,21 @@ static inline bool spi_is_bpw_supported(struct spi_device *spi, u32 bpw)
 	return false;
 }
 
+/**
+ * spi_bpw_to_bytes - Covert bits per word to bytes
+ * @bpw: Bits per word
+ *
+ * This function converts the given @bpw to bytes. The result is always
+ * power-of-two (e.g. for 37 bits it returns 8 bytes) or 0 for 0 input.
+ *
+ * Returns:
+ * Bytes for the given @bpw.
+ */
+static inline u32 spi_bpw_to_bytes(u32 bpw)
+{
+	return roundup_pow_of_two(BITS_TO_BYTES(bpw));
+}
+
 /**
  * spi_controller_xfer_timeout - Compute a suitable timeout value
  * @ctlr: SPI device
-- 
2.47.2


