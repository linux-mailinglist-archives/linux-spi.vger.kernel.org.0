Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FE5783784
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 03:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjHVBjA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Aug 2023 21:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjHVBiu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Aug 2023 21:38:50 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CC812C
        for <linux-spi@vger.kernel.org>; Mon, 21 Aug 2023 18:38:47 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RVBmG1Fp9zrSRH;
        Tue, 22 Aug 2023 09:37:18 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
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
Subject: [PATCH -next 24/24] spi: zynqmp-gqspi: switch to use modern name
Date:   Tue, 22 Aug 2023 09:35:11 +0800
Message-ID: <20230822013511.4161475-25-yangyingliang@huawei.com>
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

