Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47CB27F1E9
	for <lists+linux-spi@lfdr.de>; Wed, 30 Sep 2020 20:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbgI3S4p (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Sep 2020 14:56:45 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:41858 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730321AbgI3S4G (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Sep 2020 14:56:06 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 1314C803202C;
        Wed, 30 Sep 2020 18:56:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qV1eoHZYHGZ2; Wed, 30 Sep 2020 21:56:00 +0300 (MSK)
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
Subject: [PATCH v2 15/21] spi: dw: Move num-of retries parameter to the header file
Date:   Wed, 30 Sep 2020 21:55:39 +0300
Message-ID: <20200930185545.29959-16-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200930185545.29959-1-Sergey.Semin@baikalelectronics.ru>
References: <20200930185545.29959-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The parameter will be needed for another wait-done method being added in
the framework of the SPI memory operation modification in a further
commit.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-dma.c | 5 ++---
 drivers/spi/spi-dw.h     | 2 ++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index bb390ff67d1d..9db119dc5554 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -17,7 +17,6 @@
 
 #include "spi-dw.h"
 
-#define WAIT_RETRIES	5
 #define RX_BUSY		0
 #define RX_BURST_LEVEL	16
 #define TX_BUSY		1
@@ -208,7 +207,7 @@ static inline bool dw_spi_dma_tx_busy(struct dw_spi *dws)
 static int dw_spi_dma_wait_tx_done(struct dw_spi *dws,
 				   struct spi_transfer *xfer)
 {
-	int retry = WAIT_RETRIES;
+	int retry = SPI_WAIT_RETRIES;
 	struct spi_delay delay;
 	u32 nents;
 
@@ -283,7 +282,7 @@ static inline bool dw_spi_dma_rx_busy(struct dw_spi *dws)
 
 static int dw_spi_dma_wait_rx_done(struct dw_spi *dws)
 {
-	int retry = WAIT_RETRIES;
+	int retry = SPI_WAIT_RETRIES;
 	struct spi_delay delay;
 	unsigned long ns, us;
 	u32 nents;
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index eb1d46983319..946065201c9c 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -100,6 +100,8 @@
 #define SPI_DMA_RDMAE			(1 << 0)
 #define SPI_DMA_TDMAE			(1 << 1)
 
+#define SPI_WAIT_RETRIES		5
+
 enum dw_ssi_type {
 	SSI_MOTO_SPI = 0,
 	SSI_TI_SSP,
-- 
2.27.0

