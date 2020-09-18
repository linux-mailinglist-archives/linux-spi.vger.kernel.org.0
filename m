Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DB826F854
	for <lists+linux-spi@lfdr.de>; Fri, 18 Sep 2020 10:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgIRIbo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Sep 2020 04:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgIRIbj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Sep 2020 04:31:39 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5FBC061788
        for <linux-spi@vger.kernel.org>; Fri, 18 Sep 2020 01:31:38 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id fa1so2786635pjb.0
        for <linux-spi@vger.kernel.org>; Fri, 18 Sep 2020 01:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mxzc9a+AIt4XaKyopJ42uaLRgvLPMA2J58JJPLPnlzc=;
        b=aKWzQy2E785EwAM3zf48FJb9SNxM9DqZ/gBRc2hdvGt4wpySSDDXJpsjYmHjGtfHFg
         Pef8sAkwLXdKucFl0JVcA28XlPywjWT6DIOd/jU30Y3A7jt6NOFX2NGxl2v6yHSy8XPy
         U0V84UjZArDqeNq+9eUQ3y6A7X+a2w20XBgfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mxzc9a+AIt4XaKyopJ42uaLRgvLPMA2J58JJPLPnlzc=;
        b=egNLS+sa6t13rhTLtvg8c0cLxagV7Sp0TN2PsaErKszo2yXPbm2SXpKMqeAcxLYNBM
         4tfOZsFhOS1Cu4v62lnbOEAYlwMLJTNMRSBewJXSxKEF1w21CflnMIJMpKjZOrhLipwk
         OtgB5ZEayuQ6nzvoPq3Mdl/+banchz0nz00ApkPwixlIeiBsk4VhxuLI7hYtnUnz6vxv
         0Ea5O55w+JlqRLFcqc4L7c/Cb+yrYZ/OB7p/hxaxvAmnrQ9p8cM/qQvD6oXvRUB3NCEj
         Vqyzs2wsjrUxQdiEPeJ/z9wsr0Ac+WM/bQH7GAro5AnNwIzZEdiBsMp+XoQqqKbrM5am
         NwgA==
X-Gm-Message-State: AOAM531AM5C5iO9GEbiH2jXedEwIwlSrg5Js+4wguCGTW+EKfofw5bPD
        pjMv1PclIa8m6VKnJS24IUR0hA==
X-Google-Smtp-Source: ABdhPJzBVKAVejjumP8o+IHhjgLXqk+sE9Xn+VoGTnsSVjmfSDXZ5WjU6KJ+Men/NRjcjzHizH5IhA==
X-Received: by 2002:a17:90a:858a:: with SMTP id m10mr11441620pjn.185.1600417898406;
        Fri, 18 Sep 2020 01:31:38 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id g206sm2193172pfb.178.2020.09.18.01.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 01:31:37 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc:     Ikjoon Jang <ikjn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 3/5] spi: spi-mtk-nor: use dma_alloc_coherent() for bounce buffer
Date:   Fri, 18 Sep 2020 16:31:21 +0800
Message-Id: <20200918162834.v2.3.I06cb65401ab5ad63ea30c4788d26633928d80f38@changeid>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200918083124.3921207-1-ikjn@chromium.org>
References: <20200918083124.3921207-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Use dma_alloc_coherent() for bounce buffer instead of kmalloc.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>

---

(no changes since v1)

 drivers/spi/spi-mtk-nor.c | 60 +++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index 54b2c0fde95b..e14798a6e7d0 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -96,6 +96,7 @@ struct mtk_nor {
 	struct device *dev;
 	void __iomem *base;
 	u8 *buffer;
+	dma_addr_t buffer_dma;
 	struct clk *spi_clk;
 	struct clk *ctlr_clk;
 	unsigned int spi_freq;
@@ -275,19 +276,16 @@ static void mtk_nor_setup_bus(struct mtk_nor *sp, const struct spi_mem_op *op)
 	mtk_nor_rmw(sp, MTK_NOR_REG_BUSCFG, reg, MTK_NOR_BUS_MODE_MASK);
 }
 
