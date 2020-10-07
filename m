Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9ED0286BAF
	for <lists+linux-spi@lfdr.de>; Thu,  8 Oct 2020 01:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgJGXzs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 7 Oct 2020 19:55:48 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:45874 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbgJGXzj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 7 Oct 2020 19:55:39 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 1A6C78001644;
        Wed,  7 Oct 2020 23:55:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iB4HanI8IbFX; Thu,  8 Oct 2020 02:55:28 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        "wuxu . wu" <wuxu.wu@huawei.com>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 17/21] spi: dw: Add memory operations support
Date:   Thu, 8 Oct 2020 02:55:06 +0300
Message-ID: <20201007235511.4935-18-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20201007235511.4935-1-Sergey.Semin@baikalelectronics.ru>
References: <20201007235511.4935-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Aside from the synchronous Tx-Rx mode, which has been utilized to create
the normal SPI transfers in the framework of the DW SSI driver, DW SPI
controller supports Tx-only and EEPROM-read modes. The former one just
enables the controller to transmit all the data from the Tx FIFO ignoring
anything retrieved from the MISO lane. The later mode is so called
write-then-read operation: DW SPI controller first pushes out all the data
from the Tx FIFO, after that it'll automatically receive as much data as
has been specified by means of the CTRLR1 register. Both of those modes
can be used to implement the memory operations supported by the SPI-memory
subsystem.

The memory operation implementation is pretty much straightforward, except
a few peculiarities we have had to take into account to make things
working. Since DW SPI controller doesn't provide a way to directly set and
clear the native CS lane level, but instead automatically de-asserts it
when a transfer going on, we have to make sure the Tx FIFO isn't empty
during entire Tx procedure. In addition we also need to read data from the
Rx FIFO as fast as possible to prevent it' overflow with automatically
fetched incoming traffic. The denoted peculiarities get to cause even more
problems if DW SSI controller is equipped with relatively small FIFO and
is connected to a relatively slow system bus (APB) (with respect to the
SPI bus speed). In order to workaround the problems for as much as it's
possible, the memory operation execution procedure collects all the Tx
data into a single buffer and disables the local IRQs to speed the
write-then-optionally-read method up.

Note the provided memory operations are utilized by default only if
a glue driver hasn't provided a custom version of ones and this is not
a DW APB SSI controller with fixed automatic CS toggle functionality.

