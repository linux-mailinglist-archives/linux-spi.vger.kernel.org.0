Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3881FF5D52
	for <lists+linux-spi@lfdr.de>; Sat,  9 Nov 2019 05:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfKIESB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Nov 2019 23:18:01 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36062 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfKIESB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Nov 2019 23:18:01 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA94HwI5068334;
        Fri, 8 Nov 2019 22:17:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573273078;
        bh=BcLZxjKCYy7idf+cwghwWhjBpSuGjAGVoOYlDIaxvzU=;
        h=From:To:CC:Subject:Date;
        b=gcAA41+IzzX6zI0mKXErMDaY51m0A/al4QEGy5pgcU/Ov4avi81bO9BmwBS2KXy8F
         8fmPNG9ZPtHEPNw0u8EkU6u+TpAcOnMwR+jepLZPzmYodzgVu0UQoAaVDg8og6Lfu8
         6aMkal6tb5wwRPsRcnpL/jcGYNNESxYQa8T5bwMs=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xA94Hwnt128669
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Nov 2019 22:17:58 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 8 Nov
 2019 22:17:42 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 8 Nov 2019 22:17:42 -0600
Received: from a0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA94HuN7119007;
        Fri, 8 Nov 2019 22:17:56 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH] spi: omap2-mcspi: Remove redundant checks
Date:   Sat, 9 Nov 2019 09:48:27 +0530
Message-ID: <20191109041827.26934-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Both omap2_mcspi_tx_dma() and omap2_mcspi_rx_dma() are only called from
omap2_mcspi_txrx_dma() and omap2_mcspi_txrx_dma() is always called after
making sure that mcspi_dma->dma_rx and mcspi_dma->dma_tx are not NULL
(see omap2_mcspi_transfer_one()).
Therefore remove redundant NULL checks for omap2_mcspi->dma_tx and
omap2_mcspi->dma_rx pointers in omap2_mcspi_tx_dma() and
omap2_mcspi_rx_dma() respectively.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/spi/spi-omap2-mcspi.c | 105 +++++++++++++++-------------------
 1 file changed, 47 insertions(+), 58 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 848e03e5f42d..7e2292c11d12 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -397,30 +397,26 @@ static void omap2_mcspi_tx_dma(struct spi_device *spi,
 {
 	struct omap2_mcspi	*mcspi;
 	struct omap2_mcspi_dma  *mcspi_dma;
+	struct dma_async_tx_descriptor *tx;
 
 	mcspi = spi_master_get_devdata(spi->master);
 	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
 
-	if (mcspi_dma->dma_tx) {
-		struct dma_async_tx_descriptor *tx;
+	dmaengine_slave_config(mcspi_dma->dma_tx, &cfg);
 
-		dmaengine_slave_config(mcspi_dma->dma_tx, &cfg);
-
-		tx = dmaengine_prep_slave_sg(mcspi_dma->dma_tx, xfer->tx_sg.sgl,
-					     xfer->tx_sg.nents,
-					     DMA_MEM_TO_DEV,
-					     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-		if (tx) {
-			tx->callback = omap2_mcspi_tx_callback;
-			tx->callback_param = spi;
-			dmaengine_submit(tx);
-		} else {
-			/* FIXME: fall back to PIO? */
-		}
+	tx = dmaengine_prep_slave_sg(mcspi_dma->dma_tx, xfer->tx_sg.sgl,
+				     xfer->tx_sg.nents,
+				     DMA_MEM_TO_DEV,
+				     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (tx) {
+		tx->callback = omap2_mcspi_tx_callback;
+		tx->callback_param = spi;
+		dmaengine_submit(tx);
+	} else {
+		/* FIXME: fall back to PIO? */
 	}
 	dma_async_issue_pending(mcspi_dma->dma_tx);
 	omap2_mcspi_set_dma_req(spi, 0, 1);
-
 }
 
 static unsigned
@@ -439,6 +435,7 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 	int			word_len, element_count;
 	struct omap2_mcspi_cs	*cs = spi->controller_state;
 	void __iomem		*chstat_reg = cs->base + OMAP2_MCSPI_CHSTAT0;
+	struct dma_async_tx_descriptor *tx;
 
 	mcspi = spi_master_get_devdata(spi->master);
 	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
@@ -462,55 +459,47 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 	else /* word_len <= 32 */
 		element_count = count >> 2;
 
-	if (mcspi_dma->dma_rx) {
-		struct dma_async_tx_descriptor *tx;
 
-		dmaengine_slave_config(mcspi_dma->dma_rx, &cfg);
+	dmaengine_slave_config(mcspi_dma->dma_rx, &cfg);
 
+	/*
+	 *  Reduce DMA transfer length by one more if McSPI is
+	 *  configured in turbo mode.
+	 */
+	if ((l & OMAP2_MCSPI_CHCONF_TURBO) && mcspi->fifo_depth == 0)
+		transfer_reduction += es;
+
+	if (transfer_reduction) {
+		/* Split sgl into two. The second sgl won't be used. */
+		sizes[0] = count - transfer_reduction;
+		sizes[1] = transfer_reduction;
+		nb_sizes = 2;
+	} else {
 		/*
-		 *  Reduce DMA transfer length by one more if McSPI is
-		 *  configured in turbo mode.
+		 * Don't bother splitting the sgl. This essentially
+		 * clones the original sgl.
 		 */
-		if ((l & OMAP2_MCSPI_CHCONF_TURBO) && mcspi->fifo_depth == 0)
-			transfer_reduction += es;
-
-		if (transfer_reduction) {
-			/* Split sgl into two. The second sgl won't be used. */
-			sizes[0] = count - transfer_reduction;
-			sizes[1] = transfer_reduction;
-			nb_sizes = 2;
-		} else {
-			/*
-			 * Don't bother splitting the sgl. This essentially
-			 * clones the original sgl.
-			 */
-			sizes[0] = count;
-			nb_sizes = 1;
-		}
+		sizes[0] = count;
+		nb_sizes = 1;
+	}
 
-		ret = sg_split(xfer->rx_sg.sgl, xfer->rx_sg.nents,
-			       0, nb_sizes,
-			       sizes,
-			       sg_out, out_mapped_nents,
-			       GFP_KERNEL);
+	ret = sg_split(xfer->rx_sg.sgl, xfer->rx_sg.nents, 0, nb_sizes,
+		       sizes, sg_out, out_mapped_nents, GFP_KERNEL);
 
-		if (ret < 0) {
-			dev_err(&spi->dev, "sg_split failed\n");
-			return 0;
-		}
+	if (ret < 0) {
+		dev_err(&spi->dev, "sg_split failed\n");
+		return 0;
+	}
 
-		tx = dmaengine_prep_slave_sg(mcspi_dma->dma_rx,
-					     sg_out[0],
-					     out_mapped_nents[0],
-					     DMA_DEV_TO_MEM,
-					     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-		if (tx) {
-			tx->callback = omap2_mcspi_rx_callback;
-			tx->callback_param = spi;
-			dmaengine_submit(tx);
-		} else {
-				/* FIXME: fall back to PIO? */
-		}
+	tx = dmaengine_prep_slave_sg(mcspi_dma->dma_rx, sg_out[0],
+				     out_mapped_nents[0], DMA_DEV_TO_MEM,
+				     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (tx) {
+		tx->callback = omap2_mcspi_rx_callback;
+		tx->callback_param = spi;
+		dmaengine_submit(tx);
+	} else {
+		/* FIXME: fall back to PIO? */
 	}
 
 	dma_async_issue_pending(mcspi_dma->dma_rx);
-- 
2.24.0

