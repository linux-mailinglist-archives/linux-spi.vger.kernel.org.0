Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF188280A16
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 00:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387437AbgJAW3W (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Oct 2020 18:29:22 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:48356 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733300AbgJAW3R (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Oct 2020 18:29:17 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id BE60A803017D;
        Thu,  1 Oct 2020 22:29:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qxaMiqLPiln0; Fri,  2 Oct 2020 01:29:09 +0300 (MSK)
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
Subject: [PATCH v3 21/21] spi: dw: Add Baikal-T1 SPI Controller glue driver
Date:   Fri, 2 Oct 2020 01:28:29 +0300
Message-ID: <20201001222829.15977-22-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20201001222829.15977-1-Sergey.Semin@baikalelectronics.ru>
References: <20201001222829.15977-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Baikal-T1 is equipped with three DW APB SSI-based MMIO SPI controllers.
Two of them are pretty much normal: with IRQ, DMA, FIFOs of 64 words
depth, 4x CSs, but the third one as being a part of the Baikal-T1 System
Boot Controller has got a very limited resources: no IRQ, no DMA, only a
single native chip-select and Tx/Rx FIFO with just 8 words depth
available. In order to provide a transparent initial boot code execution
the Boot SPI controller is also utilized by an vendor-specific IP-block,
which exposes an SPI flash direct mapping interface. Since both direct
mapping and SPI controller normal utilization are mutual exclusive only
one of these interfaces can be used to access an external SPI slave
device. That's why a dedicated mux is embedded into the System Boot
Controller. All of that is taken into account in the Baikal-T1-specific DW
APB SSI glue driver implemented by means of the DW SPI core module.

Co-developed-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Signed-off-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/Kconfig      |  28 ++++
 drivers/spi/Makefile     |   1 +
 drivers/spi/spi-dw-bt1.c | 339 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 368 insertions(+)
 create mode 100644 drivers/spi/spi-dw-bt1.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 1f70bb1e7fa9..415d57b2057f 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -252,6 +252,34 @@ config SPI_DW_MMIO
 	tristate "Memory-mapped io interface driver for DW SPI core"
 	depends on HAS_IOMEM
 
+config SPI_DW_BT1
+	tristate "Baikal-T1 SPI driver for DW SPI core"
+	depends on MIPS_BAIKAL_T1 || COMPILE_TEST
+	help
+	  Baikal-T1 SoC is equipped with three DW APB SSI-based MMIO SPI
+	  controllers. Two of them are pretty much normal: with IRQ, DMA,
+	  FIFOs of 64 words depth, 4x CSs, but the third one as being a
+	  part of the Baikal-T1 System Boot Controller has got a very
+	  limited resources: no IRQ, no DMA, only a single native
+	  chip-select and Tx/Rx FIFO with just 8 words depth available.
+	  The later one is normally connected to an external SPI-nor flash
+	  of 128Mb (in general can be of bigger size).
+
+config SPI_DW_BT1_DIRMAP
+	bool "Directly mapped Baikal-T1 Boot SPI flash support"
+	depends on SPI_DW_BT1
+	select MULTIPLEXER
+	select MUX_MMIO
+	help
+	  Directly mapped SPI flash memory is an interface specific to the
+	  Baikal-T1 System Boot Controller. It is a 16MB MMIO region, which
+	  can be used to access a peripheral memory device just by
+	  reading/writing data from/to it. Note that the system APB bus
+	  will stall during each IO from/to the dirmap region until the
+	  operation is finished. So try not to use it concurrently with
+	  time-critical tasks (like the SPI memory operations implemented
+	  in this driver).
+
 endif
 
 config SPI_DLN2
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index cf955ea803cd..21dc75842aca 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_SPI_DLN2)			+= spi-dln2.o
 obj-$(CONFIG_SPI_DESIGNWARE)		+= spi-dw.o
 spi-dw-y				:= spi-dw-core.o
 spi-dw-$(CONFIG_SPI_DW_DMA)		+= spi-dw-dma.o
+obj-$(CONFIG_SPI_DW_BT1)		+= spi-dw-bt1.o
 obj-$(CONFIG_SPI_DW_MMIO)		+= spi-dw-mmio.o
 obj-$(CONFIG_SPI_DW_PCI)		+= spi-dw-pci.o
 obj-$(CONFIG_SPI_EFM32)			+= spi-efm32.o
diff --git a/drivers/spi/spi-dw-bt1.c b/drivers/spi/spi-dw-bt1.c
new file mode 100644
index 000000000000..f382dfad7842
--- /dev/null
+++ b/drivers/spi/spi-dw-bt1.c
@@ -0,0 +1,339 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Copyright (C) 2020 BAIKAL ELECTRONICS, JSC
+//
+// Authors:
+//   Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
+//   Serge Semin <Sergey.Semin@baikalelectronics.ru>
+//
+// Baikal-T1 DW APB SPI and System Boot SPI driver
+//
+
+#include <linux/clk.h>
+#include <linux/cpumask.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/mux/consumer.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+#include <linux/spi/spi-mem.h>
+#include <linux/spi/spi.h>
+
+#include "spi-dw.h"
+
+#define BT1_BOOT_DIRMAP		0
+#define BT1_BOOT_REGS		1
+
+struct dw_spi_bt1 {
+	struct dw_spi		dws;
+	struct clk		*clk;
+	struct mux_control	*mux;
+
+#ifdef CONFIG_SPI_DW_BT1_DIRMAP
+	void __iomem		*map;
+	resource_size_t		map_len;
+#endif
+};
+#define to_dw_spi_bt1(_ctlr) \
+	container_of(spi_controller_get_devdata(_ctlr), struct dw_spi_bt1, dws)
+
+typedef int (*dw_spi_bt1_init_cb)(struct platform_device *pdev,
+				    struct dw_spi_bt1 *dwsbt1);
+
+#ifdef CONFIG_SPI_DW_BT1_DIRMAP
+
+static int dw_spi_bt1_dirmap_create(struct spi_mem_dirmap_desc *desc)
+{
+	struct dw_spi_bt1 *dwsbt1 = to_dw_spi_bt1(desc->mem->spi->controller);
+
+	if (!dwsbt1->map ||
+	    !dwsbt1->dws.mem_ops.supports_op(desc->mem, &desc->info.op_tmpl))
+		return -EOPNOTSUPP;
+
+	/*
+	 * Make sure the requested region doesn't go out of the physically
+	 * mapped flash memory bounds and the operation is read-only.
+	 */
+	if (desc->info.offset + desc->info.length > dwsbt1->map_len ||
+	    desc->info.op_tmpl.data.dir != SPI_MEM_DATA_IN)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+/*
+ * Directly mapped SPI memory region is only accessible in the dword chunks.
+ * That's why we have to create a dedicated read-method to copy data from there
+ * to the passed buffer.
+ */
+static void dw_spi_bt1_dirmap_copy_from_map(void *to, void __iomem *from, size_t len)
+{
+	size_t shift, chunk;
+	u32 data;
+
+	/*
+	 * We split the copying up into the next three stages: unaligned head,
+	 * aligned body, unaligned tail.
+	 */
+	shift = (size_t)from & 0x3;
+	if (shift) {
+		chunk = min_t(size_t, 4 - shift, len);
+		data = readl_relaxed(from - shift);
+		memcpy(to, &data + shift, chunk);
+		from += chunk;
+		to += chunk;
+		len -= chunk;
+	}
+
+	while (len >= 4) {
+		data = readl_relaxed(from);
+		memcpy(to, &data, 4);
+		from += 4;
+		to += 4;
+		len -= 4;
+	}
+
+	if (len) {
+		data = readl_relaxed(from);
+		memcpy(to, &data, len);
+	}
+}
+
+static ssize_t dw_spi_bt1_dirmap_read(struct spi_mem_dirmap_desc *desc,
+				      u64 offs, size_t len, void *buf)
+{
+	struct dw_spi_bt1 *dwsbt1 = to_dw_spi_bt1(desc->mem->spi->controller);
+	struct dw_spi *dws = &dwsbt1->dws;
+	struct spi_mem *mem = desc->mem;
+	struct dw_spi_cfg cfg;
+	int ret;
+
+	/*
+	 * Make sure the requested operation length is valid. Truncate the
+	 * length if it's greater than the length of the MMIO region.
+	 */
+	if (offs >= dwsbt1->map_len || !len)
+		return 0;
+
+	len = min_t(size_t, len, dwsbt1->map_len - offs);
+
+	/* Collect the controller configuration required by the operation */
+	cfg.tmode = SPI_TMOD_EPROMREAD;
+	cfg.dfs = 8;
+	cfg.ndf = 4;
+	cfg.freq = mem->spi->max_speed_hz;
+
+	/* Make sure the corresponding CS is de-asserted on transmission */
+	dw_spi_set_cs(mem->spi, false);
+
+	spi_enable_chip(dws, 0);
+
+	dw_spi_update_config(dws, mem->spi, &cfg);
+
+	spi_umask_intr(dws, SPI_INT_RXFI);
+
+	spi_enable_chip(dws, 1);
+
+	/*
+	 * Enable the transparent mode of the System Boot Controller.
+	 * The SPI core IO should have been locked before calling this method
+	 * so noone would be touching the controller' registers during the
+	 * dirmap operation.
+	 */
+	ret = mux_control_select(dwsbt1->mux, BT1_BOOT_DIRMAP);
+	if (ret)
+		return ret;
+
+	dw_spi_bt1_dirmap_copy_from_map(buf, dwsbt1->map + offs, len);
+
+	mux_control_deselect(dwsbt1->mux);
+
+	dw_spi_set_cs(mem->spi, true);
+
+	ret = dw_spi_check_status(dws, true);
+
+	return ret ?: len;
+}
+
+#endif /* CONFIG_SPI_DW_BT1_DIRMAP */
+
+static int dw_spi_bt1_std_init(struct platform_device *pdev,
+			       struct dw_spi_bt1 *dwsbt1)
+{
+	struct dw_spi *dws = &dwsbt1->dws;
+
+	dws->irq = platform_get_irq(pdev, 0);
+	if (dws->irq < 0)
+		return dws->irq;
+
+	dws->num_cs = 4;
+
+	/*
+	 * Baikal-T1 Normal SPI Controllers don't always keep up with full SPI
+	 * bus speed especially when it comes to the concurrent access to the
+	 * APB bus resources. Thus we have no choice but to set a constraint on
+	 * the SPI bus frequency for the memory operations which require to
+	 * read/write data as fast as possible.
+	 */
+	dws->max_mem_freq = 20000000U;
+
+	dw_spi_dma_setup_generic(dws);
+
+	return 0;
+}
+
+static int dw_spi_bt1_sys_init(struct platform_device *pdev,
+			       struct dw_spi_bt1 *dwsbt1)
+{
+	struct resource *mem __maybe_unused;
+	struct dw_spi *dws = &dwsbt1->dws;
+
+	/*
+	 * Baikal-T1 System Boot Controller is equipped with a mux, which
+	 * switches between the directly mapped SPI flash access mode and
+	 * IO access to the DW APB SSI registers. Note the mux controller
+	 * must be setup to preserve the registers being accessible by default
+	 * (on idle-state).
+	 */
+	dwsbt1->mux = devm_mux_control_get(&pdev->dev, NULL);
+	if (IS_ERR(dwsbt1->mux))
+		return PTR_ERR(dwsbt1->mux);
+
+	/*
+	 * Directly mapped SPI flash memory is a 16MB MMIO region, which can be
+	 * used to access a peripheral memory device just by reading/writing
+	 * data from/to it. Note the system APB bus will stall during each IO
+	 * from/to the dirmap region until the operation is finished. So don't
+	 * use it concurrently with time-critical tasks (like the SPI memory
+	 * operations implemented in the DW APB SSI driver).
+	 */
+#ifdef CONFIG_SPI_DW_BT1_DIRMAP
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (mem) {
+		dwsbt1->map = devm_ioremap_resource(&pdev->dev, mem);
+		if (!IS_ERR(dwsbt1->map)) {
+			dwsbt1->map_len = (mem->end - mem->start + 1);
+			dws->mem_ops.dirmap_create = dw_spi_bt1_dirmap_create;
+			dws->mem_ops.dirmap_read = dw_spi_bt1_dirmap_read;
+		} else {
+			dwsbt1->map = NULL;
+		}
+	}
+#endif /* CONFIG_SPI_DW_BT1_DIRMAP */
+
+	/*
+	 * There is no IRQ, no DMA and just one CS available on the System Boot
+	 * SPI controller.
+	 */
+	dws->irq = IRQ_NOTCONNECTED;
+	dws->num_cs = 1;
+
+	/*
+	 * Baikal-T1 System Boot SPI Controller doesn't keep up with the full
+	 * SPI bus speed due to relatively slow APB bus and races for it'
+	 * resources from different CPUs. The situation is worsen by a small
+	 * FIFOs depth (just 8 words). It works better in a single CPU mode
+	 * though, but still tends to be not fast enough at low CPU
+	 * frequencies.
+	 */
+	if (num_possible_cpus() > 1)
+		dws->max_mem_freq = 10000000U;
+	else
+		dws->max_mem_freq = 20000000U;
+
+	return 0;
+}
+
+static int dw_spi_bt1_probe(struct platform_device *pdev)
+{
+	dw_spi_bt1_init_cb init_func;
+	struct dw_spi_bt1 *dwsbt1;
+	struct resource *mem;
+	struct dw_spi *dws;
+	int ret;
+
+	dwsbt1 = devm_kzalloc(&pdev->dev, sizeof(struct dw_spi_bt1), GFP_KERNEL);
+	if (!dwsbt1)
+		return -ENOMEM;
+
+	dws = &dwsbt1->dws;
+
+	dws->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
+	if (IS_ERR(dws->regs))
+		return PTR_ERR(dws->regs);
+
+	dws->paddr = mem->start;
+
+	dwsbt1->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(dwsbt1->clk))
+		return PTR_ERR(dwsbt1->clk);
+
+	ret = clk_prepare_enable(dwsbt1->clk);
+	if (ret)
+		return ret;
+
+	dws->bus_num = pdev->id;
+	dws->reg_io_width = 4;
+	dws->max_freq = clk_get_rate(dwsbt1->clk);
+	if (!dws->max_freq)
+		goto err_disable_clk;
+
+	init_func = device_get_match_data(&pdev->dev);
+	ret = init_func(pdev, dwsbt1);
+	if (ret)
+		goto err_disable_clk;
+
+	pm_runtime_enable(&pdev->dev);
+
+	ret = dw_spi_add_host(&pdev->dev, dws);
+	if (ret)
+		goto err_disable_clk;
+
+	platform_set_drvdata(pdev, dwsbt1);
+
+	return 0;
+
+err_disable_clk:
+	clk_disable_unprepare(dwsbt1->clk);
+
+	return ret;
+}
+
+static int dw_spi_bt1_remove(struct platform_device *pdev)
+{
+	struct dw_spi_bt1 *dwsbt1 = platform_get_drvdata(pdev);
+
+	dw_spi_remove_host(&dwsbt1->dws);
+
+	pm_runtime_disable(&pdev->dev);
+
+	clk_disable_unprepare(dwsbt1->clk);
+
+	return 0;
+}
+
+static const struct of_device_id dw_spi_bt1_of_match[] = {
+	{ .compatible = "baikal,bt1-ssi", .data = dw_spi_bt1_std_init},
+	{ .compatible = "baikal,bt1-sys-ssi", .data = dw_spi_bt1_sys_init},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, dw_spi_bt1_of_match);
+
+static struct platform_driver dw_spi_bt1_driver = {
+	.probe	= dw_spi_bt1_probe,
+	.remove	= dw_spi_bt1_remove,
+	.driver	= {
+		.name		= "bt1-sys-ssi",
+		.of_match_table	= dw_spi_bt1_of_match,
+	},
+};
+module_platform_driver(dw_spi_bt1_driver);
+
+MODULE_AUTHOR("Serge Semin <Sergey.Semin@baikalelectronics.ru>");
+MODULE_DESCRIPTION("Baikal-T1 System Boot SPI Controller driver");
+MODULE_LICENSE("GPL v2");
-- 
2.27.0

