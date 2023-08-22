Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3985784123
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 14:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235798AbjHVMrK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 08:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjHVMrK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 08:47:10 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66899196
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 05:47:08 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RVTXw51WRzNnHT;
        Tue, 22 Aug 2023 20:43:28 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 20:47:02 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] spi: at91-usart: Use PTR_ERR_OR_ZERO() to simplify code
Date:   Tue, 22 Aug 2023 20:46:42 +0800
Message-ID: <20230822124643.987079-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Return PTR_ERR_OR_ZERO() instead of return 0 or PTR_ERR() to
simplify code.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/spi/spi-at91-usart.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index 75d9bc606442..b11d0f993cc7 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -485,10 +485,7 @@ static int at91_usart_gpio_setup(struct platform_device *pdev)
 
 	cs_gpios = devm_gpiod_get_array_optional(&pdev->dev, "cs", GPIOD_OUT_LOW);
 
-	if (IS_ERR(cs_gpios))
-		return PTR_ERR(cs_gpios);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(cs_gpios);
 }
 
 static int at91_usart_spi_probe(struct platform_device *pdev)
-- 
2.34.1

