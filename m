Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07C52713D7
	for <lists+linux-spi@lfdr.de>; Sun, 20 Sep 2020 13:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgITLcZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 20 Sep 2020 07:32:25 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:54012 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgITLcW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 20 Sep 2020 07:32:22 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 32EFC80305E2;
        Sun, 20 Sep 2020 11:23:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aGs3rQhg65en; Sun, 20 Sep 2020 14:23:27 +0300 (MSK)
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
Subject: [PATCH v2 04/11] spi: dw-dma: Check rx_buf availability in the xfer method
Date:   Sun, 20 Sep 2020 14:23:15 +0300
Message-ID: <20200920112322.24585-5-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200920112322.24585-1-Sergey.Semin@baikalelectronics.ru>
References: <20200920112322.24585-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Checking rx_buf for being NULL and returning NULL from the Rx-channel
preparation method doesn't let us to distinguish that situation from
errors happening during the Rx SG-list preparation. So it's better to make
sure that the rx_buf not-NULL and full-duplex communication is requested
prior calling the Rx preparation method.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-dma.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index da17897b8acb..d2a67dee1a66 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -369,9 +369,6 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws,
 {
 	struct dma_async_tx_descriptor *rxdesc;
 
-	if (!xfer->rx_buf)
-		return NULL;
-
 	rxdesc = dmaengine_prep_slave_sg(dws->rxchan,
 				xfer->rx_sg.sgl,
 				xfer->rx_sg.nents,
@@ -435,10 +432,12 @@ static int dw_spi_dma_transfer(struct dw_spi *dws, struct spi_transfer *xfer)
 		return -EINVAL;
 
 	/* Prepare the RX dma transfer */
-	rxdesc = dw_spi_dma_prepare_rx(dws, xfer);
+	if (xfer->rx_buf) {
+		rxdesc = dw_spi_dma_prepare_rx(dws, xfer);
+		if (!rxdesc)
+			return -EINVAL;
 
-	/* rx must be started before tx due to spi instinct */
-	if (rxdesc) {
+		/* rx must be started before tx due to spi instinct */
 		set_bit(RX_BUSY, &dws->dma_chan_busy);
 		dmaengine_submit(rxdesc);
 		dma_async_issue_pending(dws->rxchan);
@@ -458,7 +457,7 @@ static int dw_spi_dma_transfer(struct dw_spi *dws, struct spi_transfer *xfer)
 			return ret;
 	}
 
-	if (rxdesc && dws->master->cur_msg->status == -EINPROGRESS)
+	if (xfer->rx_buf && dws->master->cur_msg->status == -EINPROGRESS)
 		ret = dw_spi_dma_wait_rx_done(dws);
 
 	return ret;
-- 
2.27.0

