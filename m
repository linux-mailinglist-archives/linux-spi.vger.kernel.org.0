Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35092340AD
	for <lists+linux-spi@lfdr.de>; Fri, 31 Jul 2020 10:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbgGaIAF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 31 Jul 2020 04:00:05 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:59786 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731675AbgGaIAF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 31 Jul 2020 04:00:05 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 99E628040A6A;
        Fri, 31 Jul 2020 08:00:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 447pCloz0qIS; Fri, 31 Jul 2020 11:00:01 +0300 (MSK)
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
Subject: [PATCH 7/8] spi: dw-dma: Pass exact data to the DMA submit and wait methods
Date:   Fri, 31 Jul 2020 10:59:52 +0300
Message-ID: <20200731075953.14416-8-Sergey.Semin@baikalelectronics.ru>
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

In order to use the DMA submission and waiting methods in both generic
DMA-based SPI transfer and one-by-one DMA SG entries transmission
functions, we need to modify the dw_spi_dma_wait() and
dw_spi_dma_submit_tx()/dw_spi_dma_submit_rx() prototypes. So instead of
getting the SPI transfer object as the second argument they must accept
the exact data structure instances they imply to use. Those are the
current transfer length and the SPI bus frequency in case of
dw_spi_dma_wait(), and SG list together with number of list entries in
case of the DMA Tx/Rx submission methods.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-dma.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index f8508c0c7978..2b42b42b6cf2 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -189,12 +189,12 @@ static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes)
 	return DMA_SLAVE_BUSWIDTH_UNDEFINED;
 }
 
-static int dw_spi_dma_wait(struct dw_spi *dws, struct spi_transfer *xfer)
+static int dw_spi_dma_wait(struct dw_spi *dws, unsigned int len, u32 speed)
 {
 	unsigned long long ms;
 
-	ms = xfer->len * MSEC_PER_SEC * BITS_PER_BYTE;
-	do_div(ms, xfer->effective_speed_hz);
+	ms = len * MSEC_PER_SEC * BITS_PER_BYTE;
+	do_div(ms, speed);
 	ms += ms + 200;
 
 	if (ms > UINT_MAX)
@@ -269,17 +269,16 @@ static int dw_spi_dma_config_tx(struct dw_spi *dws)
 	return dmaengine_slave_config(dws->txchan, &txconf);
 }
 
-static int dw_spi_dma_submit_tx(struct dw_spi *dws, struct spi_transfer *xfer)
+static int dw_spi_dma_submit_tx(struct dw_spi *dws, struct scatterlist *sgl,
+				unsigned int nents)
 {
 	struct dma_async_tx_descriptor *txdesc;
 	dma_cookie_t cookie;
 	int ret;
 
-	txdesc = dmaengine_prep_slave_sg(dws->txchan,
-				xfer->tx_sg.sgl,
-				xfer->tx_sg.nents,
-				DMA_MEM_TO_DEV,
-				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	txdesc = dmaengine_prep_slave_sg(dws->txchan, sgl, nents,
+					 DMA_MEM_TO_DEV,
+					 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!txdesc)
 		return -ENOMEM;
 
@@ -367,17 +366,16 @@ static int dw_spi_dma_config_rx(struct dw_spi *dws)
 	return dmaengine_slave_config(dws->rxchan, &rxconf);
 }
 
-static int dw_spi_dma_submit_rx(struct dw_spi *dws, struct spi_transfer *xfer)
+static int dw_spi_dma_submit_rx(struct dw_spi *dws, struct scatterlist *sgl,
+				unsigned int nents)
 {
 	struct dma_async_tx_descriptor *rxdesc;
 	dma_cookie_t cookie;
 	int ret;
 
-	rxdesc = dmaengine_prep_slave_sg(dws->rxchan,
-				xfer->rx_sg.sgl,
-				xfer->rx_sg.nents,
-				DMA_DEV_TO_MEM,
-				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	rxdesc = dmaengine_prep_slave_sg(dws->rxchan, sgl, nents,
+					 DMA_DEV_TO_MEM,
+					 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!rxdesc)
 		return -ENOMEM;
 
@@ -436,13 +434,14 @@ static int dw_spi_dma_transfer_all(struct dw_spi *dws,
 	int ret;
 
 	/* Submit DMA Tx transfer */
-	ret = dw_spi_dma_submit_tx(dws, xfer);
+	ret = dw_spi_dma_submit_tx(dws, xfer->tx_sg.sgl, xfer->tx_sg.nents);
 	if (ret)
 		goto err_clear_dmac;
 
 	/* Submit DMA Rx transfer if required */
 	if (xfer->rx_buf) {
-		ret = dw_spi_dma_submit_rx(dws, xfer);
+		ret = dw_spi_dma_submit_rx(dws, xfer->rx_sg.sgl,
+					   xfer->rx_sg.nents);
 		if (ret)
 			goto err_clear_dmac;
 
@@ -452,7 +451,7 @@ static int dw_spi_dma_transfer_all(struct dw_spi *dws,
 
 	dma_async_issue_pending(dws->txchan);
 
-	ret = dw_spi_dma_wait(dws, xfer);
+	ret = dw_spi_dma_wait(dws, xfer->len, xfer->effective_speed_hz);
 
 err_clear_dmac:
 	dw_writel(dws, DW_SPI_DMACR, 0);
-- 
2.27.0

