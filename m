Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2260A175153
	for <lists+linux-spi@lfdr.de>; Mon,  2 Mar 2020 01:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgCBAUR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 1 Mar 2020 19:20:17 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54965 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgCBAUO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 1 Mar 2020 19:20:14 -0500
Received: by mail-wm1-f65.google.com with SMTP id z12so9246222wmi.4;
        Sun, 01 Mar 2020 16:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oe4/r/Ihf536bf65zMehktueX+HtF+9YKxTAgCkGQUU=;
        b=AoQttv0FKsFTm50psNF5ZjZ3cdtt2uJw/O6HK7OWBGLU3RGZEJqOV0gsyrJlwHDuVW
         eK5yQfIbmEokMJKiI61JKYqwfy1CVCYes+1EAVLLLVNwZOeI0qB+FOddryMkfB6rIR+0
         bkrZsvAZhawCuuGsXMqY8wBE6OjTc2kCHuosVVOixF+96IeVFggorA+h4HgRYBOFe1jV
         USzj21Q2PDWePBysc9rL9btMwq2O5k77vG70vuQCRUkVWzXz0TsFA/AJC3DqNmJQRnjx
         9wcAgYwro0X1EbR3YqNwvllw5+9SLQftcJaj9hlljY4R8hInvOFFHGbrHcAGJ1BBGKdf
         BMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oe4/r/Ihf536bf65zMehktueX+HtF+9YKxTAgCkGQUU=;
        b=PF4XhsOahBqYm8EJA4hIlB+rhwcbIgh+Fl44IS0Xj9PgLlzUsBt8EMk9Xn+cxRmMIh
         Kq557YOOayzvZ+OZovgr980VK1O0yf4LC4hi4CONATu2RKDDKe2BJJnkuwVUxdg/VVIr
         RsHjoZP1jOZnSuV9SZH85NqOqHN2V0j+j02agcgeHXCnUZum7nuzy18nL1Qc52X3/g6A
         pr7X0HJ8+qxFOzM+vNGLcdDN+4a+Cka+46tPL8kKr5m7mCqX3e2FO/UDjAVDQ5w+1w0j
         R4XbkR3/SzihQ2ACN8Wf4BKPttMyOZex3+Ge7aCMtBfOh7gaYVoeB1zdhbFtXt4JwBkN
         mCFA==
X-Gm-Message-State: APjAAAUi5J2jwhsF2YzRg2mQmBXNDWSonZ5NbfXf+cqmRvVsP2kycLXe
        stwZDOG4RV9iU5iNVtrQdWBfQy65
X-Google-Smtp-Source: APXvYqxd43AIoWz2Bba+cNQTbMV7bKpB2f0fz5wtXeruALbOHWmPk2O0YF03UVLb9SPkMAC/gwRitA==
X-Received: by 2002:a7b:c5d9:: with SMTP id n25mr17259202wmk.65.1583108412649;
        Sun, 01 Mar 2020 16:20:12 -0800 (PST)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id k16sm25428417wrd.17.2020.03.01.16.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 16:20:12 -0800 (PST)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] spi: spi-fsl-dspi: Parameterize the FIFO size and DMA buffer size
Date:   Mon,  2 Mar 2020 02:19:55 +0200
Message-Id: <20200302001958.11105-4-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200302001958.11105-1-olteanv@gmail.com>
References: <20200302001958.11105-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Get rid of the ifdef for Coldfire and make these hardware
characteristics part of dspi->devtype_data.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 48 ++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 021c658886d4..55ccb3d0f683 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -20,13 +20,6 @@
 
 #define DRIVER_NAME			"fsl-dspi"
 
-#ifdef CONFIG_M5441x
-#define DSPI_FIFO_SIZE			16
-#else
-#define DSPI_FIFO_SIZE			4
-#endif
-#define DSPI_DMA_BUFSIZE		(DSPI_FIFO_SIZE * 1024)
-
 #define SPI_MCR				0x00
 #define SPI_MCR_MASTER			BIT(31)
 #define SPI_MCR_PCSIS			(0x3F << 16)
@@ -131,6 +124,8 @@ struct fsl_dspi_devtype_data {
 	u8			max_clock_factor;
 	bool			ptp_sts_supported;
 	bool			xspi_mode;
+	int			fifo_size;
+	int			dma_bufsize;
 };
 
 enum {
@@ -149,54 +144,64 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 	[VF610] = {
 		.trans_mode		= DSPI_DMA_MODE,
 		.max_clock_factor	= 2,
+		.dma_bufsize		= 4096,
+		.fifo_size		= 4,
 	},
 	[LS1021A] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
 		.ptp_sts_supported	= true,
 		.xspi_mode		= true,
+		.fifo_size		= 4,
 	},
 	[LS1012A] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
 		.ptp_sts_supported	= true,
 		.xspi_mode		= true,
+		.fifo_size		= 16,
 	},
 	[LS1043A] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
 		.ptp_sts_supported	= true,
 		.xspi_mode		= true,
+		.fifo_size		= 16,
 	},
 	[LS1046A] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
 		.ptp_sts_supported	= true,
 		.xspi_mode		= true,
+		.fifo_size		= 16,
 	},
 	[LS2080A] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
 		.ptp_sts_supported	= true,
+		.fifo_size		= 4,
 	},
 	[LS2085A] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
 		.ptp_sts_supported	= true,
