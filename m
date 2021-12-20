Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0150B47B191
	for <lists+linux-spi@lfdr.de>; Mon, 20 Dec 2021 17:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236593AbhLTQqZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Dec 2021 11:46:25 -0500
Received: from mga01.intel.com ([192.55.52.88]:20054 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234391AbhLTQqY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 20 Dec 2021 11:46:24 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="264404546"
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="264404546"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 08:46:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="663668148"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 20 Dec 2021 08:46:18 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 5B2FC23E; Mon, 20 Dec 2021 18:46:26 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Subject: [PATCH v5 2/3] mtd: spi-nor: intel-spi: Convert to SPI MEM
Date:   Mon, 20 Dec 2021 19:46:24 +0300
Message-Id: <20211220164625.9400-3-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211220164625.9400-1-mika.westerberg@linux.intel.com>
References: <20211220164625.9400-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The preferred way to implement SPI-NOR controller drivers is through SPI
subsubsystem utilizing the SPI MEM core functions. This converts the
Intel SPI flash controller driver over the SPI MEM by moving the driver
from SPI-NOR subsystem to SPI subsystem and in one go make it use the
SPI MEM functions. The driver name will be changed from intel-spi to
spi-intel to match the convention used in the SPI subsystem.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mauro Lima <mauro.lima@eclypsium.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/spi-nor/controllers/Kconfig       |  36 -
 drivers/mtd/spi-nor/controllers/Makefile      |   3 -
 drivers/mtd/spi-nor/controllers/intel-spi.h   |  21 -
 drivers/spi/Kconfig                           |  39 +
 drivers/spi/Makefile                          |   3 +
 .../intel-spi-pci.c => spi/spi-intel-pci.c}   |  20 +-
 .../spi-intel-platform.c}                     |  21 +-
 .../intel-spi.c => spi/spi-intel.c}           | 806 ++++++++++++------
 drivers/spi/spi-intel.h                       |  19 +
 include/linux/mfd/lpc_ich.h                   |   2 +-
 .../x86/{intel-spi.h => spi-intel.h}          |   6 +-
 11 files changed, 608 insertions(+), 368 deletions(-)
 delete mode 100644 drivers/mtd/spi-nor/controllers/intel-spi.h
 rename drivers/{mtd/spi-nor/controllers/intel-spi-pci.c => spi/spi-intel-pci.c} (86%)
 rename drivers/{mtd/spi-nor/controllers/intel-spi-platform.c => spi/spi-intel-platform.c} (65%)
 rename drivers/{mtd/spi-nor/controllers/intel-spi.c => spi/spi-intel.c} (59%)
 create mode 100644 drivers/spi/spi-intel.h
 rename include/linux/platform_data/x86/{intel-spi.h => spi-intel.h} (89%)

diff --git a/drivers/mtd/spi-nor/controllers/Kconfig b/drivers/mtd/spi-nor/controllers/Kconfig
index 5c0e0ec2e6d1..50f4f3484d42 100644
--- a/drivers/mtd/spi-nor/controllers/Kconfig
+++ b/drivers/mtd/spi-nor/controllers/Kconfig
@@ -26,39 +26,3 @@ config SPI_NXP_SPIFI
 	  SPIFI is a specialized controller for connecting serial SPI
 	  Flash. Enable this option if you have a device with a SPIFI
 	  controller and want to access the Flash as a mtd device.
-
-config SPI_INTEL_SPI
-	tristate
-
-config SPI_INTEL_SPI_PCI
-	tristate "Intel PCH/PCU SPI flash PCI driver (DANGEROUS)"
-	depends on X86 && PCI
-	select SPI_INTEL_SPI
-	help
-	  This enables PCI support for the Intel PCH/PCU SPI controller in
-	  master mode. This controller is present in modern Intel hardware
-	  and is used to hold BIOS and other persistent settings. Using
-	  this driver it is possible to upgrade BIOS directly from Linux.
-
-	  Say N here unless you know what you are doing. Overwriting the
-	  SPI flash may render the system unbootable.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called intel-spi-pci.
-
-config SPI_INTEL_SPI_PLATFORM
-	tristate "Intel PCH/PCU SPI flash platform driver (DANGEROUS)"
-	depends on X86
-	select SPI_INTEL_SPI
-	help
-	  This enables platform support for the Intel PCH/PCU SPI
-	  controller in master mode. This controller is present in modern
-	  Intel hardware and is used to hold BIOS and other persistent
-	  settings. Using this driver it is possible to upgrade BIOS
-	  directly from Linux.
-
-	  Say N here unless you know what you are doing. Overwriting the
-	  SPI flash may render the system unbootable.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called intel-spi-platform.
diff --git a/drivers/mtd/spi-nor/controllers/Makefile b/drivers/mtd/spi-nor/controllers/Makefile
index e7abba491d98..6e2a1dc68466 100644
--- a/drivers/mtd/spi-nor/controllers/Makefile
+++ b/drivers/mtd/spi-nor/controllers/Makefile
@@ -2,6 +2,3 @@
 obj-$(CONFIG_SPI_ASPEED_SMC)	+= aspeed-smc.o
 obj-$(CONFIG_SPI_HISI_SFC)	+= hisi-sfc.o
 obj-$(CONFIG_SPI_NXP_SPIFI)	+= nxp-spifi.o
-obj-$(CONFIG_SPI_INTEL_SPI)	+= intel-spi.o
-obj-$(CONFIG_SPI_INTEL_SPI_PCI)	+= intel-spi-pci.o
-obj-$(CONFIG_SPI_INTEL_SPI_PLATFORM)	+= intel-spi-platform.o
diff --git a/drivers/mtd/spi-nor/controllers/intel-spi.h b/drivers/mtd/spi-nor/controllers/intel-spi.h
deleted file mode 100644
index f2871179fd34..000000000000
--- a/drivers/mtd/spi-nor/controllers/intel-spi.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Intel PCH/PCU SPI flash driver.
- *
- * Copyright (C) 2016, Intel Corporation
- * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
- */
-
-#ifndef INTEL_SPI_H
-#define INTEL_SPI_H
-
-#include <linux/platform_data/x86/intel-spi.h>
-
-struct intel_spi;
-struct resource;
-
-struct intel_spi *intel_spi_probe(struct device *dev,
-	struct resource *mem, const struct intel_spi_boardinfo *info);
-int intel_spi_remove(struct intel_spi *ispi);
-
-#endif /* INTEL_SPI_H */
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 596705d24400..104ec0b51bb4 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -427,6 +427,45 @@ config SPI_INGENIC
 	  To compile this driver as a module, choose M here: the module
 	  will be called spi-ingenic.
 
