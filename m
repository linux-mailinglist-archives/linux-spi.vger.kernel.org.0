Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32784783781
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 03:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjHVBi7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Aug 2023 21:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjHVBit (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Aug 2023 21:38:49 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A994C110
        for <linux-spi@vger.kernel.org>; Mon, 21 Aug 2023 18:38:46 -0700 (PDT)
Received: from dggpemm100006.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RVBjf1kNHztS9D;
        Tue, 22 Aug 2023 09:35:02 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100006.china.huawei.com (7.185.36.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 22 Aug 2023 09:38:44 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 09:38:44 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 20/24] spi: xilinx: switch to use modern name
Date:   Tue, 22 Aug 2023 09:35:07 +0800
Message-ID: <20230822013511.4161475-21-yangyingliang@huawei.com>
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

Change legacy name master/slave to modern name host/target or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-xilinx.c | 58 ++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 8e6e3876aa9a..12355957be97 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Xilinx SPI controller driver (master mode only)
+ * Xilinx SPI controller driver (host mode only)
  *
  * Author: MontaVista Software, Inc.
  *	source@mvista.com
@@ -83,7 +83,7 @@ struct xilinx_spi {
 	void __iomem	*regs;	/* virt. address of the control registers */
 
 	int		irq;
-	bool force_irq;		/* force irq to setup master inhibit */
+	bool force_irq;		/* force irq to setup host inhibit */
 	u8 *rx_ptr;		/* pointer in the Tx buffer */
 	const u8 *tx_ptr;	/* pointer in the Rx buffer */
 	u8 bytes_per_word;
@@ -174,10 +174,10 @@ static void xspi_init_hw(struct xilinx_spi *xspi)
 			regs_base + XIPIF_V123B_IIER_OFFSET);
 	/* Disable the global IPIF interrupt */
 	xspi->write_fn(0, regs_base + XIPIF_V123B_DGIER_OFFSET);
-	/* Deselect the slave on the SPI bus */
+	/* Deselect the Target on the SPI bus */
 	xspi->write_fn(0xffff, regs_base + XSPI_SSR_OFFSET);
-	/* Disable the transmitter, enable Manual Slave Select Assertion,
-	 * put SPI controller into master mode, and enable it */
+	/* Disable the transmitter, enable Manual Target Select Assertion,
+	 * put SPI controller into host mode, and enable it */
 	xspi->write_fn(XSPI_CR_MANUAL_SSELECT |	XSPI_CR_MASTER_MODE |
 		XSPI_CR_ENABLE | XSPI_CR_TXFIFO_RESET |	XSPI_CR_RXFIFO_RESET,
 		regs_base + XSPI_CR_OFFSET);
@@ -185,12 +185,12 @@ static void xspi_init_hw(struct xilinx_spi *xspi)
 
 static void xilinx_spi_chipselect(struct spi_device *spi, int is_on)
 {
-	struct xilinx_spi *xspi = spi_master_get_devdata(spi->master);
+	struct xilinx_spi *xspi = spi_controller_get_devdata(spi->controller);
 	u16 cr;
 	u32 cs;
 
 	if (is_on == BITBANG_CS_INACTIVE) {
-		/* Deselect the slave on the SPI bus */
+		/* Deselect the target on the SPI bus */
 		xspi->write_fn(xspi->cs_inactive, xspi->regs + XSPI_SSR_OFFSET);
 		return;
 	}
@@ -225,7 +225,7 @@ static void xilinx_spi_chipselect(struct spi_device *spi, int is_on)
 static int xilinx_spi_setup_transfer(struct spi_device *spi,
 		struct spi_transfer *t)
 {
-	struct xilinx_spi *xspi = spi_master_get_devdata(spi->master);
+	struct xilinx_spi *xspi = spi_controller_get_devdata(spi->controller);
 
 	if (spi->mode & SPI_CS_HIGH)
 		xspi->cs_inactive &= ~BIT(spi_get_chipselect(spi, 0));
@@ -237,7 +237,7 @@ static int xilinx_spi_setup_transfer(struct spi_device *spi,
 
 static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 {
-	struct xilinx_spi *xspi = spi_master_get_devdata(spi->master);
+	struct xilinx_spi *xspi = spi_controller_get_devdata(spi->controller);
 	int remaining_words;	/* the number of words left to transfer */
 	bool use_irq = false;
 	u16 cr = 0;
@@ -335,9 +335,9 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 }
 
 
-/* This driver supports single master mode only. Hence Tx FIFO Empty
+/* This driver supports single host mode only. Hence Tx FIFO Empty
  * is the only interrupt we care about.
- * Receive FIFO Overrun, Transmit FIFO Underrun, Mode Fault, and Slave Mode
+ * Receive FIFO Overrun, Transmit FIFO Underrun, Mode Fault, and Target Mode
  * Fault are not to happen.
  */
 static irqreturn_t xilinx_spi_irq(int irq, void *dev_id)
@@ -393,7 +393,7 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 	struct xspi_platform_data *pdata;
 	struct resource *res;
 	int ret, num_cs = 0, bits_per_word;
-	struct spi_master *master;
+	struct spi_controller *host;
 	bool force_irq = false;
 	u32 tmp;
 	u8 i;
@@ -415,26 +415,26 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 
 	if (!num_cs) {
 		dev_err(&pdev->dev,
-			"Missing slave select configuration data\n");
+			"Missing target select configuration data\n");
 		return -EINVAL;
 	}
 
 	if (num_cs > XILINX_SPI_MAX_CS) {
-		dev_err(&pdev->dev, "Invalid number of spi slaves\n");
+		dev_err(&pdev->dev, "Invalid number of spi targets\n");
 		return -EINVAL;
 	}
 
-	master = devm_spi_alloc_master(&pdev->dev, sizeof(struct xilinx_spi));
-	if (!master)
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(struct xilinx_spi));
+	if (!host)
 		return -ENODEV;
 
 	/* the spi->mode bits understood by this driver: */
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST | SPI_LOOP |
-			    SPI_CS_HIGH;
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST | SPI_LOOP |
+			  SPI_CS_HIGH;
 
-	xspi = spi_master_get_devdata(master);
+	xspi = spi_controller_get_devdata(host);
 	xspi->cs_inactive = 0xffffffff;
-	xspi->bitbang.master = master;
+	xspi->bitbang.master = host;
 	xspi->bitbang.chipselect = xilinx_spi_chipselect;
 	xspi->bitbang.setup_transfer = xilinx_spi_setup_transfer;
 	xspi->bitbang.txrx_bufs = xilinx_spi_txrx_bufs;
@@ -444,9 +444,9 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 	if (IS_ERR(xspi->regs))
 		return PTR_ERR(xspi->regs);
 
-	master->bus_num = pdev->id;
-	master->num_chipselect = num_cs;
-	master->dev.of_node = pdev->dev.of_node;
+	host->bus_num = pdev->id;
+	host->num_chipselect = num_cs;
+	host->dev.of_node = pdev->dev.of_node;
 
 	/*
 	 * Detect endianess on the IP via loop bit in CR. Detection
@@ -466,7 +466,7 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 		xspi->write_fn = xspi_write32_be;
 	}
 
-	master->bits_per_word_mask = SPI_BPW_MASK(bits_per_word);
+	host->bits_per_word_mask = SPI_BPW_MASK(bits_per_word);
 	xspi->bytes_per_word = bits_per_word / 8;
 	xspi->buffer_size = xilinx_spi_find_buffer_size(xspi);
 
@@ -496,17 +496,17 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 
 	if (pdata) {
 		for (i = 0; i < pdata->num_devices; i++)
-			spi_new_device(master, pdata->devices + i);
+			spi_new_device(host, pdata->devices + i);
 	}
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 	return 0;
 }
 
 static void xilinx_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct xilinx_spi *xspi = spi_master_get_devdata(master);
+	struct spi_controller *host = platform_get_drvdata(pdev);
+	struct xilinx_spi *xspi = spi_controller_get_devdata(host);
 	void __iomem *regs_base = xspi->regs;
 
 	spi_bitbang_stop(&xspi->bitbang);
@@ -516,7 +516,7 @@ static void xilinx_spi_remove(struct platform_device *pdev)
 	/* Disable the global IPIF interrupt */
 	xspi->write_fn(0, regs_base + XIPIF_V123B_DGIER_OFFSET);
 
-	spi_master_put(xspi->bitbang.master);
+	spi_controller_put(xspi->bitbang.master);
 }
 
 /* work with hotplug and coldplug */
-- 
2.25.1

