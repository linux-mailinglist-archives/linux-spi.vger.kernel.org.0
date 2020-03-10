Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0EBB17EE3E
	for <lists+linux-spi@lfdr.de>; Tue, 10 Mar 2020 02:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCJBw6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 21:52:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:44228 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbgCJBw6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Mar 2020 21:52:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 18:52:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,535,1574150400"; 
   d="scan'208";a="242155459"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga003.jf.intel.com with ESMTP; 09 Mar 2020 18:52:51 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        broonie@kernel.org, vigneshr@ti.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, boris.brezillon@free-electrons.com,
        simon.k.r.goldschmidt@gmail.com, dinguyen@kernel.org,
        tien.fong.chee@intel.com, marex@denx.de,
        linux-mtd@lists.infradead.org, dwmw2@infradead.org, richard@nod.at,
        computersforpeace@gmail.com, cyrille.pitchen@atmel.com,
        david.oberhollenzer@sigma-star.at, miquel.raynal@bootlin.com,
        tudor.ambarus@gmail.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v12 4/4] spi: cadence-quadspi: Add qspi support for Intel LGM SoC
Date:   Tue, 10 Mar 2020 09:52:13 +0800
Message-Id: <20200310015213.1734-5-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200310015213.1734-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20200310015213.1734-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Add support for the Cadence QSPI controller. This controller support
on the Intel Lightning Mountain(LGM), TI and Altera SoC's.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 137 ++++++++++++++++++++++++++++++--------
 1 file changed, 111 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 7b52e109036e..3afe0aac8447 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/*
- * Driver for Cadence QSPI Controller
- *
- * Copyright Altera Corporation (C) 2012-2014. All rights reserved.
- * Copyright Intel Corporation (C) 2019-2020. All rights reserved.
- * Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com
- */
+//
+// Driver for Cadence QSPI Controller
+//
+// Copyright Altera Corporation (C) 2012-2014. All rights reserved.
+// Copyright Intel Corporation (C) 2019-2020. All rights reserved.
+// Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com
+//
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
@@ -35,6 +35,7 @@
 /* Quirks */
 #define CQSPI_NEEDS_WR_DELAY		BIT(0)
 #define CQSPI_DISABLE_DAC_MODE		BIT(1)
