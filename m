Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867881D4B70
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 12:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgEOKtJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 06:49:09 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:35448 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbgEOKtI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 May 2020 06:49:08 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 5546980005EE;
        Fri, 15 May 2020 10:49:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id k9IDQoajzosZ; Fri, 15 May 2020 13:49:02 +0300 (MSK)
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
        <devicetree@vger.kernel.org>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Jay Fang <f.fangjian@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        YueHaibing <yuehaibing@huawei.com>,
        Stephen Boyd <swboyd@chromium.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 11/19] spi: dw: Initialize paddr in DW SPI MMIO private data
Date:   Fri, 15 May 2020 13:47:50 +0300
Message-ID: <20200515104758.6934-12-Sergey.Semin@baikalelectronics.ru>
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

This field is used only for the DW SPI DMA code initialization, that's
why there were no problems with it being uninitialized in Dw SPI MMIO
driver. Since in a further patch we are going to introduce the DW SPI DMA
support in the MMIO version of the driver, lets set the field with the
physical address of the DW SPI controller registers region.

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
 drivers/spi/spi-dw-mmio.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 398f7926cf92..0894b4c09496 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -184,6 +184,7 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	int (*init_func)(struct platform_device *pdev,
 			 struct dw_spi_mmio *dwsmmio);
 	struct dw_spi_mmio *dwsmmio;
+	struct resource *mem;
 	struct dw_spi *dws;
 	int ret;
 	int num_cs;
@@ -196,10 +197,12 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	dws = &dwsmmio->dws;
 
 	/* Get basic io resource and map it */
-	dws->regs = devm_platform_ioremap_resource(pdev, 0);
+	dws->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
 	if (IS_ERR(dws->regs))
 		return PTR_ERR(dws->regs);
 
+	dws->paddr = mem->start;
+
 	dws->irq = platform_get_irq(pdev, 0);
 	if (dws->irq < 0)
 		return dws->irq; /* -ENXIO */
-- 
2.25.1

