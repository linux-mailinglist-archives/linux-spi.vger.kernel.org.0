Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B6C1E742B
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 06:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391448AbgE2EAw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 00:00:52 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:45412 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389387AbgE2D7l (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 May 2020 23:59:41 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id E75D9803078F;
        Fri, 29 May 2020 03:59:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gB-UnZMQ5-tN; Fri, 29 May 2020 06:59:38 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 10/16] spi: dw: Move Non-DMA code to the DW PCIe-SPI driver
Date:   Fri, 29 May 2020 06:59:08 +0300
Message-ID: <20200529035915.20790-11-Sergey.Semin@baikalelectronics.ru>
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

This is a preparation patch before adding the DW DMA support into the
DW SPI MMIO driver. We need to unpin the Non-DMA-specific code from the
intended to be generic DW APB SSI DMA code. This isn't that hard,
since the most part of the spi-dw-mid.c driver in fact implements a
generic DMA interface for the DW SPI controller driver. The only Intel
MID specifics concern getting the max frequency from the MRST Clock
Control Unit and fetching the DMA controller channels from
corresponding PCIe DMA controller. Since first one is related with the
SPI interface configuration we moved it' implementation into the
DW PCIe-SPI driver module. After that former spi-dw-mid.c file
can be just renamed to be the DW SPI DMA module optionally compiled in to
the DW APB SSI core driver.

Co-developed-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Signed-off-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Co-developed-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Signed-off-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: devicetree@vger.kernel.org

---

Changelog v2:
- Compile the DW SPI DMA module into the DW APB SSI core instead of being
  a separate driver.
---
 drivers/spi/Kconfig                        |  8 +--
 drivers/spi/Makefile                       |  4 +-
 drivers/spi/{spi-dw-mid.c => spi-dw-dma.c} | 66 +++-------------------
 drivers/spi/spi-dw-pci.c                   | 50 +++++++++++++++-
 drivers/spi/spi-dw.h                       | 14 ++++-
 5 files changed, 73 insertions(+), 69 deletions(-)
 rename drivers/spi/{spi-dw-mid.c => spi-dw-dma.c} (88%)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 741b9140992a..03b061975f70 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -226,14 +226,14 @@ config SPI_DESIGNWARE
 	help
 	  general driver for SPI controller core from DesignWare
 
+config SPI_DW_DMA
+	bool "DMA support for DW SPI controller"
+	depends on SPI_DESIGNWARE && DW_DMAC_PCI
+
 config SPI_DW_PCI
 	tristate "PCI interface driver for DW SPI core"
 	depends on SPI_DESIGNWARE && PCI
 
-config SPI_DW_MID_DMA
-	bool "DMA support for DW SPI controller on Intel MID platform"
-	depends on SPI_DW_PCI && DW_DMAC_PCI
-
 config SPI_DW_MMIO
 	tristate "Memory-mapped io interface driver for DW SPI core"
 	depends on SPI_DESIGNWARE
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 70ebc2a62e5f..c4aa80085257 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -37,9 +37,9 @@ obj-$(CONFIG_SPI_DAVINCI)		+= spi-davinci.o
 obj-$(CONFIG_SPI_DLN2)			+= spi-dln2.o
 obj-$(CONFIG_SPI_DESIGNWARE)		+= spi-dw.o
 spi-dw-y				:= spi-dw-core.o
+spi-dw-$(CONFIG_SPI_DW_DMA)		+= spi-dw-dma.o
 obj-$(CONFIG_SPI_DW_MMIO)		+= spi-dw-mmio.o
-obj-$(CONFIG_SPI_DW_PCI)		+= spi-dw-midpci.o
-spi-dw-midpci-objs			:= spi-dw-pci.o spi-dw-mid.o
+obj-$(CONFIG_SPI_DW_PCI)		+= spi-dw-pci.o
 obj-$(CONFIG_SPI_EFM32)			+= spi-efm32.o
 obj-$(CONFIG_SPI_EP93XX)		+= spi-ep93xx.o
 obj-$(CONFIG_SPI_FALCON)		+= spi-falcon.o
diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-dma.c
similarity index 88%
rename from drivers/spi/spi-dw-mid.c
rename to drivers/spi/spi-dw-dma.c
index ff79b4239d68..30bd9800f2df 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -1,16 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Special handling for DW core on Intel MID platform
+ * Special handling for DW DMA core
  *
  * Copyright (c) 2009, 2014 Intel Corporation.
  */
 
-#include <linux/spi/spi.h>
-#include <linux/types.h>
-
-#include "spi-dw.h"
-
-#ifdef CONFIG_SPI_DW_MID_DMA
 #include <linux/completion.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
@@ -18,6 +12,10 @@
 #include <linux/jiffies.h>
 #include <linux/pci.h>
 #include <linux/platform_data/dma-dw.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+
+#include "spi-dw.h"
 
 #define WAIT_RETRIES	5
 #define RX_BUSY		0
@@ -461,10 +459,11 @@ static const struct dw_spi_dma_ops mfld_dma_ops = {
 	.dma_stop	= mid_spi_dma_stop,
 };
 
-static void dw_spi_mid_setup_dma_mfld(struct dw_spi *dws)
+void dw_spi_mid_setup_dma_mfld(struct dw_spi *dws)
 {
 	dws->dma_ops = &mfld_dma_ops;
 }
+EXPORT_SYMBOL_GPL(dw_spi_mid_setup_dma_mfld);
 
 static const struct dw_spi_dma_ops generic_dma_ops = {
 	.dma_init	= mid_spi_dma_init_generic,
@@ -475,55 +474,8 @@ static const struct dw_spi_dma_ops generic_dma_ops = {
 	.dma_stop	= mid_spi_dma_stop,
 };
 
-static void dw_spi_mid_setup_dma_generic(struct dw_spi *dws)
+void dw_spi_mid_setup_dma_generic(struct dw_spi *dws)
 {
 	dws->dma_ops = &generic_dma_ops;
 }
-#else	/* CONFIG_SPI_DW_MID_DMA */
-static inline void dw_spi_mid_setup_dma_mfld(struct dw_spi *dws) {}
-static inline void dw_spi_mid_setup_dma_generic(struct dw_spi *dws) {}
-#endif
-
-/* Some specific info for SPI0 controller on Intel MID */
-
-/* HW info for MRST Clk Control Unit, 32b reg per controller */
-#define MRST_SPI_CLK_BASE	100000000	/* 100m */
-#define MRST_CLK_SPI_REG	0xff11d86c
-#define CLK_SPI_BDIV_OFFSET	0
-#define CLK_SPI_BDIV_MASK	0x00000007
-#define CLK_SPI_CDIV_OFFSET	9
-#define CLK_SPI_CDIV_MASK	0x00000e00
-#define CLK_SPI_DISABLE_OFFSET	8
-
-int dw_spi_mid_init_mfld(struct dw_spi *dws)
-{
-	void __iomem *clk_reg;
-	u32 clk_cdiv;
-
-	clk_reg = ioremap(MRST_CLK_SPI_REG, 16);
-	if (!clk_reg)
-		return -ENOMEM;
-
-	/* Get SPI controller operating freq info */
-	clk_cdiv = readl(clk_reg + dws->bus_num * sizeof(u32));
-	clk_cdiv &= CLK_SPI_CDIV_MASK;
-	clk_cdiv >>= CLK_SPI_CDIV_OFFSET;
-	dws->max_freq = MRST_SPI_CLK_BASE / (clk_cdiv + 1);
-
-	iounmap(clk_reg);
-
-	/* Register hook to configure CTRLR0 */
-	dws->update_cr0 = dw_spi_update_cr0;
-
-	dw_spi_mid_setup_dma_mfld(dws);
-	return 0;
-}
-
-int dw_spi_mid_init_generic(struct dw_spi *dws)
-{
-	/* Register hook to configure CTRLR0 */
-	dws->update_cr0 = dw_spi_update_cr0;
-
-	dw_spi_mid_setup_dma_generic(dws);
-	return 0;
-}
+EXPORT_SYMBOL_GPL(dw_spi_mid_setup_dma_generic);
diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index dde54a918b5d..c13707b8493e 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -15,6 +15,15 @@
 
 #define DRIVER_NAME "dw_spi_pci"
 
+/* HW info for MRST Clk Control Unit, 32b reg per controller */
+#define MRST_SPI_CLK_BASE	100000000	/* 100m */
+#define MRST_CLK_SPI_REG	0xff11d86c
+#define CLK_SPI_BDIV_OFFSET	0
+#define CLK_SPI_BDIV_MASK	0x00000007
+#define CLK_SPI_CDIV_OFFSET	9
+#define CLK_SPI_CDIV_MASK	0x00000e00
+#define CLK_SPI_DISABLE_OFFSET	8
+
 struct spi_pci_desc {
 	int	(*setup)(struct dw_spi *);
 	u16	num_cs;
@@ -22,20 +31,55 @@ struct spi_pci_desc {
 	u32	max_freq;
 };
 
+static int spi_mid_init(struct dw_spi *dws)
+{
+	void __iomem *clk_reg;
+	u32 clk_cdiv;
+
+	clk_reg = ioremap(MRST_CLK_SPI_REG, 16);
+	if (!clk_reg)
+		return -ENOMEM;
+
+	/* Get SPI controller operating freq info */
+	clk_cdiv = readl(clk_reg + dws->bus_num * sizeof(u32));
+	clk_cdiv &= CLK_SPI_CDIV_MASK;
+	clk_cdiv >>= CLK_SPI_CDIV_OFFSET;
+	dws->max_freq = MRST_SPI_CLK_BASE / (clk_cdiv + 1);
+
+	iounmap(clk_reg);
+
+	/* Register hook to configure CTRLR0 */
+	dws->update_cr0 = dw_spi_update_cr0;
+
+	dw_spi_mid_setup_dma_mfld(dws);
+
+	return 0;
+}
+
+static int spi_generic_init(struct dw_spi *dws)
+{
+	/* Register hook to configure CTRLR0 */
+	dws->update_cr0 = dw_spi_update_cr0;
+
+	dw_spi_mid_setup_dma_generic(dws);
+
+	return 0;
+}
+
 static struct spi_pci_desc spi_pci_mid_desc_1 = {
-	.setup = dw_spi_mid_init_mfld,
+	.setup = spi_mid_init,
 	.num_cs = 5,
 	.bus_num = 0,
 };
 
 static struct spi_pci_desc spi_pci_mid_desc_2 = {
-	.setup = dw_spi_mid_init_mfld,
+	.setup = spi_mid_init,
 	.num_cs = 2,
 	.bus_num = 1,
 };
 
 static struct spi_pci_desc spi_pci_ehl_desc = {
-	.setup = dw_spi_mid_init_generic,
+	.setup = spi_generic_init,
 	.num_cs = 2,
 	.bus_num = -1,
 	.max_freq = 100000000,
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 9247670fcdfb..91608cf12636 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -257,8 +257,16 @@ extern u32 dw_spi_update_cr0_v1_01a(struct spi_controller *master,
 				    struct spi_device *spi,
 				    struct spi_transfer *transfer);
 
-/* platform related setup */
-extern int dw_spi_mid_init_mfld(struct dw_spi *dws);
-extern int dw_spi_mid_init_generic(struct dw_spi *dws);
+#ifdef CONFIG_SPI_DW_DMA
+
+extern void dw_spi_mid_setup_dma_mfld(struct dw_spi *dws);
+extern void dw_spi_mid_setup_dma_generic(struct dw_spi *dws);
+
+#else
+
+static inline void dw_spi_mid_setup_dma_mfld(struct dw_spi *dws) {}
+static inline void dw_spi_mid_setup_dma_generic(struct dw_spi *dws) {}
+
+#endif /* !CONFIG_SPI_DW_DMA */
 
 #endif /* DW_SPI_HEADER_H */
-- 
2.26.2

