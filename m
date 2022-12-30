Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2FF6596BF
	for <lists+linux-spi@lfdr.de>; Fri, 30 Dec 2022 10:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbiL3JbU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Dec 2022 04:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbiL3JbS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 30 Dec 2022 04:31:18 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E797B1123
        for <linux-spi@vger.kernel.org>; Fri, 30 Dec 2022 01:31:16 -0800 (PST)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Nk0K41sLGzJpWZ;
        Fri, 30 Dec 2022 17:27:20 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 30 Dec
 2022 17:31:13 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 2/3] spi: a3700: switch to use modern name
Date:   Fri, 30 Dec 2022 17:28:05 +0800
Message-ID: <20221230092806.1687340-3-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221230092806.1687340-1-yangyingliang@huawei.com>
References: <20221230092806.1687340-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
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
 drivers/spi/spi-armada-3700.c | 98 +++++++++++++++++------------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index 9df9fc40b783..4d554b948d71 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -100,7 +100,7 @@
 #define A3700_SPI_CLK_CAPT_EDGE		BIT(7)
 
 struct a3700_spi {
-	struct spi_master *master;
+	struct spi_controller *host;
 	void __iomem *base;
 	struct clk *clk;
 	unsigned int irq;
@@ -174,7 +174,7 @@ static int a3700_spi_pin_mode_set(struct a3700_spi *a3700_spi,
 			val |= A3700_SPI_ADDR_PIN;
 		break;
 	default:
-		dev_err(&a3700_spi->master->dev, "wrong pin mode %u", pin_mode);
+		dev_err(&a3700_spi->host->dev, "wrong pin mode %u", pin_mode);
 		return -EINVAL;
 	}
 
@@ -278,7 +278,7 @@ static int a3700_spi_fifo_flush(struct a3700_spi *a3700_spi)
 
 static void a3700_spi_init(struct a3700_spi *a3700_spi)
 {
-	struct spi_master *master = a3700_spi->master;
+	struct spi_controller *host = a3700_spi->host;
 	u32 val;
 	int i;
 
@@ -295,14 +295,14 @@ static void a3700_spi_init(struct a3700_spi *a3700_spi)
 
 	/* Disable AUTO_CS and deactivate all chip-selects */
 	a3700_spi_auto_cs_unset(a3700_spi);
-	for (i = 0; i < master->num_chipselect; i++)
+	for (i = 0; i < host->num_chipselect; i++)
 		a3700_spi_deactivate_cs(a3700_spi, i);
 
 	/* Enable FIFO mode */
 	a3700_spi_fifo_mode_set(a3700_spi, true);
 
 	/* Set SPI mode */
-	a3700_spi_mode_set(a3700_spi, master->mode_bits);
+	a3700_spi_mode_set(a3700_spi, host->mode_bits);
 
 	/* Reset counters */
 	spireg_write(a3700_spi, A3700_SPI_IF_HDR_CNT_REG, 0);
@@ -315,11 +315,11 @@ static void a3700_spi_init(struct a3700_spi *a3700_spi)
 
 static irqreturn_t a3700_spi_interrupt(int irq, void *dev_id)
 {
-	struct spi_master *master = dev_id;
+	struct spi_controller *host = dev_id;
 	struct a3700_spi *a3700_spi;
 	u32 cause;
 
-	a3700_spi = spi_master_get_devdata(master);
+	a3700_spi = spi_controller_get_devdata(host);
 
 	/* Get interrupt causes */
 	cause = spireg_read(a3700_spi, A3700_SPI_INT_STAT_REG);
@@ -344,7 +344,7 @@ static bool a3700_spi_wait_completion(struct spi_device *spi)
 	unsigned int ctrl_reg;
 	unsigned long timeout_jiffies;
 
-	a3700_spi = spi_master_get_devdata(spi->master);
+	a3700_spi = spi_controller_get_devdata(spi->controller);
 
 	/* SPI interrupt is edge-triggered, which means an interrupt will
 	 * be generated only when detecting a specific status bit changed
@@ -393,7 +393,7 @@ static bool a3700_spi_transfer_wait(struct spi_device *spi,
 {
 	struct a3700_spi *a3700_spi;
 
-	a3700_spi = spi_master_get_devdata(spi->master);
+	a3700_spi = spi_controller_get_devdata(spi->controller);
 	a3700_spi->wait_mask = bit_mask;
 
 	return a3700_spi_wait_completion(spi);
@@ -417,7 +417,7 @@ static void a3700_spi_transfer_setup(struct spi_device *spi,
 {
 	struct a3700_spi *a3700_spi;
 
-	a3700_spi = spi_master_get_devdata(spi->master);
+	a3700_spi = spi_controller_get_devdata(spi->controller);
 
 	a3700_spi_clock_set(a3700_spi, xfer->speed_hz);
 
@@ -434,7 +434,7 @@ static void a3700_spi_transfer_setup(struct spi_device *spi,
 
 static void a3700_spi_set_cs(struct spi_device *spi, bool enable)
 {
-	struct a3700_spi *a3700_spi = spi_master_get_devdata(spi->master);
+	struct a3700_spi *a3700_spi = spi_controller_get_devdata(spi->controller);
 
 	if (!enable)
 		a3700_spi_activate_cs(a3700_spi, spi->chip_select);
@@ -565,10 +565,10 @@ static void a3700_spi_transfer_abort_fifo(struct a3700_spi *a3700_spi)
 	spireg_write(a3700_spi, A3700_SPI_IF_CFG_REG, val);
 }
 
-static int a3700_spi_prepare_message(struct spi_master *master,
+static int a3700_spi_prepare_message(struct spi_controller *host,
 				     struct spi_message *message)
 {
-	struct a3700_spi *a3700_spi = spi_master_get_devdata(master);
+	struct a3700_spi *a3700_spi = spi_controller_get_devdata(host);
 	struct spi_device *spi = message->spi;
 	int ret;
 
@@ -588,11 +588,11 @@ static int a3700_spi_prepare_message(struct spi_master *master,
 	return 0;
 }
 
-static int a3700_spi_transfer_one_fifo(struct spi_master *master,
+static int a3700_spi_transfer_one_fifo(struct spi_controller *host,
 				  struct spi_device *spi,
 				  struct spi_transfer *xfer)
 {
-	struct a3700_spi *a3700_spi = spi_master_get_devdata(master);
+	struct a3700_spi *a3700_spi = spi_controller_get_devdata(host);
 	int ret = 0, timeout = A3700_SPI_TIMEOUT;
 	unsigned int nbits = 0, byte_len;
 	u32 val;
@@ -732,16 +732,16 @@ static int a3700_spi_transfer_one_fifo(struct spi_master *master,
 error:
 	a3700_spi_transfer_abort_fifo(a3700_spi);
 out:
-	spi_finalize_current_transfer(master);
+	spi_finalize_current_transfer(host);
 
 	return ret;
 }
 
-static int a3700_spi_transfer_one_full_duplex(struct spi_master *master,
+static int a3700_spi_transfer_one_full_duplex(struct spi_controller *host,
 				  struct spi_device *spi,
 				  struct spi_transfer *xfer)
 {
-	struct a3700_spi *a3700_spi = spi_master_get_devdata(master);
+	struct a3700_spi *a3700_spi = spi_controller_get_devdata(host);
 	u32 val;
 
 	/* Disable FIFO mode */
@@ -777,27 +777,27 @@ static int a3700_spi_transfer_one_full_duplex(struct spi_master *master,
 
 	}
 
-	spi_finalize_current_transfer(master);
+	spi_finalize_current_transfer(host);
 
 	return 0;
 }
 
-static int a3700_spi_transfer_one(struct spi_master *master,
+static int a3700_spi_transfer_one(struct spi_controller *host,
 				  struct spi_device *spi,
 				  struct spi_transfer *xfer)
 {
 	a3700_spi_transfer_setup(spi, xfer);
 
 	if (xfer->tx_buf && xfer->rx_buf)
-		return a3700_spi_transfer_one_full_duplex(master, spi, xfer);
+		return a3700_spi_transfer_one_full_duplex(host, spi, xfer);
 
-	return a3700_spi_transfer_one_fifo(master, spi, xfer);
+	return a3700_spi_transfer_one_fifo(host, spi, xfer);
 }
 
-static int a3700_spi_unprepare_message(struct spi_master *master,
+static int a3700_spi_unprepare_message(struct spi_controller *host,
 				       struct spi_message *message)
 {
-	struct a3700_spi *a3700_spi = spi_master_get_devdata(master);
+	struct a3700_spi *a3700_spi = spi_controller_get_devdata(host);
 
 	clk_disable(a3700_spi->clk);
 
@@ -815,14 +815,14 @@ static int a3700_spi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *of_node = dev->of_node;
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct a3700_spi *spi;
 	u32 num_cs = 0;
 	int irq, ret = 0;
 
-	master = spi_alloc_master(dev, sizeof(*spi));
-	if (!master) {
-		dev_err(dev, "master allocation failed\n");
+	host = spi_alloc_host(dev, sizeof(*spi));
+	if (!host) {
+		dev_err(dev, "host allocation failed\n");
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -833,23 +833,23 @@ static int a3700_spi_probe(struct platform_device *pdev)
 		goto error;
 	}
 
-	master->bus_num = pdev->id;
-	master->dev.of_node = of_node;
-	master->mode_bits = SPI_MODE_3;
-	master->num_chipselect = num_cs;
-	master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(32);
-	master->prepare_message =  a3700_spi_prepare_message;
-	master->transfer_one = a3700_spi_transfer_one;
-	master->unprepare_message = a3700_spi_unprepare_message;
-	master->set_cs = a3700_spi_set_cs;
-	master->mode_bits |= (SPI_RX_DUAL | SPI_TX_DUAL |
+	host->bus_num = pdev->id;
+	host->dev.of_node = of_node;
+	host->mode_bits = SPI_MODE_3;
+	host->num_chipselect = num_cs;
+	host->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(32);
+	host->prepare_message =  a3700_spi_prepare_message;
+	host->transfer_one = a3700_spi_transfer_one;
+	host->unprepare_message = a3700_spi_unprepare_message;
+	host->set_cs = a3700_spi_set_cs;
+	host->mode_bits |= (SPI_RX_DUAL | SPI_TX_DUAL |
 			      SPI_RX_QUAD | SPI_TX_QUAD);
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 
-	spi = spi_master_get_devdata(master);
+	spi = spi_controller_get_devdata(host);
 
-	spi->master = master;
+	spi->host = host;
 
 	spi->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(spi->base)) {
@@ -878,23 +878,23 @@ static int a3700_spi_probe(struct platform_device *pdev)
 		goto error;
 	}
 
-	master->max_speed_hz = min_t(unsigned long, A3700_SPI_MAX_SPEED_HZ,
+	host->max_speed_hz = min_t(unsigned long, A3700_SPI_MAX_SPEED_HZ,
 					clk_get_rate(spi->clk));
-	master->min_speed_hz = DIV_ROUND_UP(clk_get_rate(spi->clk),
+	host->min_speed_hz = DIV_ROUND_UP(clk_get_rate(spi->clk),
 						A3700_SPI_MAX_PRESCALE);
 
 	a3700_spi_init(spi);
 
 	ret = devm_request_irq(dev, spi->irq, a3700_spi_interrupt, 0,
-			       dev_name(dev), master);
+			       dev_name(dev), host);
 	if (ret) {
 		dev_err(dev, "could not request IRQ: %d\n", ret);
 		goto error_clk;
 	}
 
-	ret = devm_spi_register_master(dev, master);
+	ret = devm_spi_register_controller(dev, host);
 	if (ret) {
-		dev_err(dev, "Failed to register master\n");
+		dev_err(dev, "Failed to register host\n");
 		goto error_clk;
 	}
 
@@ -903,15 +903,15 @@ static int a3700_spi_probe(struct platform_device *pdev)
 error_clk:
 	clk_unprepare(spi->clk);
 error:
-	spi_master_put(master);
+	spi_controller_put(host);
 out:
 	return ret;
 }
 
 static int a3700_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct a3700_spi *spi = spi_master_get_devdata(master);
+	struct spi_controller *host = platform_get_drvdata(pdev);
+	struct a3700_spi *spi = spi_controller_get_devdata(host);
 
 	clk_unprepare(spi->clk);
 
-- 
2.25.1

