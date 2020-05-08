Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF811CB063
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 15:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgEHNbF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 09:31:05 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:42904 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgEHNbF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 May 2020 09:31:05 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 18B7E80307C1;
        Fri,  8 May 2020 13:31:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hcbfB6EFjayB; Fri,  8 May 2020 16:31:01 +0300 (MSK)
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
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 08/17] spi: dw: Clear DMAC register when done or stopped
Date:   Fri, 8 May 2020 16:29:33 +0300
Message-ID: <20200508132943.9826-9-Sergey.Semin@baikalelectronics.ru>
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

If DMAC register is left uncleared any further DMAless transfers
may cause the DMAC hardware handshaking interface getting activated.
So the next DMA-based Rx/Tx transaction will be started right
after the dma_async_issue_pending() method is invoked even if no
DMATDLR/DMARDLR conditions are met. This at the same time may cause
the Tx/Rx FIFO buffers underrun/overrun. In order to fix this we
must clear DMAC register after a current DMA-based transaction is
finished.

Co-developed-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Signed-off-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
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
 drivers/spi/spi-dw-dma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index 7f0e4d888125..7a6769386932 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -156,6 +156,8 @@ static void dw_spi_dma_tx_done(void *arg)
 	clear_bit(TX_BUSY, &dws->dma_chan_busy);
 	if (test_bit(RX_BUSY, &dws->dma_chan_busy))
 		return;
+
+	dw_writel(dws, DW_SPI_DMACR, 0);
 	spi_finalize_current_transfer(dws->master);
 }
 
@@ -226,6 +228,8 @@ static void dw_spi_dma_rx_done(void *arg)
 	clear_bit(RX_BUSY, &dws->dma_chan_busy);
 	if (test_bit(TX_BUSY, &dws->dma_chan_busy))
 		return;
+
+	dw_writel(dws, DW_SPI_DMACR, 0);
 	spi_finalize_current_transfer(dws->master);
 }
 
@@ -318,6 +322,8 @@ static void dw_spi_dma_stop(struct dw_spi *dws)
 		dmaengine_terminate_sync(dws->rxchan);
 		clear_bit(RX_BUSY, &dws->dma_chan_busy);
 	}
+
+	dw_writel(dws, DW_SPI_DMACR, 0);
 }
 
 static const struct dw_spi_dma_ops dw_spi_pci_dma_ops = {
-- 
2.25.1

