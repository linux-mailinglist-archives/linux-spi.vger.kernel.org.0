Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD5F7808A1
	for <lists+linux-spi@lfdr.de>; Fri, 18 Aug 2023 11:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359243AbjHRJf7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Aug 2023 05:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359294AbjHRJf1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Aug 2023 05:35:27 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939783AB6
        for <linux-spi@vger.kernel.org>; Fri, 18 Aug 2023 02:35:24 -0700 (PDT)
Received: from dggpemm100017.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RRxTX074gztS9L;
        Fri, 18 Aug 2023 17:31:44 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100017.china.huawei.com (7.185.36.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 18 Aug 2023 17:35:22 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 18 Aug
 2023 17:35:22 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v3 16/23] spi: s3c64xx: switch to use modern name
Date:   Fri, 18 Aug 2023 17:31:47 +0800
Message-ID: <20230818093154.1183529-17-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818093154.1183529-1-yangyingliang@huawei.com>
References: <20230818093154.1183529-1-yangyingliang@huawei.com>
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

Change legacy name master/slave to modern name host/target or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-s3c64xx.c | 126 +++++++++++++++++++-------------------
 1 file changed, 63 insertions(+), 63 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index bf7cb18be9dc..0e48ffd499b9 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -163,9 +163,9 @@ struct s3c64xx_spi_port_config {
  * struct s3c64xx_spi_driver_data - Runtime info holder for SPI driver.
  * @clk: Pointer to the spi clock.
  * @src_clk: Pointer to the clock used to generate SPI signals.
- * @ioclk: Pointer to the i/o clock between master and slave
+ * @ioclk: Pointer to the i/o clock between host and target
  * @pdev: Pointer to device's platform device data
- * @master: Pointer to the SPI Protocol master.
+ * @host: Pointer to the SPI Protocol host.
  * @cntrlr_info: Platform specific data for the controller this driver manages.
  * @lock: Controller specific lock.
  * @state: Set of FLAGS to indicate status.
@@ -186,7 +186,7 @@ struct s3c64xx_spi_driver_data {
 	struct clk                      *src_clk;
 	struct clk                      *ioclk;
 	struct platform_device          *pdev;
-	struct spi_master               *master;
+	struct spi_controller           *host;
 	struct s3c64xx_spi_info         *cntrlr_info;
 	spinlock_t                      lock;
 	unsigned long                   sfr_start;
@@ -329,7 +329,7 @@ static int prepare_dma(struct s3c64xx_spi_dma_data *dma,
 static void s3c64xx_spi_set_cs(struct spi_device *spi, bool enable)
 {
 	struct s3c64xx_spi_driver_data *sdd =
-					spi_master_get_devdata(spi->master);
+					spi_controller_get_devdata(spi->controller);
 
 	if (sdd->cntrlr_info->no_cs)
 		return;
@@ -351,9 +351,9 @@ static void s3c64xx_spi_set_cs(struct spi_device *spi, bool enable)
 	}
 }
 
-static int s3c64xx_spi_prepare_transfer(struct spi_master *spi)
+static int s3c64xx_spi_prepare_transfer(struct spi_controller *spi)
 {
-	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(spi);
+	struct s3c64xx_spi_driver_data *sdd = spi_controller_get_devdata(spi);
 
 	if (is_polling(sdd))
 		return 0;
@@ -381,9 +381,9 @@ static int s3c64xx_spi_prepare_transfer(struct spi_master *spi)
 	return 0;
 }
 
-static int s3c64xx_spi_unprepare_transfer(struct spi_master *spi)
+static int s3c64xx_spi_unprepare_transfer(struct spi_controller *spi)
 {
-	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(spi);
+	struct s3c64xx_spi_driver_data *sdd = spi_controller_get_devdata(spi);
 
 	if (is_polling(sdd))
 		return 0;
@@ -399,11 +399,11 @@ static int s3c64xx_spi_unprepare_transfer(struct spi_master *spi)
 	return 0;
 }
 
-static bool s3c64xx_spi_can_dma(struct spi_master *master,
+static bool s3c64xx_spi_can_dma(struct spi_controller *host,
 				struct spi_device *spi,
 				struct spi_transfer *xfer)
 {
-	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
+	struct s3c64xx_spi_driver_data *sdd = spi_controller_get_devdata(host);
 
 	if (sdd->rx_dma.ch && sdd->tx_dma.ch) {
 		return xfer->len > (FIFO_LVL_MASK(sdd) >> 1) + 1;
@@ -712,10 +712,10 @@ static int s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 
 #define XFER_DMAADDR_INVALID DMA_BIT_MASK(32)
 
-static int s3c64xx_spi_prepare_message(struct spi_master *master,
+static int s3c64xx_spi_prepare_message(struct spi_controller *host,
 				       struct spi_message *msg)
 {
-	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
+	struct s3c64xx_spi_driver_data *sdd = spi_controller_get_devdata(host);
 	struct spi_device *spi = msg->spi;
 	struct s3c64xx_spi_csinfo *cs = spi->controller_data;
 
@@ -736,11 +736,11 @@ static size_t s3c64xx_spi_max_transfer_size(struct spi_device *spi)
 	return ctlr->can_dma ? S3C64XX_SPI_PACKET_CNT_MASK : SIZE_MAX;
 }
 
-static int s3c64xx_spi_transfer_one(struct spi_master *master,
+static int s3c64xx_spi_transfer_one(struct spi_controller *host,
 				    struct spi_device *spi,
 				    struct spi_transfer *xfer)
 {
-	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
+	struct s3c64xx_spi_driver_data *sdd = spi_controller_get_devdata(host);
 	const unsigned int fifo_len = (FIFO_LVL_MASK(sdd) >> 1) + 1;
 	const void *tx_buf = NULL;
 	void *rx_buf = NULL;
@@ -890,15 +890,15 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 	return status;
 }
 
-static struct s3c64xx_spi_csinfo *s3c64xx_get_slave_ctrldata(
+static struct s3c64xx_spi_csinfo *s3c64xx_get_target_ctrldata(
 				struct spi_device *spi)
 {
 	struct s3c64xx_spi_csinfo *cs;
-	struct device_node *slave_np, *data_np = NULL;
+	struct device_node *target_np, *data_np = NULL;
 	u32 fb_delay = 0;
 
-	slave_np = spi->dev.of_node;
-	if (!slave_np) {
+	target_np = spi->dev.of_node;
+	if (!target_np) {
 		dev_err(&spi->dev, "device node not found\n");
 		return ERR_PTR(-EINVAL);
 	}
@@ -907,7 +907,7 @@ static struct s3c64xx_spi_csinfo *s3c64xx_get_slave_ctrldata(
 	if (!cs)
 		return ERR_PTR(-ENOMEM);
 
-	data_np = of_get_child_by_name(slave_np, "controller-data");
+	data_np = of_get_child_by_name(target_np, "controller-data");
 	if (!data_np) {
 		dev_info(&spi->dev, "feedback delay set to default (0)\n");
 		return cs;
@@ -932,9 +932,9 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 	int err;
 	int div;
 
-	sdd = spi_master_get_devdata(spi->master);
+	sdd = spi_controller_get_devdata(spi->controller);
 	if (spi->dev.of_node) {
-		cs = s3c64xx_get_slave_ctrldata(spi);
+		cs = s3c64xx_get_target_ctrldata(spi);
 		spi->controller_data = cs;
 	}
 
@@ -1022,7 +1022,7 @@ static void s3c64xx_spi_cleanup(struct spi_device *spi)
 static irqreturn_t s3c64xx_spi_irq(int irq, void *data)
 {
 	struct s3c64xx_spi_driver_data *sdd = data;
-	struct spi_master *spi = sdd->master;
+	struct spi_controller *spi = sdd->host;
 	unsigned int val, clr = 0;
 
 	val = readl(sdd->regs + S3C64XX_SPI_STATUS);
@@ -1151,7 +1151,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	struct resource	*mem_res;
 	struct s3c64xx_spi_driver_data *sdd;
 	struct s3c64xx_spi_info *sci = dev_get_platdata(&pdev->dev);
-	struct spi_master *master;
+	struct spi_controller *host;
 	int ret, irq;
 	char clk_name[16];
 
@@ -1169,16 +1169,16 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	master = devm_spi_alloc_master(&pdev->dev, sizeof(*sdd));
-	if (!master)
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*sdd));
+	if (!host)
 		return dev_err_probe(&pdev->dev, -ENOMEM,
-				     "Unable to allocate SPI Master\n");
+				     "Unable to allocate SPI Host\n");
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 
-	sdd = spi_master_get_devdata(master);
+	sdd = spi_controller_get_devdata(host);
 	sdd->port_conf = s3c64xx_spi_get_port_config(pdev);
-	sdd->master = master;
+	sdd->host = host;
 	sdd->cntrlr_info = sci;
 	sdd->pdev = pdev;
 	if (pdev->dev.of_node) {
@@ -1196,27 +1196,27 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	sdd->tx_dma.direction = DMA_MEM_TO_DEV;
 	sdd->rx_dma.direction = DMA_DEV_TO_MEM;
 
-	master->dev.of_node = pdev->dev.of_node;
-	master->bus_num = sdd->port_id;
-	master->setup = s3c64xx_spi_setup;
-	master->cleanup = s3c64xx_spi_cleanup;
-	master->prepare_transfer_hardware = s3c64xx_spi_prepare_transfer;
-	master->unprepare_transfer_hardware = s3c64xx_spi_unprepare_transfer;
-	master->prepare_message = s3c64xx_spi_prepare_message;
-	master->transfer_one = s3c64xx_spi_transfer_one;
-	master->max_transfer_size = s3c64xx_spi_max_transfer_size;
-	master->num_chipselect = sci->num_cs;
-	master->use_gpio_descriptors = true;
-	master->dma_alignment = 8;
-	master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(16) |
-					SPI_BPW_MASK(8);
+	host->dev.of_node = pdev->dev.of_node;
+	host->bus_num = sdd->port_id;
+	host->setup = s3c64xx_spi_setup;
+	host->cleanup = s3c64xx_spi_cleanup;
+	host->prepare_transfer_hardware = s3c64xx_spi_prepare_transfer;
+	host->unprepare_transfer_hardware = s3c64xx_spi_unprepare_transfer;
+	host->prepare_message = s3c64xx_spi_prepare_message;
+	host->transfer_one = s3c64xx_spi_transfer_one;
+	host->max_transfer_size = s3c64xx_spi_max_transfer_size;
+	host->num_chipselect = sci->num_cs;
+	host->use_gpio_descriptors = true;
+	host->dma_alignment = 8;
+	host->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(16) |
+				   SPI_BPW_MASK(8);
 	/* the spi->mode bits understood by this driver: */
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 	if (sdd->port_conf->has_loopback)
-		master->mode_bits |= SPI_LOOP;
-	master->auto_runtime_pm = true;
+		host->mode_bits |= SPI_LOOP;
+	host->auto_runtime_pm = true;
 	if (!is_polling(sdd))
-		master->can_dma = s3c64xx_spi_can_dma;
+		host->can_dma = s3c64xx_spi_can_dma;
 
 	sdd->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &mem_res);
 	if (IS_ERR(sdd->regs))
@@ -1271,14 +1271,14 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	       S3C64XX_SPI_INT_TX_OVERRUN_EN | S3C64XX_SPI_INT_TX_UNDERRUN_EN,
 	       sdd->regs + S3C64XX_SPI_INT_EN);
 
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = devm_spi_register_controller(&pdev->dev, host);
 	if (ret != 0) {
-		dev_err(&pdev->dev, "cannot register SPI master: %d\n", ret);
+		dev_err(&pdev->dev, "cannot register SPI host: %d\n", ret);
 		goto err_pm_put;
 	}
 
-	dev_dbg(&pdev->dev, "Samsung SoC SPI Driver loaded for Bus SPI-%d with %d Slaves attached\n",
-					sdd->port_id, master->num_chipselect);
+	dev_dbg(&pdev->dev, "Samsung SoC SPI Driver loaded for Bus SPI-%d with %d Targets attached\n",
+					sdd->port_id, host->num_chipselect);
 	dev_dbg(&pdev->dev, "\tIOmem=[%pR]\tFIFO %dbytes\n",
 					mem_res, (FIFO_LVL_MASK(sdd) >> 1) + 1);
 
@@ -1297,8 +1297,8 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 
 static void s3c64xx_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
+	struct spi_controller *host = platform_get_drvdata(pdev);
+	struct s3c64xx_spi_driver_data *sdd = spi_controller_get_devdata(host);
 
 	pm_runtime_get_sync(&pdev->dev);
 
@@ -1317,10 +1317,10 @@ static void s3c64xx_spi_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int s3c64xx_spi_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct s3c64xx_spi_driver_data *sdd = spi_controller_get_devdata(host);
 
-	int ret = spi_master_suspend(master);
+	int ret = spi_controller_suspend(host);
 	if (ret)
 		return ret;
 
@@ -1335,8 +1335,8 @@ static int s3c64xx_spi_suspend(struct device *dev)
 
 static int s3c64xx_spi_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct s3c64xx_spi_driver_data *sdd = spi_controller_get_devdata(host);
 	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
 	int ret;
 
@@ -1347,15 +1347,15 @@ static int s3c64xx_spi_resume(struct device *dev)
 	if (ret < 0)
 		return ret;
 
-	return spi_master_resume(master);
+	return spi_controller_resume(host);
 }
 #endif /* CONFIG_PM_SLEEP */
 
 #ifdef CONFIG_PM
 static int s3c64xx_spi_runtime_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct s3c64xx_spi_driver_data *sdd = spi_controller_get_devdata(host);
 
 	clk_disable_unprepare(sdd->clk);
 	clk_disable_unprepare(sdd->src_clk);
@@ -1366,8 +1366,8 @@ static int s3c64xx_spi_runtime_suspend(struct device *dev)
 
 static int s3c64xx_spi_runtime_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct s3c64xx_spi_driver_data *sdd = spi_controller_get_devdata(host);
 	int ret;
 
 	if (sdd->port_conf->clk_ioclk) {
-- 
2.25.1