-static int mtk_nor_read_dma(struct mtk_nor *sp, u32 from, unsigned int length,
-			    u8 *buffer)
+static int read_dma(struct mtk_nor *sp, u32 from, unsigned int length,
+		    dma_addr_t dma_addr)
 {
 	int ret = 0;
 	ulong delay;
 	u32 reg;
-	dma_addr_t dma_addr;
 
-	dma_addr = dma_map_single(sp->dev, buffer, length, DMA_FROM_DEVICE);
-	if (dma_mapping_error(sp->dev, dma_addr)) {
-		dev_err(sp->dev, "failed to map dma buffer.\n");
+	if (WARN_ON((length & MTK_NOR_DMA_ALIGN_MASK) ||
+		    (dma_addr & MTK_NOR_DMA_ALIGN_MASK)))
 		return -EINVAL;
-	}
 
 	writel(from, sp->base + MTK_NOR_REG_DMA_FADR);
 	writel(dma_addr, sp->base + MTK_NOR_REG_DMA_DADR);
@@ -312,30 +310,39 @@ static int mtk_nor_read_dma(struct mtk_nor *sp, u32 from, unsigned int length,
 					 (delay + 1) * 100);
 	}
 
-	dma_unmap_single(sp->dev, dma_addr, length, DMA_FROM_DEVICE);
 	if (ret < 0)
 		dev_err(sp->dev, "dma read timeout.\n");
 
 	return ret;
 }
 
-static int mtk_nor_read_bounce(struct mtk_nor *sp, u32 from,
-			       unsigned int length, u8 *buffer)
+static int mtk_nor_read_dma(struct mtk_nor *sp, u32 from,
+			    unsigned int length, u8 *buffer)
 {
-	unsigned int rdlen;
 	int ret;
+	dma_addr_t dma_addr;
+	bool bounce = need_bounce(buffer, length);
 
-	if (length & MTK_NOR_DMA_ALIGN_MASK)
-		rdlen = (length + MTK_NOR_DMA_ALIGN) & ~MTK_NOR_DMA_ALIGN_MASK;
-	else
-		rdlen = length;
+	if (!bounce) {
+		dma_addr = dma_map_single(sp->dev, buffer, length,
+					  DMA_FROM_DEVICE);
+		if (dma_mapping_error(sp->dev, dma_addr)) {
+			dev_err(sp->dev, "failed to map dma buffer.\n");
+			return -EINVAL;
+		}
+	} else {
+		dma_addr = sp->buffer_dma;
+	}
 
-	ret = mtk_nor_read_dma(sp, from, rdlen, sp->buffer);
-	if (ret)
-		return ret;
+	ret = read_dma(sp, from, length, dma_addr);
 
-	memcpy(buffer, sp->buffer, length);
-	return 0;
+	if (!bounce)
+		dma_unmap_single(sp->dev, dma_addr, length,
+				 DMA_FROM_DEVICE);
+	else
+		memcpy(buffer, sp->buffer, length);
+
+	return ret;
 }
 
 static int mtk_nor_read_pio(struct mtk_nor *sp, const struct spi_mem_op *op)
@@ -439,11 +446,6 @@ static int mtk_nor_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		if (op->data.nbytes == 1) {
 			mtk_nor_set_addr(sp, op);
 			return mtk_nor_read_pio(sp, op);
-		} else if (((ulong)(op->data.buf.in) &
-			    MTK_NOR_DMA_ALIGN_MASK)) {
-			return mtk_nor_read_bounce(sp, op->addr.val,
-						   op->data.nbytes,
-						   op->data.buf.in);
 		} else {
 			return mtk_nor_read_dma(sp, op->addr.val,
 						op->data.nbytes,
@@ -654,6 +656,10 @@ static int mtk_nor_probe(struct platform_device *pdev)
 	sp->dev = &pdev->dev;
 	sp->spi_clk = spi_clk;
 	sp->ctlr_clk = ctlr_clk;
+	sp->buffer = dma_alloc_coherent(&pdev->dev, MTK_NOR_BOUNCE_BUF_SIZE,
+					&sp->buffer_dma, GFP_KERNEL);
+	if (!sp->buffer)
+		return -ENOMEM;
 
 	irq = platform_get_irq_optional(pdev, 0);
 	if (irq < 0) {
@@ -674,6 +680,8 @@ static int mtk_nor_probe(struct platform_device *pdev)
 	ret = mtk_nor_init(sp);
 	if (ret < 0) {
 		kfree(ctlr);
+		dma_free_coherent(&pdev->dev, MTK_NOR_BOUNCE_BUF_SIZE,
+				  sp->buffer, sp->buffer_dma);
 		return ret;
 	}
 
@@ -692,6 +700,8 @@ static int mtk_nor_remove(struct platform_device *pdev)
 
 	mtk_nor_disable_clk(sp);
 
+	dma_free_coherent(&pdev->dev, MTK_NOR_BOUNCE_BUF_SIZE,
+			  sp->buffer, sp->buffer_dma);
 	return 0;
 }
 
-- 
2.28.0.681.g6f77f65b4e-goog

