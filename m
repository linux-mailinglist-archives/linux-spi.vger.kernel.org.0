Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07965784F48
	for <lists+linux-spi@lfdr.de>; Wed, 23 Aug 2023 05:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjHWDdk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 23:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjHWDdj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 23:33:39 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF41E54
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 20:33:36 -0700 (PDT)
Received: from dggpemm500004.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RVsCr4pJbzNnF4;
        Wed, 23 Aug 2023 11:30:00 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 23 Aug 2023 11:33:34 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 23 Aug
 2023 11:33:34 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v2 06/21] spi: microchip-core: switch to use modern name
Date:   Wed, 23 Aug 2023 11:29:48 +0800
Message-ID: <20230823033003.3407403-7-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823033003.3407403-1-yangyingliang@huawei.com>
References: <20230823033003.3407403-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

Change legacy name master/slave to modern name host/target or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-microchip-core.c | 74 ++++++++++++++++----------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip-core.c
index b451cd4860ec..3d4b22eda0bf 100644
--- a/drivers/spi/spi-microchip-core.c
+++ b/drivers/spi/spi-microchip-core.c
@@ -244,7 +244,7 @@ static inline void mchp_corespi_set_framesize(struct mchp_corespi *spi, int bt)
 static void mchp_corespi_set_cs(struct spi_device *spi, bool disable)
 {
 	u32 reg;
-	struct mchp_corespi *corespi = spi_master_get_devdata(spi->master);
+	struct mchp_corespi *corespi = spi_controller_get_devdata(spi->controller);
 
 	reg = mchp_corespi_read(corespi, REG_SLAVE_SELECT);
 	reg &= ~BIT(spi_get_chipselect(spi, 0));
@@ -255,11 +255,11 @@ static void mchp_corespi_set_cs(struct spi_device *spi, bool disable)
 
 static int mchp_corespi_setup(struct spi_device *spi)
 {
-	struct mchp_corespi *corespi = spi_master_get_devdata(spi->master);
+	struct mchp_corespi *corespi = spi_controller_get_devdata(spi->controller);
 	u32 reg;
 
 	/*
-	 * Active high slaves need to be specifically set to their inactive
+	 * Active high targets need to be specifically set to their inactive
 	 * states during probe by adding them to the "control group" & thus
 	 * driving their select line low.
 	 */
@@ -271,7 +271,7 @@ static int mchp_corespi_setup(struct spi_device *spi)
 	return 0;
 }
 
-static void mchp_corespi_init(struct spi_master *master, struct mchp_corespi *spi)
+static void mchp_corespi_init(struct spi_controller *host, struct mchp_corespi *spi)
 {
 	unsigned long clk_hz;
 	u32 control = mchp_corespi_read(spi, REG_CONTROL);
@@ -285,7 +285,7 @@ static void mchp_corespi_init(struct spi_master *master, struct mchp_corespi *sp
 
 	/* max. possible spi clock rate is the apb clock rate */
 	clk_hz = clk_get_rate(spi->clk);
-	master->max_speed_hz = clk_hz;
+	host->max_speed_hz = clk_hz;
 
 	/*
 	 * The controller must be configured so that it doesn't remove Chip
@@ -305,7 +305,7 @@ static void mchp_corespi_init(struct spi_master *master, struct mchp_corespi *sp
 	/*
 	 * It is required to enable direct mode, otherwise control over the chip
 	 * select is relinquished to the hardware. SSELOUT is enabled too so we
-	 * can deal with active high slaves.
+	 * can deal with active high targets.
 	 */
 	mchp_corespi_write(spi, REG_SLAVE_SELECT, SSELOUT | SSEL_DIRECT);
 
@@ -371,8 +371,8 @@ static inline void mchp_corespi_set_mode(struct mchp_corespi *spi, unsigned int
 
 static irqreturn_t mchp_corespi_interrupt(int irq, void *dev_id)
 {
-	struct spi_master *master = dev_id;
-	struct mchp_corespi *spi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_id;
+	struct mchp_corespi *spi = spi_controller_get_devdata(host);
 	u32 intfield = mchp_corespi_read(spi, REG_MIS) & 0xf;
 	bool finalise = false;
 
@@ -399,7 +399,7 @@ static irqreturn_t mchp_corespi_interrupt(int irq, void *dev_id)
 	if (intfield & INT_RX_CHANNEL_OVERFLOW) {
 		mchp_corespi_write(spi, REG_INT_CLEAR, INT_RX_CHANNEL_OVERFLOW);
 		finalise = true;
-		dev_err(&master->dev,
+		dev_err(&host->dev,
 			"%s: RX OVERFLOW: rxlen: %d, txlen: %d\n", __func__,
 			spi->rx_len, spi->tx_len);
 	}
@@ -407,13 +407,13 @@ static irqreturn_t mchp_corespi_interrupt(int irq, void *dev_id)
 	if (intfield & INT_TX_CHANNEL_UNDERRUN) {
 		mchp_corespi_write(spi, REG_INT_CLEAR, INT_TX_CHANNEL_UNDERRUN);
 		finalise = true;
-		dev_err(&master->dev,
+		dev_err(&host->dev,
 			"%s: TX UNDERFLOW: rxlen: %d, txlen: %d\n", __func__,
 			spi->rx_len, spi->tx_len);
 	}
 
 	if (finalise)
-		spi_finalize_current_transfer(master);
+		spi_finalize_current_transfer(host);
 
 	return IRQ_HANDLED;
 }
@@ -455,16 +455,16 @@ static int mchp_corespi_calculate_clkgen(struct mchp_corespi *spi,
 	return 0;
 }
 
-static int mchp_corespi_transfer_one(struct spi_master *master,
+static int mchp_corespi_transfer_one(struct spi_controller *host,
 				     struct spi_device *spi_dev,
 				     struct spi_transfer *xfer)
 {
-	struct mchp_corespi *spi = spi_master_get_devdata(master);
+	struct mchp_corespi *spi = spi_controller_get_devdata(host);
 	int ret;
 
 	ret = mchp_corespi_calculate_clkgen(spi, (unsigned long)xfer->speed_hz);
 	if (ret) {
-		dev_err(&master->dev, "failed to set clk_gen for target %u Hz\n", xfer->speed_hz);
+		dev_err(&host->dev, "failed to set clk_gen for target %u Hz\n", xfer->speed_hz);
 		return ret;
 	}
 
@@ -484,11 +484,11 @@ static int mchp_corespi_transfer_one(struct spi_master *master,
 	return 1;
 }
 
-static int mchp_corespi_prepare_message(struct spi_master *master,
+static int mchp_corespi_prepare_message(struct spi_controller *host,
 					struct spi_message *msg)
 {
 	struct spi_device *spi_dev = msg->spi;
-	struct mchp_corespi *spi = spi_master_get_devdata(master);
+	struct mchp_corespi *spi = spi_controller_get_devdata(host);
 
 	mchp_corespi_set_framesize(spi, DEFAULT_FRAMESIZE);
 	mchp_corespi_set_mode(spi, spi_dev->mode);
@@ -498,32 +498,32 @@ static int mchp_corespi_prepare_message(struct spi_master *master,
 
 static int mchp_corespi_probe(struct platform_device *pdev)
 {
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct mchp_corespi *spi;
 	struct resource *res;
 	u32 num_cs;
 	int ret = 0;
 
-	master = devm_spi_alloc_master(&pdev->dev, sizeof(*spi));
-	if (!master)
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*spi));
+	if (!host)
 		return dev_err_probe(&pdev->dev, -ENOMEM,
-				     "unable to allocate master for SPI controller\n");
+				     "unable to allocate host for SPI controller\n");
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 
 	if (of_property_read_u32(pdev->dev.of_node, "num-cs", &num_cs))
 		num_cs = MAX_CS;
 
-	master->num_chipselect = num_cs;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
-	master->setup = mchp_corespi_setup;
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->transfer_one = mchp_corespi_transfer_one;
-	master->prepare_message = mchp_corespi_prepare_message;
-	master->set_cs = mchp_corespi_set_cs;
-	master->dev.of_node = pdev->dev.of_node;
+	host->num_chipselect = num_cs;
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	host->setup = mchp_corespi_setup;
+	host->bits_per_word_mask = SPI_BPW_MASK(8);
+	host->transfer_one = mchp_corespi_transfer_one;
+	host->prepare_message = mchp_corespi_prepare_message;
+	host->set_cs = mchp_corespi_set_cs;
+	host->dev.of_node = pdev->dev.of_node;
 
-	spi = spi_master_get_devdata(master);
+	spi = spi_controller_get_devdata(host);
 
 	spi->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(spi->regs))
@@ -534,7 +534,7 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 		return spi->irq;
 
 	ret = devm_request_irq(&pdev->dev, spi->irq, mchp_corespi_interrupt,
-			       IRQF_SHARED, dev_name(&pdev->dev), master);
+			       IRQF_SHARED, dev_name(&pdev->dev), host);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
 				     "could not request irq\n");
@@ -549,25 +549,25 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret,
 				     "failed to enable clock\n");
 
-	mchp_corespi_init(master, spi);
+	mchp_corespi_init(host, spi);
 
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = devm_spi_register_controller(&pdev->dev, host);
 	if (ret) {
 		mchp_corespi_disable(spi);
 		clk_disable_unprepare(spi->clk);
 		return dev_err_probe(&pdev->dev, ret,
-				     "unable to register master for SPI controller\n");
+				     "unable to register host for SPI controller\n");
 	}
 
-	dev_info(&pdev->dev, "Registered SPI controller %d\n", master->bus_num);
+	dev_info(&pdev->dev, "Registered SPI controller %d\n", host->bus_num);
 
 	return 0;
 }
 
 static void mchp_corespi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master  = platform_get_drvdata(pdev);
-	struct mchp_corespi *spi = spi_master_get_devdata(master);
+	struct spi_controller *host  = platform_get_drvdata(pdev);
+	struct mchp_corespi *spi = spi_controller_get_devdata(host);
 
 	mchp_corespi_disable_ints(spi);
 	clk_disable_unprepare(spi->clk);
-- 
2.25.1

