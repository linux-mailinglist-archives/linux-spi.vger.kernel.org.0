Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D801E7405
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 06:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388880AbgE2D7h (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 May 2020 23:59:37 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:45350 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388517AbgE2D7g (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 May 2020 23:59:36 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 6969A8030776;
        Fri, 29 May 2020 03:59:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZNk5yuASX1PS; Fri, 29 May 2020 06:59:32 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>, Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 03/16] spi: dw: Locally wait for the DMA transactions completion
Date:   Fri, 29 May 2020 06:59:01 +0300
Message-ID: <20200529035915.20790-4-Sergey.Semin@baikalelectronics.ru>
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

Even if DMA transactions are finished it doesn't mean that the SPI
transfers are also completed. It's specifically concerns the Tx-only
SPI transfers, since there might be data left in the SPI Tx FIFO after
the DMA engine notifies that the Tx DMA procedure is done. In order to
completely fix the problem first the driver has to wait for the DMA
transaction completion, then for the corresponding SPI operations to be
finished. In this commit we implement the former part of the solution.

Note we can't just move the SPI operations wait procedure to the DMA
completion callbacks, since these callbacks might be executed in the
tasklet context (and they will be in case of the DW DMA). In case of
slow SPI bus it can cause significant system performance drop.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
 drivers/spi/spi-dw-mid.c | 44 ++++++++++++++++++++++++++++++++++++----
 drivers/spi/spi-dw.h     |  2 ++
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index 7ff1acaa55f8..355b641c4483 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -11,9 +11,11 @@
 #include "spi-dw.h"
 
 #ifdef CONFIG_SPI_DW_MID_DMA
+#include <linux/completion.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/irqreturn.h>
+#include <linux/jiffies.h>
 #include <linux/pci.h>
 #include <linux/platform_data/dma-dw.h>
 
@@ -66,6 +68,8 @@ static int mid_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 	dws->master->dma_rx = dws->rxchan;
 	dws->master->dma_tx = dws->txchan;
 
+	init_completion(&dws->dma_completion);
+
 	return 0;
 
 free_rxchan:
@@ -91,6 +95,8 @@ static int mid_spi_dma_init_generic(struct device *dev, struct dw_spi *dws)
 	dws->master->dma_rx = dws->rxchan;
 	dws->master->dma_tx = dws->txchan;
 
+	init_completion(&dws->dma_completion);
+
 	return 0;
 }
 
@@ -121,7 +127,7 @@ static irqreturn_t dma_transfer(struct dw_spi *dws)
 
 	dev_err(&dws->master->dev, "%s: FIFO overrun/underrun\n", __func__);
 	dws->master->cur_msg->status = -EIO;
-	spi_finalize_current_transfer(dws->master);
+	complete(&dws->dma_completion);
 	return IRQ_HANDLED;
 }
 
@@ -142,6 +148,29 @@ static enum dma_slave_buswidth convert_dma_width(u8 n_bytes) {
 	return DMA_SLAVE_BUSWIDTH_UNDEFINED;
 }
 
+static int dw_spi_dma_wait(struct dw_spi *dws, struct spi_transfer *xfer)
+{
+	unsigned long long ms;
+
+	ms = xfer->len * MSEC_PER_SEC * BITS_PER_BYTE;
+	do_div(ms, xfer->effective_speed_hz);
+	ms += ms + 200;
+
+	if (ms > UINT_MAX)
+		ms = UINT_MAX;
+
+	ms = wait_for_completion_timeout(&dws->dma_completion,
+					 msecs_to_jiffies(ms));
+
+	if (ms == 0) {
+		dev_err(&dws->master->cur_msg->spi->dev,
+			"DMA transaction timed out\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
 /*
  * dws->dma_chan_busy is set before the dma transfer starts, callback for tx
  * channel will clear a corresponding bit.
@@ -155,7 +184,7 @@ static void dw_spi_dma_tx_done(void *arg)
 		return;
 
 	dw_writel(dws, DW_SPI_DMACR, 0);
-	spi_finalize_current_transfer(dws->master);
+	complete(&dws->dma_completion);
 }
 
 static struct dma_async_tx_descriptor *dw_spi_dma_prepare_tx(struct dw_spi *dws,
@@ -204,7 +233,7 @@ static void dw_spi_dma_rx_done(void *arg)
 		return;
 
 	dw_writel(dws, DW_SPI_DMACR, 0);
-	spi_finalize_current_transfer(dws->master);
+	complete(&dws->dma_completion);
 }
 
 static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws,
@@ -260,6 +289,8 @@ static int mid_spi_dma_setup(struct dw_spi *dws, struct spi_transfer *xfer)
 	/* Set the interrupt mask */
 	spi_umask_intr(dws, imr);
 
+	reinit_completion(&dws->dma_completion);
+
 	dws->transfer_handler = dma_transfer;
 
 	return 0;
@@ -268,6 +299,7 @@ static int mid_spi_dma_setup(struct dw_spi *dws, struct spi_transfer *xfer)
 static int mid_spi_dma_transfer(struct dw_spi *dws, struct spi_transfer *xfer)
 {
 	struct dma_async_tx_descriptor *txdesc, *rxdesc;
+	int ret;
 
 	/* Prepare the TX dma transfer */
 	txdesc = dw_spi_dma_prepare_tx(dws, xfer);
@@ -288,7 +320,11 @@ static int mid_spi_dma_transfer(struct dw_spi *dws, struct spi_transfer *xfer)
 		dma_async_issue_pending(dws->txchan);
 	}
 
-	return 1;
+	ret = dw_spi_dma_wait(dws, xfer);
+	if (ret)
+		return ret;
+
+	return 0;
 }
 
 static void mid_spi_dma_stop(struct dw_spi *dws)
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 79782e93eb12..9585d0c83a6d 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -2,6 +2,7 @@
 #ifndef DW_SPI_HEADER_H
 #define DW_SPI_HEADER_H
 
+#include <linux/completion.h>
 #include <linux/irqreturn.h>
 #include <linux/io.h>
 #include <linux/scatterlist.h>
@@ -145,6 +146,7 @@ struct dw_spi {
 	unsigned long		dma_chan_busy;
 	dma_addr_t		dma_addr; /* phy address of the Data register */
 	const struct dw_spi_dma_ops *dma_ops;
+	struct completion	dma_completion;
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs;
-- 
2.26.2