+config SPI_INTEL
+	tristate
+
+config SPI_INTEL_PCI
+	tristate "Intel PCH/PCU SPI flash PCI driver (DANGEROUS)"
+	depends on PCI
+	depends on X86 || COMPILE_TEST
+	depends on SPI_MEM
+	select SPI_INTEL
+	help
+	  This enables PCI support for the Intel PCH/PCU SPI controller in
+	  master mode. This controller is present in modern Intel hardware
+	  and is used to hold BIOS and other persistent settings. Using
+	  this driver it is possible to upgrade BIOS directly from Linux.
+
+	  Say N here unless you know what you are doing. Overwriting the
+	  SPI flash may render the system unbootable.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called spi-intel-pci.
+
+config SPI_INTEL_PLATFORM
+	tristate "Intel PCH/PCU SPI flash platform driver (DANGEROUS)"
+	depends on X86 || COMPILE_TEST
+	depends on SPI_MEM
+	select SPI_INTEL
+	help
+	  This enables platform support for the Intel PCH/PCU SPI
+	  controller in master mode. This controller is present in modern
+	  Intel hardware and is used to hold BIOS and other persistent
+	  settings. Using this driver it is possible to upgrade BIOS
+	  directly from Linux.
+
+	  Say N here unless you know what you are doing. Overwriting the
+	  SPI flash may render the system unbootable.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called spi-intel-platform.
+
 config SPI_JCORE
 	tristate "J-Core SPI Master"
 	depends on OF && (SUPERH || COMPILE_TEST)
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index dd7393a6046f..36b2045f08d2 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -61,6 +61,9 @@ obj-$(CONFIG_SPI_HISI_SFC_V3XX)		+= spi-hisi-sfc-v3xx.o
 obj-$(CONFIG_SPI_IMG_SPFI)		+= spi-img-spfi.o
 obj-$(CONFIG_SPI_IMX)			+= spi-imx.o
 obj-$(CONFIG_SPI_INGENIC)		+= spi-ingenic.o
+obj-$(CONFIG_SPI_INTEL)			+= spi-intel.o
+obj-$(CONFIG_SPI_INTEL_PCI)		+= spi-intel-pci.o
+obj-$(CONFIG_SPI_INTEL_PLATFORM)	+= spi-intel-platform.o
 obj-$(CONFIG_SPI_LANTIQ_SSC)		+= spi-lantiq-ssc.o
 obj-$(CONFIG_SPI_JCORE)			+= spi-jcore.o
 obj-$(CONFIG_SPI_LM70_LLP)		+= spi-lm70llp.o
diff --git a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c b/drivers/spi/spi-intel-pci.c
similarity index 86%
rename from drivers/mtd/spi-nor/controllers/intel-spi-pci.c
rename to drivers/spi/spi-intel-pci.c
index 508f7ca098ef..a177b10bc288 100644
--- a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
+++ b/drivers/spi/spi-intel-pci.c
@@ -2,16 +2,14 @@
 /*
  * Intel PCH/PCU SPI flash PCI driver.
  *
- * Copyright (C) 2016, Intel Corporation
+ * Copyright (C) 2016 - 2021 Intel Corporation
  * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
  */
 
-#include <linux/ioport.h>
-#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 
-#include "intel-spi.h"
+#include "spi-intel.h"
 
 #define BCR		0xdc
 #define BCR_WPD		BIT(0)
@@ -46,7 +44,6 @@ static int intel_spi_pci_probe(struct pci_dev *pdev,
 			       const struct pci_device_id *id)
 {
 	struct intel_spi_boardinfo *info;
-	struct intel_spi *ispi;
 	int ret;
 
 	ret = pcim_enable_device(pdev);
@@ -59,17 +56,7 @@ static int intel_spi_pci_probe(struct pci_dev *pdev,
 		return -ENOMEM;
 
 	info->data = pdev;
-	ispi = intel_spi_probe(&pdev->dev, &pdev->resource[0], info);
-	if (IS_ERR(ispi))
-		return PTR_ERR(ispi);
-
-	pci_set_drvdata(pdev, ispi);
-	return 0;
-}
-
-static void intel_spi_pci_remove(struct pci_dev *pdev)
-{
-	intel_spi_remove(pci_get_drvdata(pdev));
+	return intel_spi_probe(&pdev->dev, &pdev->resource[0], info);
 }
 
 static const struct pci_device_id intel_spi_pci_ids[] = {
@@ -98,7 +85,6 @@ static struct pci_driver intel_spi_pci_driver = {
 	.name = "intel-spi",
 	.id_table = intel_spi_pci_ids,
 	.probe = intel_spi_pci_probe,
-	.remove = intel_spi_pci_remove,
 };
 
 module_pci_driver(intel_spi_pci_driver);
diff --git a/drivers/mtd/spi-nor/controllers/intel-spi-platform.c b/drivers/spi/spi-intel-platform.c
similarity index 65%
rename from drivers/mtd/spi-nor/controllers/intel-spi-platform.c
rename to drivers/spi/spi-intel-platform.c
index f80f1086f928..293e03f239de 100644
--- a/drivers/mtd/spi-nor/controllers/intel-spi-platform.c
+++ b/drivers/spi/spi-intel-platform.c
@@ -2,20 +2,18 @@
 /*
  * Intel PCH/PCU SPI flash platform driver.
  *
- * Copyright (C) 2016, Intel Corporation
+ * Copyright (C) 2016 - 2021 Intel Corporation
  * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
  */
 
-#include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
-#include "intel-spi.h"
+#include "spi-intel.h"
 
 static int intel_spi_platform_probe(struct platform_device *pdev)
 {
 	struct intel_spi_boardinfo *info;
-	struct intel_spi *ispi;
 	struct resource *mem;
 
 	info = dev_get_platdata(&pdev->dev);
@@ -23,24 +21,11 @@ static int intel_spi_platform_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ispi = intel_spi_probe(&pdev->dev, mem, info);
-	if (IS_ERR(ispi))
-		return PTR_ERR(ispi);
-
-	platform_set_drvdata(pdev, ispi);
-	return 0;
-}
-
-static int intel_spi_platform_remove(struct platform_device *pdev)
-{
-	struct intel_spi *ispi = platform_get_drvdata(pdev);
-
-	return intel_spi_remove(ispi);
+	return intel_spi_probe(&pdev->dev, mem, info);
 }
 
 static struct platform_driver intel_spi_platform_driver = {
 	.probe = intel_spi_platform_probe,
-	.remove = intel_spi_platform_remove,
 	.driver = {
 		.name = "intel-spi",
 	},
diff --git a/drivers/mtd/spi-nor/controllers/intel-spi.c b/drivers/spi/spi-intel.c
similarity index 59%
rename from drivers/mtd/spi-nor/controllers/intel-spi.c
rename to drivers/spi/spi-intel.c
index f35597cbea0c..3b126927419c 100644
--- a/drivers/mtd/spi-nor/controllers/intel-spi.c
+++ b/drivers/spi/spi-intel.c
@@ -2,21 +2,21 @@
 /*
  * Intel PCH/PCU SPI flash driver.
  *
- * Copyright (C) 2016, Intel Corporation
+ * Copyright (C) 2016 - 2021 Intel Corporation
  * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
  */
 
-#include <linux/err.h>
-#include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
-#include <linux/sched.h>
-#include <linux/sizes.h>
-#include <linux/mtd/mtd.h>
+
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/spi-nor.h>
 
-#include "intel-spi.h"
+#include <linux/spi/flash.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
+
+#include "spi-intel.h"
 
 /* Offsets are from @ispi->base */
 #define BFPREG				0x00
@@ -92,8 +92,6 @@
 /* CPU specifics */
 #define BYT_PR				0x74
 #define BYT_SSFSTS_CTL			0x90
-#define BYT_BCR				0xfc
-#define BYT_BCR_WPD			BIT(0)
 #define BYT_FREG_NUM			5
 #define BYT_PR_NUM			5
 
@@ -125,35 +123,40 @@
  * struct intel_spi - Driver private data
  * @dev: Device pointer
  * @info: Pointer to board specific info
- * @nor: SPI NOR layer structure
  * @base: Beginning of MMIO space
  * @pregs: Start of protection registers
  * @sregs: Start of software sequencer registers
+ * @master: Pointer to the SPI controller structure
  * @nregions: Maximum number of regions
  * @pr_num: Maximum number of protected range registers
  * @locked: Is SPI setting locked
  * @swseq_reg: Use SW sequencer in register reads/writes
  * @swseq_erase: Use SW sequencer in erase operation
- * @erase_64k: 64k erase supported
  * @atomic_preopcode: Holds preopcode when atomic sequence is requested
  * @opcodes: Opcodes which are supported. This are programmed by BIOS
  *           before it locks down the controller.
+ * @mem_ops: Pointer to SPI MEM ops supported by the controller
  */
 struct intel_spi {
 	struct device *dev;
 	const struct intel_spi_boardinfo *info;
-	struct spi_nor nor;
 	void __iomem *base;
 	void __iomem *pregs;
 	void __iomem *sregs;
+	struct spi_controller *master;
 	size_t nregions;
 	size_t pr_num;
 	bool locked;
 	bool swseq_reg;
 	bool swseq_erase;
-	bool erase_64k;
 	u8 atomic_preopcode;
 	u8 opcodes[8];
+	const struct intel_spi_mem_op *mem_ops;
+};
+
+struct intel_spi_mem_op {
+	struct spi_mem_op mem_op;
+	int (*exec_op)(struct intel_spi *ispi, const struct spi_mem_op *op);
 };
 
 static bool writeable;
@@ -199,9 +202,6 @@ static void intel_spi_dump_regs(struct intel_spi *ispi)
 			readl(ispi->sregs + OPMENU1));
 	}
 
-	if (ispi->info->type == INTEL_SPI_BYT)
-		dev_dbg(ispi->dev, "BCR=0x%08x\n", readl(ispi->base + BYT_BCR));
-
 	dev_dbg(ispi->dev, "LVSCC=0x%08x\n", readl(ispi->base + LVSCC));
 	dev_dbg(ispi->dev, "UVSCC=0x%08x\n", readl(ispi->base + UVSCC));
 
@@ -217,9 +217,8 @@ static void intel_spi_dump_regs(struct intel_spi *ispi)
 		base = value & PR_BASE_MASK;
 
 		dev_dbg(ispi->dev, " %02d base: 0x%08x limit: 0x%08x [%c%c]\n",
-			 i, base << 12, (limit << 12) | 0xfff,
-			 value & PR_WPE ? 'W' : '.',
-			 value & PR_RPE ? 'R' : '.');
+			i, base << 12, (limit << 12) | 0xfff,
+			value & PR_WPE ? 'W' : '.', value & PR_RPE ? 'R' : '.');
 	}
 
 	dev_dbg(ispi->dev, "Flash regions:\n");
