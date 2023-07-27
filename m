Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24ED8765471
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jul 2023 15:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjG0NBa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Jul 2023 09:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjG0NB3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Jul 2023 09:01:29 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9AC1FF3
        for <linux-spi@vger.kernel.org>; Thu, 27 Jul 2023 06:01:27 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RBW8Y6YzLz1GDDY;
        Thu, 27 Jul 2023 21:00:29 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 21:01:23 +0800
From:   Chen Jiahao <chenjiahao16@huawei.com>
To:     <conor.dooley@microchip.com>, <daire.mcnamara@microchip.com>,
        <broonie@kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-spi@vger.kernel.org>
CC:     <chenjiahao16@huawei.com>
Subject: [PATCH -next] spi: microchip-core: Clean up redundant dev_err_probe()
Date:   Thu, 27 Jul 2023 21:00:49 +0800
Message-ID: <20230727130049.2810959-1-chenjiahao16@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Refering to platform_get_irq()'s definition, the return value has
already been checked if ret < 0, and printed via dev_err_probe().
Calling dev_err_probe() one more time outside platform_get_irq()
is obviously redundant.

Furthermore, platform_get_irq() will never return irq equals 0,
removing spi->irq == 0 checking to clean it up.

Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
---
 drivers/spi/spi-microchip-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip-core.c
index b59e8a0c5b97..ac3b7b163db4 100644
--- a/drivers/spi/spi-microchip-core.c
+++ b/drivers/spi/spi-microchip-core.c
@@ -530,10 +530,8 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 		return PTR_ERR(spi->regs);
 
 	spi->irq = platform_get_irq(pdev, 0);
-	if (spi->irq <= 0)
-		return dev_err_probe(&pdev->dev, -ENXIO,
-				     "invalid IRQ %d for SPI controller\n",
-				     spi->irq);
+	if (spi->irq < 0)
+		return -ENXIO;
 
 	ret = devm_request_irq(&pdev->dev, spi->irq, mchp_corespi_interrupt,
 			       IRQF_SHARED, dev_name(&pdev->dev), master);
-- 
2.34.1

