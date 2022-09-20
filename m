Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E145BE75B
	for <lists+linux-spi@lfdr.de>; Tue, 20 Sep 2022 15:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiITNlo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Sep 2022 09:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiITNll (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Sep 2022 09:41:41 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62294DB54
        for <linux-spi@vger.kernel.org>; Tue, 20 Sep 2022 06:41:33 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MX2db0GCWzMnD8;
        Tue, 20 Sep 2022 21:36:51 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 21:41:32 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 20 Sep
 2022 21:41:31 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <yangyingliang@huawei.com>
Subject: [PATCH -next 5/6] spi: sh-sci: Switch to use devm_spi_alloc_master()
Date:   Tue, 20 Sep 2022 21:48:18 +0800
Message-ID: <20220920134819.2981033-6-yangyingliang@huawei.com>
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
 drivers/spi/spi-sh-sci.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-sh-sci.c b/drivers/spi/spi-sh-sci.c
index 8f30531e1418..2cd5cd23e37c 100644
--- a/drivers/spi/spi-sh-sci.c
+++ b/drivers/spi/spi-sh-sci.c
@@ -118,11 +118,10 @@ static int sh_sci_spi_probe(struct platform_device *dev)
 	struct sh_sci_spi *sp;
 	int ret;
 
-	master = spi_alloc_master(&dev->dev, sizeof(struct sh_sci_spi));
+	master = devm_spi_alloc_master(&dev->dev, sizeof(struct sh_sci_spi));
 	if (master == NULL) {
 		dev_err(&dev->dev, "failed to allocate spi master\n");
-		ret = -ENOMEM;
-		goto err0;
+		return -ENOMEM;
 	}
 
 	sp = spi_master_get_devdata(master);
@@ -131,8 +130,7 @@ static int sh_sci_spi_probe(struct platform_device *dev)
 	sp->info = dev_get_platdata(&dev->dev);
 	if (!sp->info) {
 		dev_err(&dev->dev, "platform data is missing\n");
-		ret = -ENOENT;
-		goto err1;
+		return -ENOENT;
 	}
 
 	/* setup spi bitbang adaptor */
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

