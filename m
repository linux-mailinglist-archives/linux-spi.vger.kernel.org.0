Return-Path: <linux-spi+bounces-2921-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FC58C8CE1
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 21:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94EAC1F231A2
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 19:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAD1140E4D;
	Fri, 17 May 2024 19:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mUfP/QMK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EB7140366;
	Fri, 17 May 2024 19:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715974874; cv=none; b=LzB6/e4J85W3fNowupxIrukk+4WJUgzODIGVe9sYbJcg0idxYAHyLOhW+aF0z5UOWw9LbtBpYlIr+JRHahRI+Qenw7kRkr/XhpEuk6cMWn0hiTntROpCCQeLkc4GoQL7H9CO9ZsdYpHZepKmy3A+1DzIVmeA+tyg/ZZ3Go/iIoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715974874; c=relaxed/simple;
	bh=96N7qe/v17ZlBpVlNgzHkjLLMJgeHxXPuDVUsLGh+k4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BIC9Gy0rySUKDkNo+U12eQfXTgIXyIZFL780J54XS2llo1X93XHEOQGSA6L5mCrcxeL8eK9zGt2PQKMbddasCpXj3+X9nMeDupuUSRuTEnB75YLEWEnQ7BD4a7a+H7bf74oZk7A0QYtVLn1S0ytfzCgvRPNjlTntAJ3gZzOHt5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mUfP/QMK; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715974872; x=1747510872;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=96N7qe/v17ZlBpVlNgzHkjLLMJgeHxXPuDVUsLGh+k4=;
  b=mUfP/QMKNsQ5Qg5yadxBJcftZ4k3qx4424xsXktoRJtjUsE+I+cGLvjF
   /yUvnvJZ+DTJTuCpblj6ETdDIFfdO1Nm/fZPNGLUV29QlaZ/Va0Xnb6FJ
   6o2VF4jlBE7/0evpBoKKgGDl6/7ceSPTLD4CCbxv54wzvFVNmSHiq+xLN
   3Agp2fkeTBSZaTLHDzvAMsK2EzqD3eNjKiPNfOe0RAbJ88WnqsUomSWfN
   GPmh0NF2s3Yzwh+urPHXEBXze1o2PWA4DOfU82096BorjO/JrF/gBptQc
   MO8cGAH/hVw86/+0v/cR5aSj2xMohpR1hULtuf0T/lVV6yn2XRiUQZwq2
   A==;
X-CSE-ConnectionGUID: 6L93flwOQBilhX3NkUXMbg==
X-CSE-MsgGUID: MoFGCv3uRtieGzwAp1neFg==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="22783103"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="22783103"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 12:41:10 -0700
X-CSE-ConnectionGUID: S3qoplqCQd2p+BMbgzh4gQ==
X-CSE-MsgGUID: Fq/gPlBfSHOlVlgo/8Uwdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="32503704"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 17 May 2024 12:41:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 57155118; Fri, 17 May 2024 22:41:07 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] spi: bitbang: Use typedef for txrx_*() callbacks
Date: Fri, 17 May 2024 22:40:20 +0300
Message-ID: <20240517194104.747328-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240517194104.747328-1-andriy.shevchenko@linux.intel.com>
References: <20240517194104.747328-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With a typedef for the txrx_*() callbacks the code looks neater.
Note that typedef for a function is okay to have.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-bitbang.c       | 31 +++++++++----------------------
 include/linux/spi/spi_bitbang.h |  7 ++++---
 2 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index ca5cc67555c5..d88110acdc5f 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -38,26 +38,19 @@
  * working quickly, or testing for differences that aren't speed related.
  */
 
+typedef unsigned int (*spi_bb_txrx_bufs_fn)(struct spi_device *, spi_bb_txrx_word_fn,
+					    unsigned int, struct spi_transfer *,
+					    unsigned int);
+
 struct spi_bitbang_cs {
 	unsigned	nsecs;	/* (clock cycle time)/2 */
-	u32		(*txrx_word)(struct spi_device *spi, unsigned nsecs,
-					u32 word, u8 bits, unsigned flags);
-	unsigned	(*txrx_bufs)(struct spi_device *,
-					u32 (*txrx_word)(
-						struct spi_device *spi,
-						unsigned nsecs,
-						u32 word, u8 bits,
-						unsigned flags),
-					unsigned, struct spi_transfer *,
-					unsigned);
+	spi_bb_txrx_word_fn txrx_word;
+	spi_bb_txrx_bufs_fn txrx_bufs;
 };
 
 static unsigned bitbang_txrx_8(
 	struct spi_device	*spi,
-	u32			(*txrx_word)(struct spi_device *spi,
-					unsigned nsecs,
-					u32 word, u8 bits,
-					unsigned flags),
+	spi_bb_txrx_word_fn txrx_word,
 	unsigned		ns,
 	struct spi_transfer	*t,
 	unsigned flags
@@ -83,10 +76,7 @@ static unsigned bitbang_txrx_8(
 
 static unsigned bitbang_txrx_16(
 	struct spi_device	*spi,
-	u32			(*txrx_word)(struct spi_device *spi,
-					unsigned nsecs,
-					u32 word, u8 bits,
-					unsigned flags),
+	spi_bb_txrx_word_fn txrx_word,
 	unsigned		ns,
 	struct spi_transfer	*t,
 	unsigned flags
@@ -112,10 +102,7 @@ static unsigned bitbang_txrx_16(
 
 static unsigned bitbang_txrx_32(
 	struct spi_device	*spi,
-	u32			(*txrx_word)(struct spi_device *spi,
-					unsigned nsecs,
-					u32 word, u8 bits,
-					unsigned flags),
+	spi_bb_txrx_word_fn txrx_word,
 	unsigned		ns,
 	struct spi_transfer	*t,
 	unsigned flags
diff --git a/include/linux/spi/spi_bitbang.h b/include/linux/spi/spi_bitbang.h
index b930eca2ef7b..7ca08b430ed5 100644
--- a/include/linux/spi/spi_bitbang.h
+++ b/include/linux/spi/spi_bitbang.h
@@ -4,6 +4,8 @@
 
 #include <linux/workqueue.h>
 
+typedef u32 (*spi_bb_txrx_word_fn)(struct spi_device *, unsigned int, u32, u8, unsigned int);
+
 struct spi_bitbang {
 	struct mutex		lock;
 	u8			busy;
@@ -28,9 +30,8 @@ struct spi_bitbang {
 	int	(*txrx_bufs)(struct spi_device *spi, struct spi_transfer *t);
 
 	/* txrx_word[SPI_MODE_*]() just looks like a shift register */
-	u32	(*txrx_word[4])(struct spi_device *spi,
-			unsigned nsecs,
-			u32 word, u8 bits, unsigned flags);
+	spi_bb_txrx_word_fn txrx_word[4];
+
 	int	(*set_line_direction)(struct spi_device *spi, bool output);
 };
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


