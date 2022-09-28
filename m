Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D375EDF03
	for <lists+linux-spi@lfdr.de>; Wed, 28 Sep 2022 16:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbiI1OnI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 28 Sep 2022 10:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbiI1OnG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 28 Sep 2022 10:43:06 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C11FAE85C
        for <linux-spi@vger.kernel.org>; Wed, 28 Sep 2022 07:43:05 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MczdX5c62zWh1K;
        Wed, 28 Sep 2022 22:38:56 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 22:43:03 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 28 Sep
 2022 22:43:02 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <p.zabel@pengutronix.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 2/2] spi: cadence-quadspi: Use devm_platform_{get_and_}ioremap_resource()
Date:   Wed, 28 Sep 2022 22:58:52 +0800
Message-ID: <20220928145852.1882221-2-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220928145852.1882221-1-yangyingliang@huawei.com>
References: <20220928145852.1882221-1-yangyingliang@huawei.com>
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

Use the devm_platform_{get_and}_ioremap_resource() helper instead of
calling platform_get_resource() and devm_ioremap_resource() separately.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-cadence-quadspi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 447230547945..4219113cf36b 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1580,7 +1580,6 @@ static int cqspi_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct resource *res_ahb;
 	struct cqspi_st *cqspi;
-	struct resource *res;
 	int ret;
 	int irq;
 
@@ -1616,8 +1615,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	}
 
 	/* Obtain and remap controller address. */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	cqspi->iobase = devm_ioremap_resource(dev, res);
+	cqspi->iobase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(cqspi->iobase)) {
 		dev_err(dev, "Cannot remap controller address.\n");
 		ret = PTR_ERR(cqspi->iobase);
@@ -1625,8 +1623,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	}
 
 	/* Obtain and remap AHB address. */
-	res_ahb = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	cqspi->ahb_base = devm_ioremap_resource(dev, res_ahb);
+	cqspi->ahb_base = devm_platform_get_and_ioremap_resource(pdev, 1, &res_ahb);
 	if (IS_ERR(cqspi->ahb_base)) {
 		dev_err(dev, "Cannot remap AHB address.\n");
 		ret = PTR_ERR(cqspi->ahb_base);
-- 
2.25.1

