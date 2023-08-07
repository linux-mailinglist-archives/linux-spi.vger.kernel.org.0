Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7769077248C
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 14:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbjHGMoe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 08:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbjHGMo0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 08:44:26 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A321989
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 05:44:17 -0700 (PDT)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RKGFQ1FLFz1KCNc;
        Mon,  7 Aug 2023 20:43:06 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 20:44:14 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 20:44:14 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 20/20] spi: lantiq: switch to use modern name
Date:   Mon, 7 Aug 2023 20:41:05 +0800
Message-ID: <20230807124105.3429709-21-yangyingliang@huawei.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master/slave to modern name host/target or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-lantiq-ssc.c | 96 ++++++++++++++++++------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/spi/spi-lantiq-ssc.c b/drivers/spi/spi-lantiq-ssc.c
index 65568272cfd9..938e9e577e4f 100644
--- a/drivers/spi/spi-lantiq-ssc.c
+++ b/drivers/spi/spi-lantiq-ssc.c
@@ -92,7 +92,7 @@
 #define LTQ_SPI_STAT_RE		BIT(9)	/* Receive error flag */
 #define LTQ_SPI_STAT_TE		BIT(8)	/* Transmit error flag */
 #define LTQ_SPI_STAT_ME		BIT(7)	/* Mode error flag */
-#define LTQ_SPI_STAT_MS		BIT(1)	/* Master/slave select bit */
+#define LTQ_SPI_STAT_MS		BIT(1)	/* Host/target select bit */
 #define LTQ_SPI_STAT_EN		BIT(0)	/* Enable bit */
 #define LTQ_SPI_STAT_ERRORS	(LTQ_SPI_STAT_ME | LTQ_SPI_STAT_TE | \
 				 LTQ_SPI_STAT_RE | LTQ_SPI_STAT_AE | \
@@ -110,8 +110,8 @@
 #define LTQ_SPI_WHBSTATE_CLRME	BIT(6)	/* Clear mode error flag */
 #define LTQ_SPI_WHBSTATE_SETRUE	BIT(5)	/* Set receive underflow error flag */
 #define LTQ_SPI_WHBSTATE_CLRRUE	BIT(4)	/* Clear receive underflow error flag */
-#define LTQ_SPI_WHBSTATE_SETMS	BIT(3)	/* Set master select bit */
-#define LTQ_SPI_WHBSTATE_CLRMS	BIT(2)	/* Clear master select bit */
+#define LTQ_SPI_WHBSTATE_SETMS	BIT(3)	/* Set host select bit */
+#define LTQ_SPI_WHBSTATE_CLRMS	BIT(2)	/* Clear host select bit */
 #define LTQ_SPI_WHBSTATE_SETEN	BIT(1)	/* Set enable bit (operational mode) */
 #define LTQ_SPI_WHBSTATE_CLREN	BIT(0)	/* Clear enable bit (config mode */
 #define LTQ_SPI_WHBSTATE_CLR_ERRORS	(LTQ_SPI_WHBSTATE_CLRRUE | \
