Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5DF71D4B82
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 12:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgEOKte (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 06:49:34 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:35748 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbgEOKtc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 May 2020 06:49:32 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id B53D58029EC9;
        Fri, 15 May 2020 10:49:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WHYMAwD-Aa_0; Fri, 15 May 2020 13:49:24 +0300 (MSK)
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
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, John Garry <john.garry@huawei.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 15/19] spi: dw: Add DW SPI DMA/PCI/MMIO dependency on the DW SPI core
Date:   Fri, 15 May 2020 13:47:54 +0300
Message-ID: <20200515104758.6934-16-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Seeing all of the DW SPI driver components like DW SPI DMA/PCI/MMIO
depend on the DW SPI core code it's better to use the if-endif
conditional kernel config statement to signify that common dependency.

Co-developed-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Signed-off-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Co-developed-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Signed-off-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Allison Randal <allison@lohutok.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Gareth Williams <gareth.williams.jx@renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
 drivers/spi/Kconfig | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 6a84f3dad35c..3cdf8310d185 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -226,17 +226,20 @@ config SPI_DESIGNWARE
 	help
 	  general driver for SPI controller core from DesignWare
 
+if SPI_DESIGNWARE
+
 config SPI_DW_DMA
 	bool "DMA support for DW SPI controller"
-	depends on SPI_DESIGNWARE
 
 config SPI_DW_PCI
 	tristate "PCI interface driver for DW SPI core"
-	depends on SPI_DESIGNWARE && PCI
+	depends on PCI
 
 config SPI_DW_MMIO
 	tristate "Memory-mapped io interface driver for DW SPI core"
-	depends on SPI_DESIGNWARE
+	depends on HAS_IOMEM
+
+endif
 
 config SPI_DLN2
        tristate "Diolan DLN-2 USB SPI adapter"
-- 
2.25.1

