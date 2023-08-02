Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F13076C986
	for <lists+linux-spi@lfdr.de>; Wed,  2 Aug 2023 11:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjHBJdT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Aug 2023 05:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbjHBJdQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 2 Aug 2023 05:33:16 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34894127
        for <linux-spi@vger.kernel.org>; Wed,  2 Aug 2023 02:33:15 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RG6FR1gmkz1GDLT;
        Wed,  2 Aug 2023 17:32:11 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 17:33:12 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <broonie@kernel.org>, <florian.fainelli@broadcom.com>,
        <bcm-kernel-feedback-list@broadcom.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <linux-spi@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] spi: Do not check for 0 return after calling platform_get_irq()
Date:   Wed, 2 Aug 2023 17:32:38 +0800
Message-ID: <20230802093238.975906-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

It is not possible for platform_get_irq() to return 0. Use the
return value from platform_get_irq().

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/spi/spi-axi-spi-engine.c | 4 ++--
 drivers/spi/spi-bcm2835.c        | 4 ++--
 drivers/spi/spi-bcm2835aux.c     | 4 ++--
 drivers/spi/spi-cadence.c        | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 89661f3b0d44..c3224b85bc79 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -470,8 +470,8 @@ static int spi_engine_probe(struct platform_device *pdev)
 	int ret;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
-		return -ENXIO;
+	if (irq < 0)
+		return irq;
 
 	spi_engine = devm_kzalloc(&pdev->dev, sizeof(*spi_engine), GFP_KERNEL);
 	if (!spi_engine)
diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index c16abc2a9e9b..3f7f61ba66d5 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1360,8 +1360,8 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	ctlr->max_speed_hz = clk_get_rate(bs->clk) / 2;
 
 	bs->irq = platform_get_irq(pdev, 0);
-	if (bs->irq <= 0)
-		return bs->irq ? bs->irq : -ENODEV;
+	if (bs->irq < 0)
+		return bs->irq;
 
 	err = clk_prepare_enable(bs->clk);
 	if (err)
diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 8ace417c0a29..843dac847584 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -520,8 +520,8 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 	}
 
 	bs->irq = platform_get_irq(pdev, 0);
-	if (bs->irq <= 0)
-		return bs->irq ? bs->irq : -ENODEV;
+	if (bs->irq < 0)
+		return bs->irq;
 
 	/* this also enables the HW block */
 	err = clk_prepare_enable(bs->clk);
diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 42f101d357c3..7b0136536cfb 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -627,8 +627,8 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	cdns_spi_init_hw(xspi, spi_controller_is_slave(ctlr));
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		ret = -ENXIO;
+	if (irq < 0) {
+		ret = irq;
 		goto clk_dis_all;
 	}
 
-- 
2.34.1

