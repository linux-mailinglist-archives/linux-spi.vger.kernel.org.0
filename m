Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3298F76DDEB
	for <lists+linux-spi@lfdr.de>; Thu,  3 Aug 2023 04:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjHCCR3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Aug 2023 22:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHCCR2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 2 Aug 2023 22:17:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902222D49
        for <linux-spi@vger.kernel.org>; Wed,  2 Aug 2023 19:17:16 -0700 (PDT)
Received: from dggpemm500003.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RGXTC6vGWztRp1;
        Thu,  3 Aug 2023 10:13:51 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500003.china.huawei.com (7.185.36.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 10:17:14 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 10:17:13 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <j.neuschaefer@gmx.net>, <broonie@kernel.org>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next] spi: wpcm-fiu: switch to use devm_platform_ioremap_resource_byname()
Date:   Thu, 3 Aug 2023 10:14:28 +0800
Message-ID: <20230803021428.3739149-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/spi/spi-wpcm-fiu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-wpcm-fiu.c b/drivers/spi/spi-wpcm-fiu.c
index 852ffe013d32..d07a06f49204 100644
--- a/drivers/spi/spi-wpcm-fiu.c
+++ b/drivers/spi/spi-wpcm-fiu.c
@@ -448,8 +448,7 @@ static int wpcm_fiu_probe(struct platform_device *pdev)
 	fiu = spi_controller_get_devdata(ctrl);
 	fiu->dev = dev;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "control");
-	fiu->regs = devm_ioremap_resource(dev, res);
+	fiu->regs = devm_platform_ioremap_resource_byname(pdev, "control");
 	if (IS_ERR(fiu->regs)) {
 		dev_err(dev, "Failed to map registers\n");
 		return PTR_ERR(fiu->regs);
-- 
2.25.1

