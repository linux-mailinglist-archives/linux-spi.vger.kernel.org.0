Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1863C5BE756
	for <lists+linux-spi@lfdr.de>; Tue, 20 Sep 2022 15:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbiITNlh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Sep 2022 09:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiITNlf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Sep 2022 09:41:35 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B28D3B94C
        for <linux-spi@vger.kernel.org>; Tue, 20 Sep 2022 06:41:33 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MX2fF53xPz14Qtq;
        Tue, 20 Sep 2022 21:37:25 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 21:41:31 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 20 Sep
 2022 21:41:30 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <yangyingliang@huawei.com>
Subject: [PATCH -next 3/6] spi: omap-uwire: Switch to use devm_spi_alloc_master()
Date:   Tue, 20 Sep 2022 21:48:16 +0800
Message-ID: <20220920134819.2981033-4-yangyingliang@huawei.com>
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
 drivers/spi/spi-omap-uwire.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-omap-uwire.c b/drivers/spi/spi-omap-uwire.c
index 29198e6815b2..f1e66f758d45 100644
--- a/drivers/spi/spi-omap-uwire.c
+++ b/drivers/spi/spi-omap-uwire.c
@@ -448,7 +448,6 @@ static void uwire_off(struct uwire_spi *uwire)
 {
 	uwire_write_reg(UWIRE_SR3, 0);
 	clk_disable_unprepare(uwire->ck);
-	spi_master_put(uwire->bitbang.master);
 }
 
 static int uwire_probe(struct platform_device *pdev)
@@ -457,7 +456,7 @@ static int uwire_probe(struct platform_device *pdev)
 	struct uwire_spi	*uwire;
 	int			status;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*uwire));
+	master = devm_spi_alloc_master(&pdev->dev, sizeof(*uwire));
 	if (!master)
 		return -ENODEV;
 
@@ -466,7 +465,6 @@ static int uwire_probe(struct platform_device *pdev)
 	uwire_base = devm_ioremap(&pdev->dev, UWIRE_BASE_PHYS, UWIRE_IO_SIZE);
 	if (!uwire_base) {
 		dev_dbg(&pdev->dev, "can't ioremap UWIRE\n");
-		spi_master_put(master);
 		return -ENOMEM;
 	}
 
@@ -476,7 +474,6 @@ static int uwire_probe(struct platform_device *pdev)
 	if (IS_ERR(uwire->ck)) {
 		status = PTR_ERR(uwire->ck);
 		dev_dbg(&pdev->dev, "no functional clock?\n");
-		spi_master_put(master);
 		return status;
 	}
 	clk_prepare_enable(uwire->ck);
@@ -518,6 +515,7 @@ static int uwire_remove(struct platform_device *pdev)
 
 	spi_bitbang_stop(&uwire->bitbang);
 	uwire_off(uwire);
+	spi_master_put(uwire->bitbang.master);
 	return 0;
 }
 
-- 
2.25.1

