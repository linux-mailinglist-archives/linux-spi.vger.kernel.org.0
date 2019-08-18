Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09F8991893
	for <lists+linux-spi@lfdr.de>; Sun, 18 Aug 2019 20:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfHRSB0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 18 Aug 2019 14:01:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37226 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfHRSBZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 18 Aug 2019 14:01:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id z11so6358963wrt.4
        for <linux-spi@vger.kernel.org>; Sun, 18 Aug 2019 11:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lJ1JReAkepthxrDOjoe1RbJQyd30ipILAmuR0rRV1gc=;
        b=cAo5Vcc0MtgnKPUUhozD6o5meSltqUgxVehNhrnU7YPePJJYCL6a0QwhvAlnojZCDf
         5kEFZoKk6rGwalcBRjSsgTnTEXnCZ3S0MzwguozKSGWwpZCyc02LLcOD3xHaW+fKNVhZ
         AFnv4UnyjmE4uAu9duRK6VMB1t/Y3p752q6RQTudrbg/mxL3jRxepxvhazpVIll1lyET
         N4LsNc++JuLGb1OiwqNTrYevW6Pn2JQl8Y9zrLQrwmuE0s2zgILmmjNpuDoa0fOHJ1c/
         yKsUJyHl5v6Ci/YW0Q/E58Y9/iOoas4georoHwJQBWMOvIE771CaVUxEa0cRnXjjnDpi
         KJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lJ1JReAkepthxrDOjoe1RbJQyd30ipILAmuR0rRV1gc=;
        b=MaeyrHO+eFc7pPfqXmoq3iwHmvYVqteA3/EXTPMZipYJdxIEX3Ebp6D0EJpd9sLwDV
         GKiBnxPvJHAyeHLGn5q4qnfw1ug6kHkHXJd0tBewYYMoUVWZEEEVrzg7d4ihZ600L2T+
         bWxa42ZUxk+Idwu5MdxMv9BNIe0MOBNqGVk8Qalt1TjJxSCVNI25jGVWsxUMj0buXOLR
         XmOO/kjxZdT3nOyPXSB46vY8vpjylXTQsxcjJVBRGpxrNrIFDyJ5q0P3K2zC1dyUAUdJ
         PFX0LNJ/NtxSLqsnl6iIhbU+Br8A3WBEAjE+HrOl8jUbJD4V5iIgRN2Gmx7eaRtuOFa7
         YaYw==
X-Gm-Message-State: APjAAAX0E4zjlaCAaDQBxSNGOB626SD6vFHk1hM0iO4c9OYg8CW4eG8k
        vup+GDza1tBKf8wiErxKg+0=
X-Google-Smtp-Source: APXvYqyrSLQJoES3rmXG23yuivO+25zzPVdZNm9axVvYfDa1nqk64BGjXBs4yqherBunW/qtDdJj5w==
X-Received: by 2002:a5d:5302:: with SMTP id e2mr22971977wrv.345.1566151281827;
        Sun, 18 Aug 2019 11:01:21 -0700 (PDT)
Received: from localhost.localdomain ([188.25.91.80])
        by smtp.gmail.com with ESMTPSA id x6sm9372246wmf.6.2019.08.18.11.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 11:01:21 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH spi for-5.4 01/14] spi: spi-fsl-dspi: Fix code alignment
Date:   Sun, 18 Aug 2019 21:01:02 +0300
Message-Id: <20190818180115.31114-2-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818180115.31114-1-olteanv@gmail.com>
References: <20190818180115.31114-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This is a cosmetic patch that changes nothing except makes sure the code
is aligned to the same column, which makes it easier to the eye.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 370 ++++++++++++++++++-------------------
 1 file changed, 185 insertions(+), 185 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 96eacbe6ae27..0adfff9cedd1 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -28,7 +28,7 @@
 #include <linux/spi/spi_bitbang.h>
 #include <linux/time.h>
 
-#define DRIVER_NAME "fsl-dspi"
+#define DRIVER_NAME			"fsl-dspi"
 
 #ifdef CONFIG_M5441x
 #define DSPI_FIFO_SIZE			16
@@ -37,101 +37,101 @@
 #endif
 #define DSPI_DMA_BUFSIZE		(DSPI_FIFO_SIZE * 1024)
 
