Return-Path: <linux-spi+bounces-3187-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB30C8D6A1D
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 21:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FA251F29429
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 19:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EBC1822DC;
	Fri, 31 May 2024 19:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YNae9j3/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC3217F4FD;
	Fri, 31 May 2024 19:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184855; cv=none; b=tiDr8ZtvYDHxm4XcZHqU80mEC44jfQeJOwAg2poLV5Wj+SSMegfNDJzuuA5T4/NvnQuoGDji1/PW5Obrcxje4i958hqx1oFZvNloJGKrSfRIn0kKaav7d311hlPkLaY+4Yyv+kgGdcTf9cNtVoS+1366nxF85Xj1H9+LI2wHYVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184855; c=relaxed/simple;
	bh=u6yy5HS9GWcxuh4VW7Sd1i06Xno0PecsrxtOQkR0GKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JF5PpUQHd/VjQZUSDtNaUAOCKbXRrxzruDPy6p4Sjb0EJdg78EOTVpZBGLb8xoi5wad5ysJvNAI8PQNvKkKBCVxoT3YenzkB3g92FSK3HWNdedvIpoOCzJQ+XclOqgPEfmPTuQ85Z9R4JdAzF943p85wxU4XKu+pf7qWj36qJYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YNae9j3/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717184855; x=1748720855;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u6yy5HS9GWcxuh4VW7Sd1i06Xno0PecsrxtOQkR0GKk=;
  b=YNae9j3/cICmDzgoy10x6Q16su6gy/YEFb9R9s7bAfKfwe031m3KNo4f
   +K3EInukeGVz1lZzoEOhEex+/uEjcRUZqZXQtRphyTUph72xeHjIMAah9
   xyuZah78IMxnqbJWeSGSohkTj2Usjsr4HOn53DUgW5SfUk2k1UnkLjGCQ
   eZhBYJKJKoPPL2hdAMUcYLxTprmL7WmfytArmeUSJjUz0yBjzGMU555Zt
   LenazF5pTPxrefcHfUJe0/2tHh+/ovukKQmkxmilCelmFbhuiA8LrJox/
   K6U219SwkYfWwJZnF/r3izc7MPoriZSwTsO00T4fbXYZZhmKs//O1eH8I
   w==;
X-CSE-ConnectionGUID: gjrPgVhVRse6AM23iKePOA==
X-CSE-MsgGUID: mD9ioK+oT76pMoSVEIWaSA==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="39144682"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="39144682"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 12:47:34 -0700
X-CSE-ConnectionGUID: +smJlGlEQgC0zD0PglNuGQ==
X-CSE-MsgGUID: ztqxSOKHSeaBviE9im6WJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="67452630"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 31 May 2024 12:47:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3B1FA679; Fri, 31 May 2024 22:47:25 +0300 (EEST)
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
Subject: [PATCH v1 5/8] spi: pxa2xx: Use new spi_xfer_is_dma_mapped() helper
Date: Fri, 31 May 2024 22:42:37 +0300
Message-ID: <20240531194723.1761567-6-andriy.shevchenko@linux.intel.com>
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
 drivers/spi/spi-pxa2xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 1fb30201459f..16b96eb176cd 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -26,6 +26,7 @@
 
 #include <linux/spi/spi.h>
 
+#include "internals.h"
 #include "spi-pxa2xx.h"
 
 #define TIMOUT_DFLT		1000
@@ -993,11 +994,8 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *controller,
 	}
 
 	dma_thresh = SSCR1_RxTresh(RX_THRESH_DFLT) | SSCR1_TxTresh(TX_THRESH_DFLT);
-	dma_mapped = controller->can_dma &&
-		     controller->can_dma(controller, spi, transfer) &&
-		     controller->cur_msg_mapped;
+	dma_mapped = spi_xfer_is_dma_mapped(controller, spi, transfer);
 	if (dma_mapped) {
-
 		/* Ensure we have the correct interrupt handler */
 		drv_data->transfer_handler = pxa2xx_spi_dma_transfer;
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


