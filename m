Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFA3228A14
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jul 2020 22:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgGUUkB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Jul 2020 16:40:01 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:56042 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbgGUUkB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Jul 2020 16:40:01 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 342028030867;
        Tue, 21 Jul 2020 20:39:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Gn8VD52v5llM; Tue, 21 Jul 2020 23:39:58 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Feng Tang <feng.tang@intel.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] spi: dw-dma: Fix Tx DMA channel working too fast
Date:   Tue, 21 Jul 2020 23:39:51 +0300
Message-ID: <20200721203951.2159-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

It turns out having a Rx DMA channel serviced with higher priority than
a Tx DMA channel is not enough to provide a well balanced DMA-based SPI
transfer interface. There might still be moments when the Tx DMA channel
is occasionally handled faster than the Rx DMA channel. That in its turn
will eventually cause the SPI Rx FIFO overflow if SPI bus speed is high
enough to fill the SPI Rx FIFO in before it's cleared by the Rx DMA
channel. That's why having the DMA-based SPI Tx interface too optimized
is the errors prone, so the commit 0b2b66514fc9 ("spi: dw: Use DMA max
burst to set the request thresholds") though being perfectly normal from
the standard functionality point of view implicitly introduced the problem
described above. In order to fix that the Tx DMA activity is intentionally
slowed down by limiting the SPI Tx FIFO depth with a value twice bigger
than the Tx burst length calculated earlier by the
dw_spi_dma_maxburst_init() method.

Fixes: 0b2b66514fc9 ("spi: dw: Use DMA max burst to set the request thresholds")
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Feng Tang <feng.tang@intel.com>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-dma.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index 5986c520b196..bb390ff67d1d 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -372,8 +372,20 @@ static int dw_spi_dma_setup(struct dw_spi *dws, struct spi_transfer *xfer)
 {
 	u16 imr = 0, dma_ctrl = 0;
 
+	/*
+	 * Having a Rx DMA channel serviced with higher priority than a Tx DMA
+	 * channel might not be enough to provide a well balanced DMA-based
+	 * SPI transfer interface. There might still be moments when the Tx DMA
+	 * channel is occasionally handled faster than the Rx DMA channel.
+	 * That in its turn will eventually cause the SPI Rx FIFO overflow if
+	 * SPI bus speed is high enough to fill the SPI Rx FIFO in before it's
+	 * cleared by the Rx DMA channel. In order to fix the problem the Tx
+	 * DMA activity is intentionally slowed down by limiting the SPI Tx
+	 * FIFO depth with a value twice bigger than the Tx burst length
+	 * calculated earlier by the dw_spi_dma_maxburst_init() method.
+	 */
 	dw_writel(dws, DW_SPI_DMARDLR, dws->rxburst - 1);
-	dw_writel(dws, DW_SPI_DMATDLR, dws->fifo_len - dws->txburst);
+	dw_writel(dws, DW_SPI_DMATDLR, dws->txburst);
 
 	if (xfer->tx_buf)
 		dma_ctrl |= SPI_DMA_TDMAE;
-- 
2.26.2

