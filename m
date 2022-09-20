Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F055BE759
	for <lists+linux-spi@lfdr.de>; Tue, 20 Sep 2022 15:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiITNlm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Sep 2022 09:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiITNlj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Sep 2022 09:41:39 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9143C49B71
        for <linux-spi@vger.kernel.org>; Tue, 20 Sep 2022 06:41:32 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MX2fS4f9kzmVX8;
        Tue, 20 Sep 2022 21:37:36 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 21:41:31 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 20 Sep
 2022 21:41:30 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <yangyingliang@huawei.com>
Subject: [PATCH -next 2/6] spi: ath79: Switch to use devm_spi_alloc_master()
Date:   Tue, 20 Sep 2022 21:48:15 +0800
Message-ID: <20220920134819.2981033-3-yangyingliang@huawei.com>
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
 drivers/spi/spi-ath79.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index 607e7a49fb89..4cc5c4e8504e 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -173,7 +173,7 @@ static int ath79_spi_probe(struct platform_device *pdev)
 	unsigned long rate;
 	int ret;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*sp));
+	master = devm_spi_alloc_master(&pdev->dev, sizeof(*sp));
 	if (master == NULL) {
 		dev_err(&pdev->dev, "failed to allocate spi master\n");
 		return -ENOMEM;
@@ -195,20 +195,16 @@ static int ath79_spi_probe(struct platform_device *pdev)
 	sp->bitbang.flags = SPI_CS_HIGH;
 
 	sp->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(sp->base)) {
-		ret = PTR_ERR(sp->base);
-		goto err_put_master;
-	}
+	if (IS_ERR(sp->base))
+		return PTR_ERR(sp->base);
 
 	sp->clk = devm_clk_get(&pdev->dev, "ahb");
-	if (IS_ERR(sp->clk)) {
-		ret = PTR_ERR(sp->clk);
-		goto err_put_master;
-	}
+	if (IS_ERR(sp->clk))
+		return PTR_ERR(sp->clk);
 
 	ret = clk_prepare_enable(sp->clk);
 	if (ret)
-		goto err_put_master;
+		return ret;
 
 	rate = DIV_ROUND_UP(clk_get_rate(sp->clk), MHZ);
 	if (!rate) {
@@ -231,8 +227,6 @@ static int ath79_spi_probe(struct platform_device *pdev)
 	ath79_spi_disable(sp);
 err_clk_disable:
 	clk_disable_unprepare(sp->clk);
-err_put_master:
-	spi_master_put(sp->bitbang.master);
 
 	return ret;
 }
-- 
2.25.1