-#define SPI_MCR		0x00
-#define SPI_MCR_MASTER		(1 << 31)
-#define SPI_MCR_PCSIS		(0x3F << 16)
-#define SPI_MCR_CLR_TXF	(1 << 11)
-#define SPI_MCR_CLR_RXF	(1 << 10)
-#define SPI_MCR_XSPI		(1 << 3)
-
-#define SPI_TCR			0x08
-#define SPI_TCR_GET_TCNT(x)	(((x) & 0xffff0000) >> 16)
-
-#define SPI_CTAR(x)		(0x0c + (((x) & 0x3) * 4))
-#define SPI_CTAR_FMSZ(x)	(((x) & 0x0000000f) << 27)
-#define SPI_CTAR_CPOL(x)	((x) << 26)
-#define SPI_CTAR_CPHA(x)	((x) << 25)
-#define SPI_CTAR_LSBFE(x)	((x) << 24)
-#define SPI_CTAR_PCSSCK(x)	(((x) & 0x00000003) << 22)
-#define SPI_CTAR_PASC(x)	(((x) & 0x00000003) << 20)
-#define SPI_CTAR_PDT(x)	(((x) & 0x00000003) << 18)
-#define SPI_CTAR_PBR(x)	(((x) & 0x00000003) << 16)
-#define SPI_CTAR_CSSCK(x)	(((x) & 0x0000000f) << 12)
-#define SPI_CTAR_ASC(x)	(((x) & 0x0000000f) << 8)
-#define SPI_CTAR_DT(x)		(((x) & 0x0000000f) << 4)
-#define SPI_CTAR_BR(x)		((x) & 0x0000000f)
-#define SPI_CTAR_SCALE_BITS	0xf
-
-#define SPI_CTAR0_SLAVE	0x0c
-
-#define SPI_SR			0x2c
-#define SPI_SR_EOQF		0x10000000
-#define SPI_SR_TCFQF		0x80000000
-#define SPI_SR_CLEAR		0x9aaf0000
-
-#define SPI_RSER_TFFFE		BIT(25)
-#define SPI_RSER_TFFFD		BIT(24)
-#define SPI_RSER_RFDFE		BIT(17)
-#define SPI_RSER_RFDFD		BIT(16)
-
-#define SPI_RSER		0x30
-#define SPI_RSER_EOQFE		0x10000000
-#define SPI_RSER_TCFQE		0x80000000
-
-#define SPI_PUSHR		0x34
-#define SPI_PUSHR_CMD_CONT	(1 << 15)
-#define SPI_PUSHR_CONT		(SPI_PUSHR_CMD_CONT << 16)
-#define SPI_PUSHR_CMD_CTAS(x)	(((x) & 0x0003) << 12)
-#define SPI_PUSHR_CTAS(x)	(SPI_PUSHR_CMD_CTAS(x) << 16)
-#define SPI_PUSHR_CMD_EOQ	(1 << 11)
-#define SPI_PUSHR_EOQ		(SPI_PUSHR_CMD_EOQ << 16)
-#define SPI_PUSHR_CMD_CTCNT	(1 << 10)
-#define SPI_PUSHR_CTCNT		(SPI_PUSHR_CMD_CTCNT << 16)
-#define SPI_PUSHR_CMD_PCS(x)	((1 << x) & 0x003f)
-#define SPI_PUSHR_PCS(x)	(SPI_PUSHR_CMD_PCS(x) << 16)
-#define SPI_PUSHR_TXDATA(x)	((x) & 0x0000ffff)
-
-#define SPI_PUSHR_SLAVE	0x34
-
-#define SPI_POPR		0x38
-#define SPI_POPR_RXDATA(x)	((x) & 0x0000ffff)
-
-#define SPI_TXFR0		0x3c
-#define SPI_TXFR1		0x40
-#define SPI_TXFR2		0x44
-#define SPI_TXFR3		0x48
-#define SPI_RXFR0		0x7c
-#define SPI_RXFR1		0x80
-#define SPI_RXFR2		0x84
-#define SPI_RXFR3		0x88
-
-#define SPI_CTARE(x)		(0x11c + (((x) & 0x3) * 4))
-#define SPI_CTARE_FMSZE(x)	(((x) & 0x1) << 16)
-#define SPI_CTARE_DTCP(x)	((x) & 0x7ff)
-
-#define SPI_SREX		0x13c
-
-#define SPI_FRAME_BITS(bits)	SPI_CTAR_FMSZ((bits) - 1)
-#define SPI_FRAME_BITS_MASK	SPI_CTAR_FMSZ(0xf)
-#define SPI_FRAME_BITS_16	SPI_CTAR_FMSZ(0xf)
-#define SPI_FRAME_BITS_8	SPI_CTAR_FMSZ(0x7)
-
-#define SPI_FRAME_EBITS(bits)	SPI_CTARE_FMSZE(((bits) - 1) >> 4)
-#define SPI_FRAME_EBITS_MASK	SPI_CTARE_FMSZE(1)
+#define SPI_MCR				0x00
+#define SPI_MCR_MASTER			(1 << 31)
+#define SPI_MCR_PCSIS			(0x3F << 16)
+#define SPI_MCR_CLR_TXF			(1 << 11)
+#define SPI_MCR_CLR_RXF			(1 << 10)
+#define SPI_MCR_XSPI			(1 << 3)
+
+#define SPI_TCR				0x08
+#define SPI_TCR_GET_TCNT(x)		(((x) & 0xffff0000) >> 16)
+
+#define SPI_CTAR(x)			(0x0c + (((x) & 0x3) * 4))
+#define SPI_CTAR_FMSZ(x)		(((x) & 0x0000000f) << 27)
+#define SPI_CTAR_CPOL(x)		((x) << 26)
+#define SPI_CTAR_CPHA(x)		((x) << 25)
+#define SPI_CTAR_LSBFE(x)		((x) << 24)
+#define SPI_CTAR_PCSSCK(x)		(((x) & 0x00000003) << 22)
+#define SPI_CTAR_PASC(x)		(((x) & 0x00000003) << 20)
+#define SPI_CTAR_PDT(x)			(((x) & 0x00000003) << 18)
+#define SPI_CTAR_PBR(x)			(((x) & 0x00000003) << 16)
+#define SPI_CTAR_CSSCK(x)		(((x) & 0x0000000f) << 12)
+#define SPI_CTAR_ASC(x)			(((x) & 0x0000000f) << 8)
+#define SPI_CTAR_DT(x)			(((x) & 0x0000000f) << 4)
+#define SPI_CTAR_BR(x)			((x) & 0x0000000f)
+#define SPI_CTAR_SCALE_BITS		0xf
+
+#define SPI_CTAR0_SLAVE			0x0c
+
+#define SPI_SR				0x2c
+#define SPI_SR_EOQF			0x10000000
+#define SPI_SR_TCFQF			0x80000000
+#define SPI_SR_CLEAR			0x9aaf0000
+
+#define SPI_RSER_TFFFE			BIT(25)
+#define SPI_RSER_TFFFD			BIT(24)
+#define SPI_RSER_RFDFE			BIT(17)
+#define SPI_RSER_RFDFD			BIT(16)
+
+#define SPI_RSER			0x30
+#define SPI_RSER_EOQFE			0x10000000
+#define SPI_RSER_TCFQE			0x80000000
+
+#define SPI_PUSHR			0x34
+#define SPI_PUSHR_CMD_CONT		(1 << 15)
+#define SPI_PUSHR_CONT			(SPI_PUSHR_CMD_CONT << 16)
+#define SPI_PUSHR_CMD_CTAS(x)		(((x) & 0x0003) << 12)
+#define SPI_PUSHR_CTAS(x)		(SPI_PUSHR_CMD_CTAS(x) << 16)
+#define SPI_PUSHR_CMD_EOQ		(1 << 11)
+#define SPI_PUSHR_EOQ			(SPI_PUSHR_CMD_EOQ << 16)
+#define SPI_PUSHR_CMD_CTCNT		(1 << 10)
+#define SPI_PUSHR_CTCNT			(SPI_PUSHR_CMD_CTCNT << 16)
+#define SPI_PUSHR_CMD_PCS(x)		((1 << x) & 0x003f)
+#define SPI_PUSHR_PCS(x)		(SPI_PUSHR_CMD_PCS(x) << 16)
+#define SPI_PUSHR_TXDATA(x)		((x) & 0x0000ffff)
+
+#define SPI_PUSHR_SLAVE			0x34
+
+#define SPI_POPR			0x38
+#define SPI_POPR_RXDATA(x)		((x) & 0x0000ffff)
+
+#define SPI_TXFR0			0x3c
+#define SPI_TXFR1			0x40
+#define SPI_TXFR2			0x44
+#define SPI_TXFR3			0x48
+#define SPI_RXFR0			0x7c
+#define SPI_RXFR1			0x80
+#define SPI_RXFR2			0x84
+#define SPI_RXFR3			0x88
+
+#define SPI_CTARE(x)			(0x11c + (((x) & 0x3) * 4))
+#define SPI_CTARE_FMSZE(x)		(((x) & 0x1) << 16)
+#define SPI_CTARE_DTCP(x)		((x) & 0x7ff)
+
+#define SPI_SREX			0x13c
+
+#define SPI_FRAME_BITS(bits)		SPI_CTAR_FMSZ((bits) - 1)
+#define SPI_FRAME_BITS_MASK		SPI_CTAR_FMSZ(0xf)
+#define SPI_FRAME_BITS_16		SPI_CTAR_FMSZ(0xf)
+#define SPI_FRAME_BITS_8		SPI_CTAR_FMSZ(0x7)
+
+#define SPI_FRAME_EBITS(bits)		SPI_CTARE_FMSZE(((bits) - 1) >> 4)
+#define SPI_FRAME_EBITS_MASK		SPI_CTARE_FMSZE(1)
 
 /* Register offsets for regmap_pushr */
