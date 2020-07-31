Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74932340B5
	for <lists+linux-spi@lfdr.de>; Fri, 31 Jul 2020 10:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731873AbgGaIAW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 31 Jul 2020 04:00:22 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:59748 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731523AbgGaIAE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 31 Jul 2020 04:00:04 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 07D3A8040A69;
        Fri, 31 Jul 2020 08:00:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4aeNiTJ4Y1iU; Fri, 31 Jul 2020 11:00:00 +0300 (MSK)
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
Subject: [PATCH 5/8] spi: dw-dma: Detach DMA transfer into a dedicated method
Date:   Fri, 31 Jul 2020 10:59:50 +0300
Message-ID: <20200731075953.14416-6-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200731075953.14416-1-Sergey.Semin@baikalelectronics.ru>
References: <20200731075953.14416-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In order to add an alternative method of DMA-based SPI transfer first we
need to detach the currently available one from the common code. Here we
move the normal DMA-based SPI transfer execution functionality into a
dedicated method. It will be utilized if either the DMA engine supports
an unlimited number SG entries or Tx-only SPI transfer is requested. But
currently just use it for any SPI transfer.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-dma.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index 366978086781..32ef7913a73d 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -434,7 +434,8 @@ static int dw_spi_dma_setup(struct dw_spi *dws, struct spi_transfer *xfer)
 	return 0;
 }
 
-static int dw_spi_dma_transfer(struct dw_spi *dws, struct spi_transfer *xfer)
+static int dw_spi_dma_transfer_all(struct dw_spi *dws,
+				   struct spi_transfer *xfer)
 {
 	int ret;
 
@@ -455,7 +456,14 @@ static int dw_spi_dma_transfer(struct dw_spi *dws, struct spi_transfer *xfer)
 
 	dma_async_issue_pending(dws->txchan);
 
-	ret = dw_spi_dma_wait(dws, xfer);
+	return dw_spi_dma_wait(dws, xfer);
+}
+
+static int dw_spi_dma_transfer(struct dw_spi *dws, struct spi_transfer *xfer)
+{
+	int ret;
+
+	ret = dw_spi_dma_transfer_all(dws, xfer);
 	if (ret)
 		return ret;
 
-- 
2.27.0

