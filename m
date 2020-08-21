Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8188324DE63
	for <lists+linux-spi@lfdr.de>; Fri, 21 Aug 2020 19:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgHUR3l (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Aug 2020 13:29:41 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38846 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgHUQOV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Aug 2020 12:14:21 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200821161408euoutp02e42ef588136bd46e672ea7a3bf341155~tVJaQYwNz0371003710euoutp02j
        for <linux-spi@vger.kernel.org>; Fri, 21 Aug 2020 16:14:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200821161408euoutp02e42ef588136bd46e672ea7a3bf341155~tVJaQYwNz0371003710euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598026448;
        bh=UU83HvZa8Yjdm2hI09P/AOUI/1Uzpv5njQG9t3z9YZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HIVLq6e4g00Sm87HZLXlBpem70x64gvg60JcIjLiYQDxjlWehnm6KZaqLjQd+8hIh
         /Alk/WMaZotaid5LZ7dvxWrG85PVfDt5qQRrUtbp8feR36v5+U95DwK1XXtNf0aTmB
         m9uPxh0vl07e27xeNUId9xczTNf47flOLJmuyG1U=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200821161407eucas1p1372792605e4f6365b7c46882fa660f8c~tVJZsHQPW1516315163eucas1p1e;
        Fri, 21 Aug 2020 16:14:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 98.D9.06456.FC2FF3F5; Fri, 21
        Aug 2020 17:14:07 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200821161407eucas1p116af63a668bdbb75fa974589e5f6139f~tVJZBsn9i0797107971eucas1p1X;
        Fri, 21 Aug 2020 16:14:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200821161407eusmtrp2f835d2d7162d3cf5448a525bc761cdd5~tVJZBG4jf2998229982eusmtrp2g;
        Fri, 21 Aug 2020 16:14:07 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-d9-5f3ff2cf2286
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DB.17.06314.EC2FF3F5; Fri, 21
        Aug 2020 17:14:06 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200821161406eusmtip19910d1e8fe8f987164954fb383ca7c1a~tVJYzATYO1593515935eusmtip1y;
        Fri, 21 Aug 2020 16:14:06 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v2 6/9] spi: spi-s3c64xx: Check return values
