Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9FDE1E740F
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 06:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389518AbgE2D7l (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 May 2020 23:59:41 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:45454 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389305AbgE2D7k (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 May 2020 23:59:40 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 70360803077A;
        Fri, 29 May 2020 03:59:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id N8_5g2D6vp7n; Fri, 29 May 2020 06:59:36 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 09/16] spi: dw: Add core suffix to the DW APB SSI core source file
Date:   Fri, 29 May 2020 06:59:07 +0300
Message-ID: <20200529035915.20790-10-Sergey.Semin@baikalelectronics.ru>
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

Generic DMA support is going to be part of the DW APB SSI core object.
In order to preserve the kernel loadable module name as spi-dw.ko, let's
add the "-core" suffix to the object with generic DW APB SSI code and
build it into the target spi-dw.ko driver.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mips@vger.kernel.org
Cc: devicetree@vger.kernel.org

---

Changelog v3:
- This is a new patch added as a result of the discussion with Andy
  Shevchenko.
---
 drivers/spi/Makefile                    | 1 +
 drivers/spi/{spi-dw.c => spi-dw-core.c} | 0
 2 files changed, 1 insertion(+)
 rename drivers/spi/{spi-dw.c => spi-dw-core.c} (100%)

diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 28f601327f8c..70ebc2a62e5f 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_SPI_COLDFIRE_QSPI)		+= spi-coldfire-qspi.o
 obj-$(CONFIG_SPI_DAVINCI)		+= spi-davinci.o
 obj-$(CONFIG_SPI_DLN2)			+= spi-dln2.o
 obj-$(CONFIG_SPI_DESIGNWARE)		+= spi-dw.o
+spi-dw-y				:= spi-dw-core.o
 obj-$(CONFIG_SPI_DW_MMIO)		+= spi-dw-mmio.o
 obj-$(CONFIG_SPI_DW_PCI)		+= spi-dw-midpci.o
 spi-dw-midpci-objs			:= spi-dw-pci.o spi-dw-mid.o
diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw-core.c
similarity index 100%
rename from drivers/spi/spi-dw.c
rename to drivers/spi/spi-dw-core.c
-- 
2.26.2

