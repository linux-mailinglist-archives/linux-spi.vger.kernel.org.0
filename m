Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E9027BE31
	for <lists+linux-spi@lfdr.de>; Tue, 29 Sep 2020 09:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgI2Hiw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Sep 2020 03:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727632AbgI2Hiu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Sep 2020 03:38:50 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C77C061755
        for <linux-spi@vger.kernel.org>; Tue, 29 Sep 2020 00:38:49 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id n14so3681299pff.6
        for <linux-spi@vger.kernel.org>; Tue, 29 Sep 2020 00:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+r3GF4m4YugxKvqRkeEORPE8tzc/vmAmjb3ldF1z+f4=;
        b=JtxfRfZCoc631J3QzxUjx4tE5DyJzN21HObAkaJYd4wrzRIqBXFDtvuODhfBDwkwZ0
         p5topaqX9fGfxHY+UgHltGgyZ53cXwrSvY7+pi1vMor1i1veQRdlPnSIz9tMgLAbdfyl
         Wks3teP5eZ2k0RkFBrzxXXh/TazUdXKvCRvHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+r3GF4m4YugxKvqRkeEORPE8tzc/vmAmjb3ldF1z+f4=;
        b=Wk2bX3nZHsWYLpVbwOh1NhAWimSOIJKOFltlh4STEtj3waj2foMuVj4iyxV5u3Yq6G
         bJlrz0eyOTnQdGEVcOchaRbiPjaRd1KQsLxptEjEC6IPHbB1f8zhV/RxOExnVhbdBExg
         pPfBasclG1LA0xeuNdiaOIEk1V6iBRiNNfWMjqAB4A9kY/TSDEc+m9tqjruhFGjoc6gP
         hqYjHdk4ILJsNF/+vFo/hkNl2j+ZXHrdU6YUpsZW4aOVe5Ky4kvrE3molT0SjojZYPQ0
         kC7gMiwcSnZzSw58zbPee9KDNpvAw2YeQnzE6mP8BYVI8Pm9Bs1Q7VOawUucrhYE7Cke
         4VgQ==
X-Gm-Message-State: AOAM531lhYZYZ6OLqjDfZfmWORxfAb0YOEH/ly6C1sa4ovYz5lly3Ryk
        tEanC9Y8EwqYME055oqOTG6Mug==
X-Google-Smtp-Source: ABdhPJyloqcHPGpb8wGIRonsrVvNDR1Fti9p84W6aNSgDQau78lYJz5cH0Ahbvu0HvDaz77e72y6mw==
X-Received: by 2002:aa7:97a8:0:b029:13e:d13d:a105 with SMTP id d8-20020aa797a80000b029013ed13da105mr2970507pfq.33.1601365129442;
        Tue, 29 Sep 2020 00:38:49 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id e13sm3737317pjy.38.2020.09.29.00.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 00:38:49 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc:     Ikjoon Jang <ikjn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 4/4] spi: spi-mtk-nor: Add power management support
Date:   Tue, 29 Sep 2020 15:37:55 +0800
Message-Id: <20200929153320.v4.4.I68983b582d949a91866163bab588ff3c2a0d0275@changeid>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
In-Reply-To: <20200929073755.3741416-1-ikjn@chromium.org>
References: <20200929073755.3741416-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch adds dev_pm_ops to mtk-nor to support suspend/resume,
auto suspend delay is set to -1 by default.

Accessing registers are only permitted after its clock is enabled
to deal with unknown state of operating clk at probe time,

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---
Changes in v4:
- No changes

Changes in v3:
- Remove unrelated changes of dma_set_mask_coherent()

 drivers/spi/spi-mtk-nor.c | 98 ++++++++++++++++++++++++++++++---------
 1 file changed, 76 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index eac613b3930d..6179eb163cd6 100644
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
@@ -548,22 +549,15 @@ static int mtk_nor_enable_clk(struct mtk_nor *sp)
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
@@ -646,6 +640,7 @@ static int mtk_nor_probe(struct platform_device *pdev)
 	ctlr->num_chipselect = 1;
 	ctlr->setup = mtk_nor_setup;
 	ctlr->transfer_one_message = mtk_nor_transfer_one_message;
+	ctlr->auto_runtime_pm = true;
 
 	dev_set_drvdata(&pdev->dev, ctlr);
 
@@ -669,12 +664,19 @@ static int mtk_nor_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	ret = mtk_nor_enable_clk(sp);
+	if (ret < 0)
+		return ret;
+
+	sp->spi_freq = clk_get_rate(sp->spi_clk);
+
+	mtk_nor_init(sp);
+
 	irq = platform_get_irq_optional(pdev, 0);
+
 	if (irq < 0) {
 		dev_warn(sp->dev, "IRQ not available.");
 	} else {
-		writel(MTK_NOR_IRQ_MASK, base + MTK_NOR_REG_IRQ_STAT);
-		writel(0, base + MTK_NOR_REG_IRQ_EN);
 		ret = devm_request_irq(sp->dev, irq, mtk_nor_irq_handler, 0,
 				       pdev->name, sp);
 		if (ret < 0) {
@@ -685,34 +687,86 @@ static int mtk_nor_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = mtk_nor_init(sp);
-	if (ret < 0) {
-		kfree(ctlr);
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
+
+	mtk_nor_disable_clk(sp);
+
+	return 0;
+}
+
+static int __maybe_unused mtk_nor_runtime_suspend(struct device *dev)
+{
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+	struct mtk_nor *sp = spi_controller_get_devdata(ctlr);
 
 	mtk_nor_disable_clk(sp);
 
 	return 0;
 }
 
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
2.28.0.709.gb0816b6eb0-goog

