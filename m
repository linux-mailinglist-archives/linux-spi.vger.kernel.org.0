Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E5E772480
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 14:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbjHGMo1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 08:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbjHGMoV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 08:44:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF0C1730
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 05:44:15 -0700 (PDT)
Received: from dggpemm100004.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RKGBj4t9lzNmqR;
        Mon,  7 Aug 2023 20:40:45 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100004.china.huawei.com (7.185.36.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 20:44:13 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 20:44:13 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 17/20] spi: ingenic: switch to use devm_spi_alloc_host()
Date:   Mon, 7 Aug 2023 20:41:02 +0800
Message-ID: <20230807124105.3429709-18-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230807124105.3429709-1-yangyingliang@huawei.com>
References: <20230807124105.3429709-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Switch to use modern name function devm_spi_alloc_host().

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-ingenic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-ingenic.c b/drivers/spi/spi-ingenic.c
index cfa665a80bc6..cc366936d72b 100644
--- a/drivers/spi/spi-ingenic.c
+++ b/drivers/spi/spi-ingenic.c
@@ -392,7 +392,7 @@ static int spi_ingenic_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ctlr = devm_spi_alloc_master(dev, sizeof(*priv));
+	ctlr = devm_spi_alloc_host(dev, sizeof(*priv));
 	if (!ctlr) {
 		dev_err(dev, "Unable to allocate SPI controller.\n");
 		return -ENOMEM;
-- 
2.25.1

