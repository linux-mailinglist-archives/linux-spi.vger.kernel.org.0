Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7742B2847EE
	for <lists+linux-spi@lfdr.de>; Tue,  6 Oct 2020 09:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbgJFHyV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 6 Oct 2020 03:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727214AbgJFHyV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 6 Oct 2020 03:54:21 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BDEC0613D2
        for <linux-spi@vger.kernel.org>; Tue,  6 Oct 2020 00:54:21 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id h2so815789pll.11
        for <linux-spi@vger.kernel.org>; Tue, 06 Oct 2020 00:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+6PvurjL54TX+y1/PrJh4kuSmSzUHQBfsfDBvhGtO0Q=;
        b=LNtpACrZ8QtTYX8EgAopthIK0bClQe8ZiTLpReJ07bZ9/zLcTwKlzsxX4ZdoDUdy3x
         9dghrilIND6vA+NcOkkScrBu4EmutgVlpYaoJB9MCFAWVyFUG4egXCit/P1JaK2wDWR1
         KntfDGXd3Vb4HlbctW0At8LyBY5dCh/oQ+SJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+6PvurjL54TX+y1/PrJh4kuSmSzUHQBfsfDBvhGtO0Q=;
        b=NTpuPuYLTYA3p4ni9gPJ/rTcNt7LznPqOVLNE/IQbrfd688KNG0nYhALYgmjOTpuI5
         wXMTcJrsEshoWQM7/lEmSMKCu2WTQttpSLs8iwKmEFKs6oCXmTChxxVE+Vt5EDr3X0GO
         cKtanUBo541Fv8GYrz1kEsw1vzBHCRpSpMAflxcmXPEwb5Lbi1U/+7tvbuPlJZHjjZZU
         i47orAhAOtzLKyEc2spWa1psWYnPTnu8R9WGPkHi6UtG+PDmVU0i1yCYKVSSn6XPBS3x
         Nhr8mblPoDnCODiEuE4SXMxsbU0RrWTWCOJ3iyhmMBlZJHxuFlf8Qt94j66wgJSMxYIB
         HQkA==
X-Gm-Message-State: AOAM532SomJKa+qDHKXZlXW+XhwWWgOi3sLLQCjWT4y7Kem5QZ8Xo9dh
        VDNqiFreyMXlSTg906dMKguVLw==
X-Google-Smtp-Source: ABdhPJzhB+1be3wZjtai4CvszEV3UFQDP61BCOBkwhy382pX4F4n6lVjY7j9a/5gcKfhKpVJ5IebIw==
X-Received: by 2002:a17:902:6ac1:b029:d3:b3bd:b66e with SMTP id i1-20020a1709026ac1b02900d3b3bdb66emr2180366plt.21.1601970860839;
        Tue, 06 Oct 2020 00:54:20 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id r6sm2545147pfq.11.2020.10.06.00.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 00:54:20 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc:     Ikjoon Jang <ikjn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v5 3/4] spi: spi-mtk-nor: support 36bit dma addressing
Date:   Tue,  6 Oct 2020 15:54:04 +0800
Message-Id: <20201006155010.v5.3.Id1cb208392928afc7ceed4de06924243c7858cd0@changeid>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
In-Reply-To: <20201006075405.11658-1-ikjn@chromium.org>
References: <20201006075405.11658-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch enables 36bit dma address support to spi-mtk-nor.
Currently this is enabled only for mt8192-nor.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---
 drivers/spi/spi-mtk-nor.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index c11bed28b952..e46d5c93d742 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -79,6 +79,8 @@
 #define MTK_NOR_REG_DMA_FADR		0x71c
 #define MTK_NOR_REG_DMA_DADR		0x720
 #define MTK_NOR_REG_DMA_END_DADR	0x724
+#define MTK_NOR_REG_DMA_DADR_HB		0x738
+#define MTK_NOR_REG_DMA_END_DADR_HB	0x73c
 
 #define MTK_NOR_PRG_MAX_SIZE		6
 // Reading DMA src/dst addresses have to be 16-byte aligned
@@ -103,6 +105,7 @@ struct mtk_nor {
 	unsigned int spi_freq;
 	bool wbuf_en;
 	bool has_irq;
+	bool high_dma;
 	struct completion op_done;
 };
 
@@ -343,6 +346,13 @@ static int mtk_nor_dma_exec(struct mtk_nor *sp, u32 from, unsigned int length,
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
@@ -731,7 +741,8 @@ static const struct spi_controller_mem_ops mtk_nor_mem_ops = {
 };
 
 static const struct of_device_id mtk_nor_match[] = {
-	{ .compatible = "mediatek,mt8173-nor" },
+	{ .compatible = "mediatek,mt8192-nor", .data = (void *)36 },
+	{ .compatible = "mediatek,mt8173-nor", .data = (void *)32 },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mtk_nor_match);
@@ -743,6 +754,7 @@ static int mtk_nor_probe(struct platform_device *pdev)
 	void __iomem *base;
 	struct clk *spi_clk, *ctlr_clk;
 	int ret, irq;
+	unsigned long dma_bits;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
@@ -756,6 +768,12 @@ static int mtk_nor_probe(struct platform_device *pdev)
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
@@ -781,6 +799,7 @@ static int mtk_nor_probe(struct platform_device *pdev)
 	sp->dev = &pdev->dev;
 	sp->spi_clk = spi_clk;
 	sp->ctlr_clk = ctlr_clk;
+	sp->high_dma = (dma_bits > 32);
 	sp->buffer = dmam_alloc_coherent(&pdev->dev,
 				MTK_NOR_BOUNCE_BUF_SIZE + MTK_NOR_DMA_ALIGN,
 				&sp->buffer_dma, GFP_KERNEL);
-- 
2.28.0.806.g8561365e88-goog

