Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4732A41D737
	for <lists+linux-spi@lfdr.de>; Thu, 30 Sep 2021 12:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349744AbhI3KJO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Sep 2021 06:09:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:26572 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349724AbhI3KJL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 30 Sep 2021 06:09:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="205303540"
X-IronPort-AV: E=Sophos;i="5.85,335,1624345200"; 
   d="scan'208";a="205303540"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 03:07:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,335,1624345200"; 
   d="scan'208";a="476947000"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 30 Sep 2021 03:07:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id C86901AD; Thu, 30 Sep 2021 13:07:19 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Subject: [PATCH 2/3] mtd: spi-nor: intel-spi: Convert to SPI MEM
Date:   Thu, 30 Sep 2021 13:07:18 +0300
Message-Id: <20210930100719.2176-3-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210930100719.2176-1-mika.westerberg@linux.intel.com>
References: <20210930100719.2176-1-mika.westerberg@linux.intel.com>
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
---
 drivers/mtd/spi-nor/controllers/Kconfig       |  36 ---
 drivers/mtd/spi-nor/controllers/Makefile      |   3 -
 drivers/mtd/spi-nor/controllers/intel-spi.h   |  21 --
 drivers/spi/Kconfig                           |  38 +++
 drivers/spi/Makefile                          |   3 +
 .../intel-spi-pci.c => spi/spi-intel-pci.c}   |  20 +-
 .../spi-intel-platform.c}                     |  21 +-
 .../intel-spi.c => spi/spi-intel.c}           | 300 +++++++++++-------
 drivers/spi/spi-intel.h                       |  19 ++
 include/linux/mfd/lpc_ich.h                   |   2 +-
 .../x86/{intel-spi.h => spi-intel.h}          |   6 +-
 11 files changed, 252 insertions(+), 217 deletions(-)
 delete mode 100644 drivers/mtd/spi-nor/controllers/intel-spi.h
 rename drivers/{mtd/spi-nor/controllers/intel-spi-pci.c => spi/spi-intel-pci.c} (86%)
 rename drivers/{mtd/spi-nor/controllers/intel-spi-platform.c => spi/spi-intel-platform.c} (65%)
 rename drivers/{mtd/spi-nor/controllers/intel-spi.c => spi/spi-intel.c} (80%)
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
index 83e352b0c8f9..8c9d5a119046 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -406,6 +406,44 @@ config SPI_IMX
 	help
 	  This enables support for the Freescale i.MX SPI controllers.
 
+config SPI_INTEL
+	tristate
+
+config SPI_INTEL_PCI
+	tristate "Intel PCH/PCU SPI flash PCI driver (DANGEROUS)"
+	depends on PCI && (X86 || COMPILE_TEST)
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
index 699db95c8441..070918a79362 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -59,6 +59,9 @@ obj-$(CONFIG_SPI_HISI_KUNPENG)		+= spi-hisi-kunpeng.o
 obj-$(CONFIG_SPI_HISI_SFC_V3XX)		+= spi-hisi-sfc-v3xx.o
 obj-$(CONFIG_SPI_IMG_SPFI)		+= spi-img-spfi.o
 obj-$(CONFIG_SPI_IMX)			+= spi-imx.o
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
similarity index 80%
rename from drivers/mtd/spi-nor/controllers/intel-spi.c
rename to drivers/spi/spi-intel.c
index f35597cbea0c..e299710bafa9 100644
--- a/drivers/mtd/spi-nor/controllers/intel-spi.c
+++ b/drivers/spi/spi-intel.c
@@ -2,21 +2,19 @@
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
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/spi-nor.h>
+#include <linux/spi/flash.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
 
-#include "intel-spi.h"
+#include "spi-intel.h"
 
 /* Offsets are from @ispi->base */
 #define BFPREG				0x00
@@ -92,8 +90,6 @@
 /* CPU specifics */
 #define BYT_PR				0x74
 #define BYT_SSFSTS_CTL			0x90
