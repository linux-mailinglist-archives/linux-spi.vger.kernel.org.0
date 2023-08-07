Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB03772479
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 14:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbjHGMoV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 08:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbjHGMoN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 08:44:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEA7170A
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 05:44:10 -0700 (PDT)
Received: from dggpemm100018.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKGBc4ZnRztRwp;
        Mon,  7 Aug 2023 20:40:40 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100018.china.huawei.com (7.185.36.206) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 20:44:07 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 20:44:07 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 02/20] spi: au1550: switch to use modern name
Date:   Mon, 7 Aug 2023 20:40:47 +0800
Message-ID: <20230807124105.3429709-3-yangyingliang@huawei.com>
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

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-au1550.c | 74 ++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/spi/spi-au1550.c b/drivers/spi/spi-au1550.c
index 0b57e6afce0f..1011b1a8f241 100644
--- a/drivers/spi/spi-au1550.c
+++ b/drivers/spi/spi-au1550.c
@@ -54,7 +54,7 @@ struct au1550_spi {
 	int (*txrx_bufs)(struct spi_device *spi, struct spi_transfer *t);
 	irqreturn_t (*irq_callback)(struct au1550_spi *hw);
 
-	struct completion master_done;
+	struct completion host_done;
 
 	unsigned int usedma;
 	u32 dma_tx_id;
@@ -66,7 +66,7 @@ struct au1550_spi {
 	unsigned int dma_rx_tmpbuf_size;
 	u32 dma_rx_tmpbuf_addr;
 
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct device *dev;
 	struct au1550_spi_info *pdata;
 	struct resource *ioarea;
@@ -159,7 +159,7 @@ static void au1550_spi_reset_fifos(struct au1550_spi *hw)
  */
 static void au1550_spi_chipsel(struct spi_device *spi, int value)
 {
-	struct au1550_spi *hw = spi_master_get_devdata(spi->master);
+	struct au1550_spi *hw = spi_controller_get_devdata(spi->controller);
 	unsigned int cspol = spi->mode & SPI_CS_HIGH ? 1 : 0;
 	u32 cfg, stat;
 
@@ -219,7 +219,7 @@ static void au1550_spi_chipsel(struct spi_device *spi, int value)
 
 static int au1550_spi_setupxfer(struct spi_device *spi, struct spi_transfer *t)
 {
-	struct au1550_spi *hw = spi_master_get_devdata(spi->master);
+	struct au1550_spi *hw = spi_controller_get_devdata(spi->controller);
 	unsigned int bpw, hz;
 	u32 cfg, stat;
 
@@ -272,7 +272,7 @@ static int au1550_spi_setupxfer(struct spi_device *spi, struct spi_transfer *t)
  * no reliable way how to recognize that spi transfer is done
  * dma complete callbacks are called before real spi transfer is finished
  * and if only tx dma channel is set up (and rx fifo overflow event masked)
- * spi master done event irq is not generated unless rx fifo is empty (emptied)
+ * spi host done event irq is not generated unless rx fifo is empty (emptied)
  * so we need rx tmp buffer to use for rx dma if user does not provide one
  */
 static int au1550_spi_dma_rxtmp_alloc(struct au1550_spi *hw, unsigned int size)
@@ -303,7 +303,7 @@ static void au1550_spi_dma_rxtmp_free(struct au1550_spi *hw)
 
 static int au1550_spi_dma_txrxb(struct spi_device *spi, struct spi_transfer *t)
 {
-	struct au1550_spi *hw = spi_master_get_devdata(spi->master);
+	struct au1550_spi *hw = spi_controller_get_devdata(spi->controller);
 	dma_addr_t dma_tx_addr;
 	dma_addr_t dma_rx_addr;
 	u32 res;
@@ -387,7 +387,7 @@ static int au1550_spi_dma_txrxb(struct spi_device *spi, struct spi_transfer *t)
 	hw->regs->psc_spipcr = PSC_SPIPCR_MS;
 	wmb(); /* drain writebuffer */
 
-	wait_for_completion(&hw->master_done);
+	wait_for_completion(&hw->host_done);
 
 	au1xxx_dbdma_stop(hw->dma_tx_ch);
 	au1xxx_dbdma_stop(hw->dma_rx_ch);
@@ -449,7 +449,7 @@ static irqreturn_t au1550_spi_dma_irq_callback(struct au1550_spi *hw)
 				"dma transfer: unexpected SPI error (event=0x%x stat=0x%x)!\n",
 				evnt, stat);
 
-		complete(&hw->master_done);
+		complete(&hw->host_done);
 		return IRQ_HANDLED;
 	}
 
@@ -458,7 +458,7 @@ static irqreturn_t au1550_spi_dma_irq_callback(struct au1550_spi *hw)
 		au1550_spi_mask_ack_all(hw);
 		hw->rx_count = hw->len;
 		hw->tx_count = hw->len;
-		complete(&hw->master_done);
+		complete(&hw->host_done);
 	}
 	return IRQ_HANDLED;
 }
@@ -502,7 +502,7 @@ AU1550_SPI_TX_WORD(32, 0xffffff)
 static int au1550_spi_pio_txrxb(struct spi_device *spi, struct spi_transfer *t)
 {
 	u32 stat, mask;
-	struct au1550_spi *hw = spi_master_get_devdata(spi->master);
+	struct au1550_spi *hw = spi_controller_get_devdata(spi->controller);
 
 	hw->tx = t->tx_buf;
 	hw->rx = t->rx_buf;
@@ -537,7 +537,7 @@ static int au1550_spi_pio_txrxb(struct spi_device *spi, struct spi_transfer *t)
 	hw->regs->psc_spipcr = PSC_SPIPCR_MS;
 	wmb(); /* drain writebuffer */
 
-	wait_for_completion(&hw->master_done);
+	wait_for_completion(&hw->host_done);
 
 	return min(hw->rx_count, hw->tx_count);
 }
@@ -568,7 +568,7 @@ static irqreturn_t au1550_spi_pio_irq_callback(struct au1550_spi *hw)
 		dev_err(hw->dev,
 			"pio transfer: unexpected SPI error (event=0x%x stat=0x%x)!\n",
 			evnt, stat);
-		complete(&hw->master_done);
+		complete(&hw->host_done);
 		return IRQ_HANDLED;
 	}
 
