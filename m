Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B30428029E
	for <lists+linux-spi@lfdr.de>; Thu,  1 Oct 2020 17:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732660AbgJAPXQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Oct 2020 11:23:16 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41173 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732621AbgJAPWu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Oct 2020 11:22:50 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201001152248euoutp0253026932603577b0b321242f450cfa5e~555S0akif2410224102euoutp02D
        for <linux-spi@vger.kernel.org>; Thu,  1 Oct 2020 15:22:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201001152248euoutp0253026932603577b0b321242f450cfa5e~555S0akif2410224102euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601565768;
        bh=ZPDdKXrWSOpD0gqlEEMqVBHjyee2s4wL5xY64uskRHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tfiWrU6wJitgeU3KlwinvNklhFaIa93k44q7kvARnBpeV14i4+/aLfUHiOOlzD/fw
         B/2oBsVQ5W6WR1u5qRNdGoTIzUnKtAA1GHS09i00WS4E2R+tpSMBwFDSrH3JH29KIK
         iKj7oNAeSBRjD32p+jG+Pp3dhqueWgazZw3dosQQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201001152247eucas1p10ab190c72b4121e816dd78ae507aa854~555SODJSr1727717277eucas1p10;
        Thu,  1 Oct 2020 15:22:47 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 29.29.05997.744F57F5; Thu,  1
        Oct 2020 16:22:47 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201001152247eucas1p2b6b1cc61b9b175b0a621609cd58effbd~555R35PWp0234802348eucas1p2w;
        Thu,  1 Oct 2020 15:22:47 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201001152247eusmtrp10699e8a6e029508c8fc9c49893535e15~555R3PFr_2671526715eusmtrp1j;
        Thu,  1 Oct 2020 15:22:47 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-52-5f75f44706c4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 61.A5.06314.744F57F5; Thu,  1
        Oct 2020 16:22:47 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20201001152247eusmtip213a4aa992176591bd792eeffd552a52f~555RsLrr-0513205132eusmtip2T;
        Thu,  1 Oct 2020 15:22:47 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v2 RESEND 3/9] spi: spi-s3c64xx: Check return values
Date:   Thu,  1 Oct 2020 17:21:42 +0200
Message-Id: <20201001152148.29747-4-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001152148.29747-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsWy7djPc7ruX0rjDbav1bJY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yW6za9YfR
        gcfj+pJPzB47Z91l99i0qpPNY/OSeo++LasYPT5vkgtgi+KySUnNySxLLdK3S+DKmLh0GVvB
        b42KpQsvMDUwrlXsYuTkkBAwkbi06Bx7FyMXh5DACkaJNS+3sUI4XxgljsyYDuV8ZpSY0zOb
        Ba7lezsLRGI5o8T5lkVQ/c8ZJTZNb2AGqWITcJToX3oCrF1EYDuTxMTP58HamQVKJXp2HmID
        sYUFXCSWPLsDFmcRUJU4/WwdE4jNK2AtcftVIxvEOnmJ9uXbwWxOARuJcxMPs0HUCEqcnPkE
        rJdfQEtiTdN1qPnyEs1bZzODLJYQuMUusfLNMSaIQS4SN9uOQA0Vlnh1fAs7hC0jcXpyD1Az
        B5BdLzF5khlEbw+jxLY5P6B+tpa4c+4XG0gNs4CmxPpd+hBhR4kzhw6yQrTySdx4KwhxAp/E
        pG3TmSHCvBIdbUIQ1SoS6/r3QA2Ukuh9tYJxAqPSLCTPzELywCyEXQsYmVcxiqeWFuempxYb
        5aWW6xUn5haX5qXrJefnbmIEpqnT/45/2cG460/SIUYBDkYlHl6BA6XxQqyJZcWVuYcYJTiY
        lUR4nc6ejhPiTUmsrEotyo8vKs1JLT7EKM3BoiTOa7zoZayQQHpiSWp2ampBahFMlomDU6qB
        cZnH32CZZWa57/vnK0R8q3rjuHgdx3GGB9ZLL7B/lZhUeVP/0ut9BqufT9A/dURqZaf9k7z8
        LEYJdoXPUsK9+0/PMl62d97EjP+sb3tZuYT3RQpICnnt21x75F5eBYNxuPBjn4ip4V8LI6d9
        uqDkpl8fLnYy8/vrlwejt2za5H9lbcjHItWTS5RYijMSDbWYi4oTAbnBs0VPAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xe7ruX0rjDb69EbRY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yW6za9YfR
        gcfj+pJPzB47Z91l99i0qpPNY/OSeo++LasYPT5vkgtgi9KzKcovLUlVyMgvLrFVija0MNIz
        tLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLmLh0GVvBb42KpQsvMDUwrlXsYuTkkBAw
        kbj0vZ2li5GLQ0hgKaPE7y+ngBwOoISUxMq56RA1whJ/rnWxQdQ8ZZRYe+onC0iCTcBRon/p
        CVaQhIjAfiaJSxfugyWYBcolLs16zg5iCwu4SCx5dgcsziKgKnH62TomEJtXwFri9qtGNogN
        8hLty7eD2ZwCNhLnJh4Gs4UEciV27z7KBlEvKHFy5hOw45gF1CXWzxMCCfMLaEmsaboOtVZe
        onnrbOYJjEKzkHTMQuiYhaRqASPzKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMCY3Hbs5+Yd
        jJc2Bh9iFOBgVOLhFThQGi/EmlhWXJl7iFGCg1lJhNfp7Ok4Id6UxMqq1KL8+KLSnNTiQ4ym
        QG9OZJYSTc4Hpou8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2M
        Jqwd/cs2iD51KHq3yOLei9Dqmbf0dhzRuHMgWsa3PWVqRIrROv27Hqt1/gape7Ddnu3445mt
        V0bB5+mK+f2+e3Kv/liutCVqwk5F1/UZDEXZKh/LdN6fSl185MXTj7fP1Fs9+f9HZlGSx8+9
        +h6djU+2/X7i3J3mEMxumff5AxO7qs3CMuYJSizFGYmGWsxFxYkAr+VeSt8CAAA=