-#define BYT_BCR				0xfc
-#define BYT_BCR_WPD			BIT(0)
 #define BYT_FREG_NUM			5
 #define BYT_PR_NUM			5
 
@@ -125,10 +121,10 @@
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
@@ -142,10 +138,10 @@
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
@@ -199,9 +195,6 @@ static void intel_spi_dump_regs(struct intel_spi *ispi)
 			readl(ispi->sregs + OPMENU1));
 	}
 
-	if (ispi->info->type == INTEL_SPI_BYT)
-		dev_dbg(ispi->dev, "BCR=0x%08x\n", readl(ispi->base + BYT_BCR));
-
 	dev_dbg(ispi->dev, "LVSCC=0x%08x\n", readl(ispi->base + LVSCC));
 	dev_dbg(ispi->dev, "UVSCC=0x%08x\n", readl(ispi->base + UVSCC));
 
@@ -419,7 +412,6 @@ static int intel_spi_init(struct intel_spi *ispi)
 	}
 
 	intel_spi_dump_regs(ispi);
-
 	return 0;
 }
 
@@ -553,10 +545,9 @@ static int intel_spi_sw_cycle(struct intel_spi *ispi, u8 opcode, size_t len,
 	return 0;
 }
 
-static int intel_spi_read_reg(struct spi_nor *nor, u8 opcode, u8 *buf,
+static int intel_spi_read_reg(struct intel_spi *ispi, u8 opcode, void *buf,
 			      size_t len)
 {
-	struct intel_spi *ispi = nor->priv;
 	int ret;
 
 	/* Address of the first chip */
@@ -574,10 +565,9 @@ static int intel_spi_read_reg(struct spi_nor *nor, u8 opcode, u8 *buf,
 	return intel_spi_read_block(ispi, buf, len);
 }
 
-static int intel_spi_write_reg(struct spi_nor *nor, u8 opcode, const u8 *buf,
+static int intel_spi_write_reg(struct intel_spi *ispi, u8 opcode, const void *buf,
 			       size_t len)
 {
-	struct intel_spi *ispi = nor->priv;
 	int ret;
 
 	/*
@@ -632,10 +622,9 @@ static int intel_spi_write_reg(struct spi_nor *nor, u8 opcode, const u8 *buf,
 	return intel_spi_hw_cycle(ispi, opcode, len);
 }
 
-static ssize_t intel_spi_read(struct spi_nor *nor, loff_t from, size_t len,
-			      u_char *read_buf)
+static ssize_t intel_spi_read(struct intel_spi *ispi, u32 from, size_t len,
+			      void *read_buf)
 {
-	struct intel_spi *ispi = nor->priv;
 	size_t block_size, retlen = 0;
 	u32 val, status;
 	ssize_t ret;
@@ -647,16 +636,6 @@ static ssize_t intel_spi_read(struct spi_nor *nor, loff_t from, size_t len,
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
 	while (len > 0) {
 		block_size = min_t(size_t, len, INTEL_SPI_FIFO_SZ);
 
@@ -685,7 +664,7 @@ static ssize_t intel_spi_read(struct spi_nor *nor, loff_t from, size_t len,
 			ret = -EACCES;
 
 		if (ret < 0) {
-			dev_err(ispi->dev, "read error: %llx: %#x\n", from,
+			dev_err(ispi->dev, "read error: %x: %#x\n", from,
 				status);
 			return ret;
 		}
@@ -703,10 +682,9 @@ static ssize_t intel_spi_read(struct spi_nor *nor, loff_t from, size_t len,
 	return retlen;
 }
 
-static ssize_t intel_spi_write(struct spi_nor *nor, loff_t to, size_t len,
-			       const u_char *write_buf)
+static ssize_t intel_spi_write(struct intel_spi *ispi, u32 to, size_t len,
+			       const void *write_buf)
 {
-	struct intel_spi *ispi = nor->priv;
 	size_t block_size, retlen = 0;
 	u32 val, status;
 	ssize_t ret;
@@ -752,7 +730,7 @@ static ssize_t intel_spi_write(struct spi_nor *nor, loff_t to, size_t len,
 			ret = -EACCES;
 
 		if (ret < 0) {
-			dev_err(ispi->dev, "write error: %llx: %#x\n", to,
+			dev_err(ispi->dev, "write error: %x: %#x\n", to,
 				status);
 			return ret;
 		}
@@ -766,68 +744,150 @@ static ssize_t intel_spi_write(struct spi_nor *nor, loff_t to, size_t len,
 	return retlen;
 }
 
-static int intel_spi_erase(struct spi_nor *nor, loff_t offs)
+static int intel_spi_erase(struct intel_spi *ispi, u8 opcode, u32 offs)
 {
-	size_t erase_size, len = nor->mtd.erasesize;
-	struct intel_spi *ispi = nor->priv;
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
 
+	writel(offs, ispi->base + FADDR);
+
 	if (ispi->swseq_erase) {
-		while (len > 0) {
-			writel(offs, ispi->base + FADDR);
+		ret = intel_spi_sw_cycle(ispi, opcode, 0,
+					 OPTYPE_WRITE_WITH_ADDR);
+		return ret ? ret : 0;
+	}
+
+	/* Not needed with HW sequencer erase, make sure it is cleared */
+	ispi->atomic_preopcode = 0;
+
+	val = readl(ispi->base + HSFSTS_CTL);
+	val &= ~(HSFSTS_CTL_FDBC_MASK | HSFSTS_CTL_FCYCLE_MASK);
+	val |= HSFSTS_CTL_AEL | HSFSTS_CTL_FCERR | HSFSTS_CTL_FDONE;
+	val |= cmd;
+	val |= HSFSTS_CTL_FGO;
+	writel(val, ispi->base + HSFSTS_CTL);
+
+	ret = intel_spi_wait_hw_busy(ispi);
+	if (ret)
+		return ret;
+
+	status = readl(ispi->base + HSFSTS_CTL);
+	if (status & HSFSTS_CTL_FCERR)
+		return -EIO;
+	else if (status & HSFSTS_CTL_AEL)
+		return -EACCES;
+
+	return 0;
+}
 
-			ret = intel_spi_sw_cycle(ispi, nor->erase_opcode,
-						 0, OPTYPE_WRITE_WITH_ADDR);
-			if (ret)
-				return ret;
+static bool intel_spi_supports_mem_op(struct spi_mem *mem,
+				      const struct spi_mem_op *op)
+{
+	struct intel_spi *ispi = spi_master_get_devdata(mem->spi->master);
 
-			offs += erase_size;
-			len -= erase_size;
+	if (op->cmd.dtr)
+		return false;
+
+	if (ispi->swseq_reg && ispi->locked) {
+		int i;
+
+		for (i = 0; i < ARRAY_SIZE(ispi->opcodes); i++) {
+			if (ispi->opcodes[i] == op->cmd.opcode)
+				return true;
 		}
 
-		return 0;
+		return false;
 	}
 
-	/* Not needed with HW sequencer erase, make sure it is cleared */
-	ispi->atomic_preopcode = 0;
+	switch (op->cmd.opcode) {
+	case SPINOR_OP_RDID:
+	case SPINOR_OP_RDSR:
+	case SPINOR_OP_WRSR:
+		return true;
 
-	while (len > 0) {
-		writel(offs, ispi->base + FADDR);
+	case SPINOR_OP_READ:
+	case SPINOR_OP_READ_FAST:
+	case SPINOR_OP_READ_4B:
+	case SPINOR_OP_READ_FAST_4B:
+		return true;
 
-		val = readl(ispi->base + HSFSTS_CTL);
-		val &= ~(HSFSTS_CTL_FDBC_MASK | HSFSTS_CTL_FCYCLE_MASK);
-		val |= HSFSTS_CTL_AEL | HSFSTS_CTL_FCERR | HSFSTS_CTL_FDONE;
-		val |= cmd;
-		val |= HSFSTS_CTL_FGO;
-		writel(val, ispi->base + HSFSTS_CTL);
+	case SPINOR_OP_PP:
+	case SPINOR_OP_PP_4B:
+	case SPINOR_OP_WREN:
+	case SPINOR_OP_WRDI:
+		return true;
 
-		ret = intel_spi_wait_hw_busy(ispi);
-		if (ret)
-			return ret;
+	case SPINOR_OP_SE:
+	case SPINOR_OP_SE_4B:
+		return ispi->erase_64k;
 
-		status = readl(ispi->base + HSFSTS_CTL);
-		if (status & HSFSTS_CTL_FCERR)
-			return -EIO;
-		else if (status & HSFSTS_CTL_AEL)
-			return -EACCES;
+	case SPINOR_OP_BE_4K:
+	case SPINOR_OP_BE_4K_4B:
+		return true;
+	}
+
+	return false;
+}
 
-		offs += erase_size;
-		len -= erase_size;
+static int intel_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	struct intel_spi *ispi = spi_master_get_devdata(mem->spi->master);
+	size_t nbytes = op->data.nbytes;
+	u8 opcode = op->cmd.opcode;
+
+	if (op->addr.nbytes) {
+		if  (op->data.dir == SPI_MEM_DATA_IN)
+			return intel_spi_read(ispi, op->addr.val, nbytes,
+					      op->data.buf.in);
+		else if (op->data.dir == SPI_MEM_DATA_OUT)
+			return intel_spi_write(ispi, op->addr.val, nbytes,
+					       op->data.buf.out);
+		else if (op->data.dir == SPI_MEM_NO_DATA)
+			return intel_spi_erase(ispi, opcode, op->addr.val);
+	} else {
+		if  (op->data.dir == SPI_MEM_DATA_IN)
+			return intel_spi_read_reg(ispi, opcode, op->data.buf.in,
+						  nbytes);
+		else if (op->data.dir == SPI_MEM_DATA_OUT)
+			return intel_spi_write_reg(ispi, opcode, op->data.buf.out,
+						   nbytes);
+		else if (op->data.dir == SPI_MEM_NO_DATA)
+			return intel_spi_write_reg(ispi, opcode, NULL, 0);
 	}
 
-	return 0;
+	return -EINVAL;
+}
+
+static const char *intel_spi_get_name(struct spi_mem *mem)
+{
+	const struct intel_spi *ispi = spi_master_get_devdata(mem->spi->master);
+
+	/*
+	 * Return name of the flash controller device to be compatible
+	 * with the MTD version.
+	 */
+	return dev_name(ispi->dev);
 }
 
+static const struct spi_controller_mem_ops intel_spi_mem_ops = {
+	.supports_op = intel_spi_supports_mem_op,
+	.exec_op = intel_spi_exec_mem_op,
+	.get_name = intel_spi_get_name,
+};
+
 static bool intel_spi_is_protected(const struct intel_spi *ispi,
 				   unsigned int base, unsigned int limit)
 {
@@ -896,70 +956,74 @@ static void intel_spi_fill_partition(struct intel_spi *ispi,
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
+
+	return spi_new_device(ispi->master, &chip) ? 0 : -ENODEV;
+}
 
-struct intel_spi *intel_spi_probe(struct device *dev,
-	struct resource *mem, const struct intel_spi_boardinfo *info)
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
+
+	master->mem_ops = &intel_spi_mem_ops;
 
-	ispi = devm_kzalloc(dev, sizeof(*ispi), GFP_KERNEL);
-	if (!ispi)
-		return ERR_PTR(-ENOMEM);
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
2.33.0

