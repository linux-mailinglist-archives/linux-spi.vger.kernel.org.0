Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A1E5E5D65
	for <lists+linux-spi@lfdr.de>; Thu, 22 Sep 2022 10:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiIVIYp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Sep 2022 04:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiIVIYc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Sep 2022 04:24:32 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3BD1F9EF
        for <linux-spi@vger.kernel.org>; Thu, 22 Sep 2022 01:24:17 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MY7Xk22yGzpT08;
        Thu, 22 Sep 2022 16:21:26 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 16:24:16 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 16:24:11 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <yangyingliang@huawei.com>
Subject: [PATCH -next v2 5/6] spi: sh-sci: Switch to use __devm_spi_alloc_controller()
Date:   Thu, 22 Sep 2022 16:31:02 +0800
Message-ID: <20220922083103.666157-6-yangyingliang@huawei.com>
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
 drivers/spi/spi-sh-sci.c | 44 ++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/spi-sh-sci.c b/drivers/spi/spi-sh-sci.c
index 8f30531e1418..64f9d85cce0f 100644
--- a/drivers/spi/spi-sh-sci.c
+++ b/drivers/spi/spi-sh-sci.c
@@ -114,29 +114,27 @@ static void sh_sci_spi_chipselect(struct spi_device *dev, int value)
 static int sh_sci_spi_probe(struct platform_device *dev)
 {
 	struct resource	*r;
-	struct spi_master *master;
+	struct spi_controller *ctlr;
 	struct sh_sci_spi *sp;
 	int ret;
 
-	master = spi_alloc_master(&dev->dev, sizeof(struct sh_sci_spi));
-	if (master == NULL) {
-		dev_err(&dev->dev, "failed to allocate spi master\n");
-		ret = -ENOMEM;
-		goto err0;
+	ctlr = __devm_spi_alloc_controller(&dev->dev, sizeof(*sp), false);
+	if (!ctlr) {
+		dev_err(&dev->dev, "failed to allocate spi controller\n");
+		return -ENOMEM;
 	}
 
-	sp = spi_master_get_devdata(master);
+	sp = spi_controller_get_devdata(ctlr);
 
 	platform_set_drvdata(dev, sp);
 	sp->info = dev_get_platdata(&dev->dev);
 	if (!sp->info) {
 		dev_err(&dev->dev, "platform data is missing\n");
-		ret = -ENOENT;
-		goto err1;
+		return -ENOENT;
 	}
 
 	/* setup spi bitbang adaptor */
-	sp->bitbang.master = master;
+	sp->bitbang.master = ctlr;
 	sp->bitbang.master->bus_num = sp->info->bus_num;
 	sp->bitbang.master->num_chipselect = sp->info->num_chipselect;
 	sp->bitbang.chipselect = sh_sci_spi_chipselect;
@@ -147,28 +145,22 @@ static int sh_sci_spi_probe(struct platform_device *dev)
 	sp->bitbang.txrx_word[SPI_MODE_3] = sh_sci_spi_txrx_mode3;
 
 	r = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	if (r == NULL) {
-		ret = -ENOENT;
-		goto err1;
-	}
+	if (r == NULL)
+		return -ENOENT;
 	sp->membase = ioremap(r->start, resource_size(r));
-	if (!sp->membase) {
-		ret = -ENXIO;
-		goto err1;
-	}
+	if (!sp->membase)
+		return -ENXIO;
 	sp->val = ioread8(SCSPTR(sp));
 	setbits(sp, PIN_INIT, 1);
 
 	ret = spi_bitbang_start(&sp->bitbang);
-	if (!ret)
-		return 0;
+	if (ret) {
+		setbits(sp, PIN_INIT, 0);
+		iounmap(sp->membase);
+		return ret;
+	}
 
-	setbits(sp, PIN_INIT, 0);
-	iounmap(sp->membase);
- err1:
-	spi_master_put(sp->bitbang.master);
- err0:
-	return ret;
+	return 0;
 }
 
 static int sh_sci_spi_remove(struct platform_device *dev)
-- 
2.25.1

