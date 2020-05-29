Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309911E7407
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 06:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389329AbgE2D7i (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 May 2020 23:59:38 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:45374 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388525AbgE2D7h (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 May 2020 23:59:37 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 4FB7C8030777;
        Fri, 29 May 2020 03:59:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fyflqadrPR6g; Fri, 29 May 2020 06:59:33 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Linus Walleij <linus.walleij@stericsson.com>,
        Alan Cox <alan@linux.intel.com>,
        Grant Likely <grant.likely@secretlab.ca>
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
Subject: [PATCH v5 04/16] spi: dw: Add SPI Tx-done wait method to DMA-based transfer
Date:   Fri, 29 May 2020 06:59:02 +0300
Message-ID: <20200529035915.20790-5-Sergey.Semin@baikalelectronics.ru>
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

Since DMA transfers are performed asynchronously with actual SPI bus
transfers, then even if DMA transactions are finished it doesn't mean
all data is actually pushed to the SPI bus. Some data might still be
in the controller FIFO. This is specifically true for Tx-only transfers.
In this case if the next SPI transfer is recharged while a tail of the
previous one is still in FIFO, we'll loose that tail data. In order to
fix that problem let's add the wait procedure of the Tx SPI transfer
completion after the DMA transactions are finished.

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

Changelog v2:
- Use conditional statement instead of the ternary operator in the ref
  clock getter.
- Move the patch to the head of the series so one could be picked up to
  the stable kernels as a fix.

Changelog v3:
- Use spi_delay_exec() method to wait for the current operation completion.

Changelog v4:
- Get back ndelay() method to wait for an SPI transfer completion.
  spi_delay_exec() isn't suitable for the atomic context.

Changelog v5:
- Add more detailed description of the problems the patch fixes.
- Wait for the SPI Tx transfer finish in the mid_spi_dma_transfer() method
  executed in the task context.
- Use spi_delay_exec() to wait for the SPI Tx completion, since now the
  driver does in the kernel thread context.
- Use SPI_DELAY_UNIT_SCK spi_delay unit, since SPI xfer's are now have the
  effective_speed_hz initialized.
---
 drivers/spi/spi-dw-mid.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index 355b641c4483..846e3db91329 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -19,6 +19,7 @@
 #include <linux/pci.h>
 #include <linux/platform_data/dma-dw.h>
 
+#define WAIT_RETRIES	5
 #define RX_BUSY		0
 #define TX_BUSY		1
 
@@ -171,6 +172,33 @@ static int dw_spi_dma_wait(struct dw_spi *dws, struct spi_transfer *xfer)
 	return 0;
 }
 
+static inline bool dw_spi_dma_tx_busy(struct dw_spi *dws)
+{
+	return !(dw_readl(dws, DW_SPI_SR) & SR_TF_EMPT);
+}
+
+static int dw_spi_dma_wait_tx_done(struct dw_spi *dws,
+				   struct spi_transfer *xfer)
+{
+	int retry = WAIT_RETRIES;
+	struct spi_delay delay;
+	u32 nents;
+
+	nents = dw_readl(dws, DW_SPI_TXFLR);
+	delay.unit = SPI_DELAY_UNIT_SCK;
+	delay.value = nents * dws->n_bytes * BITS_PER_BYTE;
+
+	while (dw_spi_dma_tx_busy(dws) && retry--)
+		spi_delay_exec(&delay, xfer);
+
+	if (retry < 0) {
+		dev_err(&dws->master->dev, "Tx hanged up\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
 /*
  * dws->dma_chan_busy is set before the dma transfer starts, callback for tx
  * channel will clear a corresponding bit.
@@ -324,6 +352,12 @@ static int mid_spi_dma_transfer(struct dw_spi *dws, struct spi_transfer *xfer)
 	if (ret)
 		return ret;
 
+	if (txdesc && dws->master->cur_msg->status == -EINPROGRESS) {
+		ret = dw_spi_dma_wait_tx_done(dws, xfer);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
2.26.2

