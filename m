Return-Path: <linux-spi+bounces-2920-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 517738C8CDE
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 21:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6FE91F21D24
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 19:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7CD140367;
	Fri, 17 May 2024 19:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mnIuEOfO"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C856E60B9C;
	Fri, 17 May 2024 19:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715974872; cv=none; b=UNUfOlmfRAiYvsrR8BDvEBdtCDE43jjhVKW/8Nh3c1lT8DFscRYXjNymLKfk0DpxvvLtxii1hxR/2k9n9QjuN3YFKtkZkNEwmABqhCsyU9a3Ib6WWuPqdktspwrokqST7AmJAKNd+n3lPTfNMlWibJHo82LStcHWXlHTCuGmzLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715974872; c=relaxed/simple;
	bh=cTQBxU02LeveXCRXj6bpQOjerEQ0zlysDmITzO6Sx+c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETy/b5pFAEYJEWkuTeffLIkUPKbZ4+BkAxCKsWK90/x45AwxPS8yfOFexrQlLXWyh2HGQDK35egXhOGTmEOBoqAnrq6XUEtxKsctRxYNhCuwahmi88n1DEskP9YhTgtq28spbeldfpJN6pLh4jSCIyxthMox5e1gumxtjoyTB/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mnIuEOfO; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715974872; x=1747510872;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=cTQBxU02LeveXCRXj6bpQOjerEQ0zlysDmITzO6Sx+c=;
  b=mnIuEOfO9nYmKesu6Xt5YeKgWMWPLqoo11/kDzjpk+N0Nxs5j6HNboFl
   QaKM6dssqb35bHAxK/wYw73vZI9jpa5doc0+YK+OBu/Pi1pVCyBsinWfL
   JxjfcDAohIm1pMhndUdcxn5wpEtZ4T9wmftcsB1RFjSzJJlKDiHBw7Oyd
   lGoBPdFTwRjjHg/8KhWUKRNGM4aIrPGSEVCD3VFzeIMkToa/4ntVRMTli
   jmR9xzTKj/m+OjOSX8Jh8wCJRhZ2/RqLQ09UEv5lbKdW5fyOVMsHCAfc+
   /pU6ImvsLGBFklk/LVCgqpt5A0TkokewEHvGM5p7r0f0A8BzPMC8zsfKa
   A==;
X-CSE-ConnectionGUID: iqsam8g4QxC9EQWwA1XYRw==
X-CSE-MsgGUID: JBFvuL0+RCq8ToLPHrz1eg==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="29681808"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="29681808"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 12:41:11 -0700
X-CSE-ConnectionGUID: WvgmiBuLTvOTnrKrwJVSIA==
X-CSE-MsgGUID: rwfz7ZUKSuCkxxCWufEULA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="63081839"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 17 May 2024 12:41:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5C3FC2D2; Fri, 17 May 2024 22:41:07 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] spi: bitbang: Convert unsigned to unsigned int
Date: Fri, 17 May 2024 22:40:21 +0300
Message-ID: <20240517194104.747328-3-andriy.shevchenko@linux.intel.com>
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

Simple type conversion with no functional change implied.
While at it, adjust indentation where it makes sense.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-bitbang.c | 42 +++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index d88110acdc5f..afb1b1105ec2 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -43,21 +43,19 @@ typedef unsigned int (*spi_bb_txrx_bufs_fn)(struct spi_device *, spi_bb_txrx_wor
 					    unsigned int);
 
 struct spi_bitbang_cs {
-	unsigned	nsecs;	/* (clock cycle time)/2 */
+	unsigned int nsecs;	/* (clock cycle time) / 2 */
 	spi_bb_txrx_word_fn txrx_word;
 	spi_bb_txrx_bufs_fn txrx_bufs;
 };
 
-static unsigned bitbang_txrx_8(
-	struct spi_device	*spi,
+static unsigned int bitbang_txrx_8(struct spi_device *spi,
 	spi_bb_txrx_word_fn txrx_word,
-	unsigned		ns,
+	unsigned int ns,
 	struct spi_transfer	*t,
-	unsigned flags
-)
+	unsigned int flags)
 {
-	unsigned		bits = t->bits_per_word;
-	unsigned		count = t->len;
+	unsigned int		bits = t->bits_per_word;
+	unsigned int		count = t->len;
 	const u8		*tx = t->tx_buf;
 	u8			*rx = t->rx_buf;
 
@@ -74,16 +72,14 @@ static unsigned bitbang_txrx_8(
 	return t->len - count;
 }
 
-static unsigned bitbang_txrx_16(
-	struct spi_device	*spi,
+static unsigned int bitbang_txrx_16(struct spi_device *spi,
 	spi_bb_txrx_word_fn txrx_word,
-	unsigned		ns,
+	unsigned int ns,
 	struct spi_transfer	*t,
-	unsigned flags
-)
+	unsigned int flags)
 {
-	unsigned		bits = t->bits_per_word;
-	unsigned		count = t->len;
+	unsigned int		bits = t->bits_per_word;
+	unsigned int		count = t->len;
 	const u16		*tx = t->tx_buf;
 	u16			*rx = t->rx_buf;
 
@@ -100,16 +96,14 @@ static unsigned bitbang_txrx_16(
 	return t->len - count;
 }
 
-static unsigned bitbang_txrx_32(
-	struct spi_device	*spi,
+static unsigned int bitbang_txrx_32(struct spi_device *spi,
 	spi_bb_txrx_word_fn txrx_word,
-	unsigned		ns,
+	unsigned int ns,
 	struct spi_transfer	*t,
-	unsigned flags
-)
+	unsigned int flags)
 {
-	unsigned		bits = t->bits_per_word;
-	unsigned		count = t->len;
+	unsigned int		bits = t->bits_per_word;
+	unsigned int		count = t->len;
 	const u32		*tx = t->tx_buf;
 	u32			*rx = t->rx_buf;
 
@@ -221,7 +215,7 @@ EXPORT_SYMBOL_GPL(spi_bitbang_cleanup);
 static int spi_bitbang_bufs(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct spi_bitbang_cs	*cs = spi->controller_state;
-	unsigned		nsecs = cs->nsecs;
+	unsigned int		nsecs = cs->nsecs;
 	struct spi_bitbang	*bitbang;
 
 	bitbang = spi_controller_get_devdata(spi->controller);
@@ -234,7 +228,7 @@ static int spi_bitbang_bufs(struct spi_device *spi, struct spi_transfer *t)
 	}
 
 	if (spi->mode & SPI_3WIRE) {
-		unsigned flags;
+		unsigned int flags;
 
 		flags = t->tx_buf ? SPI_CONTROLLER_NO_RX : SPI_CONTROLLER_NO_TX;
 		return cs->txrx_bufs(spi, cs->txrx_word, nsecs, t, flags);
-- 
2.43.0.rc1.1336.g36b5255a03ac