@@ -605,11 +605,11 @@ static irqreturn_t au1550_spi_pio_irq_callback(struct au1550_spi *hw)
 	/*
 	 * Restart the SPI transmission in case of a transmit underflow.
 	 * This seems to work despite the notes in the Au1550 data book
-	 * of Figure 8-4 with flowchart for SPI master operation:
+	 * of Figure 8-4 with flowchart for SPI host operation:
 	 *
 	 * """Note 1: An XFR Error Interrupt occurs, unless masked,
 	 * for any of the following events: Tx FIFO Underflow,
-	 * Rx FIFO Overflow, or Multiple-master Error
+	 * Rx FIFO Overflow, or Multiple-host Error
 	 *    Note 2: In case of a Tx Underflow Error, all zeroes are
 	 * transmitted."""
 	 *
@@ -627,14 +627,14 @@ static irqreturn_t au1550_spi_pio_irq_callback(struct au1550_spi *hw)
 	if (hw->rx_count >= hw->len) {
 		/* transfer completed successfully */
 		au1550_spi_mask_ack_all(hw);
-		complete(&hw->master_done);
+		complete(&hw->host_done);
 	}
 	return IRQ_HANDLED;
 }
 
 static int au1550_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 {
-	struct au1550_spi *hw = spi_master_get_devdata(spi->master);
+	struct au1550_spi *hw = spi_controller_get_devdata(spi->controller);
 
 	return hw->txrx_bufs(spi, t);
 }
@@ -723,24 +723,24 @@ static void au1550_spi_setup_psc_as_spi(struct au1550_spi *hw)
 static int au1550_spi_probe(struct platform_device *pdev)
 {
 	struct au1550_spi *hw;
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct resource *r;
 	int err = 0;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(struct au1550_spi));
