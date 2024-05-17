Return-Path: <linux-spi+bounces-2919-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB288C8CDD
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 21:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145981C20EE8
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 19:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD07140363;
	Fri, 17 May 2024 19:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LMpZE6WD"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA5F13DDB0;
	Fri, 17 May 2024 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715974872; cv=none; b=TYwSbBCFh51gNPmttJLoNqt8tDR7VafSTxIDrj0wbnPCBks91edzcANtpfMLLOLeAKdM6r5Nc/MXlIDRJmXDTpwUU2HXM+TBh18gssxPwYStCiiQqGh+q2loq0aVUCBe4BapKlt6erGSM1lKXsFJezye+/CAV8YYxJusgvlypB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715974872; c=relaxed/simple;
	bh=fu2ycGfiDHO09k7hG2n7b4YA7Q5TXBs64qVIrhAtvt8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9FC4hm04k8Od1chJV5bt6Azfou3pFid1Hlp5w+O6AlCPFO1bUeKhVRTrCIGrtH9RK/dua+9Iiyna4Gu4xQIQT/AVsAvdwKQ5J3aNHiIuXEbkF4qRTy7gvX+amDzw2U0DY5WUEp7qviucTEKBcXi3HAweTq4M4TuE8NR91AJ7Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LMpZE6WD; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715974871; x=1747510871;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=fu2ycGfiDHO09k7hG2n7b4YA7Q5TXBs64qVIrhAtvt8=;
  b=LMpZE6WDh17BtvSi6CxAplGrwmLEJReQpFB0/HxagJ+TQukehS4K0KGg
   wfb3sq1hWtsj1sRNTQm1ud0ZwCao41idYiMXnrDNq6TrEKryj4SCE50/F
   btGllPiDTNf+ZTyEINSkIIqb0CvX15FaOOCbxUtAiRcgw24qsQ0VD1iQ/
   k7QARoSoXIe7aboPV106UbJdIgGFFwqTts7fjB0G9XEBe6ChVuAwXjfVV
   W9QlRpBxIeRgjaG/iS4EEd3iccWf2sUROzGGTo++uRpVvK/y52xxHcQuk
   UuZ5eVmjzyRoFPUnkIrPwUmDdY/9CqTstajHsIt+eYBZuDH9IJg1xuoLR
   g==;
X-CSE-ConnectionGUID: dvHHu8OTRHaWx6W2axOMEg==
X-CSE-MsgGUID: QwwQ7ivkSTuWU42INeryag==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="22783100"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="22783100"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 12:41:09 -0700
X-CSE-ConnectionGUID: x6nY/ggpQq6CNBcAPSPyVA==
X-CSE-MsgGUID: sEUCPdqXSoysdRNhWW/50Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="32503703"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 17 May 2024 12:41:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6F74B44E; Fri, 17 May 2024 22:41:07 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] spi: bitbang: Replace hard coded number of SPI modes
Date: Fri, 17 May 2024 22:40:22 +0300
Message-ID: <20240517194104.747328-4-andriy.shevchenko@linux.intel.com>
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

Instead of using hard coded number of modes, replace it with
SPI_MODE_X_MASK + 1 to show relation to the SPI modes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/spi/spi_bitbang.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/spi_bitbang.h b/include/linux/spi/spi_bitbang.h
index 7ca08b430ed5..d4cb83195f7a 100644
--- a/include/linux/spi/spi_bitbang.h
+++ b/include/linux/spi/spi_bitbang.h
@@ -30,7 +30,7 @@ struct spi_bitbang {
 	int	(*txrx_bufs)(struct spi_device *spi, struct spi_transfer *t);
 
 	/* txrx_word[SPI_MODE_*]() just looks like a shift register */
-	spi_bb_txrx_word_fn txrx_word[4];
+	spi_bb_txrx_word_fn txrx_word[SPI_MODE_X_MASK + 1];
 
 	int	(*set_line_direction)(struct spi_device *spi, bool output);
 };
-- 
2.43.0.rc1.1336.g36b5255a03ac