-#define PUSHR_CMD		0x0
-#define PUSHR_TX		0x2
+#define PUSHR_CMD			0x0
+#define PUSHR_TX			0x2
 
-#define SPI_CS_INIT		0x01
-#define SPI_CS_ASSERT		0x02
-#define SPI_CS_DROP		0x04
+#define SPI_CS_INIT			0x01
+#define SPI_CS_ASSERT			0x02
+#define SPI_CS_DROP			0x04
 
-#define DMA_COMPLETION_TIMEOUT	msecs_to_jiffies(3000)
+#define DMA_COMPLETION_TIMEOUT		msecs_to_jiffies(3000)
 
 struct chip_data {
-	u32 ctar_val;
-	u16 void_write_data;
+	u32			ctar_val;
+	u16			void_write_data;
 };
 
 enum dspi_trans_mode {
@@ -141,75 +141,75 @@ enum dspi_trans_mode {
 };
 
 struct fsl_dspi_devtype_data {
-	enum dspi_trans_mode trans_mode;
-	u8 max_clock_factor;
-	bool xspi_mode;
+	enum dspi_trans_mode	trans_mode;
+	u8			max_clock_factor;
+	bool			xspi_mode;
 };
 
 static const struct fsl_dspi_devtype_data vf610_data = {
-	.trans_mode = DSPI_DMA_MODE,
-	.max_clock_factor = 2,
+	.trans_mode		= DSPI_DMA_MODE,
+	.max_clock_factor	= 2,
 };
 
 static const struct fsl_dspi_devtype_data ls1021a_v1_data = {
-	.trans_mode = DSPI_TCFQ_MODE,
-	.max_clock_factor = 8,
-	.xspi_mode = true,
+	.trans_mode		= DSPI_TCFQ_MODE,
+	.max_clock_factor	= 8,
+	.xspi_mode		= true,
 };
 
 static const struct fsl_dspi_devtype_data ls2085a_data = {
-	.trans_mode = DSPI_TCFQ_MODE,
-	.max_clock_factor = 8,
+	.trans_mode		= DSPI_TCFQ_MODE,
+	.max_clock_factor	= 8,
 };
 
 static const struct fsl_dspi_devtype_data coldfire_data = {
-	.trans_mode = DSPI_EOQ_MODE,
-	.max_clock_factor = 8,
+	.trans_mode		= DSPI_EOQ_MODE,
+	.max_clock_factor	= 8,
 };
 
 struct fsl_dspi_dma {
 	/* Length of transfer in words of DSPI_FIFO_SIZE */
-	u32 curr_xfer_len;
-
-	u32 *tx_dma_buf;
-	struct dma_chan *chan_tx;
-	dma_addr_t tx_dma_phys;
-	struct completion cmd_tx_complete;
-	struct dma_async_tx_descriptor *tx_desc;
-
-	u32 *rx_dma_buf;
-	struct dma_chan *chan_rx;
-	dma_addr_t rx_dma_phys;
-	struct completion cmd_rx_complete;
-	struct dma_async_tx_descriptor *rx_desc;
+	u32					curr_xfer_len;
+
+	u32					*tx_dma_buf;
+	struct dma_chan				*chan_tx;
+	dma_addr_t				tx_dma_phys;
+	struct completion			cmd_tx_complete;
+	struct dma_async_tx_descriptor		*tx_desc;
+
+	u32					*rx_dma_buf;
+	struct dma_chan				*chan_rx;
+	dma_addr_t				rx_dma_phys;
+	struct completion			cmd_rx_complete;
+	struct dma_async_tx_descriptor		*rx_desc;
 };
 
 struct fsl_dspi {
-	struct spi_master	*master;
-	struct platform_device	*pdev;
-
-	struct regmap		*regmap;
-	struct regmap		*regmap_pushr;
-	int			irq;
-	struct clk		*clk;
-
-	struct spi_transfer	*cur_transfer;
-	struct spi_message	*cur_msg;
-	struct chip_data	*cur_chip;
-	size_t			len;
-	const void		*tx;
-	void			*rx;
-	void			*rx_end;
-	u16			void_write_data;
-	u16			tx_cmd;
-	u8			bits_per_word;
-	u8			bytes_per_word;
-	const struct fsl_dspi_devtype_data *devtype_data;
-
-	wait_queue_head_t	waitq;
-	u32			waitflags;
-
-	struct fsl_dspi_dma	*dma;
+	struct spi_master			*master;
+	struct platform_device			*pdev;
+
+	struct regmap				*regmap;
+	struct regmap				*regmap_pushr;
+	int					irq;
+	struct clk				*clk;
+
+	struct spi_transfer			*cur_transfer;
+	struct spi_message			*cur_msg;
+	struct chip_data			*cur_chip;
+	size_t					len;
+	const void				*tx;
+	void					*rx;
+	void					*rx_end;
+	u16					void_write_data;
+	u16					tx_cmd;
+	u8					bits_per_word;
+	u8					bytes_per_word;
+	const struct fsl_dspi_devtype_data	*devtype_data;
+
+	wait_queue_head_t			waitq;
+	u32					waitflags;
+
+	struct fsl_dspi_dma			*dma;
 };
 
 static u32 dspi_pop_tx(struct fsl_dspi *dspi)
@@ -338,7 +338,7 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 	}
 
 	time_left = wait_for_completion_timeout(&dspi->dma->cmd_tx_complete,
-					DMA_COMPLETION_TIMEOUT);
+						DMA_COMPLETION_TIMEOUT);
 	if (time_left == 0) {
 		dev_err(dev, "DMA tx timeout\n");
 		dmaengine_terminate_all(dma->chan_tx);
@@ -347,7 +347,7 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 	}
 
 	time_left = wait_for_completion_timeout(&dspi->dma->cmd_rx_complete,
-					DMA_COMPLETION_TIMEOUT);
+						DMA_COMPLETION_TIMEOUT);
 	if (time_left == 0) {
 		dev_err(dev, "DMA rx timeout\n");
 		dmaengine_terminate_all(dma->chan_tx);
@@ -421,14 +421,14 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 	}
 
 	dma->tx_dma_buf = dma_alloc_coherent(dev, DSPI_DMA_BUFSIZE,
-					&dma->tx_dma_phys, GFP_KERNEL);
+					     &dma->tx_dma_phys, GFP_KERNEL);
 	if (!dma->tx_dma_buf) {
 		ret = -ENOMEM;
 		goto err_tx_dma_buf;
 	}
 
 	dma->rx_dma_buf = dma_alloc_coherent(dev, DSPI_DMA_BUFSIZE,
-					&dma->rx_dma_phys, GFP_KERNEL);
+					     &dma->rx_dma_phys, GFP_KERNEL);
 	if (!dma->rx_dma_buf) {
 		ret = -ENOMEM;
 		goto err_rx_dma_buf;
@@ -501,14 +501,14 @@ static void dspi_release_dma(struct fsl_dspi *dspi)
 }
 
 static void hz_to_spi_baud(char *pbr, char *br, int speed_hz,
-		unsigned long clkrate)
+			   unsigned long clkrate)
 {
 	/* Valid baud rate pre-scaler values */
 	int pbr_tbl[4] = {2, 3, 5, 7};
 	int brs[16] = {	2,	4,	6,	8,
-		16,	32,	64,	128,
-		256,	512,	1024,	2048,
-		4096,	8192,	16384,	32768 };
+			16,	32,	64,	128,
+			256,	512,	1024,	2048,
+			4096,	8192,	16384,	32768 };
 	int scale_needed, scale, minscale = INT_MAX;
 	int i, j;
 
