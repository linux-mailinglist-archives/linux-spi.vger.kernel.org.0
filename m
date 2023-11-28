Return-Path: <linux-spi+bounces-74-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C87E7FB5B9
	for <lists+linux-spi@lfdr.de>; Tue, 28 Nov 2023 10:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53051282599
	for <lists+linux-spi@lfdr.de>; Tue, 28 Nov 2023 09:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F5D48CE7;
	Tue, 28 Nov 2023 09:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58019D5D
	for <linux-spi@vger.kernel.org>; Tue, 28 Nov 2023 01:26:30 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SfcSD0ZvMz1P8tX;
	Tue, 28 Nov 2023 17:22:52 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 28 Nov 2023 17:26:28 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 Nov
 2023 17:26:28 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <linux-spi@vger.kernel.org>
CC: <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
	<yangyingliang@huawei.com>
Subject: [PATCH -next 24/26] spi: zynqmp-gqspi: switch to use modern name
Date: Tue, 28 Nov 2023 17:30:29 +0800
Message-ID: <20231128093031.3707034-25-yangyingliang@huawei.com>
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
 drivers/spi/spi-zynqmp-gqspi.c | 50 +++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 9a46b2478f4e..99524a3c9f38 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Xilinx Zynq UltraScale+ MPSoC Quad-SPI (QSPI) controller driver
- * (master mode only)
+ * (host mode only)
  *
  * Copyright (C) 2009 - 2015 Xilinx, Inc.
  */
@@ -235,21 +235,21 @@ static inline void zynqmp_gqspi_write(struct zynqmp_qspi *xqspi, u32 offset,
 }
 
 /**
- * zynqmp_gqspi_selectslave - For selection of slave device
+ * zynqmp_gqspi_selecttarget - For selection of target device
  * @instanceptr:	Pointer to the zynqmp_qspi structure
- * @slavecs:	For chip select
- * @slavebus:	To check which bus is selected- upper or lower
+ * @targetcs:	For chip select
+ * @targetbus:	To check which bus is selected- upper or lower
  */