@@ -163,7 +163,7 @@ struct lantiq_ssc_hwcfg {
 };
 
 struct lantiq_ssc_spi {
-	struct spi_master		*master;
+	struct spi_controller		*host;
 	struct device			*dev;
 	void __iomem			*regbase;
 	struct clk			*spi_clk;
@@ -367,7 +367,7 @@ static void lantiq_ssc_hw_init(const struct lantiq_ssc_spi *spi)
 	hw_setup_bits_per_word(spi, spi->bits_per_word);
 	hw_setup_clock_mode(spi, SPI_MODE_0);
 
-	/* Enable master mode and clear error flags */
+	/* Enable host mode and clear error flags */
 	lantiq_ssc_writel(spi, LTQ_SPI_WHBSTATE_SETMS |
 			       LTQ_SPI_WHBSTATE_CLR_ERRORS,
 			       LTQ_SPI_WHBSTATE);
@@ -387,8 +387,8 @@ static void lantiq_ssc_hw_init(const struct lantiq_ssc_spi *spi)
 
 static int lantiq_ssc_setup(struct spi_device *spidev)
 {
-	struct spi_master *master = spidev->master;
-	struct lantiq_ssc_spi *spi = spi_master_get_devdata(master);
+	struct spi_controller *host = spidev->controller;
+	struct lantiq_ssc_spi *spi = spi_controller_get_devdata(host);
 	unsigned int cs = spi_get_chipselect(spidev, 0);
 	u32 gpocon;
 
@@ -416,10 +416,10 @@ static int lantiq_ssc_setup(struct spi_device *spidev)
 	return 0;
 }
 
-static int lantiq_ssc_prepare_message(struct spi_master *master,
+static int lantiq_ssc_prepare_message(struct spi_controller *host,
 				      struct spi_message *message)
 {
-	struct lantiq_ssc_spi *spi = spi_master_get_devdata(master);
+	struct lantiq_ssc_spi *spi = spi_controller_get_devdata(host);
 
 	hw_enter_config_mode(spi);
 	hw_setup_clock_mode(spi, message->spi->mode);
@@ -461,10 +461,10 @@ static void hw_setup_transfer(struct lantiq_ssc_spi *spi,
 	lantiq_ssc_writel(spi, con, LTQ_SPI_CON);
 }
 
-static int lantiq_ssc_unprepare_message(struct spi_master *master,
+static int lantiq_ssc_unprepare_message(struct spi_controller *host,
 					struct spi_message *message)
 {
-	struct lantiq_ssc_spi *spi = spi_master_get_devdata(master);
+	struct lantiq_ssc_spi *spi = spi_controller_get_devdata(host);
 
 	flush_workqueue(spi->wq);
 
@@ -693,8 +693,8 @@ static irqreturn_t lantiq_ssc_err_interrupt(int irq, void *data)
 	lantiq_ssc_maskl(spi, 0, LTQ_SPI_WHBSTATE_CLR_ERRORS, LTQ_SPI_WHBSTATE);
 
 	/* set bad status so it can be retried */
-	if (spi->master->cur_msg)
-		spi->master->cur_msg->status = -EIO;
+	if (spi->host->cur_msg)
+		spi->host->cur_msg->status = -EIO;
 	queue_work(spi->wq, &spi->work);
 	spin_unlock(&spi->lock);
 
@@ -772,22 +772,22 @@ static void lantiq_ssc_bussy_work(struct work_struct *work)
 		u32 stat = lantiq_ssc_readl(spi, LTQ_SPI_STAT);
 
 		if (!(stat & LTQ_SPI_STAT_BSY)) {
-			spi_finalize_current_transfer(spi->master);
+			spi_finalize_current_transfer(spi->host);
 			return;
 		}
 
 		cond_resched();
 	} while (!time_after_eq(jiffies, end));
 
-	if (spi->master->cur_msg)
-		spi->master->cur_msg->status = -EIO;
-	spi_finalize_current_transfer(spi->master);
+	if (spi->host->cur_msg)
+		spi->host->cur_msg->status = -EIO;
+	spi_finalize_current_transfer(spi->host);
 }
 
-static void lantiq_ssc_handle_err(struct spi_master *master,
+static void lantiq_ssc_handle_err(struct spi_controller *host,
 				  struct spi_message *message)
 {
-	struct lantiq_ssc_spi *spi = spi_master_get_devdata(master);
+	struct lantiq_ssc_spi *spi = spi_controller_get_devdata(host);
 
 	/* flush FIFOs on timeout */
 	rx_fifo_flush(spi);
@@ -796,7 +796,7 @@ static void lantiq_ssc_handle_err(struct spi_master *master,
 
 static void lantiq_ssc_set_cs(struct spi_device *spidev, bool enable)
 {
-	struct lantiq_ssc_spi *spi = spi_master_get_devdata(spidev->master);
+	struct lantiq_ssc_spi *spi = spi_controller_get_devdata(spidev->controller);
 	unsigned int cs = spi_get_chipselect(spidev, 0);
 	u32 fgpo;
 
@@ -808,11 +808,11 @@ static void lantiq_ssc_set_cs(struct spi_device *spidev, bool enable)
 	lantiq_ssc_writel(spi, fgpo, LTQ_SPI_FPGO);
 }
 
-static int lantiq_ssc_transfer_one(struct spi_master *master,
+static int lantiq_ssc_transfer_one(struct spi_controller *host,
 				   struct spi_device *spidev,
 				   struct spi_transfer *t)
 {
-	struct lantiq_ssc_spi *spi = spi_master_get_devdata(master);
+	struct lantiq_ssc_spi *spi = spi_controller_get_devdata(host);
 
 	hw_setup_transfer(spi, spidev, t);
 
@@ -904,7 +904,7 @@ MODULE_DEVICE_TABLE(of, lantiq_ssc_match);
 static int lantiq_ssc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct lantiq_ssc_spi *spi;
 	const struct lantiq_ssc_hwcfg *hwcfg;
 	u32 id, supports_dma, revision;
@@ -913,33 +913,33 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 
 	hwcfg = of_device_get_match_data(dev);
 
-	master = spi_alloc_master(dev, sizeof(struct lantiq_ssc_spi));
-	if (!master)
+	host = spi_alloc_host(dev, sizeof(struct lantiq_ssc_spi));
+	if (!host)
 		return -ENOMEM;
 
-	spi = spi_master_get_devdata(master);
-	spi->master = master;
+	spi = spi_controller_get_devdata(host);
+	spi->host = host;
 	spi->dev = dev;
 	spi->hwcfg = hwcfg;
 	platform_set_drvdata(pdev, spi);
 	spi->regbase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(spi->regbase)) {
 		err = PTR_ERR(spi->regbase);
-		goto err_master_put;
+		goto err_host_put;
 	}
 
 	err = hwcfg->cfg_irq(pdev, spi);
 	if (err)
-		goto err_master_put;
+		goto err_host_put;
 
 	spi->spi_clk = devm_clk_get(dev, "gate");
 	if (IS_ERR(spi->spi_clk)) {
 		err = PTR_ERR(spi->spi_clk);
-		goto err_master_put;
+		goto err_host_put;
 	}
 	err = clk_prepare_enable(spi->spi_clk);
 	if (err)
-		goto err_master_put;
+		goto err_host_put;
 
 	/*
 	 * Use the old clk_get_fpi() function on Lantiq platform, till it
@@ -965,19 +965,19 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 	spi->bits_per_word = 8;
 	spi->speed_hz = 0;
 
-	master->dev.of_node = pdev->dev.of_node;
-	master->num_chipselect = num_cs;
-	master->use_gpio_descriptors = true;
-	master->setup = lantiq_ssc_setup;
-	master->set_cs = lantiq_ssc_set_cs;
-	master->handle_err = lantiq_ssc_handle_err;
-	master->prepare_message = lantiq_ssc_prepare_message;
-	master->unprepare_message = lantiq_ssc_unprepare_message;
-	master->transfer_one = lantiq_ssc_transfer_one;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST | SPI_CS_HIGH |
-				SPI_LOOP;
-	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(2, 8) |
-				     SPI_BPW_MASK(16) | SPI_BPW_MASK(32);
+	host->dev.of_node = pdev->dev.of_node;
+	host->num_chipselect = num_cs;
+	host->use_gpio_descriptors = true;
+	host->setup = lantiq_ssc_setup;
+	host->set_cs = lantiq_ssc_set_cs;
+	host->handle_err = lantiq_ssc_handle_err;
+	host->prepare_message = lantiq_ssc_prepare_message;
+	host->unprepare_message = lantiq_ssc_unprepare_message;
+	host->transfer_one = lantiq_ssc_transfer_one;
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST | SPI_CS_HIGH |
+			  SPI_LOOP;
+	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(2, 8) |
+				   SPI_BPW_MASK(16) | SPI_BPW_MASK(32);
 
 	spi->wq = alloc_ordered_workqueue(dev_name(dev), WQ_MEM_RECLAIM);
 	if (!spi->wq) {
@@ -998,9 +998,9 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 		"Lantiq SSC SPI controller (Rev %i, TXFS %u, RXFS %u, DMA %u)\n",
 		revision, spi->tx_fifo_size, spi->rx_fifo_size, supports_dma);
 
-	err = devm_spi_register_master(dev, master);
+	err = devm_spi_register_controller(dev, host);
 	if (err) {
-		dev_err(dev, "failed to register spi_master\n");
+		dev_err(dev, "failed to register spi host\n");
 		goto err_wq_destroy;
 	}
 
@@ -1012,8 +1012,8 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 	clk_put(spi->fpi_clk);
 err_clk_disable:
 	clk_disable_unprepare(spi->spi_clk);
-err_master_put:
-	spi_master_put(master);
+err_host_put:
+	spi_controller_put(host);
 
 	return err;
 }
-- 
2.25.1

