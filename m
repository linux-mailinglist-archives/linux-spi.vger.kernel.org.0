Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1670F2340B0
	for <lists+linux-spi@lfdr.de>; Fri, 31 Jul 2020 10:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731849AbgGaIAJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 31 Jul 2020 04:00:09 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:59794 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731435AbgGaIAJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 31 Jul 2020 04:00:09 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id A65BF803202D;
        Fri, 31 Jul 2020 08:00:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hWKm7aRe4lqk; Fri, 31 Jul 2020 11:00:02 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>, Vinod Koul <vkoul@kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 8/8] spi: dw-dma: Add one-by-one SG list entries transfer
Date:   Fri, 31 Jul 2020 10:59:53 +0300
Message-ID: <20200731075953.14416-9-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200731075953.14416-1-Sergey.Semin@baikalelectronics.ru>
References: <20200731075953.14416-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In case if at least one of the requested DMA engine channels doesn't
support the hardware accelerated SG list entries traverse, the DMA driver
will most likely work that around by performing the IRQ-based SG list
entries resubmission. That might and will cause a problem if the DMA Tx
channel is recharged and re-executed before the Rx DMA channel. Due to
non-deterministic IRQ-handler execution latency the DMA Tx channel will
start pushing data to the SPI bus before the Rx DMA channel is even
reinitialized with the next inbound SG list entry. By doing so the DMA
Tx channel will implicitly start filling the DW APB SSI Rx FIFO up, which
while the DMA Rx channel being recharged and re-executed will eventually
be overflown.

In order to solve the problem we have to feed the DMA engine with SG
list entries one-by-one. It shall keep the DW APB SSI Tx and Rx FIFOs
synchronized and prevent the Rx FIFO overflow. Since in general the SPI
tx_sg and rx_sg lists may have different number of entries of different
lengths (though total length should match) we virtually split the
SG-lists to the set of DMA transfers, which length is a minimum of the
ordered SG-entries lengths.

The solution described above is only executed if a full-duplex SPI
transfer is requested and the DMA engine hasn't provided channels with
hardware accelerated SG list traverse capability to handle both SG
lists at once.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-dw-dma.c | 137 ++++++++++++++++++++++++++++++++++++++-
 drivers/spi/spi-dw.h     |   1 +
 2 files changed, 137 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index 2b42b42b6cf2..b3eeef3d5cf7 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -73,6 +73,23 @@ static void dw_spi_dma_maxburst_init(struct dw_spi *dws)
 	dw_writel(dws, DW_SPI_DMATDLR, dws->txburst);
 }
 
+static void dw_spi_dma_sg_burst_init(struct dw_spi *dws)
+{
+	struct dma_slave_caps tx = {0}, rx = {0};
+
+	dma_get_slave_caps(dws->txchan, &tx);
+	dma_get_slave_caps(dws->rxchan, &rx);
+
+	if (tx.max_sg_burst > 0 && rx.max_sg_burst > 0)
+		dws->dma_sg_burst = min(tx.max_sg_burst, rx.max_sg_burst);
+	else if (tx.max_sg_burst > 0)
+		dws->dma_sg_burst = tx.max_sg_burst;
+	else if (rx.max_sg_burst > 0)
+		dws->dma_sg_burst = rx.max_sg_burst;
+	else
+		dws->dma_sg_burst = 0;
+}
+
 static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 {
 	struct dw_dma_slave dma_tx = { .dst_id = 1 }, *tx = &dma_tx;
@@ -110,6 +127,8 @@ static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 
 	dw_spi_dma_maxburst_init(dws);
 
+	dw_spi_dma_sg_burst_init(dws);
+
 	return 0;
 
 free_rxchan:
@@ -139,6 +158,8 @@ static int dw_spi_dma_init_generic(struct device *dev, struct dw_spi *dws)
 
 	dw_spi_dma_maxburst_init(dws);
 
+	dw_spi_dma_sg_burst_init(dws);
+
 	return 0;
 }
 
@@ -459,11 +480,125 @@ static int dw_spi_dma_transfer_all(struct dw_spi *dws,
 	return ret;
 }
 
