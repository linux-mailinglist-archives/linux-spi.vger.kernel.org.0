Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4441C517648
	for <lists+linux-spi@lfdr.de>; Mon,  2 May 2022 20:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386800AbiEBSGC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 May 2022 14:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386791AbiEBSGB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 May 2022 14:06:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D10311
        for <linux-spi@vger.kernel.org>; Mon,  2 May 2022 11:02:31 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nlaNR-0004KP-Q2
        for linux-spi@vger.kernel.org; Mon, 02 May 2022 20:02:29 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id AA4B27367C
        for <linux-spi@vger.kernel.org>; Mon,  2 May 2022 18:02:28 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 3888073655;
        Mon,  2 May 2022 18:02:15 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e71b745c;
        Mon, 2 May 2022 17:54:59 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-spi@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Marek Vasut <marex@denx.de>
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Baruch Siach <baruch@tkos.co.il>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v1 6/9] spi: spi-imx: complete conversion from master -> controller
Date:   Mon,  2 May 2022 19:54:54 +0200
Message-Id: <20220502175457.1977983-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502175457.1977983-1-mkl@pengutronix.de>
References: <20220502175457.1977983-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

With patch:
| 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
the SPI "master" was generalized to "controller". This patch completed
the conversion of the spi-imx driver by replacing the remaining
occurrences of master to controller.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-imx.c | 162 +++++++++++++++++++++---------------------
 1 file changed, 81 insertions(+), 81 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 166d6b3da6a4..9defc55707c7 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -226,15 +226,15 @@ static int spi_imx_bytes_per_word(const int bits_per_word)
 		return 4;
 }
 
