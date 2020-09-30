Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55FD27F1F8
	for <lists+linux-spi@lfdr.de>; Wed, 30 Sep 2020 20:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730682AbgI3S5M (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Sep 2020 14:57:12 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:41788 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730262AbgI3S4C (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Sep 2020 14:56:02 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 0F838803017C;
        Wed, 30 Sep 2020 18:55:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gaDQJsgGfvfP; Wed, 30 Sep 2020 21:55:56 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        "wuxu . wu" <wuxu.wu@huawei.com>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 09/21] spi: dw: Refactor IRQ-based SPI transfer procedure
Date:   Wed, 30 Sep 2020 21:55:33 +0300
Message-ID: <20200930185545.29959-10-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200930185545.29959-1-Sergey.Semin@baikalelectronics.ru>
References: <20200930185545.29959-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Current IRQ-based SPI transfer execution procedure doesn't work well at
the final stage of the execution. If all the Tx data is sent out (written
to the Tx FIFO) but there is some data left to receive, the Tx FIFO Empty
IRQ will constantly happen until all of the requested inbound data is
received. Though for a short period of time, but it will make the system
less responsive. In order to fix that let's refactor the SPI transfer
execution procedure by taking the Rx FIFO Full IRQ into account. We'll read
and write SPI transfer data each time the IRQ happens as before. If all
the outbound data is sent out, we'll disable the Tx FIFO Empty IRQ. If
there is still some data to receive, we'll adjust the Rx FIFO Threshold
level, so the next IRQ would be raised at the moment of all incoming data
being available in the Rx FIFO.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-core.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 4baf72b121c2..74e8f0da2883 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -189,17 +189,30 @@ static irqreturn_t interrupt_transfer(struct dw_spi *dws)
 		return IRQ_HANDLED;
 	}
 
+	/*
+	 * Read data from the Rx FIFO every time we've got a chance executing
+	 * this method. If there is nothing left to receive, terminate the
+	 * procedure. Otherwise adjust the Rx FIFO Threshold level if it's a
+	 * final stage of the transfer. By doing so we'll get the next IRQ
+	 * right when the leftover incoming data is received.
+	 */
 	dw_reader(dws);
 	if (!dws->rx_len) {
 		spi_mask_intr(dws, 0xff);
 		spi_finalize_current_transfer(dws->master);
-		return IRQ_HANDLED;
+	} else if (dws->rx_len <= dw_readl(dws, DW_SPI_RXFTLR)) {
+		dw_writel(dws, DW_SPI_RXFTLR, dws->rx_len - 1);
 	}
+
+	/*
+	 * Send data out if Tx FIFO Empty IRQ is received. The IRQ will be
+	 * disabled after the data transmission is finished so not to
+	 * have the TXE IRQ flood at the final stage of the transfer.
+	 */
 	if (irq_status & SPI_INT_TXEI) {
-		spi_mask_intr(dws, SPI_INT_TXEI);
 		dw_writer(dws);
-		/* Enable TX irq always, it will be disabled when RX finished */
-		spi_umask_intr(dws, SPI_INT_TXEI);
+		if (!dws->tx_len)
+			spi_mask_intr(dws, SPI_INT_TXEI);
 	}
 
 	return IRQ_HANDLED;
@@ -338,10 +351,6 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 	/* For poll mode just disable all interrupts */
 	spi_mask_intr(dws, 0xff);
 
-	/*
-	 * Interrupt mode
-	 * we only need set the TXEI IRQ, as TX/RX always happen syncronizely
-	 */
 	if (dws->dma_mapped) {
 		ret = dws->dma_ops->dma_setup(dws, transfer);
 		if (ret < 0) {
@@ -349,12 +358,18 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 			return ret;
 		}
 	} else {
+		/*
+		 * Originally Tx and Rx data lengths match. Rx FIFO Threshold level
+		 * will be adjusted at the final stage of the IRQ-based SPI transfer
+		 * execution so not to lose the leftover of the incoming data.
+		 */
 		txlevel = min_t(u16, dws->fifo_len / 2, dws->tx_len);
 		dw_writel(dws, DW_SPI_TXFTLR, txlevel);
+		dw_writel(dws, DW_SPI_RXFTLR, txlevel - 1);
 
 		/* Set the interrupt mask */
 		imask |= SPI_INT_TXEI | SPI_INT_TXOI |
-			 SPI_INT_RXUI | SPI_INT_RXOI;
+			 SPI_INT_RXUI | SPI_INT_RXOI | SPI_INT_RXFI;
 		spi_umask_intr(dws, imask);
 
 		dws->transfer_handler = interrupt_transfer;
-- 
2.27.0

