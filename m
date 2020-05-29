Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E4D1E7421
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 06:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgE2EAQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 00:00:16 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:45432 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389498AbgE2D7n (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 May 2020 23:59:43 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 3954F8029EA3;
        Fri, 29 May 2020 03:59:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ygwuWnJksRuj; Fri, 29 May 2020 06:59:40 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 13/16] spi: dw: Cleanup generic DW DMA code namings
Date:   Fri, 29 May 2020 06:59:11 +0300
Message-ID: <20200529035915.20790-14-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200529035915.20790-1-Sergey.Semin@baikalelectronics.ru>
References: <20200529035915.20790-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Since from now the former Intel MID platform layer is used as a generic
DW SPI DMA module, let's alter the internal methods naming to be
DMA-related instead of having the "mid_" prefix.

Co-developed-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Signed-off-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Co-developed-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Signed-off-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: devicetree@vger.kernel.org

---

Changelog v2:
- Leave the DMA setup method suffixes to be mfld and generic.
---
 drivers/spi/spi-dw-dma.c | 85 ++++++++++++++++++++--------------------
 drivers/spi/spi-dw-pci.c |  4 +-
 drivers/spi/spi-dw.h     |  8 ++--
 3 files changed, 49 insertions(+), 48 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index 30bd9800f2df..69b7051e5323 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -23,7 +23,7 @@
 #define TX_BUSY		1
 #define TX_BURST_LEVEL	16
 
-static bool mid_spi_dma_chan_filter(struct dma_chan *chan, void *param)
+static bool dw_spi_dma_chan_filter(struct dma_chan *chan, void *param)
 {
 	struct dw_dma_slave *s = param;
 
@@ -34,7 +34,7 @@ static bool mid_spi_dma_chan_filter(struct dma_chan *chan, void *param)
 	return true;
 }
 
-static void mid_spi_maxburst_init(struct dw_spi *dws)
+static void dw_spi_dma_maxburst_init(struct dw_spi *dws)
 {
 	struct dma_slave_caps caps;
 	u32 max_burst, def_burst;
@@ -59,7 +59,7 @@ static void mid_spi_maxburst_init(struct dw_spi *dws)
 	dws->txburst = min(max_burst, def_burst);
 }
 
