Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EC07654C3
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jul 2023 15:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjG0NRQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Jul 2023 09:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbjG0NRP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Jul 2023 09:17:15 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997FA272E;
        Thu, 27 Jul 2023 06:17:12 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RBWVl2XFGzrRgv;
        Thu, 27 Jul 2023 21:16:15 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 21:17:10 +0800
From:   Chen Jiahao <chenjiahao16@huawei.com>
To:     <andi.shyti@kernel.org>, <broonie@kernel.org>,
        <krzysztof.kozlowski@linaro.org>, <alim.akhtar@samsung.com>,
        <linux-spi@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <chenjiahao16@huawei.com>
Subject: [PATCH -next] spi: s3c64xx: Clean up redundant dev_err_probe()
Date:   Thu, 27 Jul 2023 21:16:35 +0800
Message-ID: <20230727131635.2898051-1-chenjiahao16@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Referring to platform_get_irq()'s definition, the return value has
already been checked if ret < 0, and printed via dev_err_probe().
Calling dev_err_probe() one more time outside platform_get_irq()
is obviously redundant.

Removing dev_err_probe() outside platform_get_irq() to clean up
above problem.

Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
---
 drivers/spi/spi-s3c64xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index a1b68fdc205d..bf7cb18be9dc 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1167,7 +1167,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-		return dev_err_probe(&pdev->dev, irq, "Failed to get IRQ\n");
+		return irq;
 
 	master = devm_spi_alloc_master(&pdev->dev, sizeof(*sdd));
 	if (!master)
-- 
2.34.1