@@ -538,7 +538,7 @@ static void hz_to_spi_baud(char *pbr, char *br, int speed_hz,
 }
 
 static void ns_delay_scale(char *psc, char *sc, int delay_ns,
-		unsigned long clkrate)
+			   unsigned long clkrate)
 {
 	int pscale_tbl[4] = {1, 3, 5, 7};
 	int scale_needed, scale, minscale = INT_MAX;
@@ -546,7 +546,7 @@ static void ns_delay_scale(char *psc, char *sc, int delay_ns,
 	u32 remainder;
 
 	scale_needed = div_u64_rem((u64)delay_ns * clkrate, NSEC_PER_SEC,
-			&remainder);
+				   &remainder);
 	if (remainder)
 		scale_needed++;
 
@@ -661,7 +661,7 @@ static void dspi_eoq_read(struct fsl_dspi *dspi)
 }
 
 static int dspi_transfer_one_message(struct spi_master *master,
-		struct spi_message *message)
+				     struct spi_message *message)
 {
 	struct fsl_dspi *dspi = spi_master_get_devdata(master);
 	struct spi_device *spi = message->spi;
@@ -677,7 +677,7 @@ static int dspi_transfer_one_message(struct spi_master *master,
 		dspi->cur_chip = spi_get_ctldata(spi);
 		/* Prepare command word for CMD FIFO */
 		dspi->tx_cmd = SPI_PUSHR_CMD_CTAS(0) |
-			SPI_PUSHR_CMD_PCS(spi->chip_select);
+			       SPI_PUSHR_CMD_PCS(spi->chip_select);
 		if (list_is_last(&dspi->cur_transfer->transfer_list,
 				 &dspi->cur_msg->transfers)) {
 			/* Leave PCS activated after last transfer when
@@ -718,8 +718,8 @@ static int dspi_transfer_one_message(struct spi_master *master,
 			     SPI_FRAME_BITS(transfer->bits_per_word));
 		if (dspi->devtype_data->xspi_mode)
 			regmap_write(dspi->regmap, SPI_CTARE(0),
-				     SPI_FRAME_EBITS(transfer->bits_per_word)
-				     | SPI_CTARE_DTCP(1));
+				     SPI_FRAME_EBITS(transfer->bits_per_word) |
+				     SPI_CTARE_DTCP(1));
 
 		trans_mode = dspi->devtype_data->trans_mode;
 		switch (trans_mode) {
@@ -733,8 +733,8 @@ static int dspi_transfer_one_message(struct spi_master *master,
 			break;
 		case DSPI_DMA_MODE:
 			regmap_write(dspi->regmap, SPI_RSER,
-				SPI_RSER_TFFFE | SPI_RSER_TFFFD |
-				SPI_RSER_RFDFE | SPI_RSER_RFDFD);
+				     SPI_RSER_TFFFE | SPI_RSER_TFFFD |
+				     SPI_RSER_RFDFE | SPI_RSER_RFDFD);
 			status = dspi_dma_xfer(dspi);
 			break;
 		default:
@@ -746,7 +746,7 @@ static int dspi_transfer_one_message(struct spi_master *master,
 
 		if (trans_mode != DSPI_DMA_MODE) {
 			if (wait_event_interruptible(dspi->waitq,
-						dspi->waitflags))
+						     dspi->waitflags))
 				dev_err(&dspi->pdev->dev,
 					"wait transfer complete fail!\n");
 			dspi->waitflags = 0;
@@ -785,10 +785,10 @@ static int dspi_setup(struct spi_device *spi)
 
 	if (!pdata) {
 		of_property_read_u32(spi->dev.of_node, "fsl,spi-cs-sck-delay",
-				&cs_sck_delay);
+				     &cs_sck_delay);
 
 		of_property_read_u32(spi->dev.of_node, "fsl,spi-sck-cs-delay",
-				&sck_cs_delay);
+				     &sck_cs_delay);
 	} else {
 		cs_sck_delay = pdata->cs_sck_delay;
 		sck_cs_delay = pdata->sck_cs_delay;
@@ -829,7 +829,7 @@ static void dspi_cleanup(struct spi_device *spi)
 	struct chip_data *chip = spi_get_ctldata((struct spi_device *)spi);
 
 	dev_dbg(&spi->dev, "spi_device %u.%u cleanup\n",
-			spi->master->bus_num, spi->chip_select);
+		spi->master->bus_num, spi->chip_select);
 
 	kfree(chip);
 }
@@ -939,16 +939,16 @@ static const struct regmap_range dspi_volatile_ranges[] = {
 };
 
 static const struct regmap_access_table dspi_volatile_table = {
-	.yes_ranges     = dspi_volatile_ranges,
-	.n_yes_ranges   = ARRAY_SIZE(dspi_volatile_ranges),
+	.yes_ranges	= dspi_volatile_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(dspi_volatile_ranges),
 };
 
 static const struct regmap_config dspi_regmap_config = {
-	.reg_bits = 32,
-	.val_bits = 32,
-	.reg_stride = 4,
-	.max_register = 0x88,
-	.volatile_table = &dspi_volatile_table,
+	.reg_bits	= 32,
+	.val_bits	= 32,
+	.reg_stride	= 4,
+	.max_register	= 0x88,
+	.volatile_table	= &dspi_volatile_table,
 };
 
 static const struct regmap_range dspi_xspi_volatile_ranges[] = {
@@ -959,24 +959,24 @@ static const struct regmap_range dspi_xspi_volatile_ranges[] = {
 };
 
 static const struct regmap_access_table dspi_xspi_volatile_table = {
-	.yes_ranges     = dspi_xspi_volatile_ranges,
-	.n_yes_ranges   = ARRAY_SIZE(dspi_xspi_volatile_ranges),
+	.yes_ranges	= dspi_xspi_volatile_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(dspi_xspi_volatile_ranges),
 };
 
 static const struct regmap_config dspi_xspi_regmap_config[] = {
 	{
-		.reg_bits = 32,
-		.val_bits = 32,
-		.reg_stride = 4,
-		.max_register = 0x13c,
-		.volatile_table = &dspi_xspi_volatile_table,
+		.reg_bits	= 32,
+		.val_bits	= 32,
+		.reg_stride	= 4,
+		.max_register	= 0x13c,
+		.volatile_table	= &dspi_xspi_volatile_table,
 	},
 	{
-		.name = "pushr",
-		.reg_bits = 16,
-		.val_bits = 16,
-		.reg_stride = 2,
-		.max_register = 0x2,
+		.name		= "pushr",
+		.reg_bits	= 16,
+		.val_bits	= 16,
+		.reg_stride	= 2,
+		.max_register	= 0x2,
 	},
 };
 
@@ -1160,12 +1160,12 @@ static int dspi_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver fsl_dspi_driver = {
-	.driver.name    = DRIVER_NAME,
-	.driver.of_match_table = fsl_dspi_dt_ids,
-	.driver.owner   = THIS_MODULE,
-	.driver.pm = &dspi_pm,
-	.probe          = dspi_probe,
-	.remove		= dspi_remove,
+	.driver.name		= DRIVER_NAME,
+	.driver.of_match_table	= fsl_dspi_dt_ids,
+	.driver.owner		= THIS_MODULE,
+	.driver.pm		= &dspi_pm,
+	.probe			= dspi_probe,
+	.remove			= dspi_remove,
 };
 module_platform_driver(fsl_dspi_driver);
 
-- 
2.17.1

