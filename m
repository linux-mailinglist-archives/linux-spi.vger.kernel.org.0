Return-Path: <linux-spi+bounces-3185-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E6D8D6A18
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 21:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0CD1F289CD
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 19:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BA117F4F1;
	Fri, 31 May 2024 19:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UIME92Te"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11DC17D895;
	Fri, 31 May 2024 19:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184854; cv=none; b=GHWHUGJngi/xs4d3nElRR1DAu0vxWCWiameEbp7wwUA1w7ZKrRYsozOMGiYzcMmNHW5ES7vPoON4FNfPtDg5C03DElnJuA88iLV1ZCfIbmWAvw1JgnRHJvs8W5QfpaT/iYP2Q+mxpeWFBM83k42ftpCAoTtll4OTANlj6AUZSJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184854; c=relaxed/simple;
	bh=NPol/R/h+TdNNpLaDetGmpColwfnbBnkxBZCvk+JrSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjAFfS89wPGbhNtkr9Er3i/XozVktkg3tGmHVZVF6hjCtR99eZJnKSK+GiJhtSoBdeYp1hMpmrDLLWP91djolamrnsPGXf50ILf9p1ZFm0N/QJIi14cQywS1knMFFQD05YVZ+JTOD13Lb2v706nJhOmZLqG1uk/P/Iz628Lop2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UIME92Te; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717184853; x=1748720853;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NPol/R/h+TdNNpLaDetGmpColwfnbBnkxBZCvk+JrSg=;
  b=UIME92TeV3Af4Av7Xsu0DVqQekwRLPeAsNHDRpNwramT6MYbcXLK9tQH
   VvvVMRSKSQXRThdDUggDB8XPTs81fV+gPdpNaqDa2ERdkpywat2/YbNxv
   shM3HCYlUgT/8xND6cZhPkyGs86lm78obvVBc0fZbI3FT4azpcpCpGoZw
   C/0ur0l5LxNbfmND3iOXZKY9zT9Xl8XbmzudyPTNHDacM+WyYQtr8Yhm8
   2s+jMTEAnZNYvsaM/KXIsu6sVzutZ5KPzlX/d0i3g04Ynmi0AVZT0AbrL
   QLcSlPU49/hfPCA4hAK0KOAz92jb07O/ysORHH0NnpqZTDy+GDxD2Sazv
   g==;
X-CSE-ConnectionGUID: wnvTS4zYRdOyVdoC3xh7rg==
X-CSE-MsgGUID: m9xTh+NHRPOJlR0nX9Lkfw==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="39144663"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="39144663"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 12:47:30 -0700
X-CSE-ConnectionGUID: 48QEDkXyQ/mungdUvq7PWg==
X-CSE-MsgGUID: 4vLsBDPPRN+K8D49bPj6sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="67452619"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 31 May 2024 12:47:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2015E650; Fri, 31 May 2024 22:47:25 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thangaraj Samynathan <thangaraj.s@microchip.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v1 3/8] spi: ingenic: Use new spi_xfer_is_dma_mapped() helper
Date: Fri, 31 May 2024 22:42:35 +0300
Message-ID: <20240531194723.1761567-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240531194723.1761567-1-andriy.shevchenko@linux.intel.com>
References: <20240531194723.1761567-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace a few lines of code by calling a spi_xfer_is_dma_mapped() helper.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-ingenic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ingenic.c b/drivers/spi/spi-ingenic.c
index 003a6d21c4c3..318b0768701e 100644
--- a/drivers/spi/spi-ingenic.c
+++ b/drivers/spi/spi-ingenic.c
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
+#include "internals.h"
 
 #define REG_SSIDR	0x0
 #define REG_SSICR0	0x4
@@ -242,11 +243,10 @@ static int spi_ingenic_transfer_one(struct spi_controller *ctlr,
 {
 	struct ingenic_spi *priv = spi_controller_get_devdata(ctlr);
 	unsigned int bits = xfer->bits_per_word ?: spi->bits_per_word;
-	bool can_dma = ctlr->can_dma && ctlr->can_dma(ctlr, spi, xfer);
 
 	spi_ingenic_prepare_transfer(priv, spi, xfer);
 
-	if (ctlr->cur_msg_mapped && can_dma)
+	if (spi_xfer_is_dma_mapped(ctlr, spi, xfer))
 		return spi_ingenic_dma_tx(ctlr, xfer, bits);
 
 	if (bits > 16)
-- 
2.43.0.rc1.1336.g36b5255a03ac


