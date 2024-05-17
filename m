Return-Path: <linux-spi+bounces-2933-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 740CB8C8D0B
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 21:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5C7E1C22F30
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 19:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FBF1420DA;
	Fri, 17 May 2024 19:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YGJQmR+x"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33AE1411E8;
	Fri, 17 May 2024 19:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715975633; cv=none; b=kEZ9Zx3XO/ECI6i7hbVeRnK0zHv6k1SpjKTcZNuSEQ6ZF6Q/tQroMm6aBJooUM8FsC8HDtej80jKJ9/mlcGIg60uAtbEvaxuCh4skymFj/h1HD8SUHxDS9TR1VknNj7tFQLbLWnGy1rCOzZJZNTMZWTVAxVyTIlFrnOeOeyVAH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715975633; c=relaxed/simple;
	bh=6yxGDk7ROsAHdlN45SFSGOkUAPyIsLceEo5pzjgzRq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUPy2rJZwi0oPitXP+owGFr7Q/HuxPeYN1GJ/6hZavIjequhjQa+FrkEU+L9T+htnELaR45KeRTdxXCv+7KZkX0KSM9LD00Zbw6nW4XqHssRN7MnMHDbWH0U4euF0Wbq8GJGTQ2bk3UNa4Xm27MxxkBGjxL6T+UPIVRyykVYcS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YGJQmR+x; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715975632; x=1747511632;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6yxGDk7ROsAHdlN45SFSGOkUAPyIsLceEo5pzjgzRq0=;
  b=YGJQmR+x07kFasJWFsj83RkQwa0qfmIp/WvRlNRzDTXPSkiyqB3h8PE9
   rlqRlrOyNLAGs5XSCiz3OkLIL/h9KGZZE2BOXHkMGFLMqHCEbsnvgwkaD
   FLbDpbyrs1cD/YLcNOo+LkQkx2mTnRHxQKXceflmx+Tyl6/Ejwii7Q0uJ
   8md8vilQBTUhHs2uRfmGsDDlPF4JFBSSFw4938amOO1LueHsX1V0alchK
   EkCOG1pkatWVMgKBAL2elA47UH7nOuUPJQl/tAGhGdnVk0PUDjDDfBqBL
   H8XG/qKrhusNkIcVDLbkNxe9tLq4khg3I+T6TzbEXy+sy0olH9IPI+VZE
   g==;
X-CSE-ConnectionGUID: r4mK80jnSbmMki9XUge75Q==
X-CSE-MsgGUID: sZURCCQ0S2mkvD96nsrS7g==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="12348660"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="12348660"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 12:53:51 -0700
X-CSE-ConnectionGUID: yG+fqxbaS3eJAIHu8L2Vjg==
X-CSE-MsgGUID: cYaIy8bnRoWTHwLpCa8toQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="31915014"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 17 May 2024 12:53:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 50F664B1; Fri, 17 May 2024 22:53:45 +0300 (EEST)
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
Subject: [PATCH v1 05/10] spi: pxa2xx: Print DMA burst size only when DMA is enabled
Date: Fri, 17 May 2024 22:47:39 +0300
Message-ID: <20240517195344.813032-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240517195344.813032-1-andriy.shevchenko@linux.intel.com>
References: <20240517195344.813032-1-andriy.shevchenko@linux.intel.com>
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
index 56ff296925b7..6bbeb1d09ed9 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1412,7 +1412,6 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 		if (IS_ERR(platform_info))
 			return dev_err_probe(dev, PTR_ERR(platform_info), "missing platform data\n");
 	}
-	dev_dbg(dev, "DMA burst size set to %u\n", platform_info->dma_burst_size);
 
 	ssp = pxa_ssp_request(pdev->id, pdev->name);
 	if (!ssp)
@@ -1496,6 +1495,8 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 			controller->max_dma_len = MAX_DMA_LEN;
 			controller->max_transfer_size =
 				pxa2xx_spi_max_dma_transfer_size;
+
+			dev_dbg(dev, "DMA burst size set to %u\n", platform_info->dma_burst_size);
 		}
 	}
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


