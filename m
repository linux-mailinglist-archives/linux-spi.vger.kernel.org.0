Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10A277248F
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 14:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbjHGMoi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 08:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbjHGMo1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 08:44:27 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4721991
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 05:44:17 -0700 (PDT)
Received: from dggpemm100003.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKGBk0Hk4ztS1M;
        Mon,  7 Aug 2023 20:40:46 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100003.china.huawei.com (7.185.36.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 20:44:13 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 20:44:12 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 16/20] spi: imx: switch to use modern name
Date:   Mon, 7 Aug 2023 20:41:01 +0800
Message-ID: <20230807124105.3429709-17-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230807124105.3429709-1-yangyingliang@huawei.com>
References: <20230807124105.3429709-1-yangyingliang@huawei.com>
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

Change legacy name master/slave to modern name host/target.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-imx.c | 114 +++++++++++++++++++++---------------------
 1 file changed, 57 insertions(+), 57 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 3634fe8f6d68..a8a74c7cb79f 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -52,7 +52,7 @@ MODULE_PARM_DESC(polling_limit_us,
 /* The maximum bytes that a sdma BD can transfer. */
 #define MAX_SDMA_BD_BYTES (1 << 15)
 #define MX51_ECSPI_CTRL_MAX_BURST	512
-/* The maximum bytes that IMX53_ECSPI can transfer in slave mode.*/
+/* The maximum bytes that IMX53_ECSPI can transfer in target mode.*/
 #define MX53_MAX_TRANSFER_BYTES		512
 
 enum spi_imx_devtype {
@@ -77,7 +77,7 @@ struct spi_imx_devtype_data {
 	void (*setup_wml)(struct spi_imx_data *spi_imx);
 	void (*disable)(struct spi_imx_data *spi_imx);
 	bool has_dmamode;
-	bool has_slavemode;
+	bool has_targetmode;
 	unsigned int fifo_size;
 	bool dynamic_burst;
 	/*
@@ -113,10 +113,10 @@ struct spi_imx_data {
 	unsigned int dynamic_burst;
 	bool rx_only;
 
-	/* Slave mode */
-	bool slave_mode;
-	bool slave_aborted;
-	unsigned int slave_burst;
+	/* Target mode */
+	bool target_mode;
+	bool target_aborted;
+	unsigned int target_burst;
 
 	/* DMA */
 	bool usedma;
@@ -240,7 +240,7 @@ static bool spi_imx_can_dma(struct spi_controller *controller, struct spi_device
 	if (!controller->dma_rx)
 		return false;
 
-	if (spi_imx->slave_mode)
+	if (spi_imx->target_mode)
 		return false;
 
 	if (transfer->len < spi_imx->devtype_data->fifo_size)
@@ -404,12 +404,12 @@ static void spi_imx_buf_tx_swap(struct spi_imx_data *spi_imx)
 	writel(val, spi_imx->base + MXC_CSPITXDATA);
 }
 
-static void mx53_ecspi_rx_slave(struct spi_imx_data *spi_imx)
+static void mx53_ecspi_rx_target(struct spi_imx_data *spi_imx)
 {
 	u32 val = be32_to_cpu(readl(spi_imx->base + MXC_CSPIRXDATA));
 
 	if (spi_imx->rx_buf) {
-		int n_bytes = spi_imx->slave_burst % sizeof(val);
+		int n_bytes = spi_imx->target_burst % sizeof(val);
 
 		if (!n_bytes)
 			n_bytes = sizeof(val);
@@ -418,13 +418,13 @@ static void mx53_ecspi_rx_slave(struct spi_imx_data *spi_imx)
 		       ((u8 *)&val) + sizeof(val) - n_bytes, n_bytes);
 
 		spi_imx->rx_buf += n_bytes;
-		spi_imx->slave_burst -= n_bytes;
+		spi_imx->target_burst -= n_bytes;
 	}
 
 	spi_imx->remainder -= sizeof(u32);
 }
 
-static void mx53_ecspi_tx_slave(struct spi_imx_data *spi_imx)
+static void mx53_ecspi_tx_target(struct spi_imx_data *spi_imx)
 {
 	u32 val = 0;
 	int n_bytes = spi_imx->count % sizeof(val);
@@ -535,8 +535,8 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 	u32 current_cfg = cfg;
 	int channel = mx51_ecspi_channel(spi);
 
-	/* set Master or Slave mode */
-	if (spi_imx->slave_mode)
+	/* set Host or Target mode */
+	if (spi_imx->target_mode)
 		ctrl &= ~MX51_ECSPI_CTRL_MODE_MASK;
 	else
 		ctrl |= MX51_ECSPI_CTRL_MODE_MASK;
@@ -564,11 +564,11 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 	writel(testreg, spi_imx->base + MX51_ECSPI_TESTREG);
 
 	/*
-	 * eCSPI burst completion by Chip Select signal in Slave mode
+	 * eCSPI burst completion by Chip Select signal in Target mode
 	 * is not functional for imx53 Soc, config SPI burst completed when
 	 * BURST_LENGTH + 1 bits are received
 	 */
-	if (spi_imx->slave_mode && is_imx53_ecspi(spi_imx))
+	if (spi_imx->target_mode && is_imx53_ecspi(spi_imx))
 		cfg &= ~MX51_ECSPI_CONFIG_SBBCTRL(channel);
 	else
 		cfg |= MX51_ECSPI_CONFIG_SBBCTRL(channel);
@@ -655,8 +655,8 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 
 	/* Clear BL field and set the right value */
 	ctrl &= ~MX51_ECSPI_CTRL_BL_MASK;
-	if (spi_imx->slave_mode && is_imx53_ecspi(spi_imx))
-		ctrl |= (spi_imx->slave_burst * 8 - 1)
+	if (spi_imx->target_mode && is_imx53_ecspi(spi_imx))
+		ctrl |= (spi_imx->target_burst * 8 - 1)
 			<< MX51_ECSPI_CTRL_BL_OFFSET;
 	else {
 		if (spi_imx->count >= 512)
@@ -721,7 +721,7 @@ static void mx51_ecspi_reset(struct spi_imx_data *spi_imx)
 #define MX31_INTREG_RREN	(1 << 3)
 
 #define MX31_CSPICTRL_ENABLE	(1 << 0)
-#define MX31_CSPICTRL_MASTER	(1 << 1)
+#define MX31_CSPICTRL_HOST	(1 << 1)
 #define MX31_CSPICTRL_XCH	(1 << 2)
 #define MX31_CSPICTRL_SMC	(1 << 3)
 #define MX31_CSPICTRL_POL	(1 << 4)
@@ -778,7 +778,7 @@ static int mx31_prepare_message(struct spi_imx_data *spi_imx,
 static int mx31_prepare_transfer(struct spi_imx_data *spi_imx,
 				 struct spi_device *spi)
 {
-	unsigned int reg = MX31_CSPICTRL_ENABLE | MX31_CSPICTRL_MASTER;
+	unsigned int reg = MX31_CSPICTRL_ENABLE | MX31_CSPICTRL_HOST;
 	unsigned int clk;
 
 	reg |= spi_imx_clkdiv_2(spi_imx->spi_clk, spi_imx->spi_bus_clk, &clk) <<
@@ -848,7 +848,7 @@ static void mx31_reset(struct spi_imx_data *spi_imx)
 #define MX21_CSPICTRL_SSPOL	(1 << 8)
 #define MX21_CSPICTRL_XCH	(1 << 9)
 #define MX21_CSPICTRL_ENABLE	(1 << 10)
-#define MX21_CSPICTRL_MASTER	(1 << 11)
+#define MX21_CSPICTRL_HOST	(1 << 11)
 #define MX21_CSPICTRL_DR_SHIFT	14
 #define MX21_CSPICTRL_CS_SHIFT	19
 
@@ -882,7 +882,7 @@ static int mx21_prepare_message(struct spi_imx_data *spi_imx,
 static int mx21_prepare_transfer(struct spi_imx_data *spi_imx,
 				 struct spi_device *spi)
 {
-	unsigned int reg = MX21_CSPICTRL_ENABLE | MX21_CSPICTRL_MASTER;
+	unsigned int reg = MX21_CSPICTRL_ENABLE | MX21_CSPICTRL_HOST;
 	unsigned int max = is_imx27_cspi(spi_imx) ? 16 : 18;
 	unsigned int clk;
 
@@ -924,7 +924,7 @@ static void mx21_reset(struct spi_imx_data *spi_imx)
 #define MX1_CSPICTRL_PHA	(1 << 5)
 #define MX1_CSPICTRL_XCH	(1 << 8)
 #define MX1_CSPICTRL_ENABLE	(1 << 9)
-#define MX1_CSPICTRL_MASTER	(1 << 10)
+#define MX1_CSPICTRL_HOST	(1 << 10)
 #define MX1_CSPICTRL_DR_SHIFT	13
 
 static void mx1_intctrl(struct spi_imx_data *spi_imx, int enable)
@@ -957,7 +957,7 @@ static int mx1_prepare_message(struct spi_imx_data *spi_imx,
 static int mx1_prepare_transfer(struct spi_imx_data *spi_imx,
 				struct spi_device *spi)
 {
-	unsigned int reg = MX1_CSPICTRL_ENABLE | MX1_CSPICTRL_MASTER;
+	unsigned int reg = MX1_CSPICTRL_ENABLE | MX1_CSPICTRL_HOST;
 	unsigned int clk;
 
 	reg |= spi_imx_clkdiv_2(spi_imx->spi_clk, spi_imx->spi_bus_clk, &clk) <<
@@ -996,7 +996,7 @@ static struct spi_imx_devtype_data imx1_cspi_devtype_data = {
 	.fifo_size = 8,
 	.has_dmamode = false,
 	.dynamic_burst = false,
-	.has_slavemode = false,
+	.has_targetmode = false,
 	.devtype = IMX1_CSPI,
 };
 
@@ -1010,7 +1010,7 @@ static struct spi_imx_devtype_data imx21_cspi_devtype_data = {
 	.fifo_size = 8,
 	.has_dmamode = false,
 	.dynamic_burst = false,
-	.has_slavemode = false,
+	.has_targetmode = false,
 	.devtype = IMX21_CSPI,
 };
 
@@ -1025,7 +1025,7 @@ static struct spi_imx_devtype_data imx27_cspi_devtype_data = {
 	.fifo_size = 8,
 	.has_dmamode = false,
 	.dynamic_burst = false,
-	.has_slavemode = false,
+	.has_targetmode = false,
 	.devtype = IMX27_CSPI,
 };
 
@@ -1039,7 +1039,7 @@ static struct spi_imx_devtype_data imx31_cspi_devtype_data = {
 	.fifo_size = 8,
 	.has_dmamode = false,
 	.dynamic_burst = false,
-	.has_slavemode = false,
+	.has_targetmode = false,
 	.devtype = IMX31_CSPI,
 };
 
@@ -1054,7 +1054,7 @@ static struct spi_imx_devtype_data imx35_cspi_devtype_data = {
 	.fifo_size = 8,
 	.has_dmamode = true,
 	.dynamic_burst = false,
-	.has_slavemode = false,
+	.has_targetmode = false,
 	.devtype = IMX35_CSPI,
 };
 
@@ -1069,7 +1069,7 @@ static struct spi_imx_devtype_data imx51_ecspi_devtype_data = {
 	.fifo_size = 64,
 	.has_dmamode = true,
 	.dynamic_burst = true,
-	.has_slavemode = true,
+	.has_targetmode = true,
 	.disable = mx51_ecspi_disable,
 	.devtype = IMX51_ECSPI,
 };
@@ -1083,7 +1083,7 @@ static struct spi_imx_devtype_data imx53_ecspi_devtype_data = {
 	.reset = mx51_ecspi_reset,
 	.fifo_size = 64,
 	.has_dmamode = true,
-	.has_slavemode = true,
+	.has_targetmode = true,
 	.disable = mx51_ecspi_disable,
 	.devtype = IMX53_ECSPI,
 };
@@ -1099,7 +1099,7 @@ static struct spi_imx_devtype_data imx6ul_ecspi_devtype_data = {
 	.fifo_size = 64,
 	.has_dmamode = true,
 	.dynamic_burst = true,
-	.has_slavemode = true,
+	.has_targetmode = true,
 	.tx_glitch_fixed = true,
 	.disable = mx51_ecspi_disable,
 	.devtype = IMX51_ECSPI,
@@ -1164,7 +1164,7 @@ static void spi_imx_push(struct spi_imx_data *spi_imx)
 		spi_imx->txfifo++;
 	}
 
-	if (!spi_imx->slave_mode)
+	if (!spi_imx->target_mode)
 		spi_imx->devtype_data->trigger(spi_imx);
 }
 
@@ -1268,7 +1268,7 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	 * words, we have to use multiple word-size bursts, we can't use
 	 * dynamic_burst in that case.
 	 */
-	if (spi_imx->devtype_data->dynamic_burst && !spi_imx->slave_mode &&
+	if (spi_imx->devtype_data->dynamic_burst && !spi_imx->target_mode &&
 	    !(spi->mode & SPI_CS_WORD) &&
 	    (spi_imx->bits_per_word == 8 ||
 	    spi_imx->bits_per_word == 16 ||
@@ -1300,10 +1300,10 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	spi_imx->rx_only = ((t->tx_buf == NULL)
 			|| (t->tx_buf == spi->controller->dummy_tx));
 
-	if (is_imx53_ecspi(spi_imx) && spi_imx->slave_mode) {
-		spi_imx->rx = mx53_ecspi_rx_slave;
-		spi_imx->tx = mx53_ecspi_tx_slave;
-		spi_imx->slave_burst = t->len;
+	if (is_imx53_ecspi(spi_imx) && spi_imx->target_mode) {
+		spi_imx->rx = mx53_ecspi_rx_target;
+		spi_imx->tx = mx53_ecspi_tx_target;
+		spi_imx->target_burst = t->len;
 	}
 
 	spi_imx->devtype_data->prepare_transfer(spi_imx, spi);
@@ -1568,8 +1568,8 @@ static int spi_imx_poll_transfer(struct spi_device *spi,
 	return 0;
 }
 
-static int spi_imx_pio_transfer_slave(struct spi_device *spi,
-				      struct spi_transfer *transfer)
+static int spi_imx_pio_transfer_target(struct spi_device *spi,
+				       struct spi_transfer *transfer)
 {
 	struct spi_imx_data *spi_imx = spi_controller_get_devdata(spi->controller);
 	int ret = 0;
@@ -1588,22 +1588,22 @@ static int spi_imx_pio_transfer_slave(struct spi_device *spi,
 	spi_imx->remainder = 0;
 
 	reinit_completion(&spi_imx->xfer_done);
-	spi_imx->slave_aborted = false;
+	spi_imx->target_aborted = false;
 
 	spi_imx_push(spi_imx);
 
 	spi_imx->devtype_data->intctrl(spi_imx, MXC_INT_TE | MXC_INT_RDR);
 
 	if (wait_for_completion_interruptible(&spi_imx->xfer_done) ||
-	    spi_imx->slave_aborted) {
+	    spi_imx->target_aborted) {
 		dev_dbg(&spi->dev, "interrupted\n");
 		ret = -EINTR;
 	}
 
-	/* ecspi has a HW issue when works in Slave mode,
+	/* ecspi has a HW issue when works in Target mode,
 	 * after 64 words writtern to TXFIFO, even TXFIFO becomes empty,
 	 * ECSPI_TXDATA keeps shift out the last word data,
-	 * so we have to disable ECSPI when in slave mode after the
+	 * so we have to disable ECSPI when in target mode after the
 	 * transfer completes
 	 */
 	if (spi_imx->devtype_data->disable)
@@ -1626,8 +1626,8 @@ static int spi_imx_transfer_one(struct spi_controller *controller,
 	while (spi_imx->devtype_data->rx_available(spi_imx))
 		readl(spi_imx->base + MXC_CSPIRXDATA);
 
-	if (spi_imx->slave_mode)
-		return spi_imx_pio_transfer_slave(spi, transfer);
+	if (spi_imx->target_mode)
+		return spi_imx_pio_transfer_target(spi, transfer);
 
 	/*
 	 * If we decided in spi_imx_can_dma() that we want to do a DMA
@@ -1693,11 +1693,11 @@ spi_imx_unprepare_message(struct spi_controller *controller, struct spi_message
 	return 0;
 }
 
-static int spi_imx_slave_abort(struct spi_controller *controller)
+static int spi_imx_target_abort(struct spi_controller *controller)
 {
 	struct spi_imx_data *spi_imx = spi_controller_get_devdata(controller);
 
-	spi_imx->slave_aborted = true;
+	spi_imx->target_aborted = true;
 	complete(&spi_imx->xfer_done);
 
 	return 0;
@@ -1712,17 +1712,17 @@ static int spi_imx_probe(struct platform_device *pdev)
 	int ret, irq, spi_drctl;
 	const struct spi_imx_devtype_data *devtype_data =
 			of_device_get_match_data(&pdev->dev);
-	bool slave_mode;
+	bool target_mode;
 	u32 val;
 
-	slave_mode = devtype_data->has_slavemode &&
-			of_property_read_bool(np, "spi-slave");
-	if (slave_mode)
-		controller = spi_alloc_slave(&pdev->dev,
-					     sizeof(struct spi_imx_data));
-	else
-		controller = spi_alloc_master(&pdev->dev,
+	target_mode = devtype_data->has_targetmode &&
+		      of_property_read_bool(np, "spi-slave");
+	if (target_mode)
+		controller = spi_alloc_target(&pdev->dev,
 					      sizeof(struct spi_imx_data));
+	else
+		controller = spi_alloc_host(&pdev->dev,
+					    sizeof(struct spi_imx_data));
 	if (!controller)
 		return -ENOMEM;
 
@@ -1741,7 +1741,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx = spi_controller_get_devdata(controller);
 	spi_imx->controller = controller;
 	spi_imx->dev = &pdev->dev;
-	spi_imx->slave_mode = slave_mode;
+	spi_imx->target_mode = target_mode;
 
 	spi_imx->devtype_data = devtype_data;
 
@@ -1761,7 +1761,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	controller->cleanup = spi_imx_cleanup;
 	controller->prepare_message = spi_imx_prepare_message;
 	controller->unprepare_message = spi_imx_unprepare_message;
-	controller->slave_abort = spi_imx_slave_abort;
+	controller->target_abort = spi_imx_target_abort;
 	controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_NO_CS |
 				SPI_MOSI_IDLE_LOW;
 
-- 
2.25.1

