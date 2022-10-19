Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332D46046F1
	for <lists+linux-spi@lfdr.de>; Wed, 19 Oct 2022 15:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJSNZI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Oct 2022 09:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiJSNYq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Oct 2022 09:24:46 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAE810A7E5
        for <linux-spi@vger.kernel.org>; Wed, 19 Oct 2022 06:10:50 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Mslpt0yyRzJn4x;
        Wed, 19 Oct 2022 17:31:18 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 17:33:57 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 19 Oct
 2022 17:33:56 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <yangyingliang@huawei.com>
Subject: [PATCH -next] spi: img-spfi: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 19 Oct 2022 17:33:18 +0800
Message-ID: <20221019093318.1183190-1-yangyingliang@huawei.com>
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

Use the devm_platform_get_and_ioremap_resource() helper instead of calling
platform_get_resource() and devm_ioremap_resource() separately.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-img-spfi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index bfd12247f173..257046f843ff 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -540,8 +540,7 @@ static int img_spfi_probe(struct platform_device *pdev)
 	spfi->master = master;
 	spin_lock_init(&spfi->lock);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	spfi->regs = devm_ioremap_resource(spfi->dev, res);
+	spfi->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(spfi->regs)) {
 		ret = PTR_ERR(spfi->regs);
 		goto put_spi;
-- 
2.25.1

