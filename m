Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EC35E5D61
	for <lists+linux-spi@lfdr.de>; Thu, 22 Sep 2022 10:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiIVIYm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Sep 2022 04:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiIVIY2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Sep 2022 04:24:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB7E1F9E6
        for <linux-spi@vger.kernel.org>; Thu, 22 Sep 2022 01:24:12 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MY7W63d0jzlXLv;
        Thu, 22 Sep 2022 16:20:02 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 16:24:10 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 16:24:10 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <yangyingliang@huawei.com>
Subject: [PATCH -next v2 1/6] spi: oc-tiny: Switch to use __devm_spi_alloc_controller()
Date:   Thu, 22 Sep 2022 16:30:58 +0800
Message-ID: <20220922083103.666157-2-yangyingliang@huawei.com>
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
in error path can be removed. Also replace spi_master_get_devdata() with
spi_controller_get_devdata().

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-oc-tiny.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-oc-tiny.c b/drivers/spi/spi-oc-tiny.c
index 38c14c4e4e21..3514824f9f24 100644
--- a/drivers/spi/spi-oc-tiny.c
+++ b/drivers/spi/spi-oc-tiny.c
@@ -212,33 +212,31 @@ static int tiny_spi_probe(struct platform_device *pdev)
 {
 	struct tiny_spi_platform_data *platp = dev_get_platdata(&pdev->dev);
 	struct tiny_spi *hw;
-	struct spi_master *master;
+	struct spi_controller *ctlr;
 	int err = -ENODEV;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(struct tiny_spi));
-	if (!master)
+	ctlr = __devm_spi_alloc_controller(&pdev->dev, sizeof(*hw), false);
+	if (!ctlr)
 		return err;
 
 	/* setup the master state. */
-	master->bus_num = pdev->id;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
-	master->setup = tiny_spi_setup;
-	master->use_gpio_descriptors = true;
+	ctlr->bus_num = pdev->id;
+	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	ctlr->setup = tiny_spi_setup;
+	ctlr->use_gpio_descriptors = true;
 
-	hw = spi_master_get_devdata(master);
+	hw = spi_controller_get_devdata(ctlr);
 	platform_set_drvdata(pdev, hw);
 
 	/* setup the state for the bitbang driver */
-	hw->bitbang.master = master;
+	hw->bitbang.master = ctlr;
 	hw->bitbang.setup_transfer = tiny_spi_setup_transfer;
 	hw->bitbang.txrx_bufs = tiny_spi_txrx_bufs;
 
 	/* find and map our resources */
 	hw->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(hw->base)) {
-		err = PTR_ERR(hw->base);
-		goto exit;
-	}
+	if (IS_ERR(hw->base))
+		return PTR_ERR(hw->base);
 	/* irq is optional */
 	hw->irq = platform_get_irq(pdev, 0);
 	if (hw->irq >= 0) {
@@ -246,7 +244,7 @@ static int tiny_spi_probe(struct platform_device *pdev)
 		err = devm_request_irq(&pdev->dev, hw->irq, tiny_spi_irq, 0,
 				       pdev->name, hw);
 		if (err)
-			goto exit;
+			return err;
 	}
 	/* find platform data */
 	if (platp) {
@@ -255,20 +253,16 @@ static int tiny_spi_probe(struct platform_device *pdev)
 	} else {
 		err = tiny_spi_of_probe(pdev);
 		if (err)
-			goto exit;
+			return err;
 	}
 
 	/* register our spi controller */
 	err = spi_bitbang_start(&hw->bitbang);
 	if (err)
-		goto exit;
+		return err;
 	dev_info(&pdev->dev, "base %p, irq %d\n", hw->base, hw->irq);
 
 	return 0;
-
-exit:
-	spi_master_put(master);
-	return err;
 }
 
 static int tiny_spi_remove(struct platform_device *pdev)
-- 
2.25.1

