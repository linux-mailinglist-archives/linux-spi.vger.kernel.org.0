Return-Path: <linux-spi+bounces-3190-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 803DE8D6A27
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 21:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82861F29466
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 19:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51F118398A;
	Fri, 31 May 2024 19:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XEmQpatw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D261C1822D5;
	Fri, 31 May 2024 19:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184857; cv=none; b=qZ8KGZQctoimzI8Mxi+RtzfnuMarWOolFgOvGGYzm5YD+zJBSwrT+bcEP0a5rGWfSjN77iBf8oVReiFvYt6tkhueQy7g0Ml/R+zixk0xZ5qNrDAcxUeBTjkWVS61Fk46GcI+V3fm1htrWvdun6huXcwc6m6Z8WbyYqpQyjtdhBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184857; c=relaxed/simple;
	bh=+Kmjinln59NpN7Q278lsMn6Hoz1SKSjg7Oeoq61MfdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KkSovhxZAZuYijZvyRhuqmaZ8dF+SfeWdeAXNfIADAKjykWydv0fs6zmEVs3q83rhZaqRfp3D/4LlRC0/0KrdVIh2WSmbhcno7M4oSlWJtdFrNY8qHTn29FciAO+pL4tvlFzpF0DNjJgJO0YADCauRdGQea881a2l5sqY+tBSes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XEmQpatw; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717184856; x=1748720856;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+Kmjinln59NpN7Q278lsMn6Hoz1SKSjg7Oeoq61MfdQ=;
  b=XEmQpatwKxEZJV4fMazxMj8UtQAeeeiodd0w+x6eV9xOYBuYMzeZg3Ij
   V/1jL2Ek+eTq1AjivV/pLmzchh+kkLpYK0e4A2QUuDzHpgw+32ph1eCDR
   dyU2bx7+2YdvuaXXeyBaRe334lQaKri8VAnEPmNoEis2Z3hVKiFvphLvu
   /6YfwYNXGgZbI6KU646gyA0dO41u8RtdUdBJHG9zakjgSG64qTadCG7yV
   fcgwezlfCwoZ2hblnF8ztqgPYJfBvJZS4vZGBRI9Ejyx5jd42gb1gzK80
   v7GQfsAjLPvE7ixm59ppaQDzas8Mli9sJeJpRP2xLh7daIUPIanXIVaFc
   w==;
X-CSE-ConnectionGUID: fmeG26a7R2eCuqoKxz4T6w==
X-CSE-MsgGUID: U6doNzo3QY2HDDB+MPCUmw==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="39144724"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="39144724"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 12:47:34 -0700
X-CSE-ConnectionGUID: hw1ymnlbQK28Dn858UKVUg==
X-CSE-MsgGUID: 3XTF4lsMS1inXn9dTvNUbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="67452632"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 31 May 2024 12:47:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5F60E6CB; Fri, 31 May 2024 22:47:25 +0300 (EEST)
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
Subject: [PATCH v1 8/8] spi: Rework per message DMA mapped flag to be per transfer
Date: Fri, 31 May 2024 22:42:40 +0300
Message-ID: <20240531194723.1761567-9-andriy.shevchenko@linux.intel.com>
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

The granularity of DMA mappings is transfer and moreover,
the direction is also important as it can be unidirect.

The current cur_msg_mapped flag doesn't fit well the DMA mapping
and syncing calls and we have tons of checks around on top of it.
So, instead of doing that rework the code to use per transfer per
direction flag to show if it's DMA mapped or not.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/internals.h |  2 +-
 drivers/spi/spi.c       | 73 +++++++++++++++--------------------------
 include/linux/spi/spi.h | 11 ++++---
 3 files changed, 35 insertions(+), 51 deletions(-)

diff --git a/drivers/spi/internals.h b/drivers/spi/internals.h
index 47a87c2a6979..1f459b895891 100644
--- a/drivers/spi/internals.h
+++ b/drivers/spi/internals.h
@@ -45,7 +45,7 @@ static inline bool spi_xfer_is_dma_mapped(struct spi_controller *ctlr,
 					  struct spi_transfer *xfer)
 {
 	return ctlr->can_dma && ctlr->can_dma(ctlr, spi, xfer) &&
-	       ctlr->cur_msg_mapped;
+	       (xfer->tx_sg_mapped || xfer->rx_sg_mapped);
 }
 
 #endif /* __LINUX_SPI_INTERNALS_H */
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c1e8cde426e5..9721adf048b5 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1220,11 +1220,6 @@ void spi_unmap_buf(struct spi_controller *ctlr, struct device *dev,
 	spi_unmap_buf_attrs(ctlr, dev, sgt, dir, 0);
 }
 
