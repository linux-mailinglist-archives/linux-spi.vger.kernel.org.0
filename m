Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6821E7431
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 06:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391700AbgE2EBA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 00:01:00 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:45410 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388570AbgE2D7i (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 May 2020 23:59:38 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id A4EC38030772;
        Fri, 29 May 2020 03:59:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QASSozuuX7L8; Fri, 29 May 2020 06:59:34 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        Linus Walleij <linus.walleij@stericsson.com>,
        Feng Tang <feng.tang@intel.com>,
        Alan Cox <alan@linux.intel.com>, Vinod Koul <vkoul@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 05/16] spi: dw: Add SPI Rx-done wait method to DMA-based transfer
Date:   Fri, 29 May 2020 06:59:03 +0300
Message-ID: <20200529035915.20790-6-Sergey.Semin@baikalelectronics.ru>
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

Having any data left in the Rx FIFO after the DMA engine claimed it has
finished all DMA transactions is an abnormal situation, since the DW SPI
controller driver expects to have all the data being fetched and placed
into the SPI Rx buffer at that moment. In case if this has happened we
assume that DMA engine still may be doing the data fetching, thus we give
it sometime to finish. If after a short period of time the data is still
left in the Rx FIFO, the driver will give up waiting and return an error
indicating that the SPI controller/DMA engine must have hung up or failed
at some point of doing their duties.

Fixes: 7063c0d942a1 ("spi/dw_spi: add DMA support")
Co-developed-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Signed-off-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: devicetree@vger.kernel.org

---

Changelog v5:
- Create a dedicated patch which adds the Rx-done wait method.
- Add more detailed description of the problem the patch fixes.
- Wait for the SPI Rx transfer finish in the mid_spi_dma_transfer() method
  executed in the task context.
- Use spi_delay_exec() to wait for the SPI Rx completion, since now the
  driver does in the kernel thread context.
- Wait for a delay correlated with the APB/SSI synchronous clock rate
  instead of using the SPI bus clock rate.
---
 drivers/spi/spi-dw-mid.c | 48 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index 846e3db91329..4345881ebf66 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -248,6 +248,49 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_tx(struct dw_spi *dws,
 	return txdesc;
 }
 
+static inline bool dw_spi_dma_rx_busy(struct dw_spi *dws)
+{
+	return !!(dw_readl(dws, DW_SPI_SR) & SR_RF_NOT_EMPT);
+}
+
+static int dw_spi_dma_wait_rx_done(struct dw_spi *dws)
+{
+	int retry = WAIT_RETRIES;
+	struct spi_delay delay;
+	unsigned long ns, us;
+	u32 nents;
+
+	/*
+	 * It's unlikely that DMA engine is still doing the data fetching, but
+	 * if it's let's give it some reasonable time. The timeout calculation
+	 * is based on the synchronous APB/SSI reference clock rate, on a
+	 * number of data entries left in the Rx FIFO, times a number of clock
+	 * periods normally needed for a single APB read/write transaction
+	 * without PREADY signal utilized (which is true for the DW APB SSI
+	 * controller).
+	 */
+	nents = dw_readl(dws, DW_SPI_RXFLR);
+	ns = NSEC_PER_SEC / dws->max_freq * 4 * nents;
+	if (ns <= NSEC_PER_USEC) {
+		delay.unit = SPI_DELAY_UNIT_NSECS;
+		delay.value = ns;
+	} else {
+		us = DIV_ROUND_UP(ns, NSEC_PER_USEC);
+		delay.unit = SPI_DELAY_UNIT_USECS;
+		delay.value = clamp_val(us, 0, USHRT_MAX);
+	}
+
+	while (dw_spi_dma_rx_busy(dws) && retry--)
+		spi_delay_exec(&delay, NULL);
+
+	if (retry < 0) {
+		dev_err(&dws->master->dev, "Rx hanged up\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
 /*
  * dws->dma_chan_busy is set before the dma transfer starts, callback for rx
  * channel will clear a corresponding bit.
@@ -358,7 +401,10 @@ static int mid_spi_dma_transfer(struct dw_spi *dws, struct spi_transfer *xfer)
 			return ret;
 	}
 
-	return 0;
+	if (rxdesc && dws->master->cur_msg->status == -EINPROGRESS)
+		ret = dw_spi_dma_wait_rx_done(dws);
+
+	return ret;
 }
 
 static void mid_spi_dma_stop(struct dw_spi *dws)
-- 
2.26.2

