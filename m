Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2168D1E7412
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 06:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390165AbgE2D7n (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 May 2020 23:59:43 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:45418 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388744AbgE2D7k (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 May 2020 23:59:40 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id EC5DF8030779;
        Fri, 29 May 2020 03:59:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xT5FdjWP_obT; Fri, 29 May 2020 06:59:35 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 07/16] spi: dw: Use DMA max burst to set the request thresholds
Date:   Fri, 29 May 2020 06:59:05 +0300
Message-ID: <20200529035915.20790-8-Sergey.Semin@baikalelectronics.ru>
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

Each channel of DMA controller may have a limited length of burst
transaction (number of IO operations performed at ones in a single
DMA client request). This parameter can be used to setup the most
optimal DMA Tx/Rx data level values. In order to avoid the Tx buffer
overrun we can set the DMA Tx level to be of FIFO depth minus the
maximum burst transactions length. To prevent the Rx buffer underflow
the DMA Rx level should be set to the maximum burst transactions length.
This commit setups the DMA channels and the DW SPI DMA Tx/Rx levels
in accordance with these rules.

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

Changelog v3:
- Use min() method to calculate the optimal burst values.
---
 drivers/spi/spi-dw-mid.c | 37 +++++++++++++++++++++++++++++++++----
 drivers/spi/spi-dw.h     |  2 ++
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index 93463bdba0f8..ff79b4239d68 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -36,6 +36,31 @@ static bool mid_spi_dma_chan_filter(struct dma_chan *chan, void *param)
 	return true;
 }
 
+static void mid_spi_maxburst_init(struct dw_spi *dws)
+{
+	struct dma_slave_caps caps;
+	u32 max_burst, def_burst;
+	int ret;
+
+	def_burst = dws->fifo_len / 2;
+
+	ret = dma_get_slave_caps(dws->rxchan, &caps);
+	if (!ret && caps.max_burst)
+		max_burst = caps.max_burst;
+	else
+		max_burst = RX_BURST_LEVEL;
+
+	dws->rxburst = min(max_burst, def_burst);
+
+	ret = dma_get_slave_caps(dws->txchan, &caps);
+	if (!ret && caps.max_burst)
+		max_burst = caps.max_burst;
+	else
+		max_burst = TX_BURST_LEVEL;
+
+	dws->txburst = min(max_burst, def_burst);
+}
+
 static int mid_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 {
 	struct dw_dma_slave slave = {
@@ -73,6 +98,8 @@ static int mid_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 
 	init_completion(&dws->dma_completion);
 
+	mid_spi_maxburst_init(dws);
+
 	return 0;
 
 free_rxchan:
@@ -100,6 +127,8 @@ static int mid_spi_dma_init_generic(struct device *dev, struct dw_spi *dws)
 
 	init_completion(&dws->dma_completion);
 
+	mid_spi_maxburst_init(dws);
+
 	return 0;
 }
 
@@ -229,7 +258,7 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_tx(struct dw_spi *dws,
 	memset(&txconf, 0, sizeof(txconf));
 	txconf.direction = DMA_MEM_TO_DEV;
 	txconf.dst_addr = dws->dma_addr;
-	txconf.dst_maxburst = TX_BURST_LEVEL;
+	txconf.dst_maxburst = dws->txburst;
 	txconf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	txconf.dst_addr_width = convert_dma_width(dws->n_bytes);
 	txconf.device_fc = false;
@@ -321,7 +350,7 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws,
 	memset(&rxconf, 0, sizeof(rxconf));
 	rxconf.direction = DMA_DEV_TO_MEM;
 	rxconf.src_addr = dws->dma_addr;
-	rxconf.src_maxburst = RX_BURST_LEVEL;
+	rxconf.src_maxburst = dws->rxburst;
 	rxconf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	rxconf.src_addr_width = convert_dma_width(dws->n_bytes);
 	rxconf.device_fc = false;
@@ -346,8 +375,8 @@ static int mid_spi_dma_setup(struct dw_spi *dws, struct spi_transfer *xfer)
 {
 	u16 imr = 0, dma_ctrl = 0;
 
-	dw_writel(dws, DW_SPI_DMARDLR, RX_BURST_LEVEL - 1);
-	dw_writel(dws, DW_SPI_DMATDLR, TX_BURST_LEVEL);
+	dw_writel(dws, DW_SPI_DMARDLR, dws->rxburst - 1);
+	dw_writel(dws, DW_SPI_DMATDLR, dws->fifo_len - dws->txburst);
 
 	if (xfer->tx_buf) {
 		dma_ctrl |= SPI_DMA_TDMAE;
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 9585d0c83a6d..9247670fcdfb 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -142,7 +142,9 @@ struct dw_spi {
 
 	/* DMA info */
 	struct dma_chan		*txchan;
+	u32			txburst;
 	struct dma_chan		*rxchan;
+	u32			rxburst;
 	unsigned long		dma_chan_busy;
 	dma_addr_t		dma_addr; /* phy address of the Data register */
 	const struct dw_spi_dma_ops *dma_ops;
-- 
2.26.2

