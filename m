Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6285BE4D4
	for <lists+linux-spi@lfdr.de>; Tue, 20 Sep 2022 13:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbiITLnQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Sep 2022 07:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiITLmp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Sep 2022 07:42:45 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8B474BAC
        for <linux-spi@vger.kernel.org>; Tue, 20 Sep 2022 04:42:07 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MX00R4HdmzlW31;
        Tue, 20 Sep 2022 19:37:59 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 19:42:05 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 20 Sep
 2022 19:42:05 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <krzysztof.kozlowski@linaro.org>, <broonie@kernel.org>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next] spi: s3c24xx: Switch to use devm_spi_alloc_master()
Date:   Tue, 20 Sep 2022 19:49:01 +0800
Message-ID: <20220920114901.2683267-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Switch to use devm_spi_alloc_master() to simpify error path.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-s3c24xx.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
index 660aa866af06..e941803a2557 100644
--- a/drivers/spi/spi-s3c24xx.c
+++ b/drivers/spi/spi-s3c24xx.c
@@ -449,7 +449,7 @@ static int s3c24xx_spi_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	int err = 0;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(struct s3c24xx_spi));
+	master = devm_spi_alloc_master(&pdev->dev, sizeof(struct s3c24xx_spi));
 	if (master == NULL) {
 		dev_err(&pdev->dev, "No memory for spi_master\n");
 		return -ENOMEM;
@@ -463,8 +463,7 @@ static int s3c24xx_spi_probe(struct platform_device *pdev)
 
 	if (pdata == NULL) {
 		dev_err(&pdev->dev, "No platform data supplied\n");
-		err = -ENOENT;
-		goto err_no_pdata;
+		return -ENOENT;
 	}
 
 	platform_set_drvdata(pdev, hw);
@@ -499,29 +498,24 @@ static int s3c24xx_spi_probe(struct platform_device *pdev)
 
 	/* find and map our resources */
 	hw->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(hw->regs)) {
-		err = PTR_ERR(hw->regs);
-		goto err_no_pdata;
-	}
+	if (IS_ERR(hw->regs))
+		return PTR_ERR(hw->regs);
 
 	hw->irq = platform_get_irq(pdev, 0);
-	if (hw->irq < 0) {
-		err = -ENOENT;
-		goto err_no_pdata;
-	}
+	if (hw->irq < 0)
+		return -ENOENT;
 
 	err = devm_request_irq(&pdev->dev, hw->irq, s3c24xx_spi_irq, 0,
 				pdev->name, hw);
 	if (err) {
 		dev_err(&pdev->dev, "Cannot claim IRQ\n");
-		goto err_no_pdata;
+		return err;
 	}
 
 	hw->clk = devm_clk_get(&pdev->dev, "spi");
 	if (IS_ERR(hw->clk)) {
 		dev_err(&pdev->dev, "No clock for device\n");
-		err = PTR_ERR(hw->clk);
-		goto err_no_pdata;
+		return PTR_ERR(hw->clk);
 	}
 
 	s3c24xx_spi_initialsetup(hw);
@@ -531,17 +525,11 @@ static int s3c24xx_spi_probe(struct platform_device *pdev)
 	err = spi_bitbang_start(&hw->bitbang);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to register SPI master\n");
-		goto err_register;
+		clk_disable(hw->clk);
+		return err;
 	}
 
 	return 0;
-
- err_register:
-	clk_disable(hw->clk);
-
- err_no_pdata:
-	spi_master_put(hw->master);
-	return err;
 }
 
 static int s3c24xx_spi_remove(struct platform_device *dev)
-- 
2.25.1

