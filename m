Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E59478377B
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 03:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjHVBiy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Aug 2023 21:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjHVBir (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Aug 2023 21:38:47 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BF1186
        for <linux-spi@vger.kernel.org>; Mon, 21 Aug 2023 18:38:44 -0700 (PDT)
Received: from dggpemm100011.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RVBlK1ZD3zVk77;
        Tue, 22 Aug 2023 09:36:29 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100011.china.huawei.com (7.185.36.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 22 Aug 2023 09:38:43 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 09:38:42 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 15/24] spi: spi-ti-qspi: switch to use modern name
Date:   Tue, 22 Aug 2023 09:35:02 +0800
Message-ID: <20230822013511.4161475-16-yangyingliang@huawei.com>
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

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-ti-qspi.c | 86 +++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 4c81516b67db..780f04b6a32f 100644
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
 
@@ -912,7 +912,7 @@ static int ti_qspi_remove(struct platform_device *pdev)
 	struct ti_qspi *qspi = platform_get_drvdata(pdev);
 	int rc;
 
-	rc = spi_master_suspend(qspi->master);
+	rc = spi_controller_suspend(qspi->host);
 	if (rc)
 		return rc;
 
-- 
2.25.1

