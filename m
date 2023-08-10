Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00AE777984
	for <lists+linux-spi@lfdr.de>; Thu, 10 Aug 2023 15:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjHJNZb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Aug 2023 09:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbjHJNZN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Aug 2023 09:25:13 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CAB26A9
        for <linux-spi@vger.kernel.org>; Thu, 10 Aug 2023 06:25:11 -0700 (PDT)
Received: from kwepemi500019.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RM6zF1Ld3zqT2Z;
        Thu, 10 Aug 2023 21:22:17 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500019.china.huawei.com
 (7.221.188.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 21:25:07 +0800
From:   Zhang Zekun <zhangzekun11@huawei.com>
To:     <kamal.dasu@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <broonie@kernel.org>, <rjui@broadcom.com>, <sbranden@broadcom.com>,
        <linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] spi: bcm-qspi: Simplify logic by using devm_platform_ioremap_resource_byname()
Date:   Thu, 10 Aug 2023 21:16:50 +0800
Message-ID: <20230810131650.71916-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500019.china.huawei.com (7.221.188.117)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

platform_get_resource_byname() and devm_ioremap_resource() can be
replaced by devm_platform_ioremap_resource_byname(), which can
simplify the code logic a bit, No functional change here.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/spi/spi-iproc-qspi.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-iproc-qspi.c b/drivers/spi/spi-iproc-qspi.c
index 5980a0dbbccb..39ee2b43a516 100644
--- a/drivers/spi/spi-iproc-qspi.c
+++ b/drivers/spi/spi-iproc-qspi.c
@@ -94,7 +94,6 @@ static int bcm_iproc_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct bcm_iproc_intc *priv;
 	struct bcm_qspi_soc_intc *soc_intc;
-	struct resource *res;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -104,14 +103,12 @@ static int bcm_iproc_probe(struct platform_device *pdev)
 
 	spin_lock_init(&priv->soclock);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "intr_regs");
-	priv->int_reg = devm_ioremap_resource(dev, res);
+	priv->int_reg = devm_platform_ioremap_resource_byname(pdev, "intr_regs");
 	if (IS_ERR(priv->int_reg))
 		return PTR_ERR(priv->int_reg);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-					   "intr_status_reg");
-	priv->int_status_reg = devm_ioremap_resource(dev, res);
+	priv->int_status_reg = devm_platform_ioremap_resource_byname(pdev,
+								     "intr_status_reg");
 	if (IS_ERR(priv->int_status_reg))
 		return PTR_ERR(priv->int_status_reg);
 
-- 
2.17.1

