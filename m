Return-Path: <linux-spi+bounces-3189-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B858D6A24
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 21:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43087B260B1
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 19:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8DE1836D8;
	Fri, 31 May 2024 19:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XkuMzVw5"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5D71822DE;
	Fri, 31 May 2024 19:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184857; cv=none; b=iGlGeSp9+CGfT62CjvaeYzaQI6AJ9qpGcOX+gre6F6lBEUV/Dn0N1w+kwrnZPsXXjMeOreDa5mLpGwgynRCQ//GpCOVHFjQ6XxVS4vRSs/KEHNxjThJvOp6UGcbwpSdcPbR7fZ7rakgbYqu/E3qxJMHduBpHp5sPJZiyB/id0No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184857; c=relaxed/simple;
	bh=/9eJLkmp3LgLhh+fMgJbD6pR0R5JNL/+VIoLm5XWU7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQ1c8kgKgIYrxjizWyM5LlRG4gYY3RLBMfKQCj5TA1SdfxP7/9mxe/MeE/YDtHLq1z8yL8yXI85SeR82fuyaeN46A89cXSRZffcqdcwi71ATD7vFxGy58IpeYobHEKAcNC31Jqz4tXOzIvG8aRhoDq3NOxvHxIX8xXhcfG1rbmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XkuMzVw5; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717184856; x=1748720856;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/9eJLkmp3LgLhh+fMgJbD6pR0R5JNL/+VIoLm5XWU7o=;
  b=XkuMzVw5k6GlFAZam/3Jf6++astZDrCw/q+Z7c56RgIYRlpY6LIUQ3Mx
   5mjceLotL+ImaDw9YE3nHs9s9kXZy6+johPyBhkRbrovUnTLfiDBk3TSo
   SZH7wPzhgfh9jH5PBN7vfqkRo7yu35RqFOO1xUas4W/qij+RxPFXCqxdD
   xb5NsaHHtSLNP8cNI/RLo6AT9dBxhRyMKfOB2NgOCg8Gb+Ktnxmkg9C0p
   SLH3Z//2qdyTbjBxa4kz/FjE98rKNu04e6cMWnrFJT5w+/0Mbd078tGHi
   w8XybVYf0sDAH6EMblqk4SgsXUUlD5RKomh0i7fzamymOXMlUGJB4yspg
   Q==;
X-CSE-ConnectionGUID: mCTLazYfTMe35ZzDfYJvWQ==
X-CSE-MsgGUID: DOt14wRlS0qnMG7RvCu+nQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="39144693"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="39144693"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 12:47:34 -0700
X-CSE-ConnectionGUID: OzG7PVx1Sj6oa374KfTxyw==
X-CSE-MsgGUID: w7sprX4/QRubzrJxN+DHJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="67452631"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 31 May 2024 12:47:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 440BE3B3; Fri, 31 May 2024 22:47:25 +0300 (EEST)
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
Subject: [PATCH v1 6/8] spi: pci1xxxx: Use new spi_xfer_is_dma_mapped() helper
Date: Fri, 31 May 2024 22:42:38 +0300
Message-ID: <20240531194723.1761567-7-andriy.shevchenko@linux.intel.com>
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
 drivers/spi/spi-pci1xxxx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pci1xxxx.c b/drivers/spi/spi-pci1xxxx.c
index cc18d320370f..fc98979eba48 100644
--- a/drivers/spi/spi-pci1xxxx.c
+++ b/drivers/spi/spi-pci1xxxx.c
@@ -6,6 +6,7 @@
 
 
 #include <linux/bitfield.h>
+#include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/iopoll.h>
 #include <linux/irq.h>
@@ -15,7 +16,7 @@
 #include <linux/pci.h>
 #include <linux/spinlock.h>
 #include <linux/spi/spi.h>
-#include <linux/delay.h>
+#include "internals.h"
 
 #define DRV_NAME "spi-pci1xxxx"
 
@@ -567,7 +568,7 @@ static int pci1xxxx_spi_transfer_with_dma(struct spi_controller *spi_ctlr,
 static int pci1xxxx_spi_transfer_one(struct spi_controller *spi_ctlr,
 				     struct spi_device *spi, struct spi_transfer *xfer)
 {
-	if (spi_ctlr->can_dma(spi_ctlr, spi, xfer) && spi_ctlr->cur_msg_mapped)
+	if (spi_xfer_is_dma_mapped(spi_ctlr, spi, xfer))
 		return pci1xxxx_spi_transfer_with_dma(spi_ctlr, spi, xfer);
 	else
 		return pci1xxxx_spi_transfer_with_io(spi_ctlr, spi, xfer);
-- 
2.43.0.rc1.1336.g36b5255a03ac