+		.fifo_size		= 4,
 	},
 	[LX2160A] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
 		.ptp_sts_supported	= true,
+		.fifo_size		= 4,
 	},
 	[MCF5441X] = {
 		.trans_mode		= DSPI_EOQ_MODE,
 		.max_clock_factor	= 8,
+		.fifo_size		= 16,
 	},
 };
 
 struct fsl_dspi_dma {
-	/* Length of transfer in words of DSPI_FIFO_SIZE */
+	/* Length of transfer in words of dspi->fifo_size */
 	u32					curr_xfer_len;
 
 	u32					*tx_dma_buf;
@@ -397,7 +402,8 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
 	int ret = 0;
 
 	curr_remaining_bytes = dspi->len;
-	bytes_per_buffer = DSPI_DMA_BUFSIZE / DSPI_FIFO_SIZE;
+	bytes_per_buffer = dspi->devtype_data->dma_bufsize /
+			   dspi->devtype_data->fifo_size;
 	while (curr_remaining_bytes) {
 		/* Check if current transfer fits the DMA buffer */
 		dma->curr_xfer_len = curr_remaining_bytes
@@ -449,14 +455,14 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 		goto err_tx_channel;
 	}
 
-	dma->tx_dma_buf = dma_alloc_coherent(dev, DSPI_DMA_BUFSIZE,
+	dma->tx_dma_buf = dma_alloc_coherent(dev, dspi->devtype_data->dma_bufsize,
 					     &dma->tx_dma_phys, GFP_KERNEL);
 	if (!dma->tx_dma_buf) {
 		ret = -ENOMEM;
 		goto err_tx_dma_buf;
 	}
 
-	dma->rx_dma_buf = dma_alloc_coherent(dev, DSPI_DMA_BUFSIZE,
+	dma->rx_dma_buf = dma_alloc_coherent(dev, dspi->devtype_data->dma_bufsize,
 					     &dma->rx_dma_phys, GFP_KERNEL);
 	if (!dma->rx_dma_buf) {
 		ret = -ENOMEM;
@@ -493,11 +499,11 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 	return 0;
 
 err_slave_config:
-	dma_free_coherent(dev, DSPI_DMA_BUFSIZE,
-			dma->rx_dma_buf, dma->rx_dma_phys);
+	dma_free_coherent(dev, dspi->devtype_data->dma_bufsize,
+			  dma->rx_dma_buf, dma->rx_dma_phys);
 err_rx_dma_buf:
-	dma_free_coherent(dev, DSPI_DMA_BUFSIZE,
-			dma->tx_dma_buf, dma->tx_dma_phys);
+	dma_free_coherent(dev, dspi->devtype_data->dma_bufsize,
+			  dma->tx_dma_buf, dma->tx_dma_phys);
 err_tx_dma_buf:
 	dma_release_channel(dma->chan_tx);
 err_tx_channel:
@@ -519,13 +525,15 @@ static void dspi_release_dma(struct fsl_dspi *dspi)
 
 	if (dma->chan_tx) {
 		dma_unmap_single(dev, dma->tx_dma_phys,
-				 DSPI_DMA_BUFSIZE, DMA_TO_DEVICE);
+				 dspi->devtype_data->dma_bufsize,
+				 DMA_TO_DEVICE);
 		dma_release_channel(dma->chan_tx);
 	}
 
 	if (dma->chan_rx) {
 		dma_unmap_single(dev, dma->rx_dma_phys,
-				 DSPI_DMA_BUFSIZE, DMA_FROM_DEVICE);
+				 dspi->devtype_data->dma_bufsize,
+				 DMA_FROM_DEVICE);
 		dma_release_channel(dma->chan_rx);
 	}
 }
@@ -657,7 +665,7 @@ static void dspi_tcfq_read(struct fsl_dspi *dspi)
 
 static void dspi_eoq_write(struct fsl_dspi *dspi)
 {
-	int fifo_size = DSPI_FIFO_SIZE;
+	int fifo_size = dspi->devtype_data->fifo_size;
 	u16 xfer_cmd = dspi->tx_cmd;
 
 	/* Fill TX FIFO with as many transfers as possible */
@@ -667,7 +675,7 @@ static void dspi_eoq_write(struct fsl_dspi *dspi)
 		if (dspi->len == dspi->bytes_per_word || fifo_size == 0)
 			dspi->tx_cmd |= SPI_PUSHR_CMD_EOQ;
 		/* Clear transfer count for first transfer in FIFO */
-		if (fifo_size == (DSPI_FIFO_SIZE - 1))
+		if (fifo_size == (dspi->devtype_data->fifo_size - 1))
 			dspi->tx_cmd |= SPI_PUSHR_CMD_CTCNT;
 		/* Write combined TX FIFO and CMD FIFO entry */
 		fifo_write(dspi);
@@ -676,7 +684,7 @@ static void dspi_eoq_write(struct fsl_dspi *dspi)
 
 static void dspi_eoq_read(struct fsl_dspi *dspi)
 {
-	int fifo_size = DSPI_FIFO_SIZE;
+	int fifo_size = dspi->devtype_data->fifo_size;
 
 	/* Read one FIFO entry and push to rx buffer */
 	while ((dspi->rx < dspi->rx_end) && fifo_size--)
-- 
2.17.1