@@ -234,7 +233,7 @@ static void intel_spi_dump_regs(struct intel_spi *ispi)
 			dev_dbg(ispi->dev, " %02d disabled\n", i);
 		else
 			dev_dbg(ispi->dev, " %02d base: 0x%08x limit: 0x%08x\n",
-				 i, base << 12, (limit << 12) | 0xfff);
+				i, base << 12, (limit << 12) | 0xfff);
 	}
 
 	dev_dbg(ispi->dev, "Using %cW sequencer for register access\n",
@@ -310,119 +309,6 @@ static bool intel_spi_set_writeable(struct intel_spi *ispi)
 	return ispi->info->set_writeable(ispi->base, ispi->info->data);
 }
 
-static int intel_spi_init(struct intel_spi *ispi)
-{
-	u32 opmenu0, opmenu1, lvscc, uvscc, val;
-	int i;
-
-	switch (ispi->info->type) {
-	case INTEL_SPI_BYT:
-		ispi->sregs = ispi->base + BYT_SSFSTS_CTL;
-		ispi->pregs = ispi->base + BYT_PR;
-		ispi->nregions = BYT_FREG_NUM;
-		ispi->pr_num = BYT_PR_NUM;
-		ispi->swseq_reg = true;
-		break;
-
-	case INTEL_SPI_LPT:
-		ispi->sregs = ispi->base + LPT_SSFSTS_CTL;
-		ispi->pregs = ispi->base + LPT_PR;
-		ispi->nregions = LPT_FREG_NUM;
-		ispi->pr_num = LPT_PR_NUM;
-		ispi->swseq_reg = true;
-		break;
-
-	case INTEL_SPI_BXT:
-		ispi->sregs = ispi->base + BXT_SSFSTS_CTL;
-		ispi->pregs = ispi->base + BXT_PR;
-		ispi->nregions = BXT_FREG_NUM;
-		ispi->pr_num = BXT_PR_NUM;
-		ispi->erase_64k = true;
-		break;
-
-	case INTEL_SPI_CNL:
-		ispi->sregs = NULL;
-		ispi->pregs = ispi->base + CNL_PR;
-		ispi->nregions = CNL_FREG_NUM;
-		ispi->pr_num = CNL_PR_NUM;
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	/* Try to disable write protection if user asked to do so */
-	if (writeable && !intel_spi_set_writeable(ispi)) {
-		dev_warn(ispi->dev, "can't disable chip write protection\n");
-		writeable = false;
-	}
-
-	/* Disable #SMI generation from HW sequencer */
-	val = readl(ispi->base + HSFSTS_CTL);
-	val &= ~HSFSTS_CTL_FSMIE;
-	writel(val, ispi->base + HSFSTS_CTL);
-
-	/*
-	 * Determine whether erase operation should use HW or SW sequencer.
-	 *
-	 * The HW sequencer has a predefined list of opcodes, with only the
-	 * erase opcode being programmable in LVSCC and UVSCC registers.
-	 * If these registers don't contain a valid erase opcode, erase
-	 * cannot be done using HW sequencer.
-	 */
-	lvscc = readl(ispi->base + LVSCC);
-	uvscc = readl(ispi->base + UVSCC);
-	if (!(lvscc & ERASE_OPCODE_MASK) || !(uvscc & ERASE_OPCODE_MASK))
-		ispi->swseq_erase = true;
-	/* SPI controller on Intel BXT supports 64K erase opcode */
-	if (ispi->info->type == INTEL_SPI_BXT && !ispi->swseq_erase)
-		if (!(lvscc & ERASE_64K_OPCODE_MASK) ||
-		    !(uvscc & ERASE_64K_OPCODE_MASK))
-			ispi->erase_64k = false;
-
-	if (ispi->sregs == NULL && (ispi->swseq_reg || ispi->swseq_erase)) {
-		dev_err(ispi->dev, "software sequencer not supported, but required\n");
-		return -EINVAL;
-	}
-
-	/*
-	 * Some controllers can only do basic operations using hardware
-	 * sequencer. All other operations are supposed to be carried out
-	 * using software sequencer.
-	 */
-	if (ispi->swseq_reg) {
-		/* Disable #SMI generation from SW sequencer */
-		val = readl(ispi->sregs + SSFSTS_CTL);
-		val &= ~SSFSTS_CTL_FSMIE;
-		writel(val, ispi->sregs + SSFSTS_CTL);
-	}
-
-	/* Check controller's lock status */
-	val = readl(ispi->base + HSFSTS_CTL);
-	ispi->locked = !!(val & HSFSTS_CTL_FLOCKDN);
-
-	if (ispi->locked && ispi->sregs) {
-		/*
-		 * BIOS programs allowed opcodes and then locks down the
-		 * register. So read back what opcodes it decided to support.
-		 * That's the set we are going to support as well.
-		 */
-		opmenu0 = readl(ispi->sregs + OPMENU0);
-		opmenu1 = readl(ispi->sregs + OPMENU1);
-
-		if (opmenu0 && opmenu1) {
-			for (i = 0; i < ARRAY_SIZE(ispi->opcodes) / 2; i++) {
-				ispi->opcodes[i] = opmenu0 >> i * 8;
-				ispi->opcodes[i + 4] = opmenu1 >> i * 8;
-			}
-		}
-	}
-
-	intel_spi_dump_regs(ispi);
-
-	return 0;
-}
-
 static int intel_spi_opcode_index(struct intel_spi *ispi, u8 opcode, int optype)
 {
 	int i;
@@ -536,7 +422,6 @@ static int intel_spi_sw_cycle(struct intel_spi *ispi, u8 opcode, size_t len,
 		default:
 			return -EINVAL;
 		}
-
 	}
 	writel(val, ispi->sregs + SSFSTS_CTL);
 
@@ -553,31 +438,31 @@ static int intel_spi_sw_cycle(struct intel_spi *ispi, u8 opcode, size_t len,
 	return 0;
 }
 
-static int intel_spi_read_reg(struct spi_nor *nor, u8 opcode, u8 *buf,
-			      size_t len)
+static int intel_spi_read_reg(struct intel_spi *ispi, const struct spi_mem_op *op)
 {
-	struct intel_spi *ispi = nor->priv;
+	size_t nbytes = op->data.nbytes;
+	u8 opcode = op->cmd.opcode;
 	int ret;
 
 	/* Address of the first chip */
 	writel(0, ispi->base + FADDR);
 
 	if (ispi->swseq_reg)
-		ret = intel_spi_sw_cycle(ispi, opcode, len,
+		ret = intel_spi_sw_cycle(ispi, opcode, nbytes,
 					 OPTYPE_READ_NO_ADDR);
 	else
-		ret = intel_spi_hw_cycle(ispi, opcode, len);
+		ret = intel_spi_hw_cycle(ispi, opcode, nbytes);
 
 	if (ret)
 		return ret;
 
-	return intel_spi_read_block(ispi, buf, len);
+	return intel_spi_read_block(ispi, op->data.buf.in, nbytes);
 }
 
-static int intel_spi_write_reg(struct spi_nor *nor, u8 opcode, const u8 *buf,
-			       size_t len)
+static int intel_spi_write_reg(struct intel_spi *ispi, const struct spi_mem_op *op)
 {
-	struct intel_spi *ispi = nor->priv;
+	size_t nbytes = op->data.nbytes;
+	u8 opcode = op->cmd.opcode;
 	int ret;
 
 	/*
@@ -622,23 +507,23 @@ static int intel_spi_write_reg(struct spi_nor *nor, u8 opcode, const u8 *buf,
 	writel(0, ispi->base + FADDR);
 
 	/* Write the value beforehand */
-	ret = intel_spi_write_block(ispi, buf, len);
+	ret = intel_spi_write_block(ispi, op->data.buf.out, nbytes);
 	if (ret)
 		return ret;
 
 	if (ispi->swseq_reg)
-		return intel_spi_sw_cycle(ispi, opcode, len,
+		return intel_spi_sw_cycle(ispi, opcode, nbytes,
 					  OPTYPE_WRITE_NO_ADDR);
-	return intel_spi_hw_cycle(ispi, opcode, len);
+	return intel_spi_hw_cycle(ispi, opcode, nbytes);
 }
 
-static ssize_t intel_spi_read(struct spi_nor *nor, loff_t from, size_t len,
-			      u_char *read_buf)
+static int intel_spi_read(struct intel_spi *ispi, const struct spi_mem_op *op)
 {
-	struct intel_spi *ispi = nor->priv;
-	size_t block_size, retlen = 0;
+	void *read_buf = op->data.buf.in;
+	size_t block_size, nbytes = op->data.nbytes;
+	u32 addr = op->addr.val;
 	u32 val, status;
-	ssize_t ret;
+	int ret;
 
 	/*
 	 * Atomic sequence is not expected with HW sequencer reads. Make
@@ -647,24 +532,14 @@ static ssize_t intel_spi_read(struct spi_nor *nor, loff_t from, size_t len,
 	if (WARN_ON_ONCE(ispi->atomic_preopcode))
 		ispi->atomic_preopcode = 0;
 
-	switch (nor->read_opcode) {
-	case SPINOR_OP_READ:
-	case SPINOR_OP_READ_FAST:
-	case SPINOR_OP_READ_4B:
-	case SPINOR_OP_READ_FAST_4B:
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	while (len > 0) {
-		block_size = min_t(size_t, len, INTEL_SPI_FIFO_SZ);
+	while (nbytes > 0) {
+		block_size = min_t(size_t, nbytes, INTEL_SPI_FIFO_SZ);
 
 		/* Read cannot cross 4K boundary */
-		block_size = min_t(loff_t, from + block_size,
-				   round_up(from + 1, SZ_4K)) - from;
+		block_size = min_t(loff_t, addr + block_size,
+				   round_up(addr + 1, SZ_4K)) - addr;
 
-		writel(from, ispi->base + FADDR);
+		writel(addr, ispi->base + FADDR);
 
 		val = readl(ispi->base + HSFSTS_CTL);
 		val &= ~(HSFSTS_CTL_FDBC_MASK | HSFSTS_CTL_FCYCLE_MASK);
@@ -685,8 +560,7 @@ static ssize_t intel_spi_read(struct spi_nor *nor, loff_t from, size_t len,
 			ret = -EACCES;
 
 		if (ret < 0) {
-			dev_err(ispi->dev, "read error: %llx: %#x\n", from,
-				status);
+			dev_err(ispi->dev, "read error: %x: %#x\n", addr, status);
 			return ret;
 		}
 
@@ -694,34 +568,33 @@ static ssize_t intel_spi_read(struct spi_nor *nor, loff_t from, size_t len,
 		if (ret)
 			return ret;
 
-		len -= block_size;
-		from += block_size;
-		retlen += block_size;
+		nbytes -= block_size;
+		addr += block_size;
 		read_buf += block_size;
 	}
 
-	return retlen;
+	return 0;
 }
 
-static ssize_t intel_spi_write(struct spi_nor *nor, loff_t to, size_t len,
-			       const u_char *write_buf)
+static int intel_spi_write(struct intel_spi *ispi, const struct spi_mem_op *op)
 {
-	struct intel_spi *ispi = nor->priv;
-	size_t block_size, retlen = 0;
+	size_t block_size, nbytes = op->data.nbytes;
+	const void *write_buf = op->data.buf.out;
+	u32 addr = op->addr.val;
 	u32 val, status;
-	ssize_t ret;
+	int ret;
 
 	/* Not needed with HW sequencer write, make sure it is cleared */
 	ispi->atomic_preopcode = 0;
 
-	while (len > 0) {
-		block_size = min_t(size_t, len, INTEL_SPI_FIFO_SZ);
+	while (nbytes > 0) {
+		block_size = min_t(size_t, nbytes, INTEL_SPI_FIFO_SZ);
 
 		/* Write cannot cross 4K boundary */
-		block_size = min_t(loff_t, to + block_size,
-				   round_up(to + 1, SZ_4K)) - to;
+		block_size = min_t(loff_t, addr + block_size,
+				   round_up(addr + 1, SZ_4K)) - addr;
 
-		writel(to, ispi->base + FADDR);
+		writel(addr, ispi->base + FADDR);
 
 		val = readl(ispi->base + HSFSTS_CTL);
 		val &= ~(HSFSTS_CTL_FDBC_MASK | HSFSTS_CTL_FCYCLE_MASK);
@@ -752,79 +625,470 @@ static ssize_t intel_spi_write(struct spi_nor *nor, loff_t to, size_t len,
 			ret = -EACCES;
 
 		if (ret < 0) {
-			dev_err(ispi->dev, "write error: %llx: %#x\n", to,
-				status);
+			dev_err(ispi->dev, "write error: %x: %#x\n", addr, status);
 			return ret;
 		}
 
-		len -= block_size;
-		to += block_size;
-		retlen += block_size;
+		nbytes -= block_size;
+		addr += block_size;
 		write_buf += block_size;
 	}
 
-	return retlen;
+	return 0;
 }
 
-static int intel_spi_erase(struct spi_nor *nor, loff_t offs)
+static int intel_spi_erase(struct intel_spi *ispi, const struct spi_mem_op *op)
 {
-	size_t erase_size, len = nor->mtd.erasesize;
-	struct intel_spi *ispi = nor->priv;
+	u8 opcode = op->cmd.opcode;
+	u32 addr = op->addr.val;
 	u32 val, status, cmd;
 	int ret;
 
-	/* If the hardware can do 64k erase use that when possible */
-	if (len >= SZ_64K && ispi->erase_64k) {
+	switch (opcode) {
+	case SPINOR_OP_SE:
 		cmd = HSFSTS_CTL_FCYCLE_ERASE_64K;
-		erase_size = SZ_64K;
-	} else {
+		break;
+
+	case SPINOR_OP_BE_4K:
 		cmd = HSFSTS_CTL_FCYCLE_ERASE;
-		erase_size = SZ_4K;
+		break;
+
+	default:
+		return -EINVAL;
 	}
 
-	if (ispi->swseq_erase) {
-		while (len > 0) {
-			writel(offs, ispi->base + FADDR);
+	writel(addr, ispi->base + FADDR);
+
+	if (ispi->swseq_erase)
+		return intel_spi_sw_cycle(ispi, opcode, 0,
+					  OPTYPE_WRITE_WITH_ADDR);
+
+	/* Not needed with HW sequencer erase, make sure it is cleared */
+	ispi->atomic_preopcode = 0;
+
+	val = readl(ispi->base + HSFSTS_CTL);
+	val &= ~(HSFSTS_CTL_FDBC_MASK | HSFSTS_CTL_FCYCLE_MASK);
+	val |= HSFSTS_CTL_AEL | HSFSTS_CTL_FCERR | HSFSTS_CTL_FDONE;
+	val |= HSFSTS_CTL_FGO;
+	val |= cmd;
+	writel(val, ispi->base + HSFSTS_CTL);
+
+	ret = intel_spi_wait_hw_busy(ispi);
+	if (ret)
+		return ret;
+
+	status = readl(ispi->base + HSFSTS_CTL);
+	if (status & HSFSTS_CTL_FCERR)
+		return -EIO;
+	if (status & HSFSTS_CTL_AEL)
+		return -EACCES;
+
+	return 0;
+}
+
+static bool intel_spi_cmp_mem_op(const struct intel_spi_mem_op *iop,
+				 const struct spi_mem_op *op)
+{
+	if (iop->mem_op.cmd.nbytes != op->cmd.nbytes ||
+	    iop->mem_op.cmd.buswidth != op->cmd.buswidth ||
+	    iop->mem_op.cmd.dtr != op->cmd.dtr ||
+	    iop->mem_op.cmd.opcode != op->cmd.opcode)
+		return false;
+
+	if (iop->mem_op.addr.nbytes != op->addr.nbytes ||
+	    iop->mem_op.addr.dtr != op->addr.dtr)
+		return false;
+
+	if (iop->mem_op.data.dir != op->data.dir ||
+	    iop->mem_op.data.dtr != op->data.dtr)
+		return false;
+
+	if (iop->mem_op.data.dir != SPI_MEM_NO_DATA) {
+		if (iop->mem_op.data.buswidth != op->data.buswidth)
+			return false;
+	}
+
+	return true;
+}
+
+static const struct intel_spi_mem_op *
+intel_spi_match_mem_op(struct intel_spi *ispi, const struct spi_mem_op *op)
+{
+	const struct intel_spi_mem_op *iop;
+
+	for (iop = ispi->mem_ops; iop->mem_op.cmd.opcode; iop++) {
+		if (intel_spi_cmp_mem_op(iop, op))
+			break;
+	}
+
+	return iop->mem_op.cmd.opcode ? iop : NULL;
+}
+
+static bool intel_spi_supports_mem_op(struct spi_mem *mem,
+				      const struct spi_mem_op *op)
+{
+	struct intel_spi *ispi = spi_master_get_devdata(mem->spi->master);
+	const struct intel_spi_mem_op *iop;
+
+	iop = intel_spi_match_mem_op(ispi, op);
+	if (!iop) {
+		dev_dbg(ispi->dev, "%#x not supported\n", op->cmd.opcode);
+		return false;
+	}
 
-			ret = intel_spi_sw_cycle(ispi, nor->erase_opcode,
-						 0, OPTYPE_WRITE_WITH_ADDR);
-			if (ret)
-				return ret;
+	/*
+	 * For software sequencer check that the opcode is actually
+	 * present in the opmenu if it is locked.
+	 */
+	if (ispi->swseq_reg && ispi->locked) {
+		int i;
 
-			offs += erase_size;
-			len -= erase_size;
+		/* Check if it is in the locked opcodes list */
+		for (i = 0; i < ARRAY_SIZE(ispi->opcodes); i++) {
+			if (ispi->opcodes[i] == op->cmd.opcode)
+				return true;
 		}
 
-		return 0;
+		dev_dbg(ispi->dev, "%#x not supported\n", op->cmd.opcode);
+		return false;
 	}
 
-	/* Not needed with HW sequencer erase, make sure it is cleared */
-	ispi->atomic_preopcode = 0;
+	return true;
+}
 
-	while (len > 0) {
-		writel(offs, ispi->base + FADDR);
+static int intel_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	struct intel_spi *ispi = spi_master_get_devdata(mem->spi->master);
+	const struct intel_spi_mem_op *iop;
 
-		val = readl(ispi->base + HSFSTS_CTL);
-		val &= ~(HSFSTS_CTL_FDBC_MASK | HSFSTS_CTL_FCYCLE_MASK);
-		val |= HSFSTS_CTL_AEL | HSFSTS_CTL_FCERR | HSFSTS_CTL_FDONE;
-		val |= cmd;
-		val |= HSFSTS_CTL_FGO;
-		writel(val, ispi->base + HSFSTS_CTL);
+	iop = intel_spi_match_mem_op(ispi, op);
+	if (!iop)
+		return -EINVAL;
 
-		ret = intel_spi_wait_hw_busy(ispi);
-		if (ret)
-			return ret;
+	return iop->exec_op(ispi, op);
+}
 
-		status = readl(ispi->base + HSFSTS_CTL);
-		if (status & HSFSTS_CTL_FCERR)
-			return -EIO;
-		else if (status & HSFSTS_CTL_AEL)
-			return -EACCES;
+static const char *intel_spi_get_name(struct spi_mem *mem)
+{
+	const struct intel_spi *ispi = spi_master_get_devdata(mem->spi->master);
+
+	/*
+	 * Return name of the flash controller device to be compatible
+	 * with the MTD version.
+	 */
+	return dev_name(ispi->dev);
+}
+
+static const struct spi_controller_mem_ops intel_spi_mem_ops = {
+	.supports_op = intel_spi_supports_mem_op,
+	.exec_op = intel_spi_exec_mem_op,
+	.get_name = intel_spi_get_name,
+};
+
+#define INTEL_SPI_OP_ADDR(__nbytes)					\
+	{								\
+		.nbytes = __nbytes,					\
+	}
+
+#define INTEL_SPI_OP_NO_DATA						\
+	{								\
+		.dir = SPI_MEM_NO_DATA,					\
+	}
+
+#define INTEL_SPI_OP_DATA_IN(__buswidth)				\
+	{								\
+		.dir = SPI_MEM_DATA_IN,					\
+		.buswidth = __buswidth,					\
+	}
+
+#define INTEL_SPI_OP_DATA_OUT(__buswidth)				\
+	{								\
+		.dir = SPI_MEM_DATA_OUT,				\
+		.buswidth = __buswidth,					\
+	}
+
+#define INTEL_SPI_MEM_OP(__cmd, __addr, __data, __exec_op)		\
+	{								\
+		.mem_op = {						\
+			.cmd = __cmd,					\
+			.addr = __addr,					\
+			.data = __data,					\
+		},							\
+		.exec_op = __exec_op,					\
+	}
+
+/*
+ * The controller handles pretty much everything internally based on the
+ * SFDP data but we want to make sure we only support the operations
+ * actually possible. Only check buswidth and transfer direction, the
+ * core validates data.
+ */
+#define INTEL_SPI_GENERIC_OPS						\
+	/* Status register operations */				\
+	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDID, 1),		\
+			 SPI_MEM_OP_NO_ADDR,				\
+			 INTEL_SPI_OP_DATA_IN(1),			\
+			 intel_spi_read_reg),				\
+	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDSR, 1),		\
+			 SPI_MEM_OP_NO_ADDR,				\
+			 INTEL_SPI_OP_DATA_IN(1),			\
+			 intel_spi_read_reg),				\
+	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 1),		\
+			 SPI_MEM_OP_NO_ADDR,				\
+			 INTEL_SPI_OP_DATA_OUT(1),			\
+			 intel_spi_write_reg),				\
+	/* Normal read */						\
+	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_READ, 1),		\
+			 INTEL_SPI_OP_ADDR(3),				\
+			 INTEL_SPI_OP_DATA_IN(1),			\
+			 intel_spi_read),				\
+	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_READ, 1),		\
+			 INTEL_SPI_OP_ADDR(3),				\
+			 INTEL_SPI_OP_DATA_IN(2),			\
+			 intel_spi_read),				\
+	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_READ, 1),		\
+			 INTEL_SPI_OP_ADDR(3),				\
+			 INTEL_SPI_OP_DATA_IN(4),			\
+			 intel_spi_read),				\
+	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_READ, 1),		\
+			 INTEL_SPI_OP_ADDR(4),				\
+			 INTEL_SPI_OP_DATA_IN(1),			\
+			 intel_spi_read),				\
+	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_READ, 1),		\
+			 INTEL_SPI_OP_ADDR(4),				\
+			 INTEL_SPI_OP_DATA_IN(2),			\
+			 intel_spi_read),				\
+	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_READ, 1),		\
+			 INTEL_SPI_OP_ADDR(4),				\
+			 INTEL_SPI_OP_DATA_IN(4),			\
+			 intel_spi_read),				\
+	/* Fast read */							\
+	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_READ_FAST, 1),	\
+			 INTEL_SPI_OP_ADDR(3),				\
+			 INTEL_SPI_OP_DATA_IN(1),			\
+			 intel_spi_read),				\
+	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_READ_FAST, 1),	\
+			 INTEL_SPI_OP_ADDR(3),				\
+			 INTEL_SPI_OP_DATA_IN(2),			\
+			 intel_spi_read),				\
+	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_READ_FAST, 1),	\
+			 INTEL_SPI_OP_ADDR(3),				\
+			 INTEL_SPI_OP_DATA_IN(4),			\
+			 intel_spi_read),				\
+	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_READ_FAST, 1),	\
+			 INTEL_SPI_OP_ADDR(4),				\
+			 INTEL_SPI_OP_DATA_IN(1),			\
+			 intel_spi_read),				\
+	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_READ_FAST, 1),	\
+			 INTEL_SPI_OP_ADDR(4),				\
+			 INTEL_SPI_OP_DATA_IN(2),			\
+			 intel_spi_read),				\
+	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_READ_FAST, 1),	\
+			 INTEL_SPI_OP_ADDR(4),				\
+			 INTEL_SPI_OP_DATA_IN(4),			\
+			 intel_spi_read),				\
+	/* Read with 4-byte address opcode */				\
+	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_READ_4B, 1),		\
+			 INTEL_SPI_OP_ADDR(4),				\
+			 INTEL_SPI_OP_DATA_IN(1),			\
+			 intel_spi_read),				\
+	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_READ_4B, 1),		\
+			 INTEL_SPI_OP_ADDR(4),				\
+			 INTEL_SPI_OP_DATA_IN(2),			\
+			 intel_spi_read),				\
+	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_READ_4B, 1),		\
+			 INTEL_SPI_OP_ADDR(4),				\
+			 INTEL_SPI_OP_DATA_IN(4),			\
+			 intel_spi_read),				\
+	/* Fast read with 4-byte address opcode */			\
+	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_READ_FAST_4B, 1),	\
+			 INTEL_SPI_OP_ADDR(4),				\
+			 INTEL_SPI_OP_DATA_IN(1),			\
+			 intel_spi_read),				\
+	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_READ_FAST_4B, 1),	\
+			 INTEL_SPI_OP_ADDR(4),				\
+			 INTEL_SPI_OP_DATA_IN(2),			\
+			 intel_spi_read),				\
+	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_READ_FAST_4B, 1),	\
+			 INTEL_SPI_OP_ADDR(4),				\
+			 INTEL_SPI_OP_DATA_IN(4),			\
+			 intel_spi_read),				\
+	/* Write operations */						\
+	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_PP, 1),		\
+			 INTEL_SPI_OP_ADDR(3),				\
+			 INTEL_SPI_OP_DATA_OUT(1),			\
+			 intel_spi_write),				\
+	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_PP, 1),		\
+			 INTEL_SPI_OP_ADDR(4),				\
+			 INTEL_SPI_OP_DATA_OUT(1),			\
+			 intel_spi_write),				\
+	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_PP_4B, 1),		\
+			 INTEL_SPI_OP_ADDR(4),				\
+			 INTEL_SPI_OP_DATA_OUT(1),			\
+			 intel_spi_write),				\
+	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WREN, 1),		\
+			 SPI_MEM_OP_NO_ADDR,				\
+			 SPI_MEM_OP_NO_DATA,				\
+			 intel_spi_write_reg),				\
+	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRDI, 1),		\
+			 SPI_MEM_OP_NO_ADDR,				\
+			 SPI_MEM_OP_NO_DATA,				\
+			 intel_spi_write_reg),				\
+	/* Erase operations */						\
+	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_BE_4K, 1),		\
+			 INTEL_SPI_OP_ADDR(3),				\
+			 SPI_MEM_OP_NO_DATA,				\
+			 intel_spi_erase),				\
+	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_BE_4K, 1),		\
+			 INTEL_SPI_OP_ADDR(4),				\
+			 SPI_MEM_OP_NO_DATA,				\
+			 intel_spi_erase),				\
+	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_BE_4K_4B, 1),		\
+			 INTEL_SPI_OP_ADDR(4),				\
+			 SPI_MEM_OP_NO_DATA,				\
+			 intel_spi_erase)
+
+static const struct intel_spi_mem_op generic_mem_ops[] = {
+	INTEL_SPI_GENERIC_OPS,
+	{ },
+};
+
+static const struct intel_spi_mem_op erase_64k_mem_ops[] = {
+	INTEL_SPI_GENERIC_OPS,
+	/* 64k sector erase operations */
+	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_SE, 1),
+			 INTEL_SPI_OP_ADDR(3),
+			 SPI_MEM_OP_NO_DATA,
+			 intel_spi_erase),
+	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_SE, 1),
+			 INTEL_SPI_OP_ADDR(4),
+			 SPI_MEM_OP_NO_DATA,
+			 intel_spi_erase),
+	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_SE_4B, 1),
+			 INTEL_SPI_OP_ADDR(4),
+			 SPI_MEM_OP_NO_DATA,
+			 intel_spi_erase),
+	{ },
+};
+
+static int intel_spi_init(struct intel_spi *ispi)
+{
+	u32 opmenu0, opmenu1, lvscc, uvscc, val;
+	bool erase_64k = false;
+	int i;
+
+	switch (ispi->info->type) {
+	case INTEL_SPI_BYT:
+		ispi->sregs = ispi->base + BYT_SSFSTS_CTL;
+		ispi->pregs = ispi->base + BYT_PR;
+		ispi->nregions = BYT_FREG_NUM;
+		ispi->pr_num = BYT_PR_NUM;
+		ispi->swseq_reg = true;
+		break;
+
+	case INTEL_SPI_LPT:
+		ispi->sregs = ispi->base + LPT_SSFSTS_CTL;
+		ispi->pregs = ispi->base + LPT_PR;
+		ispi->nregions = LPT_FREG_NUM;
+		ispi->pr_num = LPT_PR_NUM;
+		ispi->swseq_reg = true;
+		break;
+
+	case INTEL_SPI_BXT:
+		ispi->sregs = ispi->base + BXT_SSFSTS_CTL;
+		ispi->pregs = ispi->base + BXT_PR;
+		ispi->nregions = BXT_FREG_NUM;
+		ispi->pr_num = BXT_PR_NUM;
+		erase_64k = true;
+		break;
+
+	case INTEL_SPI_CNL:
+		ispi->sregs = NULL;
+		ispi->pregs = ispi->base + CNL_PR;
+		ispi->nregions = CNL_FREG_NUM;
+		ispi->pr_num = CNL_PR_NUM;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	/* Try to disable write protection if user asked to do so */
+	if (writeable && !intel_spi_set_writeable(ispi)) {
+		dev_warn(ispi->dev, "can't disable chip write protection\n");
+		writeable = false;
+	}
+
+	/* Disable #SMI generation from HW sequencer */
+	val = readl(ispi->base + HSFSTS_CTL);
+	val &= ~HSFSTS_CTL_FSMIE;
+	writel(val, ispi->base + HSFSTS_CTL);
+
+	/*
+	 * Determine whether erase operation should use HW or SW sequencer.
+	 *
+	 * The HW sequencer has a predefined list of opcodes, with only the
+	 * erase opcode being programmable in LVSCC and UVSCC registers.
+	 * If these registers don't contain a valid erase opcode, erase
+	 * cannot be done using HW sequencer.
+	 */
+	lvscc = readl(ispi->base + LVSCC);
+	uvscc = readl(ispi->base + UVSCC);
+	if (!(lvscc & ERASE_OPCODE_MASK) || !(uvscc & ERASE_OPCODE_MASK))
+		ispi->swseq_erase = true;
+	/* SPI controller on Intel BXT supports 64K erase opcode */
+	if (ispi->info->type == INTEL_SPI_BXT && !ispi->swseq_erase)
+		if (!(lvscc & ERASE_64K_OPCODE_MASK) ||
+		    !(uvscc & ERASE_64K_OPCODE_MASK))
+			erase_64k = false;
 
-		offs += erase_size;
-		len -= erase_size;
+	if (!ispi->sregs && (ispi->swseq_reg || ispi->swseq_erase)) {
+		dev_err(ispi->dev, "software sequencer not supported, but required\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Some controllers can only do basic operations using hardware
+	 * sequencer. All other operations are supposed to be carried out
+	 * using software sequencer.
+	 */
+	if (ispi->swseq_reg) {
+		/* Disable #SMI generation from SW sequencer */
+		val = readl(ispi->sregs + SSFSTS_CTL);
+		val &= ~SSFSTS_CTL_FSMIE;
+		writel(val, ispi->sregs + SSFSTS_CTL);
 	}
 
+	/* Check controller's lock status */
+	val = readl(ispi->base + HSFSTS_CTL);
+	ispi->locked = !!(val & HSFSTS_CTL_FLOCKDN);
+
+	if (ispi->locked && ispi->sregs) {
+		/*
+		 * BIOS programs allowed opcodes and then locks down the
+		 * register. So read back what opcodes it decided to support.
+		 * That's the set we are going to support as well.
+		 */
+		opmenu0 = readl(ispi->sregs + OPMENU0);
+		opmenu1 = readl(ispi->sregs + OPMENU1);
+
+		if (opmenu0 && opmenu1) {
+			for (i = 0; i < ARRAY_SIZE(ispi->opcodes) / 2; i++) {
+				ispi->opcodes[i] = opmenu0 >> i * 8;
+				ispi->opcodes[i + 4] = opmenu1 >> i * 8;
+			}
+		}
+	}
+
+	if (erase_64k) {
+		dev_dbg(ispi->dev, "Using erase_64k memory operations");
+		ispi->mem_ops = erase_64k_mem_ops;
+	} else {
+		dev_dbg(ispi->dev, "Using generic memory operations");
+		ispi->mem_ops = generic_mem_ops;
+	}
+
+	intel_spi_dump_regs(ispi);
 	return 0;
 }
 
@@ -896,70 +1160,74 @@ static void intel_spi_fill_partition(struct intel_spi *ispi,
 	}
 }
 
-static const struct spi_nor_controller_ops intel_spi_controller_ops = {
-	.read_reg = intel_spi_read_reg,
-	.write_reg = intel_spi_write_reg,
-	.read = intel_spi_read,
-	.write = intel_spi_write,
-	.erase = intel_spi_erase,
-};
+static int intel_spi_populate_chip(struct intel_spi *ispi)
+{
+	struct flash_platform_data *pdata;
+	struct spi_board_info chip;
+
+	pdata = devm_kzalloc(ispi->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	pdata->nr_parts = 1;
+	pdata->parts = devm_kcalloc(ispi->dev, sizeof(*pdata->parts),
+				    pdata->nr_parts, GFP_KERNEL);
+	if (!pdata->parts)
+		return -ENOMEM;
+
+	intel_spi_fill_partition(ispi, pdata->parts);
+
+	memset(&chip, 0, sizeof(chip));
+	snprintf(chip.modalias, 8, "spi-nor");
+	chip.platform_data = pdata;
 
-struct intel_spi *intel_spi_probe(struct device *dev,
-	struct resource *mem, const struct intel_spi_boardinfo *info)
+	return spi_new_device(ispi->master, &chip) ? 0 : -ENODEV;
+}
+
+/**
+ * intel_spi_probe() - Probe the Intel SPI flash controller
+ * @dev: Pointer to the parent device
+ * @mem: MMIO resource
+ * @info: Platform spefific information
+ *
+ * Probes Intel SPI flash controller and creates the flash chip device.
+ * Returns %0 on success and negative errno in case of failure.
+ */
+int intel_spi_probe(struct device *dev, struct resource *mem,
+		    const struct intel_spi_boardinfo *info)
 {
-	const struct spi_nor_hwcaps hwcaps = {
-		.mask = SNOR_HWCAPS_READ |
-			SNOR_HWCAPS_READ_FAST |
-			SNOR_HWCAPS_PP,
-	};
-	struct mtd_partition part;
+	struct spi_controller *master;
 	struct intel_spi *ispi;
 	int ret;
 
-	if (!info || !mem)
-		return ERR_PTR(-EINVAL);
+	master = devm_spi_alloc_master(dev, sizeof(*ispi));
+	if (!master)
+		return -ENOMEM;
 
-	ispi = devm_kzalloc(dev, sizeof(*ispi), GFP_KERNEL);
-	if (!ispi)
-		return ERR_PTR(-ENOMEM);
+	master->mem_ops = &intel_spi_mem_ops;
+
+	ispi = spi_master_get_devdata(master);
 
 	ispi->base = devm_ioremap_resource(dev, mem);
 	if (IS_ERR(ispi->base))
-		return ERR_CAST(ispi->base);
+		return PTR_ERR(ispi->base);
 
 	ispi->dev = dev;
+	ispi->master = master;
 	ispi->info = info;
 
 	ret = intel_spi_init(ispi);
 	if (ret)
-		return ERR_PTR(ret);
-
-	ispi->nor.dev = ispi->dev;
-	ispi->nor.priv = ispi;
-	ispi->nor.controller_ops = &intel_spi_controller_ops;
-
-	ret = spi_nor_scan(&ispi->nor, NULL, &hwcaps);
-	if (ret) {
-		dev_info(dev, "failed to locate the chip\n");
-		return ERR_PTR(ret);
-	}
-
-	intel_spi_fill_partition(ispi, &part);
+		return ret;
 
-	ret = mtd_device_register(&ispi->nor.mtd, &part, 1);
+	ret = devm_spi_register_master(dev, master);
 	if (ret)
-		return ERR_PTR(ret);
+		return ret;
 
-	return ispi;
+	return intel_spi_populate_chip(ispi);
 }
 EXPORT_SYMBOL_GPL(intel_spi_probe);
 
-int intel_spi_remove(struct intel_spi *ispi)
-{
-	return mtd_device_unregister(&ispi->nor.mtd);
-}
-EXPORT_SYMBOL_GPL(intel_spi_remove);
-
 MODULE_DESCRIPTION("Intel PCH/PCU SPI flash core driver");
 MODULE_AUTHOR("Mika Westerberg <mika.westerberg@linux.intel.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/spi/spi-intel.h b/drivers/spi/spi-intel.h
new file mode 100644
index 000000000000..40f947f6941a
--- /dev/null
+++ b/drivers/spi/spi-intel.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Intel PCH/PCU SPI flash driver.
+ *
+ * Copyright (C) 2016 - 2021, Intel Corporation
+ * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
+ */
+
+#ifndef SPI_INTEL_H
+#define SPI_INTEL_H
+
+#include <linux/platform_data/x86/spi-intel.h>
+
+struct resource;
+
+int intel_spi_probe(struct device *dev, struct resource *mem,
+		    const struct intel_spi_boardinfo *info);
+
+#endif /* SPI_INTEL_H */
diff --git a/include/linux/mfd/lpc_ich.h b/include/linux/mfd/lpc_ich.h
index 39967a5eca6d..ea4a4b1b246a 100644
--- a/include/linux/mfd/lpc_ich.h
+++ b/include/linux/mfd/lpc_ich.h
@@ -8,7 +8,7 @@
 #ifndef LPC_ICH_H
 #define LPC_ICH_H
 
-#include <linux/platform_data/x86/intel-spi.h>
+#include <linux/platform_data/x86/spi-intel.h>
 
 /* GPIO resources */
 #define ICH_RES_GPIO	0
diff --git a/include/linux/platform_data/x86/intel-spi.h b/include/linux/platform_data/x86/spi-intel.h
similarity index 89%
rename from include/linux/platform_data/x86/intel-spi.h
rename to include/linux/platform_data/x86/spi-intel.h
index 7dda3f690465..a512ec37abbb 100644
--- a/include/linux/platform_data/x86/intel-spi.h
+++ b/include/linux/platform_data/x86/spi-intel.h
@@ -6,8 +6,8 @@
  * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
  */
 
-#ifndef INTEL_SPI_PDATA_H
-#define INTEL_SPI_PDATA_H
+#ifndef SPI_INTEL_PDATA_H
+#define SPI_INTEL_PDATA_H
 
 enum intel_spi_type {
 	INTEL_SPI_BYT = 1,
@@ -28,4 +28,4 @@ struct intel_spi_boardinfo {
 	void *data;
 };
 
-#endif /* INTEL_SPI_PDATA_H */
+#endif /* SPI_INTEL_PDATA_H */
-- 
2.34.1

