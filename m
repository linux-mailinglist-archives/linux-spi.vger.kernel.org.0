Return-Path: <linux-spi+bounces-7636-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FA5A92149
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 17:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDDEA3BBE31
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 15:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E98253B5C;
	Thu, 17 Apr 2025 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iApdYGZw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70952253B51;
	Thu, 17 Apr 2025 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744903205; cv=none; b=WSrijekdiKQSYXd0Pxg98BNNpkM7tZuhtObDQRkGGQDFk6ZzGATKEjgBdHRY7RPA7/k6k5jrTxkxGoI2MwPjGBHS2hNILTK6u0YShB3fWa5qzYl96DRQo912cr1BeKnaK34QlYMi8+BaEc6BidJzfjp2LYfpzAff7UpViszz5iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744903205; c=relaxed/simple;
	bh=qUmrkOLPAn9WJV8vuI19EeNWTPsJxEhjfN+fvOQk1Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0HC0yXLeoMDle3OttDfnow/C1S91LxKQEWZ8MlW4ID68e0eda6lwnlVwY+UMroDxVoWhtS5xM6BjOEiaJIKG5kczS7VDODnGQ6e2Bw90gkcEx2ZcdkguHCnH0jAzUmgOENd92Dp4Tnv9lusTOIcbic1dtXXY6Mak+rAM8eqvtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iApdYGZw; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744903203; x=1776439203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qUmrkOLPAn9WJV8vuI19EeNWTPsJxEhjfN+fvOQk1Kk=;
  b=iApdYGZww6b7nRbuBYqQfJpeG7wO3ygzCgqVnEEZcyTQ7z2pWTATmrF5
   mcHR++9U0u00CoEnI663rhqDstxS3VsqEepQhDnJF0BA9ubRzZXYK1PLj
   6ehXeWXXxIseRkq9fmhqPtQseqIegWou8uD3O4VvQtGzhg/bgojC5CZFv
   l2svncaJJuDOt1fgwIiwpvx7Xp99iaTfCaIecX7mseSW7gwAjhdxUsRZB
   Wt/u+2Lc2qPEEdEbB/B5PY8BpbAzH1Aa9VZiZ76vdH86SuHDOUsxamnth
   Wi5jzeyM7OfC48J2oqFad3o2HzQHaODzdc3kH4tG+cf7mMJuG5hTnu8g7
   A==;
X-CSE-ConnectionGUID: wIm0ICInRiauF2dRmKpYYg==
X-CSE-MsgGUID: gpqwER0nRAK5TshihYgTIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="57868614"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="57868614"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 08:20:03 -0700
X-CSE-ConnectionGUID: oLRIeTVSRwu696QfLj2t0g==
X-CSE-MsgGUID: pNzxmXjTS1Ga3/LN10qqTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="136006750"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 17 Apr 2025 08:20:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id F251E170; Thu, 17 Apr 2025 18:19:59 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 1/2] spi: Add spi_bpw_to_bytes() helper and use it
Date: Thu, 17 Apr 2025 18:17:52 +0300
Message-ID: <20250417151958.490174-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250417151958.490174-1-andriy.shevchenko@linux.intel.com>
References: <20250417151958.490174-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This helper converts the given bits per word to bytes. The result
will always be power-of-two, e.g.,

    ===============    =================
    Input (in bits)    Output (in bytes)
    ===============    =================
            0                   0
            5                   1
            9                   2
            2                   4
            3                   8
    ===============    =================

There are a couple of cases in SPI that are using the same approach
and at least one more (in IIO) would benefit of it. Add a helper
for everyone.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c       |  2 +-
 include/linux/spi/spi.h | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

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
index 834a09bd8ccc..2611f86180a3 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1340,6 +1340,31 @@ static inline bool spi_is_bpw_supported(struct spi_device *spi, u32 bpw)
 	return false;
 }
 
+/**
+ * spi_bpw_to_bytes - Covert bits per word to bytes
+ * @bpw: Bits per word
+ *
+ * This function converts the given @bpw to bytes. The result is always
+ * power-of-two, e.g.,
+ *
+ *  ===============    =================
+ *  Input (in bits)    Output (in bytes)
+ *  ===============    =================
+ *          0                   0
+ *          5                   1
+ *          9                   2
+ *          2                   4
+ *          3                   8
+ *  ===============    =================
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


