Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04CD51CB06A
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 15:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgEHNbT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 09:31:19 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:42948 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbgEHNbT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 May 2020 09:31:19 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 29C48803087B;
        Fri,  8 May 2020 13:31:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qU6h34oZLCr4; Fri,  8 May 2020 16:31:14 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 10/17] spi: dw: Parameterize the DMA Rx/Tx burst length
Date:   Fri, 8 May 2020 16:29:35 +0300
Message-ID: <20200508132943.9826-11-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

It isn't good to have numeric literals in the code especially if there
are multiple of them and they are related. Moreover in current
implementation the Tx DMA transfer activation level isn't optimal,
since it's hardwired to be at 16-32 bytes level, while it's better
to keep the SPI FIFO buffer as full as possible until all available
data is submitted. So lets introduce the DMA burst level
parametrization macros with optimal values - issue Rx transfer if at
least 16 bytes are available in the buffer and execute Tx transaction
if at least 16 bytes room is opened in SPI Tx FIFO.

Co-developed-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Signed-off-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Co-developed-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Signed-off-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Allison Randal <allison@lohutok.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Gareth Williams <gareth.williams.jx@renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
 drivers/spi/spi-dw-dma.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index 201390f7d032..d89a00fb705e 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -20,7 +20,9 @@
 
 #define WAIT_RETRIES	5
 #define RX_BUSY		0
+#define RX_BURST_LEVEL	16
 #define TX_BUSY		1
+#define TX_BURST_LEVEL	16
 
 static bool dw_spi_dma_chan_filter(struct dma_chan *chan, void *param)
 {
@@ -172,7 +174,7 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_tx(struct dw_spi *dws,
 
 	txconf.direction = DMA_MEM_TO_DEV;
 	txconf.dst_addr = dws->dma_addr;
-	txconf.dst_maxburst = 16;
+	txconf.dst_maxburst = TX_BURST_LEVEL;
 	txconf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	txconf.dst_addr_width = convert_dma_width(dws->dma_width);
 	txconf.device_fc = false;
@@ -244,7 +246,7 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws,
 
 	rxconf.direction = DMA_DEV_TO_MEM;
 	rxconf.src_addr = dws->dma_addr;
-	rxconf.src_maxburst = 16;
+	rxconf.src_maxburst = RX_BURST_LEVEL;
 	rxconf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	rxconf.src_addr_width = convert_dma_width(dws->dma_width);
 	rxconf.device_fc = false;
@@ -269,8 +271,8 @@ static int dw_spi_dma_setup(struct dw_spi *dws, struct spi_transfer *xfer)
 {
 	u16 imr = 0, dma_ctrl = 0;
 
-	dw_writel(dws, DW_SPI_DMARDLR, 0xf);
-	dw_writel(dws, DW_SPI_DMATDLR, 0x10);
+	dw_writel(dws, DW_SPI_DMARDLR, RX_BURST_LEVEL - 1);
+	dw_writel(dws, DW_SPI_DMATDLR, dws->fifo_len - TX_BURST_LEVEL);
 
 	if (xfer->tx_buf) {
 		dma_ctrl |= SPI_DMA_TDMAE;
-- 
2.25.1

