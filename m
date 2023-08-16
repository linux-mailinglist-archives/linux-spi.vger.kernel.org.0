Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBF877DD9C
	for <lists+linux-spi@lfdr.de>; Wed, 16 Aug 2023 11:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243465AbjHPJnm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Aug 2023 05:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243464AbjHPJnd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Aug 2023 05:43:33 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9409313E
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 02:43:31 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RQjmc0t6JzFqbx;
        Wed, 16 Aug 2023 17:40:32 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500016.china.huawei.com (7.185.36.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 16 Aug 2023 17:43:29 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 16 Aug
 2023 17:43:29 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 22/24] spi: sh: switch to use modern name
Date:   Wed, 16 Aug 2023 17:40:11 +0800
Message-ID: <20230816094013.1275068-23-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816094013.1275068-1-yangyingliang@huawei.com>
References: <20230816094013.1275068-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-sh.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-sh.c b/drivers/spi/spi-sh.c
index d358a2a9c3f5..4b873d9a7602 100644
--- a/drivers/spi/spi-sh.c
+++ b/drivers/spi/spi-sh.c
@@ -72,7 +72,7 @@
 struct spi_sh_data {
 	void __iomem *addr;
 	int irq;
-	struct spi_master *master;
+	struct spi_controller *host;
 	unsigned long cr1;
 	wait_queue_head_t wait;
 	int width;
@@ -327,7 +327,7 @@ static int spi_sh_transfer_one_message(struct spi_controller *ctlr,
 
 static int spi_sh_setup(struct spi_device *spi)
 {
-	struct spi_sh_data *ss = spi_master_get_devdata(spi->master);
+	struct spi_sh_data *ss = spi_controller_get_devdata(spi->controller);
 
 	pr_debug("%s: enter\n", __func__);
 
@@ -346,7 +346,7 @@ static int spi_sh_setup(struct spi_device *spi)
 
 static void spi_sh_cleanup(struct spi_device *spi)
 {
-	struct spi_sh_data *ss = spi_master_get_devdata(spi->master);
+	struct spi_sh_data *ss = spi_controller_get_devdata(spi->controller);
 
 	pr_debug("%s: enter\n", __func__);
 
@@ -381,14 +381,14 @@ static void spi_sh_remove(struct platform_device *pdev)
 {
 	struct spi_sh_data *ss = platform_get_drvdata(pdev);
 
-	spi_unregister_master(ss->master);
+	spi_unregister_controller(ss->host);
 	free_irq(ss->irq, ss);
 }
 
 static int spi_sh_probe(struct platform_device *pdev)
 {
 	struct resource *res;
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct spi_sh_data *ss;
 	int ret, irq;
 
@@ -403,13 +403,13 @@ static int spi_sh_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	master = devm_spi_alloc_master(&pdev->dev, sizeof(struct spi_sh_data));
-	if (master == NULL) {
-		dev_err(&pdev->dev, "spi_alloc_master error.\n");
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(struct spi_sh_data));
+	if (host == NULL) {
+		dev_err(&pdev->dev, "devm_spi_alloc_host error.\n");
 		return -ENOMEM;
 	}
 
-	ss = spi_master_get_devdata(master);
+	ss = spi_controller_get_devdata(host);
 	platform_set_drvdata(pdev, ss);
 
 	switch (res->flags & IORESOURCE_MEM_TYPE_MASK) {
@@ -424,7 +424,7 @@ static int spi_sh_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 	ss->irq = irq;
-	ss->master = master;
+	ss->host = host;
 	ss->addr = devm_ioremap(&pdev->dev, res->start, resource_size(res));
 	if (ss->addr == NULL) {
 		dev_err(&pdev->dev, "ioremap error.\n");
@@ -438,15 +438,15 @@ static int spi_sh_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	master->num_chipselect = 2;
-	master->bus_num = pdev->id;
-	master->setup = spi_sh_setup;
-	master->transfer_one_message = spi_sh_transfer_one_message;
-	master->cleanup = spi_sh_cleanup;
+	host->num_chipselect = 2;
+	host->bus_num = pdev->id;
+	host->setup = spi_sh_setup;
+	host->transfer_one_message = spi_sh_transfer_one_message;
+	host->cleanup = spi_sh_cleanup;
 
-	ret = spi_register_master(master);
+	ret = spi_register_controller(host);
 	if (ret < 0) {
-		printk(KERN_ERR "spi_register_master error.\n");
+		printk(KERN_ERR "spi_register_controller error.\n");
 		goto error3;
 	}
 
-- 
2.25.1

