Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619892713D0
	for <lists+linux-spi@lfdr.de>; Sun, 20 Sep 2020 13:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgITLbT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 20 Sep 2020 07:31:19 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:53648 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgITL33 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 20 Sep 2020 07:29:29 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 791FF8001384;
        Sun, 20 Sep 2020 11:29:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MXQmI7nk4Ji1; Sun, 20 Sep 2020 14:29:25 +0300 (MSK)
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
Subject: [PATCH 06/30] spi: dw: Disable all IRQs when controller is unused
Date:   Sun, 20 Sep 2020 14:28:50 +0300
Message-ID: <20200920112914.26501-7-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
References: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

It's a good practice to disable all IRQs if a device is fully unused. In
our case it is supposed to be done before requesting the IRQ and after the
last byte of an SPI transfer is received. In the former case it's required
to prevent the IRQ handler invocation before the driver data is fully
initialized (which may happen if the IRQs status has been left uncleared
before the device is probed). So we just moved the spi_hw_init() method
invocation to the earlier stage before requesting the IRQ. In the later
case there is just no point in having any of the IRQs enabled between SPI
transfers and when there is no SPI message currently being processed.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 18411f5b9954..be94ed5bb896 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -198,7 +198,7 @@ static irqreturn_t interrupt_transfer(struct dw_spi *dws)
 
 	dw_reader(dws);
 	if (dws->rx_end == dws->rx) {
-		spi_mask_intr(dws, SPI_INT_TXEI);
+		spi_mask_intr(dws, 0xff);
 		spi_finalize_current_transfer(dws->master);
 		return IRQ_HANDLED;
 	}
@@ -222,7 +222,7 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	if (!master->cur_msg) {
-		spi_mask_intr(dws, SPI_INT_TXEI);
+		spi_mask_intr(dws, 0xff);
 		return IRQ_HANDLED;
 	}
 
@@ -458,6 +458,9 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 
 	spi_controller_set_devdata(master, dws);
 
+	/* Basic HW init */
+	spi_hw_init(dev, dws);
+
 	ret = request_irq(dws->irq, dw_spi_irq, IRQF_SHARED, dev_name(dev),
 			  master);
 	if (ret < 0) {
@@ -485,9 +488,6 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	device_property_read_u32(dev, "rx-sample-delay-ns",
 				 &dws->def_rx_sample_dly_ns);
 
-	/* Basic HW init */
-	spi_hw_init(dev, dws);
-
 	if (dws->dma_ops && dws->dma_ops->dma_init) {
 		ret = dws->dma_ops->dma_init(dev, dws);
 		if (ret) {
-- 
2.27.0

