Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2D1664102
	for <lists+linux-spi@lfdr.de>; Tue, 10 Jan 2023 13:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjAJM7q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Jan 2023 07:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjAJM7p (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Jan 2023 07:59:45 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACD86543
        for <linux-spi@vger.kernel.org>; Tue, 10 Jan 2023 04:59:43 -0800 (PST)
Received: from dggpemm100007.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NrrTV6d0BzJrJR;
        Tue, 10 Jan 2023 20:58:22 +0800 (CST)
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
Subject: [PATCH -next 2/3] spi: at91-usart: switch to use modern name
Date:   Tue, 10 Jan 2023 21:18:04 +0800
Message-ID: <20230110131805.2827248-3-yangyingliang@huawei.com>
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
 drivers/spi/spi-at91-usart.c | 40 ++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index 9cd738682aab..fab9d223e24a 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -38,7 +38,7 @@
 #define US_CR_TXEN		BIT(6)
 #define US_CR_TXDIS		BIT(7)
 
-#define US_MR_SPI_MASTER	0x0E
+#define US_MR_SPI_HOST		0x0E
 #define US_MR_CHRL		GENMASK(7, 6)
 #define US_MR_CPHA		BIT(8)
 #define US_MR_CPOL		BIT(16)
@@ -61,7 +61,7 @@
 #define US_OVRE_RXRDY_IRQS	(US_IR_OVRE | US_IR_RXRDY)
 
 #define US_INIT \
-	(US_MR_SPI_MASTER | US_MR_CHRL | US_MR_CLKO | US_MR_WRDBT)
+	(US_MR_SPI_HOST | US_MR_CHRL | US_MR_CLKO | US_MR_WRDBT)
 #define US_DMA_MIN_BYTES       16
 #define US_DMA_TIMEOUT         (msecs_to_jiffies(1000))
 
@@ -104,7 +104,7 @@ struct at91_usart_spi {
 static void dma_callback(void *data)
 {
 	struct spi_controller   *ctlr = data;
-	struct at91_usart_spi   *aus = spi_master_get_devdata(ctlr);
+	struct at91_usart_spi   *aus = spi_controller_get_devdata(ctlr);
 
 	at91_usart_spi_writel(aus, IER, US_IR_RXRDY);
 	aus->current_rx_remaining_bytes = 0;
@@ -115,7 +115,7 @@ static bool at91_usart_spi_can_dma(struct spi_controller *ctrl,
 				   struct spi_device *spi,
 				   struct spi_transfer *xfer)
 {
-	struct at91_usart_spi *aus = spi_master_get_devdata(ctrl);
+	struct at91_usart_spi *aus = spi_controller_get_devdata(ctrl);
 
 	return aus->use_dma && xfer->len >= US_DMA_MIN_BYTES;
 }
@@ -216,7 +216,7 @@ static void at91_usart_spi_stop_dma(struct spi_controller *ctlr)
 static int at91_usart_spi_dma_transfer(struct spi_controller *ctlr,
 				       struct spi_transfer *xfer)
 {
-	struct at91_usart_spi *aus = spi_master_get_devdata(ctlr);
+	struct at91_usart_spi *aus = spi_controller_get_devdata(ctlr);
 	struct dma_chan	 *rxchan = ctlr->dma_rx;
 	struct dma_chan *txchan = ctlr->dma_tx;
 	struct dma_async_tx_descriptor *rxdesc;
@@ -334,7 +334,7 @@ at91_usart_spi_set_xfer_speed(struct at91_usart_spi *aus,
 static irqreturn_t at91_usart_spi_interrupt(int irq, void *dev_id)
 {
 	struct spi_controller *controller = dev_id;
-	struct at91_usart_spi *aus = spi_master_get_devdata(controller);
+	struct at91_usart_spi *aus = spi_controller_get_devdata(controller);
 
 	spin_lock(&aus->lock);
 	at91_usart_spi_read_status(aus);
@@ -359,7 +359,7 @@ static irqreturn_t at91_usart_spi_interrupt(int irq, void *dev_id)
 
 static int at91_usart_spi_setup(struct spi_device *spi)
 {
-	struct at91_usart_spi *aus = spi_master_get_devdata(spi->controller);
+	struct at91_usart_spi *aus = spi_controller_get_devdata(spi->controller);
 	u32 *ausd = spi->controller_state;
 	unsigned int mr = at91_usart_spi_readl(aus, MR);
 
@@ -399,7 +399,7 @@ static int at91_usart_spi_transfer_one(struct spi_controller *ctlr,
 				       struct spi_device *spi,
 				       struct spi_transfer *xfer)
 {
-	struct at91_usart_spi *aus = spi_master_get_devdata(ctlr);
+	struct at91_usart_spi *aus = spi_controller_get_devdata(ctlr);
 	unsigned long dma_timeout = 0;
 	int ret = 0;
 
@@ -444,7 +444,7 @@ static int at91_usart_spi_transfer_one(struct spi_controller *ctlr,
 static int at91_usart_spi_prepare_message(struct spi_controller *ctlr,
 					  struct spi_message *message)
 {
-	struct at91_usart_spi *aus = spi_master_get_devdata(ctlr);
+	struct at91_usart_spi *aus = spi_controller_get_devdata(ctlr);
 	struct spi_device *spi = message->spi;
 	u32 *ausd = spi->controller_state;
 
@@ -458,7 +458,7 @@ static int at91_usart_spi_prepare_message(struct spi_controller *ctlr,
 static int at91_usart_spi_unprepare_message(struct spi_controller *ctlr,
 					    struct spi_message *message)
 {
-	struct at91_usart_spi *aus = spi_master_get_devdata(ctlr);
+	struct at91_usart_spi *aus = spi_controller_get_devdata(ctlr);
 
 	at91_usart_spi_writel(aus, CR, US_RESET | US_DISABLE);
 	at91_usart_spi_writel(aus, IDR, US_OVRE_RXRDY_IRQS);
@@ -515,7 +515,7 @@ static int at91_usart_spi_probe(struct platform_device *pdev)
 		return PTR_ERR(clk);
 
 	ret = -ENOMEM;
-	controller = spi_alloc_master(&pdev->dev, sizeof(*aus));
+	controller = spi_alloc_host(&pdev->dev, sizeof(*aus));
 	if (!controller)
 		goto at91_usart_spi_probe_fail;
 
@@ -539,7 +539,7 @@ static int at91_usart_spi_probe(struct platform_device *pdev)
 						US_MAX_CLK_DIV);
 	platform_set_drvdata(pdev, controller);
 
-	aus = spi_master_get_devdata(controller);
+	aus = spi_controller_get_devdata(controller);
 
 	aus->dev = &pdev->dev;
 	aus->regs = devm_ioremap_resource(&pdev->dev, regs);
@@ -574,9 +574,9 @@ static int at91_usart_spi_probe(struct platform_device *pdev)
 	spin_lock_init(&aus->lock);
 	init_completion(&aus->xfer_completion);
 
-	ret = devm_spi_register_master(&pdev->dev, controller);
+	ret = devm_spi_register_controller(&pdev->dev, controller);
 	if (ret)
-		goto at91_usart_fail_register_master;
+		goto at91_usart_fail_register_controller;
 
 	dev_info(&pdev->dev,
 		 "AT91 USART SPI Controller version 0x%x at %pa (irq %d)\n",
@@ -585,19 +585,19 @@ static int at91_usart_spi_probe(struct platform_device *pdev)
 
 	return 0;
 
-at91_usart_fail_register_master:
+at91_usart_fail_register_controller:
 	at91_usart_spi_release_dma(controller);
 at91_usart_fail_dma:
 	clk_disable_unprepare(clk);
 at91_usart_spi_probe_fail:
-	spi_master_put(controller);
+	spi_controller_put(controller);
 	return ret;
 }
 
 __maybe_unused static int at91_usart_spi_runtime_suspend(struct device *dev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
-	struct at91_usart_spi *aus = spi_master_get_devdata(ctlr);
+	struct at91_usart_spi *aus = spi_controller_get_devdata(ctlr);
 
 	clk_disable_unprepare(aus->clk);
 	pinctrl_pm_select_sleep_state(dev);
@@ -608,7 +608,7 @@ __maybe_unused static int at91_usart_spi_runtime_suspend(struct device *dev)
 __maybe_unused static int at91_usart_spi_runtime_resume(struct device *dev)
 {
 	struct spi_controller *ctrl = dev_get_drvdata(dev);
-	struct at91_usart_spi *aus = spi_master_get_devdata(ctrl);
+	struct at91_usart_spi *aus = spi_controller_get_devdata(ctrl);
 
 	pinctrl_pm_select_default_state(dev);
 
@@ -633,7 +633,7 @@ __maybe_unused static int at91_usart_spi_suspend(struct device *dev)
 __maybe_unused static int at91_usart_spi_resume(struct device *dev)
 {
 	struct spi_controller *ctrl = dev_get_drvdata(dev);
-	struct at91_usart_spi *aus = spi_master_get_devdata(ctrl);
+	struct at91_usart_spi *aus = spi_controller_get_devdata(ctrl);
 	int ret;
 
 	if (!pm_runtime_suspended(dev)) {
@@ -650,7 +650,7 @@ __maybe_unused static int at91_usart_spi_resume(struct device *dev)
 static int at91_usart_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr = platform_get_drvdata(pdev);
-	struct at91_usart_spi *aus = spi_master_get_devdata(ctlr);
+	struct at91_usart_spi *aus = spi_controller_get_devdata(ctlr);
 
 	at91_usart_spi_release_dma(ctlr);
 	clk_disable_unprepare(aus->clk);
-- 
2.25.1

