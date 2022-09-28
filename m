Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6435EDEE6
	for <lists+linux-spi@lfdr.de>; Wed, 28 Sep 2022 16:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbiI1Og7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 28 Sep 2022 10:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbiI1Og6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 28 Sep 2022 10:36:58 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C15EACA1A
        for <linux-spi@vger.kernel.org>; Wed, 28 Sep 2022 07:36:56 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MczVG0phvz1P6mW;
        Wed, 28 Sep 2022 22:32:38 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 22:36:54 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 28 Sep
 2022 22:36:53 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <verdun@hpe.com>, <nick.hawkins@hpe.com>, <broonie@kernel.org>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next] spi: spi-gxp: Use devm_platform_ioremap_resource()
Date:   Wed, 28 Sep 2022 22:52:56 +0800
Message-ID: <20220928145256.1879256-1-yangyingliang@huawei.com>
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

Use the devm_platform_ioremap_resource() helper instead of calling
platform_get_resource() and devm_ioremap_resource() separately.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-gxp.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-gxp.c b/drivers/spi/spi-gxp.c
index 9ea355f7d64f..15b110183839 100644
--- a/drivers/spi/spi-gxp.c
+++ b/drivers/spi/spi-gxp.c
@@ -254,7 +254,6 @@ static int gxp_spifi_probe(struct platform_device *pdev)
 	const struct gxp_spi_data *data;
 	struct spi_controller *ctlr;
 	struct gxp_spi *spifi;
-	struct resource *res;
 	int ret;
 
 	data = of_device_get_match_data(&pdev->dev);
@@ -269,18 +268,15 @@ static int gxp_spifi_probe(struct platform_device *pdev)
 	spifi->data = data;
 	spifi->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	spifi->reg_base = devm_ioremap_resource(&pdev->dev, res);
+	spifi->reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(spifi->reg_base))
 		return PTR_ERR(spifi->reg_base);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	spifi->dat_base = devm_ioremap_resource(&pdev->dev, res);
+	spifi->dat_base = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(spifi->dat_base))
 		return PTR_ERR(spifi->dat_base);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-	spifi->dir_base = devm_ioremap_resource(&pdev->dev, res);
+	spifi->dir_base = devm_platform_ioremap_resource(pdev, 2);
 	if (IS_ERR(spifi->dir_base))
 		return PTR_ERR(spifi->dir_base);
 
-- 
2.25.1