-/* Dummy SG for unidirect transfers */
-static struct scatterlist dummy_sg = {
-	.page_link = SG_END,
-};
-
 static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 {
 	struct device *tx_dev, *rx_dev;
@@ -1263,8 +1258,8 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 						attrs);
 			if (ret != 0)
 				return ret;
-		} else {
-			xfer->tx_sg.sgl = &dummy_sg;
+
+			xfer->tx_sg_mapped = true;
 		}
 
 		if (xfer->rx_buf != NULL) {
@@ -1278,8 +1273,8 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 
 				return ret;
 			}
-		} else {
-			xfer->rx_sg.sgl = &dummy_sg;
+
+			xfer->rx_sg_mapped = true;
 		}
 	}
 	/* No transfer has been mapped, bail out with success */
@@ -1288,7 +1283,6 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 
 	ctlr->cur_rx_dma_dev = rx_dev;
 	ctlr->cur_tx_dma_dev = tx_dev;
-	ctlr->cur_msg_mapped = true;
 
 	return 0;
 }
@@ -1299,57 +1293,46 @@ static int __spi_unmap_msg(struct spi_controller *ctlr, struct spi_message *msg)
 	struct device *tx_dev = ctlr->cur_tx_dma_dev;
 	struct spi_transfer *xfer;
 
-	if (!ctlr->cur_msg_mapped || !ctlr->can_dma)
-		return 0;
-
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		/* The sync has already been done after each transfer. */
 		unsigned long attrs = DMA_ATTR_SKIP_CPU_SYNC;
 
-		if (!ctlr->can_dma(ctlr, msg->spi, xfer))
-			continue;
+		if (xfer->rx_sg_mapped)
+			spi_unmap_buf_attrs(ctlr, rx_dev, &xfer->rx_sg,
+					    DMA_FROM_DEVICE, attrs);
+		xfer->rx_sg_mapped = false;
 
-		spi_unmap_buf_attrs(ctlr, rx_dev, &xfer->rx_sg,
-				    DMA_FROM_DEVICE, attrs);
-		spi_unmap_buf_attrs(ctlr, tx_dev, &xfer->tx_sg,
-				    DMA_TO_DEVICE, attrs);
+		if (xfer->tx_sg_mapped)
+			spi_unmap_buf_attrs(ctlr, tx_dev, &xfer->tx_sg,
+					    DMA_TO_DEVICE, attrs);
+		xfer->tx_sg_mapped = false;
 	}
 
-	ctlr->cur_msg_mapped = false;
-
 	return 0;
 }
 
