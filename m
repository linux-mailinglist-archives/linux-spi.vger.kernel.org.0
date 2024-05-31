Return-Path: <linux-spi+bounces-3170-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D728D5EBF
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 11:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065DF1F23648
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 09:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE8D1411DE;
	Fri, 31 May 2024 09:47:10 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811BD7C6EB
	for <linux-spi@vger.kernel.org>; Fri, 31 May 2024 09:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717148830; cv=none; b=r9CaDk1/tszdrWUFwajd26DJWxnq/jmbj3IvGxzvQ3e07Y9QfmlLFPa9p8nKVl2N2FAsv6faDHApqMmsY3roo3Su8bWS3JceQXRyN7zU2B3C1F3wA6ZGCNNJw9HjRIG+N4EXMVm6CR4Rn+JxcNxLfF+BWRlUM/pDFTm0KcIlcsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717148830; c=relaxed/simple;
	bh=/99r5c/7PncboE8HWq5Nz4/RRTHU8owjFX7NP8sLQo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oCSMC27lRdQA4304vKCwkWKblpVEEFG7IeskFNfT9ovgoZPrhoXu+CGUGPOjxMxlV3lXBkVQ3swZHfomKnNMz5WNmD0Axql4l5sbl5NZ5WrPLbinII7m5pSmM9eZ7B4Nqs3Zs5F9Yut8HWwREieeGysC69pbAthX6JCGH8A4IZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id ba26c4d2-1f32-11ef-8e32-005056bdf889;
	Fri, 31 May 2024 12:47:00 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 1/2] spi: Revert "Check if transfer is mapped before calling DMA sync APIs"
Date: Fri, 31 May 2024 12:44:32 +0300
Message-ID: <20240531094658.1598969-2-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531094658.1598969-1-andy.shevchenko@gmail.com>
References: <20240531094658.1598969-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit da560097c05612f8d360f86528f6213629b9c395.

It makes no difference as it was mistakenly thought that it fixes
a bug while another unnoticed change have been preserved in the
tester's repositorory.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/spi/spi.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9bc9fd10d538..43cd3e5bccbe 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1320,7 +1320,7 @@ static int __spi_unmap_msg(struct spi_controller *ctlr, struct spi_message *msg)
 	return 0;
 }
 
-static void spi_dma_sync_for_device(struct spi_controller *ctlr, struct spi_message *msg,
+static void spi_dma_sync_for_device(struct spi_controller *ctlr,
 				    struct spi_transfer *xfer)
 {
 	struct device *rx_dev = ctlr->cur_rx_dma_dev;
@@ -1329,14 +1329,11 @@ static void spi_dma_sync_for_device(struct spi_controller *ctlr, struct spi_mess
 	if (!ctlr->cur_msg_mapped)
 		return;
 
-	if (!ctlr->can_dma(ctlr, msg->spi, xfer))
-		return;
-
 	dma_sync_sgtable_for_device(tx_dev, &xfer->tx_sg, DMA_TO_DEVICE);
 	dma_sync_sgtable_for_device(rx_dev, &xfer->rx_sg, DMA_FROM_DEVICE);
 }
 
-static void spi_dma_sync_for_cpu(struct spi_controller *ctlr, struct spi_message *msg,
+static void spi_dma_sync_for_cpu(struct spi_controller *ctlr,
 				 struct spi_transfer *xfer)
 {
 	struct device *rx_dev = ctlr->cur_rx_dma_dev;
@@ -1345,9 +1342,6 @@ static void spi_dma_sync_for_cpu(struct spi_controller *ctlr, struct spi_message
 	if (!ctlr->cur_msg_mapped)
 		return;
 
-	if (!ctlr->can_dma(ctlr, msg->spi, xfer))
-		return;
-
 	dma_sync_sgtable_for_cpu(rx_dev, &xfer->rx_sg, DMA_FROM_DEVICE);
 	dma_sync_sgtable_for_cpu(tx_dev, &xfer->tx_sg, DMA_TO_DEVICE);
 }
@@ -1365,13 +1359,11 @@ static inline int __spi_unmap_msg(struct spi_controller *ctlr,
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
@@ -1643,10 +1635,10 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 			reinit_completion(&ctlr->xfer_completion);
 
 fallback_pio:
-			spi_dma_sync_for_device(ctlr, msg, xfer);
+			spi_dma_sync_for_device(ctlr, xfer);
 			ret = ctlr->transfer_one(ctlr, msg->spi, xfer);
 			if (ret < 0) {
-				spi_dma_sync_for_cpu(ctlr, msg, xfer);
+				spi_dma_sync_for_cpu(ctlr, xfer);
 
 				if (ctlr->cur_msg_mapped &&
 				   (xfer->error & SPI_TRANS_FAIL_NO_START)) {
@@ -1671,7 +1663,7 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 					msg->status = ret;
 			}
 
-			spi_dma_sync_for_cpu(ctlr, msg, xfer);
+			spi_dma_sync_for_cpu(ctlr, xfer);
 		} else {
 			if (xfer->len)
 				dev_err(&msg->spi->dev,
-- 
2.45.1


