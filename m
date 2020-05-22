Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C271B1DDBBE
	for <lists+linux-spi@lfdr.de>; Fri, 22 May 2020 02:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbgEVAJW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 20:09:22 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:41566 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730255AbgEVAJW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 May 2020 20:09:22 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 9DA118029EC9;
        Fri, 22 May 2020 00:09:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WRc5ToI_dDpy; Fri, 22 May 2020 03:09:19 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Stephen Boyd <swboyd@chromium.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 14/16] spi: dw: Add DMA support to the DW SPI MMIO driver
Date:   Fri, 22 May 2020 03:08:03 +0300
Message-ID: <20200522000806.7381-15-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200522000806.7381-1-Sergey.Semin@baikalelectronics.ru>
References: <20200522000806.7381-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Since the common code in the spi-dw-dma.c driver is ready to be used
by the MMIO driver and now provides a method to generically (on any
DT or ACPI-based platforms) retrieve the Tx/Rx DMA channel handlers,
we can use it and a set of the common DW SPI DMA callbacks to enable
DMA at least for generic "snps,dw-apb-ssi" and "snps,dwc-ssi-1.01a"
devices.

Co-developed-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Signed-off-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Co-developed-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Signed-off-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
 drivers/spi/spi-dw-mmio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 0894b4c09496..e23d0c53a664 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -149,6 +149,8 @@ static int dw_spi_dw_apb_init(struct platform_device *pdev,
 	/* Register hook to configure CTRLR0 */
 	dwsmmio->dws.update_cr0 = dw_spi_update_cr0;
 
+	dw_spi_dma_setup_generic(&dwsmmio->dws);
+
 	return 0;
 }
 
@@ -158,6 +160,8 @@ static int dw_spi_dwc_ssi_init(struct platform_device *pdev,
 	/* Register hook to configure CTRLR0 */
 	dwsmmio->dws.update_cr0 = dw_spi_update_cr0_v1_01a;
 
+	dw_spi_dma_setup_generic(&dwsmmio->dws);
+
 	return 0;
 }
 
-- 
2.25.1

