Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270D2664104
	for <lists+linux-spi@lfdr.de>; Tue, 10 Jan 2023 13:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjAJM7u (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Jan 2023 07:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbjAJM7t (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Jan 2023 07:59:49 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA429517C0
        for <linux-spi@vger.kernel.org>; Tue, 10 Jan 2023 04:59:46 -0800 (PST)
Received: from dggpemm100007.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NrrTB0ptVz16MdK;
        Tue, 10 Jan 2023 20:58:06 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm100007.china.huawei.com
 (7.185.36.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 20:59:39 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 1/3] spi: atmel: switch to use modern name
Date:   Tue, 10 Jan 2023 21:18:03 +0800
Message-ID: <20230110131805.2827248-2-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230110131805.2827248-1-yangyingliang@huawei.com>
References: <20230110131805.2827248-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100007.china.huawei.com (7.185.36.116)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
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
 drivers/spi/spi-atmel.c | 254 ++++++++++++++++++++--------------------
 1 file changed, 127 insertions(+), 127 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index c4f22d50dba5..5c5678f065f3 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -358,7 +358,7 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 		u32 csr;
 
 		/* Make sure clock polarity is correct */
-		for (i = 0; i < spi->master->num_chipselect; i++) {
+		for (i = 0; i < spi->controller->num_chipselect; i++) {
 			csr = spi_readl(as, CSR0 + 4 * i);
 			if ((csr ^ cpol) & SPI_BIT(CPOL))
 				spi_writel(as, CSR0 + 4 * i,
@@ -419,11 +419,11 @@ static inline bool atmel_spi_use_dma(struct atmel_spi *as,
 	return as->use_dma && xfer->len >= DMA_MIN_BYTES;
 }
 
-static bool atmel_spi_can_dma(struct spi_master *master,
+static bool atmel_spi_can_dma(struct spi_controller *host,
 			      struct spi_device *spi,
 			      struct spi_transfer *xfer)
 {
-	struct atmel_spi *as = spi_master_get_devdata(master);
+	struct atmel_spi *as = spi_controller_get_devdata(host);
 
 	if (IS_ENABLED(CONFIG_SOC_SAM_V4_V5))
 		return atmel_spi_use_dma(as, xfer) &&
@@ -435,7 +435,7 @@ static bool atmel_spi_can_dma(struct spi_master *master,
 
 static int atmel_spi_dma_slave_config(struct atmel_spi *as, u8 bits_per_word)
 {
-	struct spi_master *master = platform_get_drvdata(as->pdev);
+	struct spi_controller *host = platform_get_drvdata(as->pdev);
 	struct dma_slave_config	slave_config;
 	int err = 0;
 
@@ -467,21 +467,21 @@ static int atmel_spi_dma_slave_config(struct atmel_spi *as, u8 bits_per_word)
 	 * So we'd rather write only one data at the time. Hence the transmit
 	 * path works the same whether FIFOs are available (and enabled) or not.
 	 */
-	if (dmaengine_slave_config(master->dma_tx, &slave_config)) {
+	if (dmaengine_slave_config(host->dma_tx, &slave_config)) {
 		dev_err(&as->pdev->dev,
 			"failed to configure tx dma channel\n");
 		err = -EINVAL;
 	}
 
 	/*
-	 * This driver configures the spi controller for master mode (MSTR bit
+	 * This driver configures the spi controller for host mode (MSTR bit
 	 * set to '1' in the Mode Register).
 	 * So according to the datasheet, when FIFOs are available (and
 	 * enabled), the Receive FIFO operates in Single Data Mode.
 	 * So the receive path works the same whether FIFOs are available (and
 	 * enabled) or not.
 	 */
-	if (dmaengine_slave_config(master->dma_rx, &slave_config)) {
+	if (dmaengine_slave_config(host->dma_rx, &slave_config)) {
 		dev_err(&as->pdev->dev,
 			"failed to configure rx dma channel\n");
 		err = -EINVAL;
@@ -490,22 +490,22 @@ static int atmel_spi_dma_slave_config(struct atmel_spi *as, u8 bits_per_word)
 	return err;
 }
 
-static int atmel_spi_configure_dma(struct spi_master *master,
+static int atmel_spi_configure_dma(struct spi_controller *host,
 				   struct atmel_spi *as)
 {
 	struct device *dev = &as->pdev->dev;
 	int err;
 
-	master->dma_tx = dma_request_chan(dev, "tx");
-	if (IS_ERR(master->dma_tx)) {
-		err = PTR_ERR(master->dma_tx);
+	host->dma_tx = dma_request_chan(dev, "tx");
+	if (IS_ERR(host->dma_tx)) {
+		err = PTR_ERR(host->dma_tx);
 		dev_dbg(dev, "No TX DMA channel, DMA is disabled\n");
 		goto error_clear;
 	}
 
-	master->dma_rx = dma_request_chan(dev, "rx");
-	if (IS_ERR(master->dma_rx)) {
-		err = PTR_ERR(master->dma_rx);
+	host->dma_rx = dma_request_chan(dev, "rx");
+	if (IS_ERR(host->dma_rx)) {
+		err = PTR_ERR(host->dma_rx);
 		/*
 		 * No reason to check EPROBE_DEFER here since we have already
 		 * requested tx channel.
@@ -520,45 +520,45 @@ static int atmel_spi_configure_dma(struct spi_master *master,
 
 	dev_info(&as->pdev->dev,
 			"Using %s (tx) and %s (rx) for DMA transfers\n",
-			dma_chan_name(master->dma_tx),
-			dma_chan_name(master->dma_rx));
+			dma_chan_name(host->dma_tx),
+			dma_chan_name(host->dma_rx));
 
 	return 0;
 error:
-	if (!IS_ERR(master->dma_rx))
-		dma_release_channel(master->dma_rx);
-	if (!IS_ERR(master->dma_tx))
-		dma_release_channel(master->dma_tx);
+	if (!IS_ERR(host->dma_rx))
+		dma_release_channel(host->dma_rx);
+	if (!IS_ERR(host->dma_tx))
+		dma_release_channel(host->dma_tx);
 error_clear:
-	master->dma_tx = master->dma_rx = NULL;
+	host->dma_tx = host->dma_rx = NULL;
 	return err;
 }
 
-static void atmel_spi_stop_dma(struct spi_master *master)
+static void atmel_spi_stop_dma(struct spi_controller *host)
 {
-	if (master->dma_rx)
-		dmaengine_terminate_all(master->dma_rx);
-	if (master->dma_tx)
-		dmaengine_terminate_all(master->dma_tx);
+	if (host->dma_rx)
+		dmaengine_terminate_all(host->dma_rx);
+	if (host->dma_tx)
+		dmaengine_terminate_all(host->dma_tx);
 }
 
-static void atmel_spi_release_dma(struct spi_master *master)
+static void atmel_spi_release_dma(struct spi_controller *host)
 {
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
 }
 
 /* This function is called by the DMA driver from tasklet context */
 static void dma_callback(void *data)
 {
-	struct spi_master	*master = data;
-	struct atmel_spi	*as = spi_master_get_devdata(master);
+	struct spi_controller	*host = data;
+	struct atmel_spi	*as = spi_controller_get_devdata(host);
 
 	if (is_vmalloc_addr(as->current_transfer->rx_buf) &&
 	    IS_ENABLED(CONFIG_SOC_SAM_V4_V5)) {
@@ -571,13 +571,13 @@ static void dma_callback(void *data)
 /*
  * Next transfer using PIO without FIFO.
  */
-static void atmel_spi_next_xfer_single(struct spi_master *master,
+static void atmel_spi_next_xfer_single(struct spi_controller *host,
 				       struct spi_transfer *xfer)
 {
-	struct atmel_spi	*as = spi_master_get_devdata(master);
+	struct atmel_spi	*as = spi_controller_get_devdata(host);
 	unsigned long xfer_pos = xfer->len - as->current_remaining_bytes;
 
-	dev_vdbg(master->dev.parent, "atmel_spi_next_xfer_pio\n");
+	dev_vdbg(host->dev.parent, "atmel_spi_next_xfer_pio\n");
 
 	/* Make sure data is not remaining in RDR */
 	spi_readl(as, RDR);
@@ -591,7 +591,7 @@ static void atmel_spi_next_xfer_single(struct spi_master *master,
 	else
 		spi_writel(as, TDR, *(u8 *)(xfer->tx_buf + xfer_pos));
 
-	dev_dbg(master->dev.parent,
+	dev_dbg(host->dev.parent,
 		"  start pio xfer %p: len %u tx %p rx %p bitpw %d\n",
 		xfer, xfer->len, xfer->tx_buf, xfer->rx_buf,
 		xfer->bits_per_word);
@@ -603,10 +603,10 @@ static void atmel_spi_next_xfer_single(struct spi_master *master,
 /*
  * Next transfer using PIO with FIFO.
  */
-static void atmel_spi_next_xfer_fifo(struct spi_master *master,
+static void atmel_spi_next_xfer_fifo(struct spi_controller *host,
 				     struct spi_transfer *xfer)
 {
-	struct atmel_spi *as = spi_master_get_devdata(master);
+	struct atmel_spi *as = spi_controller_get_devdata(host);
 	u32 current_remaining_data, num_data;
 	u32 offset = xfer->len - as->current_remaining_bytes;
 	const u16 *words = (const u16 *)((u8 *)xfer->tx_buf + offset);
@@ -614,7 +614,7 @@ static void atmel_spi_next_xfer_fifo(struct spi_master *master,
 	u16 td0, td1;
 	u32 fifomr;
 
-	dev_vdbg(master->dev.parent, "atmel_spi_next_xfer_fifo\n");
+	dev_vdbg(host->dev.parent, "atmel_spi_next_xfer_fifo\n");
 
 	/* Compute the number of data to transfer in the current iteration */
 	current_remaining_data = ((xfer->bits_per_word > 8) ?
@@ -658,7 +658,7 @@ static void atmel_spi_next_xfer_fifo(struct spi_master *master,
 		num_data--;
 	}
 
-	dev_dbg(master->dev.parent,
+	dev_dbg(host->dev.parent,
 		"  start fifo xfer %p: len %u tx %p rx %p bitpw %d\n",
 		xfer, xfer->len, xfer->tx_buf, xfer->rx_buf,
 		xfer->bits_per_word);
@@ -673,32 +673,32 @@ static void atmel_spi_next_xfer_fifo(struct spi_master *master,
 /*
  * Next transfer using PIO.
  */
-static void atmel_spi_next_xfer_pio(struct spi_master *master,
+static void atmel_spi_next_xfer_pio(struct spi_controller *host,
 				    struct spi_transfer *xfer)
 {
-	struct atmel_spi *as = spi_master_get_devdata(master);
+	struct atmel_spi *as = spi_controller_get_devdata(host);
 
 	if (as->fifo_size)
-		atmel_spi_next_xfer_fifo(master, xfer);
+		atmel_spi_next_xfer_fifo(host, xfer);
 	else
-		atmel_spi_next_xfer_single(master, xfer);
+		atmel_spi_next_xfer_single(host, xfer);
 }
 
 /*
  * Submit next transfer for DMA.
  */
-static int atmel_spi_next_xfer_dma_submit(struct spi_master *master,
+static int atmel_spi_next_xfer_dma_submit(struct spi_controller *host,
 				struct spi_transfer *xfer,
 				u32 *plen)
 {
-	struct atmel_spi	*as = spi_master_get_devdata(master);
-	struct dma_chan		*rxchan = master->dma_rx;
-	struct dma_chan		*txchan = master->dma_tx;
+	struct atmel_spi	*as = spi_controller_get_devdata(host);
+	struct dma_chan		*rxchan = host->dma_rx;
+	struct dma_chan		*txchan = host->dma_tx;
 	struct dma_async_tx_descriptor *rxdesc;
 	struct dma_async_tx_descriptor *txdesc;
 	dma_cookie_t		cookie;
 
-	dev_vdbg(master->dev.parent, "atmel_spi_next_xfer_dma_submit\n");
+	dev_vdbg(host->dev.parent, "atmel_spi_next_xfer_dma_submit\n");
 
 	/* Check that the channels are available */
 	if (!rxchan || !txchan)
@@ -749,7 +749,7 @@ static int atmel_spi_next_xfer_dma_submit(struct spi_master *master,
 	if (!txdesc)
 		goto err_dma;
 
-	dev_dbg(master->dev.parent,
+	dev_dbg(host->dev.parent,
 		"  start dma xfer %p: len %u tx %p/%08llx rx %p/%08llx\n",
 		xfer, xfer->len, xfer->tx_buf, (unsigned long long)xfer->tx_dma,
 		xfer->rx_buf, (unsigned long long)xfer->rx_dma);
@@ -759,7 +759,7 @@ static int atmel_spi_next_xfer_dma_submit(struct spi_master *master,
 
 	/* Put the callback on the RX transfer only, that should finish last */
 	rxdesc->callback = dma_callback;
-	rxdesc->callback_param = master;
+	rxdesc->callback_param = host;
 
 	/* Submit and fire RX and TX with TX last so we're ready to read! */
 	cookie = rxdesc->tx_submit(rxdesc);
@@ -775,12 +775,12 @@ static int atmel_spi_next_xfer_dma_submit(struct spi_master *master,
 
 err_dma:
 	spi_writel(as, IDR, SPI_BIT(OVRES));
-	atmel_spi_stop_dma(master);
+	atmel_spi_stop_dma(host);
 err_exit:
 	return -ENOMEM;
 }
 
-static void atmel_spi_next_xfer_data(struct spi_master *master,
+static void atmel_spi_next_xfer_data(struct spi_controller *host,
 				struct spi_transfer *xfer,
 				dma_addr_t *tx_dma,
 				dma_addr_t *rx_dma,
@@ -788,8 +788,8 @@ static void atmel_spi_next_xfer_data(struct spi_master *master,
 {
 	*rx_dma = xfer->rx_dma + xfer->len - *plen;
 	*tx_dma = xfer->tx_dma + xfer->len - *plen;
-	if (*plen > master->max_dma_len)
-		*plen = master->max_dma_len;
+	if (*plen > host->max_dma_len)
+		*plen = host->max_dma_len;
 }
 
 static int atmel_spi_set_xfer_speed(struct atmel_spi *as,
@@ -844,17 +844,17 @@ static int atmel_spi_set_xfer_speed(struct atmel_spi *as,
  * Submit next transfer for PDC.
  * lock is held, spi irq is blocked
  */
-static void atmel_spi_pdc_next_xfer(struct spi_master *master,
+static void atmel_spi_pdc_next_xfer(struct spi_controller *host,
 					struct spi_transfer *xfer)
 {
-	struct atmel_spi	*as = spi_master_get_devdata(master);
+	struct atmel_spi	*as = spi_controller_get_devdata(host);
 	u32			len;
 	dma_addr_t		tx_dma, rx_dma;
 
 	spi_writel(as, PTCR, SPI_BIT(RXTDIS) | SPI_BIT(TXTDIS));
 
 	len = as->current_remaining_bytes;
-	atmel_spi_next_xfer_data(master, xfer, &tx_dma, &rx_dma, &len);
+	atmel_spi_next_xfer_data(host, xfer, &tx_dma, &rx_dma, &len);
 	as->current_remaining_bytes -= len;
 
 	spi_writel(as, RPR, rx_dma);
@@ -865,7 +865,7 @@ static void atmel_spi_pdc_next_xfer(struct spi_master *master,
 	spi_writel(as, RCR, len);
 	spi_writel(as, TCR, len);
 
-	dev_dbg(&master->dev,
+	dev_dbg(&host->dev,
 		"  start xfer %p: len %u tx %p/%08llx rx %p/%08llx\n",
 		xfer, xfer->len, xfer->tx_buf,
 		(unsigned long long)xfer->tx_dma, xfer->rx_buf,
@@ -873,7 +873,7 @@ static void atmel_spi_pdc_next_xfer(struct spi_master *master,
 
 	if (as->current_remaining_bytes) {
 		len = as->current_remaining_bytes;
-		atmel_spi_next_xfer_data(master, xfer, &tx_dma, &rx_dma, &len);
+		atmel_spi_next_xfer_data(host, xfer, &tx_dma, &rx_dma, &len);
 		as->current_remaining_bytes -= len;
 
 		spi_writel(as, RNPR, rx_dma);
@@ -884,7 +884,7 @@ static void atmel_spi_pdc_next_xfer(struct spi_master *master,
 		spi_writel(as, RNCR, len);
 		spi_writel(as, TNCR, len);
 
-		dev_dbg(&master->dev,
+		dev_dbg(&host->dev,
 			"  next xfer %p: len %u tx %p/%08llx rx %p/%08llx\n",
 			xfer, xfer->len, xfer->tx_buf,
 			(unsigned long long)xfer->tx_dma, xfer->rx_buf,
@@ -944,14 +944,14 @@ atmel_spi_dma_map_xfer(struct atmel_spi *as, struct spi_transfer *xfer)
 	return 0;
 }
 
-static void atmel_spi_dma_unmap_xfer(struct spi_master *master,
+static void atmel_spi_dma_unmap_xfer(struct spi_controller *host,
 				     struct spi_transfer *xfer)
 {
 	if (xfer->tx_dma != INVALID_DMA_ADDRESS)
-		dma_unmap_single(master->dev.parent, xfer->tx_dma,
+		dma_unmap_single(host->dev.parent, xfer->tx_dma,
 				 xfer->len, DMA_TO_DEVICE);
 	if (xfer->rx_dma != INVALID_DMA_ADDRESS)
-		dma_unmap_single(master->dev.parent, xfer->rx_dma,
+		dma_unmap_single(host->dev.parent, xfer->rx_dma,
 				 xfer->len, DMA_FROM_DEVICE);
 }
 
@@ -1039,8 +1039,8 @@ atmel_spi_pump_pio_data(struct atmel_spi *as, struct spi_transfer *xfer)
 static irqreturn_t
 atmel_spi_pio_interrupt(int irq, void *dev_id)
 {
-	struct spi_master	*master = dev_id;
-	struct atmel_spi	*as = spi_master_get_devdata(master);
+	struct spi_controller	*host = dev_id;
+	struct atmel_spi	*as = spi_controller_get_devdata(host);
 	u32			status, pending, imr;
 	struct spi_transfer	*xfer;
 	int			ret = IRQ_NONE;
@@ -1052,7 +1052,7 @@ atmel_spi_pio_interrupt(int irq, void *dev_id)
 	if (pending & SPI_BIT(OVRES)) {
 		ret = IRQ_HANDLED;
 		spi_writel(as, IDR, SPI_BIT(OVRES));
-		dev_warn(master->dev.parent, "overrun\n");
+		dev_warn(host->dev.parent, "overrun\n");
 
 		/*
 		 * When we get an overrun, we disregard the current
@@ -1097,8 +1097,8 @@ atmel_spi_pio_interrupt(int irq, void *dev_id)
 static irqreturn_t
 atmel_spi_pdc_interrupt(int irq, void *dev_id)
 {
-	struct spi_master	*master = dev_id;
-	struct atmel_spi	*as = spi_master_get_devdata(master);
+	struct spi_controller	*host = dev_id;
+	struct atmel_spi	*as = spi_controller_get_devdata(host);
 	u32			status, pending, imr;
 	int			ret = IRQ_NONE;
 
@@ -1152,12 +1152,12 @@ static int atmel_word_delay_csr(struct spi_device *spi, struct atmel_spi *as)
 static void initialize_native_cs_for_gpio(struct atmel_spi *as)
 {
 	int i;
-	struct spi_master *master = platform_get_drvdata(as->pdev);
+	struct spi_controller *host = platform_get_drvdata(as->pdev);
 
 	if (!as->native_cs_free)
 		return; /* already initialized */
 
-	if (!master->cs_gpiods)
+	if (!host->cs_gpiods)
 		return; /* No CS GPIO */
 
 	/*
@@ -1170,7 +1170,7 @@ static void initialize_native_cs_for_gpio(struct atmel_spi *as)
 		i = 1;
 
 	for (; i < 4; i++)
-		if (master->cs_gpiods[i])
+		if (host->cs_gpiods[i])
 			as->native_cs_free |= BIT(i);
 
 	if (as->native_cs_free)
@@ -1186,7 +1186,7 @@ static int atmel_spi_setup(struct spi_device *spi)
 	int chip_select;
 	int			word_delay_csr;
 
-	as = spi_master_get_devdata(spi->master);
+	as = spi_controller_get_devdata(spi->controller);
 
 	/* see notes above re chipselect */
 	if (!spi->cs_gpiod && (spi->mode & SPI_CS_HIGH)) {
@@ -1254,7 +1254,7 @@ static int atmel_spi_setup(struct spi_device *spi)
 
 static void atmel_spi_set_cs(struct spi_device *spi, bool enable)
 {
-	struct atmel_spi *as = spi_master_get_devdata(spi->master);
+	struct atmel_spi *as = spi_controller_get_devdata(spi->controller);
 	/* the core doesn't really pass us enable/disable, but CS HIGH vs CS LOW
 	 * since we already have routines for activate/deactivate translate
 	 * high/low to active/inactive
@@ -1269,7 +1269,7 @@ static void atmel_spi_set_cs(struct spi_device *spi, bool enable)
 
 }
 
-static int atmel_spi_one_transfer(struct spi_master *master,
+static int atmel_spi_one_transfer(struct spi_controller *host,
 					struct spi_device *spi,
 					struct spi_transfer *xfer)
 {
@@ -1281,7 +1281,7 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 	int			ret;
 	unsigned long		dma_timeout;
 
-	as = spi_master_get_devdata(master);
+	as = spi_controller_get_devdata(host);
 
 	asd = spi->controller_state;
 	bits = (asd->csr >> 4) & 0xf;
@@ -1295,7 +1295,7 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 	 * DMA map early, for performance (empties dcache ASAP) and
 	 * better fault reporting.
 	 */
-	if ((!master->cur_msg->is_dma_mapped)
+	if ((!host->cur_msg->is_dma_mapped)
 		&& as->use_pdc) {
 		if (atmel_spi_dma_map_xfer(as, xfer) < 0)
 			return -ENOMEM;
@@ -1311,11 +1311,11 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 
 		if (as->use_pdc) {
 			atmel_spi_lock(as);
-			atmel_spi_pdc_next_xfer(master, xfer);
+			atmel_spi_pdc_next_xfer(host, xfer);
 			atmel_spi_unlock(as);
 		} else if (atmel_spi_use_dma(as, xfer)) {
 			len = as->current_remaining_bytes;
-			ret = atmel_spi_next_xfer_dma_submit(master,
+			ret = atmel_spi_next_xfer_dma_submit(host,
 								xfer, &len);
 			if (ret) {
 				dev_err(&spi->dev,
@@ -1329,7 +1329,7 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 			}
 		} else {
 			atmel_spi_lock(as);
-			atmel_spi_next_xfer_pio(master, xfer);
+			atmel_spi_next_xfer_pio(host, xfer);
 			atmel_spi_unlock(as);
 		}
 
@@ -1346,7 +1346,7 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 
 	if (as->done_status) {
 		if (as->use_pdc) {
-			dev_warn(master->dev.parent,
+			dev_warn(host->dev.parent,
 				"overrun (%u/%u remaining)\n",
 				spi_readl(as, TCR), spi_readl(as, RCR));
 
@@ -1362,7 +1362,7 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 				if (spi_readl(as, SR) & SPI_BIT(TXEMPTY))
 					break;
 			if (!timeout)
-				dev_warn(master->dev.parent,
+				dev_warn(host->dev.parent,
 					 "timeout waiting for TXEMPTY");
 			while (spi_readl(as, SR) & SPI_BIT(RDRF))
 				spi_readl(as, RDR);
@@ -1371,13 +1371,13 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 			spi_readl(as, SR);
 
 		} else if (atmel_spi_use_dma(as, xfer)) {
-			atmel_spi_stop_dma(master);
+			atmel_spi_stop_dma(host);
 		}
 	}
 
-	if (!master->cur_msg->is_dma_mapped
+	if (!host->cur_msg->is_dma_mapped
 		&& as->use_pdc)
-		atmel_spi_dma_unmap_xfer(master, xfer);
+		atmel_spi_dma_unmap_xfer(host, xfer);
 
 	if (as->use_pdc)
 		atmel_spi_disable_pdc_transfer(as);
@@ -1440,7 +1440,7 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	int			irq;
 	struct clk		*clk;
 	int			ret;
-	struct spi_master	*master;
+	struct spi_controller	*host;
 	struct atmel_spi	*as;
 
 	/* Select default pin state */
@@ -1459,29 +1459,29 @@ static int atmel_spi_probe(struct platform_device *pdev)
 		return PTR_ERR(clk);
 
 	/* setup spi core then atmel-specific driver state */
-	master = spi_alloc_master(&pdev->dev, sizeof(*as));
-	if (!master)
+	host = spi_alloc_host(&pdev->dev, sizeof(*as));
+	if (!host)
 		return -ENOMEM;
 
 	/* the spi->mode bits understood by this driver: */
-	master->use_gpio_descriptors = true;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
-	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 16);
-	master->dev.of_node = pdev->dev.of_node;
-	master->bus_num = pdev->id;
-	master->num_chipselect = 4;
-	master->setup = atmel_spi_setup;
-	master->flags = (SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX |
+	host->use_gpio_descriptors = true;
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 16);
+	host->dev.of_node = pdev->dev.of_node;
+	host->bus_num = pdev->id;
+	host->num_chipselect = 4;
+	host->setup = atmel_spi_setup;
+	host->flags = (SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX |
 			SPI_MASTER_GPIO_SS);
-	master->transfer_one = atmel_spi_one_transfer;
-	master->set_cs = atmel_spi_set_cs;
-	master->cleanup = atmel_spi_cleanup;
-	master->auto_runtime_pm = true;
-	master->max_dma_len = SPI_MAX_DMA_XFER;
-	master->can_dma = atmel_spi_can_dma;
-	platform_set_drvdata(pdev, master);
+	host->transfer_one = atmel_spi_one_transfer;
+	host->set_cs = atmel_spi_set_cs;
+	host->cleanup = atmel_spi_cleanup;
+	host->auto_runtime_pm = true;
+	host->max_dma_len = SPI_MAX_DMA_XFER;
+	host->can_dma = atmel_spi_can_dma;
+	platform_set_drvdata(pdev, host);
 
-	as = spi_master_get_devdata(master);
+	as = spi_controller_get_devdata(host);
 
 	spin_lock_init(&as->lock);
 
@@ -1502,7 +1502,7 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	as->use_dma = false;
 	as->use_pdc = false;
 	if (as->caps.has_dma_support) {
-		ret = atmel_spi_configure_dma(master, as);
+		ret = atmel_spi_configure_dma(host, as);
 		if (ret == 0) {
 			as->use_dma = true;
 		} else if (ret == -EPROBE_DEFER) {
@@ -1532,7 +1532,7 @@ static int atmel_spi_probe(struct platform_device *pdev)
 			}
 		}
 		if (!as->use_dma)
-			dev_info(master->dev.parent,
+			dev_info(host->dev.parent,
 				 "  can not allocate dma coherent memory\n");
 	}
 
@@ -1541,10 +1541,10 @@ static int atmel_spi_probe(struct platform_device *pdev)
 
 	if (as->use_pdc) {
 		ret = devm_request_irq(&pdev->dev, irq, atmel_spi_pdc_interrupt,
-					0, dev_name(&pdev->dev), master);
+					0, dev_name(&pdev->dev), host);
 	} else {
 		ret = devm_request_irq(&pdev->dev, irq, atmel_spi_pio_interrupt,
-					0, dev_name(&pdev->dev), master);
+					0, dev_name(&pdev->dev), host);
 	}
 	if (ret)
 		goto out_unmap_regs;
@@ -1569,7 +1569,7 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = devm_spi_register_controller(&pdev->dev, host);
 	if (ret)
 		goto out_free_dma;
 
@@ -1585,28 +1585,28 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	pm_runtime_set_suspended(&pdev->dev);
 
 	if (as->use_dma)
-		atmel_spi_release_dma(master);
+		atmel_spi_release_dma(host);
 
 	spi_writel(as, CR, SPI_BIT(SWRST));
 	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
 	clk_disable_unprepare(clk);
 out_free_irq:
 out_unmap_regs:
-	spi_master_put(master);
+	spi_controller_put(host);
 	return ret;
 }
 
 static int atmel_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master	*master = platform_get_drvdata(pdev);
-	struct atmel_spi	*as = spi_master_get_devdata(master);
+	struct spi_controller	*host = platform_get_drvdata(pdev);
+	struct atmel_spi	*as = spi_controller_get_devdata(host);
 
 	pm_runtime_get_sync(&pdev->dev);
 
 	/* reset the hardware and block queue progress */
 	if (as->use_dma) {
-		atmel_spi_stop_dma(master);
-		atmel_spi_release_dma(master);
+		atmel_spi_stop_dma(host);
+		atmel_spi_release_dma(host);
 		if (IS_ENABLED(CONFIG_SOC_SAM_V4_V5)) {
 			dma_free_coherent(&pdev->dev, SPI_MAX_DMA_XFER,
 					  as->addr_tx_bbuf,
@@ -1633,8 +1633,8 @@ static int atmel_spi_remove(struct platform_device *pdev)
 
 static int atmel_spi_runtime_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct atmel_spi *as = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct atmel_spi *as = spi_controller_get_devdata(host);
 
 	clk_disable_unprepare(as->clk);
 	pinctrl_pm_select_sleep_state(dev);
@@ -1644,8 +1644,8 @@ static int atmel_spi_runtime_suspend(struct device *dev)
 
 static int atmel_spi_runtime_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct atmel_spi *as = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct atmel_spi *as = spi_controller_get_devdata(host);
 
 	pinctrl_pm_select_default_state(dev);
 
@@ -1654,11 +1654,11 @@ static int atmel_spi_runtime_resume(struct device *dev)
 
 static int atmel_spi_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
+	struct spi_controller *host = dev_get_drvdata(dev);
 	int ret;
 
 	/* Stop the queue running */
-	ret = spi_master_suspend(master);
+	ret = spi_controller_suspend(host);
 	if (ret)
 		return ret;
 
@@ -1670,8 +1670,8 @@ static int atmel_spi_suspend(struct device *dev)
 
 static int atmel_spi_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct atmel_spi *as = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct atmel_spi *as = spi_controller_get_devdata(host);
 	int ret;
 
 	ret = clk_prepare_enable(as->clk);
@@ -1689,7 +1689,7 @@ static int atmel_spi_resume(struct device *dev)
 	}
 
 	/* Start the queue running */
-	return spi_master_resume(master);
+	return spi_controller_resume(host);
 }
 
 static const struct dev_pm_ops atmel_spi_pm_ops = {
-- 
2.25.1

