Return-Path: <linux-spi+bounces-70-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 778667FB5B4
	for <lists+linux-spi@lfdr.de>; Tue, 28 Nov 2023 10:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343092826B7
	for <lists+linux-spi@lfdr.de>; Tue, 28 Nov 2023 09:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A99495E1;
	Tue, 28 Nov 2023 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6813D56
	for <linux-spi@vger.kernel.org>; Tue, 28 Nov 2023 01:26:29 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SfcSC5FtCz1P8tN;
	Tue, 28 Nov 2023 17:22:51 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 28 Nov 2023 17:26:28 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 Nov
 2023 17:26:27 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <linux-spi@vger.kernel.org>
CC: <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
	<yangyingliang@huawei.com>
Subject: [PATCH -next 23/26] spi: zynq-qspi: switch to use modern name
Date: Tue, 28 Nov 2023 17:30:28 +0800
Message-ID: <20231128093031.3707034-24-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231128093031.3707034-1-yangyingliang@huawei.com>
References: <20231128093031.3707034-1-yangyingliang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected

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


