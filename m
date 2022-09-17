Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64B45BB825
	for <lists+linux-spi@lfdr.de>; Sat, 17 Sep 2022 14:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiIQMSI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 17 Sep 2022 08:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiIQMSI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 17 Sep 2022 08:18:08 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41C530F7F
        for <linux-spi@vger.kernel.org>; Sat, 17 Sep 2022 05:18:06 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MV8xf73hRzmV9p;
        Sat, 17 Sep 2022 20:14:14 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 17 Sep 2022 20:18:04 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 17 Sep
 2022 20:17:57 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>
Subject: [PATCH -next] spi: omap2-mcspi: Switch to use dev_err_probe() helper
Date:   Sat, 17 Sep 2022 20:25:04 +0800
Message-ID: <20220917122504.1896302-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In the probe path, dev_err() can be replace with dev_err_probe()
which will check if error code is -EPROBE_DEFER and prints the
error name.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-omap2-mcspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index c42e59df38fe..80e79f3aa0c4 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1509,10 +1509,8 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	}
 
 	status = platform_get_irq(pdev, 0);
-	if (status == -EPROBE_DEFER)
-		goto free_master;
-	if (status < 0) {
-		dev_err(&pdev->dev, "no irq resource found\n");
+	if (status) {
+		dev_err_probe(&pdev->dev, status, "no irq resource found\n");
 		goto free_master;
 	}
 	init_completion(&mcspi->txdone);
-- 
2.25.1