Date:   Fri, 21 Aug 2020 18:13:58 +0200
Message-Id: <20200821161401.11307-7-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821161401.11307-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsWy7djPc7rnP9nHG3z4qmOx+MdzJouNM9az
        Wkx9+ITNov/xa2aL8+c3sFvcPLSC0WLT42usFpd3zWGzmHF+H5NF48eb7BZrj9xld+D2uL7k
        E7PHplWdbB6bl9R79G1ZxejxeZNcAGsUl01Kak5mWWqRvl0CV8bh9w3sBWfVKmYuncbWwLhZ
        vouRk0NCwETieNd7ti5GLg4hgRWMEp23/jBBOF8YJU7dX80K4XxmlNjWfZ8JpmXFy7NQLcsZ
        Ja50T4Jqec4oca15MxtIFZuAo0T/0hNg7SICE5gkHp57A5ZgFiiV6Nl5CMwWFrCVuNY5A2ws
        i4CqxMJbS1hBbF4Ba4l926ewQqyTl2hfvh2snlPARuL4pSaoGkGJkzOfsIDY/AJaEmuarrNA
        zJeXaN46mxlksYTAOXaJJe+2sUAMcpHYfvkPG4QtLPHq+BZ2CFtG4v/O+UBHcADZ9RKTJ5lB
        9PYA/TznB1SvtcSdc7/YQGqYBTQl1u/Shwg7Siye8IYNopVP4sZbQYgT+CQmbZvODBHmleho
        E4KoVpFY178HaqCURO+rFYwTGJVmIXlmFpIHZiHsWsDIvIpRPLW0ODc9tdgwL7Vcrzgxt7g0
        L10vOT93EyMwJZ3+d/zTDsavl5IOMQpwMCrx8P44ZB8vxJpYVlyZe4hRgoNZSYTX6ezpOCHe
        lMTKqtSi/Pii0pzU4kOM0hwsSuK8xotexgoJpCeWpGanphakFsFkmTg4pRoYcwPOnNvK4RZl
        ++VX4ATmFdPDPVeWMgppW5v88hSKszv9dtur02mSJ9ekmD8x3DbX+nbj8e3Ozf//b0hp4hPm
        sKw8nZVz/uXnr1eDfhe56olKazw916Xrtt1SM1T6TKXdFaFtxz0/Xu6TXW3Sf0xLb/dao/L/
        zifX5z5wkrzqtfDdDOat/zM+KLEUZyQaajEXFScCAP0280pFAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xu7rnPtnHG2zcYGOx+MdzJouNM9az
        Wkx9+ITNov/xa2aL8+c3sFvcPLSC0WLT42usFpd3zWGzmHF+H5NF48eb7BZrj9xld+D2uL7k
        E7PHplWdbB6bl9R79G1ZxejxeZNcAGuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5
        rJWRqZK+nU1Kak5mWWqRvl2CXsbh9w3sBWfVKmYuncbWwLhZvouRk0NCwERixcuzbF2MXBxC
        AksZJVZd+MjexcgBlJCSWDk3HaJGWOLPtS6omqeMEnu+72AESbAJOEr0Lz3BCpIQEZjBJPHk
        xmRWkASzQLnEpVnP2UFsYQFbiWudM5hAbBYBVYmFt5aA1fAKWEvs2z6FFWKDvET78u1sIDan
        gI3E8UtNYHEhoJptiy+zQNQLSpyc+YQF5DhmAXWJ9fOEQML8AloSa5qus0CslZdo3jqbeQKj
        0CwkHbMQOmYhqVrAyLyKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMP62Hfu5eQfjpY3BhxgF
        OBiVeHh/HLKPF2JNLCuuzD3EKMHBrCTC63T2dJwQb0piZVVqUX58UWlOavEhRlOgNycyS4km
        5wNTQ15JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBsYax5XFEYrZ
        wX737LP6dWeH9+VMPFi39kB/w9VdoYxPJn5KTdT6/lGCaaOEtOV9Tp3s8EP9rxmk1hjFHytZ
        s2GHV/Gx7W+ZGZ6L7H+wzmbaal/d3rKnMb8edMvyh/pJn3PMk9+Rlvf9ALNpfU3QAfZUHTfP
        nnXcGfF90mEH8p10yzfW3Wk4psRSnJFoqMVcVJwIANHYjyLVAgAA
X-CMS-MailID: 20200821161407eucas1p116af63a668bdbb75fa974589e5f6139f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200821161407eucas1p116af63a668bdbb75fa974589e5f6139f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200821161407eucas1p116af63a668bdbb75fa974589e5f6139f
References: <20200821161401.11307-1-l.stelmach@samsung.com>
        <CGME20200821161407eucas1p116af63a668bdbb75fa974589e5f6139f@eucas1p1.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Check return values in prepare_dma() and s3c64xx_spi_config() and
propagate errors upwards.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 47 ++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 6381a7557def..02de734b8ab1 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -269,12 +269,13 @@ static void s3c64xx_spi_dmacb(void *data)
 	spin_unlock_irqrestore(&sdd->lock, flags);
 }
 
-static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
+static int prepare_dma(struct s3c64xx_spi_dma_data *dma,
 			struct sg_table *sgt)
 {
 	struct s3c64xx_spi_driver_data *sdd;
 	struct dma_slave_config config;
 	struct dma_async_tx_descriptor *desc;
+	int ret;
 
 	memset(&config, 0, sizeof(config));
 
@@ -298,12 +299,24 @@ static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
 
 	desc = dmaengine_prep_slave_sg(dma->ch, sgt->sgl, sgt->nents,
 				       dma->direction, DMA_PREP_INTERRUPT);
+	if (!desc) {
+		dev_err(&sdd->pdev->dev, "unable to prepare %s scatterlist",
+			dma->direction == DMA_DEV_TO_MEM ? "rx" : "tx");
+		return -ENOMEM;
+	}
 
 	desc->callback = s3c64xx_spi_dmacb;
 	desc->callback_param = dma;
 
 	dma->cookie = dmaengine_submit(desc);
+	ret = dma_submit_error(dma->cookie);
+	if (ret) {
+		dev_err(&sdd->pdev->dev, "DMA submission failed");
+		return -EIO;
+	}
+
 	dma_async_issue_pending(dma->ch);
+	return 0;
 }
 
 static void s3c64xx_spi_set_cs(struct spi_device *spi, bool enable)
