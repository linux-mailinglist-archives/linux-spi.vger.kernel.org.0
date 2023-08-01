Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D1676B664
	for <lists+linux-spi@lfdr.de>; Tue,  1 Aug 2023 15:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbjHANzS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Aug 2023 09:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbjHANzS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Aug 2023 09:55:18 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877C1C3
        for <linux-spi@vger.kernel.org>; Tue,  1 Aug 2023 06:55:15 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RFc4G70HSzLnqM;
        Tue,  1 Aug 2023 21:52:30 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.202) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 21:55:12 +0800
From:   Zhu Wang <wangzhu9@huawei.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC:     <wangzhu9@huawei.com>
Subject: [PATCH -next] spi: omap2-mcspi: remove redundant dev_err_probe()
Date:   Tue, 1 Aug 2023 21:54:42 +0800
Message-ID: <20230801135442.255604-1-wangzhu9@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.202]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

When platform_get_irq() is called, the error message has been printed,
so it need not to call dev_err_probe() to print error, we remove the
redundant platform_get_irq().

Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
---
 drivers/spi/spi-omap2-mcspi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 8331e247bf5c..e5cd82eb9e54 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1508,10 +1508,8 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	}
 
 	status = platform_get_irq(pdev, 0);
-	if (status < 0) {
-		dev_err_probe(&pdev->dev, status, "no irq resource found\n");
+	if (status < 0)
 		goto free_master;
-	}
 	init_completion(&mcspi->txdone);
 	status = devm_request_irq(&pdev->dev, status,
 				  omap2_mcspi_irq_handler, 0, pdev->name,
-- 
2.17.1

