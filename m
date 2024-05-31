Return-Path: <linux-spi+bounces-3188-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 295238D6A22
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 21:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCF061F298BD
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 19:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F337F183078;
	Fri, 31 May 2024 19:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZcM+3T+P"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF0417FADA;
	Fri, 31 May 2024 19:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184856; cv=none; b=PeIpEbMN5VwYzYrT6ZyFAu6c3Tha3ap9jLwpNoKLhSdOLXA2ap4plB2Il9x7KXbZ1kYjASoPuDG19U+UDla9SyBZAq9e68BQnY0is5T5YCD8vC7b3rVMNSm+g+jOYcATLFVberKuLUXOCJD33WuKld6+NBnKmJ+tfBj54M0k7QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184856; c=relaxed/simple;
	bh=V8BjWKXND1DprtSPvDdNYQPO5LtJssRIUnnGwI0067k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nEFwGDp6J5iDUpYO1oef1OUMWfFuueXRtqaEZcTuMm+RiXiLTYmc285fFDQ5ByzYI0r2b97O8S02trZwFuZxEUx8htUQHWAsFnON6dqoJVtfYQ1UsUkBUq8uCtOxuMG1kAB9rdSDZ17CSWcUHj90FER/vJck4xZGy1nv+N2lkRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZcM+3T+P; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717184856; x=1748720856;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V8BjWKXND1DprtSPvDdNYQPO5LtJssRIUnnGwI0067k=;
  b=ZcM+3T+PRounA/48VSVeGTIN5AdyHCDQwUYQ+sfJQnoG8vfbYHZNwClT
   sKfUsIosQvv3oLZT1R6TbSFPKtmsslT0e9GXINS3EooG2BCXBeV0XMFi1
   +ukCra4sKDaZJJwnasVgcp2X8AR3/+KFG9z8k3GIFDbCWMQRD9w5T7GYW
   2fAJ8g9XmUvrHauePstX0oO8imFkEYbipuLCT8Lz8YcMZgC14EL8fahDL
   U8k7V8OenQ8QE6TyhCzXbZjbU5xCbRFEFgxw4YMO+QS6lhX9sSYhBtYTd
   dfIF3F5sN55lpW54MBMzQMaT3odykYI+pLNdVUlomGbLAdN3uKOueIoKm
   A==;
X-CSE-ConnectionGUID: 2YRhSWKbTdeil7Z3qnyhkA==
X-CSE-MsgGUID: cwjjLymCSKaeDb8BILIv/g==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="39144705"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="39144705"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 12:47:34 -0700
X-CSE-ConnectionGUID: 1A16O+DhRjmT9I//t+XD+Q==
X-CSE-MsgGUID: oI9PyvAUSjmVJuk2u7GBNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="67452633"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 31 May 2024 12:47:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5206E6AB; Fri, 31 May 2024 22:47:25 +0300 (EEST)
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
Subject: [PATCH v1 7/8] spi: qup: Use new spi_xfer_is_dma_mapped() helper
Date: Fri, 31 May 2024 22:42:39 +0300
Message-ID: <20240531194723.1761567-8-andriy.shevchenko@linux.intel.com>
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
 drivers/spi/spi-qup.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 2af63040ac6e..06da4aa7eeb7 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -5,6 +5,8 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/err.h>
 #include <linux/interconnect.h>
 #include <linux/interrupt.h>
@@ -16,8 +18,7 @@
 #include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
-#include <linux/dmaengine.h>
-#include <linux/dma-mapping.h>
+#include "internals.h"
 
 #define QUP_CONFIG			0x0000
 #define QUP_STATE			0x0004
@@ -709,9 +710,7 @@ static int spi_qup_io_prep(struct spi_device *spi, struct spi_transfer *xfer)
 
 	if (controller->n_words <= (controller->in_fifo_sz / sizeof(u32)))
 		controller->mode = QUP_IO_M_MODE_FIFO;
-	else if (spi->controller->can_dma &&
-		 spi->controller->can_dma(spi->controller, spi, xfer) &&
-		 spi->controller->cur_msg_mapped)
+	else if (spi_xfer_is_dma_mapped(spi->controller, spi, xfer))
 		controller->mode = QUP_IO_M_MODE_BAM;
 	else
 		controller->mode = QUP_IO_M_MODE_BLOCK;
-- 
2.43.0.rc1.1336.g36b5255a03ac


