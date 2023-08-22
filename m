Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0614783782
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 03:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjHVBi7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Aug 2023 21:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjHVBiu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Aug 2023 21:38:50 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFE5180
        for <linux-spi@vger.kernel.org>; Mon, 21 Aug 2023 18:38:47 -0700 (PDT)
Received: from dggpemm100004.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RVBjr0w2XzNn8V;
        Tue, 22 Aug 2023 09:35:12 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100004.china.huawei.com (7.185.36.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 22 Aug 2023 09:38:46 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 09:38:45 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 23/24] spi: zynq-qspi: switch to use modern name
Date:   Tue, 22 Aug 2023 09:35:10 +0800
Message-ID: <20230822013511.4161475-24-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230822013511.4161475-1-yangyingliang@huawei.com>
References: <20230822013511.4161475-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Change legacy name master/slave to modern name host/target or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-zynq-qspi.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 0db69a2a72ff..d6325c6be3d4 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -54,10 +54,10 @@
 #define ZYNQ_QSPI_CONFIG_MSTREN_MASK	BIT(0) /* Master Mode */
 
 /*
- * QSPI Configuration Register - Baud rate and slave select
+ * QSPI Configuration Register - Baud rate and target select
  *
  * These are the values used in the calculation of baud rate divisor and
- * setting the slave select.
+ * setting the target select.
  */
 #define ZYNQ_QSPI_CONFIG_BAUD_DIV_MAX	GENMASK(2, 0) /* Baud rate maximum */
 #define ZYNQ_QSPI_CONFIG_BAUD_DIV_SHIFT	3 /* Baud rate divisor shift */
@@ -164,14 +164,14 @@ static inline void zynq_qspi_write(struct zynq_qspi *xqspi, u32 offset,
  *
  * The default settings of the QSPI controller's configurable parameters on
  * reset are
- *	- Master mode
+ *	- Host mode
  *	- Baud rate divisor is set to 2
  *	- Tx threshold set to 1l Rx threshold set to 32
  *	- Flash memory interface mode enabled
  *	- Size of the word to be transferred as 8 bit
  * This function performs the following actions
  *	- Disable and clear all the interrupts
- *	- Enable manual slave select
+ *	- Enable manual target select
  *	- Enable manual start
  *	- Deselect all the chip select lines
  *	- Set the size of the word to be transferred as 32 bit
@@ -289,7 +289,7 @@ static void zynq_qspi_txfifo_op(struct zynq_qspi *xqspi, unsigned int size)
  */
 static void zynq_qspi_chipselect(struct spi_device *spi, bool assert)
 {
-	struct spi_controller *ctlr = spi->master;
+	struct spi_controller *ctlr = spi->controller;
 	struct zynq_qspi *xqspi = spi_controller_get_devdata(ctlr);
 	u32 config_reg;
 
@@ -377,7 +377,7 @@ static int zynq_qspi_config_op(struct zynq_qspi *xqspi, struct spi_device *spi)
  */
 static int zynq_qspi_setup_op(struct spi_device *spi)
 {
-	struct spi_controller *ctlr = spi->master;
+	struct spi_controller *ctlr = spi->controller;
 	struct zynq_qspi *qspi = spi_controller_get_devdata(ctlr);
 
 	if (ctlr->busy)
@@ -525,7 +525,7 @@ static irqreturn_t zynq_qspi_irq(int irq, void *dev_id)
 static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
 				 const struct spi_mem_op *op)
 {
-	struct zynq_qspi *xqspi = spi_controller_get_devdata(mem->spi->master);
+	struct zynq_qspi *xqspi = spi_controller_get_devdata(mem->spi->controller);
 	int err = 0, i;
 	u8 *tmpbuf;
 
@@ -637,7 +637,7 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	struct zynq_qspi *xqspi;
 	u32 num_cs;
 
-	ctlr = spi_alloc_master(&pdev->dev, sizeof(*xqspi));
+	ctlr = spi_alloc_host(&pdev->dev, sizeof(*xqspi));
 	if (!ctlr)
 		return -ENOMEM;
 
@@ -647,14 +647,14 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	xqspi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(xqspi->regs)) {
 		ret = PTR_ERR(xqspi->regs);
-		goto remove_master;
+		goto remove_ctlr;
 	}
 
 	xqspi->pclk = devm_clk_get(&pdev->dev, "pclk");
 	if (IS_ERR(xqspi->pclk)) {
 		dev_err(&pdev->dev, "pclk clock not found.\n");
 		ret = PTR_ERR(xqspi->pclk);
-		goto remove_master;
+		goto remove_ctlr;
 	}
 
 	init_completion(&xqspi->data_completion);
@@ -663,13 +663,13 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	if (IS_ERR(xqspi->refclk)) {
 		dev_err(&pdev->dev, "ref_clk clock not found.\n");
 		ret = PTR_ERR(xqspi->refclk);
-		goto remove_master;
+		goto remove_ctlr;
 	}
 
 	ret = clk_prepare_enable(xqspi->pclk);
 	if (ret) {
 		dev_err(&pdev->dev, "Unable to enable APB clock.\n");
-		goto remove_master;
+		goto remove_ctlr;
 	}
 
 	ret = clk_prepare_enable(xqspi->refclk);
@@ -715,7 +715,7 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 
 	ret = devm_spi_register_controller(&pdev->dev, ctlr);
 	if (ret) {
-		dev_err(&pdev->dev, "spi_register_master failed\n");
+		dev_err(&pdev->dev, "devm_spi_register_controller failed\n");
 		goto clk_dis_all;
 	}
 
@@ -725,7 +725,7 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	clk_disable_unprepare(xqspi->refclk);
 clk_dis_pclk:
 	clk_disable_unprepare(xqspi->pclk);
-remove_master:
+remove_ctlr:
 	spi_controller_put(ctlr);
 
 	return ret;
-- 
2.25.1

