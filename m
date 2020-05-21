Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A5A1DC499
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 03:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbgEUBW4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 May 2020 21:22:56 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:33836 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgEUBWz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 May 2020 21:22:55 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 63CDB803078D;
        Thu, 21 May 2020 01:22:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GAe9a4jjPInB; Thu, 21 May 2020 04:22:50 +0300 (MSK)
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
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Clement Leger <cleger@kalray.eu>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 03/16] spi: dw: Discard static DW DMA slave structures
Date:   Thu, 21 May 2020 04:21:53 +0300
Message-ID: <20200521012206.14472-4-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200521012206.14472-1-Sergey.Semin@baikalelectronics.ru>
References: <20200521012206.14472-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Having them declared is redundant since each struct dw_dma_chan has
the same structure embedded and the structure from the passed dma_chan
private pointer will be copied there as a result of the next calls
chain:
dma_request_channel() -> find_candidate() -> dma_chan_get() ->
device_alloc_chan_resources() = dwc_alloc_chan_resources() ->
dw_dma_filter().
So just remove the static dw_dma_chan structures and use a locally
declared data instance with dst_id/src_id set to the same values as
the static copies used to have.

Co-developed-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Signed-off-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Co-developed-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Signed-off-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: devicetree@vger.kernel.org

---

Changelog v3:
- Explicitly initialize the dw_dma_slave members on stack.
---
 drivers/spi/spi-dw-mid.c | 19 ++++++++-----------
 drivers/spi/spi-dw.h     |  2 --
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index cf99832ba271..8446bad0528c 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -21,9 +21,6 @@
 #define RX_BUSY		0
 #define TX_BUSY		1
 
-static struct dw_dma_slave mid_dma_tx = { .dst_id = 1 };
-static struct dw_dma_slave mid_dma_rx = { .src_id = 0 };
-
 static bool mid_spi_dma_chan_filter(struct dma_chan *chan, void *param)
 {
 	struct dw_dma_slave *s = param;
@@ -37,9 +34,11 @@ static bool mid_spi_dma_chan_filter(struct dma_chan *chan, void *param)
 
 static int mid_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 {
+	struct dw_dma_slave slave = {
+		.src_id = 0,
+		.dst_id = 0
+	};
 	struct pci_dev *dma_dev;
-	struct dw_dma_slave *tx = dws->dma_tx;
-	struct dw_dma_slave *rx = dws->dma_rx;
 	dma_cap_mask_t mask;
 
 	/*
@@ -54,14 +53,14 @@ static int mid_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 	dma_cap_set(DMA_SLAVE, mask);
 
 	/* 1. Init rx channel */
-	rx->dma_dev = &dma_dev->dev;
-	dws->rxchan = dma_request_channel(mask, mid_spi_dma_chan_filter, rx);
+	slave.dma_dev = &dma_dev->dev;
+	dws->rxchan = dma_request_channel(mask, mid_spi_dma_chan_filter, &slave);
 	if (!dws->rxchan)
 		goto err_exit;
 
 	/* 2. Init tx channel */
-	tx->dma_dev = &dma_dev->dev;
-	dws->txchan = dma_request_channel(mask, mid_spi_dma_chan_filter, tx);
+	slave.dst_id = 1;
+	dws->txchan = dma_request_channel(mask, mid_spi_dma_chan_filter, &slave);
 	if (!dws->txchan)
 		goto free_rxchan;
 
@@ -386,8 +385,6 @@ static const struct dw_spi_dma_ops mfld_dma_ops = {
 
 static void dw_spi_mid_setup_dma_mfld(struct dw_spi *dws)
 {
-	dws->dma_tx = &mid_dma_tx;
-	dws->dma_rx = &mid_dma_rx;
 	dws->dma_ops = &mfld_dma_ops;
 }
 
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 81364f501b7e..60e9e430ce7b 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -146,8 +146,6 @@ struct dw_spi {
 	unsigned long		dma_chan_busy;
 	dma_addr_t		dma_addr; /* phy address of the Data register */
 	const struct dw_spi_dma_ops *dma_ops;
-	void			*dma_tx;
-	void			*dma_rx;
 
 	/* Bus interface info */
 	void			*priv;
-- 
2.25.1

