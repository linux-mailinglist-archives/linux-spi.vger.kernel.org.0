Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556D226F853
	for <lists+linux-spi@lfdr.de>; Fri, 18 Sep 2020 10:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgIRIbo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Sep 2020 04:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgIRIbn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Sep 2020 04:31:43 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8543FC06174A
        for <linux-spi@vger.kernel.org>; Fri, 18 Sep 2020 01:31:43 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id fa1so2786764pjb.0
        for <linux-spi@vger.kernel.org>; Fri, 18 Sep 2020 01:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WhcfZzUawu7IGCGdEVtnYYchZjnf9bfpM7EHLtCGyWY=;
        b=HAjR/a3E0C2jC7NrUpZ9xj59sZPMOz27K/Kdvjiz9t8WwPWDenQ6XauQVUNFx3kO8I
         K8PXTTV4jNU/f5mPOWsbWK7WzxICQ8rC1X1iUKDFeVQYFi6YjDY9rgiVZpL9C82Iy5Ae
         N+5JHwtH/iZu5U4jmeEHe1Kwwu+EkYTmW7DDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WhcfZzUawu7IGCGdEVtnYYchZjnf9bfpM7EHLtCGyWY=;
        b=e/yqm0x/zqyY2piLei1lynr0ebgPyE/8M+Lqk++k56R13fm4nBvHKmobI/xKo/aYu5
         JjJSvnY2BirXAde6ucxnXcQ+6mShB+OEt5sKxMVjEAx0u13T/HN57pvx/tLHeSl9zQBV
         J1WFjY/PpHHv3YQE5aQO7TB7CwPCHE335eZrN1VODM07D8W03sSOnTXmqdiUG/cql00/
         FfpyfUjjsPfim22iUM0fPZqlLyP78mmvhGsGL4MSJMNClmbNJDHUcxjPoUAzkWg+lzaM
         mSJqWZezlIbvydujwDV/SqXk3G9YhHfA5PgTHyPUXAQviRupJZHA/LS3J9bWOx5cGv2n
         Fd6A==
X-Gm-Message-State: AOAM532ycnrlXVQWzisVOwp3L0jRfzgl/93pi6xXdxfCLx9gb6K5s1F1
        9TSL0isaX5OHAz0+G+/7JSJaIQ==
X-Google-Smtp-Source: ABdhPJx762UucxyaZ+w3YSAoNix0FtNYzia6auJ1wmsqxmDPSBJ1DH8Rvp53SOa+u1Mdzj1EiZyJDg==
X-Received: by 2002:a17:902:9343:b029:d1:f3e1:c190 with SMTP id g3-20020a1709029343b02900d1f3e1c190mr9661647plp.2.1600417903054;
        Fri, 18 Sep 2020 01:31:43 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id g206sm2193172pfb.178.2020.09.18.01.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 01:31:42 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc:     Ikjoon Jang <ikjn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 5/5] spi: spi-mtk-nor: Add power management support
Date:   Fri, 18 Sep 2020 16:31:23 +0800
Message-Id: <20200918162834.v2.5.I68983b582d949a91866163bab588ff3c2a0d0275@changeid>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200918083124.3921207-1-ikjn@chromium.org>
References: <20200918083124.3921207-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch adds dev_pm_ops to mtk-nor to support suspend/resume,
auto suspend delay is set to -1 by default.

Accessing registers are delayed after enabling clocks
to deal with unknown state of clocks at probe time,

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---

 drivers/spi/spi-mtk-nor.c | 105 +++++++++++++++++++++++++++++---------
 1 file changed, 80 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index 99dd5dca744e..5dcd575998d9 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 #include <linux/string.h>
@@ -551,22 +552,15 @@ static int mtk_nor_enable_clk(struct mtk_nor *sp)
 	return 0;
 }
 
-static int mtk_nor_init(struct mtk_nor *sp)
+static void mtk_nor_init(struct mtk_nor *sp)
 {
-	int ret;
-
-	ret = mtk_nor_enable_clk(sp);
-	if (ret)
-		return ret;
-
-	sp->spi_freq = clk_get_rate(sp->spi_clk);
+	writel(0, sp->base + MTK_NOR_REG_IRQ_EN);
+	writel(MTK_NOR_IRQ_MASK, sp->base + MTK_NOR_REG_IRQ_STAT);
 
 	writel(MTK_NOR_ENABLE_SF_CMD, sp->base + MTK_NOR_REG_WP);
 	mtk_nor_rmw(sp, MTK_NOR_REG_CFG2, MTK_NOR_WR_CUSTOM_OP_EN, 0);
 	mtk_nor_rmw(sp, MTK_NOR_REG_CFG3,
 		    MTK_NOR_DISABLE_WREN | MTK_NOR_DISABLE_SR_POLL, 0);
-
-	return ret;
 }
 
 static irqreturn_t mtk_nor_irq_handler(int irq, void *data)