X-CMS-MailID: 20201001152247eucas1p2b6b1cc61b9b175b0a621609cd58effbd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201001152247eucas1p2b6b1cc61b9b175b0a621609cd58effbd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201001152247eucas1p2b6b1cc61b9b175b0a621609cd58effbd
References: <20200821161401.11307-1-l.stelmach@samsung.com>
        <20201001152148.29747-1-l.stelmach@samsung.com>
        <CGME20201001152247eucas1p2b6b1cc61b9b175b0a621609cd58effbd@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Check return values in prepare_dma() and s3c64xx_spi_config() and
propagate errors upwards.

Fixes: 788437273fa8 ("spi: s3c64xx: move to generic dmaengine API")
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 50 ++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 22bf8c75580a..f7482f2f1e13 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -122,6 +122,7 @@
 
 struct s3c64xx_spi_dma_data {
 	struct dma_chan *ch;
+	dma_cookie_t cookie;
 	enum dma_transfer_direction direction;
 };
 
@@ -271,12 +272,13 @@ static void s3c64xx_spi_dmacb(void *data)
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
 
@@ -300,12 +302,24 @@ static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
 
 	desc = dmaengine_prep_slave_sg(dma->ch, sgt->sgl, sgt->nents,
 				       dma->direction, DMA_PREP_INTERRUPT);
+	if (!desc) {
+		dev_err(&sdd->pdev->dev, "unable to prepare %s scatterlist",
+			dma->direction == DMA_DEV_TO_MEM ? "rx" : "tx");
+		return -ENOMEM;
+	}
 
 	desc->callback = s3c64xx_spi_dmacb;
 	desc->callback_param = dma;
 
-	dmaengine_submit(desc);
+	dma->cookie = dmaengine_submit(desc);
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
@@ -355,11 +369,12 @@ static bool s3c64xx_spi_can_dma(struct spi_master *master,
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
@@ -385,7 +400,7 @@ static void s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 		chcfg |= S3C64XX_SPI_CH_TXCH_ON;
 		if (dma_mode) {
 			modecfg |= S3C64XX_SPI_MODE_TXDMA_ON;
-			prepare_dma(&sdd->tx_dma, &xfer->tx_sg);
+			ret = prepare_dma(&sdd->tx_dma, &xfer->tx_sg);
 		} else {
 			switch (sdd->cur_bpw) {
 			case 32:
@@ -417,12 +432,17 @@ static void s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
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
@@ -555,9 +575,10 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
 	return 0;
 }
 
-static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
+static int s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 {
 	void __iomem *regs = sdd->regs;
+	int ret;
 	u32 val;
 
 	/* Disable Clock */
@@ -605,7 +626,9 @@ static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 
 	if (sdd->port_conf->clk_from_cmu) {
 		/* The src_clk clock is divided internally by 2 */
-		clk_set_rate(sdd->src_clk, sdd->cur_speed * 2);
+		ret = clk_set_rate(sdd->src_clk, sdd->cur_speed * 2);
+		if (ret)
+			return ret;
 	} else {
 		/* Configure Clock */
 		val = readl(regs + S3C64XX_SPI_CLK_CFG);
@@ -619,6 +642,8 @@ static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 		val |= S3C64XX_SPI_ENCLK_ENABLE;
 		writel(val, regs + S3C64XX_SPI_CLK_CFG);
 	}
+
+	return 0;
 }
 
 #define XFER_DMAADDR_INVALID DMA_BIT_MASK(32)
@@ -661,7 +686,9 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 		sdd->cur_bpw = bpw;
 		sdd->cur_speed = speed;
 		sdd->cur_mode = spi->mode;
-		s3c64xx_spi_config(sdd);
+		status = s3c64xx_spi_config(sdd);
+		if (status)
+			return status;
 	}
 
 	if (!is_polling(sdd) && (xfer->len > fifo_len) &&
@@ -688,10 +715,15 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
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

