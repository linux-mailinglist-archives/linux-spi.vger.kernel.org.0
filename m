Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4072713A9
	for <lists+linux-spi@lfdr.de>; Sun, 20 Sep 2020 13:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgITL3m (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 20 Sep 2020 07:29:42 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:53666 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgITL3a (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 20 Sep 2020 07:29:30 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 42F1C800114E;
        Sun, 20 Sep 2020 11:29:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uR6zC4P0PeAZ; Sun, 20 Sep 2020 14:29:26 +0300 (MSK)
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
Subject: [PATCH 07/30] spi: dw: Use relaxed IO-methods to access FIFOs
Date:   Sun, 20 Sep 2020 14:28:51 +0300
Message-ID: <20200920112914.26501-8-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
References: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In accordance with [1] the relaxed methods are guaranteed to be ordered
with respect to other accesses from the same CPU thread to the same
peripheral.  This is what we need during the data read/write from/to the
controller FIFOs being executed within a single IRQ handler or a kernel
task.

Such optimization shall significantly speed the data reader and writer up.
For instance, the relaxed IO-accessors utilization on Baikal-T1 lets the
driver to support the SPI memory operations with bus frequency three-fold
faster than if normal IO-accessors would be used.

[1] "LINUX KERNEL MEMORY BARRIERS", Documentation/memory-barriers.txt,
    Section "KERNEL I/O BARRIER EFFECTS"

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw.h | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index ff77f39047ce..063fa1b1352d 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -161,29 +161,19 @@ static inline u32 dw_readl(struct dw_spi *dws, u32 offset)
 	return __raw_readl(dws->regs + offset);
 }
 
-static inline u16 dw_readw(struct dw_spi *dws, u32 offset)
-{
-	return __raw_readw(dws->regs + offset);
-}
-
 static inline void dw_writel(struct dw_spi *dws, u32 offset, u32 val)
 {
 	__raw_writel(val, dws->regs + offset);
 }
 
-static inline void dw_writew(struct dw_spi *dws, u32 offset, u16 val)
-{
-	__raw_writew(val, dws->regs + offset);
-}
-
 static inline u32 dw_read_io_reg(struct dw_spi *dws, u32 offset)
 {
 	switch (dws->reg_io_width) {
 	case 2:
-		return dw_readw(dws, offset);
+		return readw_relaxed(dws->regs + offset);
 	case 4:
 	default:
-		return dw_readl(dws, offset);
+		return readl_relaxed(dws->regs + offset);
 	}
 }
 
@@ -191,11 +181,11 @@ static inline void dw_write_io_reg(struct dw_spi *dws, u32 offset, u32 val)
 {
 	switch (dws->reg_io_width) {
 	case 2:
-		dw_writew(dws, offset, val);
+		writew_relaxed(val, dws->regs + offset);
 		break;
 	case 4:
 	default:
-		dw_writel(dws, offset, val);
+		writel_relaxed(val, dws->regs + offset);
 		break;
 	}
 }
-- 
2.27.0

