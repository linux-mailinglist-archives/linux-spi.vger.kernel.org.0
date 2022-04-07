Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EC44F7E3C
	for <lists+linux-spi@lfdr.de>; Thu,  7 Apr 2022 13:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244897AbiDGLqr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Apr 2022 07:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244881AbiDGLqo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Apr 2022 07:46:44 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA98F18FAEE;
        Thu,  7 Apr 2022 04:44:44 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E4F001F4613A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649331883;
        bh=dPxlhSVYd600fL3YUjgSwJ0toHgDWrLLNeaN31UMFzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YgX+n5RSJhXdgBvQxEYR8TQbfpy1pjatHHsEi0WKImrFpKqLxPDnF7+GufJY/KgM/
         neXdQgsBYzaEj+e6bhEfQhEoJUoEmND1rzTadEeXe4fHt1Sb+v1WPyDzJdskTLKMYT
         FSdpWtw02tGmx7rH4sdgfRCVltPk6VtGSkb/mGpreqK/glXKC7YS94+sWzgIAkIw0K
         DkT5XJgb+loRXQPOcEPtBvGLZ+yJbFmvNWZMr0jDa8CT38tZBnKM3nbvDViSloz1CL
         SVHoxDq8Awl43Tt9n28SFrOBngO4/V5kzKSN+hrvTVd7Z1PygN9b/wkjufMUHFDHd+
         IXLw1uOFkHS3g==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     broonie@kernel.org