+static int dw_spi_dma_transfer_one(struct dw_spi *dws,
+				   struct spi_transfer *xfer)
+{
+	struct scatterlist *tx_sg = NULL, *rx_sg = NULL, tx_tmp, rx_tmp;
+	unsigned int tx_len = 0, rx_len = 0;
+	unsigned int base, len;
+	int ret;
+
+	sg_init_table(&tx_tmp, 1);
+	sg_init_table(&rx_tmp, 1);
+
+	/*
+	 * In case if at least one of the requested DMA channels doesn't
+	 * support the hardware accelerated SG list entries traverse, the DMA
+	 * driver will most likely work that around by performing the IRQ-based
+	 * SG list entries resubmission. That might and will cause a problem
+	 * if the DMA Tx channel is recharged and re-executed before the Rx DMA
+	 * channel. Due to non-deterministic IRQ-handler execution latency the
+	 * DMA Tx channel will start pushing data to the SPI bus before the
+	 * Rx DMA channel is even reinitialized with the next inbound SG list
+	 * entry. By doing so the DMA Tx channel will implicitly start filling
+	 * the DW APB SSI Rx FIFO up, which while the DMA Rx channel being
+	 * recharged and re-executed will eventually be overflown.
+	 *
+	 * In order to solve the problem we have to feed the DMA engine with SG
+	 * list entries one-by-one. It shall keep the DW APB SSI Tx and Rx
+	 * FIFOs synchronized and prevent the Rx FIFO overflow. Since in
+	 * general the tx_sg and rx_sg lists may have different number of
+	 * entries of different lengths (though total length should match)
+	 * let's virtually split the SG-lists to the set of DMA transfers,
+	 * which length is a minimum of the ordered SG-entries lengths.
+	 * An ASCII-sketch of the implemented algo is following:
+	 *                  xfer->len
+	 *                |___________|
+	 * tx_sg list:    |___|____|__|
+	 * rx_sg list:    |_|____|____|
+	 * DMA transfers: |_|_|__|_|__|
+	 *
+	 * Note in order to have this workaround solving the denoted problem
+	 * the DMA engine driver should properly initialize the max_sg_burst
+	 * capability and set the DMA device max segment size parameter with
+	 * maximum data block size the DMA engine supports.
+	 */
+	for (base = 0, len = 0; base < xfer->len; base += len) {
+		/* Fetch next Tx DMA data chunk */
+		if (!tx_len) {
+			tx_sg = !tx_sg ? &xfer->tx_sg.sgl[0] : sg_next(tx_sg);
+			sg_dma_address(&tx_tmp) = sg_dma_address(tx_sg);
+			tx_len = sg_dma_len(tx_sg);
+		}
+
+		/* Fetch next Rx DMA data chunk */
+		if (!rx_len) {
+			rx_sg = !rx_sg ? &xfer->rx_sg.sgl[0] : sg_next(rx_sg);
+			sg_dma_address(&rx_tmp) = sg_dma_address(rx_sg);
+			rx_len = sg_dma_len(rx_sg);
+		}
+
+		len = min(tx_len, rx_len);
+
+		sg_dma_len(&tx_tmp) = len;
+		sg_dma_len(&rx_tmp) = len;
+
+		/* Submit DMA Tx transfer */
+		ret = dw_spi_dma_submit_tx(dws, &tx_tmp, 1);
+		if (ret)
+			break;
+
+		/* Submit DMA Rx transfer */
+		ret = dw_spi_dma_submit_rx(dws, &rx_tmp, 1);
+		if (ret)
+			break;
+
+		/* Rx must be started before Tx due to SPI instinct */
+		dma_async_issue_pending(dws->rxchan);
+
+		dma_async_issue_pending(dws->txchan);
+
+		/*
+		 * Here we only need to wait for the DMA transfer to be
+		 * finished since SPI controller is kept enabled during the
+		 * procedure this loop implements and there is no risk to lose
+		 * data left in the Tx/Rx FIFOs.
+		 */
+		ret = dw_spi_dma_wait(dws, len, xfer->effective_speed_hz);
+		if (ret)
+			break;
+
+		reinit_completion(&dws->dma_completion);
+
+		sg_dma_address(&tx_tmp) += len;
+		sg_dma_address(&rx_tmp) += len;
+		tx_len -= len;
+		rx_len -= len;
+	}
+
+	dw_writel(dws, DW_SPI_DMACR, 0);
+
+	return ret;
+}
+
 static int dw_spi_dma_transfer(struct dw_spi *dws, struct spi_transfer *xfer)
 {
+	unsigned int nents;
 	int ret;
 
-	ret = dw_spi_dma_transfer_all(dws, xfer);
+	nents = max(xfer->tx_sg.nents, xfer->rx_sg.nents);
+
+	/*
+	 * Execute normal DMA-based transfer (which submits the Rx and Tx SG
+	 * lists directly to the DMA engine at once) if either full hardware
+	 * accelerated SG list traverse is supported by both channels, or the
+	 * Tx-only SPI transfer is requested, or the DMA engine is capable to
+	 * handle both SG lists on hardware accelerated basis.
+	 */
+	if (!dws->dma_sg_burst || !xfer->rx_buf || nents <= dws->dma_sg_burst)
+		ret = dw_spi_dma_transfer_all(dws, xfer);
+	else
+		ret = dw_spi_dma_transfer_one(dws, xfer);
 	if (ret)
 		return ret;
 
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 151ba316619e..1d201c62d292 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -146,6 +146,7 @@ struct dw_spi {
 	u32			txburst;
 	struct dma_chan		*rxchan;
 	u32			rxburst;
+	u32			dma_sg_burst;
 	unsigned long		dma_chan_busy;
 	dma_addr_t		dma_addr; /* phy address of the Data register */
 	const struct dw_spi_dma_ops *dma_ops;
-- 
2.27.0

