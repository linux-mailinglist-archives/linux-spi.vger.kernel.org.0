Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64F22713AE
	for <lists+linux-spi@lfdr.de>; Sun, 20 Sep 2020 13:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgITL3n (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 20 Sep 2020 07:29:43 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:53640 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgITL33 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 20 Sep 2020 07:29:29 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id B2D418001383;
        Sun, 20 Sep 2020 11:29:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DDfvsA9FBVD7; Sun, 20 Sep 2020 14:29:25 +0300 (MSK)
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
Subject: [PATCH 05/30] spi: dw: Clear IRQ status on DW SPI controller reset
Date:   Sun, 20 Sep 2020 14:28:49 +0300
Message-ID: <20200920112914.26501-6-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
References: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

It turns out the IRQ status isn't cleared after switching the controller
off and getting it back on, which may cause raising false error interrupts
if controller has been unsuccessfully used by, for instance, a bootloader
before the driver is loaded. Let's explicitly clear the interrupts status
in the dedicated controller reset method.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 1ab704d1ebd8..ff77f39047ce 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -229,14 +229,15 @@ static inline void spi_umask_intr(struct dw_spi *dws, u32 mask)
 }
 
 /*
- * This does disable the SPI controller, interrupts, and re-enable the
- * controller back. Transmit and receive FIFO buffers are cleared when the
- * device is disabled.
+ * This disables the SPI controller, interrupts, clears the interrupts status,
+ * and re-enable the controller back. Transmit and receive FIFO buffers are
+ * cleared when the device is disabled.
  */
 static inline void spi_reset_chip(struct dw_spi *dws)
 {
 	spi_enable_chip(dws, 0);
 	spi_mask_intr(dws, 0xff);
+	dw_readl(dws, DW_SPI_ICR);
 	spi_enable_chip(dws, 1);
 }
 
-- 
2.27.0

