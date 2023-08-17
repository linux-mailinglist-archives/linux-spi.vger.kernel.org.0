Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923C177F022
	for <lists+linux-spi@lfdr.de>; Thu, 17 Aug 2023 07:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348065AbjHQFHy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Aug 2023 01:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348074AbjHQFHe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Aug 2023 01:07:34 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188802684
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 22:07:32 -0700 (PDT)
Received: from dggpemm100008.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RRCb21QFzzNn33;
        Thu, 17 Aug 2023 13:03:58 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100008.china.huawei.com (7.185.36.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 17 Aug 2023 13:07:30 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 17 Aug
 2023 13:07:29 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v2 08/23] spi: spi-qcom-qspi: switch to use modern name
Date:   Thu, 17 Aug 2023 13:03:17 +0800
Message-ID: <20230817050332.1274751-9-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230817050332.1274751-1-yangyingliang@huawei.com>
References: <20230817050332.1274751-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
 drivers/spi/spi-qcom-qspi.c | 80 ++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index b9d5641b3365..49b775134485 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -247,11 +247,11 @@ static void qcom_qspi_pio_xfer(struct qcom_qspi *ctrl)
 	qcom_qspi_pio_xfer_ctrl(ctrl);
 }
 
-static void qcom_qspi_handle_err(struct spi_master *master,
+static void qcom_qspi_handle_err(struct spi_controller *host,
 				 struct spi_message *msg)
 {
 	u32 int_status;
-	struct qcom_qspi *ctrl = spi_master_get_devdata(master);
+	struct qcom_qspi *ctrl = spi_controller_get_devdata(host);
 	unsigned long flags;
 	int i;
 
@@ -411,11 +411,11 @@ static bool qcom_qspi_can_dma(struct spi_controller *ctlr,
 	return xfer->len > QSPI_MAX_BYTES_FIFO;
 }
 
-static int qcom_qspi_transfer_one(struct spi_master *master,
+static int qcom_qspi_transfer_one(struct spi_controller *host,
 				  struct spi_device *slv,
 				  struct spi_transfer *xfer)
 {
-	struct qcom_qspi *ctrl = spi_master_get_devdata(master);
+	struct qcom_qspi *ctrl = spi_controller_get_devdata(host);
 	int ret;
 	unsigned long speed_hz;
 	unsigned long flags;
@@ -443,7 +443,7 @@ static int qcom_qspi_transfer_one(struct spi_master *master,
 		ctrl->xfer.tx_buf = xfer->tx_buf;
 	}
 	ctrl->xfer.is_last = list_is_last(&xfer->transfer_list,
-					  &master->cur_msg->transfers);
+					  &host->cur_msg->transfers);
 	ctrl->xfer.rem_bytes = xfer->len;
 
 	if (xfer->rx_sg.nents || xfer->tx_sg.nents) {
@@ -481,7 +481,7 @@ static int qcom_qspi_transfer_one(struct spi_master *master,
 	return 1;
 }
 
-static int qcom_qspi_prepare_message(struct spi_master *master,
+static int qcom_qspi_prepare_message(struct spi_controller *host,
 				     struct spi_message *message)
 {
 	u32 mstr_cfg;
@@ -490,7 +490,7 @@ static int qcom_qspi_prepare_message(struct spi_master *master,
 	int tx_data_delay = 1;
 	unsigned long flags;
 
-	ctrl = spi_master_get_devdata(master);
+	ctrl = spi_controller_get_devdata(host);
 	spin_lock_irqsave(&ctrl->lock, flags);
 
 	mstr_cfg = readl(ctrl->base + MSTR_CONFIG);
@@ -694,18 +694,18 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct device *dev;
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct qcom_qspi *ctrl;
 
 	dev = &pdev->dev;
 
-	master = devm_spi_alloc_master(dev, sizeof(*ctrl));
-	if (!master)
+	host = devm_spi_alloc_host(dev, sizeof(*ctrl));
+	if (!host)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 
-	ctrl = spi_master_get_devdata(master);
+	ctrl = spi_controller_get_devdata(host);
 
 	spin_lock_init(&ctrl->lock);
 	ctrl->dev = dev;
@@ -758,23 +758,23 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "could not set DMA mask\n");
 
-	master->max_speed_hz = 300000000;
-	master->max_dma_len = 65536; /* as per HPG */
-	master->dma_alignment = QSPI_ALIGN_REQ;
-	master->num_chipselect = QSPI_NUM_CS;
-	master->bus_num = -1;
-	master->dev.of_node = pdev->dev.of_node;
-	master->mode_bits = SPI_MODE_0 |
-			    SPI_TX_DUAL | SPI_RX_DUAL |
-			    SPI_TX_QUAD | SPI_RX_QUAD;
-	master->flags = SPI_CONTROLLER_HALF_DUPLEX;
-	master->prepare_message = qcom_qspi_prepare_message;
-	master->transfer_one = qcom_qspi_transfer_one;
-	master->handle_err = qcom_qspi_handle_err;
+	host->max_speed_hz = 300000000;
+	host->max_dma_len = 65536; /* as per HPG */
+	host->dma_alignment = QSPI_ALIGN_REQ;
+	host->num_chipselect = QSPI_NUM_CS;
+	host->bus_num = -1;
+	host->dev.of_node = pdev->dev.of_node;
+	host->mode_bits = SPI_MODE_0 |
+			  SPI_TX_DUAL | SPI_RX_DUAL |
+			  SPI_TX_QUAD | SPI_RX_QUAD;
+	host->flags = SPI_CONTROLLER_HALF_DUPLEX;
+	host->prepare_message = qcom_qspi_prepare_message;
+	host->transfer_one = qcom_qspi_transfer_one;
+	host->handle_err = qcom_qspi_handle_err;
 	if (of_property_read_bool(pdev->dev.of_node, "iommus"))
-		master->can_dma = qcom_qspi_can_dma;
-	master->auto_runtime_pm = true;
-	master->mem_ops = &qcom_qspi_mem_ops;
+		host->can_dma = qcom_qspi_can_dma;
+	host->auto_runtime_pm = true;
+	host->mem_ops = &qcom_qspi_mem_ops;
 
 	ret = devm_pm_opp_set_clkname(&pdev->dev, "core");
 	if (ret)
@@ -794,7 +794,7 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 	pm_runtime_set_autosuspend_delay(dev, 250);
 	pm_runtime_enable(dev);
 
-	ret = spi_register_master(master);
+	ret = spi_register_controller(host);
 	if (!ret)
 		return 0;
 
@@ -805,18 +805,18 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 
 static void qcom_qspi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
+	struct spi_controller *host = platform_get_drvdata(pdev);
 
 	/* Unregister _before_ disabling pm_runtime() so we stop transfers */
-	spi_unregister_master(master);
+	spi_unregister_controller(host);
 
 	pm_runtime_disable(&pdev->dev);
 }
 
 static int __maybe_unused qcom_qspi_runtime_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct qcom_qspi *ctrl = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct qcom_qspi *ctrl = spi_controller_get_devdata(host);
 	int ret;
 
 	/* Drop the performance state vote */
@@ -837,8 +837,8 @@ static int __maybe_unused qcom_qspi_runtime_suspend(struct device *dev)
 
 static int __maybe_unused qcom_qspi_runtime_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct qcom_qspi *ctrl = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct qcom_qspi *ctrl = spi_controller_get_devdata(host);
 	int ret;
 
 	pinctrl_pm_select_default_state(dev);
@@ -859,30 +859,30 @@ static int __maybe_unused qcom_qspi_runtime_resume(struct device *dev)
 
 static int __maybe_unused qcom_qspi_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
+	struct spi_controller *host = dev_get_drvdata(dev);
 	int ret;
 
-	ret = spi_master_suspend(master);
+	ret = spi_controller_suspend(host);
 	if (ret)
 		return ret;
 
 	ret = pm_runtime_force_suspend(dev);
 	if (ret)
-		spi_master_resume(master);
+		spi_controller_resume(host);
 
 	return ret;
 }
 
 static int __maybe_unused qcom_qspi_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
+	struct spi_controller *host = dev_get_drvdata(dev);
 	int ret;
 
 	ret = pm_runtime_force_resume(dev);
 	if (ret)
 		return ret;
 
-	ret = spi_master_resume(master);
+	ret = spi_controller_resume(host);
 	if (ret)
 		pm_runtime_force_suspend(dev);
 
-- 
2.25.1

