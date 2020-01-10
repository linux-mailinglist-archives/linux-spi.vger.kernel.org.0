Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F146813779B
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2020 21:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgAJUAA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Jan 2020 15:00:00 -0500
Received: from foss.arm.com ([217.140.110.172]:50582 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727812AbgAJT7I (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 10 Jan 2020 14:59:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BE04DA7;
        Fri, 10 Jan 2020 11:59:07 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97E5B3F534;
        Fri, 10 Jan 2020 11:59:06 -0800 (PST)
Date:   Fri, 10 Jan 2020 19:59:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     broonie@kernel.org, chenxiang66@hisilicon.com,
        fengsheng5@huawei.com, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com,
        Mark Brown <broonie@kernel.org>, tudor.ambarus@microchip.com,
        xuejiancheng@hisilicon.com
Subject: Applied "spi: Add HiSilicon v3xx SPI NOR flash controller driver" to the spi tree
In-Reply-To: <1575900490-74467-3-git-send-email-john.garry@huawei.com>
Message-Id: <applied-1575900490-74467-3-git-send-email-john.garry@huawei.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: Add HiSilicon v3xx SPI NOR flash controller driver

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.6

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From a2ca53b52e007de81752bbb443d828f5950d6d04 Mon Sep 17 00:00:00 2001
From: John Garry <john.garry@huawei.com>
Date: Mon, 9 Dec 2019 22:08:09 +0800
Subject: [PATCH] spi: Add HiSilicon v3xx SPI NOR flash controller driver

Add the driver for the HiSilicon v3xx SPI NOR flash controller, commonly
found in hi16xx chipsets.

This is a different controller than that in drivers/mtd/spi-nor/hisi-sfc.c;
indeed, the naming for that driver is poor, since it is really known as
FMC, and can support other memory technologies.

The driver module name is "hisi-sfc-v3xx", as recommended by HW designer,
being an attempt to provide a distinct name - v3xx being the unique
controller versioning.

Only ACPI firmware is supported.

DMA is not supported, and we just use polling mode for operation
completion notification.

The driver uses the SPI MEM OPs.

Signed-off-by: John Garry <john.garry@huawei.com>
Link: https://lore.kernel.org/r/1575900490-74467-3-git-send-email-john.garry@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/Kconfig             |   9 +
 drivers/spi/Makefile            |   1 +
 drivers/spi/spi-hisi-sfc-v3xx.c | 284 ++++++++++++++++++++++++++++++++
 3 files changed, 294 insertions(+)
 create mode 100644 drivers/spi/spi-hisi-sfc-v3xx.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 870f7797b56b..d6ed0c355954 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -281,6 +281,15 @@ config SPI_FSL_QUADSPI
 	  This controller does not support generic SPI messages. It only
 	  supports the high-level SPI memory interface.
 
+config SPI_HISI_SFC_V3XX
+	tristate "HiSilicon SPI-NOR Flash Controller for Hi16XX chipsets"
+	depends on (ARM64 && ACPI) || COMPILE_TEST
+	depends on HAS_IOMEM
+	select CONFIG_MTD_SPI_NOR
+	help
+	  This enables support for HiSilicon v3xx SPI-NOR flash controller
+	  found in hi16xx chipsets.
+
 config SPI_NXP_FLEXSPI
 	tristate "NXP Flex SPI controller"
 	depends on ARCH_LAYERSCAPE || HAS_IOMEM
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index bb49c9e6d0a0..9b65ec5afc5e 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_SPI_FSL_LPSPI)		+= spi-fsl-lpspi.o
 obj-$(CONFIG_SPI_FSL_QUADSPI)		+= spi-fsl-qspi.o
 obj-$(CONFIG_SPI_FSL_SPI)		+= spi-fsl-spi.o
 obj-$(CONFIG_SPI_GPIO)			+= spi-gpio.o
+obj-$(CONFIG_SPI_HISI_SFC_V3XX)		+= spi-hisi-sfc-v3xx.o
 obj-$(CONFIG_SPI_IMG_SPFI)		+= spi-img-spfi.o
 obj-$(CONFIG_SPI_IMX)			+= spi-imx.o
 obj-$(CONFIG_SPI_LANTIQ_SSC)		+= spi-lantiq-ssc.o
diff --git a/drivers/spi/spi-hisi-sfc-v3xx.c b/drivers/spi/spi-hisi-sfc-v3xx.c
new file mode 100644
index 000000000000..4cf8fc80a7b7
--- /dev/null
+++ b/drivers/spi/spi-hisi-sfc-v3xx.c
@@ -0,0 +1,284 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// HiSilicon SPI NOR V3XX Flash Controller Driver for hi16xx chipsets
+//
+// Copyright (c) 2019 HiSilicon Technologies Co., Ltd.
+// Author: John Garry <john.garry@huawei.com>
+
+#include <linux/acpi.h>
+#include <linux/bitops.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
+
+#define HISI_SFC_V3XX_VERSION (0x1f8)
+
+#define HISI_SFC_V3XX_CMD_CFG (0x300)
+#define HISI_SFC_V3XX_CMD_CFG_DATA_CNT_OFF 9
+#define HISI_SFC_V3XX_CMD_CFG_RW_MSK BIT(8)
+#define HISI_SFC_V3XX_CMD_CFG_DATA_EN_MSK BIT(7)
+#define HISI_SFC_V3XX_CMD_CFG_DUMMY_CNT_OFF 4
+#define HISI_SFC_V3XX_CMD_CFG_ADDR_EN_MSK BIT(3)
+#define HISI_SFC_V3XX_CMD_CFG_CS_SEL_OFF 1
+#define HISI_SFC_V3XX_CMD_CFG_START_MSK BIT(0)
+#define HISI_SFC_V3XX_CMD_INS (0x308)
+#define HISI_SFC_V3XX_CMD_ADDR (0x30c)
+#define HISI_SFC_V3XX_CMD_DATABUF0 (0x400)
+
+struct hisi_sfc_v3xx_host {
+	struct device *dev;
+	void __iomem *regbase;
+	int max_cmd_dword;
+};
+
+#define HISI_SFC_V3XX_WAIT_TIMEOUT_US		1000000
+#define HISI_SFC_V3XX_WAIT_POLL_INTERVAL_US	10
+
+static int hisi_sfc_v3xx_wait_cmd_idle(struct hisi_sfc_v3xx_host *host)
+{
+	u32 reg;
+
+	return readl_poll_timeout(host->regbase + HISI_SFC_V3XX_CMD_CFG, reg,
+				  !(reg & HISI_SFC_V3XX_CMD_CFG_START_MSK),
+				  HISI_SFC_V3XX_WAIT_POLL_INTERVAL_US,
+				  HISI_SFC_V3XX_WAIT_TIMEOUT_US);
+}
+
+static int hisi_sfc_v3xx_adjust_op_size(struct spi_mem *mem,
+					struct spi_mem_op *op)
+{
+	struct spi_device *spi = mem->spi;
+	struct hisi_sfc_v3xx_host *host;
+	uintptr_t addr = (uintptr_t)op->data.buf.in;
+	int max_byte_count;
+
+	host = spi_controller_get_devdata(spi->master);
+
+	max_byte_count = host->max_cmd_dword * 4;
+
+	if (!IS_ALIGNED(addr, 4) && op->data.nbytes >= 4)
+		op->data.nbytes = 4 - (addr % 4);
+	else if (op->data.nbytes > max_byte_count)
+		op->data.nbytes = max_byte_count;
+
+	return 0;
+}
+
+/*
+ * memcpy_{to,from}io doesn't gurantee 32b accesses - which we require for the
+ * DATABUF registers -so use __io{read,write}32_copy when possible. For
+ * trailing bytes, copy them byte-by-byte from the DATABUF register, as we
+ * can't clobber outside the source/dest buffer.
+ *
+ * For efficient data read/write, we try to put any start 32b unaligned data
+ * into a separate transaction in hisi_sfc_v3xx_adjust_op_size().
+ */
+static void hisi_sfc_v3xx_read_databuf(struct hisi_sfc_v3xx_host *host,
+				       u8 *to, unsigned int len)
+{
+	void __iomem *from;
+	int i;
+
+	from = host->regbase + HISI_SFC_V3XX_CMD_DATABUF0;
+
+	if (IS_ALIGNED((uintptr_t)to, 4)) {
+		int words = len / 4;
+
+		__ioread32_copy(to, from, words);
+
+		len -= words * 4;
+		if (len) {
+			u32 val;
+
+			to += words * 4;
+			from += words * 4;
+
+			val = __raw_readl(from);
+
+			for (i = 0; i < len; i++, val >>= 8, to++)
+				*to = (u8)val;
+		}
+	} else {
+		for (i = 0; i < DIV_ROUND_UP(len, 4); i++, from += 4) {
+			u32 val = __raw_readl(from);
+			int j;
+
+			for (j = 0; j < 4 && (j + (i * 4) < len);
+			     to++, val >>= 8, j++)
+				*to = (u8)val;
+		}
+	}
+}
+
+static void hisi_sfc_v3xx_write_databuf(struct hisi_sfc_v3xx_host *host,
+					const u8 *from, unsigned int len)
+{
+	void __iomem *to;
+	int i;
+
+	to = host->regbase + HISI_SFC_V3XX_CMD_DATABUF0;
+
+	if (IS_ALIGNED((uintptr_t)from, 4)) {
+		int words = len / 4;
+
+		__iowrite32_copy(to, from, words);
+
+		len -= words * 4;
+		if (len) {
+			u32 val = 0;
+
+			to += words * 4;
+			from += words * 4;
+
+			for (i = 0; i < len; i++, from++)
+				val |= *from << i * 8;
+			__raw_writel(val, to);
+		}
+
+	} else {
+		for (i = 0; i < DIV_ROUND_UP(len, 4); i++, to += 4) {
+			u32 val = 0;
+			int j;
+
+			for (j = 0; j < 4 && (j + (i * 4) < len);
+			     from++, j++)
+				val |= *from << j * 8;
+			__raw_writel(val, to);
+		}
+	}
+}
+
+static int hisi_sfc_v3xx_generic_exec_op(struct hisi_sfc_v3xx_host *host,
+					 const struct spi_mem_op *op,
+					 u8 chip_select)
+{
+	int ret, len = op->data.nbytes;
+	u32 config = 0;
+
+	if (op->addr.nbytes)
+		config |= HISI_SFC_V3XX_CMD_CFG_ADDR_EN_MSK;
+
+	if (op->data.dir != SPI_MEM_NO_DATA) {
+		config |= (len - 1) << HISI_SFC_V3XX_CMD_CFG_DATA_CNT_OFF;
+		config |= HISI_SFC_V3XX_CMD_CFG_DATA_EN_MSK;
+	}
+
+	if (op->data.dir == SPI_MEM_DATA_OUT)
+		hisi_sfc_v3xx_write_databuf(host, op->data.buf.out, len);
+	else if (op->data.dir == SPI_MEM_DATA_IN)
+		config |= HISI_SFC_V3XX_CMD_CFG_RW_MSK;
+
+	config |= op->dummy.nbytes << HISI_SFC_V3XX_CMD_CFG_DUMMY_CNT_OFF |
+		  chip_select << HISI_SFC_V3XX_CMD_CFG_CS_SEL_OFF |
+		  HISI_SFC_V3XX_CMD_CFG_START_MSK;
+
+	writel(op->addr.val, host->regbase + HISI_SFC_V3XX_CMD_ADDR);
+	writel(op->cmd.opcode, host->regbase + HISI_SFC_V3XX_CMD_INS);
+
+	writel(config, host->regbase + HISI_SFC_V3XX_CMD_CFG);
+
+	ret = hisi_sfc_v3xx_wait_cmd_idle(host);
+	if (ret)
+		return ret;
+
+	if (op->data.dir == SPI_MEM_DATA_IN)
+		hisi_sfc_v3xx_read_databuf(host, op->data.buf.in, len);
+
+	return 0;
+}
+
+static int hisi_sfc_v3xx_exec_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op)
+{
+	struct hisi_sfc_v3xx_host *host;
+	struct spi_device *spi = mem->spi;
+	u8 chip_select = spi->chip_select;
+
+	host = spi_controller_get_devdata(spi->master);
+
+	return hisi_sfc_v3xx_generic_exec_op(host, op, chip_select);
+}
+
+static const struct spi_controller_mem_ops hisi_sfc_v3xx_mem_ops = {
+	.adjust_op_size = hisi_sfc_v3xx_adjust_op_size,
+	.exec_op = hisi_sfc_v3xx_exec_op,
+};
+
+static int hisi_sfc_v3xx_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct hisi_sfc_v3xx_host *host;
+	struct spi_controller *ctlr;
+	u32 version;
+	int ret;
+
+	ctlr = spi_alloc_master(&pdev->dev, sizeof(*host));
+	if (!ctlr)
+		return -ENOMEM;
+
+	ctlr->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD |
+			  SPI_TX_DUAL | SPI_TX_QUAD;
+
+	host = spi_controller_get_devdata(ctlr);
+	host->dev = dev;
+
+	platform_set_drvdata(pdev, host);
+
+	host->regbase = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(host->regbase)) {
+		ret = PTR_ERR(host->regbase);
+		goto err_put_master;
+	}
+
+	ctlr->bus_num = -1;
+	ctlr->num_chipselect = 1;
+	ctlr->mem_ops = &hisi_sfc_v3xx_mem_ops;
+
+	version = readl(host->regbase + HISI_SFC_V3XX_VERSION);
+
+	switch (version) {
+	case 0x351:
+		host->max_cmd_dword = 64;
+		break;
+	default:
+		host->max_cmd_dword = 16;
+		break;
+	}
+
+	ret = devm_spi_register_controller(dev, ctlr);
+	if (ret)
+		goto err_put_master;
+
+	dev_info(&pdev->dev, "hw version 0x%x\n", version);
+
+	return 0;
+
+err_put_master:
+	spi_master_put(ctlr);
+	return ret;
+}
+
+#if IS_ENABLED(CONFIG_ACPI)
+static const struct acpi_device_id hisi_sfc_v3xx_acpi_ids[] = {
+	{"HISI0341", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, hisi_sfc_v3xx_acpi_ids);
+#endif
+
+static struct platform_driver hisi_sfc_v3xx_spi_driver = {
+	.driver = {
+		.name	= "hisi-sfc-v3xx",
+		.acpi_match_table = ACPI_PTR(hisi_sfc_v3xx_acpi_ids),
+	},
+	.probe	= hisi_sfc_v3xx_probe,
+};
+
+module_platform_driver(hisi_sfc_v3xx_spi_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("John Garry <john.garry@huawei.com>");
+MODULE_DESCRIPTION("HiSilicon SPI NOR V3XX Flash Controller Driver for hi16xx chipsets");
-- 
2.20.1

