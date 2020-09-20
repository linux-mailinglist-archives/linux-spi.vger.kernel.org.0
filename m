Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA6B2713C3
	for <lists+linux-spi@lfdr.de>; Sun, 20 Sep 2020 13:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgITLam (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 20 Sep 2020 07:30:42 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:53640 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgITL3u (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 20 Sep 2020 07:29:50 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 548008002562;
        Sun, 20 Sep 2020 11:29:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cdPCdQANdvMQ; Sun, 20 Sep 2020 14:29:34 +0300 (MSK)
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
Subject: [PATCH 17/30] spi: dw: Refactor data IO procedure
Date:   Sun, 20 Sep 2020 14:29:01 +0300
Message-ID: <20200920112914.26501-18-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
References: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Tx and Rx data write/read procedure can be significantly simplified by
using Tx/Rx transfer lengths instead of the end pointers. By having the
Tx/Rx data leftover lengths (in the number of transfer words) we can get
rid of all subtraction and division operations utilized here and there in
the tx_max(), rx_max(), dw_writer() and dw_reader() methods. Such
modification will not only give us the more optimized IO procedures, but
will make the data IO methods much more readable than before.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-core.c | 37 +++++++++++++++++--------------------
 drivers/spi/spi-dw.h      |  5 ++---
 2 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 9102685c1523..84c1fdfd6e52 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -108,9 +108,8 @@ EXPORT_SYMBOL_GPL(dw_spi_set_cs);
 /* Return the max entries we can fill into tx fifo */
 static inline u32 tx_max(struct dw_spi *dws)
 {
-	u32 tx_left, tx_room, rxtx_gap;
+	u32 tx_room, rxtx_gap;
 
-	tx_left = (dws->tx_end - dws->tx) / dws->n_bytes;
 	tx_room = dws->fifo_len - dw_readl(dws, DW_SPI_TXFLR);
 
 	/*
@@ -121,18 +120,15 @@ static inline u32 tx_max(struct dw_spi *dws)
 	 * shift registers. So a control from sw point of
 	 * view is taken.
 	 */
-	rxtx_gap =  ((dws->rx_end - dws->rx) - (dws->tx_end - dws->tx))
-			/ dws->n_bytes;
+	rxtx_gap = dws->fifo_len - (dws->rx_len - dws->tx_len);
 
-	return min3(tx_left, tx_room, (u32) (dws->fifo_len - rxtx_gap));
+	return min3((u32)dws->tx_len, tx_room, rxtx_gap);
 }
 
 /* Return the max entries we should read out of rx fifo */
 static inline u32 rx_max(struct dw_spi *dws)
 {
-	u32 rx_left = (dws->rx_end - dws->rx) / dws->n_bytes;
-
-	return min_t(u32, rx_left, dw_readl(dws, DW_SPI_RXFLR));
+	return min_t(u32, dws->rx_len, dw_readl(dws, DW_SPI_RXFLR));
 }
 
 static void dw_writer(struct dw_spi *dws)
@@ -141,15 +137,16 @@ static void dw_writer(struct dw_spi *dws)
 	u16 txw = 0;
 
 	while (max--) {
-		/* Set the tx word if the transfer's original "tx" is not null */
-		if (dws->tx_end - dws->len) {
+		if (dws->tx) {
 			if (dws->n_bytes == 1)
 				txw = *(u8 *)(dws->tx);
 			else
 				txw = *(u16 *)(dws->tx);
+
+			dws->tx += dws->n_bytes;
 		}
 		dw_write_io_reg(dws, DW_SPI_DR, txw);
-		dws->tx += dws->n_bytes;
+		--dws->tx_len;
 	}
 }
 
@@ -160,14 +157,15 @@ static void dw_reader(struct dw_spi *dws)
 
 	while (max--) {
 		rxw = dw_read_io_reg(dws, DW_SPI_DR);
-		/* Care rx only if the transfer's original "rx" is not null */
-		if (dws->rx_end - dws->len) {
+		if (dws->rx) {
 			if (dws->n_bytes == 1)
 				*(u8 *)(dws->rx) = rxw;
 			else
 				*(u16 *)(dws->rx) = rxw;
+
+			dws->rx += dws->n_bytes;
 		}
-		dws->rx += dws->n_bytes;
+		--dws->rx_len;
 	}
 }
 
@@ -192,7 +190,7 @@ static irqreturn_t interrupt_transfer(struct dw_spi *dws)
 	}
 
 	dw_reader(dws);
-	if (dws->rx_end == dws->rx) {
+	if (!dws->rx_len) {
 		spi_mask_intr(dws, 0xff);
 		spi_finalize_current_transfer(dws->master);
 		return IRQ_HANDLED;
@@ -299,12 +297,11 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 	dws->dma_mapped = 0;
 	dws->n_bytes = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
 	dws->tx = (void *)transfer->tx_buf;
-	dws->tx_end = dws->tx + transfer->len;
+	dws->tx_len = transfer->len / dws->n_bytes;
 	dws->rx = transfer->rx_buf;
-	dws->rx_end = dws->rx + transfer->len;
-	dws->len = transfer->len;
+	dws->rx_len = dws->tx_len;
 
-	/* Ensure dw->rx and dw->rx_end are visible */
+	/* Ensure the data above is visible for all CPUs */
 	smp_mb();
 
 	spi_enable_chip(dws, 0);
@@ -331,7 +328,7 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 			return ret;
 		}
 	} else {
-		txlevel = min_t(u16, dws->fifo_len / 2, dws->len / dws->n_bytes);
+		txlevel = min_t(u16, dws->fifo_len / 2, dws->tx_len);
 		dw_writel(dws, DW_SPI_TXFTLR, txlevel);
 
 		/* Set the interrupt mask */
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 2a2346438564..cfc9f63acde4 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -147,11 +147,10 @@ struct dw_spi {
 	void (*set_cs)(struct spi_device *spi, bool enable);
 
 	/* Current message transfer state info */
-	size_t			len;
 	void			*tx;
-	void			*tx_end;
+	unsigned int		tx_len;
 	void			*rx;
-	void			*rx_end;
+	unsigned int		rx_len;
 	int			dma_mapped;
 	u8			n_bytes;	/* current is a 1/2 bytes op */
 	irqreturn_t		(*transfer_handler)(struct dw_spi *dws);
-- 
2.27.0