@@ -630,6 +624,11 @@ static int mtk_nor_probe(struct platform_device *pdev)
 	if (IS_ERR(ctlr_clk))
 		return PTR_ERR(ctlr_clk);
 
+	irq = platform_get_irq_optional(pdev, 0);
+
+	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(36)))
+		dev_warn(&pdev->dev, "failed to set dma mask(36)\n");
+
 	buffer = devm_kmalloc(&pdev->dev,
 			      MTK_NOR_BOUNCE_BUF_SIZE + MTK_NOR_DMA_ALIGN,
 			      GFP_KERNEL);
@@ -661,6 +660,7 @@ static int mtk_nor_probe(struct platform_device *pdev)
 	ctlr->num_chipselect = 1;
 	ctlr->setup = mtk_nor_setup;
 	ctlr->transfer_one_message = mtk_nor_transfer_one_message;
+	ctlr->auto_runtime_pm = true;
 
 	dev_set_drvdata(&pdev->dev, ctlr);
 
@@ -678,12 +678,17 @@ static int mtk_nor_probe(struct platform_device *pdev)
 	if (!sp->buffer)
 		return -ENOMEM;
 
-	irq = platform_get_irq_optional(pdev, 0);
+	ret = mtk_nor_enable_clk(sp);
+	if (ret < 0)
+		return ret;
+
+	sp->spi_freq = clk_get_rate(sp->spi_clk);
+
+	mtk_nor_init(sp);
+
 	if (irq < 0) {
 		dev_warn(sp->dev, "IRQ not available.");
 	} else {
-		writel(MTK_NOR_IRQ_MASK, base + MTK_NOR_REG_IRQ_STAT);
-		writel(0, base + MTK_NOR_REG_IRQ_EN);
 		ret = devm_request_irq(sp->dev, irq, mtk_nor_irq_handler, 0,
 				       pdev->name, sp);
 		if (ret < 0) {
@@ -694,26 +699,41 @@ static int mtk_nor_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = mtk_nor_init(sp);
-	if (ret < 0) {
-		kfree(ctlr);
-		dma_free_coherent(&pdev->dev, MTK_NOR_BOUNCE_BUF_SIZE,
-				  sp->buffer, sp->buffer_dma);
-		return ret;
-	}
+	pm_runtime_set_autosuspend_delay(&pdev->dev, -1);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
+
+	ret = devm_spi_register_controller(&pdev->dev, ctlr);
+	if (ret < 0)
+		goto err_probe;
+
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
 
 	dev_info(&pdev->dev, "spi frequency: %d Hz\n", sp->spi_freq);
 
-	return devm_spi_register_controller(&pdev->dev, ctlr);
+	return 0;
+
+err_probe:
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+
+	mtk_nor_disable_clk(sp);
+
+	return ret;
 }
 
 static int mtk_nor_remove(struct platform_device *pdev)
 {
-	struct spi_controller *ctlr;
-	struct mtk_nor *sp;
+	struct spi_controller *ctlr = dev_get_drvdata(&pdev->dev);
+	struct mtk_nor *sp = spi_controller_get_devdata(ctlr);
 
-	ctlr = dev_get_drvdata(&pdev->dev);
-	sp = spi_controller_get_devdata(ctlr);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 
 	mtk_nor_disable_clk(sp);
 
@@ -722,10 +742,45 @@ static int mtk_nor_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused mtk_nor_runtime_suspend(struct device *dev)
+{
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+	struct mtk_nor *sp = spi_controller_get_devdata(ctlr);
+
+	mtk_nor_disable_clk(sp);
+
+	return 0;
+}
+
+static int __maybe_unused mtk_nor_runtime_resume(struct device *dev)
+{
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+	struct mtk_nor *sp = spi_controller_get_devdata(ctlr);
+
+	return mtk_nor_enable_clk(sp);
+}
+
+static int __maybe_unused mtk_nor_suspend(struct device *dev)
+{
+	return pm_runtime_force_suspend(dev);
+}
+
+static int __maybe_unused mtk_nor_resume(struct device *dev)
+{
+	return pm_runtime_force_resume(dev);
+}
+
+static const struct dev_pm_ops mtk_nor_pm_ops = {
+	SET_RUNTIME_PM_OPS(mtk_nor_runtime_suspend,
+			   mtk_nor_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(mtk_nor_suspend, mtk_nor_resume)
+};
+
 static struct platform_driver mtk_nor_driver = {
 	.driver = {
 		.name = DRIVER_NAME,
 		.of_match_table = mtk_nor_match,
+		.pm = &mtk_nor_pm_ops,
 	},
 	.probe = mtk_nor_probe,
 	.remove = mtk_nor_remove,
-- 
2.28.0.681.g6f77f65b4e-goog

