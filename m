Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D675E8CFB
	for <lists+linux-spi@lfdr.de>; Sat, 24 Sep 2022 15:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiIXNMc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 24 Sep 2022 09:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiIXNMa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 24 Sep 2022 09:12:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45FCAF0C1
        for <linux-spi@vger.kernel.org>; Sat, 24 Sep 2022 06:12:27 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MZTp55wjRzHtkH;
        Sat, 24 Sep 2022 21:07:41 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 21:12:26 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 24 Sep
 2022 21:12:25 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <olteanv@gmail.com>, <han.xu@nxp.com>, <broonie@kernel.org>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 3/3] spi: spi-fsl-qspi: Use devm_platform_ioremap_resource_byname()
Date:   Sat, 24 Sep 2022 21:18:54 +0800
Message-ID: <20220924131854.964923-3-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220924131854.964923-1-yangyingliang@huawei.com>
References: <20220924131854.964923-1-yangyingliang@huawei.com>
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

Use the devm_platform_ioremap_resource_byname() helper instead of
calling platform_get_resource_byname() and devm_ioremap_resource()
separately.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-fsl-qspi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 46ae46a944c5..85cc71ba624a 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -867,8 +867,7 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, q);
 
 	/* find the resources */
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "QuadSPI");
-	q->iobase = devm_ioremap_resource(dev, res);
+	q->iobase = devm_platform_ioremap_resource_byname(pdev, "QuadSPI");
 	if (IS_ERR(q->iobase)) {
 		ret = PTR_ERR(q->iobase);
 		goto err_put_ctrl;
-- 
2.25.1

