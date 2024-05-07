Return-Path: <linux-spi+bounces-2764-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9E48BEDE5
	for <lists+linux-spi@lfdr.de>; Tue,  7 May 2024 22:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8A61C249C3
	for <lists+linux-spi@lfdr.de>; Tue,  7 May 2024 20:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D90187323;
	Tue,  7 May 2024 20:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NWSSUa0/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBAC187321;
	Tue,  7 May 2024 20:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715112640; cv=none; b=sDcwIY3/fI0D6sFqls6zrRobP2vUeXE2ZpdymkO7C/2o1DXUdFaXu5pcfVVceZ5K3ljUVxF4SfoOx/w8NDMszNoH6vi88If0wsPa54j7vuodihX5PrCNyxlynQOBQGNOUYU6Ri9zYOvqVAzYPUrNNki0d6KPOZp+T2ELnCxLQEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715112640; c=relaxed/simple;
	bh=Y/s+dSrrtiOg8HwUTWr6cvAnMzvrvLoRt+LOHLXCFFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UwvFakxX0xm+j28WIUrJzEbQKnCinC3g5PQAcSRd142SBrz/KwP4/AWXRDYXFr8qHPWJX/ctJREweGyp0u/TS7+6HX0/FD7mFzHsU4htDS/xDeqvR0hvodXcGkQt54WqrROLkNNXtioB1zFkmjz3p2pep/OSG88sdPfGBijsiXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NWSSUa0/; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715112639; x=1746648639;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y/s+dSrrtiOg8HwUTWr6cvAnMzvrvLoRt+LOHLXCFFw=;
  b=NWSSUa0//Ho1OTLxJZds8OWVUS9Mvb4F130easfAEz8N+2QykmyTT4by
   /os1xx3m+ClGQoFLsmOJd4mGOJWCXM+ki3u+n28iXpC2iyKwo5x/eXDKe
   HPEPlI0BIoEovbMjh9j+mymo5R8ZwDNN0IVe3elfGRe1zbBBsvvg+adsO
   Bfy1vlOLgJnb+zvFrIOHhgUFHRqDC4XZYOWkmfpf338RGDrY6P7x3TNy5
   Lc0iO4w2Id3jwHQ3AYomix13dmzUmx3y03ECbHLEe/t26Cj0nAfPstSrY
   Qftyd5jAXg8RhbFWtC4GzcAuB+t9JeGO5njGGwNhXpXM/nZWrf0tnqOD2
   A==;
X-CSE-ConnectionGUID: 9UEtKfCKRzyvLxhicB3few==
X-CSE-MsgGUID: ihOEaGZuRbGo/a6taFK2tg==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11065626"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="11065626"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 13:10:36 -0700
X-CSE-ConnectionGUID: dmQRhGxgQme+6URZUuViLg==
X-CSE-MsgGUID: G2qfQ5dLQjmHNlISrIHxCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="33333791"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 07 May 2024 13:10:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A133A12A; Tue, 07 May 2024 23:10:33 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] spi: Remove unneded check for orig_nents
Date: Tue,  7 May 2024 23:10:27 +0300
Message-ID: <20240507201028.564630-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both dma_unmap_sgtable() and sg_free_table() in spi_unmap_buf_attrs()
have checks for orig_nents against 0. No need to duplicate this.
All the same applies to other DMA mapping API calls.

Also note, there is no other user in the kernel that does this kind of
checks.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b7e40898590a..cb27d9e551a4 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1221,12 +1221,10 @@ static void spi_unmap_buf_attrs(struct spi_controller *ctlr,
 				enum dma_data_direction dir,
 				unsigned long attrs)
 {
-	if (sgt->orig_nents) {
-		dma_unmap_sgtable(dev, sgt, dir, attrs);
-		sg_free_table(sgt);
-		sgt->orig_nents = 0;
-		sgt->nents = 0;
-	}
+	dma_unmap_sgtable(dev, sgt, dir, attrs);
+	sg_free_table(sgt);
+	sgt->orig_nents = 0;
+	sgt->nents = 0;
 }
 
 void spi_unmap_buf(struct spi_controller *ctlr, struct device *dev,
@@ -1331,10 +1329,8 @@ static void spi_dma_sync_for_device(struct spi_controller *ctlr,
 	if (!ctlr->cur_msg_mapped)
 		return;
 
-	if (xfer->tx_sg.orig_nents)
-		dma_sync_sgtable_for_device(tx_dev, &xfer->tx_sg, DMA_TO_DEVICE);
-	if (xfer->rx_sg.orig_nents)
-		dma_sync_sgtable_for_device(rx_dev, &xfer->rx_sg, DMA_FROM_DEVICE);
+	dma_sync_sgtable_for_device(tx_dev, &xfer->tx_sg, DMA_TO_DEVICE);
+	dma_sync_sgtable_for_device(rx_dev, &xfer->rx_sg, DMA_FROM_DEVICE);
 }
 
 static void spi_dma_sync_for_cpu(struct spi_controller *ctlr,
@@ -1346,10 +1342,8 @@ static void spi_dma_sync_for_cpu(struct spi_controller *ctlr,
 	if (!ctlr->cur_msg_mapped)
 		return;
 
-	if (xfer->rx_sg.orig_nents)
-		dma_sync_sgtable_for_cpu(rx_dev, &xfer->rx_sg, DMA_FROM_DEVICE);
-	if (xfer->tx_sg.orig_nents)
-		dma_sync_sgtable_for_cpu(tx_dev, &xfer->tx_sg, DMA_TO_DEVICE);
+	dma_sync_sgtable_for_cpu(rx_dev, &xfer->rx_sg, DMA_FROM_DEVICE);
+	dma_sync_sgtable_for_cpu(tx_dev, &xfer->tx_sg, DMA_TO_DEVICE);
 }
 #else /* !CONFIG_HAS_DMA */
 static inline int __spi_map_msg(struct spi_controller *ctlr,
-- 
2.43.0.rc1.1336.g36b5255a03ac


