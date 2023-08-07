Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEFE772482
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 14:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbjHGMo3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 08:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjHGMoV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 08:44:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72621722
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 05:44:14 -0700 (PDT)
Received: from dggpemm100012.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKGFJ5cgczfbnf;
        Mon,  7 Aug 2023 20:43:00 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100012.china.huawei.com (7.185.36.212) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 20:44:10 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 20:44:09 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 08/20] spi: fsl-lpspi: switch to use modern name
Date:   Mon, 7 Aug 2023 20:40:53 +0800
Message-ID: <20230807124105.3429709-9-yangyingliang@huawei.com>
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

Change legacy name master/target to modern name host/target

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-fsl-lpspi.c | 54 ++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index e32e8cab5aa8..11991eb12636 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -72,7 +72,7 @@
 #define CFGR1_PINCFG	(BIT(24)|BIT(25))
 #define CFGR1_PCSPOL	BIT(8)
 #define CFGR1_NOSTALL	BIT(3)
-#define CFGR1_MASTER	BIT(0)
+#define CFGR1_HOST	BIT(0)
 #define FSR_TXCOUNT	(0xFF)
 #define RSR_RXEMPTY	BIT(1)
 #define TCR_CPOL	BIT(31)
@@ -96,7 +96,7 @@ struct fsl_lpspi_data {
 	unsigned long base_phys;
 	struct clk *clk_ipg;
 	struct clk *clk_per;
-	bool is_slave;
+	bool is_target;
 	bool is_only_cs1;
 	bool is_first_byte;
 
@@ -113,7 +113,7 @@ struct fsl_lpspi_data {
 	struct lpspi_config config;
 	struct completion xfer_done;
 
-	bool slave_aborted;
+	bool target_aborted;
 
 	/* DMA */
 	bool usedma;
@@ -234,7 +234,7 @@ static void fsl_lpspi_write_tx_fifo(struct fsl_lpspi_data *fsl_lpspi)
 	}
 
 	if (txfifo_cnt < fsl_lpspi->txfifosize) {
-		if (!fsl_lpspi->is_slave) {
+		if (!fsl_lpspi->is_target) {
 			temp = readl(fsl_lpspi->base + IMX7ULP_TCR);
 			temp &= ~TCR_CONTC;
 			writel(temp, fsl_lpspi->base + IMX7ULP_TCR);
@@ -258,7 +258,7 @@ static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *fsl_lpspi)
 	temp |= fsl_lpspi->config.bpw - 1;
 	temp |= (fsl_lpspi->config.mode & 0x3) << 30;
 	temp |= (fsl_lpspi->config.chip_select & 0x3) << 24;
-	if (!fsl_lpspi->is_slave) {
+	if (!fsl_lpspi->is_target) {
 		temp |= fsl_lpspi->config.prescale << 27;
 		/*
 		 * Set TCR_CONT will keep SS asserted after current transfer.
@@ -385,7 +385,7 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
 	u32 temp;
 	int ret;
 
-	if (!fsl_lpspi->is_slave) {
+	if (!fsl_lpspi->is_target) {
 		ret = fsl_lpspi_set_bitrate(fsl_lpspi);
 		if (ret)
 			return ret;
@@ -393,8 +393,8 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
 
 	fsl_lpspi_set_watermark(fsl_lpspi);
 
-	if (!fsl_lpspi->is_slave)
-		temp = CFGR1_MASTER;
+	if (!fsl_lpspi->is_target)
+		temp = CFGR1_HOST;
 	else
 		temp = CFGR1_PINCFG;
 	if (fsl_lpspi->config.mode & SPI_CS_HIGH)
@@ -461,12 +461,12 @@ static int fsl_lpspi_setup_transfer(struct spi_controller *controller,
 	return fsl_lpspi_config(fsl_lpspi);
 }
 
-static int fsl_lpspi_slave_abort(struct spi_controller *controller)
+static int fsl_lpspi_target_abort(struct spi_controller *controller)
 {
 	struct fsl_lpspi_data *fsl_lpspi =
 				spi_controller_get_devdata(controller);
 
-	fsl_lpspi->slave_aborted = true;
+	fsl_lpspi->target_aborted = true;
 	if (!fsl_lpspi->usedma)
 		complete(&fsl_lpspi->xfer_done);
 	else {
@@ -482,9 +482,9 @@ static int fsl_lpspi_wait_for_completion(struct spi_controller *controller)
 	struct fsl_lpspi_data *fsl_lpspi =
 				spi_controller_get_devdata(controller);
 
-	if (fsl_lpspi->is_slave) {
+	if (fsl_lpspi->is_target) {
 		if (wait_for_completion_interruptible(&fsl_lpspi->xfer_done) ||
-			fsl_lpspi->slave_aborted) {
+			fsl_lpspi->target_aborted) {
 			dev_dbg(fsl_lpspi->dev, "interrupted\n");
 			return -EINTR;
 		}
@@ -587,9 +587,9 @@ static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
 	reinit_completion(&fsl_lpspi->dma_tx_completion);
 	dma_async_issue_pending(controller->dma_tx);
 
-	fsl_lpspi->slave_aborted = false;
+	fsl_lpspi->target_aborted = false;
 
-	if (!fsl_lpspi->is_slave) {
+	if (!fsl_lpspi->is_target) {
 		transfer_timeout = fsl_lpspi_calculate_timeout(fsl_lpspi,
 							       transfer->len);
 
@@ -615,7 +615,7 @@ static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
 		}
 	} else {
 		if (wait_for_completion_interruptible(&fsl_lpspi->dma_tx_completion) ||
-			fsl_lpspi->slave_aborted) {
+			fsl_lpspi->target_aborted) {
 			dev_dbg(fsl_lpspi->dev,
 				"I/O Error in DMA TX interrupted\n");
 			dmaengine_terminate_all(controller->dma_tx);
@@ -625,7 +625,7 @@ static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
 		}
 
 		if (wait_for_completion_interruptible(&fsl_lpspi->dma_rx_completion) ||
-			fsl_lpspi->slave_aborted) {
+			fsl_lpspi->target_aborted) {
 			dev_dbg(fsl_lpspi->dev,
 				"I/O Error in DMA RX interrupted\n");
 			dmaengine_terminate_all(controller->dma_tx);
@@ -700,7 +700,7 @@ static int fsl_lpspi_pio_transfer(struct spi_controller *controller,
 	fsl_lpspi->remain = t->len;
 
 	reinit_completion(&fsl_lpspi->xfer_done);
-	fsl_lpspi->slave_aborted = false;
+	fsl_lpspi->target_aborted = false;
 
 	fsl_lpspi_write_tx_fifo(fsl_lpspi);
 
@@ -826,15 +826,15 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	int ret, irq;
 	u32 num_cs;
 	u32 temp;
-	bool is_slave;
+	bool is_target;
 
-	is_slave = of_property_read_bool((&pdev->dev)->of_node, "spi-slave");
-	if (is_slave)
-		controller = spi_alloc_slave(&pdev->dev,
-					sizeof(struct fsl_lpspi_data));
+	is_target = of_property_read_bool((&pdev->dev)->of_node, "spi-slave");
+	if (is_target)
+		controller = spi_alloc_target(&pdev->dev,
+					      sizeof(struct fsl_lpspi_data));
 	else
-		controller = spi_alloc_master(&pdev->dev,
-					sizeof(struct fsl_lpspi_data));
+		controller = spi_alloc_host(&pdev->dev,
+					    sizeof(struct fsl_lpspi_data));
 
 	if (!controller)
 		return -ENOMEM;
@@ -843,7 +843,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 
 	fsl_lpspi = spi_controller_get_devdata(controller);
 	fsl_lpspi->dev = &pdev->dev;
-	fsl_lpspi->is_slave = is_slave;
+	fsl_lpspi->is_target = is_target;
 	fsl_lpspi->is_only_cs1 = of_property_read_bool((&pdev->dev)->of_node,
 						"fsl,spi-only-use-cs1-sel");
 
@@ -912,8 +912,8 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	controller->dev.of_node = pdev->dev.of_node;
 	controller->bus_num = pdev->id;
 	controller->num_chipselect = num_cs;
-	controller->slave_abort = fsl_lpspi_slave_abort;
-	if (!fsl_lpspi->is_slave)
+	controller->target_abort = fsl_lpspi_target_abort;
+	if (!fsl_lpspi->is_target)
 		controller->use_gpio_descriptors = true;
 
 	ret = fsl_lpspi_dma_init(&pdev->dev, fsl_lpspi, controller);
-- 
2.25.1