Cc:     matthias.bgg@gmail.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 3/8] spi: mt65xx: Add and use pointer to struct device in mtk_spi_probe()
Date:   Thu,  7 Apr 2022 13:44:23 +0200
Message-Id: <20220407114428.167091-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407114428.167091-1-angelogioacchino.delregno@collabora.com>
References: <20220407114428.167091-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In preparation for switching to dev_err_probe() in this function, add
a pointer to struct device and replace all occurrences of '&pdev->dev'
to using this 'dev' pointer.
This is done for one-line fitting of the dev_err_probe() calls.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-mt65xx.c | 70 ++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 4e0b520f9abe..250a508427ee 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -1082,18 +1082,19 @@ static const struct spi_controller_mem_ops mtk_spi_mem_ops = {
 
 static int mtk_spi_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct spi_master *master;
 	struct mtk_spi *mdata;
 	int i, irq, ret, addr_bits;
 
-	master = devm_spi_alloc_master(&pdev->dev, sizeof(*mdata));
+	master = devm_spi_alloc_master(dev, sizeof(*mdata));
 	if (!master) {
-		dev_err(&pdev->dev, "failed to alloc spi master\n");
+		dev_err(dev, "failed to alloc spi master\n");
 		return -ENOMEM;
 	}
 
 	master->auto_runtime_pm = true;
-	master->dev.of_node = pdev->dev.of_node;
+	master->dev.of_node = dev->of_node;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
 
 	master->set_cs = mtk_spi_set_cs;
@@ -1105,7 +1106,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	master->use_gpio_descriptors = true;
 
 	mdata = spi_master_get_devdata(master);
-	mdata->dev_comp = device_get_match_data(&pdev->dev);
+	mdata->dev_comp = device_get_match_data(dev);
 
 	if (mdata->dev_comp->enhance_timing)
 		master->mode_bits |= SPI_CS_HIGH;
@@ -1116,32 +1117,31 @@ static int mtk_spi_probe(struct platform_device *pdev)
 		master->mode_bits |= SPI_LOOP;
 
 	if (mdata->dev_comp->ipm_design) {
-		mdata->dev = &pdev->dev;
+		mdata->dev = dev;
 		master->mem_ops = &mtk_spi_mem_ops;
 		init_completion(&mdata->spimem_done);
 	}
 
 	if (mdata->dev_comp->need_pad_sel) {
-		mdata->pad_num = of_property_count_u32_elems(
-			pdev->dev.of_node,
+		mdata->pad_num = of_property_count_u32_elems(dev->of_node,
 			"mediatek,pad-select");
 		if (mdata->pad_num < 0) {
-			dev_err(&pdev->dev,
+			dev_err(dev,
 				"No 'mediatek,pad-select' property\n");
 			return -EINVAL;
 		}
 
-		mdata->pad_sel = devm_kmalloc_array(&pdev->dev, mdata->pad_num,
+		mdata->pad_sel = devm_kmalloc_array(dev, mdata->pad_num,
 						    sizeof(u32), GFP_KERNEL);
 		if (!mdata->pad_sel)
 			return -ENOMEM;
 
 		for (i = 0; i < mdata->pad_num; i++) {
-			of_property_read_u32_index(pdev->dev.of_node,
+			of_property_read_u32_index(dev->of_node,
 						   "mediatek,pad-select",
 						   i, &mdata->pad_sel[i]);
 			if (mdata->pad_sel[i] > MT8173_SPI_MAX_PAD_SEL) {
-				dev_err(&pdev->dev, "wrong pad-sel[%d]: %u\n",
+				dev_err(dev, "wrong pad-sel[%d]: %u\n",
 					i, mdata->pad_sel[i]);
 				return -EINVAL;
 			}
@@ -1157,59 +1157,59 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	if (!pdev->dev.dma_mask)
-		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
+	if (!dev->dma_mask)
+		dev->dma_mask = &dev->coherent_dma_mask;
 
-	ret = devm_request_irq(&pdev->dev, irq, mtk_spi_interrupt,
-			       IRQF_TRIGGER_NONE, dev_name(&pdev->dev), master);
+	ret = devm_request_irq(dev, irq, mtk_spi_interrupt,
+			       IRQF_TRIGGER_NONE, dev_name(dev), master);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to register irq (%d)\n", ret);
+		dev_err(dev, "failed to register irq (%d)\n", ret);
 		return ret;
 	}
 
-	mdata->parent_clk = devm_clk_get(&pdev->dev, "parent-clk");
+	mdata->parent_clk = devm_clk_get(dev, "parent-clk");
 	if (IS_ERR(mdata->parent_clk)) {
 		ret = PTR_ERR(mdata->parent_clk);
-		dev_err(&pdev->dev, "failed to get parent-clk: %d\n", ret);
+		dev_err(dev, "failed to get parent-clk: %d\n", ret);
 		return ret;
 	}
 
-	mdata->sel_clk = devm_clk_get(&pdev->dev, "sel-clk");
+	mdata->sel_clk = devm_clk_get(dev, "sel-clk");
 	if (IS_ERR(mdata->sel_clk)) {
 		ret = PTR_ERR(mdata->sel_clk);
-		dev_err(&pdev->dev, "failed to get sel-clk: %d\n", ret);
+		dev_err(dev, "failed to get sel-clk: %d\n", ret);
 		return ret;
 	}
 
-	mdata->spi_clk = devm_clk_get(&pdev->dev, "spi-clk");
+	mdata->spi_clk = devm_clk_get(dev, "spi-clk");
 	if (IS_ERR(mdata->spi_clk)) {
 		ret = PTR_ERR(mdata->spi_clk);
-		dev_err(&pdev->dev, "failed to get spi-clk: %d\n", ret);
+		dev_err(dev, "failed to get spi-clk: %d\n", ret);
 		return ret;
 	}
 
-	mdata->spi_hclk = devm_clk_get_optional(&pdev->dev, "hclk");
+	mdata->spi_hclk = devm_clk_get_optional(dev, "hclk");
 	if (IS_ERR(mdata->spi_hclk)) {
 		ret = PTR_ERR(mdata->spi_hclk);
-		dev_err(&pdev->dev, "failed to get hclk: %d\n", ret);
+		dev_err(dev, "failed to get hclk: %d\n", ret);
 		return ret;
 	}
 
 	ret = clk_prepare_enable(mdata->spi_hclk);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to enable hclk (%d)\n", ret);
+		dev_err(dev, "failed to enable hclk (%d)\n", ret);
 		return ret;
 	}
 
 	ret = clk_prepare_enable(mdata->spi_clk);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to enable spi_clk (%d)\n", ret);
+		dev_err(dev, "failed to enable spi_clk (%d)\n", ret);
 		goto err_disable_spi_hclk;
 	}
 
 	ret = clk_set_parent(mdata->sel_clk, mdata->parent_clk);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to clk_set_parent (%d)\n", ret);
+		dev_err(dev, "failed to clk_set_parent (%d)\n", ret);
 		goto err_disable_spi_clk;
 	}
 
@@ -1223,11 +1223,11 @@ static int mtk_spi_probe(struct platform_device *pdev)
 		clk_disable_unprepare(mdata->spi_hclk);
 	}
 
-	pm_runtime_enable(&pdev->dev);
+	pm_runtime_enable(dev);
 
 	if (mdata->dev_comp->need_pad_sel) {
 		if (mdata->pad_num != master->num_chipselect) {
-			dev_err(&pdev->dev,
+			dev_err(dev,
 				"pad_num does not match num_chipselect(%d != %d)\n",
 				mdata->pad_num, master->num_chipselect);
 			ret = -EINVAL;
@@ -1235,7 +1235,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 		}
 
 		if (!master->cs_gpiods && master->num_chipselect > 1) {
-			dev_err(&pdev->dev,
+			dev_err(dev,
 				"cs_gpios not specified and num_chipselect > 1\n");
 			ret = -EINVAL;
 			goto err_disable_runtime_pm;
@@ -1246,21 +1246,21 @@ static int mtk_spi_probe(struct platform_device *pdev)
 		addr_bits = DMA_ADDR_EXT_BITS;
 	else
 		addr_bits = DMA_ADDR_DEF_BITS;
-	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(addr_bits));
+	ret = dma_set_mask(dev, DMA_BIT_MASK(addr_bits));
 	if (ret)
-		dev_notice(&pdev->dev, "SPI dma_set_mask(%d) failed, ret:%d\n",
+		dev_notice(dev, "SPI dma_set_mask(%d) failed, ret:%d\n",
 			   addr_bits, ret);
 
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = devm_spi_register_master(dev, master);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to register master (%d)\n", ret);
+		dev_err(dev, "failed to register master (%d)\n", ret);
 		goto err_disable_runtime_pm;
 	}
 
 	return 0;
 
 err_disable_runtime_pm:
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_disable(dev);
 err_disable_spi_clk:
 	clk_disable_unprepare(mdata->spi_clk);
 err_disable_spi_hclk:
-- 
2.35.1

