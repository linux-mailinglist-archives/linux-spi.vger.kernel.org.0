Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38191E7434
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 06:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389387AbgE2EBA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 00:01:00 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:45432 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389144AbgE2D7i (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 May 2020 23:59:38 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 936EF8030778;
        Fri, 29 May 2020 03:59:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1ssxlNDJj-6q; Fri, 29 May 2020 06:59:36 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 08/16] spi: dw: Fix Rx-only DMA transfers
Date:   Fri, 29 May 2020 06:59:06 +0300
Message-ID: <20200529035915.20790-9-Sergey.Semin@baikalelectronics.ru>
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

Tx-only DMA transfers are working perfectly fine since in this case
the code just ignores the Rx FIFO overflow interrupts. But it turns
out the SPI Rx-only transfers are broken since nothing pushing any
data to the shift registers, so the Rx FIFO is left empty and the
SPI core subsystems just returns a timeout error. Since DW DMAC
driver doesn't support something like cyclic write operations of
a single byte to a device register, the only way to support the
Rx-only SPI transfers is to fake it by using a dummy Tx-buffer.
This is what we intend to fix in this commit by setting the
SPI_CONTROLLER_MUST_TX flag for DMA-capable platform.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
 drivers/spi/spi-dw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 6939e003e3e9..4d1849699a12 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -515,6 +515,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 			dev_warn(dev, "DMA init failed\n");
 		} else {
 			master->can_dma = dws->dma_ops->can_dma;
+			master->flags |= SPI_CONTROLLER_MUST_TX;
 		}
 	}
 
-- 
2.26.2

