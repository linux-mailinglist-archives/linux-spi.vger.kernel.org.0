Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBB61DDBA6
	for <lists+linux-spi@lfdr.de>; Fri, 22 May 2020 02:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbgEVAI3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 20:08:29 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:41188 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730127AbgEVAI0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 May 2020 20:08:26 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 3CF698030791;
        Fri, 22 May 2020 00:08:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id J3Bik7PTjQr3; Fri, 22 May 2020 03:08:23 +0300 (MSK)
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
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 02/16] spi: dw: Enable interrupts in accordance with DMA xfer mode
Date:   Fri, 22 May 2020 03:07:51 +0300
Message-ID: <20200522000806.7381-3-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200522000806.7381-1-Sergey.Semin@baikalelectronics.ru>
References: <20200522000806.7381-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

It's pointless to track the Tx overrun interrupts if Rx-only SPI
transfer is issued. Similarly there is no need in handling the Rx
overrun/underrun interrupts if Tx-only SPI transfer is executed.
So lets unmask the interrupts only if corresponding SPI
transactions are implied.

Co-developed-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Signed-off-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
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
 drivers/spi/spi-dw-mid.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index 2152c0cb3953..f24fcd925b48 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -297,19 +297,23 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws,
 
 static int mid_spi_dma_setup(struct dw_spi *dws, struct spi_transfer *xfer)
 {
-	u16 dma_ctrl = 0;
+	u16 imr = 0, dma_ctrl = 0;
 
 	dw_writel(dws, DW_SPI_DMARDLR, 0xf);
 	dw_writel(dws, DW_SPI_DMATDLR, 0x10);
 
-	if (xfer->tx_buf)
+	if (xfer->tx_buf) {
 		dma_ctrl |= SPI_DMA_TDMAE;
-	if (xfer->rx_buf)
+		imr |= SPI_INT_TXOI;
+	}
+	if (xfer->rx_buf) {
 		dma_ctrl |= SPI_DMA_RDMAE;
+		imr |= SPI_INT_RXUI | SPI_INT_RXOI;
+	}
 	dw_writel(dws, DW_SPI_DMACR, dma_ctrl);
 
 	/* Set the interrupt mask */
-	spi_umask_intr(dws, SPI_INT_TXOI | SPI_INT_RXUI | SPI_INT_RXOI);
+	spi_umask_intr(dws, imr);
 
 	dws->transfer_handler = dma_transfer;
 
-- 
2.25.1

