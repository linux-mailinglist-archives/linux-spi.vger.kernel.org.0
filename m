Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9BC2780F7
	for <lists+linux-spi@lfdr.de>; Fri, 25 Sep 2020 08:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbgIYGyo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Sep 2020 02:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbgIYGyk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 25 Sep 2020 02:54:40 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC10C0613D5
        for <linux-spi@vger.kernel.org>; Thu, 24 Sep 2020 23:54:40 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z19so2237520pfn.8
        for <linux-spi@vger.kernel.org>; Thu, 24 Sep 2020 23:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q1sjz1AOP3RHN+D2U3Yr0dC8Mgj3MJeltuBOhjJoHBE=;
        b=igrI5latvdPt4aE/Cq47rXBxO6po1rbw5Kx731skmFqpAxoNONI26r8BshXxGn08b5
         7rhWAUjAPpJpJmmlqioxbRerj0BO3MtHFX0r04U6ReyaNPpzPYR3EqTGYCkeWawahwEI
         y1+Eg2bUCBNsM2idfI5XtUqmHvNJFgM3c4qZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q1sjz1AOP3RHN+D2U3Yr0dC8Mgj3MJeltuBOhjJoHBE=;
        b=PqRQtA+4GoBLQbm9Oez+GEDG42QIzq+7lTL0LPF7gaupNrFvJHU9kjAAepkbG5hBmw
         bTX7l+w9oP0De0Il6ZsGzIMWhuC6wbpUEynxv8KQXBfSgb46aPEJOeJw6kmZYjOeqU8d
         LWV6gTXdslAKFFyJrCqRhCp2A4aYy0IzWOyA2WNfl3v1Lr9DDY/XYMb6LRyyXnEIEut3
         XMYXt+G1VvXZJtAJL9V0jTon3vI4ddmCm9BCFvC8ZJjkf8Ora/rLb35xDLXmTp1A4NWg
         t4QJF/DRO1Kd+ODG+xdCz14lrN81HbrBCQM5nQXZjmJsm56zIRTo5tXEF9OlPPctHXMw
         3A6w==
X-Gm-Message-State: AOAM532pSQ8aeZwKteReYtkWl4ZBsuiTypV/KQt37GsBI1/L0W3c0lRe
        7nnKIQqkjVNf7JmrpvneNs7Jcw==
X-Google-Smtp-Source: ABdhPJwyB6XORjYiFS8uQ2wfeOioKyeLL0KFpbwVKrof6R1wEMQaX91jqXNpsA2X3ljJjbI6sOtfhg==
X-Received: by 2002:a62:fc06:0:b029:142:2501:397d with SMTP id e6-20020a62fc060000b02901422501397dmr2805467pfh.66.1601016880071;
        Thu, 24 Sep 2020 23:54:40 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id x27sm1549612pfp.128.2020.09.24.23.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 23:54:39 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc:     Ikjoon Jang <ikjn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 5/6] spi: spi-mtk-nor: support 36bit dma addressing
Date:   Fri, 25 Sep 2020 14:54:16 +0800
Message-Id: <20200925145255.v3.5.Id1cb208392928afc7ceed4de06924243c7858cd0@changeid>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200925065418.1077472-1-ikjn@chromium.org>
References: <20200925065418.1077472-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch enables 36bit dma address support to spi-mtk-nor.
Currently this is enabled only for mt8192-nor.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---

(no changes since v1)

 drivers/spi/spi-mtk-nor.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index 8dbafee7f431..35205635ed42 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -78,6 +78,8 @@
 #define MTK_NOR_REG_DMA_FADR		0x71c
 #define MTK_NOR_REG_DMA_DADR		0x720
 #define MTK_NOR_REG_DMA_END_DADR	0x724
+#define MTK_NOR_REG_DMA_DADR_HB		0x738
+#define MTK_NOR_REG_DMA_END_DADR_HB	0x73c
 
 /* maximum bytes of TX in PRG mode */
 #define MTK_NOR_PRG_MAX_SIZE		6
@@ -106,6 +108,7 @@ struct mtk_nor {
 	unsigned int spi_freq;
 	bool wbuf_en;
 	bool has_irq;
+	bool high_dma;
 	struct completion op_done;
 };
 
@@ -305,6 +308,11 @@ static int mtk_nor_dma_exec(struct mtk_nor *sp, u32 from, unsigned int length,
 	writel(dma_addr, sp->base + MTK_NOR_REG_DMA_DADR);
 	writel(dma_addr + length, sp->base + MTK_NOR_REG_DMA_END_DADR);
 
+	if (sp->high_dma) {
+		writel(dma_addr >> 32, sp->base + MTK_NOR_REG_DMA_DADR_HB);
+		writel((dma_addr + length) >> 32, sp->base + MTK_NOR_REG_DMA_END_DADR_HB);
+	}
+
 	if (sp->has_irq) {
 		reinit_completion(&sp->op_done);
 		mtk_nor_rmw(sp, MTK_NOR_REG_IRQ_EN, MTK_NOR_IRQ_DMA, 0);
@@ -635,7 +643,8 @@ static const struct spi_controller_mem_ops mtk_nor_mem_ops = {
 };
 
 static const struct of_device_id mtk_nor_match[] = {
-	{ .compatible = "mediatek,mt8173-nor" },
+	{ .compatible = "mediatek,mt8192-nor", .data = (void *)36 },
+	{ .compatible = "mediatek,mt8173-nor", .data = (void *)32 },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mtk_nor_match);
@@ -647,6 +656,7 @@ static int mtk_nor_probe(struct platform_device *pdev)
 	void __iomem *base;
 	struct clk *spi_clk, *ctlr_clk;
 	int ret, irq;
+	unsigned long dma_bits;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
@@ -660,6 +670,12 @@ static int mtk_nor_probe(struct platform_device *pdev)
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
-- 
2.28.0.681.g6f77f65b4e-goog

