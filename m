Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F311D4B64
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 12:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgEOKsp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 06:48:45 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:35362 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbgEOKso (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 May 2020 06:48:44 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 2AD6A8029EC9;
        Fri, 15 May 2020 10:48:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id x3g8URpO-hUZ; Fri, 15 May 2020 13:48:36 +0300 (MSK)
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
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 03/19] spi: dw: Clear DMAC register when done or stopped
Date:   Fri, 15 May 2020 13:47:42 +0300
Message-ID: <20200515104758.6934-4-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
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

Changelog v2:
- Move the patch to the head of the series so one could be picked up to
  the stable kernels as a fix.
- Clear the DMACR in the DMA exit callback too.
---
 drivers/spi/spi-dw-mid.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index 7a5ae1506365..0c597b6bb154 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -108,6 +108,8 @@ static void mid_spi_dma_exit(struct dw_spi *dws)
 		dmaengine_terminate_sync(dws->rxchan);
 		dma_release_channel(dws->rxchan);
 	}
+
+	dw_writel(dws, DW_SPI_DMACR, 0);
 }
 
 static irqreturn_t dma_transfer(struct dw_spi *dws)
@@ -178,6 +180,8 @@ static void dw_spi_dma_tx_done(void *arg)
 	clear_bit(TX_BUSY, &dws->dma_chan_busy);
 	if (test_bit(RX_BUSY, &dws->dma_chan_busy))
 		return;
+
+	dw_writel(dws, DW_SPI_DMACR, 0);
 	spi_finalize_current_transfer(dws->master);
 }
 
@@ -249,6 +253,8 @@ static void dw_spi_dma_rx_done(void *arg)
 	clear_bit(RX_BUSY, &dws->dma_chan_busy);
 	if (test_bit(TX_BUSY, &dws->dma_chan_busy))
 		return;
+
+	dw_writel(dws, DW_SPI_DMACR, 0);
 	spi_finalize_current_transfer(dws->master);
 }
 
@@ -342,6 +348,8 @@ static void mid_spi_dma_stop(struct dw_spi *dws)
 		dmaengine_terminate_sync(dws->rxchan);
 		clear_bit(RX_BUSY, &dws->dma_chan_busy);
 	}
+
+	dw_writel(dws, DW_SPI_DMACR, 0);
 }
 
 static const struct dw_spi_dma_ops mfld_dma_ops = {
-- 
2.25.1

