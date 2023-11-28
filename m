Return-Path: <linux-spi+bounces-64-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AC87FB5B1
	for <lists+linux-spi@lfdr.de>; Tue, 28 Nov 2023 10:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E31FAB217E7
	for <lists+linux-spi@lfdr.de>; Tue, 28 Nov 2023 09:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C60349F72;
	Tue, 28 Nov 2023 09:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F9BD53
	for <linux-spi@vger.kernel.org>; Tue, 28 Nov 2023 01:26:26 -0800 (PST)
Received: from dggpemm500004.china.huawei.com (unknown [172.30.72.53])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SfcS84RJKz1P8vG;
	Tue, 28 Nov 2023 17:22:48 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 28 Nov 2023 17:26:25 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 Nov
 2023 17:26:24 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <linux-spi@vger.kernel.org>
CC: <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
	<yangyingliang@huawei.com>
Subject: [PATCH -next 15/26] spi: spi-ti-qspi: switch to use modern name
Date: Tue, 28 Nov 2023 17:30:20 +0800
Message-ID: <20231128093031.3707034-16-yangyingliang@huawei.com>
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

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-ti-qspi.c | 88 +++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index fdc092a05284..d9ce878389da 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -40,7 +40,7 @@ struct ti_qspi {
 	/* list synchronization */
 	struct mutex            list_lock;
 
-	struct spi_master	*master;
+	struct spi_controller	*host;
 	void __iomem            *base;
 	void __iomem            *mmap_base;
 	size_t			mmap_size;
@@ -137,20 +137,20 @@ static inline void ti_qspi_write(struct ti_qspi *qspi,
 
 static int ti_qspi_setup(struct spi_device *spi)
 {
-	struct ti_qspi	*qspi = spi_master_get_devdata(spi->master);
+	struct ti_qspi	*qspi = spi_controller_get_devdata(spi->controller);
 	int ret;
 
-	if (spi->master->busy) {
-		dev_dbg(qspi->dev, "master busy doing other transfers\n");
+	if (spi->controller->busy) {
+		dev_dbg(qspi->dev, "host busy doing other transfers\n");
 		return -EBUSY;
 	}
 
-	if (!qspi->master->max_speed_hz) {
+	if (!qspi->host->max_speed_hz) {
 		dev_err(qspi->dev, "spi max frequency not defined\n");
 		return -EINVAL;
 	}
 
-	spi->max_speed_hz = min(spi->max_speed_hz, qspi->master->max_speed_hz);
+	spi->max_speed_hz = min(spi->max_speed_hz, qspi->host->max_speed_hz);
 
 	ret = pm_runtime_resume_and_get(qspi->dev);
 	if (ret < 0) {
@@ -526,7 +526,7 @@ static int ti_qspi_dma_xfer_sg(struct ti_qspi *qspi, struct sg_table rx_sg,
 
 static void ti_qspi_enable_memory_map(struct spi_device *spi)
 {
-	struct ti_qspi  *qspi = spi_master_get_devdata(spi->master);
+	struct ti_qspi  *qspi = spi_controller_get_devdata(spi->controller);
 
 	ti_qspi_write(qspi, MM_SWITCH, QSPI_SPI_SWITCH_REG);
 	if (qspi->ctrl_base) {
@@ -540,7 +540,7 @@ static void ti_qspi_enable_memory_map(struct spi_device *spi)
 
 static void ti_qspi_disable_memory_map(struct spi_device *spi)
 {
-	struct ti_qspi  *qspi = spi_master_get_devdata(spi->master);
+	struct ti_qspi  *qspi = spi_controller_get_devdata(spi->controller);
 
 	ti_qspi_write(qspi, 0, QSPI_SPI_SWITCH_REG);
 	if (qspi->ctrl_base)
@@ -554,7 +554,7 @@ static void ti_qspi_setup_mmap_read(struct spi_device *spi, u8 opcode,
 				    u8 data_nbits, u8 addr_width,
 				    u8 dummy_bytes)
 {
-	struct ti_qspi  *qspi = spi_master_get_devdata(spi->master);
+	struct ti_qspi  *qspi = spi_controller_get_devdata(spi->controller);
 	u32 memval = opcode;
 
 	switch (data_nbits) {
@@ -576,7 +576,7 @@ static void ti_qspi_setup_mmap_read(struct spi_device *spi, u8 opcode,
 
 static int ti_qspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
-	struct ti_qspi *qspi = spi_controller_get_devdata(mem->spi->master);
+	struct ti_qspi *qspi = spi_controller_get_devdata(mem->spi->controller);
 	size_t max_len;
 
 	if (op->data.dir == SPI_MEM_DATA_IN) {
@@ -606,7 +606,7 @@ static int ti_qspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 static int ti_qspi_exec_mem_op(struct spi_mem *mem,
 			       const struct spi_mem_op *op)
 {
-	struct ti_qspi *qspi = spi_master_get_devdata(mem->spi->master);
+	struct ti_qspi *qspi = spi_controller_get_devdata(mem->spi->controller);
 	u32 from = 0;
 	int ret = 0;
 
@@ -633,10 +633,10 @@ static int ti_qspi_exec_mem_op(struct spi_mem *mem,
 		struct sg_table sgt;
 
 		if (virt_addr_valid(op->data.buf.in) &&
-		    !spi_controller_dma_map_mem_op_data(mem->spi->master, op,
+		    !spi_controller_dma_map_mem_op_data(mem->spi->controller, op,
 							&sgt)) {
 			ret = ti_qspi_dma_xfer_sg(qspi, sgt, from);
-			spi_controller_dma_unmap_mem_op_data(mem->spi->master,
+			spi_controller_dma_unmap_mem_op_data(mem->spi->controller,
 							     op, &sgt);
 		} else {
 			ret = ti_qspi_dma_bounce_buffer(qspi, from,
@@ -658,10 +658,10 @@ static const struct spi_controller_mem_ops ti_qspi_mem_ops = {
 	.adjust_op_size = ti_qspi_adjust_op_size,
 };
 
-static int ti_qspi_start_transfer_one(struct spi_master *master,
+static int ti_qspi_start_transfer_one(struct spi_controller *host,
 		struct spi_message *m)
 {
-	struct ti_qspi *qspi = spi_master_get_devdata(master);
+	struct ti_qspi *qspi = spi_controller_get_devdata(host);
 	struct spi_device *spi = m->spi;
 	struct spi_transfer *t;
 	int status = 0, ret;
@@ -720,7 +720,7 @@ static int ti_qspi_start_transfer_one(struct spi_master *master,
 
 	ti_qspi_write(qspi, qspi->cmd | QSPI_INVAL, QSPI_SPI_CMD_REG);
 	m->status = status;
-	spi_finalize_current_message(master);
+	spi_finalize_current_message(host);
 
 	return status;
 }
@@ -756,33 +756,33 @@ MODULE_DEVICE_TABLE(of, ti_qspi_match);
 static int ti_qspi_probe(struct platform_device *pdev)
 {
 	struct  ti_qspi *qspi;
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct resource         *r, *res_mmap;
 	struct device_node *np = pdev->dev.of_node;
 	u32 max_freq;
 	int ret = 0, num_cs, irq;
 	dma_cap_mask_t mask;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*qspi));
-	if (!master)
+	host = spi_alloc_host(&pdev->dev, sizeof(*qspi));
+	if (!host)
 		return -ENOMEM;
 
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD;
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD;
 
-	master->flags = SPI_CONTROLLER_HALF_DUPLEX;
-	master->setup = ti_qspi_setup;
-	master->auto_runtime_pm = true;
-	master->transfer_one_message = ti_qspi_start_transfer_one;
-	master->dev.of_node = pdev->dev.of_node;
-	master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(16) |
-				     SPI_BPW_MASK(8);
-	master->mem_ops = &ti_qspi_mem_ops;
+	host->flags = SPI_CONTROLLER_HALF_DUPLEX;
+	host->setup = ti_qspi_setup;
+	host->auto_runtime_pm = true;
+	host->transfer_one_message = ti_qspi_start_transfer_one;
+	host->dev.of_node = pdev->dev.of_node;
+	host->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(16) |
+				   SPI_BPW_MASK(8);
+	host->mem_ops = &ti_qspi_mem_ops;
 
 	if (!of_property_read_u32(np, "num-cs", &num_cs))
-		master->num_chipselect = num_cs;
+		host->num_chipselect = num_cs;
 
-	qspi = spi_master_get_devdata(master);
-	qspi->master = master;
+	qspi = spi_controller_get_devdata(host);
+	qspi->host = host;
 	qspi->dev = &pdev->dev;
 	platform_set_drvdata(pdev, qspi);
 
@@ -792,7 +792,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 		if (r == NULL) {
 			dev_err(&pdev->dev, "missing platform data\n");
 			ret = -ENODEV;
-			goto free_master;
+			goto free_host;
 		}
 	}
 
@@ -812,7 +812,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = irq;
-		goto free_master;
+		goto free_host;
 	}
 
 	mutex_init(&qspi->list_lock);
@@ -820,7 +820,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	qspi->base = devm_ioremap_resource(&pdev->dev, r);
 	if (IS_ERR(qspi->base)) {
 		ret = PTR_ERR(qspi->base);
-		goto free_master;
+		goto free_host;
 	}
 
 
@@ -830,7 +830,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 						"syscon-chipselects");
 		if (IS_ERR(qspi->ctrl_base)) {
 			ret = PTR_ERR(qspi->ctrl_base);
-			goto free_master;
+			goto free_host;
 		}
 		ret = of_property_read_u32_index(np,
 						 "syscon-chipselects",
@@ -838,7 +838,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(&pdev->dev,
 				"couldn't get ctrl_mod reg index\n");
-			goto free_master;
+			goto free_host;
 		}
 	}
 
@@ -853,7 +853,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 
 	if (!of_property_read_u32(np, "spi-max-frequency", &max_freq))
-		master->max_speed_hz = max_freq;
+		host->max_speed_hz = max_freq;
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_MEMCPY, mask);
@@ -876,7 +876,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 		dma_release_channel(qspi->rx_chan);
 		goto no_dma;
 	}
-	master->dma_rx = qspi->rx_chan;
+	host->dma_rx = qspi->rx_chan;
 	init_completion(&qspi->transfer_complete);
 	if (res_mmap)
 		qspi->mmap_phys_base = (dma_addr_t)res_mmap->start;
@@ -889,21 +889,21 @@ static int ti_qspi_probe(struct platform_device *pdev)
 				 "mmap failed with error %ld using PIO mode\n",
 				 PTR_ERR(qspi->mmap_base));
 			qspi->mmap_base = NULL;
-			master->mem_ops = NULL;
+			host->mem_ops = NULL;
 		}
 	}
 	qspi->mmap_enabled = false;
 	qspi->current_cs = -1;
 
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = devm_spi_register_controller(&pdev->dev, host);
 	if (!ret)
 		return 0;
 
 	ti_qspi_dma_cleanup(qspi);
 
 	pm_runtime_disable(&pdev->dev);
-free_master:
-	spi_master_put(master);
+free_host:
+	spi_controller_put(host);
 	return ret;
 }
 
@@ -912,9 +912,9 @@ static void ti_qspi_remove(struct platform_device *pdev)
 	struct ti_qspi *qspi = platform_get_drvdata(pdev);
 	int rc;
 
-	rc = spi_master_suspend(qspi->master);
+	rc = spi_controller_suspend(qspi->host);
 	if (rc) {
-		dev_alert(&pdev->dev, "spi_master_suspend() failed (%pe)\n",
+		dev_alert(&pdev->dev, "spi_controller_suspend() failed (%pe)\n",
 			  ERR_PTR(rc));
 		return;
 	}
-- 
2.25.1


