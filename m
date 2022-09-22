Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4045E5D64
	for <lists+linux-spi@lfdr.de>; Thu, 22 Sep 2022 10:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiIVIYo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Sep 2022 04:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiIVIYc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Sep 2022 04:24:32 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C746D1F9F0
        for <linux-spi@vger.kernel.org>; Thu, 22 Sep 2022 01:24:17 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MY7VY5zl0zMpNS;
        Thu, 22 Sep 2022 16:19:33 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 16:24:16 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 16:24:12 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <yangyingliang@huawei.com>
Subject: [PATCH -next v2 6/6] spi: altera: Switch to use __devm_spi_alloc_controller()
Date:   Thu, 22 Sep 2022 16:31:03 +0800
Message-ID: <20220922083103.666157-7-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922083103.666157-1-yangyingliang@huawei.com>
References: <20220922083103.666157-1-yangyingliang@huawei.com>
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

With using __devm_spi_alloc_controller(), spi_controller_put() is called in
devres_release_all() whenever the device is unbound, so the spi_master_put()
in error path can be removed.
Also replace spi_master_get_devdata() and devm_spi_register_master() with
spi_controller_get_devdata() and devm_spi_register_controller().

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-altera-platform.c | 55 ++++++++++++++-----------------
 1 file changed, 24 insertions(+), 31 deletions(-)

diff --git a/drivers/spi/spi-altera-platform.c b/drivers/spi/spi-altera-platform.c
index 65147aae82a1..7404e5eaaeb2 100644
--- a/drivers/spi/spi-altera-platform.c
+++ b/drivers/spi/spi-altera-platform.c
@@ -39,38 +39,37 @@ static int altera_spi_probe(struct platform_device *pdev)
 	struct altera_spi_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	enum altera_spi_type type = ALTERA_SPI_TYPE_UNKNOWN;
 	struct altera_spi *hw;
-	struct spi_master *master;
+	struct spi_controller *ctlr;
 	int err = -ENODEV;
 	u16 i;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(struct altera_spi));
-	if (!master)
+	ctlr = __devm_spi_alloc_controller(&pdev->dev, sizeof(*hw), false);
+	if (!ctlr)
 		return err;
 
-	/* setup the master state. */
-	master->bus_num = -1;
+	/* setup the controller state. */
+	ctlr->bus_num = -1;
 
 	if (pdata) {
 		if (pdata->num_chipselect > ALTERA_SPI_MAX_CS) {
 			dev_err(&pdev->dev,
 				"Invalid number of chipselect: %u\n",
 				pdata->num_chipselect);
-			err = -EINVAL;
-			goto exit;
+			return -EINVAL;
 		}
 
-		master->num_chipselect = pdata->num_chipselect;
-		master->mode_bits = pdata->mode_bits;
-		master->bits_per_word_mask = pdata->bits_per_word_mask;
+		ctlr->num_chipselect = pdata->num_chipselect;
+		ctlr->mode_bits = pdata->mode_bits;
+		ctlr->bits_per_word_mask = pdata->bits_per_word_mask;
 	} else {
-		master->num_chipselect = 16;
-		master->mode_bits = SPI_CS_HIGH;
-		master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 16);
+		ctlr->num_chipselect = 16;
+		ctlr->mode_bits = SPI_CS_HIGH;
+		ctlr->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 16);
 	}
 
-	master->dev.of_node = pdev->dev.of_node;
+	ctlr->dev.of_node = pdev->dev.of_node;
 
-	hw = spi_master_get_devdata(master);
+	hw = spi_controller_get_devdata(ctlr);
 	hw->dev = &pdev->dev;
 
 	if (platid)
@@ -83,7 +82,7 @@ static int altera_spi_probe(struct platform_device *pdev)
 		hw->regmap = dev_get_regmap(pdev->dev.parent, NULL);
 		if (!hw->regmap) {
 			dev_err(&pdev->dev, "get regmap failed\n");
-			goto exit;
+			return err;
 		}
 
 		regoff = platform_get_resource(pdev, IORESOURCE_REG, 0);
@@ -93,38 +92,35 @@ static int altera_spi_probe(struct platform_device *pdev)
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
 
-	altera_spi_init_master(master);
+	altera_spi_init_master(ctlr);
 
 	/* irq is optional */
 	hw->irq = platform_get_irq(pdev, 0);
 	if (hw->irq >= 0) {
 		err = devm_request_irq(&pdev->dev, hw->irq, altera_spi_irq, 0,
-				       pdev->name, master);
+				       pdev->name, ctlr);
 		if (err)
-			goto exit;
+			return err;
 	}
 
-	err = devm_spi_register_master(&pdev->dev, master);
+	err = devm_spi_register_controller(&pdev->dev, ctlr);
 	if (err)
-		goto exit;
+		return err;
 
 	if (pdata) {
 		for (i = 0; i < pdata->num_devices; i++) {
-			if (!spi_new_device(master, pdata->devices + i))
+			if (!spi_new_device(ctlr, pdata->devices + i))
 				dev_warn(&pdev->dev,
 					 "unable to create SPI device: %s\n",
 					 pdata->devices[i].modalias);
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

