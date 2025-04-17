Return-Path: <linux-spi+bounces-7640-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBB4A92169
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 17:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF5F27AC2F3
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 15:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1293253956;
	Thu, 17 Apr 2025 15:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GeME2V/j"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C88724EF90;
	Thu, 17 Apr 2025 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744903536; cv=none; b=KrPIkU7XJyK/T4/+CXrI7UFFl0QIzOlZN7nqLJ2AS4DxSvE/6IU7JYkUZ865vVBhaPbP9CA/rbbYtZE/VbCr5c8/aZAu+u3r76aMsnvUzZY7bxZlbeZzipgP0bjdWeBIc3EHOpUeOkLBVHcXV9oCV8Lglu0NB7VfZfqqBMl6Kfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744903536; c=relaxed/simple;
	bh=E8TjGTgmXMM0wPS0/q7mf9Hb/MdG/iF8qByDfmetJ14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPkqrT/9fr8inkc6yuOEwIE5/koJcQtaI4KZ8bIpLQrF3eZMp5iwdLVrJ0EvVLYyhQHhBQQPwgwTuTyFR93+/sWJs05SFmVHl7aU1XCsTMiF9jc75bEri2NYdNKG+diJXICB3khzBlD9nTOoyJGI7tCWTVCX3MwVzsNOb4Rhe/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GeME2V/j; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744903535; x=1776439535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E8TjGTgmXMM0wPS0/q7mf9Hb/MdG/iF8qByDfmetJ14=;
  b=GeME2V/jNFM7Wmh3WdmULdZnCjQGHCKHW35IPxLZf8xVQW7EU9iRMEE7
   Xn/jEowq78ra6XkarKcSOyAA+uUprfsjbTjzltAFop2DHKELc2V8AWr8W
   fMcTQoxXsuXB4UFZ49aiJR7/G5lxXzrk9aXwWbFC+wbQaT8aJzdw9G/52
   ZLszR6YfJWVEmZ8wqTaDP0We1jV2knnqSBg/d7l+SMu7Fn+bqHYwZHrXJ
   7kgu9Sn5fYV8r7mJ5HZJ6OK7ss0Rcfn1UgnXCgxzvieHJK9ap0377fQMT
   YvM/rNx1WewJZImQZ1p9OSudOxQSNKegdaEsVqlgXRZ2QxMHrk6RopgF8
   Q==;
X-CSE-ConnectionGUID: /neUxqH8QbG8TtSAYPMhGQ==
X-CSE-MsgGUID: 9EzYeCT/ShOWIgswtLlaTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="57869092"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="57869092"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 08:25:35 -0700
X-CSE-ConnectionGUID: fFN4y9QnRI2KWvGrUmHfow==
X-CSE-MsgGUID: 059aj4DjRgGlDxfZlt9GTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="136008918"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 17 Apr 2025 08:25:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C4B62170; Thu, 17 Apr 2025 18:25:31 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v3 1/2] spi: Add spi_bpw_to_bytes() helper and use it
Date: Thu, 17 Apr 2025 18:24:46 +0300
Message-ID: <20250417152529.490582-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250417152529.490582-1-andriy.shevchenko@linux.intel.com>
References: <20250417152529.490582-1-andriy.shevchenko@linux.intel.com>
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
            5                   1
            9                   2
            21                  4
            37                  8
    ===============    =================

It will return 0 for the 0 input.

There are a couple of cases in SPI that are using the same approach
and at least one more (in IIO) would benefit of it. Add a helper
for everyone.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c       |  2 +-
 include/linux/spi/spi.h | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

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
index 834a09bd8ccc..c921ff902f0c 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1340,6 +1340,32 @@ static inline bool spi_is_bpw_supported(struct spi_device *spi, u32 bpw)
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
+ *          5                   1
+ *          9                   2
+ *          21                  4
+ *          37                  8
+ *  ===============    =================
+ *
+ * It will return 0 for the 0 input.
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


