Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3AE7668FA
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jul 2023 11:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbjG1JfS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jul 2023 05:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235483AbjG1JfN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Jul 2023 05:35:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E68A2
        for <linux-spi@vger.kernel.org>; Fri, 28 Jul 2023 02:35:10 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RC2X519WkzrS3B;
        Fri, 28 Jul 2023 17:34:13 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 17:35:09 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 17:35:08 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 12/21] spi: cadence: switch to use modern name
Date:   Fri, 28 Jul 2023 17:32:12 +0800
Message-ID: <20230728093221.3312026-13-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728093221.3312026-1-yangyingliang@huawei.com>
References: <20230728093221.3312026-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master/slave to modern name host/target or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-cadence.c | 70 +++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 42f101d357c3..2554d06a650c 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Cadence SPI controller driver (master and slave mode)
+ * Cadence SPI controller driver (host and target mode)
  *
  * Copyright (C) 2008 - 2014 Xilinx, Inc.
  *
@@ -59,10 +59,10 @@
 					CDNS_SPI_CR_BAUD_DIV_4)
 
 /*
- * SPI Configuration Register - Baud rate and slave select
+ * SPI Configuration Register - Baud rate and target select
  *
  * These are the values used in the calculation of baud rate divisor and
- * setting the slave select.
+ * setting the target select.
  */
 
 #define CDNS_SPI_BAUD_DIV_MAX		7 /* Baud rate divisor maximum */
@@ -141,20 +141,20 @@ static inline void cdns_spi_write(struct cdns_spi *xspi, u32 offset, u32 val)
 /**
  * cdns_spi_init_hw - Initialize the hardware and configure the SPI controller
  * @xspi:	Pointer to the cdns_spi structure
- * @is_slave:	Flag to indicate slave or master mode
- * * On reset the SPI controller is configured to slave or  master mode.
- * In master mode baud rate divisor is set to 4, threshold value for TX FIFO
+ * @is_target:	Flag to indicate target or host mode
+ * * On reset the SPI controller is configured to target or host mode.
+ * In host mode baud rate divisor is set to 4, threshold value for TX FIFO
  * not full interrupt is set to 1 and size of the word to be transferred as 8 bit.
  *
  * This function initializes the SPI controller to disable and clear all the
- * interrupts, enable manual slave select and manual start, deselect all the
+ * interrupts, enable manual target select and manual start, deselect all the
  * chip select lines, and enable the SPI controller.
  */