-static void zynqmp_gqspi_selectslave(struct zynqmp_qspi *instanceptr,
-				     u8 slavecs, u8 slavebus)
+static void zynqmp_gqspi_selecttarget(struct zynqmp_qspi *instanceptr,
+				      u8 targetcs, u8 targetbus)
 {
 	/*
 	 * Bus and CS lines selected here will be updated in the instance and
 	 * used for subsequent GENFIFO entries during transfer.
 	 */
 
-	/* Choose slave select line */
-	switch (slavecs) {
+	/* Choose target select line */
+	switch (targetcs) {
 	case GQSPI_SELECT_FLASH_CS_BOTH:
 		instanceptr->genfifocs = GQSPI_GENFIFO_CS_LOWER |
 			GQSPI_GENFIFO_CS_UPPER;
@@ -261,11 +261,11 @@ static void zynqmp_gqspi_selectslave(struct zynqmp_qspi *instanceptr,
 		instanceptr->genfifocs = GQSPI_GENFIFO_CS_LOWER;
 		break;
 	default:
-		dev_warn(instanceptr->dev, "Invalid slave select\n");
+		dev_warn(instanceptr->dev, "Invalid target select\n");
 	}
 
 	/* Choose the bus */
-	switch (slavebus) {
+	switch (targetbus) {
 	case GQSPI_SELECT_FLASH_BUS_BOTH:
 		instanceptr->genfifobus = GQSPI_GENFIFO_BUS_LOWER |
 			GQSPI_GENFIFO_BUS_UPPER;
@@ -277,7 +277,7 @@ static void zynqmp_gqspi_selectslave(struct zynqmp_qspi *instanceptr,
 		instanceptr->genfifobus = GQSPI_GENFIFO_BUS_LOWER;
 		break;
 	default:
-		dev_warn(instanceptr->dev, "Invalid slave bus\n");
+		dev_warn(instanceptr->dev, "Invalid target bus\n");
 	}
 }
 
@@ -337,13 +337,13 @@ static void zynqmp_qspi_set_tapdelay(struct zynqmp_qspi *xqspi, u32 baudrateval)
  *
  * The default settings of the QSPI controller's configurable parameters on
  * reset are
- *	- Master mode
+ *	- Host mode
  *	- TX threshold set to 1
  *	- RX threshold set to 1
  *	- Flash memory interface mode enabled
  * This function performs the following actions
  *	- Disable and clear all the interrupts
- *	- Enable manual slave select
+ *	- Enable manual target select
  *	- Enable manual start
  *	- Deselect all the chip select lines
  *	- Set the little endian mode of TX FIFO
@@ -426,9 +426,9 @@ static void zynqmp_qspi_init_hw(struct zynqmp_qspi *xqspi)
 			   GQSPI_RX_FIFO_THRESHOLD);
 	zynqmp_gqspi_write(xqspi, GQSPI_GF_THRESHOLD_OFST,
 			   GQSPI_GEN_FIFO_THRESHOLD_RESET_VAL);
-	zynqmp_gqspi_selectslave(xqspi,
-				 GQSPI_SELECT_FLASH_CS_LOWER,
-				 GQSPI_SELECT_FLASH_BUS_LOWER);
+	zynqmp_gqspi_selecttarget(xqspi,
+				  GQSPI_SELECT_FLASH_CS_LOWER,
+				  GQSPI_SELECT_FLASH_BUS_LOWER);
 	/* Initialize DMA */
 	zynqmp_gqspi_write(xqspi,
 			   GQSPI_QSPIDMA_DST_CTRL_OFST,
@@ -459,7 +459,7 @@ static void zynqmp_qspi_copy_read_data(struct zynqmp_qspi *xqspi,
  */
 static void zynqmp_qspi_chipselect(struct spi_device *qspi, bool is_high)
 {
-	struct zynqmp_qspi *xqspi = spi_master_get_devdata(qspi->master);
+	struct zynqmp_qspi *xqspi = spi_controller_get_devdata(qspi->controller);
 	ulong timeout;
 	u32 genfifoentry = 0, statusreg;
 
@@ -594,7 +594,7 @@ static int zynqmp_qspi_config_op(struct zynqmp_qspi *xqspi,
  */
 static int zynqmp_qspi_setup_op(struct spi_device *qspi)
 {
-	struct spi_controller *ctlr = qspi->master;
+	struct spi_controller *ctlr = qspi->controller;
 	struct zynqmp_qspi *xqspi = spi_controller_get_devdata(ctlr);
 
 	if (ctlr->busy)
@@ -1048,7 +1048,7 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 			       const struct spi_mem_op *op)
 {
 	struct zynqmp_qspi *xqspi = spi_controller_get_devdata
-				    (mem->spi->master);
+				    (mem->spi->controller);
 	int err = 0, i;
 	u32 genfifoentry = 0;
 	u16 opcode = op->cmd.opcode;
@@ -1224,7 +1224,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	u32 num_cs;
 	const struct qspi_platform_data *p_data;
 
-	ctlr = spi_alloc_master(&pdev->dev, sizeof(*xqspi));
+	ctlr = spi_alloc_host(&pdev->dev, sizeof(*xqspi));
 	if (!ctlr)
 		return -ENOMEM;
 
@@ -1240,27 +1240,27 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	xqspi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(xqspi->regs)) {
 		ret = PTR_ERR(xqspi->regs);
-		goto remove_master;
+		goto remove_ctlr;
 	}
 
 	xqspi->pclk = devm_clk_get(&pdev->dev, "pclk");
 	if (IS_ERR(xqspi->pclk)) {
 		dev_err(dev, "pclk clock not found.\n");
 		ret = PTR_ERR(xqspi->pclk);
-		goto remove_master;
+		goto remove_ctlr;
 	}
 
 	xqspi->refclk = devm_clk_get(&pdev->dev, "ref_clk");
 	if (IS_ERR(xqspi->refclk)) {
 		dev_err(dev, "ref_clk clock not found.\n");
 		ret = PTR_ERR(xqspi->refclk);
-		goto remove_master;
+		goto remove_ctlr;
 	}
 
 	ret = clk_prepare_enable(xqspi->pclk);
 	if (ret) {
 		dev_err(dev, "Unable to enable APB clock.\n");
-		goto remove_master;
+		goto remove_ctlr;
 	}
 
 	ret = clk_prepare_enable(xqspi->refclk);
@@ -1346,7 +1346,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	clk_disable_unprepare(xqspi->refclk);
 clk_dis_pclk:
 	clk_disable_unprepare(xqspi->pclk);
-remove_master:
+remove_ctlr:
 	spi_controller_put(ctlr);
 
 	return ret;
-- 
2.25.1