@@ -353,11 +366,12 @@ static bool s3c64xx_spi_can_dma(struct spi_master *master,
 	return xfer->len > (FIFO_LVL_MASK(sdd) >> 1) + 1;
 }
 
-static void s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
+static int s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 				    struct spi_transfer *xfer, int dma_mode)
 {
 	void __iomem *regs = sdd->regs;
 	u32 modecfg, chcfg;
+	int ret = 0;
 
 	modecfg = readl(regs + S3C64XX_SPI_MODE_CFG);
 	modecfg &= ~(S3C64XX_SPI_MODE_TXDMA_ON | S3C64XX_SPI_MODE_RXDMA_ON);
@@ -383,7 +397,7 @@ static void s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 		chcfg |= S3C64XX_SPI_CH_TXCH_ON;
 		if (dma_mode) {
 			modecfg |= S3C64XX_SPI_MODE_TXDMA_ON;
-			prepare_dma(&sdd->tx_dma, &xfer->tx_sg);
+			ret = prepare_dma(&sdd->tx_dma, &xfer->tx_sg);
 		} else {
 			switch (sdd->cur_bpw) {
 			case 32:
@@ -415,12 +429,17 @@ static void s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 			writel(((xfer->len * 8 / sdd->cur_bpw) & 0xffff)
 					| S3C64XX_SPI_PACKET_CNT_EN,
 					regs + S3C64XX_SPI_PACKET_CNT);
-			prepare_dma(&sdd->rx_dma, &xfer->rx_sg);
+			ret = prepare_dma(&sdd->rx_dma, &xfer->rx_sg);
 		}
 	}
 
+	if (ret)
+		return ret;
+
 	writel(modecfg, regs + S3C64XX_SPI_MODE_CFG);
 	writel(chcfg, regs + S3C64XX_SPI_CH_CFG);
+
+	return 0;
 }
 
 static u32 s3c64xx_spi_wait_for_timeout(struct s3c64xx_spi_driver_data *sdd,
@@ -553,9 +572,10 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
 	return 0;
 }
 
-static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
+static int s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 {
 	void __iomem *regs = sdd->regs;
+	int ret;
 	u32 val;
 
 	/* Disable Clock */
@@ -603,7 +623,9 @@ static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 
 	if (sdd->port_conf->clk_from_cmu) {
 		/* The src_clk clock is divided internally by 2 */
-		clk_set_rate(sdd->src_clk, sdd->cur_speed * 2);
+		ret = clk_set_rate(sdd->src_clk, sdd->cur_speed * 2);
+		if (ret)
+			return ret;
 	} else {
 		/* Configure Clock */
 		val = readl(regs + S3C64XX_SPI_CLK_CFG);
@@ -617,6 +639,8 @@ static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 		val |= S3C64XX_SPI_ENCLK_ENABLE;
 		writel(val, regs + S3C64XX_SPI_CLK_CFG);
 	}
+
+	return 0;
 }
 
 #define XFER_DMAADDR_INVALID DMA_BIT_MASK(32)
@@ -659,7 +683,9 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 		sdd->cur_bpw = bpw;
 		sdd->cur_speed = speed;
 		sdd->cur_mode = spi->mode;
-		s3c64xx_spi_config(sdd);
+		status = s3c64xx_spi_config(sdd);
+		if (status)
+			return status;
 	}
 
 	if (!is_polling(sdd) && (xfer->len > fifo_len) &&
@@ -686,10 +712,15 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 		/* Start the signals */
 		s3c64xx_spi_set_cs(spi, true);
 
-		s3c64xx_enable_datapath(sdd, xfer, use_dma);
+		status = s3c64xx_enable_datapath(sdd, xfer, use_dma);
 
 		spin_unlock_irqrestore(&sdd->lock, flags);
 
+		if (status) {
+			dev_err(&spi->dev, "failed to enable data path for transfer: %d\n", status);
+			break;
+		}
+
 		if (use_dma)
 			status = s3c64xx_wait_for_dma(sdd, xfer);
 		else
-- 
2.26.2

