Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35C028125F
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 14:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387920AbgJBMXT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Oct 2020 08:23:19 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54170 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387894AbgJBMW6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Oct 2020 08:22:58 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201002122253euoutp020d416a4c92094ff6c7d2ffe78dd4d057~6LFfTlrwV2200222002euoutp02B
        for <linux-spi@vger.kernel.org>; Fri,  2 Oct 2020 12:22:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201002122253euoutp020d416a4c92094ff6c7d2ffe78dd4d057~6LFfTlrwV2200222002euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601641373;
        bh=ZDasxSLDTG8wrzz/6e9tA0XQtu/VdW0OUqVXl2oFS/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MUsfbiP2ie4P7JDHNCRmwAd+a1BAIZ0jqzwU/GBaH8uLaEW6wPVXfjY3sYwFReyIt
         IpHn+9rDq5t1y6w/XCMeDAWBZcuaWGdOSq7UyhQHB8nnjc16vjwRUsPHXMUgzXjtyv
         c3X8AYJy9ZQx7fVAmYLZHMcnZGkb2EQT79HSQ3Kg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201002122252eucas1p2c64faa54d42c02eb1e62e74f3aa8f3f1~6LFezFImU2502325023eucas1p2H;
        Fri,  2 Oct 2020 12:22:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 6B.EB.05997.C9B177F5; Fri,  2
        Oct 2020 13:22:52 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201002122252eucas1p1555a9b0df6f2318ab511117be3f65dee~6LFedUxGs0998509985eucas1p1M;
        Fri,  2 Oct 2020 12:22:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201002122252eusmtrp27a12fe77a97437b5fd9f00766564b87f~6LFecuf3t0226002260eusmtrp2A;
        Fri,  2 Oct 2020 12:22:52 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-4f-5f771b9cfd48
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CE.B0.06017.C9B177F5; Fri,  2
        Oct 2020 13:22:52 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20201002122252eusmtip11711655e6661b1b8089a322115f4cd88~6LFeRkg990741307413eusmtip19;
        Fri,  2 Oct 2020 12:22:52 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?q?Bart=C5=82omiej=20=C5=BBo=C5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v3 3/9] spi: spi-s3c64xx: Check return values
Date:   Fri,  2 Oct 2020 14:22:37 +0200
Message-Id: <20201002122243.26849-4-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201002122243.26849-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsWy7djPc7pzpMvjDZaeVLNY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yW6za9YfR
        gcfj+pJPzB47Z91l99i0qpPNY/OSeo++LasYPT5vkgtgi+KySUnNySxLLdK3S+DK2DD5O1vB
        b42Kh3t7mRoY1yp2MXJwSAiYSKxdU9HFyMUhJLCCUeLU/W1MEM4XRolHb2+zQDifGSXOvl3F
        2sXICdaxac0mdojEcqCWF4eYIZznQFV95xlBqtgEHCX6l55gBUmICGxnkpj4+TzYLGaBo4wS
        mx9cZQGpEhawlbh8ZRpYB4uAqkTPq14WkKt4BayBxmZCrJOXaF++nQ3E5hSwkTi5aBuYzSsg
        KHFy5hOwMfwCWhJrmq6D2cxA9c1bZzND9D5il/j/zAvCdpHYvfY9E4QtLPHq+BZ2CFtG4v/O
        +UyQwKiXmDzJDORMCYEeRoltc36wQNRYS9w594sNpIZZQFNi/S59iLCjxNZN95khWvkkbrwV
        hLiAT2LStulQYV6JjjYhiGoViXX9e6AGSkn0vlrBOIFRaRaSX2YhuX8Wwq4FjMyrGMVTS4tz
        01OLjfJSy/WKE3OLS/PS9ZLzczcxAlPU6X/Hv+xg3PUn6RCjAAejEg+vwIHSeCHWxLLiytxD
        jBIczEoivE5nT8cJ8aYkVlalFuXHF5XmpBYfYpTmYFES5zVe9DJWSCA9sSQ1OzW1ILUIJsvE
        wSnVwDjnXlSr/sload7NMhlP9rV8dw+/df5l+SHNCzKFHEemMN18s3DmuqkXEr4c2GF8ytNk
        7/kJUfFMAUfnsZ6edbfaWmvGfes6idscUsznksTeTNV7KirZ2jRtecK27yqpSwKS9awLn6YW
        33+6MEgw2T8hWi8xrirxqL/jW4PupMMKR9fUv/FbHqbEUpyRaKjFXFScCADLC6OETQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xu7pzpMvjDWa95LVY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yW6za9YfR
        gcfj+pJPzB47Z91l99i0qpPNY/OSeo++LasYPT5vkgtgi9KzKcovLUlVyMgvLrFVija0MNIz
        tLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DL2DD5O1vBb42Kh3t7mRoY1yp2MXJySAiY
        SGxas4kdxBYSWMoosfuzeRcjB1BcSmLl3HSIEmGJP9e62LoYuYBKnjJKdC+/B1bPJuAo0b/0
        BCtIQkRgP5PEpQv3WUAcZoHDjBKX161jAqkSFrCVuHxlGiOIzSKgKtHzqpcFZAOvgLXEqReZ
        EBvkJdqXb2cDsTkFbCROLtrGBnGQtUTrx7msIDavgKDEyZlPwFqZBdQl1s8TAgnzC2hJrGm6
        zgJiMwONad46m3kCo9AsJB2zEDpmIalawMi8ilEktbQ4Nz232EivODG3uDQvXS85P3cTIzAi
        tx37uWUHY9e74EOMAhyMSjy8AgdK44VYE8uKK3MPMUpwMCuJ8DqdPR0nxJuSWFmVWpQfX1Sa
        k1p8iNEU6MuJzFKiyfnAZJFXEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaP
        iYNTqoGx9Ba/1dVUTm2d+ww3gxZfrdXaYvcoLuDkPdEIKcGz26avq7nBtcqPk9E4qshHd32G
        gFnYbcnrn9codb29mTbRo1R7yVsDgcdxb1Q8hVvms8xbzMO1K211veotnSll7sv+WP/klewL
        7btyJHHFt+RrU6+JXBa5/q9Qb3+M7XeRVG3/KGlr3RglluKMREMt5qLiRACUm4u03gIAAA==
X-CMS-MailID: 20201002122252eucas1p1555a9b0df6f2318ab511117be3f65dee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201002122252eucas1p1555a9b0df6f2318ab511117be3f65dee
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201002122252eucas1p1555a9b0df6f2318ab511117be3f65dee
References: <20201002122243.26849-1-l.stelmach@samsung.com>
        <CGME20201002122252eucas1p1555a9b0df6f2318ab511117be3f65dee@eucas1p1.samsung.com>
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
index 4a9ca9a99857..48afd4818558 100644
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

