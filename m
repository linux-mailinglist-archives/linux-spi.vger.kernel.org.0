Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103FD5BE75C
	for <lists+linux-spi@lfdr.de>; Tue, 20 Sep 2022 15:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiITNlo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Sep 2022 09:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiITNll (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Sep 2022 09:41:41 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4966242AD1
        for <linux-spi@vger.kernel.org>; Tue, 20 Sep 2022 06:41:34 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MX2fG54jJz14Qkk;
        Tue, 20 Sep 2022 21:37:26 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 21:41:32 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 20 Sep
 2022 21:41:31 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <yangyingliang@huawei.com>
Subject: [PATCH -next 6/6] spi: altera: Switch to use devm_spi_alloc_master()
Date:   Tue, 20 Sep 2022 21:48:19 +0800
Message-ID: <20220920134819.2981033-7-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920134819.2981033-1-yangyingliang@huawei.com>
References: <20220920134819.2981033-1-yangyingliang@huawei.com>
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
 drivers/spi/spi-altera-platform.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-altera-platform.c b/drivers/spi/spi-altera-platform.c
index 65147aae82a1..376df7b6f543 100644
--- a/drivers/spi/spi-altera-platform.c
+++ b/drivers/spi/spi-altera-platform.c
@@ -43,7 +43,7 @@ static int altera_spi_probe(struct platform_device *pdev)
 	int err = -ENODEV;
 	u16 i;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(struct altera_spi));
+	master = devm_spi_alloc_master(&pdev->dev, sizeof(struct altera_spi));
 	if (!master)
 		return err;
 
@@ -55,8 +55,7 @@ static int altera_spi_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"Invalid number of chipselect: %u\n",
 				pdata->num_chipselect);
-			err = -EINVAL;
-			goto exit;
+			return -EINVAL;
 		}
 
 		master->num_chipselect = pdata->num_chipselect;
@@ -83,7 +82,7 @@ static int altera_spi_probe(struct platform_device *pdev)
 		hw->regmap = dev_get_regmap(pdev->dev.parent, NULL);
 		if (!hw->regmap) {
 			dev_err(&pdev->dev, "get regmap failed\n");
-			goto exit;
+			return err;
 		}
 
 		regoff = platform_get_resource(pdev, IORESOURCE_REG, 0);
@@ -93,17 +92,14 @@ static int altera_spi_probe(struct platform_device *pdev)
 		void __iomem *res;
 
 		res = devm_platform_ioremap_resource(pdev, 0);
-		if (IS_ERR(res)) {
-			err = PTR_ERR(res);
-			goto exit;
-		}
+		if (IS_ERR(res))
+			return PTR_ERR(res);
 
 		hw->regmap = devm_regmap_init_mmio(&pdev->dev, res,
 						   &spi_altera_config);
 		if (IS_ERR(hw->regmap)) {
 			dev_err(&pdev->dev, "regmap mmio init failed\n");
-			err = PTR_ERR(hw->regmap);
-			goto exit;
+			return PTR_ERR(hw->regmap);
 		}
 	}
 
@@ -115,12 +111,12 @@ static int altera_spi_probe(struct platform_device *pdev)
 		err = devm_request_irq(&pdev->dev, hw->irq, altera_spi_irq, 0,
 				       pdev->name, master);
 		if (err)
-			goto exit;
+			return err;
 	}
 
 	err = devm_spi_register_master(&pdev->dev, master);
 	if (err)
-		goto exit;
+		return err;
 
 	if (pdata) {
 		for (i = 0; i < pdata->num_devices; i++) {
@@ -134,9 +130,6 @@ static int altera_spi_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "regoff %u, irq %d\n", hw->regoff, hw->irq);
 
 	return 0;
-exit:
-	spi_master_put(master);
-	return err;
 }
 
 #ifdef CONFIG_OF
-- 
2.25.1

