Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6E71CB059
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 15:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgEHNal (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 09:30:41 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:42774 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbgEHNal (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 May 2020 09:30:41 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 1A92E803087B;
        Fri,  8 May 2020 13:30:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uAGSLXYKZDSR; Fri,  8 May 2020 16:30:32 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 04/17] spi: dw: Cleanup generic DW DMA code namings
Date:   Fri, 8 May 2020 16:29:29 +0300
Message-ID: <20200508132943.9826-5-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Since from now the former Intel MID platform layer will be used
as a generic DW SPI DMA module, lets alter the internal methods
naming to be DMA-related instead of having the "mid_" prefix. In
addition the DW PCI-DMA specific methods and structures should
be named with pci-suffexes, since we'll implement the DW MMIO DMA
specific functions and objects soon.

Co-developed-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Signed-off-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Co-developed-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Signed-off-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Allison Randal <allison@lohutok.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Gareth Williams <gareth.williams.jx@renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
 drivers/spi/spi-dw-dma.c | 42 ++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index 0230b4252611..523d9e39ffc1 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -20,10 +20,10 @@
 #define RX_BUSY		0
 #define TX_BUSY		1
 
-static struct dw_dma_slave mid_dma_tx = { .dst_id = 1 };
-static struct dw_dma_slave mid_dma_rx = { .src_id = 0 };
+static struct dw_dma_slave pci_dma_tx = { .dst_id = 1 };
+static struct dw_dma_slave pci_dma_rx = { .src_id = 0 };
 
-static bool mid_spi_dma_chan_filter(struct dma_chan *chan, void *param)
+static bool dw_spi_dma_chan_filter(struct dma_chan *chan, void *param)
 {
 	struct dw_dma_slave *s = param;
 
@@ -34,7 +34,7 @@ static bool mid_spi_dma_chan_filter(struct dma_chan *chan, void *param)
 	return true;
 }
 
-static int mid_spi_dma_init(struct dw_spi *dws)
+static int dw_spi_pci_dma_init(struct dw_spi *dws)
 {
 	struct pci_dev *dma_dev;
 	struct dw_dma_slave *tx = dws->dma_tx;
@@ -54,14 +54,14 @@ static int mid_spi_dma_init(struct dw_spi *dws)
 
 	/* 1. Init rx channel */
 	rx->dma_dev = &dma_dev->dev;
-	dws->rxchan = dma_request_channel(mask, mid_spi_dma_chan_filter, rx);
+	dws->rxchan = dma_request_channel(mask, dw_spi_dma_chan_filter, rx);
 	if (!dws->rxchan)
 		goto err_exit;
 	dws->master->dma_rx = dws->rxchan;
 
 	/* 2. Init tx channel */
 	tx->dma_dev = &dma_dev->dev;
-	dws->txchan = dma_request_channel(mask, mid_spi_dma_chan_filter, tx);
+	dws->txchan = dma_request_channel(mask, dw_spi_dma_chan_filter, tx);
 	if (!dws->txchan)
 		goto free_rxchan;
 	dws->master->dma_tx = dws->txchan;
@@ -75,7 +75,7 @@ static int mid_spi_dma_init(struct dw_spi *dws)
 	return -EBUSY;
 }
 
-static void mid_spi_dma_exit(struct dw_spi *dws)
+static void dw_spi_dma_exit(struct dw_spi *dws)
 {
 	if (!dws->dma_inited)
 		return;
@@ -103,7 +103,7 @@ static irqreturn_t dma_transfer(struct dw_spi *dws)
 	return IRQ_HANDLED;
 }
 
-static bool mid_spi_can_dma(struct spi_controller *master,
+static bool dw_spi_can_dma(struct spi_controller *master,
 		struct spi_device *spi, struct spi_transfer *xfer)
 {
 	struct dw_spi *dws = spi_controller_get_devdata(master);
@@ -215,7 +215,7 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws,
 	return rxdesc;
 }
 
-static int mid_spi_dma_setup(struct dw_spi *dws, struct spi_transfer *xfer)
+static int dw_spi_dma_setup(struct dw_spi *dws, struct spi_transfer *xfer)
 {
 	u16 dma_ctrl = 0;
 
@@ -236,7 +236,7 @@ static int mid_spi_dma_setup(struct dw_spi *dws, struct spi_transfer *xfer)
 	return 0;
 }
 
-static int mid_spi_dma_transfer(struct dw_spi *dws, struct spi_transfer *xfer)
+static int dw_spi_dma_transfer(struct dw_spi *dws, struct spi_transfer *xfer)
 {
 	struct dma_async_tx_descriptor *txdesc, *rxdesc;
 
@@ -262,7 +262,7 @@ static int mid_spi_dma_transfer(struct dw_spi *dws, struct spi_transfer *xfer)
 	return 0;
 }
 
-static void mid_spi_dma_stop(struct dw_spi *dws)
+static void dw_spi_dma_stop(struct dw_spi *dws)
 {
 	if (test_bit(TX_BUSY, &dws->dma_chan_busy)) {
 		dmaengine_terminate_sync(dws->txchan);
@@ -274,19 +274,19 @@ static void mid_spi_dma_stop(struct dw_spi *dws)
 	}
 }
 
-static const struct dw_spi_dma_ops mid_dma_ops = {
-	.dma_init	= mid_spi_dma_init,
-	.dma_exit	= mid_spi_dma_exit,
-	.dma_setup	= mid_spi_dma_setup,
-	.can_dma	= mid_spi_can_dma,
-	.dma_transfer	= mid_spi_dma_transfer,
-	.dma_stop	= mid_spi_dma_stop,
+static const struct dw_spi_dma_ops dw_spi_pci_dma_ops = {
+	.dma_init	= dw_spi_pci_dma_init,
+	.dma_exit	= dw_spi_dma_exit,
+	.dma_setup	= dw_spi_dma_setup,
+	.can_dma	= dw_spi_can_dma,
+	.dma_transfer	= dw_spi_dma_transfer,
+	.dma_stop	= dw_spi_dma_stop,
 };
 
 void dw_spi_pci_dma_setup(struct dw_spi *dws)
 {
-	dws->dma_tx = &mid_dma_tx;
-	dws->dma_rx = &mid_dma_rx;
-	dws->dma_ops = &mid_dma_ops;
+	dws->dma_tx = &pci_dma_tx;
+	dws->dma_rx = &pci_dma_rx;
+	dws->dma_ops = &dw_spi_pci_dma_ops;
 }
 EXPORT_SYMBOL_GPL(dw_spi_pci_dma_setup);
-- 
2.25.1

