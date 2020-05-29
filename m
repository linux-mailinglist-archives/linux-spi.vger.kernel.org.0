Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7351E7E3F
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 15:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgE2NMX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 09:12:23 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:48180 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgE2NMU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 May 2020 09:12:20 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id EF2AF803078D;
        Fri, 29 May 2020 13:12:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id T6Vn1q4Zp39n; Fri, 29 May 2020 16:12:16 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 06/16] spi: dw: Parameterize the DMA Rx/Tx burst length
Date:   Fri, 29 May 2020 16:11:55 +0300
Message-ID: <20200529131205.31838-7-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200529131205.31838-1-Sergey.Semin@baikalelectronics.ru>
References: <20200529131205.31838-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

It isn't good to have numeric literals in the code especially if there
are multiple of them and they are related. Let's replace the Tx and Rx
burst level literals with the corresponding constants.

Co-developed-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Signed-off-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Co-developed-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Signed-off-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: devicetree@vger.kernel.org

---

Changelog v3:
- Discard the dws->fifo_len utilization in the Tx FIFO DMA threshold
  setting.
---
 drivers/spi/spi-dw-mid.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index abd6955ad1f7..189b517f77fc 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -21,7 +21,9 @@
 
 #define WAIT_RETRIES	5
 #define RX_BUSY		0
+#define RX_BURST_LEVEL	16
 #define TX_BUSY		1
+#define TX_BURST_LEVEL	16
 
 static bool mid_spi_dma_chan_filter(struct dma_chan *chan, void *param)
 {
@@ -227,7 +229,7 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_tx(struct dw_spi *dws,
 	memset(&txconf, 0, sizeof(txconf));
 	txconf.direction = DMA_MEM_TO_DEV;
 	txconf.dst_addr = dws->dma_addr;
-	txconf.dst_maxburst = 16;
+	txconf.dst_maxburst = TX_BURST_LEVEL;
 	txconf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	txconf.dst_addr_width = convert_dma_width(dws->n_bytes);
 	txconf.device_fc = false;
@@ -319,7 +321,7 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws,
 	memset(&rxconf, 0, sizeof(rxconf));
 	rxconf.direction = DMA_DEV_TO_MEM;
 	rxconf.src_addr = dws->dma_addr;
-	rxconf.src_maxburst = 16;
+	rxconf.src_maxburst = RX_BURST_LEVEL;
 	rxconf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	rxconf.src_addr_width = convert_dma_width(dws->n_bytes);
 	rxconf.device_fc = false;
@@ -344,8 +346,8 @@ static int mid_spi_dma_setup(struct dw_spi *dws, struct spi_transfer *xfer)
 {
 	u16 imr = 0, dma_ctrl = 0;
 
-	dw_writel(dws, DW_SPI_DMARDLR, 0xf);
-	dw_writel(dws, DW_SPI_DMATDLR, 0x10);
+	dw_writel(dws, DW_SPI_DMARDLR, RX_BURST_LEVEL - 1);
+	dw_writel(dws, DW_SPI_DMATDLR, TX_BURST_LEVEL);
 
 	if (xfer->tx_buf) {
 		dma_ctrl |= SPI_DMA_TDMAE;
-- 
2.26.2

