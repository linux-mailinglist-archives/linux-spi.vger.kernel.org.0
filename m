Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8075969A646
	for <lists+linux-spi@lfdr.de>; Fri, 17 Feb 2023 08:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjBQHxN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Feb 2023 02:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjBQHxM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Feb 2023 02:53:12 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F51C93E5
        for <linux-spi@vger.kernel.org>; Thu, 16 Feb 2023 23:53:10 -0800 (PST)
Received: from dggpemm100007.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PJ3rm22YhzRs3X;
        Fri, 17 Feb 2023 15:50:32 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm100007.china.huawei.com
 (7.185.36.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 17 Feb
 2023 15:53:08 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <william.zhang@broadcom.com>, <kursad.oney@broadcom.com>,
        <jonas.gorski@gmail.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <broonie@kernel.org>, <yangyingliang@huawei.com>,
        <liwei391@huawei.com>
Subject: [PATCH -next] spi: bcm63xx-hsspi: fix error return code in bcmbca_hsspi_probe()
Date:   Fri, 17 Feb 2023 15:52:26 +0800
Message-ID: <20230217075226.185920-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100007.china.huawei.com (7.185.36.116)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Set the error code when sysfs_create_group() fails in bcmbca_hsspi_probe().

Fixes: 50a6620dd1fb ("spi: bcm63xx-hsspi: Add polling mode support")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-bcm63xx-hsspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 68093c045e0b..cd0a6478f5e7 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -849,7 +849,8 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(&pdev->dev);
 
-	if (sysfs_create_group(&pdev->dev.kobj, &bcm63xx_hsspi_group)) {
+	ret = sysfs_create_group(&pdev->dev.kobj, &bcm63xx_hsspi_group);
+	if (ret) {
 		dev_err(&pdev->dev, "couldn't register sysfs group\n");
 		goto out_pm_disable;
 	}
-- 
2.25.1

