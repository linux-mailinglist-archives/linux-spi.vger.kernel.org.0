Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49E22340B8
	for <lists+linux-spi@lfdr.de>; Fri, 31 Jul 2020 10:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731435AbgGaIAV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 31 Jul 2020 04:00:21 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:59730 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731539AbgGaIAE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 31 Jul 2020 04:00:04 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 74B308030808;
        Fri, 31 Jul 2020 08:00:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QbiS43k0K67d; Fri, 31 Jul 2020 10:59:59 +0300 (MSK)
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
Subject: [PATCH 4/8] spi: dw-dma: Move DMA transfers submission to the channels prep methods
Date:   Fri, 31 Jul 2020 10:59:49 +0300
Message-ID: <20200731075953.14416-5-Sergey.Semin@baikalelectronics.ru>
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

Indeed we can freely move the dmaengine_submit() method invocation and the
Tx and Rx busy flag setting into the DMA Tx/Rx prepare methods. By doing
so first we implement another preparation before adding the one-by-one DMA
SG entries transmission, second we now have the dma_async_tx_descriptor
descriptor used locally only in the new DMA transfers submitition methods,
which makes the code less complex with no passing around the DMA Tx
descriptors, third we make the generic transfer method more readable, where
now the functionality of submission, execution and wait procedures is
transparently split up instead of having a preparation, intermixed
submission/execution and wait procedures. While at it we also add the
dmaengine_submit() return value test. It has been unnecessary for
DW DMAC, but should be done to support the generic DMA interface.

Note since the DMA channels preparation methods are now responsible for
the DMA transactions submission, we also rename them to
dw_spi_dma_submit_{tx,rx}().

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-dma.c | 56 ++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index 56496b659d62..366978086781 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -272,10 +272,11 @@ static int dw_spi_dma_config_tx(struct dw_spi *dws)
 	return dmaengine_slave_config(dws->txchan, &txconf);
 }
 
-static struct dma_async_tx_descriptor *
-dw_spi_dma_prepare_tx(struct dw_spi *dws, struct spi_transfer *xfer)
+static int dw_spi_dma_submit_tx(struct dw_spi *dws, struct spi_transfer *xfer)
 {
 	struct dma_async_tx_descriptor *txdesc;
+	dma_cookie_t cookie;
+	int ret;
 
 	txdesc = dmaengine_prep_slave_sg(dws->txchan,
 				xfer->tx_sg.sgl,
@@ -283,12 +284,17 @@ dw_spi_dma_prepare_tx(struct dw_spi *dws, struct spi_transfer *xfer)
 				DMA_MEM_TO_DEV,
 				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!txdesc)
-		return NULL;
+		return -ENOMEM;
 
 	txdesc->callback = dw_spi_dma_tx_done;
 	txdesc->callback_param = dws;
 
-	return txdesc;
+	cookie = dmaengine_submit(txdesc);
+	ret = dma_submit_error(cookie);
+	if (!ret)
+		set_bit(TX_BUSY, &dws->dma_chan_busy);
+
+	return ret;
 }
 
 static inline bool dw_spi_dma_rx_busy(struct dw_spi *dws)
@@ -365,13 +371,11 @@ static int dw_spi_dma_config_rx(struct dw_spi *dws)
 	return dmaengine_slave_config(dws->rxchan, &rxconf);
 }
 
-static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws,
-		struct spi_transfer *xfer)
+static int dw_spi_dma_submit_rx(struct dw_spi *dws, struct spi_transfer *xfer)
 {
 	struct dma_async_tx_descriptor *rxdesc;
-
-	if (!xfer->rx_buf)
-		return NULL;
+	dma_cookie_t cookie;
+	int ret;
 
 	rxdesc = dmaengine_prep_slave_sg(dws->rxchan,
 				xfer->rx_sg.sgl,
@@ -379,12 +383,17 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws,
 				DMA_DEV_TO_MEM,
 				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!rxdesc)
-		return NULL;
+		return -ENOMEM;
 
 	rxdesc->callback = dw_spi_dma_rx_done;
 	rxdesc->callback_param = dws;
 
-	return rxdesc;
+	cookie = dmaengine_submit(rxdesc);
+	ret = dma_submit_error(cookie);
+	if (!ret)
+		set_bit(RX_BUSY, &dws->dma_chan_busy);
+
+	return ret;
 }
 
 static int dw_spi_dma_setup(struct dw_spi *dws, struct spi_transfer *xfer)
@@ -427,26 +436,23 @@ static int dw_spi_dma_setup(struct dw_spi *dws, struct spi_transfer *xfer)
 
 static int dw_spi_dma_transfer(struct dw_spi *dws, struct spi_transfer *xfer)
 {
-	struct dma_async_tx_descriptor *txdesc, *rxdesc;
 	int ret;
 
-	/* Prepare the TX dma transfer */
-	txdesc = dw_spi_dma_prepare_tx(dws, xfer);
-	if (!txdesc)
-		return -EINVAL;
+	/* Submit DMA Tx transfer */
+	ret = dw_spi_dma_submit_tx(dws, xfer);
+	if (ret)
+		return ret;
 
-	/* Prepare the RX dma transfer */
-	rxdesc = dw_spi_dma_prepare_rx(dws, xfer);
+	/* Submit DMA Rx transfer if required */
+	if (xfer->rx_buf) {
+		ret = dw_spi_dma_submit_rx(dws, xfer);
+		if (ret)
+			return ret;
 
-	/* rx must be started before tx due to spi instinct */
-	if (rxdesc) {
-		set_bit(RX_BUSY, &dws->dma_chan_busy);
-		dmaengine_submit(rxdesc);
+		/* rx must be started before tx due to spi instinct */
 		dma_async_issue_pending(dws->rxchan);
 	}
 
-	set_bit(TX_BUSY, &dws->dma_chan_busy);
-	dmaengine_submit(txdesc);
 	dma_async_issue_pending(dws->txchan);
 
 	ret = dw_spi_dma_wait(dws, xfer);
@@ -459,7 +465,7 @@ static int dw_spi_dma_transfer(struct dw_spi *dws, struct spi_transfer *xfer)
 			return ret;
 	}
 
-	if (rxdesc && dws->master->cur_msg->status == -EINPROGRESS)
+	if (xfer->rx_buf && dws->master->cur_msg->status == -EINPROGRESS)
 		ret = dw_spi_dma_wait_rx_done(dws);
 
 	return ret;
-- 
2.27.0

