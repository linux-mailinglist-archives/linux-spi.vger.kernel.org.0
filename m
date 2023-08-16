Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A1777DD94
	for <lists+linux-spi@lfdr.de>; Wed, 16 Aug 2023 11:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243452AbjHPJnj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Aug 2023 05:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243455AbjHPJn3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Aug 2023 05:43:29 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803D626AD
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 02:43:28 -0700 (PDT)
Received: from dggpemm500008.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RQjlt6NHyzNmtB;
        Wed, 16 Aug 2023 17:39:54 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500008.china.huawei.com (7.185.36.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 16 Aug 2023 17:43:26 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 16 Aug
 2023 17:43:25 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 14/24] spi: rpc-if: switch to use devm_spi_alloc_host()
Date:   Wed, 16 Aug 2023 17:40:03 +0800
Message-ID: <20230816094013.1275068-15-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816094013.1275068-1-yangyingliang@huawei.com>
References: <20230816094013.1275068-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Switch to use modern name function devm_spi_alloc_host().

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-rpc-if.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rpc-if.c b/drivers/spi/spi-rpc-if.c
index 2f78124a1b59..e11146932828 100644
--- a/drivers/spi/spi-rpc-if.c
+++ b/drivers/spi/spi-rpc-if.c
@@ -134,7 +134,7 @@ static int rpcif_spi_probe(struct platform_device *pdev)
 	struct rpcif *rpc;
 	int error;
 
-	ctlr = devm_spi_alloc_master(&pdev->dev, sizeof(*rpc));
+	ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(*rpc));
 	if (!ctlr)
 		return -ENOMEM;
 
-- 
2.25.1