-static void cdns_spi_init_hw(struct cdns_spi *xspi, bool is_slave)
+static void cdns_spi_init_hw(struct cdns_spi *xspi, bool is_target)
 {
 	u32 ctrl_reg = 0;
 
-	if (!is_slave)
+	if (!is_target)
 		ctrl_reg |= CDNS_SPI_CR_DEFAULT;
 
 	if (xspi->is_decoded_cs)
@@ -185,10 +185,10 @@ static void cdns_spi_chipselect(struct spi_device *spi, bool is_high)
 	ctrl_reg = cdns_spi_read(xspi, CDNS_SPI_CR);
 
 	if (is_high) {
-		/* Deselect the slave */
+		/* Deselect the target */
 		ctrl_reg |= CDNS_SPI_CR_SSCTRL;
 	} else {
-		/* Select the slave */
+		/* Select the target */
 		ctrl_reg &= ~CDNS_SPI_CR_SSCTRL;
 		if (!(xspi->is_decoded_cs))
 			ctrl_reg |= ((~(CDNS_SPI_SS0 << spi_get_chipselect(spi, 0))) <<
@@ -227,7 +227,7 @@ static void cdns_spi_config_clock_mode(struct spi_device *spi)
 		/*
 		 * Just writing the CR register does not seem to apply the clock
 		 * setting changes. This is problematic when changing the clock
-		 * polarity as it will cause the SPI slave to see spurious clock
+		 * polarity as it will cause the SPI target to see spurious clock
 		 * transitions. To workaround the issue toggle the ER register.
 		 */
 		cdns_spi_write(xspi, CDNS_SPI_ER, CDNS_SPI_ER_DISABLE);
@@ -406,7 +406,7 @@ static irqreturn_t cdns_spi_irq(int irq, void *dev_id)
 static int cdns_prepare_message(struct spi_controller *ctlr,
 				struct spi_message *msg)
 {
-	if (!spi_controller_is_slave(ctlr))
+	if (!spi_controller_is_target(ctlr))
 		cdns_spi_config_clock_mode(msg->spi);
 	return 0;
 }
@@ -418,9 +418,9 @@ static int cdns_prepare_message(struct spi_controller *ctlr,
  * @transfer:	Pointer to the spi_transfer structure which provides
  *		information about next transfer parameters
  *
- * This function in master mode fills the TX FIFO, starts the SPI transfer and
+ * This function in host mode fills the TX FIFO, starts the SPI transfer and
  * returns a positive transfer count so that core will wait for completion.
- * This function in slave mode fills the TX FIFO and wait for transfer trigger.
+ * This function in target mode fills the TX FIFO and wait for transfer trigger.
  *
  * Return:	Number of bytes transferred in the last transfer
  */
@@ -435,7 +435,7 @@ static int cdns_transfer_one(struct spi_controller *ctlr,
 	xspi->tx_bytes = transfer->len;
 	xspi->rx_bytes = transfer->len;
 
-	if (!spi_controller_is_slave(ctlr)) {
+	if (!spi_controller_is_target(ctlr)) {
 		cdns_spi_setup_transfer(spi, transfer);
 	} else {
 		/* Set TX empty threshold to half of FIFO depth
@@ -457,7 +457,7 @@ static int cdns_transfer_one(struct spi_controller *ctlr,
  * @ctlr:	Pointer to the spi_controller structure which provides
  *		information about the controller.
  *
- * This function enables SPI master controller.
+ * This function enables SPI host controller.
  *
  * Return:	0 always
  */
@@ -475,7 +475,7 @@ static int cdns_prepare_transfer_hardware(struct spi_controller *ctlr)
  * @ctlr:	Pointer to the spi_controller structure which provides
  *		information about the controller.
  *
- * This function disables the SPI master controller when no slave selected.
+ * This function disables the SPI host controller when no target selected.
  * This function flush out if any pending data in FIFO.
  *
  * Return:	0 always
@@ -486,15 +486,15 @@ static int cdns_unprepare_transfer_hardware(struct spi_controller *ctlr)
 	u32 ctrl_reg;
 	unsigned int cnt = xspi->tx_fifo_depth;
 
-	if (spi_controller_is_slave(ctlr)) {
+	if (spi_controller_is_target(ctlr)) {
 		while (cnt--)
 			cdns_spi_read(xspi, CDNS_SPI_RXD);
 	}
 
-	/* Disable the SPI if slave is deselected */
+	/* Disable the SPI if target is deselected */
 	ctrl_reg = cdns_spi_read(xspi, CDNS_SPI_CR);
 	ctrl_reg = (ctrl_reg & CDNS_SPI_CR_SSCTRL) >>  CDNS_SPI_SS_SHIFT;
-	if (ctrl_reg == CDNS_SPI_NOSS || spi_controller_is_slave(ctlr))
+	if (ctrl_reg == CDNS_SPI_NOSS || spi_controller_is_target(ctlr))
 		cdns_spi_write(xspi, CDNS_SPI_ER, CDNS_SPI_ER_DISABLE);
 
 	/* Reset to default */
@@ -521,14 +521,14 @@ static void cdns_spi_detect_fifo_depth(struct cdns_spi *xspi)
 }
 
 /**
- * cdns_slave_abort - Abort slave transfer
+ * cdns_target_abort - Abort target transfer
  * @ctlr:	Pointer to the spi_controller structure
  *
- * This function abort slave transfer if there any transfer timeout.
+ * This function abort target transfer if there any transfer timeout.
  *
  * Return:      0 always
  */
-static int cdns_slave_abort(struct spi_controller *ctlr)
+static int cdns_target_abort(struct spi_controller *ctlr)
 {
 	struct cdns_spi *xspi = spi_controller_get_devdata(ctlr);
 	u32 intr_status;
@@ -555,13 +555,13 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	struct spi_controller *ctlr;
 	struct cdns_spi *xspi;
 	u32 num_cs;
-	bool slave;
+	bool target;
 
-	slave = of_property_read_bool(pdev->dev.of_node, "spi-slave");
-	if (slave)
-		ctlr = spi_alloc_slave(&pdev->dev, sizeof(*xspi));
+	target = of_property_read_bool(pdev->dev.of_node, "spi-slave");
+	if (target)
+		ctlr = spi_alloc_target(&pdev->dev, sizeof(*xspi));
 	else
-		ctlr = spi_alloc_master(&pdev->dev, sizeof(*xspi));
+		ctlr = spi_alloc_host(&pdev->dev, sizeof(*xspi));
 
 	if (!ctlr)
 		return -ENOMEM;
@@ -589,7 +589,7 @@ static int cdns_spi_probe(struct platform_device *pdev)
 		goto remove_ctlr;
 	}
 
-	if (!spi_controller_is_slave(ctlr)) {
+	if (!spi_controller_is_target(ctlr)) {
 		xspi->ref_clk = devm_clk_get(&pdev->dev, "ref_clk");
 		if (IS_ERR(xspi->ref_clk)) {
 			dev_err(&pdev->dev, "ref_clk clock not found.\n");
@@ -624,7 +624,7 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	cdns_spi_detect_fifo_depth(xspi);
 
 	/* SPI controller initializations */
-	cdns_spi_init_hw(xspi, spi_controller_is_slave(ctlr));
+	cdns_spi_init_hw(xspi, spi_controller_is_target(ctlr));
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
@@ -648,7 +648,7 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA;
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 
-	if (!spi_controller_is_slave(ctlr)) {
+	if (!spi_controller_is_target(ctlr)) {
 		ctlr->mode_bits |=  SPI_CS_HIGH;
 		ctlr->set_cs = cdns_spi_chipselect;
 		ctlr->auto_runtime_pm = true;
@@ -660,7 +660,7 @@ static int cdns_spi_probe(struct platform_device *pdev)
 		pm_runtime_put_autosuspend(&pdev->dev);
 	} else {
 		ctlr->mode_bits |= SPI_NO_CS;
-		ctlr->slave_abort = cdns_slave_abort;
+		ctlr->target_abort = cdns_target_abort;
 	}
 	ret = spi_register_controller(ctlr);
 	if (ret) {
@@ -671,7 +671,7 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	return ret;
 
 clk_dis_all:
-	if (!spi_controller_is_slave(ctlr)) {
+	if (!spi_controller_is_target(ctlr)) {
 		pm_runtime_set_suspended(&pdev->dev);
 		pm_runtime_disable(&pdev->dev);
 		clk_disable_unprepare(xspi->ref_clk);
@@ -735,7 +735,7 @@ static int __maybe_unused cdns_spi_resume(struct device *dev)
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
 	struct cdns_spi *xspi = spi_controller_get_devdata(ctlr);
 
-	cdns_spi_init_hw(xspi, spi_controller_is_slave(ctlr));
+	cdns_spi_init_hw(xspi, spi_controller_is_target(ctlr));
 	return spi_controller_resume(ctlr);
 }
 
-- 
2.25.1

