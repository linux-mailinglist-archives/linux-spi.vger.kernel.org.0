Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CAB5BE885
	for <lists+linux-spi@lfdr.de>; Tue, 20 Sep 2022 16:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiITOTS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Sep 2022 10:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbiITOSQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Sep 2022 10:18:16 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB9D69F77;
        Tue, 20 Sep 2022 07:15:22 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MX3Nb312PzMn7w;
        Tue, 20 Sep 2022 22:10:39 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 22:15:20 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 20 Sep
 2022 22:15:19 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>
CC:     <krzysztof.kozlowski@linaro.org>, <andi@etezian.org>,
        <alim.akhtar@samsung.com>, <broonie@kernel.org>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v2] spi: s3c24xx: Switch to use devm_spi_alloc_master()
Date:   Tue, 20 Sep 2022 22:22:16 +0800
Message-ID: <20220920142216.3002291-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
v2:
  Don't remove error label err_register.
---
 drivers/spi/spi-s3c24xx.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
index 660aa866af06..ef25b5e93900 100644
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
@@ -539,8 +533,6 @@ static int s3c24xx_spi_probe(struct platform_device *pdev)
  err_register:
 	clk_disable(hw->clk);
 
- err_no_pdata:
-	spi_master_put(hw->master);
 	return err;
 }
 
-- 
2.25.1

