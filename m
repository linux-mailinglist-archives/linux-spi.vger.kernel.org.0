Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16FC617FD21
	for <lists+linux-spi@lfdr.de>; Tue, 10 Mar 2020 14:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbgCJM4B (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Mar 2020 08:56:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55179 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbgCJM4A (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Mar 2020 08:56:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id n8so1273847wmc.4;
        Tue, 10 Mar 2020 05:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uB7g92zSkyc4Tyrv/IlzK5Cjo/ddDsP0TZyadbno/Zs=;
        b=eo1lo0gKBnsvDHxgStrGIkqtGTP/q7vSn9rg+GGvsDw6vH4kSQ0D8Cv8nD5fCbWkxX
         LkDLwhl+2GLmNUUVu0maS+50QpH/2WNZza5OnzcFk13MSRFbazJc2dKqcVYiptzUmXVK
         d8rjnS59LmlNwh1odB0MAG5FeHjki0RhYeLPAJvnX25uVtz1a81UEU5DC7/6CNHVsTEE
         VzuIL5EMBIXPZkRunhkAsXLH4V2tyjxyPhQeDLvG5oo7SUtul3ktYUG4bEm9aWtyFCF2
         ZkWkVmgqsO+3ZqCq4F/uJ7S4OFoVBr3lwZlbSPWVHBdGQCyln6GnSYr6jl4rv8EzMPbL
         FyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uB7g92zSkyc4Tyrv/IlzK5Cjo/ddDsP0TZyadbno/Zs=;
        b=S14D/CCjgMFUgPg4skSsjFMii6TQp0oHgEg0DeiFVBjHcnV6vHDs6Z9l3iYuRvK0fX
         qTzqdxbJnxbjWopQcDaZ0qEm6OuN+XVtm16FEYJo7PU6SWcJnDVXAUbz76M3YzwUBTR3
         0hy8uYCyCbGkKq6igva7xtcEC7BGjpEYH7bLxpAc4fVnPNZSSSTAImEhyOK/oMRNuFFF
         5Ly3FerIQdZ5r/1fXkF5/t4JaaAnHyBI8ucTgie53n8dWL9Gfxlkhy3SuS+AH2W8Z17R
         KWyUcUWPucglSnTQ+jSOCZRRa5n/u+ckOkSDg5oRWypGLHELbUrl2OGpvce1AUOCqP5S
         hhGA==
X-Gm-Message-State: ANhLgQ0Vsw/gq6zzfi+cqZPBpZq5MwYVLAPexrD21izDfBBIgqh/LFbn
        9S9Ezfk0z6jn0O278TIWy0E7ziUtOAk=
X-Google-Smtp-Source: ADFU+vuhmnR9pAQBOTGsK/B+rEMl1zK1w8TAzrBYjiyeKZ9qBtGblqtfVv39BW0tJutHBhRbXRswjg==
X-Received: by 2002:a05:600c:350:: with SMTP id u16mr2056964wmd.168.1583844955860;
        Tue, 10 Mar 2020 05:55:55 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id t81sm4018594wmb.15.2020.03.10.05.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 05:55:55 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v3 4/7] spi: spi-fsl-dspi: Fix bits-per-word acceleration in DMA mode
Date:   Tue, 10 Mar 2020 14:55:39 +0200
Message-Id: <20200310125542.5939-5-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310125542.5939-1-olteanv@gmail.com>
References: <20200310125542.5939-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

In DMA mode, dspi_setup_accel does not get called, which results in the
dspi->oper_word_size variable (which is used by dspi_dma_xfer) to not be
initialized properly.

Because oper_word_size is zero, a few calculations end up being
incorrect, and the DMA transfer eventually times out instead of sending
anything on the wire.

Set up native transfers (or 8-on-16 acceleration) using dspi_setup_accel
for DMA mode too.

Also take the opportunity and simplify the DMA buffer handling a little
bit.

Fixes: 6c1c26ecd9a3 ("spi: spi-fsl-dspi: Accelerate transfers using larger word size if possible")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v3:
Pretty much re-did the patch. Before, dspi_setup_accel was called just
once at the beginning of dspi_dma_xfer. Now it is called in the while
loop. Everything else is just refactoring that follows along.

Changes in v2:
None.

 drivers/spi/spi-fsl-dspi.c | 7 +++++--
 drivers/spi/spi-fsl-dspi.c | 83 +++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 41 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index c59b68592283..8f5d18dc78d5 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -119,7 +119,6 @@ struct fsl_dspi_devtype_data {
 	enum dspi_trans_mode	trans_mode;
 	u8			max_clock_factor;
 	int			fifo_size;
-	int			dma_bufsize;
 };
 
 enum {
@@ -138,7 +137,6 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 	[VF610] = {
 		.trans_mode		= DSPI_DMA_MODE,
 		.max_clock_factor	= 2,
-		.dma_bufsize		= 4096,
 		.fifo_size		= 4,
 	},
 	[LS1021A] = {
@@ -167,19 +165,16 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 	},
 	[LS2080A] = {
 		.trans_mode		= DSPI_DMA_MODE,
-		.dma_bufsize		= 8,
 		.max_clock_factor	= 8,
 		.fifo_size		= 4,
 	},
 	[LS2085A] = {
 		.trans_mode		= DSPI_DMA_MODE,
-		.dma_bufsize		= 8,
 		.max_clock_factor	= 8,
 		.fifo_size		= 4,
 	},
 	[LX2160A] = {
 		.trans_mode		= DSPI_DMA_MODE,
-		.dma_bufsize		= 8,
 		.max_clock_factor	= 8,
 		.fifo_size		= 4,
 	},
@@ -191,9 +186,6 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 };
 
 struct fsl_dspi_dma {
-	/* Length of transfer in words of dspi->fifo_size */
-	u32					curr_xfer_len;
-
 	u32					*tx_dma_buf;
 	struct dma_chan				*chan_tx;
 	dma_addr_t				tx_dma_phys;
@@ -352,7 +344,7 @@ static void dspi_rx_dma_callback(void *arg)
 	int i;
 
 	if (dspi->rx) {
-		for (i = 0; i < dma->curr_xfer_len; i++)
+		for (i = 0; i < dspi->words_in_flight; i++)
 			dspi_push_rx(dspi, dspi->dma->rx_dma_buf[i]);
 	}
 
@@ -366,12 +358,12 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 	int time_left;
 	int i;
 
-	for (i = 0; i < dma->curr_xfer_len; i++)
+	for (i = 0; i < dspi->words_in_flight; i++)
 		dspi->dma->tx_dma_buf[i] = dspi_pop_tx_pushr(dspi);
 
 	dma->tx_desc = dmaengine_prep_slave_single(dma->chan_tx,
 					dma->tx_dma_phys,
-					dma->curr_xfer_len *
+					dspi->words_in_flight *
 					DMA_SLAVE_BUSWIDTH_4_BYTES,
 					DMA_MEM_TO_DEV,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
@@ -389,7 +381,7 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 
 	dma->rx_desc = dmaengine_prep_slave_single(dma->chan_rx,
 					dma->rx_dma_phys,
-					dma->curr_xfer_len *
+					dspi->words_in_flight *
 					DMA_SLAVE_BUSWIDTH_4_BYTES,
 					DMA_DEV_TO_MEM,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
@@ -437,46 +429,56 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 	return 0;
 }
 
+static void dspi_setup_accel(struct fsl_dspi *dspi);
+
 static int dspi_dma_xfer(struct fsl_dspi *dspi)
 {
 	struct spi_message *message = dspi->cur_msg;
 	struct device *dev = &dspi->pdev->dev;
-	struct fsl_dspi_dma *dma = dspi->dma;
-	int curr_remaining_bytes;
-	int bytes_per_buffer;
+	int bytes_in_flight = dspi->len;
+	int chunk_size;
 	int ret = 0;
 
-	curr_remaining_bytes = dspi->len;
-	bytes_per_buffer = dspi->devtype_data->dma_bufsize /
-			   dspi->devtype_data->fifo_size;
-	while (curr_remaining_bytes) {
+	/*
+	 * dspi->len gets decremented by dspi_pop_tx_pushr in
+	 * dspi_next_xfer_dma_submit
+	 */
+	while (dspi->len) {
+		/* Figure out operational bits-per-word for this chunk */
+		dspi_setup_accel(dspi);
+
+		/*
+		 * If the 16-bit TXDATA of the PUSHR is underutilized, then
+		 * each DMA buffer will be able to hold only up to fifo_size
+		 * useful bytes.
+		 */
+		if (dspi->oper_word_size == 1)
+			chunk_size = dspi->devtype_data->fifo_size;
+		else
+			chunk_size = dspi->devtype_data->fifo_size * 2;
+
 		/* Check if current transfer fits the DMA buffer */
-		dma->curr_xfer_len = curr_remaining_bytes /
-				     dspi->oper_word_size;
-		if (dma->curr_xfer_len > bytes_per_buffer)
-			dma->curr_xfer_len = bytes_per_buffer;
+		bytes_in_flight = dspi->len;
+		if (bytes_in_flight > chunk_size)
+			bytes_in_flight = chunk_size;
+
+		dspi->words_in_flight = bytes_in_flight / dspi->oper_word_size;
 
 		ret = dspi_next_xfer_dma_submit(dspi);
 		if (ret) {
 			dev_err(dev, "DMA transfer failed\n");
-			goto exit;
-
-		} else {
-			const int len = dma->curr_xfer_len *
-					dspi->oper_word_size;
-			curr_remaining_bytes -= len;
-			message->actual_length += len;
-			if (curr_remaining_bytes < 0)
-				curr_remaining_bytes = 0;
+			break;
 		}
+
+		message->actual_length += bytes_in_flight;
 	}
 
-exit:
 	return ret;
 }
 
 static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 {
+	int dma_bufsize = dspi->devtype_data->fifo_size * 2;
 	struct device *dev = &dspi->pdev->dev;
 	struct dma_slave_config cfg;
 	struct fsl_dspi_dma *dma;
@@ -500,14 +502,14 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 		goto err_tx_channel;
 	}
 
-	dma->tx_dma_buf = dma_alloc_coherent(dev, dspi->devtype_data->dma_bufsize,
+	dma->tx_dma_buf = dma_alloc_coherent(dev, dma_bufsize,
 					     &dma->tx_dma_phys, GFP_KERNEL);
 	if (!dma->tx_dma_buf) {
 		ret = -ENOMEM;
 		goto err_tx_dma_buf;
 	}
 
-	dma->rx_dma_buf = dma_alloc_coherent(dev, dspi->devtype_data->dma_bufsize,
+	dma->rx_dma_buf = dma_alloc_coherent(dev, dma_bufsize,
 					     &dma->rx_dma_phys, GFP_KERNEL);
 	if (!dma->rx_dma_buf) {
 		ret = -ENOMEM;
@@ -544,10 +546,10 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 	return 0;
 
 err_slave_config:
-	dma_free_coherent(dev, dspi->devtype_data->dma_bufsize,
+	dma_free_coherent(dev, dma_bufsize,
 			  dma->rx_dma_buf, dma->rx_dma_phys);
 err_rx_dma_buf:
-	dma_free_coherent(dev, dspi->devtype_data->dma_bufsize,
+	dma_free_coherent(dev, dma_bufsize,
 			  dma->tx_dma_buf, dma->tx_dma_phys);
 err_tx_dma_buf:
 	dma_release_channel(dma->chan_tx);
@@ -562,6 +564,7 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 
 static void dspi_release_dma(struct fsl_dspi *dspi)
 {
+	int dma_bufsize = dspi->devtype_data->fifo_size * 2;
 	struct fsl_dspi_dma *dma = dspi->dma;
 	struct device *dev = &dspi->pdev->dev;
 
@@ -570,15 +573,13 @@ static void dspi_release_dma(struct fsl_dspi *dspi)
 
 	if (dma->chan_tx) {
 		dma_unmap_single(dev, dma->tx_dma_phys,
-				 dspi->devtype_data->dma_bufsize,
-				 DMA_TO_DEVICE);
+				 dma_bufsize, DMA_TO_DEVICE);
 		dma_release_channel(dma->chan_tx);
 	}
 
 	if (dma->chan_rx) {
 		dma_unmap_single(dev, dma->rx_dma_phys,
-				 dspi->devtype_data->dma_bufsize,
-				 DMA_FROM_DEVICE);
+				 dma_bufsize, DMA_FROM_DEVICE);
 		dma_release_channel(dma->chan_rx);
 	}
 }
-- 
2.17.1

