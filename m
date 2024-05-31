Return-Path: <linux-spi+bounces-3184-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236638D6A16
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 21:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EEE5B21D82
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 19:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B104517E476;
	Fri, 31 May 2024 19:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JYTQSupf"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B559178369;
	Fri, 31 May 2024 19:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184853; cv=none; b=aNsG2uqOO6jKhJMI+MfA9xq4E10rXVfFhpdV5BSji6gQdUFghJl4ey0Q+7NE9sw4HKRQq5dAEfmOpu4OMLZWzKBGQTbc5oc9YRjxgHeI/YIPG68cY7VCoffUl/iFqbwtR/ivjJ8TLpGAdMfGMnGZ7P6Z1NpYHfYWUAEUyKxCxa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184853; c=relaxed/simple;
	bh=h+TKuS+Kdb3EPN8yAMusweqbJNDGlVqQOxmyBy/mh6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3QtdTK3XBOP9eNl1AK7rFtLqInu9vMQG8NatqbSSwxJqVlaMP0CBz02rv/Z2m565CDlkVkIE5xdYP8wX9Dlh++XsPymvF0Z/9Fjaqtro4N5OJZn71pfEztYXapGjbBSIdC/As86e3mfJc04nq4ZZ3BQx2ikJF06536GVYjcyX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JYTQSupf; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717184852; x=1748720852;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h+TKuS+Kdb3EPN8yAMusweqbJNDGlVqQOxmyBy/mh6A=;
  b=JYTQSupfrVk+ncv575yVAPFwqTrk15iUADrwcS9uOps5JUQEfGuzcj9v
   p37/9bzAZgvh5HbMm3AQNbArEZq6aksup+Y1yx+finWyaEyEOGpRm3X12
   uP81OYvnEy9JINOc/5F3s3YCh6/0xMO2DgbU3d+6y8ERdlRj/Yz/ABfev
   oQ9o82/cyb4nXcCpDQIdPhek3Jykff+v1mtaWLtNoCyCcoYNUuFvowqYq
   WnM8bsGxKi0IaZBlxnzErK003kjWRzU4QRJ2HLPlF9r8D5tGud70aJoR0
   8m6pOyimeXAHo73A8+vp2Z5YOT7uAVdegOfAz9jjsVN8KE1qCaxOgbm74
   g==;
X-CSE-ConnectionGUID: bZU4WJ4sTeq3ZPd0dbS7uQ==
X-CSE-MsgGUID: wRBHKDuqQ/mZz+haTKlOLw==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="39144652"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="39144652"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 12:47:30 -0700
X-CSE-ConnectionGUID: wmQx8GSBSMyebRW4k5MCGA==
X-CSE-MsgGUID: BrgdulQQRBK5Wbl/9p+0fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="67452621"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 31 May 2024 12:47:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1639641D; Fri, 31 May 2024 22:47:25 +0300 (EEST)
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
Subject: [PATCH v1 2/8] spi: dw: Use new spi_xfer_is_dma_mapped() helper
Date: Fri, 31 May 2024 22:42:34 +0300
Message-ID: <20240531194723.1761567-3-andriy.shevchenko@linux.intel.com>
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
 drivers/spi/spi-dw-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index ddfdb903047a..431788dd848c 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -19,6 +19,7 @@
 #include <linux/string.h>
 #include <linux/of.h>
 
+#include "internals.h"
 #include "spi-dw.h"
 
 #ifdef CONFIG_DEBUG_FS
@@ -438,8 +439,7 @@ static int dw_spi_transfer_one(struct spi_controller *host,
 	transfer->effective_speed_hz = dws->current_freq;
 
 	/* Check if current transfer is a DMA transaction */
-	if (host->can_dma && host->can_dma(host, spi, transfer))
-		dws->dma_mapped = host->cur_msg_mapped;
+	dws->dma_mapped = spi_xfer_is_dma_mapped(host, spi, transfer);
 
 	/* For poll mode just disable all interrupts */
 	dw_spi_mask_intr(dws, 0xff);
-- 
2.43.0.rc1.1336.g36b5255a03ac


