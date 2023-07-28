Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0997668F6
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jul 2023 11:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbjG1JfP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jul 2023 05:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbjG1JfL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Jul 2023 05:35:11 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8E21739
        for <linux-spi@vger.kernel.org>; Fri, 28 Jul 2023 02:35:09 -0700 (PDT)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RC2V55vl3zLnxq;
        Fri, 28 Jul 2023 17:32:29 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 17:35:06 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 17:35:06 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 06/21] spi: bcm2835aux: switch to use modern name
Date:   Fri, 28 Jul 2023 17:32:06 +0800
Message-ID: <20230728093221.3312026-7-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728093221.3312026-1-yangyingliang@huawei.com>
References: <20230728093221.3312026-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
 drivers/spi/spi-bcm2835aux.c | 84 ++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 8ace417c0a29..172b534390b2 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -231,8 +231,8 @@ static void bcm2835aux_spi_transfer_helper(struct bcm2835aux_spi *bs)
 
 static irqreturn_t bcm2835aux_spi_interrupt(int irq, void *dev_id)
 {
-	struct spi_master *master = dev_id;
-	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_id;
+	struct bcm2835aux_spi *bs = spi_controller_get_devdata(host);
 
 	/* IRQ may be shared, so return if our interrupts are disabled */
 	if (!(bcm2835aux_rd(bs, BCM2835_AUX_SPI_CNTL1) &
@@ -251,17 +251,17 @@ static irqreturn_t bcm2835aux_spi_interrupt(int irq, void *dev_id)
 	/* and if rx_len is 0 then disable interrupts and wake up completion */
 	if (!bs->rx_len) {
 		bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL1, bs->cntl[1]);
-		spi_finalize_current_transfer(master);
+		spi_finalize_current_transfer(host);
 	}
 
 	return IRQ_HANDLED;
 }
 
-static int __bcm2835aux_spi_transfer_one_irq(struct spi_master *master,
+static int __bcm2835aux_spi_transfer_one_irq(struct spi_controller *host,
 					     struct spi_device *spi,
 					     struct spi_transfer *tfr)
 {
-	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
+	struct bcm2835aux_spi *bs = spi_controller_get_devdata(host);
 
 	/* enable interrupts */
 	bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL1, bs->cntl[1] |
@@ -272,11 +272,11 @@ static int __bcm2835aux_spi_transfer_one_irq(struct spi_master *master,
 	return 1;
 }
 
-static int bcm2835aux_spi_transfer_one_irq(struct spi_master *master,
+static int bcm2835aux_spi_transfer_one_irq(struct spi_controller *host,
 					   struct spi_device *spi,
 					   struct spi_transfer *tfr)
 {
-	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
+	struct bcm2835aux_spi *bs = spi_controller_get_devdata(host);
 
 	/* update statistics */
 	bs->count_transfer_irq++;
@@ -294,14 +294,14 @@ static int bcm2835aux_spi_transfer_one_irq(struct spi_master *master,
 	}
 
 	/* now run the interrupt mode */
-	return __bcm2835aux_spi_transfer_one_irq(master, spi, tfr);
+	return __bcm2835aux_spi_transfer_one_irq(host, spi, tfr);
 }
 
-static int bcm2835aux_spi_transfer_one_poll(struct spi_master *master,
+static int bcm2835aux_spi_transfer_one_poll(struct spi_controller *host,
 					    struct spi_device *spi,
 					struct spi_transfer *tfr)
 {
-	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
+	struct bcm2835aux_spi *bs = spi_controller_get_devdata(host);
 	unsigned long timeout;
 
 	/* update statistics */
@@ -328,7 +328,7 @@ static int bcm2835aux_spi_transfer_one_poll(struct spi_master *master,
 					    bs->tx_len, bs->rx_len);
 			/* forward to interrupt handler */
 			bs->count_transfer_irq_after_poll++;
-			return __bcm2835aux_spi_transfer_one_irq(master,
+			return __bcm2835aux_spi_transfer_one_irq(host,
 							       spi, tfr);
 		}
 	}
@@ -337,11 +337,11 @@ static int bcm2835aux_spi_transfer_one_poll(struct spi_master *master,
 	return 0;
 }
 
-static int bcm2835aux_spi_transfer_one(struct spi_master *master,
+static int bcm2835aux_spi_transfer_one(struct spi_controller *host,
 				       struct spi_device *spi,
 				       struct spi_transfer *tfr)
 {
-	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
+	struct bcm2835aux_spi *bs = spi_controller_get_devdata(host);
 	unsigned long spi_hz, clk_hz, speed;
 	unsigned long hz_per_byte, byte_limit;
 
@@ -392,17 +392,17 @@ static int bcm2835aux_spi_transfer_one(struct spi_master *master,
 
 	/* run in polling mode for short transfers */
 	if (tfr->len < byte_limit)
-		return bcm2835aux_spi_transfer_one_poll(master, spi, tfr);
+		return bcm2835aux_spi_transfer_one_poll(host, spi, tfr);
 
 	/* run in interrupt mode for all others */
-	return bcm2835aux_spi_transfer_one_irq(master, spi, tfr);
+	return bcm2835aux_spi_transfer_one_irq(host, spi, tfr);
 }
 
-static int bcm2835aux_spi_prepare_message(struct spi_master *master,
+static int bcm2835aux_spi_prepare_message(struct spi_controller *host,
 					  struct spi_message *msg)
 {
 	struct spi_device *spi = msg->spi;
-	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
+	struct bcm2835aux_spi *bs = spi_controller_get_devdata(host);
 
 	bs->cntl[0] = BCM2835_AUX_SPI_CNTL0_ENABLE |
 		      BCM2835_AUX_SPI_CNTL0_VAR_WIDTH |
@@ -422,20 +422,20 @@ static int bcm2835aux_spi_prepare_message(struct spi_master *master,
 	return 0;
 }
 
-static int bcm2835aux_spi_unprepare_message(struct spi_master *master,
+static int bcm2835aux_spi_unprepare_message(struct spi_controller *host,
 					    struct spi_message *msg)
 {
-	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
+	struct bcm2835aux_spi *bs = spi_controller_get_devdata(host);
 
 	bcm2835aux_spi_reset_hw(bs);
 
 	return 0;
 }
 
-static void bcm2835aux_spi_handle_err(struct spi_master *master,
+static void bcm2835aux_spi_handle_err(struct spi_controller *host,
 				      struct spi_message *msg)
 {
-	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
+	struct bcm2835aux_spi *bs = spi_controller_get_devdata(host);
 
 	bcm2835aux_spi_reset_hw(bs);
 }
@@ -473,18 +473,18 @@ static int bcm2835aux_spi_setup(struct spi_device *spi)
 
 static int bcm2835aux_spi_probe(struct platform_device *pdev)
 {
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct bcm2835aux_spi *bs;
 	unsigned long clk_hz;
 	int err;
 
-	master = devm_spi_alloc_master(&pdev->dev, sizeof(*bs));
-	if (!master)
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*bs));
+	if (!host)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, master);
-	master->mode_bits = (SPI_CPOL | SPI_CS_HIGH | SPI_NO_CS);
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
+	platform_set_drvdata(pdev, host);
+	host->mode_bits = (SPI_CPOL | SPI_CS_HIGH | SPI_NO_CS);
+	host->bits_per_word_mask = SPI_BPW_MASK(8);
 	/* even though the driver never officially supported native CS
 	 * allow a single native CS for legacy DT support purposes when
 	 * no cs-gpio is configured.
@@ -496,16 +496,16 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 	 * * cs_delay_usec: cs is always deasserted one SCK cycle after
 	 *     a spi_transfer
 	 */
-	master->num_chipselect = 1;
-	master->setup = bcm2835aux_spi_setup;
-	master->transfer_one = bcm2835aux_spi_transfer_one;
-	master->handle_err = bcm2835aux_spi_handle_err;
-	master->prepare_message = bcm2835aux_spi_prepare_message;
-	master->unprepare_message = bcm2835aux_spi_unprepare_message;
-	master->dev.of_node = pdev->dev.of_node;
-	master->use_gpio_descriptors = true;
+	host->num_chipselect = 1;
+	host->setup = bcm2835aux_spi_setup;
+	host->transfer_one = bcm2835aux_spi_transfer_one;
+	host->handle_err = bcm2835aux_spi_handle_err;
+	host->prepare_message = bcm2835aux_spi_prepare_message;
+	host->unprepare_message = bcm2835aux_spi_unprepare_message;
+	host->dev.of_node = pdev->dev.of_node;
+	host->use_gpio_descriptors = true;
 
-	bs = spi_master_get_devdata(master);
+	bs = spi_controller_get_devdata(host);
 
 	/* the main area */
 	bs->regs = devm_platform_ioremap_resource(pdev, 0);
@@ -544,15 +544,15 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 	err = devm_request_irq(&pdev->dev, bs->irq,
 			       bcm2835aux_spi_interrupt,
 			       IRQF_SHARED,
-			       dev_name(&pdev->dev), master);
+			       dev_name(&pdev->dev), host);
 	if (err) {
 		dev_err(&pdev->dev, "could not request IRQ: %d\n", err);
 		goto out_clk_disable;
 	}
 
-	err = spi_register_master(master);
+	err = spi_register_controller(host);
 	if (err) {
-		dev_err(&pdev->dev, "could not register SPI master: %d\n", err);
+		dev_err(&pdev->dev, "could not register SPI host: %d\n", err);
 		goto out_clk_disable;
 	}
 
@@ -567,12 +567,12 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 
 static void bcm2835aux_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
+	struct spi_controller *host = platform_get_drvdata(pdev);
+	struct bcm2835aux_spi *bs = spi_controller_get_devdata(host);
 
 	bcm2835aux_debugfs_remove(bs);
 
-	spi_unregister_master(master);
+	spi_unregister_controller(host);
 
 	bcm2835aux_spi_reset_hw(bs);
 
-- 
2.25.1

