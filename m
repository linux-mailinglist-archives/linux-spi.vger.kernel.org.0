Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282152C6843
	for <lists+linux-spi@lfdr.de>; Fri, 27 Nov 2020 15:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730868AbgK0Oxt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 27 Nov 2020 09:53:49 -0500
Received: from ns2.baikalelectronics.com ([94.125.187.42]:33640 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729913AbgK0Oxt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 27 Nov 2020 09:53:49 -0500
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Nov 2020 09:53:47 EST
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] spi: dw-bt1: Fix undefined devm_mux_control_get symbol
Date:   Fri, 27 Nov 2020 17:46:11 +0300
Message-ID: <20201127144612.4204-1-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20201116040721.8001-1-rdunlap@infradead.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

I mistakenly added the select attributes to the SPI_DW_BT1_DIRMAP config
instead of having them defined in SPI_DW_BT1. If the kernel doesn't have
the MULTIPLEXER and MUX_MMIO configs manually enabled and the
SPI_DW_BT1_DIRMAP config hasn't been selected, Baikal-T1 SPI device will
always fail to be probed by the driver. Fix that and the error reported by
the test robot:

>> ld.lld: error: undefined symbol: devm_mux_control_get
   >>> referenced by spi-dw-bt1.c
   >>> spi/spi-dw-bt1.o:(dw_spi_bt1_sys_init) in archive drivers/built-in.a

by moving the MULTIPLEXER/MUX_MMIO configs selection to the SPI_DW_BT1
config.

Link: https://lore.kernel.org/lkml/202011161745.uYRlekse-lkp@intel.com/
Link: https://lore.kernel.org/linux-spi/20201116040721.8001-1-rdunlap@infradead.org/
Fixes: abf00907538e ("spi: dw: Add Baikal-T1 SPI Controller glue driver")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>

---

Mark, I see you haven't applied the previous version of the patch yet. So
please replace it with this one.

Randy, sorry for resending the patch. I've just realized that your
solution doesn't completely fix the problem. Yeah, the kernel build won't
fail to be linked after your patch being merged, but the driver still will
fail to probe the device if the MULTIPLEXER and MUX_MMIO haven't been
selected for the kernel. So the select attributes need to be moved from
SPI_DW_BT1_DIRMAP to the SPI_DW_BT1 config.
---
 drivers/spi/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 415d57b2057f..0707068ffe47 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -255,6 +255,8 @@ config SPI_DW_MMIO
 config SPI_DW_BT1
 	tristate "Baikal-T1 SPI driver for DW SPI core"
 	depends on MIPS_BAIKAL_T1 || COMPILE_TEST
+	select MULTIPLEXER
+	select MUX_MMIO
 	help
 	  Baikal-T1 SoC is equipped with three DW APB SSI-based MMIO SPI
 	  controllers. Two of them are pretty much normal: with IRQ, DMA,
@@ -268,8 +270,6 @@ config SPI_DW_BT1
 config SPI_DW_BT1_DIRMAP
 	bool "Directly mapped Baikal-T1 Boot SPI flash support"
 	depends on SPI_DW_BT1
-	select MULTIPLEXER
-	select MUX_MMIO
 	help
 	  Directly mapped SPI flash memory is an interface specific to the
 	  Baikal-T1 System Boot Controller. It is a 16MB MMIO region, which
-- 
2.29.2