-static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
+static bool spi_imx_can_dma(struct spi_controller *controller, struct spi_device *spi,
 			 struct spi_transfer *transfer)
 {
-	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
+	struct spi_imx_data *spi_imx = spi_controller_get_devdata(controller);
 
-	if (!use_dma || master->fallback)
+	if (!use_dma || controller->fallback)
 		return false;
 
-	if (!master->dma_rx)
+	if (!controller->dma_rx)
 		return false;
 
 	if (spi_imx->slave_mode)
@@ -1168,12 +1168,12 @@ static irqreturn_t spi_imx_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int spi_imx_dma_configure(struct spi_master *master)
+static int spi_imx_dma_configure(struct spi_controller *controller)
 {
 	int ret;
 	enum dma_slave_buswidth buswidth;
 	struct dma_slave_config rx = {}, tx = {};
-	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
+	struct spi_imx_data *spi_imx = spi_controller_get_devdata(controller);
 
 	switch (spi_imx_bytes_per_word(spi_imx->bits_per_word)) {
 	case 4:
@@ -1193,7 +1193,7 @@ static int spi_imx_dma_configure(struct spi_master *master)
 	tx.dst_addr = spi_imx->base_phys + MXC_CSPITXDATA;
 	tx.dst_addr_width = buswidth;
 	tx.dst_maxburst = spi_imx->wml;
-	ret = dmaengine_slave_config(master->dma_tx, &tx);
+	ret = dmaengine_slave_config(controller->dma_tx, &tx);
 	if (ret) {
 		dev_err(spi_imx->dev, "TX dma configuration failed with %d\n", ret);
 		return ret;
@@ -1203,7 +1203,7 @@ static int spi_imx_dma_configure(struct spi_master *master)
 	rx.src_addr = spi_imx->base_phys + MXC_CSPIRXDATA;
 	rx.src_addr_width = buswidth;
 	rx.src_maxburst = spi_imx->wml;
-	ret = dmaengine_slave_config(master->dma_rx, &rx);
+	ret = dmaengine_slave_config(controller->dma_rx, &rx);
 	if (ret) {
 		dev_err(spi_imx->dev, "RX dma configuration failed with %d\n", ret);
 		return ret;
@@ -1215,7 +1215,7 @@ static int spi_imx_dma_configure(struct spi_master *master)
 static int spi_imx_setupxfer(struct spi_device *spi,
 				 struct spi_transfer *t)
 {
-	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
+	struct spi_imx_data *spi_imx = spi_controller_get_devdata(spi->controller);
 
 	if (!t)
 		return 0;
@@ -1282,50 +1282,50 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 
 static void spi_imx_sdma_exit(struct spi_imx_data *spi_imx)
 {
-	struct spi_master *master = spi_imx->bitbang.master;
+	struct spi_controller *controller = spi_imx->bitbang.master;
 
-	if (master->dma_rx) {
-		dma_release_channel(master->dma_rx);
-		master->dma_rx = NULL;
+	if (controller->dma_rx) {
+		dma_release_channel(controller->dma_rx);
+		controller->dma_rx = NULL;
 	}
 
-	if (master->dma_tx) {
-		dma_release_channel(master->dma_tx);
-		master->dma_tx = NULL;
+	if (controller->dma_tx) {
+		dma_release_channel(controller->dma_tx);
+		controller->dma_tx = NULL;
 	}
 }
 
 static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
-			     struct spi_master *master)
+			     struct spi_controller *controller)
 {
 	int ret;
 
 	spi_imx->wml = spi_imx->devtype_data->fifo_size / 2;
 
 	/* Prepare for TX DMA: */
-	master->dma_tx = dma_request_chan(dev, "tx");
-	if (IS_ERR(master->dma_tx)) {
-		ret = PTR_ERR(master->dma_tx);
+	controller->dma_tx = dma_request_chan(dev, "tx");
+	if (IS_ERR(controller->dma_tx)) {
+		ret = PTR_ERR(controller->dma_tx);
 		dev_dbg(dev, "can't get the TX DMA channel, error %d!\n", ret);
-		master->dma_tx = NULL;
+		controller->dma_tx = NULL;
 		goto err;
 	}
 
 	/* Prepare for RX : */
-	master->dma_rx = dma_request_chan(dev, "rx");
-	if (IS_ERR(master->dma_rx)) {
-		ret = PTR_ERR(master->dma_rx);
+	controller->dma_rx = dma_request_chan(dev, "rx");
+	if (IS_ERR(controller->dma_rx)) {
+		ret = PTR_ERR(controller->dma_rx);
 		dev_dbg(dev, "can't get the RX DMA channel, error %d\n", ret);
-		master->dma_rx = NULL;
+		controller->dma_rx = NULL;
 		goto err;
 	}
 
 	init_completion(&spi_imx->dma_rx_completion);
 	init_completion(&spi_imx->dma_tx_completion);
-	master->can_dma = spi_imx_can_dma;
-	master->max_dma_len = MAX_SDMA_BD_BYTES;
-	spi_imx->bitbang.master->flags = SPI_MASTER_MUST_RX |
-					 SPI_MASTER_MUST_TX;
+	controller->can_dma = spi_imx_can_dma;
+	controller->max_dma_len = MAX_SDMA_BD_BYTES;
+	spi_imx->bitbang.master->flags = SPI_CONTROLLER_MUST_RX |
+					 SPI_CONTROLLER_MUST_TX;
 
 	return 0;
 err:
@@ -1367,7 +1367,7 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	struct dma_async_tx_descriptor *desc_tx, *desc_rx;
 	unsigned long transfer_timeout;
 	unsigned long timeout;
-	struct spi_master *master = spi_imx->bitbang.master;
+	struct spi_controller *controller = spi_imx->bitbang.master;
 	struct sg_table *tx = &transfer->tx_sg, *rx = &transfer->rx_sg;
 	struct scatterlist *last_sg = sg_last(rx->sgl, rx->nents);
 	unsigned int bytes_per_word, i;
@@ -1385,7 +1385,7 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 
 	spi_imx->wml =  i;
 
-	ret = spi_imx_dma_configure(master);
+	ret = spi_imx_dma_configure(controller);
 	if (ret)
 		goto dma_failure_no_start;
 
@@ -1400,7 +1400,7 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	 * The TX DMA setup starts the transfer, so make sure RX is configured
 	 * before TX.
 	 */
-	desc_rx = dmaengine_prep_slave_sg(master->dma_rx,
+	desc_rx = dmaengine_prep_slave_sg(controller->dma_rx,
 				rx->sgl, rx->nents, DMA_DEV_TO_MEM,
 				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc_rx) {
@@ -1412,14 +1412,14 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	desc_rx->callback_param = (void *)spi_imx;
 	dmaengine_submit(desc_rx);
 	reinit_completion(&spi_imx->dma_rx_completion);
-	dma_async_issue_pending(master->dma_rx);
+	dma_async_issue_pending(controller->dma_rx);
 
-	desc_tx = dmaengine_prep_slave_sg(master->dma_tx,
+	desc_tx = dmaengine_prep_slave_sg(controller->dma_tx,
 				tx->sgl, tx->nents, DMA_MEM_TO_DEV,
 				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc_tx) {
-		dmaengine_terminate_all(master->dma_tx);
-		dmaengine_terminate_all(master->dma_rx);
+		dmaengine_terminate_all(controller->dma_tx);
+		dmaengine_terminate_all(controller->dma_rx);
 		return -EINVAL;
 	}
 
@@ -1427,7 +1427,7 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	desc_tx->callback_param = (void *)spi_imx;
 	dmaengine_submit(desc_tx);
 	reinit_completion(&spi_imx->dma_tx_completion);
-	dma_async_issue_pending(master->dma_tx);
+	dma_async_issue_pending(controller->dma_tx);
 
 	transfer_timeout = spi_imx_calculate_timeout(spi_imx, transfer->len);
 
@@ -1436,17 +1436,17 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 						transfer_timeout);
 	if (!timeout) {
 		dev_err(spi_imx->dev, "I/O Error in DMA TX\n");
-		dmaengine_terminate_all(master->dma_tx);
-		dmaengine_terminate_all(master->dma_rx);
+		dmaengine_terminate_all(controller->dma_tx);
+		dmaengine_terminate_all(controller->dma_rx);
 		return -ETIMEDOUT;
 	}
 
 	timeout = wait_for_completion_timeout(&spi_imx->dma_rx_completion,
 					      transfer_timeout);
 	if (!timeout) {
-		dev_err(&master->dev, "I/O Error in DMA RX\n");
+		dev_err(&controller->dev, "I/O Error in DMA RX\n");
 		spi_imx->devtype_data->reset(spi_imx);
-		dmaengine_terminate_all(master->dma_rx);
+		dmaengine_terminate_all(controller->dma_rx);
 		return -ETIMEDOUT;
 	}
 
@@ -1460,7 +1460,7 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 static int spi_imx_pio_transfer(struct spi_device *spi,
 				struct spi_transfer *transfer)
 {
-	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
+	struct spi_imx_data *spi_imx = spi_controller_get_devdata(spi->controller);
 	unsigned long transfer_timeout;
 	unsigned long timeout;
 
@@ -1492,7 +1492,7 @@ static int spi_imx_pio_transfer(struct spi_device *spi,
 static int spi_imx_pio_transfer_slave(struct spi_device *spi,
 				      struct spi_transfer *transfer)
 {
-	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
+	struct spi_imx_data *spi_imx = spi_controller_get_devdata(spi->controller);
 	int ret = transfer->len;
 
 	if (is_imx53_ecspi(spi_imx) &&
@@ -1536,7 +1536,7 @@ static int spi_imx_pio_transfer_slave(struct spi_device *spi,
 static int spi_imx_transfer(struct spi_device *spi,
 				struct spi_transfer *transfer)
 {
-	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
+	struct spi_imx_data *spi_imx = spi_controller_get_devdata(spi->controller);
 
 	transfer->effective_speed_hz = spi_imx->spi_bus_clk;
 
@@ -1566,9 +1566,9 @@ static void spi_imx_cleanup(struct spi_device *spi)
 }
 
 static int
-spi_imx_prepare_message(struct spi_master *master, struct spi_message *msg)
+spi_imx_prepare_message(struct spi_controller *controller, struct spi_message *msg)
 {
-	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
+	struct spi_imx_data *spi_imx = spi_controller_get_devdata(controller);
 	int ret;
 
 	ret = pm_runtime_resume_and_get(spi_imx->dev);
@@ -1587,18 +1587,18 @@ spi_imx_prepare_message(struct spi_master *master, struct spi_message *msg)
 }
 
 static int
-spi_imx_unprepare_message(struct spi_master *master, struct spi_message *msg)
+spi_imx_unprepare_message(struct spi_controller *controller, struct spi_message *msg)
 {
-	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
+	struct spi_imx_data *spi_imx = spi_controller_get_devdata(controller);
 
 	pm_runtime_mark_last_busy(spi_imx->dev);
 	pm_runtime_put_autosuspend(spi_imx->dev);
 	return 0;
 }
 
-static int spi_imx_slave_abort(struct spi_master *master)
+static int spi_imx_slave_abort(struct spi_controller *controller)
 {
-	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
+	struct spi_imx_data *spi_imx = spi_controller_get_devdata(controller);
 
 	spi_imx->slave_aborted = true;
 	complete(&spi_imx->xfer_done);
@@ -1609,7 +1609,7 @@ static int spi_imx_slave_abort(struct spi_master *master)
 static int spi_imx_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct spi_master *master;
+	struct spi_controller *controller;
 	struct spi_imx_data *spi_imx;
 	struct resource *res;
 	int ret, irq, spi_drctl;
@@ -1621,12 +1621,12 @@ static int spi_imx_probe(struct platform_device *pdev)
 	slave_mode = devtype_data->has_slavemode &&
 			of_property_read_bool(np, "spi-slave");
 	if (slave_mode)
-		master = spi_alloc_slave(&pdev->dev,
-					 sizeof(struct spi_imx_data));
+		controller = spi_alloc_slave(&pdev->dev,
+					     sizeof(struct spi_imx_data));
 	else
-		master = spi_alloc_master(&pdev->dev,
-					  sizeof(struct spi_imx_data));
-	if (!master)
+		controller = spi_alloc_master(&pdev->dev,
+					      sizeof(struct spi_imx_data));
+	if (!controller)
 		return -ENOMEM;
 
 	ret = of_property_read_u32(np, "fsl,spi-rdy-drctl", &spi_drctl);
@@ -1635,14 +1635,14 @@ static int spi_imx_probe(struct platform_device *pdev)
 		spi_drctl = 0;
 	}
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, controller);
 
-	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
-	master->bus_num = np ? -1 : pdev->id;
-	master->use_gpio_descriptors = true;
+	controller->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
+	controller->bus_num = np ? -1 : pdev->id;
+	controller->use_gpio_descriptors = true;
 
-	spi_imx = spi_master_get_devdata(master);
-	spi_imx->bitbang.master = master;
+	spi_imx = spi_controller_get_devdata(controller);
+	spi_imx->bitbang.master = controller;
 	spi_imx->dev = &pdev->dev;
 	spi_imx->slave_mode = slave_mode;
 
@@ -1655,9 +1655,9 @@ static int spi_imx_probe(struct platform_device *pdev)
 	 * board files have <= 3 chip selects.
 	 */
 	if (!device_property_read_u32(&pdev->dev, "num-cs", &val))
-		master->num_chipselect = val;
+		controller->num_chipselect = val;
 	else
-		master->num_chipselect = 3;
+		controller->num_chipselect = 3;
 
 	spi_imx->bitbang.setup_transfer = spi_imx_setupxfer;
 	spi_imx->bitbang.txrx_bufs = spi_imx_transfer;
@@ -1691,38 +1691,38 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(spi_imx->base)) {
 		ret = PTR_ERR(spi_imx->base);
-		goto out_master_put;
+		goto out_controller_put;
 	}
 	spi_imx->base_phys = res->start;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = irq;
-		goto out_master_put;
+		goto out_controller_put;
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq, spi_imx_isr, 0,
 			       dev_name(&pdev->dev), spi_imx);
 	if (ret) {
 		dev_err(&pdev->dev, "can't get irq%d: %d\n", irq, ret);
-		goto out_master_put;
+		goto out_controller_put;
 	}
 
 	spi_imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(spi_imx->clk_ipg)) {
 		ret = PTR_ERR(spi_imx->clk_ipg);
-		goto out_master_put;
+		goto out_controller_put;
 	}
 
 	spi_imx->clk_per = devm_clk_get(&pdev->dev, "per");
 	if (IS_ERR(spi_imx->clk_per)) {
 		ret = PTR_ERR(spi_imx->clk_per);
-		goto out_master_put;
+		goto out_controller_put;
 	}
 
 	ret = clk_prepare_enable(spi_imx->clk_per);
 	if (ret)
-		goto out_master_put;
+		goto out_controller_put;
 
 	ret = clk_prepare_enable(spi_imx->clk_ipg);
 	if (ret)
@@ -1740,7 +1740,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	 * if validated on other chips.
 	 */
 	if (spi_imx->devtype_data->has_dmamode) {
-		ret = spi_imx_sdma_init(&pdev->dev, spi_imx, master);
+		ret = spi_imx_sdma_init(&pdev->dev, spi_imx, controller);
 		if (ret == -EPROBE_DEFER)
 			goto out_runtime_pm_put;
 
@@ -1753,7 +1753,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 
 	spi_imx->devtype_data->intctrl(spi_imx, 0);
 
-	master->dev.of_node = pdev->dev.of_node;
+	controller->dev.of_node = pdev->dev.of_node;
 	ret = spi_bitbang_start(&spi_imx->bitbang);
 	if (ret) {
 		dev_err_probe(&pdev->dev, ret, "bitbang start failed\n");
@@ -1776,16 +1776,16 @@ static int spi_imx_probe(struct platform_device *pdev)
 	clk_disable_unprepare(spi_imx->clk_ipg);
 out_put_per:
 	clk_disable_unprepare(spi_imx->clk_per);
-out_master_put:
-	spi_master_put(master);
+out_controller_put:
+	spi_controller_put(controller);
 
 	return ret;
 }
 
 static int spi_imx_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
+	struct spi_controller *controller = platform_get_drvdata(pdev);
+	struct spi_imx_data *spi_imx = spi_controller_get_devdata(controller);
 	int ret;
 
 	spi_bitbang_stop(&spi_imx->bitbang);
@@ -1803,18 +1803,18 @@ static int spi_imx_remove(struct platform_device *pdev)
 	pm_runtime_disable(spi_imx->dev);
 
 	spi_imx_sdma_exit(spi_imx);
-	spi_master_put(master);
+	spi_controller_put(controller);
 
 	return 0;
 }
 
 static int __maybe_unused spi_imx_runtime_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
+	struct spi_controller *controller = dev_get_drvdata(dev);
 	struct spi_imx_data *spi_imx;
 	int ret;
 
-	spi_imx = spi_master_get_devdata(master);
+	spi_imx = spi_controller_get_devdata(controller);
 
 	ret = clk_prepare_enable(spi_imx->clk_per);
 	if (ret)
@@ -1831,10 +1831,10 @@ static int __maybe_unused spi_imx_runtime_resume(struct device *dev)
 
 static int __maybe_unused spi_imx_runtime_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
+	struct spi_controller *controller = dev_get_drvdata(dev);
 	struct spi_imx_data *spi_imx;
 
-	spi_imx = spi_master_get_devdata(master);
+	spi_imx = spi_controller_get_devdata(controller);
 
 	clk_disable_unprepare(spi_imx->clk_per);
 	clk_disable_unprepare(spi_imx->clk_ipg);
-- 
2.35.1


