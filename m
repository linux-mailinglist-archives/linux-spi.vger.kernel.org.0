Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7C627BE2C
	for <lists+linux-spi@lfdr.de>; Tue, 29 Sep 2020 09:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbgI2Hit (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Sep 2020 03:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbgI2Hir (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Sep 2020 03:38:47 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87876C0613D0
        for <linux-spi@vger.kernel.org>; Tue, 29 Sep 2020 00:38:47 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s31so3154379pga.7
        for <linux-spi@vger.kernel.org>; Tue, 29 Sep 2020 00:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Kh1cgPE0z6ZaYTa5OCqa2rDxMEmjbF1J+zo1XE6Dzc=;
        b=QNnAm1umIqZw/2DLvd2wp3irYnYcyua/7QVqZM1qQ0IAu261zfNJya2qYqYVA9mpbd
         e6AJPlCGYWmh5BcSJBgbVx0pEf0KcBKlavOi25/linNkqEh14DI+RBfRo9/Ek05pBI8f
         xYWjZTx8PO8JSbr8OU4nD8Ji4AJsHWxsEVcIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Kh1cgPE0z6ZaYTa5OCqa2rDxMEmjbF1J+zo1XE6Dzc=;
        b=O15G1BOrLzeJnnNqUNrJCzsxi2Dq1ni+mLQiyLs9h4dUVMMmpNF0HlZkUmr6AL3FZN
         aDyYg7RPDG3oaayJS5/nigesf031De2xHZpneDDAqgja0RhAwnW4nJkzzuRJ7q0Gmb2l
         y9EiFE2U3JmWuCJEJE+V4LrgEb6SJw798L9ADUpKGs6N9KxCNEBts2ThUJcoG6YEFaC/
         TRbQpgP/CMGHibHMuMJEcLLZlZ8lMR3JA6vGG6y0aC66DaQHtetxCjYwrlqBHcq4Z6BT
         5imVSv7qysX68FeePvBp21SL0labgDy03CWzRY6tAU5utNmKMpO9wrNWP6Nw9uMdYRx4
         KwDA==
X-Gm-Message-State: AOAM533OlWCxI5LC6WQi5kR1ILNOLz0e/Nqj4SLM8zwOPVyg13vYayWc
        lVsQfoKNbZcY5MA5rzD6yzilsQ==
X-Google-Smtp-Source: ABdhPJyeKEeCFO9drJ59wOuGzyqYVRMXtgWAOmJ66srgwVHkEYZLkS53C9kvpTmRMDRnznNtWJA/Xg==
X-Received: by 2002:a17:902:9349:b029:d0:cb2d:f26c with SMTP id g9-20020a1709029349b02900d0cb2df26cmr3263756plp.5.1601365127053;
        Tue, 29 Sep 2020 00:38:47 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id e13sm3737317pjy.38.2020.09.29.00.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 00:38:46 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc:     Ikjoon Jang <ikjn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 3/4] spi: spi-mtk-nor: support 36bit dma addressing
Date:   Tue, 29 Sep 2020 15:37:54 +0800
Message-Id: <20200929153320.v4.3.Id1cb208392928afc7ceed4de06924243c7858cd0@changeid>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
In-Reply-To: <20200929073755.3741416-1-ikjn@chromium.org>
References: <20200929073755.3741416-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch enables 36bit dma address support to spi-mtk-nor.
Currently this is enabled only for mt8192-nor.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---

Changes in v4:
- Fix 0-day ci warning from shifting 32bit value
- Fix missing initialization of internal flags, 'high_dma'

 drivers/spi/spi-mtk-nor.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index cfb9a2450962..eac613b3930d 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -78,6 +78,8 @@
 #define MTK_NOR_REG_DMA_FADR		0x71c
 #define MTK_NOR_REG_DMA_DADR		0x720
 #define MTK_NOR_REG_DMA_END_DADR	0x724
+#define MTK_NOR_REG_DMA_DADR_HB		0x738
+#define MTK_NOR_REG_DMA_END_DADR_HB	0x73c
 
 #define MTK_NOR_PRG_MAX_SIZE		6
 // Reading DMA src/dst addresses have to be 16-byte aligned
@@ -102,6 +104,7 @@ struct mtk_nor {
 	unsigned int spi_freq;
 	bool wbuf_en;
 	bool has_irq;
+	bool high_dma;
 	struct completion op_done;
 };
 
@@ -278,6 +281,13 @@ static int mtk_nor_dma_exec(struct mtk_nor *sp, u32 from, unsigned int length,
 	writel(dma_addr, sp->base + MTK_NOR_REG_DMA_DADR);
 	writel(dma_addr + length, sp->base + MTK_NOR_REG_DMA_END_DADR);
 
+	if (sp->high_dma) {
+		writel(upper_32_bits(dma_addr),
+		       sp->base + MTK_NOR_REG_DMA_DADR_HB);
+		writel(upper_32_bits(dma_addr + length),
+		       sp->base + MTK_NOR_REG_DMA_END_DADR_HB);
+	}
+
 	if (sp->has_irq) {
 		reinit_completion(&sp->op_done);
 		mtk_nor_rmw(sp, MTK_NOR_REG_IRQ_EN, MTK_NOR_IRQ_DMA, 0);
@@ -589,7 +599,8 @@ static const struct spi_controller_mem_ops mtk_nor_mem_ops = {
 };
 
 static const struct of_device_id mtk_nor_match[] = {
-	{ .compatible = "mediatek,mt8173-nor" },
+	{ .compatible = "mediatek,mt8192-nor", .data = (void *)36 },
+	{ .compatible = "mediatek,mt8173-nor", .data = (void *)32 },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mtk_nor_match);
@@ -601,6 +612,7 @@ static int mtk_nor_probe(struct platform_device *pdev)
 	void __iomem *base;
 	struct clk *spi_clk, *ctlr_clk;
 	int ret, irq;
+	unsigned long dma_bits;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
@@ -614,6 +626,12 @@ static int mtk_nor_probe(struct platform_device *pdev)
 	if (IS_ERR(ctlr_clk))
 		return PTR_ERR(ctlr_clk);
 
+	dma_bits = (unsigned long)of_device_get_match_data(&pdev->dev);
+	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(dma_bits))) {
+		dev_err(&pdev->dev, "failed to set dma mask(%lu)\n", dma_bits);
+		return -EINVAL;
+	}
+
 	ctlr = spi_alloc_master(&pdev->dev, sizeof(*sp));
 	if (!ctlr) {
 		dev_err(&pdev->dev, "failed to allocate spi controller\n");
@@ -639,6 +657,7 @@ static int mtk_nor_probe(struct platform_device *pdev)
 	sp->dev = &pdev->dev;
 	sp->spi_clk = spi_clk;
 	sp->ctlr_clk = ctlr_clk;
+	sp->high_dma = (dma_bits > 32);
 	sp->buffer = dmam_alloc_coherent(&pdev->dev,
 				MTK_NOR_BOUNCE_BUF_SIZE + MTK_NOR_DMA_ALIGN,
 				&sp->buffer_dma, GFP_KERNEL);
-- 
2.28.0.709.gb0816b6eb0-goog