Co-developed-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Signed-off-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/Kconfig       |   1 +
 drivers/spi/spi-dw-core.c | 301 ++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-dw.h      |  13 ++
 3 files changed, 315 insertions(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index c6ea760ea5f0..1f70bb1e7fa9 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -235,6 +235,7 @@ config SPI_DAVINCI
 
 config SPI_DESIGNWARE
 	tristate "DesignWare SPI controller core support"
+	imply SPI_MEM
 	help
 	  general driver for SPI controller core from DesignWare
 
diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 8480da49a6a1..8eb3b31b376d 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -8,10 +8,13 @@
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/preempt.h>
 #include <linux/highmem.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
+#include <linux/string.h>
 #include <linux/of.h>
 
 #include "spi-dw.h"
@@ -422,6 +425,301 @@ static void dw_spi_handle_err(struct spi_controller *master,
 	spi_reset_chip(dws);
 }
 
+static int dw_spi_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *op)
+{
+	if (op->data.dir == SPI_MEM_DATA_IN)
+		op->data.nbytes = clamp_val(op->data.nbytes, 0, SPI_NDF_MASK + 1);
+
+	return 0;
+}
+
+static bool dw_spi_supports_mem_op(struct spi_mem *mem,
+				   const struct spi_mem_op *op)
+{
+	if (op->data.buswidth > 1 || op->addr.buswidth > 1 ||
+	    op->dummy.buswidth > 1 || op->cmd.buswidth > 1)
+		return false;
+
+	return spi_mem_default_supports_op(mem, op);
+}
+
+static int dw_spi_init_mem_buf(struct dw_spi *dws, const struct spi_mem_op *op)
+{
+	unsigned int i, j, len;
+	u8 *out;
+
+	/*
+	 * Calculate the total length of the EEPROM command transfer and
+	 * either use the pre-allocated buffer or create a temporary one.
+	 */
+	len = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;
+	if (op->data.dir == SPI_MEM_DATA_OUT)
+		len += op->data.nbytes;
+
+	if (len <= SPI_BUF_SIZE) {
+		out = dws->buf;
+	} else {
+		out = kzalloc(len, GFP_KERNEL);
+		if (!out)
+			return -ENOMEM;
+	}
+
+	/*
+	 * Collect the operation code, address and dummy bytes into the single
+	 * buffer. If it's a transfer with data to be sent, also copy it into the
+	 * single buffer in order to speed the data transmission up.
+	 */
+	for (i = 0; i < op->cmd.nbytes; ++i)
+		out[i] = SPI_GET_BYTE(op->cmd.opcode, op->cmd.nbytes - i - 1);
+	for (j = 0; j < op->addr.nbytes; ++i, ++j)
+		out[i] = SPI_GET_BYTE(op->addr.val, op->addr.nbytes - j - 1);
+	for (j = 0; j < op->dummy.nbytes; ++i, ++j)
+		out[i] = 0x0;
+
+	if (op->data.dir == SPI_MEM_DATA_OUT)
+		memcpy(&out[i], op->data.buf.out, op->data.nbytes);
+
+	dws->n_bytes = 1;
+	dws->tx = out;
+	dws->tx_len = len;
+	if (op->data.dir == SPI_MEM_DATA_IN) {
+		dws->rx = op->data.buf.in;
+		dws->rx_len = op->data.nbytes;
+	} else {
+		dws->rx = NULL;
+		dws->rx_len = 0;
+	}
+
+	return 0;
+}
+
+static void dw_spi_free_mem_buf(struct dw_spi *dws)
+{
+	if (dws->tx != dws->buf)
+		kfree(dws->tx);
+}
+
+static int dw_spi_write_then_read(struct dw_spi *dws, struct spi_device *spi)
+{
+	u32 room, entries, sts;
+	unsigned int len;
+	u8 *buf;
+
+	/*
+	 * At initial stage we just pre-fill the Tx FIFO in with no rush,
+	 * since native CS hasn't been enabled yet and the automatic data
+	 * transmission won't start til we do that.
+	 */
+	len = min(dws->fifo_len, dws->tx_len);
+	buf = dws->tx;
+	while (len--)
+		dw_write_io_reg(dws, DW_SPI_DR, *buf++);
+
+	/*
+	 * After setting any bit in the SER register the transmission will
+	 * start automatically. We have to keep up with that procedure
+	 * otherwise the CS de-assertion will happen whereupon the memory
+	 * operation will be pre-terminated.
+	 */
+	len = dws->tx_len - ((void *)buf - dws->tx);
+	dw_spi_set_cs(spi, false);
+	while (len) {
+		entries = readl_relaxed(dws->regs + DW_SPI_TXFLR);
+		if (!entries) {
+			dev_err(&dws->master->dev, "CS de-assertion on Tx\n");
+			return -EIO;
+		}
+		room = min(dws->fifo_len - entries, len);
+		for (; room; --room, --len)
+			dw_write_io_reg(dws, DW_SPI_DR, *buf++);
+	}
+
+	/*
+	 * Data fetching will start automatically if the EEPROM-read mode is
+	 * activated. We have to keep up with the incoming data pace to
+	 * prevent the Rx FIFO overflow causing the inbound data loss.
+	 */
+	len = dws->rx_len;
+	buf = dws->rx;
+	while (len) {
+		entries = readl_relaxed(dws->regs + DW_SPI_RXFLR);
+		if (!entries) {
+			sts = readl_relaxed(dws->regs + DW_SPI_RISR);
+			if (sts & SPI_INT_RXOI) {
+				dev_err(&dws->master->dev, "FIFO overflow on Rx\n");
+				return -EIO;
+			}
+			continue;
+		}
+		entries = min(entries, len);
+		for (; entries; --entries, --len)
+			*buf++ = dw_read_io_reg(dws, DW_SPI_DR);
+	}
+
+	return 0;
+}
+
+static inline bool dw_spi_ctlr_busy(struct dw_spi *dws)
+{
+	return dw_readl(dws, DW_SPI_SR) & SR_BUSY;
+}
+
+static int dw_spi_wait_mem_op_done(struct dw_spi *dws)
+{
+	int retry = SPI_WAIT_RETRIES;
+	struct spi_delay delay;
+	unsigned long ns, us;
+	u32 nents;
+
+	nents = dw_readl(dws, DW_SPI_TXFLR);
+	ns = NSEC_PER_SEC / dws->current_freq * nents;
+	ns *= dws->n_bytes * BITS_PER_BYTE;
+	if (ns <= NSEC_PER_USEC) {
+		delay.unit = SPI_DELAY_UNIT_NSECS;
+		delay.value = ns;
+	} else {
+		us = DIV_ROUND_UP(ns, NSEC_PER_USEC);
+		delay.unit = SPI_DELAY_UNIT_USECS;
+		delay.value = clamp_val(us, 0, USHRT_MAX);
+	}
+
+	while (dw_spi_ctlr_busy(dws) && retry--)
+		spi_delay_exec(&delay, NULL);
+
+	if (retry < 0) {
+		dev_err(&dws->master->dev, "Mem op hanged up\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static void dw_spi_stop_mem_op(struct dw_spi *dws, struct spi_device *spi)
+{
+	spi_enable_chip(dws, 0);
+	dw_spi_set_cs(spi, true);
+	spi_enable_chip(dws, 1);
+}
+
+/*
+ * The SPI memory operation implementation below is the best choice for the
+ * devices, which are selected by the native chip-select lane. It's
+ * specifically developed to workaround the problem with automatic chip-select
+ * lane toggle when there is no data in the Tx FIFO buffer. Luckily the current
+ * SPI-mem core calls exec_op() callback only if the GPIO-based CS is
+ * unavailable.
+ */
+static int dw_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	struct dw_spi *dws = spi_controller_get_devdata(mem->spi->controller);
+	struct dw_spi_cfg cfg;
+	unsigned long flags;
+	int ret;
+
+	/*
+	 * Collect the outbound data into a single buffer to speed the
+	 * transmission up at least on the initial stage.
+	 */
+	ret = dw_spi_init_mem_buf(dws, op);
+	if (ret)
+		return ret;
+
+	/*
+	 * DW SPI EEPROM-read mode is required only for the SPI memory Data-IN
+	 * operation. Transmit-only mode is suitable for the rest of them.
+	 */
+	cfg.dfs = 8;
+	cfg.freq = mem->spi->max_speed_hz;
+	if (op->data.dir == SPI_MEM_DATA_IN) {
+		cfg.tmode = SPI_TMOD_EPROMREAD;
+		cfg.ndf = op->data.nbytes;
+	} else {
+		cfg.tmode = SPI_TMOD_TO;
+	}
+
+	spi_enable_chip(dws, 0);
+
+	dw_spi_update_config(dws, mem->spi, &cfg);
+
+	spi_mask_intr(dws, 0xff);
+
+	spi_enable_chip(dws, 1);
+
+	/*
+	 * DW APB SSI controller has very nasty peculiarities. First originally
+	 * (without any vendor-specific modifications) it doesn't provide a
+	 * direct way to set and clear the native chip-select signal. Instead
+	 * the controller asserts the CS lane if Tx FIFO isn't empty and a
+	 * transmission is going on, and automatically de-asserts it back to
+	 * the high level if the Tx FIFO doesn't have anything to be pushed
+	 * out. Due to that a multi-tasking or heavy IRQs activity might be
+	 * fatal, since the transfer procedure preemption may cause the Tx FIFO
+	 * getting empty and sudden CS de-assertion, which in the middle of the
+	 * transfer will most likely cause the data loss. Secondly the
+	 * EEPROM-read or Read-only DW SPI transfer modes imply the incoming
+	 * data being automatically pulled in into the Rx FIFO. So if the
+	 * driver software is late in fetching the data from the FIFO before
+	 * it's overflown, new incoming data will be lost. In order to make
+	 * sure the executed memory operations are CS-atomic and to prevent the
+	 * Rx FIFO overflow we have to disable the local interrupts so to block
+	 * any preemption during the subsequent IO operations.
+	 *
+	 * Note. At some circumstances disabling IRQs may not help to prevent
+	 * the problems described above. The CS de-assertion and Rx FIFO
+	 * overflow may still happen due to the relatively slow system bus or
+	 * CPU not working fast enough, so the write-then-read algo implemented
+	 * here just won't keep up with the SPI bus data transfer. Such
+	 * situation is highly platform specific and is supposed to be fixed by
+	 * manually restricting the SPI bus frequency using the
+	 * dws->max_mem_freq parameter.
+	 */
+	local_irq_save(flags);
+	preempt_disable();
+
+	ret = dw_spi_write_then_read(dws, mem->spi);
+
+	local_irq_restore(flags);
+	preempt_enable();
+
+	/*
+	 * Wait for the operation being finished and check the controller
+	 * status only if there hasn't been any run-time error detected. In the
+	 * former case it's just pointless. In the later one to prevent an
+	 * additional error message printing since any hw error flag being set
+	 * would be due to an error detected on the data transfer.
+	 */
+	if (!ret) {
+		ret = dw_spi_wait_mem_op_done(dws);
+		if (!ret)
+			ret = dw_spi_check_status(dws, true);
+	}
+
+	dw_spi_stop_mem_op(dws, mem->spi);
+
+	dw_spi_free_mem_buf(dws);
+
+	return ret;
+}
+
+/*
+ * Initialize the default memory operations if a glue layer hasn't specified
+ * custom ones. Direct mapping operations will be preserved anyway since DW SPI
+ * controller doesn't have an embedded dirmap interface. Note the memory
+ * operations implemented in this driver is the best choice only for the DW APB
+ * SSI controller with standard native CS functionality. If a hardware vendor
+ * has fixed the automatic CS assertion/de-assertion peculiarity, then it will
+ * be safer to use the normal SPI-messages-based transfers implementation.
+ */
+static void dw_spi_init_mem_ops(struct dw_spi *dws)
+{
+	if (!dws->mem_ops.exec_op && !(dws->caps & DW_SPI_CAP_CS_OVERRIDE) &&
+	    !dws->set_cs) {
+		dws->mem_ops.adjust_op_size = dw_spi_adjust_mem_op_size;
+		dws->mem_ops.supports_op = dw_spi_supports_mem_op;
+		dws->mem_ops.exec_op = dw_spi_exec_mem_op;
+	}
+}
+
 /* This may be called twice for each spi dev */
 static int dw_spi_setup(struct spi_device *spi)
 {
@@ -522,6 +820,8 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 		goto err_free_master;
 	}
 
+	dw_spi_init_mem_ops(dws);
+
 	master->use_gpio_descriptors = true;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
 	master->bits_per_word_mask =  SPI_BPW_RANGE_MASK(4, 16);
@@ -535,6 +835,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 		master->set_cs = dw_spi_set_cs;
 	master->transfer_one = dw_spi_transfer_one;
 	master->handle_err = dw_spi_handle_err;
+	master->mem_ops = &dws->mem_ops;
 	master->max_speed_hz = dws->max_freq;
 	master->dev.of_node = dev->of_node;
 	master->dev.fwnode = dev->fwnode;
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 5eb98ece2f2a..4b08fe34a85d 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -8,6 +8,7 @@
 #include <linux/irqreturn.h>
 #include <linux/io.h>
 #include <linux/scatterlist.h>
+#include <linux/spi/spi-mem.h>
 
 /* Register offsets */
 #define DW_SPI_CTRLR0			0x00
@@ -78,6 +79,9 @@
  */
 #define DWC_SSI_CTRLR0_KEEMBAY_MST	BIT(31)
 
+/* Bit fields in CTRLR1 */
+#define SPI_NDF_MASK			GENMASK(15, 0)
+
 /* Bit fields in SR, 7 bits */
 #define SR_MASK				0x7f		/* cover 7 bits */
 #define SR_BUSY				(1 << 0)
@@ -101,6 +105,11 @@
 #define SPI_DMA_TDMAE			(1 << 1)
 
 #define SPI_WAIT_RETRIES		5
+#define SPI_BUF_SIZE \
+	(sizeof_field(struct spi_mem_op, cmd.opcode) + \
+	 sizeof_field(struct spi_mem_op, addr.val) + 256)
+#define SPI_GET_BYTE(_val, _idx) \
+	((_val) >> (BITS_PER_BYTE * (_idx)) & 0xff)
 
 enum dw_ssi_type {
 	SSI_MOTO_SPI = 0,
@@ -153,6 +162,7 @@ struct dw_spi {
 	unsigned int		tx_len;
 	void			*rx;
 	unsigned int		rx_len;
+	u8			buf[SPI_BUF_SIZE];
 	int			dma_mapped;
 	u8			n_bytes;	/* current is a 1/2 bytes op */
 	irqreturn_t		(*transfer_handler)(struct dw_spi *dws);
@@ -160,6 +170,9 @@ struct dw_spi {
 	u32			cur_rx_sample_dly;
 	u32			def_rx_sample_dly_ns;
 
+	/* Custom memory operations */
+	struct spi_controller_mem_ops mem_ops;
+
 	/* DMA info */
 	struct dma_chan		*txchan;
 	u32			txburst;
-- 
2.27.0

