Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D015BE754
	for <lists+linux-spi@lfdr.de>; Tue, 20 Sep 2022 15:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiITNlf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Sep 2022 09:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiITNld (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Sep 2022 09:41:33 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5965D48C9D
        for <linux-spi@vger.kernel.org>; Tue, 20 Sep 2022 06:41:32 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MX2fF0TPlz14QtL;
        Tue, 20 Sep 2022 21:37:25 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 21:41:30 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 20 Sep
 2022 21:41:30 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <yangyingliang@huawei.com>
Subject: [PATCH -next 1/6] spi: oc-tiny: Switch to use devm_spi_alloc_master()
Date:   Tue, 20 Sep 2022 21:48:14 +0800
Message-ID: <20220920134819.2981033-2-yangyingliang@huawei.com>
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
 drivers/spi/spi-oc-tiny.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-oc-tiny.c b/drivers/spi/spi-oc-tiny.c
index 38c14c4e4e21..1ab807741d26 100644
--- a/drivers/spi/spi-oc-tiny.c
+++ b/drivers/spi/spi-oc-tiny.c
@@ -215,7 +215,7 @@ static int tiny_spi_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	int err = -ENODEV;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(struct tiny_spi));
+	master = devm_spi_alloc_master(&pdev->dev, sizeof(struct tiny_spi));
 	if (!master)
 		return err;
 
@@ -235,10 +235,8 @@ static int tiny_spi_probe(struct platform_device *pdev)
 
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

