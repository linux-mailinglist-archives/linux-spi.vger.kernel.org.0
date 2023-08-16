Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C9C77DD8B
	for <lists+linux-spi@lfdr.de>; Wed, 16 Aug 2023 11:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243472AbjHPJnh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Aug 2023 05:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243436AbjHPJn1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Aug 2023 05:43:27 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD3426AD
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 02:43:25 -0700 (PDT)
Received: from dggpemm100005.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RQjmT43GwzFqfv;
        Wed, 16 Aug 2023 17:40:25 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100005.china.huawei.com (7.185.36.231) with Microsoft SMTP Server
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
Subject: [PATCH -next 05/24] spi: spl022: switch to use modern name
Date:   Wed, 16 Aug 2023 17:39:54 +0800
Message-ID: <20230816094013.1275068-6-yangyingliang@huawei.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-pl022.c | 96 ++++++++++++++++++++---------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 1af75eff26b6..a123bad1faba 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * A driver for the ARM PL022 PrimeCell SSP/SPI bus master.
+ * A driver for the ARM PL022 PrimeCell SSP/SPI bus host.
  *
  * Copyright (C) 2008-2012 ST-Ericsson AB
  * Copyright (C) 2006 STMicroelectronics Pvt. Ltd.
@@ -336,8 +336,8 @@ struct vendor_data {
  * @phybase: the physical memory where the SSP device resides
  * @virtbase: the virtual memory where the SSP is mapped
  * @clk: outgoing clock "SPICLK" for the SPI bus
- * @master: SPI framework hookup
- * @master_info: controller-specific data from machine setup
+ * @host: SPI framework hookup
+ * @host_info: controller-specific data from machine setup
  * @pump_transfers: Tasklet used in Interrupt Transfer mode
  * @cur_msg: Pointer to current spi_message being processed
  * @cur_transfer: Pointer to current spi_transfer
@@ -370,8 +370,8 @@ struct pl022 {
 	resource_size_t			phybase;
 	void __iomem			*virtbase;
 	struct clk			*clk;
-	struct spi_master		*master;
-	struct pl022_ssp_controller	*master_info;
+	struct spi_controller		*host;
+	struct pl022_ssp_controller	*host_info;
 	/* Message per-transfer pump */
 	struct tasklet_struct		pump_transfers;
 	struct spi_message		*cur_msg;
@@ -500,7 +500,7 @@ static void giveback(struct pl022 *pl022)
 		 * could invalidate the cs_control() callback...
 		 */
 		/* get a pointer to the next message, if any */
-		next_msg = spi_get_next_queued_message(pl022->master);
+		next_msg = spi_get_next_queued_message(pl022->host);
 
 		/*
 		 * see if the next and current messages point
@@ -523,7 +523,7 @@ static void giveback(struct pl022 *pl022)
 	writew((readw(SSP_CR1(pl022->virtbase)) &
 		(~SSP_CR1_MASK_SSE)), SSP_CR1(pl022->virtbase));
 
-	spi_finalize_current_message(pl022->master);
+	spi_finalize_current_message(pl022->host);
 }
 
 /**
@@ -1110,16 +1110,16 @@ static int pl022_dma_probe(struct pl022 *pl022)
 	 * of them.
 	 */
 	pl022->dma_rx_channel = dma_request_channel(mask,
-					    pl022->master_info->dma_filter,
-					    pl022->master_info->dma_rx_param);
+					    pl022->host_info->dma_filter,
+					    pl022->host_info->dma_rx_param);
 	if (!pl022->dma_rx_channel) {
 		dev_dbg(&pl022->adev->dev, "no RX DMA channel!\n");
 		goto err_no_rxchan;
 	}
 
 	pl022->dma_tx_channel = dma_request_channel(mask,
-					    pl022->master_info->dma_filter,
-					    pl022->master_info->dma_tx_param);
+					    pl022->host_info->dma_filter,
+					    pl022->host_info->dma_tx_param);
 	if (!pl022->dma_tx_channel) {
 		dev_dbg(&pl022->adev->dev, "no TX DMA channel!\n");
 		goto err_no_txchan;
@@ -1573,10 +1573,10 @@ static void do_polling_transfer(struct pl022 *pl022)
 	return;
 }
 
