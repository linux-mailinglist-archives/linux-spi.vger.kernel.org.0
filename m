Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969A878089F
	for <lists+linux-spi@lfdr.de>; Fri, 18 Aug 2023 11:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359253AbjHRJgA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Aug 2023 05:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359290AbjHRJf1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Aug 2023 05:35:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCA73ABC
        for <linux-spi@vger.kernel.org>; Fri, 18 Aug 2023 02:35:25 -0700 (PDT)
Received: from dggpemm100018.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RRxWF4lcNzVkYk;
        Fri, 18 Aug 2023 17:33:13 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100018.china.huawei.com (7.185.36.206) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 18 Aug 2023 17:35:22 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 18 Aug
 2023 17:35:21 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH -next v3 14/23] spi: rspi: switch to use spi_alloc_host()
Date:   Fri, 18 Aug 2023 17:31:45 +0800
Message-ID: <20230818093154.1183529-15-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818093154.1183529-1-yangyingliang@huawei.com>
References: <20230818093154.1183529-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Switch to use modern name function spi_alloc_host().

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 83bb16995e06..8e81f1a8623f 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1294,7 +1294,7 @@ static int rspi_probe(struct platform_device *pdev)
 	const struct spi_ops *ops;
 	unsigned long clksrc;
 
-	ctlr = spi_alloc_master(&pdev->dev, sizeof(struct rspi_data));
+	ctlr = spi_alloc_host(&pdev->dev, sizeof(struct rspi_data));
 	if (ctlr == NULL)
 		return -ENOMEM;
 
-- 
2.25.1

