Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660DD44FC3A
	for <lists+linux-spi@lfdr.de>; Sun, 14 Nov 2021 23:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbhKNWdg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 14 Nov 2021 17:33:36 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:35912 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbhKNWdf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 14 Nov 2021 17:33:35 -0500
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
Authentication-Results: mail.baikalelectronics.ru; dkim=permerror (bad message/signature format)
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nandhini Srikandan <nandhini.srikandan@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/6] spi: dw: Put the driver entities naming in order
Date:   Mon, 15 Nov 2021 01:30:23 +0300
Message-ID: <20211114223026.13359-4-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20211114223026.13359-1-Sergey.Semin@baikalelectronics.ru>
References: <20211114223026.13359-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Mostly due to a long driver history it's methods and macro names look a
bit messy. In particularly that concerns the code their prefixes. A
biggest part of the driver functions and macros have got the dw_spi/DW_SPI
prefixes. But there are some entities which have been just
"spi_/SPI_"-prefixed. Especially that concerns the CSR and their fields
macro definitions. It makes the code harder to comprehend since such
methods and macros can be easily confused with the global SPI-subsystem
exports. In this case the only possible way to more or less quickly
distinguish one naming space from another is either by context or by the
argument type, which most of the times isn't that easy anyway. In addition
to that a new DW SSI IP-core support has been added in the framework of
commit e539f435cb9c ("spi: dw: Add support for DesignWare DWC_ssi"), which
introduced a new set or macro-prefixes to describe CTRLR0-specific fields
and worsen the situation. Finally there are methods with
no DW SPI driver-reference prefix at all, that make the code reading even
harder. So in order to ease the driver hacking let's bring the code naming
to a common base:
1) Each method is supposed to have "dw_spi_" prefix so to be easily
distinguished from the kernel API, e.g. SPI-subsystem methods and macros.
(Exception is the local implementation of the readl/writel methods since
being just the regspace accessors.)
2) Each generically used macro should have DW_SPI_-prefix thus being
easily comprehended as the local driver definition.
3) DW APB SSI and DW SSI specific macros should have prefixes as DW_PSSI_
and DW_HSSI_ respectively so referring to the system buses they support
(APB and AHB similarly to the DT clocks naming like pclk, hclk).

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

---

Folks, any ideas of a better naming scheme especially for the DW APB SSI
and DW SSI specific macros are very welcome.

Changelog v2:
- Replace "assi" suffixes with "pssi" in the spi-dw-mmio.c methods.
  (Thanks Andy for noticing this pity mistake)
---
 drivers/spi/spi-dw-bt1.c  |   8 +--
 drivers/spi/spi-dw-core.c | 138 ++++++++++++++++++------------------
 drivers/spi/spi-dw-dma.c  |  50 ++++++-------
 drivers/spi/spi-dw-mmio.c |  20 +++---
 drivers/spi/spi-dw-pci.c  |  59 ++++++++--------
 drivers/spi/spi-dw.h      | 145 +++++++++++++++++++-------------------
 6 files changed, 211 insertions(+), 209 deletions(-)

diff --git a/drivers/spi/spi-dw-bt1.c b/drivers/spi/spi-dw-bt1.c
index ac7e4f30d1da..c06553416123 100644
--- a/drivers/spi/spi-dw-bt1.c
+++ b/drivers/spi/spi-dw-bt1.c
@@ -123,7 +123,7 @@ static ssize_t dw_spi_bt1_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	len = min_t(size_t, len, dwsbt1->map_len - offs);
 
 	/* Collect the controller configuration required by the operation */
-	cfg.tmode = SPI_TMOD_EPROMREAD;
+	cfg.tmode = DW_SPI_CTRLR0_TMOD_EPROMREAD;
 	cfg.dfs = 8;
 	cfg.ndf = 4;
 	cfg.freq = mem->spi->max_speed_hz;
@@ -131,13 +131,13 @@ static ssize_t dw_spi_bt1_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	/* Make sure the corresponding CS is de-asserted on transmission */
 	dw_spi_set_cs(mem->spi, false);
 
-	spi_enable_chip(dws, 0);
+	dw_spi_enable_chip(dws, 0);
 
 	dw_spi_update_config(dws, mem->spi, &cfg);
 
-	spi_umask_intr(dws, SPI_INT_RXFI);
+	dw_spi_umask_intr(dws, DW_SPI_INT_RXFI);
 
-	spi_enable_chip(dws, 1);
+	dw_spi_enable_chip(dws, 1);
 
 	/*
 	 * Enable the transparent mode of the System Boot Controller.
diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index da6100fd185f..57bbffe6d6f9 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -24,7 +24,7 @@
 #endif
 
 /* Slave spi_device related */
