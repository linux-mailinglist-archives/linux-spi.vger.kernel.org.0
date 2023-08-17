Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEAD77F012
	for <lists+linux-spi@lfdr.de>; Thu, 17 Aug 2023 07:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348083AbjHQFIB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Aug 2023 01:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348089AbjHQFHj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Aug 2023 01:07:39 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5AC2698
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 22:07:37 -0700 (PDT)
Received: from dggpemm500012.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RRCb167RNztSDb;
        Thu, 17 Aug 2023 13:03:57 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 17 Aug 2023 13:07:35 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 17 Aug
 2023 13:07:34 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v2 22/23] spi: sifive: switch to use modern name
Date:   Thu, 17 Aug 2023 13:03:31 +0800
Message-ID: <20230817050332.1274751-23-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230817050332.1274751-1-yangyingliang@huawei.com>
References: <20230817050332.1274751-1-yangyingliang@huawei.com>
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
 drivers/spi/spi-sifive.c | 80 ++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
index 2f77dae85386..cfd17bbb2202 100644
--- a/drivers/spi/spi-sifive.c
+++ b/drivers/spi/spi-sifive.c
@@ -128,9 +128,9 @@ static void sifive_spi_init(struct sifive_spi *spi)
 }
 
 static int
-sifive_spi_prepare_message(struct spi_master *master, struct spi_message *msg)
+sifive_spi_prepare_message(struct spi_controller *host, struct spi_message *msg)
 {
-	struct sifive_spi *spi = spi_master_get_devdata(master);
+	struct sifive_spi *spi = spi_controller_get_devdata(host);
 	struct spi_device *device = msg->spi;
 
 	/* Update the chip select polarity */
@@ -152,7 +152,7 @@ sifive_spi_prepare_message(struct spi_master *master, struct spi_message *msg)
 
 static void sifive_spi_set_cs(struct spi_device *device, bool is_high)
 {
-	struct sifive_spi *spi = spi_master_get_devdata(device->master);
+	struct sifive_spi *spi = spi_controller_get_devdata(device->controller);
 
 	/* Reverse polarity is handled by SCMR/CPOL. Not inverted CS. */
 	if (device->mode & SPI_CS_HIGH)
@@ -252,10 +252,10 @@ static void sifive_spi_rx(struct sifive_spi *spi, u8 *rx_ptr)
 }
 
 static int
-sifive_spi_transfer_one(struct spi_master *master, struct spi_device *device,
+sifive_spi_transfer_one(struct spi_controller *host, struct spi_device *device,
 			struct spi_transfer *t)
 {
-	struct sifive_spi *spi = spi_master_get_devdata(master);
+	struct sifive_spi *spi = spi_controller_get_devdata(host);
 	int poll = sifive_spi_prep_transfer(spi, device, t);
 	const u8 *tx_ptr = t->tx_buf;
 	u8 *rx_ptr = t->rx_buf;
@@ -294,35 +294,35 @@ static int sifive_spi_probe(struct platform_device *pdev)
 	struct sifive_spi *spi;
 	int ret, irq, num_cs;
 	u32 cs_bits, max_bits_per_word;
-	struct spi_master *master;
+	struct spi_controller *host;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(struct sifive_spi));
-	if (!master) {
+	host = spi_alloc_host(&pdev->dev, sizeof(struct sifive_spi));
+	if (!host) {
 		dev_err(&pdev->dev, "out of memory\n");
 		return -ENOMEM;
 	}
 
-	spi = spi_master_get_devdata(master);
+	spi = spi_controller_get_devdata(host);
 	init_completion(&spi->done);
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 
 	spi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(spi->regs)) {
 		ret = PTR_ERR(spi->regs);
-		goto put_master;
+		goto put_host;
 	}
 
 	spi->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(spi->clk)) {
 		dev_err(&pdev->dev, "Unable to find bus clock\n");
 		ret = PTR_ERR(spi->clk);
-		goto put_master;
+		goto put_host;
 	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = irq;
-		goto put_master;
+		goto put_host;
 	}
 
 	/* Optional parameters */
@@ -339,14 +339,14 @@ static int sifive_spi_probe(struct platform_device *pdev)
 	if (!ret && max_bits_per_word < 8) {
 		dev_err(&pdev->dev, "Only 8bit SPI words supported by the driver\n");
 		ret = -EINVAL;
-		goto put_master;
+		goto put_host;
 	}
 
 	/* Spin up the bus clock before hitting registers */
 	ret = clk_prepare_enable(spi->clk);
 	if (ret) {
 		dev_err(&pdev->dev, "Unable to enable bus clock\n");
-		goto put_master;
+		goto put_host;
 	}
 
 	/* probe the number of CS lines */
@@ -362,30 +362,30 @@ static int sifive_spi_probe(struct platform_device *pdev)
 
 	num_cs = ilog2(cs_bits) + 1;
 	if (num_cs > SIFIVE_SPI_MAX_CS) {
-		dev_err(&pdev->dev, "Invalid number of spi slaves\n");
+		dev_err(&pdev->dev, "Invalid number of spi targets\n");
 		ret = -EINVAL;
 		goto disable_clk;
 	}
 
-	/* Define our master */
-	master->dev.of_node = pdev->dev.of_node;
-	master->bus_num = pdev->id;
-	master->num_chipselect = num_cs;
-	master->mode_bits = SPI_CPHA | SPI_CPOL
+	/* Define our host */
+	host->dev.of_node = pdev->dev.of_node;
+	host->bus_num = pdev->id;
+	host->num_chipselect = num_cs;
+	host->mode_bits = SPI_CPHA | SPI_CPOL
 			  | SPI_CS_HIGH | SPI_LSB_FIRST
 			  | SPI_TX_DUAL | SPI_TX_QUAD
 			  | SPI_RX_DUAL | SPI_RX_QUAD;
 	/* TODO: add driver support for bits_per_word < 8
 	 * we need to "left-align" the bits (unless SPI_LSB_FIRST)
 	 */
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->flags = SPI_CONTROLLER_MUST_TX | SPI_CONTROLLER_GPIO_SS;
-	master->prepare_message = sifive_spi_prepare_message;
-	master->set_cs = sifive_spi_set_cs;
-	master->transfer_one = sifive_spi_transfer_one;
+	host->bits_per_word_mask = SPI_BPW_MASK(8);
+	host->flags = SPI_CONTROLLER_MUST_TX | SPI_CONTROLLER_GPIO_SS;
+	host->prepare_message = sifive_spi_prepare_message;
+	host->set_cs = sifive_spi_set_cs;
+	host->transfer_one = sifive_spi_transfer_one;
 
 	pdev->dev.dma_mask = NULL;
-	/* Configure the SPI master hardware */
+	/* Configure the SPI host hardware */
 	sifive_spi_init(spi);
 
 	/* Register for SPI Interrupt */
@@ -397,11 +397,11 @@ static int sifive_spi_probe(struct platform_device *pdev)
 	}
 
 	dev_info(&pdev->dev, "mapped; irq=%d, cs=%d\n",
-		 irq, master->num_chipselect);
+		 irq, host->num_chipselect);
 
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = devm_spi_register_controller(&pdev->dev, host);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "spi_register_master failed\n");
+		dev_err(&pdev->dev, "spi_register_host failed\n");
 		goto disable_clk;
 	}
 
