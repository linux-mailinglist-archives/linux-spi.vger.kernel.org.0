Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC602604B90
	for <lists+linux-spi@lfdr.de>; Wed, 19 Oct 2022 17:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiJSPdk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Oct 2022 11:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiJSPdY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Oct 2022 11:33:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66701DCCD2
        for <linux-spi@vger.kernel.org>; Wed, 19 Oct 2022 08:26:45 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MsldC2Fq9zmVDC;
        Wed, 19 Oct 2022 17:22:55 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 17:27:19 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 19 Oct
 2022 17:27:18 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <chin-ting_kuo@aspeedtech.com>, <clg@kaod.org>,
        <broonie@kernel.org>, <yangyingliang@huawei.com>
Subject: [PATCH -next] spi: aspeed: Use devm_platform_{get_and_}ioremap_resource()
Date:   Wed, 19 Oct 2022 17:26:35 +0800
Message-ID: <20221019092635.1176622-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
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

Use the devm_platform_{get_and_}ioremap_resource() helper instead of
calling platform_get_resource() and devm_ioremap_resource() separately.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-aspeed-smc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 33cefcf18392..710ff8cf121f 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -734,13 +734,11 @@ static int aspeed_spi_probe(struct platform_device *pdev)
 	aspi->data = data;
 	aspi->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	aspi->regs = devm_ioremap_resource(dev, res);
+	aspi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(aspi->regs))
 		return PTR_ERR(aspi->regs);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	aspi->ahb_base = devm_ioremap_resource(dev, res);
+	aspi->ahb_base = devm_platform_get_and_ioremap_resource(pdev, 1, &res);
 	if (IS_ERR(aspi->ahb_base)) {
 		dev_err(dev, "missing AHB mapping window\n");
 		return PTR_ERR(aspi->ahb_base);
-- 
2.25.1

