Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E608B664101
	for <lists+linux-spi@lfdr.de>; Tue, 10 Jan 2023 13:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbjAJM7p (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Jan 2023 07:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjAJM7o (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Jan 2023 07:59:44 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93AF517C0
        for <linux-spi@vger.kernel.org>; Tue, 10 Jan 2023 04:59:43 -0800 (PST)
Received: from dggpemm100007.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NrrTB1xhdznVCt;
        Tue, 10 Jan 2023 20:58:06 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm100007.china.huawei.com
 (7.185.36.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 20:59:40 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 3/3] spi: atmel-quadspi: switch to use modern name
Date:   Tue, 10 Jan 2023 21:18:05 +0800
Message-ID: <20230110131805.2827248-4-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230110131805.2827248-1-yangyingliang@huawei.com>
References: <20230110131805.2827248-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100007.china.huawei.com (7.185.36.116)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/atmel-quadspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 70637e46290a..f4632cb07495 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -406,7 +406,7 @@ static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
 
 static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
-	struct atmel_qspi *aq = spi_controller_get_devdata(mem->spi->master);
+	struct atmel_qspi *aq = spi_controller_get_devdata(mem->spi->controller);
 	u32 sr, offset;
 	int err;
 
@@ -476,7 +476,7 @@ static const struct spi_controller_mem_ops atmel_qspi_mem_ops = {
 
 static int atmel_qspi_setup(struct spi_device *spi)
 {
-	struct spi_controller *ctrl = spi->master;
+	struct spi_controller *ctrl = spi->controller;
 	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
 	unsigned long src_rate;
 	u32 scbr;
@@ -512,7 +512,7 @@ static int atmel_qspi_setup(struct spi_device *spi)
 
 static int atmel_qspi_set_cs_timing(struct spi_device *spi)
 {
-	struct spi_controller *ctrl = spi->master;
+	struct spi_controller *ctrl = spi->controller;
 	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
 	unsigned long clk_rate;
 	u32 cs_setup;
@@ -582,7 +582,7 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 	struct resource *res;
 	int irq, err = 0;
 
-	ctrl = devm_spi_alloc_master(&pdev->dev, sizeof(*aq));
+	ctrl = devm_spi_alloc_host(&pdev->dev, sizeof(*aq));
 	if (!ctrl)
 		return -ENOMEM;
 
-- 
2.25.1