-static int pl022_transfer_one_message(struct spi_master *master,
+static int pl022_transfer_one_message(struct spi_controller *host,
 				      struct spi_message *msg)
 {
-	struct pl022 *pl022 = spi_master_get_devdata(master);
+	struct pl022 *pl022 = spi_controller_get_devdata(host);
 
 	/* Initial message state */
 	pl022->cur_msg = msg;
@@ -1602,9 +1602,9 @@ static int pl022_transfer_one_message(struct spi_master *master,
 	return 0;
 }
 
-static int pl022_unprepare_transfer_hardware(struct spi_master *master)
+static int pl022_unprepare_transfer_hardware(struct spi_controller *host)
 {
-	struct pl022 *pl022 = spi_master_get_devdata(master);
+	struct pl022 *pl022 = spi_controller_get_devdata(host);
 
 	/* nothing more to do - disable spi/ssp and power off */
 	writew((readw(SSP_CR1(pl022->virtbase)) &
@@ -1826,10 +1826,10 @@ static const struct pl022_config_chip pl022_default_chip_info = {
 };
 
 /**
- * pl022_setup - setup function registered to SPI master framework
+ * pl022_setup - setup function registered to SPI host framework
  * @spi: spi device which is requesting setup
  *
- * This function is registered to the SPI framework for this SPI master
+ * This function is registered to the SPI framework for this SPI host
  * controller. If it is the first time when setup is called by this device,
  * this function will initialize the runtime state for this chip and save
  * the same in the device structure. Else it will update the runtime info
@@ -1844,7 +1844,7 @@ static int pl022_setup(struct spi_device *spi)
 	struct chip_data *chip;
 	struct ssp_clock_params clk_freq = { .cpsdvsr = 0, .scr = 0};
 	int status = 0;
-	struct pl022 *pl022 = spi_master_get_devdata(spi->master);
+	struct pl022 *pl022 = spi_controller_get_devdata(spi->controller);
 	unsigned int bits = spi->bits_per_word;
 	u32 tmp;
 	struct device_node *np = spi->dev.of_node;
@@ -1964,7 +1964,7 @@ static int pl022_setup(struct spi_device *spi)
 	chip->dmacr = 0;
 	chip->cpsr = 0;
 	if ((chip_info->com_mode == DMA_TRANSFER)
-	    && ((pl022->master_info)->enable_dma)) {
+	    && ((pl022->host_info)->enable_dma)) {
 		chip->enable_dma = true;
 		dev_dbg(&spi->dev, "DMA mode set in controller state\n");
 		SSP_WRITE_BITS(chip->dmacr, SSP_DMA_ENABLED,
@@ -2061,10 +2061,10 @@ static int pl022_setup(struct spi_device *spi)
 }
 
 /**
- * pl022_cleanup - cleanup function registered to SPI master framework
+ * pl022_cleanup - cleanup function registered to SPI host framework
  * @spi: spi device which is requesting cleanup
  *
- * This function is registered to the SPI framework for this SPI master
+ * This function is registered to the SPI framework for this SPI host
  * controller. It will free the runtime state of chip.
  */
 static void pl022_cleanup(struct spi_device *spi)
@@ -2103,7 +2103,7 @@ static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
 	struct device *dev = &adev->dev;
 	struct pl022_ssp_controller *platform_info =
 			dev_get_platdata(&adev->dev);
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct pl022 *pl022 = NULL;	/*Data for this driver */
 	int status = 0;
 
@@ -2117,16 +2117,16 @@ static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
 		return -ENODEV;
 	}
 
-	/* Allocate master with space for data */
-	master = spi_alloc_master(dev, sizeof(struct pl022));
-	if (master == NULL) {
-		dev_err(&adev->dev, "probe - cannot alloc SPI master\n");
+	/* Allocate host with space for data */
+	host = spi_alloc_host(dev, sizeof(struct pl022));
+	if (host == NULL) {
+		dev_err(&adev->dev, "probe - cannot alloc SPI host\n");
 		return -ENOMEM;
 	}
 
-	pl022 = spi_master_get_devdata(master);
-	pl022->master = master;
-	pl022->master_info = platform_info;
+	pl022 = spi_controller_get_devdata(host);
+	pl022->host = host;
+	pl022->host_info = platform_info;
 	pl022->adev = adev;
 	pl022->vendor = id->data;
 
@@ -2134,25 +2134,25 @@ static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
 	 * Bus Number Which has been Assigned to this SSP controller
 	 * on this board
 	 */
-	master->bus_num = platform_info->bus_id;
-	master->cleanup = pl022_cleanup;
-	master->setup = pl022_setup;
-	master->auto_runtime_pm = true;
-	master->transfer_one_message = pl022_transfer_one_message;
-	master->unprepare_transfer_hardware = pl022_unprepare_transfer_hardware;
-	master->rt = platform_info->rt;
-	master->dev.of_node = dev->of_node;
-	master->use_gpio_descriptors = true;
+	host->bus_num = platform_info->bus_id;
+	host->cleanup = pl022_cleanup;
+	host->setup = pl022_setup;
+	host->auto_runtime_pm = true;
+	host->transfer_one_message = pl022_transfer_one_message;
+	host->unprepare_transfer_hardware = pl022_unprepare_transfer_hardware;
+	host->rt = platform_info->rt;
+	host->dev.of_node = dev->of_node;
+	host->use_gpio_descriptors = true;
 
 	/*
 	 * Supports mode 0-3, loopback, and active low CS. Transfers are
 	 * always MS bit first on the original pl022.
 	 */
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
 	if (pl022->vendor->extended_cr)
-		master->mode_bits |= SPI_LSB_FIRST;
+		host->mode_bits |= SPI_LSB_FIRST;
 
-	dev_dbg(&adev->dev, "BUSNO: %d\n", master->bus_num);
+	dev_dbg(&adev->dev, "BUSNO: %d\n", host->bus_num);
 
 	status = amba_request_regions(adev, NULL);
 	if (status)
@@ -2215,10 +2215,10 @@ static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
 
 	/* Register with the SPI framework */
 	amba_set_drvdata(adev, pl022);
-	status = devm_spi_register_master(&adev->dev, master);
+	status = devm_spi_register_controller(&adev->dev, host);
 	if (status != 0) {
 		dev_err_probe(&adev->dev, status,
-			      "problem registering spi master\n");
+			      "problem registering spi host\n");
 		goto err_spi_register;
 	}
 	dev_dbg(dev, "probe succeeded\n");
@@ -2246,7 +2246,7 @@ static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
  err_no_ioremap:
 	amba_release_regions(adev);
  err_no_ioregion:
-	spi_master_put(master);
+	spi_controller_put(host);
 	return status;
 }
 
@@ -2265,7 +2265,7 @@ pl022_remove(struct amba_device *adev)
 	pm_runtime_get_noresume(&adev->dev);
 
 	load_ssp_default_config(pl022);
-	if (pl022->master_info->enable_dma)
+	if (pl022->host_info->enable_dma)
 		pl022_dma_remove(pl022);
 
 	clk_disable_unprepare(pl022->clk);
@@ -2279,13 +2279,13 @@ static int pl022_suspend(struct device *dev)
 	struct pl022 *pl022 = dev_get_drvdata(dev);
 	int ret;
 
-	ret = spi_master_suspend(pl022->master);
+	ret = spi_controller_suspend(pl022->host);
 	if (ret)
 		return ret;
 
 	ret = pm_runtime_force_suspend(dev);
 	if (ret) {
-		spi_master_resume(pl022->master);
+		spi_controller_resume(pl022->host);
 		return ret;
 	}
 
@@ -2305,7 +2305,7 @@ static int pl022_resume(struct device *dev)
 		dev_err(dev, "problem resuming\n");
 
 	/* Start the queue running */
-	ret = spi_master_resume(pl022->master);
+	ret = spi_controller_resume(pl022->host);
 	if (!ret)
 		dev_dbg(dev, "resumed\n");
 
-- 
2.25.1

