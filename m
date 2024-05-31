Return-Path: <linux-spi+bounces-3186-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E34558D6A1B
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 21:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FC6E288893
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 19:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620E67F7CA;
	Fri, 31 May 2024 19:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F/84ravK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20B017E479;
	Fri, 31 May 2024 19:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184855; cv=none; b=e2Eg5xe1sZ7UrwGKtN1ea5EZOAtWQ2dpsooMoyuY0ElZwRRmu1wKxJ3SOB1Fa5UFub1eDf4PKyW+MUnNHrRImknlkttjFL1AvibOqZZGPXgENo6XiU1BMGaq+LiGl1qJnyI0ttwE1esSIjwhtVzHNYj8/EZM4LSbyQg7rvnac4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184855; c=relaxed/simple;
	bh=m6PMMUoDxsMJTLuxxmK/JswtaHUXsRGOeRWlSpgoV5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9aCvanPq88oGDqY0MPiSbMQuzdnTlFaKWjiVBGjHGEj34jLpjm6kJth271bfU0yG9lDU0OHWKuRs3382SN7z54WqpcbsCn/U/dibXbwKh0ZRkX/u67cX8UlJSF7EKhPuT+iJGNBX/Dfb7WG67XuiMF1bvUVWYEePgHKiqvyaiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F/84ravK; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717184854; x=1748720854;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m6PMMUoDxsMJTLuxxmK/JswtaHUXsRGOeRWlSpgoV5M=;
  b=F/84ravKYvaQzekpl/fddSypGF1a+yevZb7hEtrKRGJAPhQGH3bTtO8M
   4WQhKzR6QtajfFbx+6Bc0KD7ze28EokTqwB7uT/S8UhhpzpOp/noTvd9S
   sVt7SU2ml+bynCoVMuken6oBfhwGygP2LqMyt3FK8Hi3YX3QWQPWkJnob
   bm5a5EiHY3eyN3rBtoYqwljB+QgvV/fizU7KCMDxV8wuaTwnwjKl7YTdG
   ZfgaTOjBwykK5UiqpE2MflaW6YGZn2IIGLxI7YTGrQqIVPLuF1PJaDajo
   FAhXGebwpkpG7cPWmYrWNNPj6h+U5kl42EY5Otu/AkosLE0pOK8CsHrnD
   Q==;
X-CSE-ConnectionGUID: 1qHqDdSpRCiB5avDa1bxkA==
X-CSE-MsgGUID: Quus20irSyuVaaz0Rw0RUw==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="39144674"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="39144674"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 12:47:30 -0700
X-CSE-ConnectionGUID: hnQdOcRDTgGX5Z0NhqkDKg==
X-CSE-MsgGUID: dlchLsbuS/6MVxz8w1FczA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="67452620"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 31 May 2024 12:47:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2CF12668; Fri, 31 May 2024 22:47:25 +0300 (EEST)
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
Subject: [PATCH v1 4/8] spi: omap2-mcspi: Use new spi_xfer_is_dma_mapped() helper
Date: Fri, 31 May 2024 22:42:36 +0300
Message-ID: <20240531194723.1761567-5-andriy.shevchenko@linux.intel.com>
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
 drivers/spi/spi-omap2-mcspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 7e3083b83534..b624cc472857 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -27,6 +27,8 @@
 
 #include <linux/spi/spi.h>
 
+#include "internals.h"
+
 #include <linux/platform_data/spi-omap2-mcspi.h>
 
 #define OMAP2_MCSPI_MAX_FREQ		48000000
@@ -1208,8 +1210,7 @@ static int omap2_mcspi_transfer_one(struct spi_controller *ctlr,
 		unsigned	count;
 
 		if ((mcspi_dma->dma_rx && mcspi_dma->dma_tx) &&
-		    ctlr->cur_msg_mapped &&
-		    ctlr->can_dma(ctlr, spi, t))
+		    spi_xfer_is_dma_mapped(ctlr, spi, t))
 			omap2_mcspi_set_fifo(spi, t, 1);
 
 		omap2_mcspi_set_enable(spi, 1);
@@ -1220,8 +1221,7 @@ static int omap2_mcspi_transfer_one(struct spi_controller *ctlr,
 					+ OMAP2_MCSPI_TX0);
 
 		if ((mcspi_dma->dma_rx && mcspi_dma->dma_tx) &&
-		    ctlr->cur_msg_mapped &&
-		    ctlr->can_dma(ctlr, spi, t))
+		    spi_xfer_is_dma_mapped(ctlr, spi, t))
 			count = omap2_mcspi_txrx_dma(spi, t);
 		else
 			count = omap2_mcspi_txrx_pio(spi, t);
-- 
2.43.0.rc1.1336.g36b5255a03ac