-	if (master == NULL) {
-		dev_err(&pdev->dev, "No memory for spi_master\n");
+	host = spi_alloc_host(&pdev->dev, sizeof(struct au1550_spi));
+	if (host == NULL) {
+		dev_err(&pdev->dev, "No memory for spi_controller\n");
 		err = -ENOMEM;
 		goto err_nomem;
 	}
 
 	/* the spi->mode bits understood by this driver: */
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
-	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 24);
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
+	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 24);
 
-	hw = spi_master_get_devdata(master);
+	hw = spi_controller_get_devdata(host);
 
-	hw->master = master;
+	hw->host = host;
 	hw->pdata = dev_get_platdata(&pdev->dev);
 	hw->dev = &pdev->dev;
 
@@ -798,9 +798,9 @@ static int au1550_spi_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, hw);
 
-	init_completion(&hw->master_done);
+	init_completion(&hw->host_done);
 
-	hw->bitbang.master = hw->master;
+	hw->bitbang.master = hw->host;
 	hw->bitbang.setup_transfer = au1550_spi_setupxfer;
 	hw->bitbang.chipselect = au1550_spi_chipsel;
 	hw->bitbang.txrx_bufs = au1550_spi_txrx_bufs;
@@ -858,8 +858,8 @@ static int au1550_spi_probe(struct platform_device *pdev)
 		goto err_no_irq;
 	}
 
-	master->bus_num = pdev->id;
-	master->num_chipselect = hw->pdata->num_chipselect;
+	host->bus_num = pdev->id;
+	host->num_chipselect = hw->pdata->num_chipselect;
 
 	/*
 	 *  precompute valid range for spi freq - from au1550 datasheet:
@@ -874,8 +874,8 @@ static int au1550_spi_probe(struct platform_device *pdev)
 		int min_div = (2 << 0) * (2 * (4 + 1));
 		int max_div = (2 << 3) * (2 * (63 + 1));
 
-		master->max_speed_hz = hw->pdata->mainclk_hz / min_div;
-		master->min_speed_hz =
+		host->max_speed_hz = hw->pdata->mainclk_hz / min_div;
+		host->min_speed_hz =
 				hw->pdata->mainclk_hz / (max_div + 1) + 1;
 	}
 
@@ -883,13 +883,13 @@ static int au1550_spi_probe(struct platform_device *pdev)
 
 	err = spi_bitbang_start(&hw->bitbang);
 	if (err) {
-		dev_err(&pdev->dev, "Failed to register SPI master\n");
+		dev_err(&pdev->dev, "Failed to register SPI host\n");
 		goto err_register;
 	}
 
 	dev_info(&pdev->dev,
-		"spi master registered: bus_num=%d num_chipselect=%d\n",
-		master->bus_num, master->num_chipselect);
+		"spi host registered: bus_num=%d num_chipselect=%d\n",
+		host->bus_num, host->num_chipselect);
 
 	return 0;
 
@@ -917,7 +917,7 @@ static int au1550_spi_probe(struct platform_device *pdev)
 
 err_no_iores:
 err_no_pdata:
-	spi_master_put(hw->master);
+	spi_controller_put(hw->host);
 
 err_nomem:
 	return err;
@@ -927,8 +927,8 @@ static void au1550_spi_remove(struct platform_device *pdev)
 {
 	struct au1550_spi *hw = platform_get_drvdata(pdev);
 
-	dev_info(&pdev->dev, "spi master remove: bus_num=%d\n",
-		hw->master->bus_num);
+	dev_info(&pdev->dev, "spi host remove: bus_num=%d\n",
+		hw->host->bus_num);
 
 	spi_bitbang_stop(&hw->bitbang);
 	free_irq(hw->irq, hw);
@@ -941,7 +941,7 @@ static void au1550_spi_remove(struct platform_device *pdev)
 		au1xxx_dbdma_chan_free(hw->dma_tx_ch);
 	}
 
-	spi_master_put(hw->master);
+	spi_controller_put(hw->host);
 }
 
 /* work with hotplug and coldplug */
-- 
2.25.1

