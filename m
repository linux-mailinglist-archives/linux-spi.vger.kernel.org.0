Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBFC2713D4
	for <lists+linux-spi@lfdr.de>; Sun, 20 Sep 2020 13:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgITLcY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 20 Sep 2020 07:32:24 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:54016 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgITLcW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 20 Sep 2020 07:32:22 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id B49DE803017D;
        Sun, 20 Sep 2020 11:23:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id o4siTxQgm8tT; Sun, 20 Sep 2020 14:23:31 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>, Vinod Koul <vkoul@kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 09/11] spi: dw-dma: Move DMAC register cleanup to DMA transfer method
Date:   Sun, 20 Sep 2020 14:23:20 +0300
Message-ID: <20200920112322.24585-10-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200920112322.24585-1-Sergey.Semin@baikalelectronics.ru>
References: <20200920112322.24585-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

DW APB SSI DMA driver doesn't use the native SPI core wait API since
commit bdbdf0f06337 ("spi: dw: Locally wait for the DMA transfers
completion"). Due to that the driver can now clear the DMAC register
in a single place synchronously with the DMA transactions completion
or failure. After that all the possible code paths are still covered:
1) DMA completion callbacks are executed in case if the corresponding DMA
transactions are finished. When they are, one of them will eventually wake
the SPI messages pump kernel thread and dw_spi_dma_transfer_all() method
will clean the DMAC register as implied by this patch.
2) dma_stop is called when the SPI core detects an error either returned
from the transfer_one() callback or set in the SPI message status field.
Both types of errors will be noticed by the dw_spi_dma_transfer_all()
method.
3) dma_exit is called when either SPI controller driver or the
corresponding device is removed. In any case the SPI core will first
flush the SPI messages pump kernel thread, so any pending or in-fly
SPI transfers will be finished before that.

Due to all of that let's simplify the DW APB SSI DMA driver a bit and
move the DMAC register cleanup to a single place in the
dw_spi_dma_transfer_all() method.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-dma.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index f2baefcae9ae..935f073a3523 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -152,8 +152,6 @@ static void dw_spi_dma_exit(struct dw_spi *dws)
 		dmaengine_terminate_sync(dws->rxchan);
 		dma_release_channel(dws->rxchan);
 	}
-
-	dw_writel(dws, DW_SPI_DMACR, 0);
 }
 
 static irqreturn_t dw_spi_dma_transfer_handler(struct dw_spi *dws)
@@ -252,7 +250,6 @@ static void dw_spi_dma_tx_done(void *arg)
 	if (test_bit(RX_BUSY, &dws->dma_chan_busy))
 		return;
 
-	dw_writel(dws, DW_SPI_DMACR, 0);
 	complete(&dws->dma_completion);
 }
 
@@ -355,7 +352,6 @@ static void dw_spi_dma_rx_done(void *arg)
 	if (test_bit(TX_BUSY, &dws->dma_chan_busy))
 		return;
 
-	dw_writel(dws, DW_SPI_DMACR, 0);
 	complete(&dws->dma_completion);
 }
 
@@ -449,13 +445,13 @@ static int dw_spi_dma_transfer_all(struct dw_spi *dws,
 	/* Submit the DMA Tx transfer */
 	ret = dw_spi_dma_submit_tx(dws, xfer);
 	if (ret)
-		return ret;
+		goto err_clear_dmac;
 
 	/* Submit the DMA Rx transfer if required */
 	if (xfer->rx_buf) {
 		ret = dw_spi_dma_submit_rx(dws, xfer);
 		if (ret)
-			return ret;
+			goto err_clear_dmac;
 
 		/* rx must be started before tx due to spi instinct */
 		dma_async_issue_pending(dws->rxchan);
@@ -463,7 +459,12 @@ static int dw_spi_dma_transfer_all(struct dw_spi *dws,
 
 	dma_async_issue_pending(dws->txchan);
 
-	return dw_spi_dma_wait(dws, xfer);
+	ret = dw_spi_dma_wait(dws, xfer);
+
+err_clear_dmac:
+	dw_writel(dws, DW_SPI_DMACR, 0);
+
+	return ret;
 }
 
 static int dw_spi_dma_transfer(struct dw_spi *dws, struct spi_transfer *xfer)
@@ -496,8 +497,6 @@ static void dw_spi_dma_stop(struct dw_spi *dws)
 		dmaengine_terminate_sync(dws->rxchan);
 		clear_bit(RX_BUSY, &dws->dma_chan_busy);
 	}
-
-	dw_writel(dws, DW_SPI_DMACR, 0);
 }
 
 static const struct dw_spi_dma_ops dw_spi_dma_mfld_ops = {
-- 
2.27.0