-static int mid_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
+static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 {
 	struct dw_dma_slave slave = {
 		.src_id = 0,
@@ -81,13 +81,13 @@ static int mid_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 
 	/* 1. Init rx channel */
 	slave.dma_dev = &dma_dev->dev;
-	dws->rxchan = dma_request_channel(mask, mid_spi_dma_chan_filter, &slave);
+	dws->rxchan = dma_request_channel(mask, dw_spi_dma_chan_filter, &slave);
 	if (!dws->rxchan)
 		goto err_exit;
 
 	/* 2. Init tx channel */
 	slave.dst_id = 1;
-	dws->txchan = dma_request_channel(mask, mid_spi_dma_chan_filter, &slave);
+	dws->txchan = dma_request_channel(mask, dw_spi_dma_chan_filter, &slave);
 	if (!dws->txchan)
 		goto free_rxchan;
 
@@ -96,7 +96,7 @@ static int mid_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 
 	init_completion(&dws->dma_completion);
 
-	mid_spi_maxburst_init(dws);
+	dw_spi_dma_maxburst_init(dws);
 
 	return 0;
 
@@ -107,7 +107,7 @@ static int mid_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 	return -EBUSY;
 }
 
-static int mid_spi_dma_init_generic(struct device *dev, struct dw_spi *dws)
+static int dw_spi_dma_init_generic(struct device *dev, struct dw_spi *dws)
 {
 	dws->rxchan = dma_request_slave_channel(dev, "rx");
 	if (!dws->rxchan)
@@ -125,12 +125,12 @@ static int mid_spi_dma_init_generic(struct device *dev, struct dw_spi *dws)
 
 	init_completion(&dws->dma_completion);
 
-	mid_spi_maxburst_init(dws);
+	dw_spi_dma_maxburst_init(dws);
 
 	return 0;
 }
 
-static void mid_spi_dma_exit(struct dw_spi *dws)
+static void dw_spi_dma_exit(struct dw_spi *dws)
 {
 	if (dws->txchan) {
 		dmaengine_terminate_sync(dws->txchan);
@@ -145,7 +145,7 @@ static void mid_spi_dma_exit(struct dw_spi *dws)
 	dw_writel(dws, DW_SPI_DMACR, 0);
 }
 
-static irqreturn_t dma_transfer(struct dw_spi *dws)
+static irqreturn_t dw_spi_dma_transfer_handler(struct dw_spi *dws)
 {
 	u16 irq_status = dw_readl(dws, DW_SPI_ISR);
 
@@ -161,15 +161,16 @@ static irqreturn_t dma_transfer(struct dw_spi *dws)
 	return IRQ_HANDLED;
 }
 
-static bool mid_spi_can_dma(struct spi_controller *master,
-		struct spi_device *spi, struct spi_transfer *xfer)
+static bool dw_spi_can_dma(struct spi_controller *master,
+			   struct spi_device *spi, struct spi_transfer *xfer)
 {
 	struct dw_spi *dws = spi_controller_get_devdata(master);
 
 	return xfer->len > dws->fifo_len;
 }
 
-static enum dma_slave_buswidth convert_dma_width(u8 n_bytes) {
+static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes)
+{
 	if (n_bytes == 1)
 		return DMA_SLAVE_BUSWIDTH_1_BYTE;
 	else if (n_bytes == 2)
@@ -244,8 +245,8 @@ static void dw_spi_dma_tx_done(void *arg)
 	complete(&dws->dma_completion);
 }
 
-static struct dma_async_tx_descriptor *dw_spi_dma_prepare_tx(struct dw_spi *dws,
-		struct spi_transfer *xfer)
+static struct dma_async_tx_descriptor *
+dw_spi_dma_prepare_tx(struct dw_spi *dws, struct spi_transfer *xfer)
 {
 	struct dma_slave_config txconf;
 	struct dma_async_tx_descriptor *txdesc;
@@ -258,7 +259,7 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_tx(struct dw_spi *dws,
 	txconf.dst_addr = dws->dma_addr;
 	txconf.dst_maxburst = dws->txburst;
 	txconf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	txconf.dst_addr_width = convert_dma_width(dws->n_bytes);
+	txconf.dst_addr_width = dw_spi_dma_convert_width(dws->n_bytes);
 	txconf.device_fc = false;
 
 	dmaengine_slave_config(dws->txchan, &txconf);
@@ -350,7 +351,7 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws,
 	rxconf.src_addr = dws->dma_addr;
 	rxconf.src_maxburst = dws->rxburst;
 	rxconf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	rxconf.src_addr_width = convert_dma_width(dws->n_bytes);
+	rxconf.src_addr_width = dw_spi_dma_convert_width(dws->n_bytes);
 	rxconf.device_fc = false;
 
 	dmaengine_slave_config(dws->rxchan, &rxconf);
@@ -369,7 +370,7 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws,
 	return rxdesc;
 }
 
-static int mid_spi_dma_setup(struct dw_spi *dws, struct spi_transfer *xfer)
+static int dw_spi_dma_setup(struct dw_spi *dws, struct spi_transfer *xfer)
 {
 	u16 imr = 0, dma_ctrl = 0;
 
@@ -391,12 +392,12 @@ static int mid_spi_dma_setup(struct dw_spi *dws, struct spi_transfer *xfer)
 
 	reinit_completion(&dws->dma_completion);
 
-	dws->transfer_handler = dma_transfer;
+	dws->transfer_handler = dw_spi_dma_transfer_handler;
 
 	return 0;
 }
 
-static int mid_spi_dma_transfer(struct dw_spi *dws, struct spi_transfer *xfer)
+static int dw_spi_dma_transfer(struct dw_spi *dws, struct spi_transfer *xfer)
 {
 	struct dma_async_tx_descriptor *txdesc, *rxdesc;
 	int ret;
@@ -436,7 +437,7 @@ static int mid_spi_dma_transfer(struct dw_spi *dws, struct spi_transfer *xfer)
 	return ret;
 }
 
-static void mid_spi_dma_stop(struct dw_spi *dws)
+static void dw_spi_dma_stop(struct dw_spi *dws)
 {
 	if (test_bit(TX_BUSY, &dws->dma_chan_busy)) {
 		dmaengine_terminate_sync(dws->txchan);
@@ -450,32 +451,32 @@ static void mid_spi_dma_stop(struct dw_spi *dws)
 	dw_writel(dws, DW_SPI_DMACR, 0);
 }
 
-static const struct dw_spi_dma_ops mfld_dma_ops = {
-	.dma_init	= mid_spi_dma_init_mfld,
-	.dma_exit	= mid_spi_dma_exit,
-	.dma_setup	= mid_spi_dma_setup,
-	.can_dma	= mid_spi_can_dma,
-	.dma_transfer	= mid_spi_dma_transfer,
-	.dma_stop	= mid_spi_dma_stop,
+static const struct dw_spi_dma_ops dw_spi_dma_mfld_ops = {
+	.dma_init	= dw_spi_dma_init_mfld,
+	.dma_exit	= dw_spi_dma_exit,
+	.dma_setup	= dw_spi_dma_setup,
+	.can_dma	= dw_spi_can_dma,
+	.dma_transfer	= dw_spi_dma_transfer,
+	.dma_stop	= dw_spi_dma_stop,
 };
 
-void dw_spi_mid_setup_dma_mfld(struct dw_spi *dws)
+void dw_spi_dma_setup_mfld(struct dw_spi *dws)
 {
-	dws->dma_ops = &mfld_dma_ops;
+	dws->dma_ops = &dw_spi_dma_mfld_ops;
 }
-EXPORT_SYMBOL_GPL(dw_spi_mid_setup_dma_mfld);
-
-static const struct dw_spi_dma_ops generic_dma_ops = {
-	.dma_init	= mid_spi_dma_init_generic,
-	.dma_exit	= mid_spi_dma_exit,
-	.dma_setup	= mid_spi_dma_setup,
-	.can_dma	= mid_spi_can_dma,
-	.dma_transfer	= mid_spi_dma_transfer,
-	.dma_stop	= mid_spi_dma_stop,
+EXPORT_SYMBOL_GPL(dw_spi_dma_setup_mfld);
+
+static const struct dw_spi_dma_ops dw_spi_dma_generic_ops = {
+	.dma_init	= dw_spi_dma_init_generic,
+	.dma_exit	= dw_spi_dma_exit,
+	.dma_setup	= dw_spi_dma_setup,
+	.can_dma	= dw_spi_can_dma,
+	.dma_transfer	= dw_spi_dma_transfer,
+	.dma_stop	= dw_spi_dma_stop,
 };
 
-void dw_spi_mid_setup_dma_generic(struct dw_spi *dws)
+void dw_spi_dma_setup_generic(struct dw_spi *dws)
 {
-	dws->dma_ops = &generic_dma_ops;
+	dws->dma_ops = &dw_spi_dma_generic_ops;
 }
-EXPORT_SYMBOL_GPL(dw_spi_mid_setup_dma_generic);
+EXPORT_SYMBOL_GPL(dw_spi_dma_setup_generic);
diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index c13707b8493e..2ea73809ca34 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -51,7 +51,7 @@ static int spi_mid_init(struct dw_spi *dws)
 	/* Register hook to configure CTRLR0 */
 	dws->update_cr0 = dw_spi_update_cr0;
 
-	dw_spi_mid_setup_dma_mfld(dws);
+	dw_spi_dma_setup_mfld(dws);
 
 	return 0;
 }
@@ -61,7 +61,7 @@ static int spi_generic_init(struct dw_spi *dws)
 	/* Register hook to configure CTRLR0 */
 	dws->update_cr0 = dw_spi_update_cr0;
 
-	dw_spi_mid_setup_dma_generic(dws);
+	dw_spi_dma_setup_generic(dws);
 
 	return 0;
 }
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 91608cf12636..0b2cd7994513 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -259,13 +259,13 @@ extern u32 dw_spi_update_cr0_v1_01a(struct spi_controller *master,
 
 #ifdef CONFIG_SPI_DW_DMA
 
-extern void dw_spi_mid_setup_dma_mfld(struct dw_spi *dws);
-extern void dw_spi_mid_setup_dma_generic(struct dw_spi *dws);
+extern void dw_spi_dma_setup_mfld(struct dw_spi *dws);
+extern void dw_spi_dma_setup_generic(struct dw_spi *dws);
 
 #else
 
-static inline void dw_spi_mid_setup_dma_mfld(struct dw_spi *dws) {}
-static inline void dw_spi_mid_setup_dma_generic(struct dw_spi *dws) {}
+static inline void dw_spi_dma_setup_mfld(struct dw_spi *dws) {}
+static inline void dw_spi_dma_setup_generic(struct dw_spi *dws) {}
 
 #endif /* !CONFIG_SPI_DW_DMA */
 
-- 
2.26.2

