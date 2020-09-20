Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE192713DC
	for <lists+linux-spi@lfdr.de>; Sun, 20 Sep 2020 13:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgITLc2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 20 Sep 2020 07:32:28 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:54052 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgITLc1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 20 Sep 2020 07:32:27 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 8DD0B8030171;
        Sun, 20 Sep 2020 11:23:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RpDXG3G2kXML; Sun, 20 Sep 2020 14:23:29 +0300 (MSK)
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
Subject: [PATCH v2 06/11] spi: dw-dma: Check DMA Tx-desc submission status
Date:   Sun, 20 Sep 2020 14:23:17 +0300
Message-ID: <20200920112322.24585-7-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200920112322.24585-1-Sergey.Semin@baikalelectronics.ru>
References: <20200920112322.24585-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

We suggest to add the dmaengine_submit() return value test for errors.  It
has been unnecessary while the driver was expected to be utilized in pair
with DW DMAC. But since now the driver can be used with any DMA engine, it
might be useful to track the errors on DMA submissions so not miss them
and get into an unpredictable driver behaviour.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v2:
- Replace negative conditional statements with the positive ones.
- Terminate the prepared descriptors on submission errors.
---
 drivers/spi/spi-dw-dma.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index 769d10ca74b4..aa3900809126 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -275,6 +275,8 @@ static struct dma_async_tx_descriptor *
 dw_spi_dma_submit_tx(struct dw_spi *dws, struct spi_transfer *xfer)
 {
 	struct dma_async_tx_descriptor *txdesc;
+	dma_cookie_t cookie;
+	int ret;
 
 	txdesc = dmaengine_prep_slave_sg(dws->txchan,
 				xfer->tx_sg.sgl,
@@ -287,7 +289,13 @@ dw_spi_dma_submit_tx(struct dw_spi *dws, struct spi_transfer *xfer)
 	txdesc->callback = dw_spi_dma_tx_done;
 	txdesc->callback_param = dws;
 
-	dmaengine_submit(txdesc);
+	cookie = dmaengine_submit(txdesc);
+	ret = dma_submit_error(cookie);
+	if (ret) {
+		dmaengine_terminate_sync(dws->txchan);
+		return NULL;
+	}
+
 	set_bit(TX_BUSY, &dws->dma_chan_busy);
 
 	return txdesc;
@@ -371,6 +379,8 @@ static struct dma_async_tx_descriptor *dw_spi_dma_submit_rx(struct dw_spi *dws,
 		struct spi_transfer *xfer)
 {
 	struct dma_async_tx_descriptor *rxdesc;
+	dma_cookie_t cookie;
+	int ret;
 
 	rxdesc = dmaengine_prep_slave_sg(dws->rxchan,
 				xfer->rx_sg.sgl,
@@ -383,7 +393,13 @@ static struct dma_async_tx_descriptor *dw_spi_dma_submit_rx(struct dw_spi *dws,
 	rxdesc->callback = dw_spi_dma_rx_done;
 	rxdesc->callback_param = dws;
 
-	dmaengine_submit(rxdesc);
+	cookie = dmaengine_submit(rxdesc);
+	ret = dma_submit_error(cookie);
+	if (ret) {
+		dmaengine_terminate_sync(dws->rxchan);
+		return NULL;
+	}
+
 	set_bit(RX_BUSY, &dws->dma_chan_busy);
 
 	return rxdesc;
-- 
2.27.0

