Return-Path: <linux-spi+bounces-3009-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 152F18CC55D
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 19:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381621C20F29
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 17:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913B71422C6;
	Wed, 22 May 2024 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V/1ei27w"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84AB1420C8;
	Wed, 22 May 2024 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716397830; cv=none; b=cIqWLWH1jLByVLX7Cd7elIWg21j35ZwOv56hPgZ2Z8iBanXtNBmYTbOx7KqnRDNwERhx2It7rTJrzR/em7ym+y8DtKjeLGKZO/V1w4EUlNBV8KjUd9in8F5XGNDMGkxgBPXpG2RN2Vhb4R//kHUWicAG9tqpZ/gNOVWjrNkVvTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716397830; c=relaxed/simple;
	bh=ih/XatgI/b6IXMWF2mm3fivW4TL6AmJ8/jFk2rg1YXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fjfI0VxMcOFykoMT3nShXp3snZx/L4t754VSkE5qAFsvU/Zol6zCZDWk67GsCx+LU9SObSv5ekmxNJn/phGbgAx4r5T/x3+lL6o2NZYaH1NKHyOhSKs0nVVWa7l/dhd15MjhrUzg65GWrU+8Oh3ywfEDwjgFST2wiHujRexQ7Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V/1ei27w; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716397829; x=1747933829;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ih/XatgI/b6IXMWF2mm3fivW4TL6AmJ8/jFk2rg1YXQ=;
  b=V/1ei27wJZnCp5jBxcWHrZAGZxe8DjpWMdF++7UUy6vzkpQ/KaYMBQnZ
   G9xCgxUvxZ17A5bkeoqyvKyGn+XboRt3lP6mQQoC68pL84rnfLY2zzWka
   mq+lDBaq6s16tXaIuBIt6xZaDIjzcTYYk2jvcBArDePCMqH3k65oof7ri
   IxsYZQ8qNMlkAClI+4MSxNClJZcdCXuFS08KiNVwd0XcxkSCSWOUOyTVx
   qnDXvKeltZpPLzJ0ifSng227lNHUEnYd8BkNWWJWWTre2+EzK8G2roBtN
   AfM7TUmRceDfkjMmtFJWfKGapw8B2pfPZSKsWKUz2x5PsC5cyaP0lbDGs
   g==;
X-CSE-ConnectionGUID: 8w6/T7P5QLqU+PCQMqg8pg==
X-CSE-MsgGUID: fVY7HYzyRIujHwzsGUqBLw==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="35180072"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="35180072"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 10:10:29 -0700
X-CSE-ConnectionGUID: 36ppDiJ0ROqN2gKE81F7ag==
X-CSE-MsgGUID: 2V+ttrCiSq+SXM7w0NvCzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="38204823"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 22 May 2024 10:10:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BCCC83D1; Wed, 22 May 2024 20:10:25 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v1 2/2] spi: Check if transfer is mapped before calling DMA sync APIs
Date: Wed, 22 May 2024 20:09:50 +0300
Message-ID: <20240522171018.3362521-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240522171018.3362521-1-andriy.shevchenko@linux.intel.com>
References: <20240522171018.3362521-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The resent update to remove the orig_nents checks revealed
that not all DMA sync backends can cope with the unallocated
SG list, while supplying orig_nents == 0 (the commit 861370f49ce4
("iommu/dma: force bouncing if the size is not cacheline-aligned"),
for example, makes that happen for the IOMMU case). It means
we have to check if the buffers are DMA mapped before trying
to sync them. Re-introduce that check in a form of calling
->can_dma() in the same way as it's done in the DMA mapping loop
for the SPI transfers.

Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
Closes: https://lore.kernel.org/r/8ae675b5-fcf9-4c9b-b06a-4462f70e1322@linaro.org
Closes: https://lore.kernel.org/all/d3679496-2e4e-4a7c-97ed-f193bd53af1d@notapiano
Fixes: 8cc3bad9d9d6 ("spi: Remove unneded check for orig_nents")
Suggested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 51811f04e463..cc8bb7d5ba1a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1311,7 +1311,7 @@ static int __spi_unmap_msg(struct spi_controller *ctlr, struct spi_message *msg)
 	return 0;
 }
 
-static void spi_dma_sync_for_device(struct spi_controller *ctlr,
+static void spi_dma_sync_for_device(struct spi_controller *ctlr, struct spi_message *msg,
 				    struct spi_transfer *xfer)
 {
 	struct device *rx_dev = ctlr->cur_rx_dma_dev;
@@ -1320,11 +1320,14 @@ static void spi_dma_sync_for_device(struct spi_controller *ctlr,
 	if (!ctlr->cur_msg_mapped)
 		return;
 
+	if (!ctlr->can_dma(ctlr, msg->spi, xfer))
+		return;
+
 	dma_sync_sgtable_for_device(tx_dev, &xfer->tx_sg, DMA_TO_DEVICE);
 	dma_sync_sgtable_for_device(rx_dev, &xfer->rx_sg, DMA_FROM_DEVICE);
 }
 
-static void spi_dma_sync_for_cpu(struct spi_controller *ctlr,
+static void spi_dma_sync_for_cpu(struct spi_controller *ctlr, struct spi_message *msg,
 				 struct spi_transfer *xfer)
 {
 	struct device *rx_dev = ctlr->cur_rx_dma_dev;
@@ -1333,6 +1336,9 @@ static void spi_dma_sync_for_cpu(struct spi_controller *ctlr,
 	if (!ctlr->cur_msg_mapped)
 		return;
 
+	if (!ctlr->can_dma(ctlr, msg->spi, xfer))
+		return;
+
 	dma_sync_sgtable_for_cpu(rx_dev, &xfer->rx_sg, DMA_FROM_DEVICE);
 	dma_sync_sgtable_for_cpu(tx_dev, &xfer->tx_sg, DMA_TO_DEVICE);
 }
@@ -1350,11 +1356,13 @@ static inline int __spi_unmap_msg(struct spi_controller *ctlr,
 }
 
 static void spi_dma_sync_for_device(struct spi_controller *ctrl,
+				    struct spi_message *msg,
 				    struct spi_transfer *xfer)
 {
 }
 
 static void spi_dma_sync_for_cpu(struct spi_controller *ctrl,
+				 struct spi_message *msg,
 				 struct spi_transfer *xfer)
 {
 }
@@ -1626,10 +1634,10 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 			reinit_completion(&ctlr->xfer_completion);
 
 fallback_pio:
-			spi_dma_sync_for_device(ctlr, xfer);
+			spi_dma_sync_for_device(ctlr, msg, xfer);
 			ret = ctlr->transfer_one(ctlr, msg->spi, xfer);
 			if (ret < 0) {
-				spi_dma_sync_for_cpu(ctlr, xfer);
+				spi_dma_sync_for_cpu(ctlr, msg, xfer);
 
 				if (ctlr->cur_msg_mapped &&
 				   (xfer->error & SPI_TRANS_FAIL_NO_START)) {
@@ -1654,7 +1662,7 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 					msg->status = ret;
 			}
 
-			spi_dma_sync_for_cpu(ctlr, xfer);
+			spi_dma_sync_for_cpu(ctlr, msg, xfer);
 		} else {
 			if (xfer->len)
 				dev_err(&msg->spi->dev,
-- 
2.43.0.rc1.1336.g36b5255a03ac


