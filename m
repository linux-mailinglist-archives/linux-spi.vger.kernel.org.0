Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B10C2713DB
	for <lists+linux-spi@lfdr.de>; Sun, 20 Sep 2020 13:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgITLc1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 20 Sep 2020 07:32:27 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:54054 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgITLc0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 20 Sep 2020 07:32:26 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 5338A8030865;
        Sun, 20 Sep 2020 11:23:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 32H5h15es7Nm; Sun, 20 Sep 2020 14:23:25 +0300 (MSK)
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
Subject: [PATCH v2 01/11] spi: dw-dma: Set DMA Level registers on init
Date:   Sun, 20 Sep 2020 14:23:12 +0300
Message-ID: <20200920112322.24585-2-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200920112322.24585-1-Sergey.Semin@baikalelectronics.ru>
References: <20200920112322.24585-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Indeed the registers content doesn't get cleared when the SPI controller
is disabled and enabled. Max burst lengths aren't changed since the Rx and
Tx DMA channels are requested on init stage and are kept acquired until
the device is removed. Obviously SPI controller FIFO depth can't be
changed. Due to all of that we can safely move the DMA Transmit and
Receive data level registers initialization to the SPI controller DMA init
stage (when the SPI controller is being probed) instead of doing it for
each SPI transfer when dma_setup is called. This shall speed the DMA-based
SPI transfer initialization up a bit, particularly if the APB bus is
relatively slow.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-dma.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index bb390ff67d1d..a7ff1e357f8b 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -49,6 +49,7 @@ static void dw_spi_dma_maxburst_init(struct dw_spi *dws)
 		max_burst = RX_BURST_LEVEL;
 
 	dws->rxburst = min(max_burst, def_burst);
+	dw_writel(dws, DW_SPI_DMARDLR, dws->rxburst - 1);
 
 	ret = dma_get_slave_caps(dws->txchan, &caps);
 	if (!ret && caps.max_burst)
@@ -56,7 +57,19 @@ static void dw_spi_dma_maxburst_init(struct dw_spi *dws)
 	else
 		max_burst = TX_BURST_LEVEL;
 
+	/*
+	 * Having a Rx DMA channel serviced with higher priority than a Tx DMA
+	 * channel might not be enough to provide a well balanced DMA-based
+	 * SPI transfer interface. There might still be moments when the Tx DMA
+	 * channel is occasionally handled faster than the Rx DMA channel.
+	 * That in its turn will eventually cause the SPI Rx FIFO overflow if
+	 * SPI bus speed is high enough to fill the SPI Rx FIFO in before it's
+	 * cleared by the Rx DMA channel. In order to fix the problem the Tx
+	 * DMA activity is intentionally slowed down by limiting the SPI Tx
+	 * FIFO depth with a value twice bigger than the Tx burst length.
+	 */
 	dws->txburst = min(max_burst, def_burst);
+	dw_writel(dws, DW_SPI_DMATDLR, dws->txburst);
 }
 
 static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
@@ -372,21 +385,6 @@ static int dw_spi_dma_setup(struct dw_spi *dws, struct spi_transfer *xfer)
 {
 	u16 imr = 0, dma_ctrl = 0;
 
-	/*
-	 * Having a Rx DMA channel serviced with higher priority than a Tx DMA
-	 * channel might not be enough to provide a well balanced DMA-based
-	 * SPI transfer interface. There might still be moments when the Tx DMA
-	 * channel is occasionally handled faster than the Rx DMA channel.
-	 * That in its turn will eventually cause the SPI Rx FIFO overflow if
-	 * SPI bus speed is high enough to fill the SPI Rx FIFO in before it's
-	 * cleared by the Rx DMA channel. In order to fix the problem the Tx
-	 * DMA activity is intentionally slowed down by limiting the SPI Tx
-	 * FIFO depth with a value twice bigger than the Tx burst length
-	 * calculated earlier by the dw_spi_dma_maxburst_init() method.
-	 */
-	dw_writel(dws, DW_SPI_DMARDLR, dws->rxburst - 1);
-	dw_writel(dws, DW_SPI_DMATDLR, dws->txburst);
-
 	if (xfer->tx_buf)
 		dma_ctrl |= SPI_DMA_TDMAE;
 	if (xfer->rx_buf)
-- 
2.27.0