+#define CQSPI_NEEDS_ADDR_SWAP		BIT(1)
 
 /* Capabilities*/
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
@@ -76,6 +77,8 @@ struct cqspi_st {
 	unsigned long		master_ref_clk_hz;
 	u32			fifo_depth;
 	u32			fifo_width;
+	u32			bus_num;
+	u32			num_chipselect;
 	bool			rclk_en;
 	u32			trigger_address;
 	u32			wr_delay;
@@ -132,6 +135,9 @@ struct cqspi_driver_platdata {
 #define CQSPI_REG_WR_INSTR_OPCODE_LSB		0
 #define CQSPI_REG_WR_INSTR_TYPE_ADDR_LSB	12
 #define CQSPI_REG_WR_INSTR_TYPE_DATA_LSB	16
+#define CQSPI_REG_WR_INSTR_TYPE_ADDR_MASK	3
+#define CQSPI_REG_WR_INSTR_TYPE_DATA_MASK	3
+#define CQSPI_REG_WR_INSTR_TYPE_WEL_DIS_POS	8
 
 #define CQSPI_REG_DELAY				0x0C
 #define CQSPI_REG_DELAY_TSLCH_LSB		0
@@ -262,25 +268,43 @@ static u32 cqspi_get_rd_sram_level(struct cqspi_st *cqspi)
 	return reg & CQSPI_REG_SDRAMLEVEL_RD_MASK;
 }
 
-static irqreturn_t cqspi_irq_handler(int this_irq, void *dev)
+static irqreturn_t cqspi_irq_handler(int irq, void *dev_id)
 {
-	struct cqspi_st *cqspi = dev;
+	struct cqspi_st *cqspi = dev_id;
 	unsigned int irq_status;
 
+	if (readl(cqspi->iobase + CQSPI_REG_IRQSTATUS) == 0)
+		return IRQ_NONE;
+
 	/* Read interrupt status */
 	irq_status = readl(cqspi->iobase + CQSPI_REG_IRQSTATUS);
-
 	/* Clear interrupt */
 	writel(irq_status, cqspi->iobase + CQSPI_REG_IRQSTATUS);
-
 	irq_status &= CQSPI_IRQ_MASK_RD | CQSPI_IRQ_MASK_WR;
 
-	if (irq_status)
-		complete(&cqspi->transfer_complete);
+	complete(&cqspi->transfer_complete);
 
 	return IRQ_HANDLED;
 }
 
+static u32 cqspi_cmd2addr(const struct spi_mem_op *op)
+{
+	const u8 *addrbuf = (u8 *)&op->addr.val;
+	unsigned int addr = 0;
+	int i;
+
+	/* Invalid address return zero. */
+	if (op->addr.nbytes > 4)
+		return 0;
+
+	for (i = 0; i < op->addr.nbytes; i++) {
+		addr = addr << 8;
+		addr |= addrbuf[i];
+	}
+
+	return addr;
+}
+
 static unsigned int cqspi_calc_rdreg(struct cqspi_flash_pdata *f_pdata)
 {
 	u32 rdreg = 0;
@@ -352,11 +376,14 @@ static int cqspi_exec_flash_cmd(struct cqspi_st *cqspi, unsigned int reg)
 static int cqspi_command_read(struct cqspi_flash_pdata *f_pdata,
 			      const struct spi_mem_op *op)
 {
+	const struct cqspi_driver_platdata *ddata;
 	struct cqspi_st *cqspi = f_pdata->cqspi;
+	struct device *dev = &cqspi->pdev->dev;
 	void __iomem *reg_base = cqspi->iobase;
 	u8 *rxbuf = op->data.buf.in;
 	u8 opcode = op->cmd.opcode;
 	size_t n_rx = op->data.nbytes;
+	unsigned int addr_value;
 	unsigned int rdreg;
 	unsigned int reg;
 	size_t read_len;
@@ -376,6 +403,16 @@ static int cqspi_command_read(struct cqspi_flash_pdata *f_pdata,
 
 	reg |= (0x1 << CQSPI_REG_CMDCTRL_RD_EN_LSB);
 
+	ddata  = of_device_get_match_data(dev);
+	if ((ddata->quirks & CQSPI_NEEDS_ADDR_SWAP) & op->addr.nbytes) {
+		reg |= BIT(CQSPI_REG_CMDCTRL_ADDR_EN_LSB);
+		reg |= ((op->addr.nbytes - 1) & CQSPI_REG_CMDCTRL_ADD_BYTES_MASK)
+			<< CQSPI_REG_CMDCTRL_ADD_BYTES_LSB;
+		addr_value = cqspi_cmd2addr(op);
+
+		writel(addr_value, reg_base + CQSPI_REG_CMDADDRESS);
+	}
+
 	/* 0 means 1 byte. */
 	reg |= (((n_rx - 1) & CQSPI_REG_CMDCTRL_RD_BYTES_MASK)
 		<< CQSPI_REG_CMDCTRL_RD_BYTES_LSB);
@@ -424,7 +461,7 @@ static int cqspi_command_write(struct cqspi_flash_pdata *f_pdata,
 	if (op->addr.nbytes) {
 		reg |= (0x1 << CQSPI_REG_CMDCTRL_ADDR_EN_LSB);
 		reg |= ((op->addr.nbytes - 1) & CQSPI_REG_CMDCTRL_ADD_BYTES_MASK)
-		<< CQSPI_REG_CMDCTRL_ADD_BYTES_LSB;
+			<< CQSPI_REG_CMDCTRL_ADD_BYTES_LSB;
 
 		writel(op->addr.val, reg_base + CQSPI_REG_CMDADDRESS);
 	}
@@ -453,10 +490,20 @@ static int cqspi_command_write(struct cqspi_flash_pdata *f_pdata,
 static int cqspi_read_setup(struct cqspi_flash_pdata *f_pdata,
 			    const struct spi_mem_op *op)
 {
+	const struct cqspi_driver_platdata *ddata;
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	void __iomem *reg_base = cqspi->iobase;
+	struct device *dev = &cqspi->pdev->dev;
+	unsigned int reg, addr_value;
 	unsigned int dummy_clk = 0;
-	unsigned int reg;
+
+	ddata  = of_device_get_match_data(dev);
+	if ((ddata->quirks & CQSPI_NEEDS_ADDR_SWAP) & op->addr.nbytes) {
+		addr_value = cqspi_cmd2addr(op);
+		writel(addr_value, reg_base + CQSPI_REG_INDIRECTRDSTARTADDR);
+		reg |= (op->data.buswidth & CQSPI_REG_RD_INSTR_TYPE_DATA_MASK)
+			<< CQSPI_REG_RD_INSTR_TYPE_DATA_LSB;
+	}
 
 	reg = op->cmd.opcode << CQSPI_REG_RD_INSTR_OPCODE_LSB;
 	reg |= cqspi_calc_rdreg(f_pdata);
@@ -468,7 +515,7 @@ static int cqspi_read_setup(struct cqspi_flash_pdata *f_pdata,
 
 	if (dummy_clk / 8)
 		reg |= (dummy_clk & CQSPI_REG_RD_INSTR_DUMMY_MASK)
-		       << CQSPI_REG_RD_INSTR_DUMMY_LSB;
+			<< CQSPI_REG_RD_INSTR_DUMMY_LSB;
 
 	writel(reg, reg_base + CQSPI_REG_RD_INSTR);
 
@@ -508,7 +555,7 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 
 	while (remaining > 0) {
 		if (!wait_for_completion_timeout(&cqspi->transfer_complete,
-						 msecs_to_jiffies(CQSPI_READ_TIMEOUT_MS)))
+				msecs_to_jiffies(CQSPI_READ_TIMEOUT_MS)))
 			ret = -ETIMEDOUT;
 
 		bytes_to_read = cqspi_get_rd_sram_level(cqspi);
@@ -575,9 +622,12 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 static int cqspi_write_setup(struct cqspi_flash_pdata *f_pdata,
 			     const struct spi_mem_op *op)
 {
-	unsigned int reg;
+	const struct cqspi_driver_platdata *ddata;
 	struct cqspi_st *cqspi = f_pdata->cqspi;
+	struct device *dev = &cqspi->pdev->dev;
 	void __iomem *reg_base = cqspi->iobase;
+	const u8 *txbuf = &op->cmd.opcode;
+	unsigned int reg;
 
 	/* Set opcode. */
 	reg = op->cmd.opcode << CQSPI_REG_WR_INSTR_OPCODE_LSB;
@@ -585,6 +635,24 @@ static int cqspi_write_setup(struct cqspi_flash_pdata *f_pdata,
 	reg = cqspi_calc_rdreg(f_pdata);
 	writel(reg, reg_base + CQSPI_REG_RD_INSTR);
 
+	ddata  = of_device_get_match_data(dev);
+	if (ddata->quirks & CQSPI_NEEDS_ADDR_SWAP) {
+		/* Set opcode. */
+		reg = txbuf[0] << CQSPI_REG_WR_INSTR_OPCODE_LSB;
+		reg |= BIT(CQSPI_REG_WR_INSTR_TYPE_WEL_DIS_POS);
+		/* Configure the mode for address */
+		reg |= (op->addr.buswidth & CQSPI_REG_WR_INSTR_TYPE_ADDR_MASK)
+			<< CQSPI_REG_WR_INSTR_TYPE_ADDR_LSB;
+
+		/* Configure the mode for data */
+		reg |= (op->data.buswidth & CQSPI_REG_WR_INSTR_TYPE_DATA_MASK)
+			<< CQSPI_REG_WR_INSTR_TYPE_DATA_LSB;
+		writel(reg, reg_base + CQSPI_REG_WR_INSTR);
+		/* Setup write address. */
+		reg = cqspi_cmd2addr(op);
+		writel(reg, reg_base + CQSPI_REG_INDIRECTWRSTARTADDR);
+	}
+
 	reg = readl(reg_base + CQSPI_REG_SIZE);
 	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
 	reg |= (op->addr.nbytes - 1);
@@ -644,7 +712,7 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 		}
 
 		if (!wait_for_completion_timeout(&cqspi->transfer_complete,
-						 msecs_to_jiffies(CQSPI_TIMEOUT_MS))) {
+					msecs_to_jiffies(CQSPI_TIMEOUT_MS))) {
 			dev_err(dev, "Indirect write timeout\n");
 			ret = -ETIMEDOUT;
 			goto failwr;
@@ -903,7 +971,7 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 				     u_char *buf, loff_t from, size_t len)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
-	struct device *dev = &cqspi->pdev->dev;
+	struct device *dev = cqspi->rx_chan->device->dev;
 	enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
 	dma_addr_t dma_src = (dma_addr_t)cqspi->mmap_phys_base + from;
 	int ret = 0;
@@ -1053,6 +1121,8 @@ static int cqspi_of_get_pdata(struct cqspi_st *cqspi)
 	struct device *dev = &cqspi->pdev->dev;
 	struct device_node *np = dev->of_node;
 
+	cqspi->is_decoded_cs = of_property_read_bool(np, "cdns,is-decoded-cs");
+
 	if (of_property_read_u32(np, "cdns,fifo-depth", &cqspi->fifo_depth)) {
 		dev_err(dev, "couldn't determine fifo-depth\n");
 		return -ENXIO;
@@ -1098,10 +1168,6 @@ static void cqspi_controller_init(struct cqspi_st *cqspi)
 	writel(cqspi->fifo_depth * cqspi->fifo_width / 8,
 	       cqspi->iobase + CQSPI_REG_INDIRECTWRWATERMARK);
 
-	/*
-	 * Disable Direct Access Controller and Auto polling when not
-	 * supported.
-	 */
 	if (!cqspi->use_dac_mode) {
 		u32 reg;
 
@@ -1128,7 +1194,7 @@ static int cqspi_request_mmap_dma(struct cqspi_st *cqspi)
 	if (IS_ERR(cqspi->rx_chan)) {
 		int ret = PTR_ERR(cqspi->rx_chan);
 
-		if (ret == -EPROBE_DEFER)
+		if (ret != -EPROBE_DEFER)
 			dev_err(&cqspi->pdev->dev, "No Rx DMA available\n");
 		cqspi->rx_chan = NULL;
 
@@ -1273,6 +1339,11 @@ static int cqspi_probe(struct platform_device *pdev)
 
 	cqspi->master_ref_clk_hz = clk_get_rate(cqspi->clk);
 	ddata  = of_device_get_match_data(dev);
+	if (!ddata) {
+		dev_err(dev, "Could not retrieve QSPI caps\n");
+		goto probe_reset_failed;
+	}
+
 	if (ddata) {
 		if (ddata->quirks & CQSPI_NEEDS_WR_DELAY)
 			cqspi->wr_delay = 5 * DIV_ROUND_UP(NSEC_PER_SEC,
@@ -1281,9 +1352,15 @@ static int cqspi_probe(struct platform_device *pdev)
 			master->mode_bits |= SPI_RX_OCTAL;
 		if (!(ddata->quirks & CQSPI_DISABLE_DAC_MODE))
 			cqspi->use_dac_mode = true;
+		if (ddata->quirks & CQSPI_NEEDS_ADDR_SWAP) {
+			master->bus_num = 0;
+			master->num_chipselect = 2;
+			master->mode_bits = SPI_CS_HIGH | SPI_CPOL | SPI_CPHA |
+						SPI_TX_QUAD;
+		}
 	}
 
-	ret = devm_request_irq(dev, irq, cqspi_irq_handler, 0,
+	ret = devm_request_irq(dev, irq, cqspi_irq_handler, IRQF_SHARED,
 			       pdev->name, cqspi);
 	if (ret) {
 		dev_err(dev, "Cannot request IRQ.\n");
@@ -1381,6 +1458,10 @@ static const struct cqspi_driver_platdata am654_ospi = {
 	.quirks = CQSPI_NEEDS_WR_DELAY,
 };
 
+static const struct cqspi_driver_platdata intel_lgm_qspi = {
+	.quirks = CQSPI_NEEDS_ADDR_SWAP,
+};
+
 static const struct of_device_id cqspi_dt_ids[] = {
 	{
 		.compatible = "cdns,qspi-nor",
@@ -1394,6 +1475,10 @@ static const struct of_device_id cqspi_dt_ids[] = {
 		.compatible = "ti,am654-ospi",
 		.data = &am654_ospi,
 	},
+	{
+		.compatible = "intel,lgm-qspi",
+		.data = &intel_lgm_qspi,
+	},
 	{ /* end of table */ }
 };
 
-- 
2.11.0

