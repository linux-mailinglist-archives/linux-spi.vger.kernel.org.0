Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D105E5D62
	for <lists+linux-spi@lfdr.de>; Thu, 22 Sep 2022 10:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiIVIYn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Sep 2022 04:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiIVIYc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Sep 2022 04:24:32 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577891F9EC
        for <linux-spi@vger.kernel.org>; Thu, 22 Sep 2022 01:24:16 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MY7Xh6MGYzpSt5;
        Thu, 22 Sep 2022 16:21:24 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 16:24:14 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 16:24:11 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <yangyingliang@huawei.com>
Subject: [PATCH -next v2 4/6] spi: ppc4xx: Switch to use __devm_spi_alloc_controller()
Date:   Thu, 22 Sep 2022 16:31:01 +0800
Message-ID: <20220922083103.666157-5-yangyingliang@huawei.com>
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
 drivers/spi/spi-ppc4xx.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index d65f047b6c82..89ea6ee0afdb 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -340,7 +340,7 @@ static void spi_ppc4xx_enable(struct ppc4xx_spi *hw)
 static int spi_ppc4xx_of_probe(struct platform_device *op)
 {
 	struct ppc4xx_spi *hw;
-	struct spi_master *master;
+	struct spi_controller *ctlr;
 	struct spi_bitbang *bbp;
 	struct resource resource;
 	struct device_node *np = op->dev.of_node;
@@ -349,13 +349,13 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 	int ret;
 	const unsigned int *clk;
 
-	master = spi_alloc_master(dev, sizeof(*hw));
-	if (master == NULL)
+	ctlr = __devm_spi_alloc_controller(dev, sizeof(*hw), false);
+	if (!ctlr)
 		return -ENOMEM;
-	master->dev.of_node = np;
-	platform_set_drvdata(op, master);
-	hw = spi_master_get_devdata(master);
-	hw->master = master;
+	ctlr->dev.of_node = np;
+	platform_set_drvdata(op, ctlr);
+	hw = spi_controller_get_devdata(ctlr);
+	hw->master = ctlr;
 	hw->dev = dev;
 
 	init_completion(&hw->done);
@@ -384,16 +384,14 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 	opbnp = of_find_compatible_node(NULL, NULL, "ibm,opb");
 	if (opbnp == NULL) {
 		dev_err(dev, "OPB: cannot find node\n");
-		ret = -ENODEV;
-		goto free_master;
+		return -ENODEV;
 	}
 	/* Get the clock (Hz) for the OPB */
 	clk = of_get_property(opbnp, "clock-frequency", NULL);
 	if (clk == NULL) {
 		dev_err(dev, "OPB: no clock-frequency property set\n");
 		of_node_put(opbnp);
-		ret = -ENODEV;
-		goto free_master;
+		return -ENODEV;
 	}
 	hw->opb_freq = *clk;
 	hw->opb_freq >>= 2;
@@ -402,7 +400,7 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 	ret = of_address_to_resource(np, 0, &resource);
 	if (ret) {
 		dev_err(dev, "error while parsing device node resource\n");
-		goto free_master;
+		return ret;
 	}
 	hw->mapbase = resource.start;
 	hw->mapsize = resource_size(&resource);
@@ -410,8 +408,7 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 	/* Sanity check */
 	if (hw->mapsize < sizeof(struct spi_ppc4xx_regs)) {
 		dev_err(dev, "too small to map registers\n");
-		ret = -EINVAL;
-		goto free_master;
+		return -EINVAL;
 	}
 
 	/* Request IRQ */
@@ -420,7 +417,7 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 			  0, "spi_ppc4xx_of", (void *)hw);
 	if (ret) {
 		dev_err(dev, "unable to allocate interrupt\n");
-		goto free_master;
+		return ret;
 	}
 
 	if (!request_mem_region(hw->mapbase, hw->mapsize, DRIVER_NAME)) {
@@ -457,8 +454,6 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 	release_mem_region(hw->mapbase, hw->mapsize);
 request_mem_error:
 	free_irq(hw->irqnum, hw);
-free_master:
-	spi_master_put(master);
 
 	dev_err(dev, "initialization failed\n");
 	return ret;
-- 
2.25.1