@@ -409,16 +409,16 @@ static int sifive_spi_probe(struct platform_device *pdev)
 
 disable_clk:
 	clk_disable_unprepare(spi->clk);
-put_master:
-	spi_master_put(master);
+put_host:
+	spi_controller_put(host);
 
 	return ret;
 }
 
 static void sifive_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct sifive_spi *spi = spi_master_get_devdata(master);
+	struct spi_controller *host = platform_get_drvdata(pdev);
+	struct sifive_spi *spi = spi_controller_get_devdata(host);
 
 	/* Disable all the interrupts just in case */
 	sifive_spi_write(spi, SIFIVE_SPI_REG_IE, 0);
@@ -427,11 +427,11 @@ static void sifive_spi_remove(struct platform_device *pdev)
 
 static int sifive_spi_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct sifive_spi *spi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct sifive_spi *spi = spi_controller_get_devdata(host);
 	int ret;
 
-	ret = spi_master_suspend(master);
+	ret = spi_controller_suspend(host);
 	if (ret)
 		return ret;
 
@@ -445,14 +445,14 @@ static int sifive_spi_suspend(struct device *dev)
 
 static int sifive_spi_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct sifive_spi *spi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct sifive_spi *spi = spi_controller_get_devdata(host);
 	int ret;
 
 	ret = clk_prepare_enable(spi->clk);
 	if (ret)
 		return ret;
-	ret = spi_master_resume(master);
+	ret = spi_controller_resume(host);
 	if (ret)
 		clk_disable_unprepare(spi->clk);
 
-- 
2.25.1

