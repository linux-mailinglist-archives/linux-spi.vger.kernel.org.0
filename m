Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BA9286BB7
	for <lists+linux-spi@lfdr.de>; Thu,  8 Oct 2020 01:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgJGXzx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 7 Oct 2020 19:55:53 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:45740 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbgJGXzf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 7 Oct 2020 19:55:35 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id D6587803017F;
        Wed,  7 Oct 2020 23:55:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZHtC-efnC7mB; Thu,  8 Oct 2020 02:55:27 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        "wuxu . wu" <wuxu.wu@huawei.com>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 16/21] spi: dw: Add generic DW SSI status-check method
Date:   Thu, 8 Oct 2020 02:55:05 +0300
Message-ID: <20201007235511.4935-17-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20201007235511.4935-1-Sergey.Semin@baikalelectronics.ru>
References: <20201007235511.4935-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The DW SSI errors handling method can be generically implemented for all
types of the transfers: IRQ, DMA and poll-based ones. It will be a
function which checks the overflow/underflow error flags and resets the
controller if any of them is set. In the framework of this commit we make
use of the new method to detect the errors in the IRQ- and DMA-based SPI
transfer execution procedures.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-core.c | 43 +++++++++++++++++++++++++++++++--------
 drivers/spi/spi-dw-dma.c  | 11 ++--------
 drivers/spi/spi-dw.h      |  1 +
 3 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 76e323db170f..8480da49a6a1 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -169,23 +169,48 @@ static void dw_reader(struct dw_spi *dws)
 	}
 }
 
-static void int_error_stop(struct dw_spi *dws, const char *msg)
+int dw_spi_check_status(struct dw_spi *dws, bool raw)
 {
-	spi_reset_chip(dws);
+	u32 irq_status;
+	int ret = 0;
+
+	if (raw)
+		irq_status = dw_readl(dws, DW_SPI_RISR);
+	else
+		irq_status = dw_readl(dws, DW_SPI_ISR);
+
+	if (irq_status & SPI_INT_RXOI) {
+		dev_err(&dws->master->dev, "RX FIFO overflow detected\n");
+		ret = -EIO;
+	}
+
+	if (irq_status & SPI_INT_RXUI) {
+		dev_err(&dws->master->dev, "RX FIFO underflow detected\n");
+		ret = -EIO;
+	}
 
-	dev_err(&dws->master->dev, "%s\n", msg);
-	dws->master->cur_msg->status = -EIO;
-	spi_finalize_current_transfer(dws->master);
+	if (irq_status & SPI_INT_TXOI) {
+		dev_err(&dws->master->dev, "TX FIFO overflow detected\n");
+		ret = -EIO;
+	}
+
+	/* Generically handle the erroneous situation */
+	if (ret) {
+		spi_reset_chip(dws);
+		if (dws->master->cur_msg)
+			dws->master->cur_msg->status = ret;
+	}
+
+	return ret;
 }
+EXPORT_SYMBOL_GPL(dw_spi_check_status);
 
 static irqreturn_t dw_spi_transfer_handler(struct dw_spi *dws)
 {
 	u16 irq_status = dw_readl(dws, DW_SPI_ISR);
 
-	/* Error handling */
-	if (irq_status & (SPI_INT_TXOI | SPI_INT_RXOI | SPI_INT_RXUI)) {
-		dw_readl(dws, DW_SPI_ICR);
-		int_error_stop(dws, "interrupt_transfer: fifo overrun/underrun");
+	if (dw_spi_check_status(dws, false)) {
+		spi_finalize_current_transfer(dws->master);
 		return IRQ_HANDLED;
 	}
 
diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index 9db119dc5554..1969b09b4f5e 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -144,17 +144,10 @@ static void dw_spi_dma_exit(struct dw_spi *dws)
 
 static irqreturn_t dw_spi_dma_transfer_handler(struct dw_spi *dws)
 {
-	u16 irq_status = dw_readl(dws, DW_SPI_ISR);
+	dw_spi_check_status(dws, false);
 
-	if (!irq_status)
-		return IRQ_NONE;
-
-	dw_readl(dws, DW_SPI_ICR);
-	spi_reset_chip(dws);
-
-	dev_err(&dws->master->dev, "%s: FIFO overrun/underrun\n", __func__);
-	dws->master->cur_msg->status = -EIO;
 	complete(&dws->dma_completion);
+
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 946065201c9c..5eb98ece2f2a 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -261,6 +261,7 @@ static inline void spi_shutdown_chip(struct dw_spi *dws)
 extern void dw_spi_set_cs(struct spi_device *spi, bool enable);
 extern void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
 				 struct dw_spi_cfg *cfg);
+extern int dw_spi_check_status(struct dw_spi *dws, bool raw);
 extern int dw_spi_add_host(struct device *dev, struct dw_spi *dws);
 extern void dw_spi_remove_host(struct dw_spi *dws);
 extern int dw_spi_suspend_host(struct dw_spi *dws);
-- 
2.27.0

