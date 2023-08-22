Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345CB783774
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 03:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjHVBir (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Aug 2023 21:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjHVBip (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Aug 2023 21:38:45 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E5E189
        for <linux-spi@vger.kernel.org>; Mon, 21 Aug 2023 18:38:42 -0700 (PDT)
Received: from dggpemm100016.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RVBm840lrzrSXY;
        Tue, 22 Aug 2023 09:37:12 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100016.china.huawei.com (7.185.36.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 22 Aug 2023 09:38:40 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 09:38:40 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 09/24] spi: synquacer: switch to use modern name
Date:   Tue, 22 Aug 2023 09:34:56 +0800
Message-ID: <20230822013511.4161475-10-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230822013511.4161475-1-yangyingliang@huawei.com>
References: <20230822013511.4161475-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-synquacer.c | 82 ++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/spi/spi-synquacer.c b/drivers/spi/spi-synquacer.c
index aeaf7db022f0..7cb4301a6fb2 100644
--- a/drivers/spi/spi-synquacer.c
+++ b/drivers/spi/spi-synquacer.c
@@ -225,11 +225,11 @@ static int write_fifo(struct synquacer_spi *sspi)
 	return 0;
 }
 
-static int synquacer_spi_config(struct spi_master *master,
+static int synquacer_spi_config(struct spi_controller *host,
 				struct spi_device *spi,
 				struct spi_transfer *xfer)
 {
-	struct synquacer_spi *sspi = spi_master_get_devdata(master);
+	struct synquacer_spi *sspi = spi_controller_get_devdata(host);
 	unsigned int speed, mode, bpw, cs, bus_width, transfer_mode;
 	u32 rate, val, div;
 
@@ -263,7 +263,7 @@ static int synquacer_spi_config(struct spi_master *master,
 	}
 
 	sspi->transfer_mode = transfer_mode;
-	rate = master->max_speed_hz;
+	rate = host->max_speed_hz;
 
 	div = DIV_ROUND_UP(rate, speed);
 	if (div > 254) {
@@ -350,11 +350,11 @@ static int synquacer_spi_config(struct spi_master *master,
 	return 0;
 }
 
-static int synquacer_spi_transfer_one(struct spi_master *master,
+static int synquacer_spi_transfer_one(struct spi_controller *host,
 				      struct spi_device *spi,
 				      struct spi_transfer *xfer)
 {
-	struct synquacer_spi *sspi = spi_master_get_devdata(master);
+	struct synquacer_spi *sspi = spi_controller_get_devdata(host);
 	int ret;
 	int status = 0;
 	u32 words;
@@ -378,7 +378,7 @@ static int synquacer_spi_transfer_one(struct spi_master *master,
 	if (bpw == 8 && !(xfer->len % 4) && !(spi->mode & SPI_LSB_FIRST))
 		xfer->bits_per_word = 32;
 
-	ret = synquacer_spi_config(master, spi, xfer);
+	ret = synquacer_spi_config(host, spi, xfer);
 
 	/* restore */
 	xfer->bits_per_word = bpw;
@@ -482,7 +482,7 @@ static int synquacer_spi_transfer_one(struct spi_master *master,
 
 static void synquacer_spi_set_cs(struct spi_device *spi, bool enable)
 {
-	struct synquacer_spi *sspi = spi_master_get_devdata(spi->master);
+	struct synquacer_spi *sspi = spi_controller_get_devdata(spi->controller);
 	u32 val;
 
 	val = readl(sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
@@ -517,11 +517,11 @@ static int synquacer_spi_wait_status_update(struct synquacer_spi *sspi,
 	return -EBUSY;
 }
 
-static int synquacer_spi_enable(struct spi_master *master)
+static int synquacer_spi_enable(struct spi_controller *host)
 {
 	u32 val;
 	int status;
-	struct synquacer_spi *sspi = spi_master_get_devdata(master);
+	struct synquacer_spi *sspi = spi_controller_get_devdata(host);
 
 	/* Disable module */
 	writel(0, sspi->regs + SYNQUACER_HSSPI_REG_MCTRL);
@@ -601,18 +601,18 @@ static irqreturn_t sq_spi_tx_handler(int irq, void *priv)
 static int synquacer_spi_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct synquacer_spi *sspi;
 	int ret;
 	int rx_irq, tx_irq;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*sspi));
-	if (!master)
+	host = spi_alloc_host(&pdev->dev, sizeof(*sspi));
+	if (!host)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 
-	sspi = spi_master_get_devdata(master);
+	sspi = spi_controller_get_devdata(host);
 	sspi->dev = &pdev->dev;
 
 	init_completion(&sspi->transfer_done);
@@ -625,7 +625,7 @@ static int synquacer_spi_probe(struct platform_device *pdev)
 
 	sspi->clk_src_type = SYNQUACER_HSSPI_CLOCK_SRC_IHCLK; /* Default */
 	device_property_read_u32(&pdev->dev, "socionext,ihclk-rate",
-				 &master->max_speed_hz); /* for ACPI */
+				 &host->max_speed_hz); /* for ACPI */
 
 	if (dev_of_node(&pdev->dev)) {
 		if (device_property_match_string(&pdev->dev,
@@ -655,21 +655,21 @@ static int synquacer_spi_probe(struct platform_device *pdev)
 			goto put_spi;
 		}
 
-		master->max_speed_hz = clk_get_rate(sspi->clk);
+		host->max_speed_hz = clk_get_rate(sspi->clk);
 	}
 
-	if (!master->max_speed_hz) {
+	if (!host->max_speed_hz) {
 		dev_err(&pdev->dev, "missing clock source\n");
 		ret = -EINVAL;
 		goto disable_clk;
 	}
-	master->min_speed_hz = master->max_speed_hz / 254;
+	host->min_speed_hz = host->max_speed_hz / 254;
 
 	sspi->aces = device_property_read_bool(&pdev->dev,
 					       "socionext,set-aces");
 	sspi->rtm = device_property_read_bool(&pdev->dev, "socionext,use-rtm");
 
-	master->num_chipselect = SYNQUACER_HSSPI_NUM_CHIP_SELECT;
+	host->num_chipselect = SYNQUACER_HSSPI_NUM_CHIP_SELECT;
 
 	rx_irq = platform_get_irq(pdev, 0);
 	if (rx_irq <= 0) {
@@ -699,27 +699,27 @@ static int synquacer_spi_probe(struct platform_device *pdev)
 		goto disable_clk;
 	}
 
-	master->dev.of_node = np;
-	master->dev.fwnode = pdev->dev.fwnode;
-	master->auto_runtime_pm = true;
-	master->bus_num = pdev->id;
+	host->dev.of_node = np;
+	host->dev.fwnode = pdev->dev.fwnode;
+	host->auto_runtime_pm = true;
+	host->bus_num = pdev->id;
 
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_TX_DUAL | SPI_RX_DUAL |
-			    SPI_TX_QUAD | SPI_RX_QUAD;
-	master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(24) |
-				     SPI_BPW_MASK(16) | SPI_BPW_MASK(8);
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_TX_DUAL | SPI_RX_DUAL |
+			  SPI_TX_QUAD | SPI_RX_QUAD;
+	host->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(24) |
+				   SPI_BPW_MASK(16) | SPI_BPW_MASK(8);
 
-	master->set_cs = synquacer_spi_set_cs;
-	master->transfer_one = synquacer_spi_transfer_one;
+	host->set_cs = synquacer_spi_set_cs;
+	host->transfer_one = synquacer_spi_transfer_one;
 
-	ret = synquacer_spi_enable(master);
+	ret = synquacer_spi_enable(host);
 	if (ret)
 		goto disable_clk;
 
 	pm_runtime_set_active(sspi->dev);
 	pm_runtime_enable(sspi->dev);
 
-	ret = devm_spi_register_master(sspi->dev, master);
+	ret = devm_spi_register_controller(sspi->dev, host);
 	if (ret)
 		goto disable_pm;
 
@@ -730,15 +730,15 @@ static int synquacer_spi_probe(struct platform_device *pdev)
 disable_clk:
 	clk_disable_unprepare(sspi->clk);
 put_spi:
-	spi_master_put(master);
+	spi_controller_put(host);
 
 	return ret;
 }
 
 static void synquacer_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct synquacer_spi *sspi = spi_master_get_devdata(master);
+	struct spi_controller *host = platform_get_drvdata(pdev);
+	struct synquacer_spi *sspi = spi_controller_get_devdata(host);
 
 	pm_runtime_disable(sspi->dev);
 
@@ -747,11 +747,11 @@ static void synquacer_spi_remove(struct platform_device *pdev)
 
 static int __maybe_unused synquacer_spi_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct synquacer_spi *sspi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct synquacer_spi *sspi = spi_controller_get_devdata(host);
 	int ret;
 
-	ret = spi_master_suspend(master);
+	ret = spi_controller_suspend(host);
 	if (ret)
 		return ret;
 
@@ -763,8 +763,8 @@ static int __maybe_unused synquacer_spi_suspend(struct device *dev)
 
 static int __maybe_unused synquacer_spi_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct synquacer_spi *sspi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct synquacer_spi *sspi = spi_controller_get_devdata(host);
 	int ret;
 
 	if (!pm_runtime_suspended(dev)) {
@@ -778,7 +778,7 @@ static int __maybe_unused synquacer_spi_resume(struct device *dev)
 			return ret;
 		}
 
-		ret = synquacer_spi_enable(master);
+		ret = synquacer_spi_enable(host);
 		if (ret) {
 			clk_disable_unprepare(sspi->clk);
 			dev_err(dev, "failed to enable spi (%d)\n", ret);
@@ -786,7 +786,7 @@ static int __maybe_unused synquacer_spi_resume(struct device *dev)
 		}
 	}
 
-	ret = spi_master_resume(master);
+	ret = spi_controller_resume(host);
 	if (ret < 0)
 		clk_disable_unprepare(sspi->clk);
 
-- 
2.25.1

