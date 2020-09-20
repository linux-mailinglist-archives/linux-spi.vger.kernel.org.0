Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884832713D9
	for <lists+linux-spi@lfdr.de>; Sun, 20 Sep 2020 13:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgITLc0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 20 Sep 2020 07:32:26 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:54042 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgITLc0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 20 Sep 2020 07:32:26 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id E9848803016F;
        Sun, 20 Sep 2020 11:23:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2OLrOgJxmom1; Sun, 20 Sep 2020 14:23:28 +0300 (MSK)
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
Subject: [PATCH v2 05/11] spi: dw-dma: Move DMA transfers submission to the channels prep methods
Date:   Sun, 20 Sep 2020 14:23:16 +0300
Message-ID: <20200920112322.24585-6-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200920112322.24585-1-Sergey.Semin@baikalelectronics.ru>
References: <20200920112322.24585-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Indeed we can freely move the dmaengine_submit() method invocation and the
Tx and Rx busy flag setting into the DMA Tx/Rx prepare methods. Since the
Tx/Rx preparation method is now mainly used for the DMA transfers
submission, here we suggest to rename it to have the _submit_{r,t}x suffix
instead.

By having this alteration applied first we implement another code
preparation before adding the one-by-one DMA SG entries transmission,
second we now have the dma_async_tx_descriptor descriptor used locally
only in the new DMA transfers submission methods (this will be cleaned up
a bit later), third we make the generic transfer method more readable,
where now the functionality of submission, execution and wait procedures
is transparently split up instead of having a preparation, intermixed
submission/execution and wait procedures.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-dma.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index d2a67dee1a66..769d10ca74b4 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -272,7 +272,7 @@ static int dw_spi_dma_config_tx(struct dw_spi *dws)
 }
 
 static struct dma_async_tx_descriptor *
-dw_spi_dma_prepare_tx(struct dw_spi *dws, struct spi_transfer *xfer)
+dw_spi_dma_submit_tx(struct dw_spi *dws, struct spi_transfer *xfer)
 {
 	struct dma_async_tx_descriptor *txdesc;
 
@@ -287,6 +287,9 @@ dw_spi_dma_prepare_tx(struct dw_spi *dws, struct spi_transfer *xfer)
 	txdesc->callback = dw_spi_dma_tx_done;
 	txdesc->callback_param = dws;
 
+	dmaengine_submit(txdesc);
+	set_bit(TX_BUSY, &dws->dma_chan_busy);
+
 	return txdesc;
 }
 
@@ -364,7 +367,7 @@ static int dw_spi_dma_config_rx(struct dw_spi *dws)
 	return dmaengine_slave_config(dws->rxchan, &rxconf);
 }
 
-static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws,
+static struct dma_async_tx_descriptor *dw_spi_dma_submit_rx(struct dw_spi *dws,
 		struct spi_transfer *xfer)
 {
 	struct dma_async_tx_descriptor *rxdesc;
@@ -380,6 +383,9 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws,
 	rxdesc->callback = dw_spi_dma_rx_done;
 	rxdesc->callback_param = dws;
 
+	dmaengine_submit(rxdesc);
+	set_bit(RX_BUSY, &dws->dma_chan_busy);
+
 	return rxdesc;
 }
 
@@ -426,25 +432,21 @@ static int dw_spi_dma_transfer(struct dw_spi *dws, struct spi_transfer *xfer)
 	struct dma_async_tx_descriptor *txdesc, *rxdesc;
 	int ret;
 
-	/* Prepare the TX dma transfer */
-	txdesc = dw_spi_dma_prepare_tx(dws, xfer);
+	/* Submit the DMA Tx transfer */
+	txdesc = dw_spi_dma_submit_tx(dws, xfer);
 	if (!txdesc)
 		return -EINVAL;
 
-	/* Prepare the RX dma transfer */
+	/* Submit the DMA Rx transfer if required */
 	if (xfer->rx_buf) {
-		rxdesc = dw_spi_dma_prepare_rx(dws, xfer);
+		rxdesc = dw_spi_dma_submit_rx(dws, xfer);
 		if (!rxdesc)
 			return -EINVAL;
 
 		/* rx must be started before tx due to spi instinct */
-		set_bit(RX_BUSY, &dws->dma_chan_busy);
-		dmaengine_submit(rxdesc);
 		dma_async_issue_pending(dws->rxchan);
 	}
 
-	set_bit(TX_BUSY, &dws->dma_chan_busy);
-	dmaengine_submit(txdesc);
 	dma_async_issue_pending(dws->txchan);
 
 	ret = dw_spi_dma_wait(dws, xfer);
-- 
2.27.0

