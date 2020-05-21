Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20021DC48F
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 03:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgEUBWs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 May 2020 21:22:48 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:33776 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgEUBWr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 May 2020 21:22:47 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id D24808030779;
        Thu, 21 May 2020 01:22:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WcfgVTapab-x; Thu, 21 May 2020 04:22:44 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        Vinod Koul <vkoul@kernel.org>, Feng Tang <feng.tang@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Linus Walleij <linus.walleij@stericsson.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Clement Leger <cleger@kalray.eu>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 01/16] spi: dw: Add Tx/Rx finish wait methods to the MID DMA
Date:   Thu, 21 May 2020 04:21:51 +0300
Message-ID: <20200521012206.14472-2-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200521012206.14472-1-Sergey.Semin@baikalelectronics.ru>
References: <20200521012206.14472-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Since DMA transfers are performed asynchronously with actual SPI
transaction, then even if DMA transfers are finished it doesn't mean
all data is actually pushed to the SPI bus. Some data might still be
in the controller FIFO. This is specifically true for Tx-only
transfers. In this case if the next SPI transfer is recharged while
a tail of the previous one is still in FIFO, we'll loose that tail
data. In order to fix this lets add the wait procedure of the Tx/Rx
SPI transfers completion after the corresponding DMA transactions
are finished.

Co-developed-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Signed-off-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Fixes: 7063c0d942a1 ("spi/dw_spi: add DMA support")
Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: devicetree@vger.kernel.org

---

Changelog v2:
- Use conditional statement instead of the ternary operator in the ref
  clock getter.
- Move the patch to the head of the series so one could be picked up to
  the stable kernels as a fix.

Changelog v3:
- Use spi_delay_exec() method to wait for the current operation completion.
---
 drivers/spi/spi-dw-mid.c | 69 ++++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-dw.h     | 10 ++++++
 2 files changed, 79 insertions(+)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index f9757a370699..3526b196a7fc 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -17,6 +17,7 @@
 #include <linux/pci.h>
 #include <linux/platform_data/dma-dw.h>
 
+#define WAIT_RETRIES	5
 #define RX_BUSY		0
 #define TX_BUSY		1
 
@@ -143,6 +144,47 @@ static enum dma_slave_buswidth convert_dma_width(u32 dma_width) {
 	return DMA_SLAVE_BUSWIDTH_UNDEFINED;
 }
 
+static void dw_spi_dma_calc_delay(struct dw_spi *dws, u32 nents,
+				  struct spi_delay *delay)
+{
+	unsigned long ns, us;
+
+	ns = (NSEC_PER_SEC / spi_get_clk(dws)) * nents * dws->n_bytes *
+	     BITS_PER_BYTE;
+
+	if (ns <= NSEC_PER_USEC) {
+		delay->unit = SPI_DELAY_UNIT_NSECS;
+		delay->value = ns;
+	} else {
+		us = DIV_ROUND_UP(ns, NSEC_PER_USEC);
+		delay->unit = SPI_DELAY_UNIT_USECS;
+		delay->value = clamp_val(us, 0, USHRT_MAX);
+	}
+}
+
+static inline bool dw_spi_dma_tx_busy(struct dw_spi *dws)
+{
+	return !(dw_readl(dws, DW_SPI_SR) & SR_TF_EMPT);
+}
+
+static void dw_spi_dma_wait_tx_done(struct dw_spi *dws)
+{
+	int retry = WAIT_RETRIES;
+	struct spi_delay delay;
+	u32 nents;
+
+	nents = dw_readl(dws, DW_SPI_TXFLR);
+	dw_spi_dma_calc_delay(dws, nents, &delay);
+
+	while (dw_spi_dma_tx_busy(dws) && retry--)
+		spi_delay_exec(&delay, NULL);
+
+	if (retry < 0) {
+		dev_err(&dws->master->dev, "Tx hanged up\n");
+		dws->master->cur_msg->status = -EIO;
+	}
+}
+
 /*
  * dws->dma_chan_busy is set before the dma transfer starts, callback for tx
  * channel will clear a corresponding bit.
@@ -151,6 +193,8 @@ static void dw_spi_dma_tx_done(void *arg)
 {
 	struct dw_spi *dws = arg;
 
+	dw_spi_dma_wait_tx_done(dws);
+
 	clear_bit(TX_BUSY, &dws->dma_chan_busy);
 	if (test_bit(RX_BUSY, &dws->dma_chan_busy))
 		return;
@@ -192,6 +236,29 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_tx(struct dw_spi *dws,
 	return txdesc;
 }
 
+static inline bool dw_spi_dma_rx_busy(struct dw_spi *dws)
+{
+	return !!(dw_readl(dws, DW_SPI_SR) & SR_RF_NOT_EMPT);
+}
+
+static void dw_spi_dma_wait_rx_done(struct dw_spi *dws)
+{
+	int retry = WAIT_RETRIES;
+	struct spi_delay delay;
+	u32 nents;
+
+	nents = dw_readl(dws, DW_SPI_RXFLR);
+	dw_spi_dma_calc_delay(dws, nents, &delay);
+
+	while (dw_spi_dma_rx_busy(dws) && retry--)
+		spi_delay_exec(&delay, NULL);
+
+	if (retry < 0) {
+		dev_err(&dws->master->dev, "Rx hanged up\n");
+		dws->master->cur_msg->status = -EIO;
+	}
+}
+
 /*
  * dws->dma_chan_busy is set before the dma transfer starts, callback for rx
  * channel will clear a corresponding bit.
@@ -200,6 +267,8 @@ static void dw_spi_dma_rx_done(void *arg)
 {
 	struct dw_spi *dws = arg;
 
+	dw_spi_dma_wait_rx_done(dws);
+
 	clear_bit(RX_BUSY, &dws->dma_chan_busy);
 	if (test_bit(TX_BUSY, &dws->dma_chan_busy))
 		return;
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index e92d43b9a9e6..81364f501b7e 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -210,6 +210,16 @@ static inline void spi_set_clk(struct dw_spi *dws, u16 div)
 	dw_writel(dws, DW_SPI_BAUDR, div);
 }
 
+static inline u32 spi_get_clk(struct dw_spi *dws)
+{
+	u32 div = dw_readl(dws, DW_SPI_BAUDR);
+
+	if (!div)
+		return 0;
+
+	return dws->max_freq / div;
+}
+
 /* Disable IRQ bits */
 static inline void spi_mask_intr(struct dw_spi *dws, u32 mask)
 {
-- 
2.25.1

