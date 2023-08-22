Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D2A783776
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 03:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjHVBit (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Aug 2023 21:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjHVBiq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Aug 2023 21:38:46 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D9E187
        for <linux-spi@vger.kernel.org>; Mon, 21 Aug 2023 18:38:42 -0700 (PDT)
Received: from dggpemm100018.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RVBlG45KXzVkC6;
        Tue, 22 Aug 2023 09:36:26 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100018.china.huawei.com (7.185.36.206) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 22 Aug 2023 09:38:40 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 09:38:39 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 08/24] spi: sunplus-sp7021: switch to use modern name
Date:   Tue, 22 Aug 2023 09:34:55 +0800
Message-ID: <20230822013511.4161475-9-yangyingliang@huawei.com>
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
 drivers/spi/spi-sunplus-sp7021.c | 88 ++++++++++++++++----------------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/spi/spi-sunplus-sp7021.c b/drivers/spi/spi-sunplus-sp7021.c
index eb8f835a4771..4e481380c259 100644
--- a/drivers/spi/spi-sunplus-sp7021.c
+++ b/drivers/spi/spi-sunplus-sp7021.c
@@ -70,8 +70,8 @@
 #define SP7021_FIFO_DATA_LEN		(16)
 
 enum {
-	SP7021_MASTER_MODE = 0,
-	SP7021_SLAVE_MODE = 1,
+	SP7021_HOST_MODE = 0,
+	SP7021_TARGET_MODE = 1,
 };
 
 struct sp7021_spi_ctlr {
@@ -88,7 +88,7 @@ struct sp7021_spi_ctlr {
 	// data xfer lock
 	struct mutex buf_lock;
 	struct completion isr_done;
-	struct completion slave_isr;
+	struct completion target_isr;
 	unsigned int  rx_cur_len;
 	unsigned int  tx_cur_len;
 	unsigned int  data_unit;
@@ -96,7 +96,7 @@ struct sp7021_spi_ctlr {
 	u8 *rx_buf;
 };
 
-static irqreturn_t sp7021_spi_slave_irq(int irq, void *dev)
+static irqreturn_t sp7021_spi_target_irq(int irq, void *dev)
 {
 	struct sp7021_spi_ctlr *pspim = dev;
 	unsigned int data_status;
@@ -104,25 +104,25 @@ static irqreturn_t sp7021_spi_slave_irq(int irq, void *dev)
 	data_status = readl(pspim->s_base + SP7021_DATA_RDY_REG);
 	data_status |= SP7021_SLAVE_CLR_INT;
 	writel(data_status , pspim->s_base + SP7021_DATA_RDY_REG);
-	complete(&pspim->slave_isr);
+	complete(&pspim->target_isr);
 	return IRQ_HANDLED;
 }
 
-static int sp7021_spi_slave_abort(struct spi_controller *ctlr)
+static int sp7021_spi_target_abort(struct spi_controller *ctlr)
 {
-	struct sp7021_spi_ctlr *pspim = spi_master_get_devdata(ctlr);
+	struct sp7021_spi_ctlr *pspim = spi_controller_get_devdata(ctlr);
 
-	complete(&pspim->slave_isr);
+	complete(&pspim->target_isr);
 	complete(&pspim->isr_done);
 	return 0;
 }
 
-static int sp7021_spi_slave_tx(struct spi_device *spi, struct spi_transfer *xfer)
+static int sp7021_spi_target_tx(struct spi_device *spi, struct spi_transfer *xfer)
 {
 	struct sp7021_spi_ctlr *pspim = spi_controller_get_devdata(spi->controller);
 	u32 value;
 
-	reinit_completion(&pspim->slave_isr);
+	reinit_completion(&pspim->target_isr);
 	value = SP7021_SLAVE_DMA_EN | SP7021_SLAVE_DMA_RW | FIELD_PREP(SP7021_SLAVE_DMA_CMD, 3);
 	writel(value, pspim->s_base + SP7021_SLAVE_DMA_CTRL_REG);
 	writel(xfer->len, pspim->s_base + SP7021_SLAVE_DMA_LENGTH_REG);
@@ -137,7 +137,7 @@ static int sp7021_spi_slave_tx(struct spi_device *spi, struct spi_transfer *xfer
 	return 0;
 }
 
-static int sp7021_spi_slave_rx(struct spi_device *spi, struct spi_transfer *xfer)
+static int sp7021_spi_target_rx(struct spi_device *spi, struct spi_transfer *xfer)
 {
 	struct sp7021_spi_ctlr *pspim = spi_controller_get_devdata(spi->controller);
 	u32 value;
@@ -155,7 +155,7 @@ static int sp7021_spi_slave_rx(struct spi_device *spi, struct spi_transfer *xfer
 	return 0;
 }
 
-static void sp7021_spi_master_rb(struct sp7021_spi_ctlr *pspim, unsigned int len)
+static void sp7021_spi_host_rb(struct sp7021_spi_ctlr *pspim, unsigned int len)
 {
 	int i;
 
@@ -166,7 +166,7 @@ static void sp7021_spi_master_rb(struct sp7021_spi_ctlr *pspim, unsigned int len
 	}
 }
 
-static void sp7021_spi_master_wb(struct sp7021_spi_ctlr *pspim, unsigned int len)
+static void sp7021_spi_host_wb(struct sp7021_spi_ctlr *pspim, unsigned int len)
 {
 	int i;
 
@@ -177,7 +177,7 @@ static void sp7021_spi_master_wb(struct sp7021_spi_ctlr *pspim, unsigned int len
 	}
 }
 
-static irqreturn_t sp7021_spi_master_irq(int irq, void *dev)
+static irqreturn_t sp7021_spi_host_irq(int irq, void *dev)
 {
 	struct sp7021_spi_ctlr *pspim = dev;
 	unsigned int tx_cnt, total_len;
@@ -206,9 +206,9 @@ static irqreturn_t sp7021_spi_master_irq(int irq, void *dev)
 		fd_status, rx_cnt, tx_cnt, tx_len);
 
 	if (rx_cnt > 0)
-		sp7021_spi_master_rb(pspim, rx_cnt);
+		sp7021_spi_host_rb(pspim, rx_cnt);
 	if (tx_cnt > 0)
-		sp7021_spi_master_wb(pspim, tx_cnt);
+		sp7021_spi_host_wb(pspim, tx_cnt);
 
 	fd_status = readl(pspim->m_base + SP7021_SPI_STATUS_REG);
 	tx_len = FIELD_GET(SP7021_TX_LEN_MASK, fd_status);
@@ -224,7 +224,7 @@ static irqreturn_t sp7021_spi_master_irq(int irq, void *dev)
 				rx_cnt = FIELD_GET(SP7021_RX_CNT_MASK, fd_status);
 
 			if (rx_cnt > 0)
-				sp7021_spi_master_rb(pspim, rx_cnt);
+				sp7021_spi_host_rb(pspim, rx_cnt);
 		}
 		value = readl(pspim->m_base + SP7021_INT_BUSY_REG);
 		value |= SP7021_CLR_MASTER_INT;
@@ -240,7 +240,7 @@ static irqreturn_t sp7021_spi_master_irq(int irq, void *dev)
 
 static void sp7021_prep_transfer(struct spi_controller *ctlr, struct spi_device *spi)
 {
-	struct sp7021_spi_ctlr *pspim = spi_master_get_devdata(ctlr);
+	struct sp7021_spi_ctlr *pspim = spi_controller_get_devdata(ctlr);
 
 	pspim->tx_cur_len = 0;
 	pspim->rx_cur_len = 0;
@@ -251,7 +251,7 @@ static void sp7021_prep_transfer(struct spi_controller *ctlr, struct spi_device
 static int sp7021_spi_controller_prepare_message(struct spi_controller *ctlr,
 						 struct spi_message *msg)
 {
-	struct sp7021_spi_ctlr *pspim = spi_master_get_devdata(ctlr);
+	struct sp7021_spi_ctlr *pspim = spi_controller_get_devdata(ctlr);
 	struct spi_device *s = msg->spi;
 	u32 valus, rs = 0;
 
@@ -283,7 +283,7 @@ static int sp7021_spi_controller_prepare_message(struct spi_controller *ctlr,
 
 static void sp7021_spi_setup_clk(struct spi_controller *ctlr, struct spi_transfer *xfer)
 {
-	struct sp7021_spi_ctlr *pspim = spi_master_get_devdata(ctlr);
+	struct sp7021_spi_ctlr *pspim = spi_controller_get_devdata(ctlr);
 	u32 clk_rate, clk_sel, div;
 
 	clk_rate = clk_get_rate(pspim->spi_clk);
@@ -295,10 +295,10 @@ static void sp7021_spi_setup_clk(struct spi_controller *ctlr, struct spi_transfe
 	writel(pspim->xfer_conf, pspim->m_base + SP7021_SPI_CONFIG_REG);
 }
 
-static int sp7021_spi_master_transfer_one(struct spi_controller *ctlr, struct spi_device *spi,
+static int sp7021_spi_host_transfer_one(struct spi_controller *ctlr, struct spi_device *spi,
 				       struct spi_transfer *xfer)
 {
-	struct sp7021_spi_ctlr *pspim = spi_master_get_devdata(ctlr);
+	struct sp7021_spi_ctlr *pspim = spi_controller_get_devdata(ctlr);
 	unsigned long timeout = msecs_to_jiffies(1000);
 	unsigned int xfer_cnt, xfer_len, last_len;
 	unsigned int i, len_temp;
@@ -323,7 +323,7 @@ static int sp7021_spi_master_transfer_one(struct spi_controller *ctlr, struct sp
 
 		if (pspim->tx_cur_len < xfer_len) {
 			len_temp = min(pspim->data_unit, xfer_len);
-			sp7021_spi_master_wb(pspim, len_temp);
+			sp7021_spi_host_wb(pspim, len_temp);
 		}
 		reg_temp = readl(pspim->m_base + SP7021_SPI_CONFIG_REG);
 		reg_temp &= ~SP7021_CLEAN_RW_BYTE;
@@ -359,10 +359,10 @@ static int sp7021_spi_master_transfer_one(struct spi_controller *ctlr, struct sp
 	return 0;
 }
 
-static int sp7021_spi_slave_transfer_one(struct spi_controller *ctlr, struct spi_device *spi,
+static int sp7021_spi_target_transfer_one(struct spi_controller *ctlr, struct spi_device *spi,
 				       struct spi_transfer *xfer)
 {
-	struct sp7021_spi_ctlr *pspim = spi_master_get_devdata(ctlr);
+	struct sp7021_spi_ctlr *pspim = spi_controller_get_devdata(ctlr);
 	struct device *dev = pspim->dev;
 	int ret;
 
@@ -371,14 +371,14 @@ static int sp7021_spi_slave_transfer_one(struct spi_controller *ctlr, struct spi
 					      xfer->len, DMA_TO_DEVICE);
 		if (dma_mapping_error(dev, xfer->tx_dma))
 			return -ENOMEM;
-		ret = sp7021_spi_slave_tx(spi, xfer);
+		ret = sp7021_spi_target_tx(spi, xfer);
 		dma_unmap_single(dev, xfer->tx_dma, xfer->len, DMA_TO_DEVICE);
 	} else if (xfer->rx_buf && !xfer->tx_buf) {
 		xfer->rx_dma = dma_map_single(dev, xfer->rx_buf, xfer->len,
 					      DMA_FROM_DEVICE);
 		if (dma_mapping_error(dev, xfer->rx_dma))
 			return -ENOMEM;
-		ret = sp7021_spi_slave_rx(spi, xfer);
+		ret = sp7021_spi_target_rx(spi, xfer);
 		dma_unmap_single(dev, xfer->rx_dma, xfer->len, DMA_FROM_DEVICE);
 	} else {
 		dev_dbg(&ctlr->dev, "%s() wrong command\n", __func__);
@@ -409,14 +409,14 @@ static int sp7021_spi_controller_probe(struct platform_device *pdev)
 	pdev->id = of_alias_get_id(pdev->dev.of_node, "sp_spi");
 
 	if (device_property_read_bool(dev, "spi-slave"))
-		mode = SP7021_SLAVE_MODE;
+		mode = SP7021_TARGET_MODE;
 	else
-		mode = SP7021_MASTER_MODE;
+		mode = SP7021_HOST_MODE;
 
-	if (mode == SP7021_SLAVE_MODE)
-		ctlr = devm_spi_alloc_slave(dev, sizeof(*pspim));
+	if (mode == SP7021_TARGET_MODE)
+		ctlr = devm_spi_alloc_target(dev, sizeof(*pspim));
 	else
-		ctlr = devm_spi_alloc_master(dev, sizeof(*pspim));
+		ctlr = devm_spi_alloc_host(dev, sizeof(*pspim));
 	if (!ctlr)
 		return -ENOMEM;
 	device_set_node(&ctlr->dev, dev_fwnode(dev));
@@ -424,9 +424,9 @@ static int sp7021_spi_controller_probe(struct platform_device *pdev)
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
 	ctlr->auto_runtime_pm = true;
 	ctlr->prepare_message = sp7021_spi_controller_prepare_message;
-	if (mode == SP7021_SLAVE_MODE) {
-		ctlr->transfer_one = sp7021_spi_slave_transfer_one;
-		ctlr->slave_abort = sp7021_spi_slave_abort;
+	if (mode == SP7021_TARGET_MODE) {
+		ctlr->transfer_one = sp7021_spi_target_transfer_one;
+		ctlr->target_abort = sp7021_spi_target_abort;
 		ctlr->flags = SPI_CONTROLLER_HALF_DUPLEX;
 	} else {
 		ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
@@ -434,7 +434,7 @@ static int sp7021_spi_controller_probe(struct platform_device *pdev)
 		ctlr->max_speed_hz = 25000000;
 		ctlr->use_gpio_descriptors = true;
 		ctlr->flags = SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX;
-		ctlr->transfer_one = sp7021_spi_master_transfer_one;
+		ctlr->transfer_one = sp7021_spi_host_transfer_one;
 	}
 	platform_set_drvdata(pdev, ctlr);
 	pspim = spi_controller_get_devdata(ctlr);
@@ -443,7 +443,7 @@ static int sp7021_spi_controller_probe(struct platform_device *pdev)
 	pspim->dev = dev;
 	mutex_init(&pspim->buf_lock);
 	init_completion(&pspim->isr_done);
-	init_completion(&pspim->slave_isr);
+	init_completion(&pspim->target_isr);
 
 	pspim->m_base = devm_platform_ioremap_resource_byname(pdev, "master");
 	if (IS_ERR(pspim->m_base))
@@ -485,12 +485,12 @@ static int sp7021_spi_controller_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = devm_request_irq(dev, pspim->m_irq, sp7021_spi_master_irq,
+	ret = devm_request_irq(dev, pspim->m_irq, sp7021_spi_host_irq,
 			       IRQF_TRIGGER_RISING, pdev->name, pspim);
 	if (ret)
 		return ret;
 
-	ret = devm_request_irq(dev, pspim->s_irq, sp7021_spi_slave_irq,
+	ret = devm_request_irq(dev, pspim->s_irq, sp7021_spi_target_irq,
 			       IRQF_TRIGGER_RISING, pdev->name, pspim);
 	if (ret)
 		return ret;
@@ -499,7 +499,7 @@ static int sp7021_spi_controller_probe(struct platform_device *pdev)
 	ret = spi_register_controller(ctlr);
 	if (ret) {
 		pm_runtime_disable(dev);
-		return dev_err_probe(dev, ret, "spi_register_master fail\n");
+		return dev_err_probe(dev, ret, "spi_register_controller fail\n");
 	}
 	return 0;
 }
@@ -516,7 +516,7 @@ static void sp7021_spi_controller_remove(struct platform_device *pdev)
 static int __maybe_unused sp7021_spi_controller_suspend(struct device *dev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
-	struct sp7021_spi_ctlr *pspim = spi_master_get_devdata(ctlr);
+	struct sp7021_spi_ctlr *pspim = spi_controller_get_devdata(ctlr);
 
 	return reset_control_assert(pspim->rstc);
 }
@@ -524,7 +524,7 @@ static int __maybe_unused sp7021_spi_controller_suspend(struct device *dev)
 static int __maybe_unused sp7021_spi_controller_resume(struct device *dev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
-	struct sp7021_spi_ctlr *pspim = spi_master_get_devdata(ctlr);
+	struct sp7021_spi_ctlr *pspim = spi_controller_get_devdata(ctlr);
 
 	reset_control_deassert(pspim->rstc);
 	return clk_prepare_enable(pspim->spi_clk);
@@ -534,7 +534,7 @@ static int __maybe_unused sp7021_spi_controller_resume(struct device *dev)
 static int sp7021_spi_runtime_suspend(struct device *dev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
-	struct sp7021_spi_ctlr *pspim = spi_master_get_devdata(ctlr);
+	struct sp7021_spi_ctlr *pspim = spi_controller_get_devdata(ctlr);
 
 	return reset_control_assert(pspim->rstc);
 }
@@ -542,7 +542,7 @@ static int sp7021_spi_runtime_suspend(struct device *dev)
 static int sp7021_spi_runtime_resume(struct device *dev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
-	struct sp7021_spi_ctlr *pspim = spi_master_get_devdata(ctlr);
+	struct sp7021_spi_ctlr *pspim = spi_controller_get_devdata(ctlr);
 
 	return reset_control_deassert(pspim->rstc);
 }
-- 
2.25.1

