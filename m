Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBB12340A8
	for <lists+linux-spi@lfdr.de>; Fri, 31 Jul 2020 10:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731613AbgGaIAE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 31 Jul 2020 04:00:04 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:59710 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731530AbgGaIAC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 31 Jul 2020 04:00:02 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id B82B6803202D;
        Fri, 31 Jul 2020 07:59:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dhj8sOxTMUso; Fri, 31 Jul 2020 10:59:59 +0300 (MSK)
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
Subject: [PATCH 3/8] spi: dw-dma: Configure the DMA channels in dma_setup
Date:   Fri, 31 Jul 2020 10:59:48 +0300
Message-ID: <20200731075953.14416-4-Sergey.Semin@baikalelectronics.ru>
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

Mainly this is a preparation patch before adding one-by-one DMA SG entries
transmission. But logically the Tx and Rx DMA channels setup should be
performed in the dma_setup() callback anyway. So let's move the DMA slave
channels src/dst burst lengths, address and address width configuration to
the DMA setup stage. While at it make sure the return value of the
dmaengine_slave_config() method is checked. It has been unnecessary in
case if Dw DMAC is utilized as a DMA engine, since its device_config()
callback always returns zero (though it might change in future). But since
DW APB SSI driver now supports any DMA back-end we must make sure the
DMA device configuration has been successful before proceeding with
further setups.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-dma.c | 42 +++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index ec721af61663..56496b659d62 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -257,11 +257,9 @@ static void dw_spi_dma_tx_done(void *arg)
 	complete(&dws->dma_completion);
 }
 
-static struct dma_async_tx_descriptor *
-dw_spi_dma_prepare_tx(struct dw_spi *dws, struct spi_transfer *xfer)
+static int dw_spi_dma_config_tx(struct dw_spi *dws)
 {
 	struct dma_slave_config txconf;
-	struct dma_async_tx_descriptor *txdesc;
 
 	memset(&txconf, 0, sizeof(txconf));
 	txconf.direction = DMA_MEM_TO_DEV;
@@ -271,7 +269,13 @@ dw_spi_dma_prepare_tx(struct dw_spi *dws, struct spi_transfer *xfer)
 	txconf.dst_addr_width = dw_spi_dma_convert_width(dws->n_bytes);
 	txconf.device_fc = false;
 
-	dmaengine_slave_config(dws->txchan, &txconf);
+	return dmaengine_slave_config(dws->txchan, &txconf);
+}
+
+static struct dma_async_tx_descriptor *
+dw_spi_dma_prepare_tx(struct dw_spi *dws, struct spi_transfer *xfer)
+{
+	struct dma_async_tx_descriptor *txdesc;
 
 	txdesc = dmaengine_prep_slave_sg(dws->txchan,
 				xfer->tx_sg.sgl,
@@ -346,14 +350,9 @@ static void dw_spi_dma_rx_done(void *arg)
 	complete(&dws->dma_completion);
 }
 
-static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws,
-		struct spi_transfer *xfer)
+static int dw_spi_dma_config_rx(struct dw_spi *dws)
 {
 	struct dma_slave_config rxconf;
-	struct dma_async_tx_descriptor *rxdesc;
-
-	if (!xfer->rx_buf)
-		return NULL;
 
 	memset(&rxconf, 0, sizeof(rxconf));
 	rxconf.direction = DMA_DEV_TO_MEM;
@@ -363,7 +362,16 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws,
 	rxconf.src_addr_width = dw_spi_dma_convert_width(dws->n_bytes);
 	rxconf.device_fc = false;
 
-	dmaengine_slave_config(dws->rxchan, &rxconf);
+	return dmaengine_slave_config(dws->rxchan, &rxconf);
+}
+
+static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws,
+		struct spi_transfer *xfer)
+{
+	struct dma_async_tx_descriptor *rxdesc;
+
+	if (!xfer->rx_buf)
+		return NULL;
 
 	rxdesc = dmaengine_prep_slave_sg(dws->rxchan,
 				xfer->rx_sg.sgl,
@@ -382,10 +390,22 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws,
 static int dw_spi_dma_setup(struct dw_spi *dws, struct spi_transfer *xfer)
 {
 	u16 imr, dma_ctrl;
+	int ret;
 
 	if (!xfer->tx_buf)
 		return -EINVAL;
 
+	/* Setup DMA channels */
+	ret = dw_spi_dma_config_tx(dws);
+	if (ret)
+		return ret;
+
+	if (xfer->rx_buf) {
+		ret = dw_spi_dma_config_rx(dws);
+		if (ret)
+			return ret;
+	}
+
 	/* Set the DMA handshaking interface */
 	dma_ctrl = SPI_DMA_TDMAE;
 	if (xfer->rx_buf)
-- 
2.27.0

