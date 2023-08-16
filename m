Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D05177DD91
	for <lists+linux-spi@lfdr.de>; Wed, 16 Aug 2023 11:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243304AbjHPJni (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Aug 2023 05:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243435AbjHPJn0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Aug 2023 05:43:26 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9128C26AB
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 02:43:24 -0700 (PDT)
Received: from dggpemm100006.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RQjlj74w6ztS0v;
        Wed, 16 Aug 2023 17:39:45 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100006.china.huawei.com (7.185.36.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 16 Aug 2023 17:43:22 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 16 Aug
 2023 17:43:22 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 04/24] spi: pic32: switch to use modern name
Date:   Wed, 16 Aug 2023 17:39:53 +0800
Message-ID: <20230816094013.1275068-5-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816094013.1275068-1-yangyingliang@huawei.com>
References: <20230816094013.1275068-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-pic32.c | 158 ++++++++++++++++++++--------------------
 1 file changed, 79 insertions(+), 79 deletions(-)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index e9b4c9cb97fb..eb76474edd2a 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -55,7 +55,7 @@ struct pic32_spi_regs {
 #define  TX_FIFO_HALF_EMPTY	2 /* empty by half or more */
 #define  TX_FIFO_NOT_FULL	3 /* atleast one empty */
 
-#define CTRL_MSTEN	BIT(5) /* enable master mode */
+#define CTRL_HSTEN	BIT(5) /* enable host mode */
 #define CTRL_CKP	BIT(6) /* active low */
 #define CTRL_CKE	BIT(8) /* Tx on falling edge */
 #define CTRL_SMP	BIT(9) /* Rx at middle or end of tx */
@@ -100,7 +100,7 @@ struct pic32_spi {
 	int			tx_irq;
 	u32			fifo_n_byte; /* FIFO depth in bytes */
 	struct clk		*clk;
-	struct spi_master	*master;
+	struct spi_controller	*host;
 	/* Current controller setting */
 	u32			speed_hz; /* spi-clk rate */
 	u32			mode;
@@ -224,9 +224,9 @@ static void pic32_err_stop(struct pic32_spi *pic32s, const char *msg)
 	disable_irq_nosync(pic32s->tx_irq);
 
 	/* Show err message and abort xfer with err */
-	dev_err(&pic32s->master->dev, "%s\n", msg);
-	if (pic32s->master->cur_msg)
-		pic32s->master->cur_msg->status = -EIO;
+	dev_err(&pic32s->host->dev, "%s\n", msg);
+	if (pic32s->host->cur_msg)
+		pic32s->host->cur_msg->status = -EIO;
 	complete(&pic32s->xfer_done);
 }
 
@@ -250,7 +250,7 @@ static irqreturn_t pic32_spi_fault_irq(int irq, void *dev_id)
 		return IRQ_HANDLED;
 	}
 
-	if (!pic32s->master->cur_msg) {
+	if (!pic32s->host->cur_msg) {
 		pic32_err_stop(pic32s, "err_irq: no mesg");
 		return IRQ_NONE;
 	}
@@ -300,16 +300,16 @@ static void pic32_spi_dma_rx_notify(void *data)
 static int pic32_spi_dma_transfer(struct pic32_spi *pic32s,
 				  struct spi_transfer *xfer)
 {
-	struct spi_master *master = pic32s->master;
+	struct spi_controller *host = pic32s->host;
 	struct dma_async_tx_descriptor *desc_rx;
 	struct dma_async_tx_descriptor *desc_tx;
 	dma_cookie_t cookie;
 	int ret;
 
-	if (!master->dma_rx || !master->dma_tx)
+	if (!host->dma_rx || !host->dma_tx)
 		return -ENODEV;
 
-	desc_rx = dmaengine_prep_slave_sg(master->dma_rx,
+	desc_rx = dmaengine_prep_slave_sg(host->dma_rx,
 					  xfer->rx_sg.sgl,
 					  xfer->rx_sg.nents,
 					  DMA_DEV_TO_MEM,
@@ -319,7 +319,7 @@ static int pic32_spi_dma_transfer(struct pic32_spi *pic32s,
 		goto err_dma;
 	}
 
-	desc_tx = dmaengine_prep_slave_sg(master->dma_tx,
+	desc_tx = dmaengine_prep_slave_sg(host->dma_tx,
 					  xfer->tx_sg.sgl,
 					  xfer->tx_sg.nents,
 					  DMA_MEM_TO_DEV,
@@ -343,13 +343,13 @@ static int pic32_spi_dma_transfer(struct pic32_spi *pic32s,
 	if (ret)
 		goto err_dma_tx;
 
-	dma_async_issue_pending(master->dma_rx);
-	dma_async_issue_pending(master->dma_tx);
+	dma_async_issue_pending(host->dma_rx);
+	dma_async_issue_pending(host->dma_tx);
 
 	return 0;
 
 err_dma_tx:
-	dmaengine_terminate_all(master->dma_rx);
+	dmaengine_terminate_all(host->dma_rx);
 err_dma:
 	return ret;
 }
@@ -357,7 +357,7 @@ static int pic32_spi_dma_transfer(struct pic32_spi *pic32s,
 static int pic32_spi_dma_config(struct pic32_spi *pic32s, u32 dma_width)
 {
 	int buf_offset = offsetof(struct pic32_spi_regs, buf);
-	struct spi_master *master = pic32s->master;
+	struct spi_controller *host = pic32s->host;
 	struct dma_slave_config cfg;
 	int ret;
 
@@ -371,16 +371,16 @@ static int pic32_spi_dma_config(struct pic32_spi *pic32s, u32 dma_width)
 	cfg.dst_addr_width = dma_width;
 	/* tx channel */
 	cfg.direction = DMA_MEM_TO_DEV;
-	ret = dmaengine_slave_config(master->dma_tx, &cfg);
+	ret = dmaengine_slave_config(host->dma_tx, &cfg);
 	if (ret) {
-		dev_err(&master->dev, "tx channel setup failed\n");
+		dev_err(&host->dev, "tx channel setup failed\n");
 		return ret;
 	}
 	/* rx channel */
 	cfg.direction = DMA_DEV_TO_MEM;
-	ret = dmaengine_slave_config(master->dma_rx, &cfg);
+	ret = dmaengine_slave_config(host->dma_rx, &cfg);
 	if (ret)
-		dev_err(&master->dev, "rx channel setup failed\n");
+		dev_err(&host->dev, "rx channel setup failed\n");
 
 	return ret;
 }
@@ -430,19 +430,19 @@ static int pic32_spi_set_word_size(struct pic32_spi *pic32s, u8 bits_per_word)
 	return 0;
 }
 
-static int pic32_spi_prepare_hardware(struct spi_master *master)
+static int pic32_spi_prepare_hardware(struct spi_controller *host)
 {
-	struct pic32_spi *pic32s = spi_master_get_devdata(master);
+	struct pic32_spi *pic32s = spi_controller_get_devdata(host);
 
 	pic32_spi_enable(pic32s);
 
 	return 0;
 }
 
-static int pic32_spi_prepare_message(struct spi_master *master,
+static int pic32_spi_prepare_message(struct spi_controller *host,
 				     struct spi_message *msg)
 {
-	struct pic32_spi *pic32s = spi_master_get_devdata(master);
+	struct pic32_spi *pic32s = spi_controller_get_devdata(host);
 	struct spi_device *spi = msg->spi;
 	u32 val;
 
@@ -481,18 +481,18 @@ static int pic32_spi_prepare_message(struct spi_master *master,
 	return 0;
 }
 
-static bool pic32_spi_can_dma(struct spi_master *master,
+static bool pic32_spi_can_dma(struct spi_controller *host,
 			      struct spi_device *spi,
 			      struct spi_transfer *xfer)
 {
-	struct pic32_spi *pic32s = spi_master_get_devdata(master);
+	struct pic32_spi *pic32s = spi_controller_get_devdata(host);
 
 	/* skip using DMA on small size transfer to avoid overhead.*/
 	return (xfer->len >= PIC32_DMA_LEN_MIN) &&
 	       test_bit(PIC32F_DMA_PREP, &pic32s->flags);
 }
 
-static int pic32_spi_one_transfer(struct spi_master *master,
+static int pic32_spi_one_transfer(struct spi_controller *host,
 				  struct spi_device *spi,
 				  struct spi_transfer *transfer)
 {
@@ -501,7 +501,7 @@ static int pic32_spi_one_transfer(struct spi_master *master,
 	unsigned long timeout;
 	int ret;
 
-	pic32s = spi_master_get_devdata(master);
+	pic32s = spi_controller_get_devdata(host);
 
 	/* handle transfer specific word size change */
 	if (transfer->bits_per_word &&
@@ -549,8 +549,8 @@ static int pic32_spi_one_transfer(struct spi_master *master,
 	if (timeout == 0) {
 		dev_err(&spi->dev, "wait error/timedout\n");
 		if (dma_issued) {
-			dmaengine_terminate_all(master->dma_rx);
-			dmaengine_terminate_all(master->dma_tx);
+			dmaengine_terminate_all(host->dma_rx);
+			dmaengine_terminate_all(host->dma_tx);
 		}
 		ret = -ETIMEDOUT;
 	} else {
@@ -560,16 +560,16 @@ static int pic32_spi_one_transfer(struct spi_master *master,
 	return ret;
 }
 
-static int pic32_spi_unprepare_message(struct spi_master *master,
+static int pic32_spi_unprepare_message(struct spi_controller *host,
 				       struct spi_message *msg)
 {
 	/* nothing to do */
 	return 0;
 }
 
-static int pic32_spi_unprepare_hardware(struct spi_master *master)
+static int pic32_spi_unprepare_hardware(struct spi_controller *host)
 {
-	struct pic32_spi *pic32s = spi_master_get_devdata(master);
+	struct pic32_spi *pic32s = spi_controller_get_devdata(host);
 
 	pic32_spi_disable(pic32s);
 
@@ -605,28 +605,28 @@ static void pic32_spi_cleanup(struct spi_device *spi)
 
 static int pic32_spi_dma_prep(struct pic32_spi *pic32s, struct device *dev)
 {
-	struct spi_master *master = pic32s->master;
+	struct spi_controller *host = pic32s->host;
 	int ret = 0;
 
-	master->dma_rx = dma_request_chan(dev, "spi-rx");
-	if (IS_ERR(master->dma_rx)) {
-		if (PTR_ERR(master->dma_rx) == -EPROBE_DEFER)
+	host->dma_rx = dma_request_chan(dev, "spi-rx");
+	if (IS_ERR(host->dma_rx)) {
+		if (PTR_ERR(host->dma_rx) == -EPROBE_DEFER)
 			ret = -EPROBE_DEFER;
 		else
 			dev_warn(dev, "RX channel not found.\n");
 
-		master->dma_rx = NULL;
+		host->dma_rx = NULL;
 		goto out_err;
 	}
 
-	master->dma_tx = dma_request_chan(dev, "spi-tx");
-	if (IS_ERR(master->dma_tx)) {
-		if (PTR_ERR(master->dma_tx) == -EPROBE_DEFER)
+	host->dma_tx = dma_request_chan(dev, "spi-tx");
+	if (IS_ERR(host->dma_tx)) {
+		if (PTR_ERR(host->dma_tx) == -EPROBE_DEFER)
 			ret = -EPROBE_DEFER;
 		else
 			dev_warn(dev, "TX channel not found.\n");
 
-		master->dma_tx = NULL;
+		host->dma_tx = NULL;
 		goto out_err;
 	}
 
@@ -639,14 +639,14 @@ static int pic32_spi_dma_prep(struct pic32_spi *pic32s, struct device *dev)
 	return 0;
 
 out_err:
-	if (master->dma_rx) {
-		dma_release_channel(master->dma_rx);
-		master->dma_rx = NULL;
+	if (host->dma_rx) {
+		dma_release_channel(host->dma_rx);
+		host->dma_rx = NULL;
 	}
 
-	if (master->dma_tx) {
-		dma_release_channel(master->dma_tx);
-		master->dma_tx = NULL;
+	if (host->dma_tx) {
+		dma_release_channel(host->dma_tx);
+		host->dma_tx = NULL;
 	}
 
 	return ret;
@@ -658,11 +658,11 @@ static void pic32_spi_dma_unprep(struct pic32_spi *pic32s)
 		return;
 
 	clear_bit(PIC32F_DMA_PREP, &pic32s->flags);
-	if (pic32s->master->dma_rx)
-		dma_release_channel(pic32s->master->dma_rx);
+	if (pic32s->host->dma_rx)
+		dma_release_channel(pic32s->host->dma_rx);
 
-	if (pic32s->master->dma_tx)
-		dma_release_channel(pic32s->master->dma_tx);
+	if (pic32s->host->dma_tx)
+		dma_release_channel(pic32s->host->dma_tx);
 }
 
 static void pic32_spi_hw_init(struct pic32_spi *pic32s)
@@ -680,8 +680,8 @@ static void pic32_spi_hw_init(struct pic32_spi *pic32s)
 	/* disable framing mode */
 	ctrl &= ~CTRL_FRMEN;
 
-	/* enable master mode while disabled */
-	ctrl |= CTRL_MSTEN;
+	/* enable host mode while disabled */
+	ctrl |= CTRL_HSTEN;
 
 	/* set tx fifo threshold interrupt */
 	ctrl &= ~(0x3 << CTRL_TX_INT_SHIFT);
@@ -752,36 +752,36 @@ static int pic32_spi_hw_probe(struct platform_device *pdev,
 
 static int pic32_spi_probe(struct platform_device *pdev)
 {
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct pic32_spi *pic32s;
 	int ret;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*pic32s));
-	if (!master)
+	host = spi_alloc_host(&pdev->dev, sizeof(*pic32s));
+	if (!host)
 		return -ENOMEM;
 
-	pic32s = spi_master_get_devdata(master);
-	pic32s->master = master;
+	pic32s = spi_controller_get_devdata(host);
+	pic32s->host = host;
 
 	ret = pic32_spi_hw_probe(pdev, pic32s);
 	if (ret)
-		goto err_master;
-
-	master->dev.of_node	= pdev->dev.of_node;
-	master->mode_bits	= SPI_MODE_3 | SPI_MODE_0 | SPI_CS_HIGH;
-	master->num_chipselect	= 1; /* single chip-select */
-	master->max_speed_hz	= clk_get_rate(pic32s->clk);
-	master->setup		= pic32_spi_setup;
-	master->cleanup		= pic32_spi_cleanup;
-	master->flags		= SPI_CONTROLLER_MUST_TX | SPI_CONTROLLER_MUST_RX;
-	master->bits_per_word_mask	= SPI_BPW_MASK(8) | SPI_BPW_MASK(16) |
+		goto err_host;
+
+	host->dev.of_node	= pdev->dev.of_node;
+	host->mode_bits	= SPI_MODE_3 | SPI_MODE_0 | SPI_CS_HIGH;
+	host->num_chipselect	= 1; /* single chip-select */
+	host->max_speed_hz	= clk_get_rate(pic32s->clk);
+	host->setup		= pic32_spi_setup;
+	host->cleanup		= pic32_spi_cleanup;
+	host->flags		= SPI_CONTROLLER_MUST_TX | SPI_CONTROLLER_MUST_RX;
+	host->bits_per_word_mask	= SPI_BPW_MASK(8) | SPI_BPW_MASK(16) |
 					  SPI_BPW_MASK(32);
-	master->transfer_one		= pic32_spi_one_transfer;
-	master->prepare_message		= pic32_spi_prepare_message;
-	master->unprepare_message	= pic32_spi_unprepare_message;
-	master->prepare_transfer_hardware	= pic32_spi_prepare_hardware;
-	master->unprepare_transfer_hardware	= pic32_spi_unprepare_hardware;
-	master->use_gpio_descriptors = true;
+	host->transfer_one		= pic32_spi_one_transfer;
+	host->prepare_message		= pic32_spi_prepare_message;
+	host->unprepare_message	= pic32_spi_unprepare_message;
+	host->prepare_transfer_hardware	= pic32_spi_prepare_hardware;
+	host->unprepare_transfer_hardware	= pic32_spi_unprepare_hardware;
+	host->use_gpio_descriptors = true;
 
 	/* optional DMA support */
 	ret = pic32_spi_dma_prep(pic32s, &pdev->dev);
@@ -789,7 +789,7 @@ static int pic32_spi_probe(struct platform_device *pdev)
 		goto err_bailout;
 
 	if (test_bit(PIC32F_DMA_PREP, &pic32s->flags))
-		master->can_dma	= pic32_spi_can_dma;
+		host->can_dma	= pic32_spi_can_dma;
 
 	init_completion(&pic32s->xfer_done);
 	pic32s->mode = -1;
@@ -824,10 +824,10 @@ static int pic32_spi_probe(struct platform_device *pdev)
 		goto err_bailout;
 	}
 
-	/* register master */
-	ret = devm_spi_register_master(&pdev->dev, master);
+	/* register host */
+	ret = devm_spi_register_controller(&pdev->dev, host);
 	if (ret) {
-		dev_err(&master->dev, "failed registering spi master\n");
+		dev_err(&host->dev, "failed registering spi host\n");
 		goto err_bailout;
 	}
 
@@ -838,8 +838,8 @@ static int pic32_spi_probe(struct platform_device *pdev)
 err_bailout:
 	pic32_spi_dma_unprep(pic32s);
 	clk_disable_unprepare(pic32s->clk);
-err_master:
-	spi_master_put(master);
+err_host:
+	spi_controller_put(host);
 	return ret;
 }
 
-- 
2.25.1