-static void spi_dma_sync_for_device(struct spi_controller *ctlr, struct spi_message *msg,
+static void spi_dma_sync_for_device(struct spi_controller *ctlr,
 				    struct spi_transfer *xfer)
 {
 	struct device *rx_dev = ctlr->cur_rx_dma_dev;
 	struct device *tx_dev = ctlr->cur_tx_dma_dev;
 
-	if (!ctlr->cur_msg_mapped)
-		return;
-
-	if (!ctlr->can_dma(ctlr, msg->spi, xfer))
-		return;
-
-	dma_sync_sgtable_for_device(tx_dev, &xfer->tx_sg, DMA_TO_DEVICE);
-	dma_sync_sgtable_for_device(rx_dev, &xfer->rx_sg, DMA_FROM_DEVICE);
+	if (xfer->tx_sg_mapped)
+		dma_sync_sgtable_for_device(tx_dev, &xfer->tx_sg, DMA_TO_DEVICE);
+	if (xfer->rx_sg_mapped)
+		dma_sync_sgtable_for_device(rx_dev, &xfer->rx_sg, DMA_FROM_DEVICE);
 }
 
-static void spi_dma_sync_for_cpu(struct spi_controller *ctlr, struct spi_message *msg,
+static void spi_dma_sync_for_cpu(struct spi_controller *ctlr,
 				 struct spi_transfer *xfer)
 {
 	struct device *rx_dev = ctlr->cur_rx_dma_dev;
 	struct device *tx_dev = ctlr->cur_tx_dma_dev;
 
-	if (!ctlr->cur_msg_mapped)
-		return;
-
-	if (!ctlr->can_dma(ctlr, msg->spi, xfer))
-		return;
-
-	dma_sync_sgtable_for_cpu(rx_dev, &xfer->rx_sg, DMA_FROM_DEVICE);
-	dma_sync_sgtable_for_cpu(tx_dev, &xfer->tx_sg, DMA_TO_DEVICE);
+	if (xfer->rx_sg_mapped)
+		dma_sync_sgtable_for_cpu(rx_dev, &xfer->rx_sg, DMA_FROM_DEVICE);
+	if (xfer->tx_sg_mapped)
+		dma_sync_sgtable_for_cpu(tx_dev, &xfer->tx_sg, DMA_TO_DEVICE);
 }
 #else /* !CONFIG_HAS_DMA */
 static inline int __spi_map_msg(struct spi_controller *ctlr,
@@ -1365,13 +1348,11 @@ static inline int __spi_unmap_msg(struct spi_controller *ctlr,
 }
 
 static void spi_dma_sync_for_device(struct spi_controller *ctrl,
-				    struct spi_message *msg,
 				    struct spi_transfer *xfer)
 {
 }
 
 static void spi_dma_sync_for_cpu(struct spi_controller *ctrl,
-				 struct spi_message *msg,
 				 struct spi_transfer *xfer)
 {
 }
@@ -1643,13 +1624,13 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 			reinit_completion(&ctlr->xfer_completion);
 
 fallback_pio:
-			spi_dma_sync_for_device(ctlr, msg, xfer);
+			spi_dma_sync_for_device(ctlr, xfer);
 			ret = ctlr->transfer_one(ctlr, msg->spi, xfer);
 			if (ret < 0) {
-				spi_dma_sync_for_cpu(ctlr, msg, xfer);
+				spi_dma_sync_for_cpu(ctlr, xfer);
 
-				if (ctlr->cur_msg_mapped &&
-				   (xfer->error & SPI_TRANS_FAIL_NO_START)) {
+				if ((xfer->tx_sg_mapped || xfer->rx_sg_mapped) &&
+				    (xfer->error & SPI_TRANS_FAIL_NO_START)) {
 					__spi_unmap_msg(ctlr, msg);
 					ctlr->fallback = true;
 					xfer->error &= ~SPI_TRANS_FAIL_NO_START;
@@ -1671,7 +1652,7 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 					msg->status = ret;
 			}
 
-			spi_dma_sync_for_cpu(ctlr, msg, xfer);
+			spi_dma_sync_for_cpu(ctlr, xfer);
 		} else {
 			if (xfer->len)
 				dev_err(&msg->spi->dev,
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index eec7199bcda5..ea54ab10b914 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -448,7 +448,6 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  * @cur_msg_need_completion: Flag used internally to opportunistically skip
  *	the @cur_msg_completion. This flag is used to signal the context that
  *	is running spi_finalize_current_message() that it needs to complete()
- * @cur_msg_mapped: message has been mapped for DMA
  * @fallback: fallback to PIO if DMA transfer return failure with
  *	SPI_TRANS_FAIL_NO_START.
  * @last_cs_mode_high: was (mode & SPI_CS_HIGH) true on the last call to set_cs.
@@ -709,7 +708,6 @@ struct spi_controller {
 	bool				running;
 	bool				rt;
 	bool				auto_runtime_pm;
-	bool				cur_msg_mapped;
 	bool                            fallback;
 	bool				last_cs_mode_high;
 	s8				last_cs[SPI_CS_CNT_MAX];
@@ -982,6 +980,8 @@ struct spi_res {
  *      transfer this transfer. Set to 0 if the SPI bus driver does
  *      not support it.
  * @transfer_list: transfers are sequenced through @spi_message.transfers
+ * @tx_sg_mapped: If true, the @tx_sg is mapped for DMA
+ * @rx_sg_mapped: If true, the @rx_sg is mapped for DMA
  * @tx_sg: Scatterlist for transmit, currently not for client use
  * @rx_sg: Scatterlist for receive, currently not for client use
  * @ptp_sts_word_pre: The word (subject to bits_per_word semantics) offset
@@ -1078,10 +1078,13 @@ struct spi_transfer {
 #define SPI_TRANS_FAIL_IO	BIT(1)
 	u16		error;
 
-	dma_addr_t	tx_dma;
-	dma_addr_t	rx_dma;
+	bool		tx_sg_mapped;
+	bool		rx_sg_mapped;
+
 	struct sg_table tx_sg;
 	struct sg_table rx_sg;
+	dma_addr_t	tx_dma;
+	dma_addr_t	rx_dma;
 
 	unsigned	dummy_data:1;
 	unsigned	cs_off:1;
-- 
2.43.0.rc1.1336.g36b5255a03ac


