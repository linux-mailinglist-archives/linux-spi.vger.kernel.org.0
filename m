Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A9C2713D6
	for <lists+linux-spi@lfdr.de>; Sun, 20 Sep 2020 13:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgITLcY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 20 Sep 2020 07:32:24 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:54028 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgITLcX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 20 Sep 2020 07:32:23 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id E4D5E803073C;
        Sun, 20 Sep 2020 11:23:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FYtquVonEStk; Sun, 20 Sep 2020 14:23:26 +0300 (MSK)
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
Subject: [PATCH v2 02/11] spi: dw-dma: Fail DMA-based transfer if no Tx-buffer specified
Date:   Sun, 20 Sep 2020 14:23:13 +0300
Message-ID: <20200920112322.24585-3-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200920112322.24585-1-Sergey.Semin@baikalelectronics.ru>
References: <20200920112322.24585-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Since commit 46164fde6b78 ("spi: dw: Fix Rx-only DMA transfers") if DMA
interface is enabled, then Tx-buffer must be available in each SPI
transfer. It's required since in order to activate the incoming data
reception either DMA or CPU must be pushing data out to the SPI bus.
But the DW APB SSI DMA driver code is still left in state as if Tx-buffer
might be optional, which is no longer true. Let's fix it so an error would
be returned if no Tx-buffer detected and DMA Tx would be always
enabled.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-dma.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index a7ff1e357f8b..1b013ac94a3f 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -262,9 +262,6 @@ dw_spi_dma_prepare_tx(struct dw_spi *dws, struct spi_transfer *xfer)
 	struct dma_slave_config txconf;
 	struct dma_async_tx_descriptor *txdesc;
 
-	if (!xfer->tx_buf)
-		return NULL;
-
 	memset(&txconf, 0, sizeof(txconf));
 	txconf.direction = DMA_MEM_TO_DEV;
 	txconf.dst_addr = dws->dma_addr;
@@ -383,17 +380,19 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws,
 
 static int dw_spi_dma_setup(struct dw_spi *dws, struct spi_transfer *xfer)
 {
-	u16 imr = 0, dma_ctrl = 0;
+	u16 imr, dma_ctrl;
 
-	if (xfer->tx_buf)
-		dma_ctrl |= SPI_DMA_TDMAE;
+	if (!xfer->tx_buf)
+		return -EINVAL;
+
+	/* Set the DMA handshaking interface */
+	dma_ctrl = SPI_DMA_TDMAE;
 	if (xfer->rx_buf)
 		dma_ctrl |= SPI_DMA_RDMAE;
 	dw_writel(dws, DW_SPI_DMACR, dma_ctrl);
 
 	/* Set the interrupt mask */
-	if (xfer->tx_buf)
-		imr |= SPI_INT_TXOI;
+	imr = SPI_INT_TXOI;
 	if (xfer->rx_buf)
 		imr |= SPI_INT_RXUI | SPI_INT_RXOI;
 	spi_umask_intr(dws, imr);
@@ -412,6 +411,8 @@ static int dw_spi_dma_transfer(struct dw_spi *dws, struct spi_transfer *xfer)
 
 	/* Prepare the TX dma transfer */
 	txdesc = dw_spi_dma_prepare_tx(dws, xfer);
+	if (!txdesc)
+		return -EINVAL;
 
 	/* Prepare the RX dma transfer */
 	rxdesc = dw_spi_dma_prepare_rx(dws, xfer);
@@ -423,17 +424,15 @@ static int dw_spi_dma_transfer(struct dw_spi *dws, struct spi_transfer *xfer)
 		dma_async_issue_pending(dws->rxchan);
 	}
 
-	if (txdesc) {
-		set_bit(TX_BUSY, &dws->dma_chan_busy);
-		dmaengine_submit(txdesc);
-		dma_async_issue_pending(dws->txchan);
-	}
+	set_bit(TX_BUSY, &dws->dma_chan_busy);
+	dmaengine_submit(txdesc);
+	dma_async_issue_pending(dws->txchan);
 
 	ret = dw_spi_dma_wait(dws, xfer);
 	if (ret)
 		return ret;
 
-	if (txdesc && dws->master->cur_msg->status == -EINPROGRESS) {
+	if (dws->master->cur_msg->status == -EINPROGRESS) {
 		ret = dw_spi_dma_wait_tx_done(dws, xfer);
 		if (ret)
 			return ret;
-- 
2.27.0

