Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD4D2713D5
	for <lists+linux-spi@lfdr.de>; Sun, 20 Sep 2020 13:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgITLcY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 20 Sep 2020 07:32:24 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:54020 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgITLcX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 20 Sep 2020 07:32:23 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 4655B8030833;
        Sun, 20 Sep 2020 11:23:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3DB0P7RBo_ww; Sun, 20 Sep 2020 14:23:29 +0300 (MSK)
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
Subject: [PATCH v2 07/11] spi: dw-dma: Remove DMA Tx-desc passing around
Date:   Sun, 20 Sep 2020 14:23:18 +0300
Message-ID: <20200920112322.24585-8-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200920112322.24585-1-Sergey.Semin@baikalelectronics.ru>
References: <20200920112322.24585-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

It's pointless to pass the Rx and Tx transfers DMA Tx-descriptors, since
they are used in the Tx/Rx submit method only. Instead just return the
submission status from these methods. This alteration will make the code
less complex.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-dma.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index aa3900809126..9f70818acce6 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -271,8 +271,7 @@ static int dw_spi_dma_config_tx(struct dw_spi *dws)
 	return dmaengine_slave_config(dws->txchan, &txconf);
 }
 
-static struct dma_async_tx_descriptor *
-dw_spi_dma_submit_tx(struct dw_spi *dws, struct spi_transfer *xfer)
+static int dw_spi_dma_submit_tx(struct dw_spi *dws, struct spi_transfer *xfer)
 {
 	struct dma_async_tx_descriptor *txdesc;
 	dma_cookie_t cookie;
@@ -284,7 +283,7 @@ dw_spi_dma_submit_tx(struct dw_spi *dws, struct spi_transfer *xfer)
 				DMA_MEM_TO_DEV,
 				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!txdesc)
-		return NULL;
+		return -ENOMEM;
 
 	txdesc->callback = dw_spi_dma_tx_done;
 	txdesc->callback_param = dws;
@@ -293,12 +292,12 @@ dw_spi_dma_submit_tx(struct dw_spi *dws, struct spi_transfer *xfer)
 	ret = dma_submit_error(cookie);
 	if (ret) {
 		dmaengine_terminate_sync(dws->txchan);
-		return NULL;
+		return ret;
 	}
 
 	set_bit(TX_BUSY, &dws->dma_chan_busy);
 
-	return txdesc;
+	return 0;
 }
 
 static inline bool dw_spi_dma_rx_busy(struct dw_spi *dws)
@@ -375,8 +374,7 @@ static int dw_spi_dma_config_rx(struct dw_spi *dws)
 	return dmaengine_slave_config(dws->rxchan, &rxconf);
 }
 
-static struct dma_async_tx_descriptor *dw_spi_dma_submit_rx(struct dw_spi *dws,
-		struct spi_transfer *xfer)
+static int dw_spi_dma_submit_rx(struct dw_spi *dws, struct spi_transfer *xfer)
 {
 	struct dma_async_tx_descriptor *rxdesc;
 	dma_cookie_t cookie;
@@ -388,7 +386,7 @@ static struct dma_async_tx_descriptor *dw_spi_dma_submit_rx(struct dw_spi *dws,
 				DMA_DEV_TO_MEM,
 				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!rxdesc)
-		return NULL;
+		return -ENOMEM;
 
 	rxdesc->callback = dw_spi_dma_rx_done;
 	rxdesc->callback_param = dws;
@@ -397,12 +395,12 @@ static struct dma_async_tx_descriptor *dw_spi_dma_submit_rx(struct dw_spi *dws,
 	ret = dma_submit_error(cookie);
 	if (ret) {
 		dmaengine_terminate_sync(dws->rxchan);
-		return NULL;
+		return ret;
 	}
 
 	set_bit(RX_BUSY, &dws->dma_chan_busy);
 
-	return rxdesc;
+	return 0;
 }
 
 static int dw_spi_dma_setup(struct dw_spi *dws, struct spi_transfer *xfer)
@@ -445,19 +443,18 @@ static int dw_spi_dma_setup(struct dw_spi *dws, struct spi_transfer *xfer)
 
 static int dw_spi_dma_transfer(struct dw_spi *dws, struct spi_transfer *xfer)
 {
-	struct dma_async_tx_descriptor *txdesc, *rxdesc;
 	int ret;
 
 	/* Submit the DMA Tx transfer */
-	txdesc = dw_spi_dma_submit_tx(dws, xfer);
-	if (!txdesc)
-		return -EINVAL;
+	ret = dw_spi_dma_submit_tx(dws, xfer);
+	if (ret)
+		return ret;
 
 	/* Submit the DMA Rx transfer if required */
 	if (xfer->rx_buf) {
-		rxdesc = dw_spi_dma_submit_rx(dws, xfer);
-		if (!rxdesc)
-			return -EINVAL;
+		ret = dw_spi_dma_submit_rx(dws, xfer);
+		if (ret)
+			return ret;
 
 		/* rx must be started before tx due to spi instinct */
 		dma_async_issue_pending(dws->rxchan);
-- 
2.27.0

