Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD5E27F1F4
	for <lists+linux-spi@lfdr.de>; Wed, 30 Sep 2020 20:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbgI3S5B (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Sep 2020 14:57:01 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:41796 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730263AbgI3S4F (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Sep 2020 14:56:05 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id B17F3803017D;
        Wed, 30 Sep 2020 18:55:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VD95cV8Rxn-i; Wed, 30 Sep 2020 21:55:57 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        "wuxu . wu" <wuxu.wu@huawei.com>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 10/21] spi: dw: Perform IRQ setup in a dedicated function
Date:   Wed, 30 Sep 2020 21:55:34 +0300
Message-ID: <20200930185545.29959-11-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200930185545.29959-1-Sergey.Semin@baikalelectronics.ru>
References: <20200930185545.29959-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In order to make the transfer_one() callback method more readable and
for unification with the DMA-based transfer, let's detach the IRQ setup
procedure into a dedicated function. While at it rename the IRQ-based
transfer handler function to be dw_spi-prefixe and looking more like the
DMA-related one.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-core.c | 41 ++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 74e8f0da2883..db3fec4195f7 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -178,7 +178,7 @@ static void int_error_stop(struct dw_spi *dws, const char *msg)
 	spi_finalize_current_transfer(dws->master);
 }
 
-static irqreturn_t interrupt_transfer(struct dw_spi *dws)
+static irqreturn_t dw_spi_transfer_handler(struct dw_spi *dws)
 {
 	u16 irq_status = dw_readl(dws, DW_SPI_ISR);
 
@@ -315,6 +315,27 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
 }
 EXPORT_SYMBOL_GPL(dw_spi_update_config);
 
+static void dw_spi_irq_setup(struct dw_spi *dws)
+{
+	u16 level;
+	u8 imask;
+
+	/*
+	 * Originally Tx and Rx data lengths match. Rx FIFO Threshold level
+	 * will be adjusted at the final stage of the IRQ-based SPI transfer
+	 * execution so not to lose the leftover of the incoming data.
+	 */
+	level = min_t(u16, dws->fifo_len / 2, dws->tx_len);
+	dw_writel(dws, DW_SPI_TXFTLR, level);
+	dw_writel(dws, DW_SPI_RXFTLR, level - 1);
+
+	imask = SPI_INT_TXEI | SPI_INT_TXOI | SPI_INT_RXUI | SPI_INT_RXOI |
+		SPI_INT_RXFI;
+	spi_umask_intr(dws, imask);
+
+	dws->transfer_handler = dw_spi_transfer_handler;
+}
+
 static int dw_spi_transfer_one(struct spi_controller *master,
 		struct spi_device *spi, struct spi_transfer *transfer)
 {
@@ -324,8 +345,6 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 		.dfs = transfer->bits_per_word,
 		.freq = transfer->speed_hz,
 	};
-	u8 imask = 0;
-	u16 txlevel = 0;
 	int ret;
 
 	dws->dma_mapped = 0;
@@ -358,21 +377,7 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 			return ret;
 		}
 	} else {
-		/*
-		 * Originally Tx and Rx data lengths match. Rx FIFO Threshold level
-		 * will be adjusted at the final stage of the IRQ-based SPI transfer
-		 * execution so not to lose the leftover of the incoming data.
-		 */
-		txlevel = min_t(u16, dws->fifo_len / 2, dws->tx_len);
-		dw_writel(dws, DW_SPI_TXFTLR, txlevel);
-		dw_writel(dws, DW_SPI_RXFTLR, txlevel - 1);
-
-		/* Set the interrupt mask */
-		imask |= SPI_INT_TXEI | SPI_INT_TXOI |
-			 SPI_INT_RXUI | SPI_INT_RXOI | SPI_INT_RXFI;
-		spi_umask_intr(dws, imask);
-
-		dws->transfer_handler = interrupt_transfer;
+		dw_spi_irq_setup(dws);
 	}
 
 	spi_enable_chip(dws, 1);
-- 
2.27.0

