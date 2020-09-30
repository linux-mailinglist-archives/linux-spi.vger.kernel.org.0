Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3A327F1DD
	for <lists+linux-spi@lfdr.de>; Wed, 30 Sep 2020 20:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbgI3S4Y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Sep 2020 14:56:24 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:41788 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730378AbgI3S4M (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Sep 2020 14:56:12 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 4594E803073D;
        Wed, 30 Sep 2020 18:56:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TNH2ayoHo4jG; Wed, 30 Sep 2020 21:56:03 +0300 (MSK)
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
Subject: [PATCH v2 19/21] spi: dw: Add poll-based SPI transfers support
Date:   Wed, 30 Sep 2020 21:55:43 +0300
Message-ID: <20200930185545.29959-20-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200930185545.29959-1-Sergey.Semin@baikalelectronics.ru>
References: <20200930185545.29959-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

A functionality of the poll-based transfer has been removed by
commit 1ceb09717e98 ("spi: dw: remove cs_control and poll_mode members
from chip_data") with a justification that "there is no user of one
anymore". It turns out one of our DW APB SSI core is synthesized with no
IRQ line attached and the only possible way of using it is to implement a
poll-based SPI transfer procedure. So we have to get the removed
functionality back, but with some alterations described below.

First of all the poll-based transfer is activated only if the DW SPI
controller doesn't have an IRQ line attached and the Linux IRQ number is
initialized with the IRQ_NOTCONNECTED value. Secondly the transfer
procedure is now executed with a delay performed between writer and reader
methods. The delay value is calculated based on the number of data words
expected to be received on the current iteration. Finally the errors
status is checked on each iteration.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-core.c | 40 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index cc217b0e588e..a3c0be6943f3 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -364,6 +364,42 @@ static void dw_spi_irq_setup(struct dw_spi *dws)
 	dws->transfer_handler = dw_spi_transfer_handler;
 }
 
+/*
+ * The iterative procedure of the poll-based transfer is simple: write as much
+ * as possible to the Tx FIFO, wait until the pending to receive data is ready
+ * to be read, read it from the Rx FIFO and check whether the performed
+ * procedure has been successful.
+ *
+ * Note this method the same way as the IRQ-based transfer won't work well for
+ * the SPI devices connected to the controller with native CS due to the
+ * automatic CS assertion/de-assertion.
+ */
+static int dw_spi_poll_transfer(struct dw_spi *dws,
+				struct spi_transfer *transfer)
+{
+	struct spi_delay delay;
+	u16 nbits;
+	int ret;
+
+	delay.unit = SPI_DELAY_UNIT_SCK;
+	nbits = dws->n_bytes * BITS_PER_BYTE;
+
+	do {
+		dw_writer(dws);
+
+		delay.value = nbits * (dws->rx_len - dws->tx_len);
+		spi_delay_exec(&delay, transfer);
+
+		dw_reader(dws);
+
+		ret = dw_spi_check_status(dws, true);
+		if (ret)
+			return ret;
+	} while (dws->rx_len);
+
+	return 0;
+}
+
 static int dw_spi_transfer_one(struct spi_controller *master,
 		struct spi_device *spi, struct spi_transfer *transfer)
 {
@@ -408,6 +444,8 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 
 	if (dws->dma_mapped)
 		return dws->dma_ops->dma_transfer(dws, transfer);
+	else if (dws->irq == IRQ_NOTCONNECTED)
+		return dw_spi_poll_transfer(dws, transfer);
 
 	dw_spi_irq_setup(dws);
 
@@ -816,7 +854,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 
 	ret = request_irq(dws->irq, dw_spi_irq, IRQF_SHARED, dev_name(dev),
 			  master);
-	if (ret < 0) {
+	if (ret < 0 && ret != -ENOTCONN) {
 		dev_err(dev, "can not get IRQ\n");
 		goto err_free_master;
 	}
-- 
2.27.0

