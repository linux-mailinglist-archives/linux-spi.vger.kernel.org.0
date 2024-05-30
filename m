Return-Path: <linux-spi+bounces-3151-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9A38D4EC6
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 17:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8EA61F24A15
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 15:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1183A1862AA;
	Thu, 30 May 2024 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kP8XQVQK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C8D18397C;
	Thu, 30 May 2024 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081888; cv=none; b=AieFGisc8nTtV55F2rAIhI1zyuyVaRuwasLtmBbY/WDub3QU/qTU93kXq2tZ+xKkPNAe4iN4mRE2o5Z+vz7unQbUjfa+SpysGNRdaLonOAaPJ0cJZF53xYOXl5mjojA1ESdtGoaN6aI9XtquFFg3tnpE35Crryjt8ywcLtWWG24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081888; c=relaxed/simple;
	bh=VtuiMejnZILT/hyIjcNOY30dlVGcZI/pZvafnR2kTW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qtq4Mtafgk/F+vHFer6EwRDgQva1Rdnwo8hxcbV+j7f79GyovlDgSUai155vs1VGal+RWUH8/nqGwuLT5SoIo4vJhtTq1rha5+9vBnqEFcRrdaCx1RBQ8QjwUMsmqZbgUH2St+at7hH3WertgKG6okDcG5KXWU8IAi1docDsLKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kP8XQVQK; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717081887; x=1748617887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VtuiMejnZILT/hyIjcNOY30dlVGcZI/pZvafnR2kTW0=;
  b=kP8XQVQKKytQswSd5X1lf78c910hKf33lY6j8pJTw92/gAAdNDNv/lIv
   fhnQc6aOqzGEPsXxk2+in3oJr9QfzCtzIlDMQLCFtoweEsgsC72MVFbpr
   Roetf1EK+aWtmBLz2HRutOKKIU1/tuWnZ+UE4LkF70yb2/1/7gmM99/n5
   UBFk2S017b08Kzcmuk3xae7vNryUsfPYYFe27AM9/3ScQhGX7cem9hjj6
   JFnGG7UvfbG5cCJpLytSMsFIcbxcmluKZxyKHUotvOM6rxTyNIBCRpcPd
   CADT/1FfS2nuGhZllWZrN6YDb39ynb7QoKx1jUpn7x7p/yDFP3H5t2m9a
   A==;
X-CSE-ConnectionGUID: jqnYpsmUQnWTr0EfaRQFPg==
X-CSE-MsgGUID: YSkyMrx/RcyBAXhigPW7qA==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="31093063"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="31093063"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 08:11:26 -0700
X-CSE-ConnectionGUID: UfNqA/KvRC27iVrFMnKkuA==
X-CSE-MsgGUID: rivNWmNoRDSgY/osG8FgRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="40288503"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 30 May 2024 08:11:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 62AE46CB; Thu, 30 May 2024 18:11:19 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v2 06/11] spi: pxa2xx: Print DMA burst size only when DMA is enabled
Date: Thu, 30 May 2024 18:10:02 +0300
Message-ID: <20240530151117.1130792-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240530151117.1130792-1-andriy.shevchenko@linux.intel.com>
References: <20240530151117.1130792-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Print DMA burst size only when DMA is enabled to avoid making
a false impression that DMA is enabled when it may be not.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 19ee7739f4bd..30a829b74a22 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1434,7 +1434,6 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 		if (IS_ERR(platform_info))
 			return dev_err_probe(dev, PTR_ERR(platform_info), "missing platform data\n");
 	}
-	dev_dbg(dev, "DMA burst size set to %u\n", platform_info->dma_burst_size);
 
 	ssp = pxa2xx_spi_ssp_request(pdev);
 	if (IS_ERR(ssp))
@@ -1516,6 +1515,8 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 			controller->max_dma_len = MAX_DMA_LEN;
 			controller->max_transfer_size =
 				pxa2xx_spi_max_dma_transfer_size;
+
+			dev_dbg(dev, "DMA burst size set to %u\n", platform_info->dma_burst_size);
 		}
 	}
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


