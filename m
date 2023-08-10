Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F6E7772F4
	for <lists+linux-spi@lfdr.de>; Thu, 10 Aug 2023 10:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbjHJIdL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Aug 2023 04:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbjHJIdK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Aug 2023 04:33:10 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D2CED
        for <linux-spi@vger.kernel.org>; Thu, 10 Aug 2023 01:33:10 -0700 (PDT)
Received: from dggpemm100002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RM0TX4qVYztSGR;
        Thu, 10 Aug 2023 16:29:36 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100002.china.huawei.com (7.185.36.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 16:33:06 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 16:33:06 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 05/21] spi: microchip-core-qspi: switch to use modern name
Date:   Thu, 10 Aug 2023 16:29:48 +0800
Message-ID: <20230810083004.3988597-6-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230810083004.3988597-1-yangyingliang@huawei.com>
References: <20230810083004.3988597-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-microchip-core-qspi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-microchip-core-qspi.c
index 4f76ddf97b10..512542457dcc 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -25,7 +25,7 @@
  * QSPI Control register mask defines
  */
 #define CONTROL_ENABLE		BIT(0)
-#define CONTROL_MASTER		BIT(1)
+#define CONTROL_HOST		BIT(1)
 #define CONTROL_XIP		BIT(2)
 #define CONTROL_XIPADDR		BIT(3)
 #define CONTROL_CLKIDLE		BIT(10)
@@ -299,11 +299,11 @@ static int mchp_coreqspi_setup_clock(struct mchp_coreqspi *qspi, struct spi_devi
 
 static int mchp_coreqspi_setup_op(struct spi_device *spi_dev)
 {
-	struct spi_controller *ctlr = spi_dev->master;
+	struct spi_controller *ctlr = spi_dev->controller;
 	struct mchp_coreqspi *qspi = spi_controller_get_devdata(ctlr);
 	u32 control = readl_relaxed(qspi->regs + REG_CONTROL);
 
-	control |= (CONTROL_MASTER | CONTROL_ENABLE);
+	control |= (CONTROL_HOST | CONTROL_ENABLE);
 	control &= ~CONTROL_CLKIDLE;
 	writel_relaxed(control, qspi->regs + REG_CONTROL);
 
@@ -368,7 +368,7 @@ static inline void mchp_coreqspi_config_op(struct mchp_coreqspi *qspi, const str
 static int mchp_qspi_wait_for_ready(struct spi_mem *mem)
 {
 	struct mchp_coreqspi *qspi = spi_controller_get_devdata
-				    (mem->spi->master);
+				    (mem->spi->controller);
 	u32 status;
 	int ret;
 
@@ -387,7 +387,7 @@ static int mchp_qspi_wait_for_ready(struct spi_mem *mem)
 static int mchp_coreqspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
 	struct mchp_coreqspi *qspi = spi_controller_get_devdata
-				    (mem->spi->master);
+				    (mem->spi->controller);
 	u32 address = op->addr.val;
 	u8 opcode = op->cmd.opcode;
 	u8 opaddr[5];
@@ -505,10 +505,10 @@ static int mchp_coreqspi_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	int ret;
 
-	ctlr = devm_spi_alloc_master(&pdev->dev, sizeof(*qspi));
+	ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(*qspi));
 	if (!ctlr)
 		return dev_err_probe(&pdev->dev, -ENOMEM,
-				     "unable to allocate master for QSPI controller\n");
+				     "unable to allocate host for QSPI controller\n");
 
 	qspi = spi_controller_get_devdata(ctlr);
 	platform_set_drvdata(pdev, qspi);
-- 
2.25.1

