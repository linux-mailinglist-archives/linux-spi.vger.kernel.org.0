Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71CC2AEC7A
	for <lists+linux-spi@lfdr.de>; Wed, 11 Nov 2020 09:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgKKIzQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Nov 2020 03:55:16 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:48845 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725986AbgKKIzQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Nov 2020 03:55:16 -0500
X-UUID: 616b040ac8054539bc8df0256bdbf60c-20201111
X-UUID: 616b040ac8054539bc8df0256bdbf60c-20201111
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <bayi.cheng@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1352437981; Wed, 11 Nov 2020 16:55:09 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 Nov 2020 16:55:07 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 11 Nov 2020 16:55:07 +0800
From:   Bayi Cheng <bayi.cheng@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ikjoon Jang <ikjn@chromium.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        <srv_heupstream@mediatek.com>, bayi cheng <bayi.cheng@mediatek.com>
Subject: [PATCH v1] spi: spi-mtk-nor: add axi clock control for MT8192 spi-nor
Date:   Wed, 11 Nov 2020 16:55:02 +0800
Message-ID: <1605084902-13151-2-git-send-email-bayi.cheng@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1605084902-13151-1-git-send-email-bayi.cheng@mediatek.com>
References: <1605084902-13151-1-git-send-email-bayi.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: bayi cheng <bayi.cheng@mediatek.com>

MT8192 spi-nor is an independent sub system, we need extra control axi
bus clock for it. Add support for the additional axi clock to allow it
to be configured appropriately.

Signed-off-by: bayi cheng <bayi.cheng@mediatek.com>
---
 drivers/spi/spi-mtk-nor.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index b97f26a..bf2d0f9 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -103,6 +103,7 @@ struct mtk_nor {
 	dma_addr_t buffer_dma;
 	struct clk *spi_clk;
 	struct clk *ctlr_clk;
+	struct clk *axi_clk;
 	unsigned int spi_freq;
 	bool wbuf_en;
 	bool has_irq;
@@ -672,6 +673,7 @@ static void mtk_nor_disable_clk(struct mtk_nor *sp)
 {
 	clk_disable_unprepare(sp->spi_clk);
 	clk_disable_unprepare(sp->ctlr_clk);
+	clk_disable_unprepare(sp->axi_clk);
 }
 
 static int mtk_nor_enable_clk(struct mtk_nor *sp)
@@ -688,6 +690,13 @@ static int mtk_nor_enable_clk(struct mtk_nor *sp)
 		return ret;
 	}
 
+	ret = clk_prepare_enable(sp->axi_clk);
+	if (ret) {
+		clk_disable_unprepare(sp->spi_clk);
+		clk_disable_unprepare(sp->ctlr_clk);
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -746,7 +755,7 @@ static int mtk_nor_probe(struct platform_device *pdev)
 	struct spi_controller *ctlr;
 	struct mtk_nor *sp;
 	void __iomem *base;
-	struct clk *spi_clk, *ctlr_clk;
+	struct clk *spi_clk, *ctlr_clk, *axi_clk;
 	int ret, irq;
 	unsigned long dma_bits;
 
@@ -762,6 +771,10 @@ static int mtk_nor_probe(struct platform_device *pdev)
 	if (IS_ERR(ctlr_clk))
 		return PTR_ERR(ctlr_clk);
 
+	axi_clk = devm_clk_get_optional(&pdev->dev, "axi");
+	if (IS_ERR(axi_clk))
+		return PTR_ERR(axi_clk);
+
 	dma_bits = (unsigned long)of_device_get_match_data(&pdev->dev);
 	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(dma_bits))) {
 		dev_err(&pdev->dev, "failed to set dma mask(%lu)\n", dma_bits);
@@ -794,6 +807,7 @@ static int mtk_nor_probe(struct platform_device *pdev)
 	sp->dev = &pdev->dev;
 	sp->spi_clk = spi_clk;
 	sp->ctlr_clk = ctlr_clk;
+	sp->axi_clk = axi_clk;
 	sp->high_dma = (dma_bits > 32);
 	sp->buffer = dmam_alloc_coherent(&pdev->dev,
 				MTK_NOR_BOUNCE_BUF_SIZE + MTK_NOR_DMA_ALIGN,
-- 
1.9.1

