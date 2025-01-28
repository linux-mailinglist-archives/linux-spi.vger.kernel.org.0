Return-Path: <linux-spi+bounces-6522-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E99A2060B
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jan 2025 09:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35FF73A7BD0
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jan 2025 08:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C211DFE01;
	Tue, 28 Jan 2025 08:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="oyihePaW"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C641D1DED67;
	Tue, 28 Jan 2025 08:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738052531; cv=none; b=YPwtgJPJHaDNVqFOmWu+iEWvpk0jZNcv4a5xYLk5r1XadYeURu+v2pcd7NYNxp31BbNfUCTJZLNsJZmMm/n8HD9k1opA1jNTC6Dld6L4y1y7fUan0QPsddYnFrr/uyRmHDiyIUZxkLLZldQFi1SJ2bYtWULVgRFn2PzvbtLJdqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738052531; c=relaxed/simple;
	bh=guTDRVQ0bA+FgB03EMiV0zkxqwi1mG6yi7ByusMvOO0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HGU9FSlR9q9KiHlMR5ZocixN8IXOhkWZBI1k2Jt61HBjYB2wTxBCgawvAzqeDMUZO9JdGKcPK/QeiZaNLJumu426pxJ+ZB6SYtszp0oSNC/j6mSVxKKhcQh7lKZPUuZbrLOkv9Ulo3mFMVjf9ACtzpBjC8x+LYxBoJFjqC4yFnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=oyihePaW; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50S215X8017105;
	Tue, 28 Jan 2025 09:21:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	I1PI+GkLypLNE5jdeczD+hDE1fBj1JzmBZWOUvEItM8=; b=oyihePaWuy6UoqFe
	zO7XWzyp2IagIWgcaZZ4jO7Yy1B7FvDIxNwic4gIY5h8pYOhtscRNuWOWVJCeCoq
	denXoNe7cN1iC9jvzNeQ7rhUBOPVN2rDQFbfmGQnscql0zbDGsthWJeroromV2mN
	dWciiD4GpfQTdyEhIIYJMUoZsHfQiIIwoK/vI3wzPFBjEVGXoSX82F8+VlGEhhvT
	QQw9qeoQ0r15Ibnxp7zRfclBTzH44OrZCSS6aMkn7c/MTDj5ClS2X4zLh1/xOD+v
	SmHKZnzVLJu1PWbRF0vrfdoqRyyZKB4Ms1zqbps04gf/EubNxU07k79DsX0TBbP/
	gSWH0A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44ebcbjrw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 09:21:43 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8735C40067;
	Tue, 28 Jan 2025 09:20:10 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E27C929C5F6;
	Tue, 28 Jan 2025 09:17:43 +0100 (CET)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 28 Jan
 2025 09:17:43 +0100
From: <patrice.chotard@foss.st.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <christophe.kerello@foss.st.com>, <patrice.chotard@foss.st.com>
Subject: [PATCH v2 2/9] spi: stm32: Add OSPI driver
Date: Tue, 28 Jan 2025 09:17:24 +0100
Message-ID: <20250128081731.2284457-3-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250128081731.2284457-1-patrice.chotard@foss.st.com>
References: <20250128081731.2284457-1-patrice.chotard@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SAFCAS1NODE1.st.com (10.75.90.11) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_02,2025-01-27_01,2024-11-22_01

From: Patrice Chotard <patrice.chotard@foss.st.com>

Add STM32 OSPI driver, it supports :
  - support sNOR / sNAND devices.
  - Three functional modes: indirect, automatic-status polling,
    memory-mapped.
  - Single-, dual-, quad-, and octal-SPI communication.
  - Dual-quad communication.
  - Single data rate (SDR).
  - DMA channel for indirect mode.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/spi/Kconfig          |   10 +
 drivers/spi/Makefile         |    1 +
 drivers/spi/spi-stm32-ospi.c | 1064 ++++++++++++++++++++++++++++++++++
 3 files changed, 1075 insertions(+)
 create mode 100644 drivers/spi/spi-stm32-ospi.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ea8a31032927..256a3e23639a 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1045,6 +1045,16 @@ config SPI_STM32
 	  is not available, the driver automatically falls back to
 	  PIO mode.
 
+config SPI_STM32_OSPI
+	tristate "STMicroelectronics STM32 OCTO SPI controller"
+	depends on ARCH_STM32 || COMPILE_TEST
+	depends on OF
+	depends on SPI_MEM
+	help
+	  This enables support for the Octo SPI controller in master mode.
+	  This driver does not support generic SPI. The implementation only
+	  supports spi-mem interface.
+
 config SPI_STM32_QSPI
 	tristate "STMicroelectronics STM32 QUAD SPI controller"
 	depends on ARCH_STM32 || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 9db7554c1864..65e0804ebb3a 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -138,6 +138,7 @@ obj-$(CONFIG_SPI_SPRD)			+= spi-sprd.o
 obj-$(CONFIG_SPI_SPRD_ADI)		+= spi-sprd-adi.o
 obj-$(CONFIG_SPI_STM32) 		+= spi-stm32.o
 obj-$(CONFIG_SPI_STM32_QSPI) 		+= spi-stm32-qspi.o
+obj-$(CONFIG_SPI_STM32_OSPI) 		+= spi-stm32-ospi.o
 obj-$(CONFIG_SPI_ST_SSC4)		+= spi-st-ssc4.o
 obj-$(CONFIG_SPI_SUN4I)			+= spi-sun4i.o
 obj-$(CONFIG_SPI_SUN6I)			+= spi-sun6i.o
diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
new file mode 100644
index 000000000000..131266a7c5fe
--- /dev/null
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -0,0 +1,1064 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) STMicroelectronics 2025 - All Rights Reserved
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/sizes.h>
+#include <linux/spi/spi-mem.h>
+#include <linux/types.h>
+
+#define OSPI_CR			0x00
+#define CR_EN			BIT(0)
+#define CR_ABORT		BIT(1)
+#define CR_DMAEN		BIT(2)
+#define CR_FTHRES_SHIFT		8
+#define CR_TEIE			BIT(16)
+#define CR_TCIE			BIT(17)
+#define CR_SMIE			BIT(19)
+#define CR_APMS			BIT(22)
+#define CR_CSSEL		BIT(24)
+#define CR_FMODE_MASK		GENMASK(29, 28)
+#define CR_FMODE_INDW		(0U)
+#define CR_FMODE_INDR		(1U)
+#define CR_FMODE_APM		(2U)
+#define CR_FMODE_MM		(3U)
+
+#define OSPI_DCR1		0x08
+#define DCR1_DLYBYP		BIT(3)
+#define DCR1_DEVSIZE_MASK	GENMASK(20, 16)
+#define DCR1_MTYP_MASK		GENMASK(26, 24)
+#define DCR1_MTYP_MX_MODE	1
+#define DCR1_MTYP_HP_MEMMODE	4
+
+#define OSPI_DCR2		0x0c
+#define DCR2_PRESC_MASK		GENMASK(7, 0)
+
+#define OSPI_SR			0x20
+#define SR_TEF			BIT(0)
+#define SR_TCF			BIT(1)
+#define SR_FTF			BIT(2)
+#define SR_SMF			BIT(3)
+#define SR_BUSY			BIT(5)
+
+#define OSPI_FCR		0x24
+#define FCR_CTEF		BIT(0)
+#define FCR_CTCF		BIT(1)
+#define FCR_CSMF		BIT(3)
+
+#define OSPI_DLR		0x40
+#define OSPI_AR			0x48
+#define OSPI_DR			0x50
+#define OSPI_PSMKR		0x80
+#define OSPI_PSMAR		0x88
+
+#define OSPI_CCR		0x100
+#define CCR_IMODE_MASK		GENMASK(2, 0)
+#define CCR_IDTR		BIT(3)
+#define CCR_ISIZE_MASK		GENMASK(5, 4)
+#define CCR_ADMODE_MASK		GENMASK(10, 8)
+#define CCR_ADMODE_8LINES	4
+#define CCR_ADDTR		BIT(11)
+#define CCR_ADSIZE_MASK		GENMASK(13, 12)
+#define CCR_ADSIZE_32BITS	3
+#define CCR_DMODE_MASK		GENMASK(26, 24)
+#define CCR_DMODE_8LINES	4
+#define CCR_DQSE		BIT(29)
+#define CCR_DDTR		BIT(27)
+#define CCR_BUSWIDTH_0		0x0
+#define CCR_BUSWIDTH_1		0x1
+#define CCR_BUSWIDTH_2		0x2
+#define CCR_BUSWIDTH_4		0x3
+#define CCR_BUSWIDTH_8		0x4
+
+#define OSPI_TCR		0x108
+#define TCR_DCYC_MASK		GENMASK(4, 0)
+#define TCR_DHQC		BIT(28)
+#define TCR_SSHIFT		BIT(30)
+
+#define OSPI_IR			0x110
+
+#define STM32_OSPI_MAX_MMAP_SZ	SZ_256M
+#define STM32_OSPI_MAX_NORCHIP	2
+
+#define STM32_FIFO_TIMEOUT_US		30000
+#define STM32_ABT_TIMEOUT_US		100000
+#define STM32_COMP_TIMEOUT_MS		5000
+#define STM32_BUSY_TIMEOUT_US		100000
+
+
+#define STM32_AUTOSUSPEND_DELAY -1
+
+struct stm32_ospi {
+	struct device *dev;
+	struct spi_controller *ctrl;
+	struct clk *clk;
+	struct reset_control *rstc;
+
+	struct completion data_completion;
+	struct completion match_completion;
+
+	struct dma_chan *dma_chtx;
+	struct dma_chan *dma_chrx;
+	struct completion dma_completion;
+
+	void __iomem *regs_base;
+	void __iomem *mm_base;
+	phys_addr_t regs_phys_base;
+	resource_size_t mm_size;
+	u32 clk_rate;
+	u32 fmode;
+	u32 cr_reg;
+	u32 dcr_reg;
+	u32 flash_presc[STM32_OSPI_MAX_NORCHIP];
+	int irq;
+	unsigned long status_timeout;
+
+	/*
+	 * To protect device configuration, could be different between
+	 * 2 flash access
+	 */
+	struct mutex lock;
+};
+
+static void stm32_ospi_read_fifo(u8 *val, void __iomem *addr)
+{
+	*val = readb_relaxed(addr);
+}
+
+static void stm32_ospi_write_fifo(u8 *val, void __iomem *addr)
+{
+	writeb_relaxed(*val, addr);
+}
+
+static int stm32_ospi_abort(struct stm32_ospi *ospi)
+{
+	void __iomem *regs_base = ospi->regs_base;
+	u32 cr;
+	int timeout;
+
+	cr = readl_relaxed(regs_base + OSPI_CR) | CR_ABORT;
+	writel_relaxed(cr, regs_base + OSPI_CR);
+
+	/* wait clear of abort bit by hw */
+	timeout = readl_relaxed_poll_timeout_atomic(regs_base + OSPI_CR,
+						    cr, !(cr & CR_ABORT), 1,
+						    STM32_ABT_TIMEOUT_US);
+
+	if (timeout)
+		dev_err(ospi->dev, "%s abort timeout:%d\n", __func__, timeout);
+
+	return timeout;
+}
+
+static int stm32_ospi_tx_poll(struct stm32_ospi *ospi, u8 *buf, u32 len, bool read)
+{
+	void __iomem *regs_base = ospi->regs_base;
+	void (*tx_fifo)(u8 *val, void __iomem *addr);
+	u32 sr;
+	int ret;
+
+	if (read)
+		tx_fifo = stm32_ospi_read_fifo;
+	else
+		tx_fifo = stm32_ospi_write_fifo;
+
+	while (len--) {
+		ret = readl_relaxed_poll_timeout_atomic(regs_base + OSPI_SR,
+							sr, sr & SR_FTF, 1,
+							STM32_FIFO_TIMEOUT_US);
+		if (ret) {
+			dev_err(ospi->dev, "fifo timeout (len:%d stat:%#x)\n",
+				len, sr);
+			return ret;
+		}
+		tx_fifo(buf++, regs_base + OSPI_DR);
+	}
+
+	return 0;
+}
+
+static int stm32_ospi_wait_nobusy(struct stm32_ospi *ospi)
+{
+	u32 sr;
+
+	return readl_relaxed_poll_timeout_atomic(ospi->regs_base + OSPI_SR,
+						 sr, !(sr & SR_BUSY), 1,
+						 STM32_BUSY_TIMEOUT_US);
+}
+
+static int stm32_ospi_wait_cmd(struct stm32_ospi *ospi)
+{
+	void __iomem *regs_base = ospi->regs_base;
+	u32 cr, sr;
+	int err = 0;
+
+	if ((readl_relaxed(regs_base + OSPI_SR) & SR_TCF) ||
+	    ospi->fmode == CR_FMODE_APM)
+		goto out;
+
+	reinit_completion(&ospi->data_completion);
+	cr = readl_relaxed(regs_base + OSPI_CR);
+	writel_relaxed(cr | CR_TCIE | CR_TEIE, regs_base + OSPI_CR);
+
+	if (!wait_for_completion_timeout(&ospi->data_completion,
+				msecs_to_jiffies(STM32_COMP_TIMEOUT_MS)))
+		err = -ETIMEDOUT;
+
+	sr = readl_relaxed(regs_base + OSPI_SR);
+	if (sr & SR_TCF)
+		/* avoid false timeout */
+		err = 0;
+	if (sr & SR_TEF)
+		err = -EIO;
+
+out:
+	/* clear flags */
+	writel_relaxed(FCR_CTCF | FCR_CTEF, regs_base + OSPI_FCR);
+
+	if (!err)
+		err = stm32_ospi_wait_nobusy(ospi);
+
+	return err;
+}
+
+static void stm32_ospi_dma_callback(void *arg)
+{
+	struct completion *dma_completion = arg;
+
+	complete(dma_completion);
+}
+
+static irqreturn_t stm32_ospi_irq(int irq, void *dev_id)
+{
+	struct stm32_ospi *ospi = (struct stm32_ospi *)dev_id;
+	void __iomem *regs_base = ospi->regs_base;
+	u32 cr, sr;
+
+	cr = readl_relaxed(regs_base + OSPI_CR);
+	sr = readl_relaxed(regs_base + OSPI_SR);
+
+	if (cr & CR_SMIE && sr & SR_SMF) {
+		/* disable irq */
+		cr &= ~CR_SMIE;
+		writel_relaxed(cr, regs_base + OSPI_CR);
+		complete(&ospi->match_completion);
+
+		return IRQ_HANDLED;
+	}
+
+	if (sr & (SR_TEF | SR_TCF)) {
+		/* disable irq */
+		cr &= ~CR_TCIE & ~CR_TEIE;
+		writel_relaxed(cr, regs_base + OSPI_CR);
+		complete(&ospi->data_completion);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void stm32_ospi_dma_setup(struct stm32_ospi *ospi,
+			 struct dma_slave_config *dma_cfg)
+{
+	if (dma_cfg && ospi->dma_chrx) {
+		if (dmaengine_slave_config(ospi->dma_chrx, dma_cfg)) {
+			dev_err(ospi->dev, "dma rx config failed\n");
+			dma_release_channel(ospi->dma_chrx);
+			ospi->dma_chrx = NULL;
+		}
+	}
+
+	if (dma_cfg && ospi->dma_chtx) {
+		if (dmaengine_slave_config(ospi->dma_chtx, dma_cfg)) {
+			dev_err(ospi->dev, "dma tx config failed\n");
+			dma_release_channel(ospi->dma_chtx);
+			ospi->dma_chtx = NULL;
+		}
+	}
+
+	init_completion(&ospi->dma_completion);
+}
+
+static int stm32_ospi_tx_mm(struct stm32_ospi *ospi,
+			    const struct spi_mem_op *op)
+{
+	memcpy_fromio(op->data.buf.in, ospi->mm_base + op->addr.val,
+		      op->data.nbytes);
+	return 0;
+}
+
+static int stm32_ospi_tx_dma(struct stm32_ospi *ospi,
+			     const struct spi_mem_op *op)
+{
+	struct dma_async_tx_descriptor *desc;
+	void __iomem *regs_base = ospi->regs_base;
+	enum dma_transfer_direction dma_dir;
+	struct dma_chan *dma_ch;
+	struct sg_table sgt;
+	dma_cookie_t cookie;
+	u32 cr, t_out;
+	int err;
+
+	if (op->data.dir == SPI_MEM_DATA_IN) {
+		dma_dir = DMA_DEV_TO_MEM;
+		dma_ch = ospi->dma_chrx;
+	} else {
+		dma_dir = DMA_MEM_TO_DEV;
+		dma_ch = ospi->dma_chtx;
+	}
+
+	/*
+	 * Spi_map_buf return -EINVAL if the buffer is not DMA-able
+	 * (DMA-able: in vmalloc | kmap | virt_addr_valid)
+	 */
+	err = spi_controller_dma_map_mem_op_data(ospi->ctrl, op, &sgt);
+	if (err)
+		return err;
+
+	desc = dmaengine_prep_slave_sg(dma_ch, sgt.sgl, sgt.nents,
+				       dma_dir, DMA_PREP_INTERRUPT);
+	if (!desc) {
+		err = -ENOMEM;
+		goto out_unmap;
+	}
+
+	cr = readl_relaxed(regs_base + OSPI_CR);
+
+	reinit_completion(&ospi->dma_completion);
+	desc->callback = stm32_ospi_dma_callback;
+	desc->callback_param = &ospi->dma_completion;
+	cookie = dmaengine_submit(desc);
+	err = dma_submit_error(cookie);
+	if (err)
+		goto out;
+
+	dma_async_issue_pending(dma_ch);
+
+	writel_relaxed(cr | CR_DMAEN, regs_base + OSPI_CR);
+
+	t_out = sgt.nents * STM32_COMP_TIMEOUT_MS;
+	if (!wait_for_completion_timeout(&ospi->dma_completion,
+					 msecs_to_jiffies(t_out)))
+		err = -ETIMEDOUT;
+
+	if (err)
+		dmaengine_terminate_all(dma_ch);
+
+out:
+	writel_relaxed(cr & ~CR_DMAEN, regs_base + OSPI_CR);
+out_unmap:
+	spi_controller_dma_unmap_mem_op_data(ospi->ctrl, op, &sgt);
+
+	return err;
+}
+
+static int stm32_ospi_tx(struct stm32_ospi *ospi, const struct spi_mem_op *op)
+{
+	u8 *buf;
+
+	if (!op->data.nbytes)
+		return 0;
+
+	if (ospi->fmode == CR_FMODE_MM)
+		return stm32_ospi_tx_mm(ospi, op);
+	else if (((op->data.dir == SPI_MEM_DATA_IN && ospi->dma_chrx) ||
+		 (op->data.dir == SPI_MEM_DATA_OUT && ospi->dma_chtx)) &&
+		  op->data.nbytes > 8)
+		if (!stm32_ospi_tx_dma(ospi, op))
+			return 0;
+
+	if (op->data.dir == SPI_MEM_DATA_IN)
+		buf = op->data.buf.in;
+	else
+		buf = (u8 *)op->data.buf.out;
+
+	return stm32_ospi_tx_poll(ospi, buf, op->data.nbytes,
+				 op->data.dir == SPI_MEM_DATA_IN);
+}
+
+static int stm32_ospi_wait_poll_status(struct stm32_ospi *ospi,
+				       const struct spi_mem_op *op)
+{
+	void __iomem *regs_base = ospi->regs_base;
+	u32 cr;
+
+	reinit_completion(&ospi->match_completion);
+	cr = readl_relaxed(regs_base + OSPI_CR);
+	writel_relaxed(cr | CR_SMIE, regs_base + OSPI_CR);
+
+	if (!wait_for_completion_timeout(&ospi->match_completion,
+					 msecs_to_jiffies(ospi->status_timeout))) {
+		u32 sr = readl_relaxed(regs_base + OSPI_SR);
+
+		/* Avoid false timeout */
+		if (!(sr & SR_SMF))
+			return -ETIMEDOUT;
+	}
+
+	writel_relaxed(FCR_CSMF, regs_base + OSPI_FCR);
+
+	return 0;
+}
+
+static int stm32_ospi_get_mode(u8 buswidth)
+{
+	switch (buswidth) {
+	case 8:
+		return CCR_BUSWIDTH_8;
+	case 4:
+		return CCR_BUSWIDTH_4;
+	default:
+		return buswidth;
+	}
+}
+
+static int stm32_ospi_send(struct spi_device *spi, const struct spi_mem_op *op)
+{
+	struct stm32_ospi *ospi = spi_controller_get_devdata(spi->controller);
+	void __iomem *regs_base = ospi->regs_base;
+	u32 ccr, cr, dcr2, tcr;
+	int timeout, err = 0, err_poll_status = 0;
+	u8 cs = spi->chip_select[ffs(spi->cs_index_mask) - 1];
+
+	dev_dbg(ospi->dev, "cmd:%#x mode:%d.%d.%d.%d addr:%#llx len:%#x\n",
+		op->cmd.opcode, op->cmd.buswidth, op->addr.buswidth,
+		op->dummy.buswidth, op->data.buswidth,
+		op->addr.val, op->data.nbytes);
+
+	cr = readl_relaxed(ospi->regs_base + OSPI_CR);
+	cr &= ~CR_CSSEL;
+	cr |= FIELD_PREP(CR_CSSEL, cs);
+	cr &= ~CR_FMODE_MASK;
+	cr |= FIELD_PREP(CR_FMODE_MASK, ospi->fmode);
+	writel_relaxed(cr, regs_base + OSPI_CR);
+
+	if (op->data.nbytes)
+		writel_relaxed(op->data.nbytes - 1, regs_base + OSPI_DLR);
+
+	/* set prescaler */
+	dcr2 = readl_relaxed(regs_base + OSPI_DCR2);
+	dcr2 |= FIELD_PREP(DCR2_PRESC_MASK, ospi->flash_presc[cs]);
+	writel_relaxed(dcr2, regs_base + OSPI_DCR2);
+
+	ccr = FIELD_PREP(CCR_IMODE_MASK, stm32_ospi_get_mode(op->cmd.buswidth));
+
+	if (op->addr.nbytes) {
+		ccr |= FIELD_PREP(CCR_ADMODE_MASK,
+				  stm32_ospi_get_mode(op->addr.buswidth));
+		ccr |= FIELD_PREP(CCR_ADSIZE_MASK, op->addr.nbytes - 1);
+	}
+
+	tcr = TCR_SSHIFT;
+	if (op->dummy.buswidth && op->dummy.nbytes) {
+		tcr |= FIELD_PREP(TCR_DCYC_MASK,
+				  op->dummy.nbytes * 8 / op->dummy.buswidth);
+	}
+	writel_relaxed(tcr, regs_base + OSPI_TCR);
+
+	if (op->data.nbytes) {
+		ccr |= FIELD_PREP(CCR_DMODE_MASK,
+				  stm32_ospi_get_mode(op->data.buswidth));
+	}
+
+	writel_relaxed(ccr, regs_base + OSPI_CCR);
+
+	/* set instruction, must be set after ccr register update */
+	writel_relaxed(op->cmd.opcode, regs_base + OSPI_IR);
+
+	if (op->addr.nbytes && ospi->fmode != CR_FMODE_MM)
+		writel_relaxed(op->addr.val, regs_base + OSPI_AR);
+
+	if (ospi->fmode == CR_FMODE_APM)
+		err_poll_status = stm32_ospi_wait_poll_status(ospi, op);
+
+	err = stm32_ospi_tx(ospi, op);
+
+	/*
+	 * Abort in:
+	 * -error case
+	 * -read memory map: prefetching must be stopped if we read the last
+	 *  byte of device (device size - fifo size). like device size is not
+	 *  knows, the prefetching is always stop.
+	 */
+	if (err || err_poll_status || ospi->fmode == CR_FMODE_MM)
+		goto abort;
+
+	/* Wait end of tx in indirect mode */
+	err = stm32_ospi_wait_cmd(ospi);
+	if (err)
+		goto abort;
+
+	return 0;
+
+abort:
+	timeout = stm32_ospi_abort(ospi);
+	writel_relaxed(FCR_CTCF | FCR_CSMF, regs_base + OSPI_FCR);
+
+	if (err || err_poll_status || timeout)
+		dev_err(ospi->dev, "%s err:%d err_poll_status:%d abort timeout:%d\n",
+			__func__, err, err_poll_status, timeout);
+
+	return err;
+}
+
+static int stm32_ospi_poll_status(struct spi_mem *mem,
+				  const struct spi_mem_op *op,
+				  u16 mask, u16 match,
+				  unsigned long initial_delay_us,
+				  unsigned long polling_rate_us,
+				  unsigned long timeout_ms)
+{
+	struct stm32_ospi *ospi = spi_controller_get_devdata(mem->spi->controller);
+	void __iomem *regs_base = ospi->regs_base;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(ospi->dev);
+	if (ret < 0)
+		return ret;
+
+	mutex_lock(&ospi->lock);
+
+	writel_relaxed(mask, regs_base + OSPI_PSMKR);
+	writel_relaxed(match, regs_base + OSPI_PSMAR);
+	ospi->fmode = CR_FMODE_APM;
+	ospi->status_timeout = timeout_ms;
+
+	ret = stm32_ospi_send(mem->spi, op);
+	mutex_unlock(&ospi->lock);
+
+	pm_runtime_mark_last_busy(ospi->dev);
+	pm_runtime_put_autosuspend(ospi->dev);
+
+	return ret;
+}
+
+static int stm32_ospi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	struct stm32_ospi *ospi = spi_controller_get_devdata(mem->spi->controller);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(ospi->dev);
+	if (ret < 0)
+		return ret;
+
+	mutex_lock(&ospi->lock);
+	if (op->data.dir == SPI_MEM_DATA_IN && op->data.nbytes)
+		ospi->fmode = CR_FMODE_INDR;
+	else
+		ospi->fmode = CR_FMODE_INDW;
+
+	ret = stm32_ospi_send(mem->spi, op);
+	mutex_unlock(&ospi->lock);
+
+	pm_runtime_mark_last_busy(ospi->dev);
+	pm_runtime_put_autosuspend(ospi->dev);
+
+	return ret;
+}
+
+static int stm32_ospi_dirmap_create(struct spi_mem_dirmap_desc *desc)
+{
+	struct stm32_ospi *ospi = spi_controller_get_devdata(desc->mem->spi->controller);
+
+	if (desc->info.op_tmpl.data.dir == SPI_MEM_DATA_OUT)
+		return -EOPNOTSUPP;
+
+	/* Should never happen, as mm_base == null is an error probe exit condition */
+	if (!ospi->mm_base && desc->info.op_tmpl.data.dir == SPI_MEM_DATA_IN)
+		return -EOPNOTSUPP;
+
+	if (!ospi->mm_size)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static ssize_t stm32_ospi_dirmap_read(struct spi_mem_dirmap_desc *desc,
+				      u64 offs, size_t len, void *buf)
+{
+	struct stm32_ospi *ospi = spi_controller_get_devdata(desc->mem->spi->controller);
+	struct spi_mem_op op;
+	u32 addr_max;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(ospi->dev);
+	if (ret < 0)
+		return ret;
+
+	mutex_lock(&ospi->lock);
+	/*
+	 * Make a local copy of desc op_tmpl and complete dirmap rdesc
+	 * spi_mem_op template with offs, len and *buf in  order to get
+	 * all needed transfer information into struct spi_mem_op
+	 */
+	memcpy(&op, &desc->info.op_tmpl, sizeof(struct spi_mem_op));
+	dev_dbg(ospi->dev, "%s len = 0x%zx offs = 0x%llx buf = 0x%p\n", __func__, len, offs, buf);
+
+	op.data.nbytes = len;
+	op.addr.val = desc->info.offset + offs;
+	op.data.buf.in = buf;
+
+	addr_max = op.addr.val + op.data.nbytes + 1;
+	if (addr_max < ospi->mm_size && op.addr.buswidth)
+		ospi->fmode = CR_FMODE_MM;
+	else
+		ospi->fmode = CR_FMODE_INDR;
+
+	ret = stm32_ospi_send(desc->mem->spi, &op);
+	mutex_unlock(&ospi->lock);
+
+	pm_runtime_mark_last_busy(ospi->dev);
+	pm_runtime_put_autosuspend(ospi->dev);
+
+	return ret ?: len;
+}
+
+static int stm32_ospi_transfer_one_message(struct spi_controller *ctrl,
+					   struct spi_message *msg)
+{
+	struct stm32_ospi *ospi = spi_controller_get_devdata(ctrl);
+	struct spi_transfer *transfer;
+	struct spi_device *spi = msg->spi;
+	struct spi_mem_op op;
+	struct gpio_desc *cs_gpiod = spi->cs_gpiod[ffs(spi->cs_index_mask) - 1];
+	int ret = 0;
+
+	if (!cs_gpiod)
+		return -EOPNOTSUPP;
+
+	ret = pm_runtime_resume_and_get(ospi->dev);
+	if (ret < 0)
+		return ret;
+
+	mutex_lock(&ospi->lock);
+
+	gpiod_set_value_cansleep(cs_gpiod, true);
+
+	list_for_each_entry(transfer, &msg->transfers, transfer_list) {
+		u8 dummy_bytes = 0;
+
+		memset(&op, 0, sizeof(op));
+
+		dev_dbg(ospi->dev, "tx_buf:%p tx_nbits:%d rx_buf:%p rx_nbits:%d len:%d dummy_data:%d\n",
+			transfer->tx_buf, transfer->tx_nbits,
+			transfer->rx_buf, transfer->rx_nbits,
+			transfer->len, transfer->dummy_data);
+
+		/*
+		 * OSPI hardware supports dummy bytes transfer.
+		 * If current transfer is dummy byte, merge it with the next
+		 * transfer in order to take into account OSPI block constraint
+		 */
+		if (transfer->dummy_data) {
+			op.dummy.buswidth = transfer->tx_nbits;
+			op.dummy.nbytes = transfer->len;
+			dummy_bytes = transfer->len;
+
+			/* If happens, means that message is not correctly built */
+			if (list_is_last(&transfer->transfer_list, &msg->transfers)) {
+				ret = -EINVAL;
+				goto end_of_transfer;
+			}
+
+			transfer = list_next_entry(transfer, transfer_list);
+		}
+
+		op.data.nbytes = transfer->len;
+
+		if (transfer->rx_buf) {
+			ospi->fmode = CR_FMODE_INDR;
+			op.data.buswidth = transfer->rx_nbits;
+			op.data.dir = SPI_MEM_DATA_IN;
+			op.data.buf.in = transfer->rx_buf;
+		} else {
+			ospi->fmode = CR_FMODE_INDW;
+			op.data.buswidth = transfer->tx_nbits;
+			op.data.dir = SPI_MEM_DATA_OUT;
+			op.data.buf.out = transfer->tx_buf;
+		}
+
+		ret = stm32_ospi_send(spi, &op);
+		if (ret)
+			goto end_of_transfer;
+
+		msg->actual_length += transfer->len + dummy_bytes;
+	}
+
+end_of_transfer:
+	gpiod_set_value_cansleep(cs_gpiod, false);
+
+	mutex_unlock(&ospi->lock);
+
+	msg->status = ret;
+	spi_finalize_current_message(ctrl);
+
+	pm_runtime_mark_last_busy(ospi->dev);
+	pm_runtime_put_autosuspend(ospi->dev);
+
+	return ret;
+}
+
+static int stm32_ospi_setup(struct spi_device *spi)
+{
+	struct spi_controller *ctrl = spi->controller;
+	struct stm32_ospi *ospi = spi_controller_get_devdata(ctrl);
+	void __iomem *regs_base = ospi->regs_base;
+	int ret;
+	u8 cs = spi->chip_select[ffs(spi->cs_index_mask) - 1];
+
+	if (ctrl->busy)
+		return -EBUSY;
+
+	if (!spi->max_speed_hz)
+		return -EINVAL;
+
+	ret = pm_runtime_resume_and_get(ospi->dev);
+	if (ret < 0)
+		return ret;
+
+	ospi->flash_presc[cs] = DIV_ROUND_UP(ospi->clk_rate, spi->max_speed_hz) - 1;
+
+	mutex_lock(&ospi->lock);
+
+	ospi->cr_reg = CR_APMS | 3 << CR_FTHRES_SHIFT | CR_EN;
+	writel_relaxed(ospi->cr_reg, regs_base + OSPI_CR);
+
+	/* set dcr fsize to max address */
+	ospi->dcr_reg = DCR1_DEVSIZE_MASK | DCR1_DLYBYP;
+	writel_relaxed(ospi->dcr_reg, regs_base + OSPI_DCR1);
+
+	mutex_unlock(&ospi->lock);
+
+	pm_runtime_mark_last_busy(ospi->dev);
+	pm_runtime_put_autosuspend(ospi->dev);
+
+	return 0;
+}
+
+/*
+ * No special host constraint, so use default spi_mem_default_supports_op
+ * to check supported mode.
+ */
+static const struct spi_controller_mem_ops stm32_ospi_mem_ops = {
+	.exec_op	= stm32_ospi_exec_op,
+	.dirmap_create	= stm32_ospi_dirmap_create,
+	.dirmap_read	= stm32_ospi_dirmap_read,
+	.poll_status	= stm32_ospi_poll_status,
+};
+
+static int stm32_ospi_get_resources(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct stm32_ospi *ospi = platform_get_drvdata(pdev);
+	struct resource *res;
+	struct reserved_mem *rmem = NULL;
+	struct device_node *node;
+	int ret;
+
+	ospi->regs_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(ospi->regs_base))
+		return PTR_ERR(ospi->regs_base);
+
+	ospi->regs_phys_base = res->start;
+
+	ospi->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(ospi->clk))
+		return dev_err_probe(dev, PTR_ERR(ospi->clk),
+				     "Can't get clock\n");
+
+	ospi->clk_rate = clk_get_rate(ospi->clk);
+	if (!ospi->clk_rate) {
+		dev_err(dev, "Invalid clock rate\n");
+		return -EINVAL;
+	}
+
+	ospi->irq = platform_get_irq(pdev, 0);
+	if (ospi->irq < 0) {
+		dev_err(dev, "Can't get irq %d\n", ospi->irq);
+		return ospi->irq;
+	}
+
+	ret = devm_request_irq(dev, ospi->irq, stm32_ospi_irq, 0,
+			       dev_name(dev), ospi);
+	if (ret) {
+		dev_err(dev, "Failed to request irq\n");
+		return ret;
+	}
+
+	ospi->rstc = devm_reset_control_array_get_optional_exclusive(dev);
+	if (IS_ERR(ospi->rstc))
+		return dev_err_probe(dev, PTR_ERR(ospi->rstc),
+				     "Can't get reset\n");
+
+	ospi->dma_chrx = dma_request_chan(dev, "rx");
+	if (IS_ERR(ospi->dma_chrx)) {
+		ret = PTR_ERR(ospi->dma_chrx);
+		ospi->dma_chrx = NULL;
+		if (ret == -EPROBE_DEFER)
+			goto err_dma;
+	}
+
+	ospi->dma_chtx = dma_request_chan(dev, "tx");
+	if (IS_ERR(ospi->dma_chtx)) {
+		ret = PTR_ERR(ospi->dma_chtx);
+		ospi->dma_chtx = NULL;
+		if (ret == -EPROBE_DEFER)
+			goto err_dma;
+	}
+
+	node = of_parse_phandle(dev->of_node, "memory-region", 0);
+	if (node)
+		rmem = of_reserved_mem_lookup(node);
+	of_node_put(node);
+
+	if (rmem) {
+		ospi->mm_size = rmem->size;
+		ospi->mm_base = devm_ioremap(dev, rmem->base, rmem->size);
+		if (IS_ERR(ospi->mm_base)) {
+			dev_err(dev, "unable to map memory region: %pa+%pa\n",
+				&rmem->base, &rmem->size);
+			ret = PTR_ERR(ospi->mm_base);
+			goto err_dma;
+		}
+
+		if (ospi->mm_size > STM32_OSPI_MAX_MMAP_SZ) {
+			dev_err(dev, "Memory map size outsize bounds\n");
+			ret = -EINVAL;
+			goto err_dma;
+		}
+	} else {
+		dev_info(dev, "No memory-map region found\n");
+	}
+
+	init_completion(&ospi->data_completion);
+	init_completion(&ospi->match_completion);
+
+	return 0;
+
+err_dma:
+	dev_info(dev, "Can't get all resources (%d)\n", ret);
+
+	if (ospi->dma_chtx)
+		dma_release_channel(ospi->dma_chtx);
+	if (ospi->dma_chrx)
+		dma_release_channel(ospi->dma_chrx);
+
+	return ret;
+};
+
+static int stm32_ospi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct spi_controller *ctrl;
+	struct stm32_ospi *ospi;
+	struct dma_slave_config dma_cfg;
+	struct device_node *child;
+	int ret;
+	u8 spi_flash_count = 0;
+
+	/*
+	 * Flash subnodes sanity check:
+	 *        1 or 2 spi-nand/spi-nor flashes		=> supported
+	 *	  All other flash node configuration		=> not supported
+	 */
+	for_each_available_child_of_node(dev->of_node, child) {
+		if (of_device_is_compatible(child, "jedec,spi-nor") ||
+		    of_device_is_compatible(child, "spi-nand"))
+			spi_flash_count++;
+	}
+
+	if (spi_flash_count == 0 || spi_flash_count > 2) {
+		dev_err(dev, "Incorrect DT flash node\n");
+		return -ENODEV;
+	}
+
+	ctrl = devm_spi_alloc_host(dev, sizeof(*ospi));
+	if (!ctrl)
+		return -ENOMEM;
+
+	ospi = spi_controller_get_devdata(ctrl);
+	ospi->ctrl = ctrl;
+
+	ospi->dev = &pdev->dev;
+	platform_set_drvdata(pdev, ospi);
+
+	ret = stm32_ospi_get_resources(pdev);
+	if (ret)
+		return ret;
+
+	memset(&dma_cfg, 0, sizeof(dma_cfg));
+	dma_cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dma_cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dma_cfg.src_addr = ospi->regs_phys_base + OSPI_DR;
+	dma_cfg.dst_addr = ospi->regs_phys_base + OSPI_DR;
+	dma_cfg.src_maxburst = 4;
+	dma_cfg.dst_maxburst = 4;
+	stm32_ospi_dma_setup(ospi, &dma_cfg);
+
+	mutex_init(&ospi->lock);
+
+	ctrl->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD |
+			  SPI_TX_DUAL | SPI_TX_QUAD |
+			  SPI_TX_OCTAL | SPI_RX_OCTAL;
+	ctrl->setup = stm32_ospi_setup;
+	ctrl->bus_num = -1;
+	ctrl->mem_ops = &stm32_ospi_mem_ops;
+	ctrl->use_gpio_descriptors = true;
+	ctrl->transfer_one_message = stm32_ospi_transfer_one_message;
+	ctrl->num_chipselect = STM32_OSPI_MAX_NORCHIP;
+	ctrl->dev.of_node = dev->of_node;
+
+	pm_runtime_enable(ospi->dev);
+	pm_runtime_set_autosuspend_delay(ospi->dev, STM32_AUTOSUSPEND_DELAY);
+	pm_runtime_use_autosuspend(ospi->dev);
+
+	ret = pm_runtime_resume_and_get(ospi->dev);
+	if (ret < 0)
+		goto err_pm_enable;
+
+	if (ospi->rstc) {
+		reset_control_assert(ospi->rstc);
+		udelay(2);
+		reset_control_deassert(ospi->rstc);
+	}
+
+	ret = spi_register_controller(ctrl);
+	if (ret) {
+		/* Disable ospi */
+		writel_relaxed(0, ospi->regs_base + OSPI_CR);
+		goto err_pm_resume;
+	}
+
+	pm_runtime_mark_last_busy(ospi->dev);
+	pm_runtime_put_autosuspend(ospi->dev);
+
+	return 0;
+
+err_pm_resume:
+	pm_runtime_put_sync_suspend(ospi->dev);
+
+err_pm_enable:
+	pm_runtime_force_suspend(ospi->dev);
+	mutex_destroy(&ospi->lock);
+
+	return ret;
+}
+
+static void stm32_ospi_remove(struct platform_device *pdev)
+{
+	struct stm32_ospi *ospi = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(ospi->dev);
+	if (ret < 0)
+		return;
+
+	spi_unregister_controller(ospi->ctrl);
+	/* Disable ospi */
+	writel_relaxed(0, ospi->regs_base + OSPI_CR);
+	mutex_destroy(&ospi->lock);
+
+	if (ospi->dma_chtx)
+		dma_release_channel(ospi->dma_chtx);
+	if (ospi->dma_chrx)
+		dma_release_channel(ospi->dma_chrx);
+
+	pm_runtime_put_sync_suspend(ospi->dev);
+	pm_runtime_force_suspend(ospi->dev);
+}
+
+static int __maybe_unused stm32_ospi_suspend(struct device *dev)
+{
+	struct stm32_ospi *ospi = dev_get_drvdata(dev);
+
+	pinctrl_pm_select_sleep_state(dev);
+
+	return pm_runtime_force_suspend(ospi->dev);
+}
+
+static int __maybe_unused stm32_ospi_resume(struct device *dev)
+{
+	struct stm32_ospi *ospi = dev_get_drvdata(dev);
+	void __iomem *regs_base = ospi->regs_base;
+	int ret;
+
+	ret = pm_runtime_force_resume(ospi->dev);
+	if (ret < 0)
+		return ret;
+
+	pinctrl_pm_select_default_state(dev);
+
+	ret = pm_runtime_resume_and_get(ospi->dev);
+	if (ret < 0)
+		return ret;
+
+	writel_relaxed(ospi->cr_reg, regs_base + OSPI_CR);
+	writel_relaxed(ospi->dcr_reg, regs_base + OSPI_DCR1);
+	pm_runtime_mark_last_busy(ospi->dev);
+	pm_runtime_put_autosuspend(ospi->dev);
+
+	return 0;
+}
+
+static int __maybe_unused stm32_ospi_runtime_suspend(struct device *dev)
+{
+	struct stm32_ospi *ospi = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(ospi->clk);
+
+	return 0;
+}
+
+static int __maybe_unused stm32_ospi_runtime_resume(struct device *dev)
+{
+	struct stm32_ospi *ospi = dev_get_drvdata(dev);
+
+	return clk_prepare_enable(ospi->clk);
+}
+
+static const struct dev_pm_ops stm32_ospi_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(stm32_ospi_suspend, stm32_ospi_resume)
+	SET_RUNTIME_PM_OPS(stm32_ospi_runtime_suspend,
+			   stm32_ospi_runtime_resume, NULL)
+};
+
+static const struct of_device_id stm32_ospi_of_match[] = {
+	{ .compatible = "st,stm32mp25-ospi" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, stm32_ospi_of_match);
+
+static struct platform_driver stm32_ospi_driver = {
+	.probe	= stm32_ospi_probe,
+	.remove	= stm32_ospi_remove,
+	.driver	= {
+		.name = "stm32-ospi",
+		.pm = &stm32_ospi_pm_ops,
+		.of_match_table = stm32_ospi_of_match,
+	},
+};
+module_platform_driver(stm32_ospi_driver);
+
+MODULE_DESCRIPTION("STMicroelectronics STM32 OCTO SPI driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1