-struct chip_data {
+struct dw_spi_chip_data {
 	u32 cr0;
 	u32 rx_sample_dly;	/* RX sample delay */
 };
@@ -109,7 +109,7 @@ void dw_spi_set_cs(struct spi_device *spi, bool enable)
 EXPORT_SYMBOL_NS_GPL(dw_spi_set_cs, SPI_DW_CORE);
 
 /* Return the max entries we can fill into tx fifo */
-static inline u32 tx_max(struct dw_spi *dws)
+static inline u32 dw_spi_tx_max(struct dw_spi *dws)
 {
 	u32 tx_room, rxtx_gap;
 
@@ -129,14 +129,14 @@ static inline u32 tx_max(struct dw_spi *dws)
 }
 
 /* Return the max entries we should read out of rx fifo */
-static inline u32 rx_max(struct dw_spi *dws)
+static inline u32 dw_spi_rx_max(struct dw_spi *dws)
 {
 	return min_t(u32, dws->rx_len, dw_readl(dws, DW_SPI_RXFLR));
 }
 
 static void dw_writer(struct dw_spi *dws)
 {
-	u32 max = tx_max(dws);
+	u32 max = dw_spi_tx_max(dws);
 	u32 txw = 0;
 
 	while (max--) {
@@ -157,7 +157,7 @@ static void dw_writer(struct dw_spi *dws)
 
 static void dw_reader(struct dw_spi *dws)
 {
-	u32 max = rx_max(dws);
+	u32 max = dw_spi_rx_max(dws);
 	u32 rxw;
 
 	while (max--) {
@@ -186,24 +186,24 @@ int dw_spi_check_status(struct dw_spi *dws, bool raw)
 	else
 		irq_status = dw_readl(dws, DW_SPI_ISR);
 
-	if (irq_status & SPI_INT_RXOI) {
+	if (irq_status & DW_SPI_INT_RXOI) {
 		dev_err(&dws->master->dev, "RX FIFO overflow detected\n");
 		ret = -EIO;
 	}
 
-	if (irq_status & SPI_INT_RXUI) {
+	if (irq_status & DW_SPI_INT_RXUI) {
 		dev_err(&dws->master->dev, "RX FIFO underflow detected\n");
 		ret = -EIO;
 	}
 
-	if (irq_status & SPI_INT_TXOI) {
+	if (irq_status & DW_SPI_INT_TXOI) {
 		dev_err(&dws->master->dev, "TX FIFO overflow detected\n");
 		ret = -EIO;
 	}
 
 	/* Generically handle the erroneous situation */
 	if (ret) {
-		spi_reset_chip(dws);
+		dw_spi_reset_chip(dws);
 		if (dws->master->cur_msg)
 			dws->master->cur_msg->status = ret;
 	}
@@ -230,7 +230,7 @@ static irqreturn_t dw_spi_transfer_handler(struct dw_spi *dws)
 	 */
 	dw_reader(dws);
 	if (!dws->rx_len) {
-		spi_mask_intr(dws, 0xff);
+		dw_spi_mask_intr(dws, 0xff);
 		spi_finalize_current_transfer(dws->master);
 	} else if (dws->rx_len <= dw_readl(dws, DW_SPI_RXFTLR)) {
 		dw_writel(dws, DW_SPI_RXFTLR, dws->rx_len - 1);
@@ -241,10 +241,10 @@ static irqreturn_t dw_spi_transfer_handler(struct dw_spi *dws)
 	 * disabled after the data transmission is finished so not to
 	 * have the TXE IRQ flood at the final stage of the transfer.
 	 */
-	if (irq_status & SPI_INT_TXEI) {
+	if (irq_status & DW_SPI_INT_TXEI) {
 		dw_writer(dws);
 		if (!dws->tx_len)
-			spi_mask_intr(dws, SPI_INT_TXEI);
+			dw_spi_mask_intr(dws, DW_SPI_INT_TXEI);
 	}
 
 	return IRQ_HANDLED;
@@ -260,7 +260,7 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	if (!master->cur_msg) {
-		spi_mask_intr(dws, 0xff);
+		dw_spi_mask_intr(dws, 0xff);
 		return IRQ_HANDLED;
 	}
 
@@ -271,37 +271,37 @@ static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device *spi)
 {
 	u32 cr0 = 0;
 
-	if (!(dws->caps & DW_SPI_CAP_DWC_SSI)) {
+	if (!(dws->caps & DW_SPI_CAP_DWC_HSSI)) {
 		/* CTRLR0[ 5: 4] Frame Format */
-		cr0 |= SPI_FRF_MOTO_SPI << SPI_FRF_OFFSET;
+		cr0 |= DW_SPI_CTRLR0_FRF_MOTO_SPI << DW_PSSI_CTRLR0_FRF_OFFSET;
 
 		/*
 		 * SPI mode (SCPOL|SCPH)
 		 * CTRLR0[ 6] Serial Clock Phase
 		 * CTRLR0[ 7] Serial Clock Polarity
 		 */
-		cr0 |= ((spi->mode & SPI_CPOL) ? 1 : 0) << SPI_SCOL_OFFSET;
-		cr0 |= ((spi->mode & SPI_CPHA) ? 1 : 0) << SPI_SCPH_OFFSET;
+		cr0 |= ((spi->mode & SPI_CPOL) ? 1 : 0) << DW_PSSI_CTRLR0_SCOL_OFFSET;
+		cr0 |= ((spi->mode & SPI_CPHA) ? 1 : 0) << DW_PSSI_CTRLR0_SCPH_OFFSET;
 
 		/* CTRLR0[11] Shift Register Loop */
-		cr0 |= ((spi->mode & SPI_LOOP) ? 1 : 0) << SPI_SRL_OFFSET;
+		cr0 |= ((spi->mode & SPI_LOOP) ? 1 : 0) << DW_PSSI_CTRLR0_SRL_OFFSET;
 	} else {
 		/* CTRLR0[ 7: 6] Frame Format */
-		cr0 |= SPI_FRF_MOTO_SPI << DWC_SSI_CTRLR0_FRF_OFFSET;
+		cr0 |= DW_SPI_CTRLR0_FRF_MOTO_SPI << DW_HSSI_CTRLR0_FRF_OFFSET;
 
 		/*
 		 * SPI mode (SCPOL|SCPH)
 		 * CTRLR0[ 8] Serial Clock Phase
 		 * CTRLR0[ 9] Serial Clock Polarity
 		 */
-		cr0 |= ((spi->mode & SPI_CPOL) ? 1 : 0) << DWC_SSI_CTRLR0_SCPOL_OFFSET;
-		cr0 |= ((spi->mode & SPI_CPHA) ? 1 : 0) << DWC_SSI_CTRLR0_SCPH_OFFSET;
+		cr0 |= ((spi->mode & SPI_CPOL) ? 1 : 0) << DW_HSSI_CTRLR0_SCPOL_OFFSET;
+		cr0 |= ((spi->mode & SPI_CPHA) ? 1 : 0) << DW_HSSI_CTRLR0_SCPH_OFFSET;
 
 		/* CTRLR0[13] Shift Register Loop */
-		cr0 |= ((spi->mode & SPI_LOOP) ? 1 : 0) << DWC_SSI_CTRLR0_SRL_OFFSET;
+		cr0 |= ((spi->mode & SPI_LOOP) ? 1 : 0) << DW_HSSI_CTRLR0_SRL_OFFSET;
 
 		if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
-			cr0 |= DWC_SSI_CTRLR0_KEEMBAY_MST;
+			cr0 |= DW_HSSI_CTRLR0_KEEMBAY_MST;
 	}
 
 	return cr0;
@@ -310,7 +310,7 @@ static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device *spi)
 void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
 			  struct dw_spi_cfg *cfg)
 {
-	struct chip_data *chip = spi_get_ctldata(spi);
+	struct dw_spi_chip_data *chip = spi_get_ctldata(spi);
 	u32 cr0 = chip->cr0;
 	u32 speed_hz;
 	u16 clk_div;
@@ -318,16 +318,17 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
 	/* CTRLR0[ 4/3: 0] or CTRLR0[ 20: 16] Data Frame Size */
 	cr0 |= (cfg->dfs - 1) << dws->dfs_offset;
 
-	if (!(dws->caps & DW_SPI_CAP_DWC_SSI))
+	if (!(dws->caps & DW_SPI_CAP_DWC_HSSI))
 		/* CTRLR0[ 9:8] Transfer Mode */
-		cr0 |= cfg->tmode << SPI_TMOD_OFFSET;
+		cr0 |= cfg->tmode << DW_PSSI_CTRLR0_TMOD_OFFSET;
 	else
 		/* CTRLR0[11:10] Transfer Mode */
-		cr0 |= cfg->tmode << DWC_SSI_CTRLR0_TMOD_OFFSET;
+		cr0 |= cfg->tmode << DW_HSSI_CTRLR0_TMOD_OFFSET;
 
 	dw_writel(dws, DW_SPI_CTRLR0, cr0);
 
-	if (cfg->tmode == SPI_TMOD_EPROMREAD || cfg->tmode == SPI_TMOD_RO)
+	if (cfg->tmode == DW_SPI_CTRLR0_TMOD_EPROMREAD ||
+	    cfg->tmode == DW_SPI_CTRLR0_TMOD_RO)
 		dw_writel(dws, DW_SPI_CTRLR1, cfg->ndf ? cfg->ndf - 1 : 0);
 
 	/* Note DW APB SSI clock divider doesn't support odd numbers */
@@ -335,7 +336,7 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
 	speed_hz = dws->max_freq / clk_div;
 
 	if (dws->current_freq != speed_hz) {
-		spi_set_clk(dws, clk_div);
+		dw_spi_set_clk(dws, clk_div);
 		dws->current_freq = speed_hz;
 	}
 
@@ -363,9 +364,9 @@ static void dw_spi_irq_setup(struct dw_spi *dws)
 
 	dws->transfer_handler = dw_spi_transfer_handler;
 
-	imask = SPI_INT_TXEI | SPI_INT_TXOI | SPI_INT_RXUI | SPI_INT_RXOI |
-		SPI_INT_RXFI;
-	spi_umask_intr(dws, imask);
+	imask = DW_SPI_INT_TXEI | DW_SPI_INT_TXOI |
+		DW_SPI_INT_RXUI | DW_SPI_INT_RXOI | DW_SPI_INT_RXFI;
+	dw_spi_umask_intr(dws, imask);
 }
 
 /*
@@ -405,11 +406,12 @@ static int dw_spi_poll_transfer(struct dw_spi *dws,
 }
 
 static int dw_spi_transfer_one(struct spi_controller *master,
-		struct spi_device *spi, struct spi_transfer *transfer)
+			       struct spi_device *spi,
+			       struct spi_transfer *transfer)
 {
 	struct dw_spi *dws = spi_controller_get_devdata(master);
 	struct dw_spi_cfg cfg = {
-		.tmode = SPI_TMOD_TR,
+		.tmode = DW_SPI_CTRLR0_TMOD_TR,
 		.dfs = transfer->bits_per_word,
 		.freq = transfer->speed_hz,
 	};
@@ -425,7 +427,7 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 	/* Ensure the data above is visible for all CPUs */
 	smp_mb();
 
-	spi_enable_chip(dws, 0);
+	dw_spi_enable_chip(dws, 0);
 
 	dw_spi_update_config(dws, spi, &cfg);
 
@@ -436,7 +438,7 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 		dws->dma_mapped = master->cur_msg_mapped;
 
 	/* For poll mode just disable all interrupts */
-	spi_mask_intr(dws, 0xff);
+	dw_spi_mask_intr(dws, 0xff);
 
 	if (dws->dma_mapped) {
 		ret = dws->dma_ops->dma_setup(dws, transfer);
@@ -444,7 +446,7 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 			return ret;
 	}
 
-	spi_enable_chip(dws, 1);
+	dw_spi_enable_chip(dws, 1);
 
 	if (dws->dma_mapped)
 		return dws->dma_ops->dma_transfer(dws, transfer);
@@ -457,20 +459,20 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 }
 
 static void dw_spi_handle_err(struct spi_controller *master,
-		struct spi_message *msg)
+			      struct spi_message *msg)
 {
 	struct dw_spi *dws = spi_controller_get_devdata(master);
 
 	if (dws->dma_mapped)
 		dws->dma_ops->dma_stop(dws);
 
-	spi_reset_chip(dws);
+	dw_spi_reset_chip(dws);
 }
 
 static int dw_spi_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
 	if (op->data.dir == SPI_MEM_DATA_IN)
-		op->data.nbytes = clamp_val(op->data.nbytes, 0, SPI_NDF_MASK + 1);
+		op->data.nbytes = clamp_val(op->data.nbytes, 0, DW_SPI_NDF_MASK + 1);
 
 	return 0;
 }
@@ -498,7 +500,7 @@ static int dw_spi_init_mem_buf(struct dw_spi *dws, const struct spi_mem_op *op)
 	if (op->data.dir == SPI_MEM_DATA_OUT)
 		len += op->data.nbytes;
 
-	if (len <= SPI_BUF_SIZE) {
+	if (len <= DW_SPI_BUF_SIZE) {
 		out = dws->buf;
 	} else {
 		out = kzalloc(len, GFP_KERNEL);
@@ -512,9 +514,9 @@ static int dw_spi_init_mem_buf(struct dw_spi *dws, const struct spi_mem_op *op)
 	 * single buffer in order to speed the data transmission up.
 	 */
 	for (i = 0; i < op->cmd.nbytes; ++i)
-		out[i] = SPI_GET_BYTE(op->cmd.opcode, op->cmd.nbytes - i - 1);
+		out[i] = DW_SPI_GET_BYTE(op->cmd.opcode, op->cmd.nbytes - i - 1);
 	for (j = 0; j < op->addr.nbytes; ++i, ++j)
-		out[i] = SPI_GET_BYTE(op->addr.val, op->addr.nbytes - j - 1);
+		out[i] = DW_SPI_GET_BYTE(op->addr.val, op->addr.nbytes - j - 1);
 	for (j = 0; j < op->dummy.nbytes; ++i, ++j)
 		out[i] = 0x0;
 
@@ -587,7 +589,7 @@ static int dw_spi_write_then_read(struct dw_spi *dws, struct spi_device *spi)
 		entries = readl_relaxed(dws->regs + DW_SPI_RXFLR);
 		if (!entries) {
 			sts = readl_relaxed(dws->regs + DW_SPI_RISR);
-			if (sts & SPI_INT_RXOI) {
+			if (sts & DW_SPI_INT_RXOI) {
 				dev_err(&dws->master->dev, "FIFO overflow on Rx\n");
 				return -EIO;
 			}
@@ -603,12 +605,12 @@ static int dw_spi_write_then_read(struct dw_spi *dws, struct spi_device *spi)
 
 static inline bool dw_spi_ctlr_busy(struct dw_spi *dws)
 {
-	return dw_readl(dws, DW_SPI_SR) & SR_BUSY;
+	return dw_readl(dws, DW_SPI_SR) & DW_SPI_SR_BUSY;
 }
 
 static int dw_spi_wait_mem_op_done(struct dw_spi *dws)
 {
-	int retry = SPI_WAIT_RETRIES;
+	int retry = DW_SPI_WAIT_RETRIES;
 	struct spi_delay delay;
 	unsigned long ns, us;
 	u32 nents;
@@ -638,9 +640,9 @@ static int dw_spi_wait_mem_op_done(struct dw_spi *dws)
 
 static void dw_spi_stop_mem_op(struct dw_spi *dws, struct spi_device *spi)
 {
-	spi_enable_chip(dws, 0);
+	dw_spi_enable_chip(dws, 0);
 	dw_spi_set_cs(spi, true);
-	spi_enable_chip(dws, 1);
+	dw_spi_enable_chip(dws, 1);
 }
 
 /*
@@ -673,19 +675,19 @@ static int dw_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	cfg.dfs = 8;
 	cfg.freq = clamp(mem->spi->max_speed_hz, 0U, dws->max_mem_freq);
 	if (op->data.dir == SPI_MEM_DATA_IN) {
-		cfg.tmode = SPI_TMOD_EPROMREAD;
+		cfg.tmode = DW_SPI_CTRLR0_TMOD_EPROMREAD;
 		cfg.ndf = op->data.nbytes;
 	} else {
-		cfg.tmode = SPI_TMOD_TO;
+		cfg.tmode = DW_SPI_CTRLR0_TMOD_TO;
 	}
 
-	spi_enable_chip(dws, 0);
+	dw_spi_enable_chip(dws, 0);
 
 	dw_spi_update_config(dws, mem->spi, &cfg);
 
-	spi_mask_intr(dws, 0xff);
+	dw_spi_mask_intr(dws, 0xff);
 
-	spi_enable_chip(dws, 1);
+	dw_spi_enable_chip(dws, 1);
 
 	/*
 	 * DW APB SSI controller has very nasty peculiarities. First originally
@@ -768,7 +770,7 @@ static void dw_spi_init_mem_ops(struct dw_spi *dws)
 static int dw_spi_setup(struct spi_device *spi)
 {
 	struct dw_spi *dws = spi_controller_get_devdata(spi->controller);
-	struct chip_data *chip;
+	struct dw_spi_chip_data *chip;
 
 	/* Only alloc on first setup */
 	chip = spi_get_ctldata(spi);
@@ -776,7 +778,7 @@ static int dw_spi_setup(struct spi_device *spi)
 		struct dw_spi *dws = spi_controller_get_devdata(spi->controller);
 		u32 rx_sample_dly_ns;
 
-		chip = kzalloc(sizeof(struct chip_data), GFP_KERNEL);
+		chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 		if (!chip)
 			return -ENOMEM;
 		spi_set_ctldata(spi, chip);
@@ -803,16 +805,16 @@ static int dw_spi_setup(struct spi_device *spi)
 
 static void dw_spi_cleanup(struct spi_device *spi)
 {
-	struct chip_data *chip = spi_get_ctldata(spi);
+	struct dw_spi_chip_data *chip = spi_get_ctldata(spi);
 
 	kfree(chip);
 	spi_set_ctldata(spi, NULL);
 }
 
 /* Restart the controller, disable all interrupts, clean rx fifo */
-static void spi_hw_init(struct device *dev, struct dw_spi *dws)
+static void dw_spi_hw_init(struct device *dev, struct dw_spi *dws)
 {
-	spi_reset_chip(dws);
+	dw_spi_reset_chip(dws);
 
 	/*
 	 * Try to detect the FIFO depth if not set by interface driver,
@@ -837,18 +839,18 @@ static void spi_hw_init(struct device *dev, struct dw_spi *dws)
 	 * writability. Note DWC SSI controller also has the extended DFS, but
 	 * with zero offset.
 	 */
-	if (!(dws->caps & DW_SPI_CAP_DWC_SSI)) {
+	if (!(dws->caps & DW_SPI_CAP_DWC_HSSI)) {
 		u32 cr0, tmp = dw_readl(dws, DW_SPI_CTRLR0);
 
-		spi_enable_chip(dws, 0);
+		dw_spi_enable_chip(dws, 0);
 		dw_writel(dws, DW_SPI_CTRLR0, 0xffffffff);
 		cr0 = dw_readl(dws, DW_SPI_CTRLR0);
 		dw_writel(dws, DW_SPI_CTRLR0, tmp);
-		spi_enable_chip(dws, 1);
+		dw_spi_enable_chip(dws, 1);
 
-		if (!(cr0 & SPI_DFS_MASK)) {
+		if (!(cr0 & DW_PSSI_CTRLR0_DFS_MASK)) {
 			dws->caps |= DW_SPI_CAP_DFS32;
-			dws->dfs_offset = SPI_DFS32_OFFSET;
+			dws->dfs_offset = DW_PSSI_CTRLR0_DFS32_OFFSET;
 			dev_dbg(dev, "Detected 32-bits max data frame size\n");
 		}
 	} else {
@@ -878,7 +880,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	spi_controller_set_devdata(master, dws);
 
 	/* Basic HW init */
-	spi_hw_init(dev, dws);
+	dw_spi_hw_init(dev, dws);
 
 	ret = request_irq(dws->irq, dw_spi_irq, IRQF_SHARED, dev_name(dev),
 			  master);
@@ -939,7 +941,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 err_dma_exit:
 	if (dws->dma_ops && dws->dma_ops->dma_exit)
 		dws->dma_ops->dma_exit(dws);
-	spi_enable_chip(dws, 0);
+	dw_spi_enable_chip(dws, 0);
 	free_irq(dws->irq, master);
 err_free_master:
 	spi_controller_put(master);
@@ -956,7 +958,7 @@ void dw_spi_remove_host(struct dw_spi *dws)
 	if (dws->dma_ops && dws->dma_ops->dma_exit)
 		dws->dma_ops->dma_exit(dws);
 
-	spi_shutdown_chip(dws);
+	dw_spi_shutdown_chip(dws);
 
 	free_irq(dws->irq, dws->master);
 }
@@ -970,14 +972,14 @@ int dw_spi_suspend_host(struct dw_spi *dws)
 	if (ret)
 		return ret;
 
-	spi_shutdown_chip(dws);
+	dw_spi_shutdown_chip(dws);
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(dw_spi_suspend_host, SPI_DW_CORE);
 
 int dw_spi_resume_host(struct dw_spi *dws)
 {
-	spi_hw_init(&dws->master->dev, dws);
+	dw_spi_hw_init(&dws->master->dev, dws);
 	return spi_controller_resume(dws->master);
 }
 EXPORT_SYMBOL_NS_GPL(dw_spi_resume_host, SPI_DW_CORE);
diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index 5687ec05d627..2b9d36355b63 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -20,10 +20,10 @@
 
 MODULE_IMPORT_NS(SPI_DW_CORE);
 
-#define RX_BUSY		0
-#define RX_BURST_LEVEL	16
-#define TX_BUSY		1
-#define TX_BURST_LEVEL	16
+#define DW_SPI_RX_BUSY		0
+#define DW_SPI_RX_BURST_LEVEL	16
+#define DW_SPI_TX_BUSY		1
+#define DW_SPI_TX_BURST_LEVEL	16
 
 static bool dw_spi_dma_chan_filter(struct dma_chan *chan, void *param)
 {
@@ -48,7 +48,7 @@ static void dw_spi_dma_maxburst_init(struct dw_spi *dws)
 	if (!ret && caps.max_burst)
 		max_burst = caps.max_burst;
 	else
-		max_burst = RX_BURST_LEVEL;
+		max_burst = DW_SPI_RX_BURST_LEVEL;
 
 	dws->rxburst = min(max_burst, def_burst);
 	dw_writel(dws, DW_SPI_DMARDLR, dws->rxburst - 1);
@@ -57,7 +57,7 @@ static void dw_spi_dma_maxburst_init(struct dw_spi *dws)
 	if (!ret && caps.max_burst)
 		max_burst = caps.max_burst;
 	else
-		max_burst = TX_BURST_LEVEL;
+		max_burst = DW_SPI_TX_BURST_LEVEL;
 
 	/*
 	 * Having a Rx DMA channel serviced with higher priority than a Tx DMA
@@ -229,13 +229,13 @@ static int dw_spi_dma_wait(struct dw_spi *dws, unsigned int len, u32 speed)
 
 static inline bool dw_spi_dma_tx_busy(struct dw_spi *dws)
 {
-	return !(dw_readl(dws, DW_SPI_SR) & SR_TF_EMPT);
+	return !(dw_readl(dws, DW_SPI_SR) & DW_SPI_SR_TF_EMPT);
 }
 
 static int dw_spi_dma_wait_tx_done(struct dw_spi *dws,
 				   struct spi_transfer *xfer)
 {
-	int retry = SPI_WAIT_RETRIES;
+	int retry = DW_SPI_WAIT_RETRIES;
 	struct spi_delay delay;
 	u32 nents;
 
@@ -262,8 +262,8 @@ static void dw_spi_dma_tx_done(void *arg)
 {
 	struct dw_spi *dws = arg;
 
-	clear_bit(TX_BUSY, &dws->dma_chan_busy);
-	if (test_bit(RX_BUSY, &dws->dma_chan_busy))
+	clear_bit(DW_SPI_TX_BUSY, &dws->dma_chan_busy);
+	if (test_bit(DW_SPI_RX_BUSY, &dws->dma_chan_busy))
 		return;
 
 	complete(&dws->dma_completion);
@@ -307,19 +307,19 @@ static int dw_spi_dma_submit_tx(struct dw_spi *dws, struct scatterlist *sgl,
 		return ret;
 	}
 
-	set_bit(TX_BUSY, &dws->dma_chan_busy);
+	set_bit(DW_SPI_TX_BUSY, &dws->dma_chan_busy);
 
 	return 0;
 }
 
 static inline bool dw_spi_dma_rx_busy(struct dw_spi *dws)
 {
-	return !!(dw_readl(dws, DW_SPI_SR) & SR_RF_NOT_EMPT);
+	return !!(dw_readl(dws, DW_SPI_SR) & DW_SPI_SR_RF_NOT_EMPT);
 }
 
 static int dw_spi_dma_wait_rx_done(struct dw_spi *dws)
 {
-	int retry = SPI_WAIT_RETRIES;
+	int retry = DW_SPI_WAIT_RETRIES;
 	struct spi_delay delay;
 	unsigned long ns, us;
 	u32 nents;
@@ -363,8 +363,8 @@ static void dw_spi_dma_rx_done(void *arg)
 {
 	struct dw_spi *dws = arg;
 
-	clear_bit(RX_BUSY, &dws->dma_chan_busy);
-	if (test_bit(TX_BUSY, &dws->dma_chan_busy))
+	clear_bit(DW_SPI_RX_BUSY, &dws->dma_chan_busy);
+	if (test_bit(DW_SPI_TX_BUSY, &dws->dma_chan_busy))
 		return;
 
 	complete(&dws->dma_completion);
@@ -408,7 +408,7 @@ static int dw_spi_dma_submit_rx(struct dw_spi *dws, struct scatterlist *sgl,
 		return ret;
 	}
 
-	set_bit(RX_BUSY, &dws->dma_chan_busy);
+	set_bit(DW_SPI_RX_BUSY, &dws->dma_chan_busy);
 
 	return 0;
 }
@@ -433,16 +433,16 @@ static int dw_spi_dma_setup(struct dw_spi *dws, struct spi_transfer *xfer)
 	}
 
 	/* Set the DMA handshaking interface */
-	dma_ctrl = SPI_DMA_TDMAE;
+	dma_ctrl = DW_SPI_DMACR_TDMAE;
 	if (xfer->rx_buf)
-		dma_ctrl |= SPI_DMA_RDMAE;
+		dma_ctrl |= DW_SPI_DMACR_RDMAE;
 	dw_writel(dws, DW_SPI_DMACR, dma_ctrl);
 
 	/* Set the interrupt mask */
-	imr = SPI_INT_TXOI;
+	imr = DW_SPI_INT_TXOI;
 	if (xfer->rx_buf)
-		imr |= SPI_INT_RXUI | SPI_INT_RXOI;
-	spi_umask_intr(dws, imr);
+		imr |= DW_SPI_INT_RXUI | DW_SPI_INT_RXOI;
+	dw_spi_umask_intr(dws, imr);
 
 	reinit_completion(&dws->dma_completion);
 
@@ -618,13 +618,13 @@ static int dw_spi_dma_transfer(struct dw_spi *dws, struct spi_transfer *xfer)
 
 static void dw_spi_dma_stop(struct dw_spi *dws)
 {
-	if (test_bit(TX_BUSY, &dws->dma_chan_busy)) {
+	if (test_bit(DW_SPI_TX_BUSY, &dws->dma_chan_busy)) {
 		dmaengine_terminate_sync(dws->txchan);
-		clear_bit(TX_BUSY, &dws->dma_chan_busy);
+		clear_bit(DW_SPI_TX_BUSY, &dws->dma_chan_busy);
 	}
-	if (test_bit(RX_BUSY, &dws->dma_chan_busy)) {
+	if (test_bit(DW_SPI_RX_BUSY, &dws->dma_chan_busy)) {
 		dmaengine_terminate_sync(dws->rxchan);
-		clear_bit(RX_BUSY, &dws->dma_chan_busy);
+		clear_bit(DW_SPI_RX_BUSY, &dws->dma_chan_busy);
 	}
 }
 
diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 711f4d3404c5..0b37bd32b041 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -196,18 +196,18 @@ static int dw_spi_alpine_init(struct platform_device *pdev,
 	return 0;
 }
 
-static int dw_spi_dw_apb_init(struct platform_device *pdev,
-			      struct dw_spi_mmio *dwsmmio)
+static int dw_spi_pssi_init(struct platform_device *pdev,
+			    struct dw_spi_mmio *dwsmmio)
 {
 	dw_spi_dma_setup_generic(&dwsmmio->dws);
 
 	return 0;
 }
 
-static int dw_spi_dwc_ssi_init(struct platform_device *pdev,
-			       struct dw_spi_mmio *dwsmmio)
+static int dw_spi_hssi_init(struct platform_device *pdev,
+			    struct dw_spi_mmio *dwsmmio)
 {
-	dwsmmio->dws.caps = DW_SPI_CAP_DWC_SSI;
+	dwsmmio->dws.caps = DW_SPI_CAP_DWC_HSSI;
 
 	dw_spi_dma_setup_generic(&dwsmmio->dws);
 
@@ -217,7 +217,7 @@ static int dw_spi_dwc_ssi_init(struct platform_device *pdev,
 static int dw_spi_keembay_init(struct platform_device *pdev,
 			       struct dw_spi_mmio *dwsmmio)
 {
-	dwsmmio->dws.caps = DW_SPI_CAP_KEEMBAY_MST | DW_SPI_CAP_DWC_SSI;
+	dwsmmio->dws.caps = DW_SPI_CAP_KEEMBAY_MST | DW_SPI_CAP_DWC_HSSI;
 
 	return 0;
 }
@@ -342,12 +342,12 @@ static int dw_spi_mmio_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id dw_spi_mmio_of_match[] = {
-	{ .compatible = "snps,dw-apb-ssi", .data = dw_spi_dw_apb_init},
+	{ .compatible = "snps,dw-apb-ssi", .data = dw_spi_pssi_init},
 	{ .compatible = "mscc,ocelot-spi", .data = dw_spi_mscc_ocelot_init},
 	{ .compatible = "mscc,jaguar2-spi", .data = dw_spi_mscc_jaguar2_init},
 	{ .compatible = "amazon,alpine-dw-apb-ssi", .data = dw_spi_alpine_init},
-	{ .compatible = "renesas,rzn1-spi", .data = dw_spi_dw_apb_init},
-	{ .compatible = "snps,dwc-ssi-1.01a", .data = dw_spi_dwc_ssi_init},
+	{ .compatible = "renesas,rzn1-spi", .data = dw_spi_pssi_init},
+	{ .compatible = "snps,dwc-ssi-1.01a", .data = dw_spi_hssi_init},
 	{ .compatible = "intel,keembay-ssi", .data = dw_spi_keembay_init},
 	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
 	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
@@ -357,7 +357,7 @@ MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id dw_spi_mmio_acpi_match[] = {
-	{"HISI0173", (kernel_ulong_t)dw_spi_dw_apb_init},
+	{"HISI0173", (kernel_ulong_t)dw_spi_pssi_init},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, dw_spi_mmio_acpi_match);
diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index 5552240fee55..7c8279d13f31 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -24,14 +24,14 @@
 #define CLK_SPI_CDIV_MASK	0x00000e00
 #define CLK_SPI_DISABLE_OFFSET	8
 
-struct spi_pci_desc {
+struct dw_spi_pci_desc {
 	int	(*setup)(struct dw_spi *);
 	u16	num_cs;
 	u16	bus_num;
 	u32	max_freq;
 };
 
-static int spi_mid_init(struct dw_spi *dws)
+static int dw_spi_pci_mid_init(struct dw_spi *dws)
 {
 	void __iomem *clk_reg;
 	u32 clk_cdiv;
@@ -53,36 +53,36 @@ static int spi_mid_init(struct dw_spi *dws)
 	return 0;
 }
 
-static int spi_generic_init(struct dw_spi *dws)
+static int dw_spi_pci_generic_init(struct dw_spi *dws)
 {
 	dw_spi_dma_setup_generic(dws);
 
 	return 0;
 }
 
-static struct spi_pci_desc spi_pci_mid_desc_1 = {
-	.setup = spi_mid_init,
+static struct dw_spi_pci_desc dw_spi_pci_mid_desc_1 = {
+	.setup = dw_spi_pci_mid_init,
 	.num_cs = 5,
 	.bus_num = 0,
 };
 
-static struct spi_pci_desc spi_pci_mid_desc_2 = {
-	.setup = spi_mid_init,
+static struct dw_spi_pci_desc dw_spi_pci_mid_desc_2 = {
+	.setup = dw_spi_pci_mid_init,
 	.num_cs = 2,
 	.bus_num = 1,
 };
 
-static struct spi_pci_desc spi_pci_ehl_desc = {
-	.setup = spi_generic_init,
+static struct dw_spi_pci_desc dw_spi_pci_ehl_desc = {
+	.setup = dw_spi_pci_generic_init,
 	.num_cs = 2,
 	.bus_num = -1,
 	.max_freq = 100000000,
 };
 
-static int spi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+static int dw_spi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
+	struct dw_spi_pci_desc *desc = (struct dw_spi_pci_desc *)ent->driver_data;
 	struct dw_spi *dws;
-	struct spi_pci_desc *desc = (struct spi_pci_desc *)ent->driver_data;
 	int pci_bar = 0;
 	int ret;
 
@@ -150,7 +150,7 @@ static int spi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return ret;
 }
 
-static void spi_pci_remove(struct pci_dev *pdev)
+static void dw_spi_pci_remove(struct pci_dev *pdev)
 {
 	struct dw_spi *dws = pci_get_drvdata(pdev);
 
@@ -162,14 +162,14 @@ static void spi_pci_remove(struct pci_dev *pdev)
 }
 
 #ifdef CONFIG_PM_SLEEP
-static int spi_suspend(struct device *dev)
+static int dw_spi_pci_suspend(struct device *dev)
 {
 	struct dw_spi *dws = dev_get_drvdata(dev);
 
 	return dw_spi_suspend_host(dws);
 }
 
-static int spi_resume(struct device *dev)
+static int dw_spi_pci_resume(struct device *dev)
 {
 	struct dw_spi *dws = dev_get_drvdata(dev);
 
@@ -177,38 +177,37 @@ static int spi_resume(struct device *dev)
 }
 #endif
 
-static SIMPLE_DEV_PM_OPS(dw_spi_pm_ops, spi_suspend, spi_resume);
+static SIMPLE_DEV_PM_OPS(dw_spi_pci_pm_ops, dw_spi_pci_suspend, dw_spi_pci_resume);
 
-static const struct pci_device_id pci_ids[] = {
+static const struct pci_device_id dw_spi_pci_ids[] = {
 	/* Intel MID platform SPI controller 0 */
 	/*
 	 * The access to the device 8086:0801 is disabled by HW, since it's
 	 * exclusively used by SCU to communicate with MSIC.
 	 */
 	/* Intel MID platform SPI controller 1 */
-	{ PCI_VDEVICE(INTEL, 0x0800), (kernel_ulong_t)&spi_pci_mid_desc_1},
+	{ PCI_VDEVICE(INTEL, 0x0800), (kernel_ulong_t)&dw_spi_pci_mid_desc_1},
 	/* Intel MID platform SPI controller 2 */
-	{ PCI_VDEVICE(INTEL, 0x0812), (kernel_ulong_t)&spi_pci_mid_desc_2},
+	{ PCI_VDEVICE(INTEL, 0x0812), (kernel_ulong_t)&dw_spi_pci_mid_desc_2},
 	/* Intel Elkhart Lake PSE SPI controllers */
-	{ PCI_VDEVICE(INTEL, 0x4b84), (kernel_ulong_t)&spi_pci_ehl_desc},
-	{ PCI_VDEVICE(INTEL, 0x4b85), (kernel_ulong_t)&spi_pci_ehl_desc},
-	{ PCI_VDEVICE(INTEL, 0x4b86), (kernel_ulong_t)&spi_pci_ehl_desc},
-	{ PCI_VDEVICE(INTEL, 0x4b87), (kernel_ulong_t)&spi_pci_ehl_desc},
+	{ PCI_VDEVICE(INTEL, 0x4b84), (kernel_ulong_t)&dw_spi_pci_ehl_desc},
+	{ PCI_VDEVICE(INTEL, 0x4b85), (kernel_ulong_t)&dw_spi_pci_ehl_desc},
+	{ PCI_VDEVICE(INTEL, 0x4b86), (kernel_ulong_t)&dw_spi_pci_ehl_desc},
+	{ PCI_VDEVICE(INTEL, 0x4b87), (kernel_ulong_t)&dw_spi_pci_ehl_desc},
 	{},
 };
-MODULE_DEVICE_TABLE(pci, pci_ids);
+MODULE_DEVICE_TABLE(pci, dw_spi_pci_ids);
 
-static struct pci_driver dw_spi_driver = {
+static struct pci_driver dw_spi_pci_driver = {
 	.name =		DRIVER_NAME,
-	.id_table =	pci_ids,
-	.probe =	spi_pci_probe,
-	.remove =	spi_pci_remove,
+	.id_table =	dw_spi_pci_ids,
+	.probe =	dw_spi_pci_probe,
+	.remove =	dw_spi_pci_remove,
 	.driver         = {
-		.pm     = &dw_spi_pm_ops,
+		.pm     = &dw_spi_pci_pm_ops,
 	},
 };
-
-module_pci_driver(dw_spi_driver);
+module_pci_driver(dw_spi_pci_driver);
 
 MODULE_AUTHOR("Feng Tang <feng.tang@intel.com>");
 MODULE_DESCRIPTION("PCI interface driver for DW SPI Core");
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 467c342bfe56..893b78c43a50 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef DW_SPI_HEADER_H
-#define DW_SPI_HEADER_H
+#ifndef __SPI_DW_H__
+#define __SPI_DW_H__
 
 #include <linux/bits.h>
 #include <linux/completion.h>
@@ -11,7 +11,7 @@
 #include <linux/spi/spi-mem.h>
 #include <linux/bitfield.h>
 
-/* Register offsets */
+/* Register offsets (Generic for both DWC APB SSI and DWC SSI IP-cores) */
 #define DW_SPI_CTRLR0			0x00
 #define DW_SPI_CTRLR1			0x04
 #define DW_SPI_SSIENR			0x08
@@ -40,84 +40,85 @@
 #define DW_SPI_RX_SAMPLE_DLY		0xf0
 #define DW_SPI_CS_OVERRIDE		0xf4
 
-/* Bit fields in CTRLR0 */
-#define SPI_DFS_OFFSET			0
-#define SPI_DFS_MASK			GENMASK(3, 0)
-#define SPI_DFS32_OFFSET		16
-
-#define SPI_FRF_OFFSET			4
-#define SPI_FRF_MOTO_SPI		0x0
-#define SPI_FRF_TI_SSP			0x1
-#define SPI_FRF_NS_MICROWIRE		0x2
-#define SPI_FRF_RESV			0x3
-
-#define SPI_MODE_OFFSET			6
-#define SPI_SCPH_OFFSET			6
-#define SPI_SCOL_OFFSET			7
-
-#define SPI_TMOD_OFFSET			8
-#define SPI_TMOD_MASK			(0x3 << SPI_TMOD_OFFSET)
-#define	SPI_TMOD_TR			0x0		/* xmit & recv */
-#define SPI_TMOD_TO			0x1		/* xmit only */
-#define SPI_TMOD_RO			0x2		/* recv only */
-#define SPI_TMOD_EPROMREAD		0x3		/* eeprom read mode */
-
-#define SPI_SLVOE_OFFSET		10
-#define SPI_SRL_OFFSET			11
-#define SPI_CFS_OFFSET			12
-
-/* Bit fields in CTRLR0 based on DWC_ssi_databook.pdf v1.01a */
-#define DWC_SSI_CTRLR0_SRL_OFFSET	13
-#define DWC_SSI_CTRLR0_TMOD_OFFSET	10
-#define DWC_SSI_CTRLR0_TMOD_MASK	GENMASK(11, 10)
-#define DWC_SSI_CTRLR0_SCPOL_OFFSET	9
-#define DWC_SSI_CTRLR0_SCPH_OFFSET	8
-#define DWC_SSI_CTRLR0_FRF_OFFSET	6
-#define DWC_SSI_CTRLR0_DFS_OFFSET	0
+/* Bit fields in CTRLR0 (DWC APB SSI) */
+#define DW_PSSI_CTRLR0_DFS_OFFSET		0
+#define DW_PSSI_CTRLR0_DFS_MASK			GENMASK(3, 0)
+#define DW_PSSI_CTRLR0_DFS32_OFFSET		16
+
+#define DW_PSSI_CTRLR0_FRF_OFFSET		4
+#define DW_SPI_CTRLR0_FRF_MOTO_SPI		0x0
+#define DW_SPI_CTRLR0_FRF_TI_SSP		0x1
+#define DW_SPI_CTRLR0_FRF_NS_MICROWIRE		0x2
+#define DW_SPI_CTRLR0_FRF_RESV			0x3
+
+#define DW_PSSI_CTRLR0_MODE_OFFSET		6
+#define DW_PSSI_CTRLR0_SCPH_OFFSET		6
+#define DW_PSSI_CTRLR0_SCOL_OFFSET		7
+
+#define DW_PSSI_CTRLR0_TMOD_OFFSET		8
+#define DW_PSSI_CTRLR0_TMOD_MASK		(0x3 << DW_PSSI_CTRLR0_TMOD_OFFSET)
+#define DW_SPI_CTRLR0_TMOD_TR			0x0	/* xmit & recv */
+#define DW_SPI_CTRLR0_TMOD_TO			0x1	/* xmit only */
+#define DW_SPI_CTRLR0_TMOD_RO			0x2	/* recv only */
+#define DW_SPI_CTRLR0_TMOD_EPROMREAD		0x3	/* eeprom read mode */
+
+#define DW_PSSI_CTRLR0_SLVOE_OFFSET		10
+#define DW_PSSI_CTRLR0_SRL_OFFSET		11
+#define DW_PSSI_CTRLR0_CFS_OFFSET		12
+
+/* Bit fields in CTRLR0 (DWC SSI with AHB interface) */
+#define DW_HSSI_CTRLR0_SRL_OFFSET		13
+#define DW_HSSI_CTRLR0_TMOD_OFFSET		10
+#define DW_HSSI_CTRLR0_TMOD_MASK		GENMASK(11, 10)
+#define DW_HSSI_CTRLR0_SCPOL_OFFSET		9
+#define DW_HSSI_CTRLR0_SCPH_OFFSET		8
+#define DW_HSSI_CTRLR0_FRF_OFFSET		6
+#define DW_HSSI_CTRLR0_DFS_OFFSET		0
 
 /*
  * For Keem Bay, CTRLR0[31] is used to select controller mode.
  * 0: SSI is slave
  * 1: SSI is master
  */
-#define DWC_SSI_CTRLR0_KEEMBAY_MST	BIT(31)
+#define DW_HSSI_CTRLR0_KEEMBAY_MST		BIT(31)
 
 /* Bit fields in CTRLR1 */
-#define SPI_NDF_MASK			GENMASK(15, 0)
+#define DW_SPI_NDF_MASK				GENMASK(15, 0)
 
 /* Bit fields in SR, 7 bits */
-#define SR_MASK				0x7f		/* cover 7 bits */
-#define SR_BUSY				(1 << 0)
-#define SR_TF_NOT_FULL			(1 << 1)
-#define SR_TF_EMPT			(1 << 2)
-#define SR_RF_NOT_EMPT			(1 << 3)
-#define SR_RF_FULL			(1 << 4)
-#define SR_TX_ERR			(1 << 5)
-#define SR_DCOL				(1 << 6)
+#define DW_SPI_SR_MASK				0x7f	/* cover 7 bits */
+#define DW_SPI_SR_BUSY				(1 << 0)
+#define DW_SPI_SR_TF_NOT_FULL			(1 << 1)
+#define DW_SPI_SR_TF_EMPT			(1 << 2)
+#define DW_SPI_SR_RF_NOT_EMPT			(1 << 3)
+#define DW_SPI_SR_RF_FULL			(1 << 4)
+#define DW_SPI_SR_TX_ERR			(1 << 5)
+#define DW_SPI_SR_DCOL				(1 << 6)
 
 /* Bit fields in ISR, IMR, RISR, 7 bits */
-#define SPI_INT_TXEI			(1 << 0)
-#define SPI_INT_TXOI			(1 << 1)
-#define SPI_INT_RXUI			(1 << 2)
-#define SPI_INT_RXOI			(1 << 3)
-#define SPI_INT_RXFI			(1 << 4)
-#define SPI_INT_MSTI			(1 << 5)
+#define DW_SPI_INT_TXEI				(1 << 0)
+#define DW_SPI_INT_TXOI				(1 << 1)
+#define DW_SPI_INT_RXUI				(1 << 2)
+#define DW_SPI_INT_RXOI				(1 << 3)
+#define DW_SPI_INT_RXFI				(1 << 4)
+#define DW_SPI_INT_MSTI				(1 << 5)
 
 /* Bit fields in DMACR */
-#define SPI_DMA_RDMAE			(1 << 0)
-#define SPI_DMA_TDMAE			(1 << 1)
+#define DW_SPI_DMACR_RDMAE			(1 << 0)
+#define DW_SPI_DMACR_TDMAE			(1 << 1)
 
-#define SPI_WAIT_RETRIES		5
-#define SPI_BUF_SIZE \
+/* Mem/DMA operations helpers */
+#define DW_SPI_WAIT_RETRIES			5
+#define DW_SPI_BUF_SIZE \
 	(sizeof_field(struct spi_mem_op, cmd.opcode) + \
 	 sizeof_field(struct spi_mem_op, addr.val) + 256)
-#define SPI_GET_BYTE(_val, _idx) \
+#define DW_SPI_GET_BYTE(_val, _idx) \
 	((_val) >> (BITS_PER_BYTE * (_idx)) & 0xff)
 
 /* DW SPI capabilities */
 #define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
 #define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
-#define DW_SPI_CAP_DWC_SSI		BIT(2)
+#define DW_SPI_CAP_DWC_HSSI		BIT(2)
 #define DW_SPI_CAP_DFS32		BIT(3)
 
 /* Slave spi_transfer/spi_mem_op related */
@@ -162,7 +163,7 @@ struct dw_spi {
 	unsigned int		tx_len;
 	void			*rx;
 	unsigned int		rx_len;
-	u8			buf[SPI_BUF_SIZE];
+	u8			buf[DW_SPI_BUF_SIZE];
 	int			dma_mapped;
 	u8			n_bytes;	/* current is a 1/2 bytes op */
 	irqreturn_t		(*transfer_handler)(struct dw_spi *dws);
@@ -224,18 +225,18 @@ static inline void dw_write_io_reg(struct dw_spi *dws, u32 offset, u32 val)
 	}
 }
 
-static inline void spi_enable_chip(struct dw_spi *dws, int enable)
+static inline void dw_spi_enable_chip(struct dw_spi *dws, int enable)
 {
 	dw_writel(dws, DW_SPI_SSIENR, (enable ? 1 : 0));
 }
 
-static inline void spi_set_clk(struct dw_spi *dws, u16 div)
+static inline void dw_spi_set_clk(struct dw_spi *dws, u16 div)
 {
 	dw_writel(dws, DW_SPI_BAUDR, div);
 }
 
 /* Disable IRQ bits */
-static inline void spi_mask_intr(struct dw_spi *dws, u32 mask)
+static inline void dw_spi_mask_intr(struct dw_spi *dws, u32 mask)
 {
 	u32 new_mask;
 
@@ -244,7 +245,7 @@ static inline void spi_mask_intr(struct dw_spi *dws, u32 mask)
 }
 
 /* Enable IRQ bits */
-static inline void spi_umask_intr(struct dw_spi *dws, u32 mask)
+static inline void dw_spi_umask_intr(struct dw_spi *dws, u32 mask)
 {
 	u32 new_mask;
 
@@ -257,19 +258,19 @@ static inline void spi_umask_intr(struct dw_spi *dws, u32 mask)
  * and CS, then re-enables the controller back. Transmit and receive FIFO
  * buffers are cleared when the device is disabled.
  */
-static inline void spi_reset_chip(struct dw_spi *dws)
+static inline void dw_spi_reset_chip(struct dw_spi *dws)
 {
-	spi_enable_chip(dws, 0);
-	spi_mask_intr(dws, 0xff);
+	dw_spi_enable_chip(dws, 0);
+	dw_spi_mask_intr(dws, 0xff);
 	dw_readl(dws, DW_SPI_ICR);
 	dw_writel(dws, DW_SPI_SER, 0);
-	spi_enable_chip(dws, 1);
+	dw_spi_enable_chip(dws, 1);
 }
 
-static inline void spi_shutdown_chip(struct dw_spi *dws)
+static inline void dw_spi_shutdown_chip(struct dw_spi *dws)
 {
-	spi_enable_chip(dws, 0);
-	spi_set_clk(dws, 0);
+	dw_spi_enable_chip(dws, 0);
+	dw_spi_set_clk(dws, 0);
 }
 
 extern void dw_spi_set_cs(struct spi_device *spi, bool enable);
@@ -293,4 +294,4 @@ static inline void dw_spi_dma_setup_generic(struct dw_spi *dws) {}
 
 #endif /* !CONFIG_SPI_DW_DMA */
 
-#endif /* DW_SPI_HEADER_H */
+#endif /* __SPI_DW_H__ */
-- 
2.33.0

