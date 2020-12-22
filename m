Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9314D2E0E56
	for <lists+linux-spi@lfdr.de>; Tue, 22 Dec 2020 19:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgLVSpZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Dec 2020 13:45:25 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54434 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLVSpZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Dec 2020 13:45:25 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BMIigEZ015143;
        Tue, 22 Dec 2020 12:44:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608662682;
        bh=wtNjqX/SFi4ohW52XsC96ikubl1SuHs4kv1/95hv3uY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=uKMvGbsE1izcQ8NM8553L094l2Pl7XTfg6A5Jlu4vSK8dkcssrije7gWbxFjqTZls
         8tJxJUsWzRLaF3t/phPPjmKIkCcv5zeOaUoP1RdSsz2bVqY79auIceQHKNkpRum+e3
         UbWS+G0Q8zIf6CUVVcqGQcqT7Iyc4FFArVIiu2fA=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BMIigdJ000581
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Dec 2020 12:44:42 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 22
 Dec 2020 12:44:42 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 22 Dec 2020 12:44:42 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BMIiQbf003761;
        Tue, 22 Dec 2020 12:44:40 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Pratyush Yadav <p.yadav@ti.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/7] spi: cadence-quadspi: Add DTR support
Date:   Wed, 23 Dec 2020 00:14:25 +0530
Message-ID: <20201222184425.7028-8-p.yadav@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201222184425.7028-1-p.yadav@ti.com>
References: <20201222184425.7028-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Double Transfer Rate (DTR) mode transfers data twice per clock cycle.
Add support for parsing DTR ops and set up the registers to allow it.

Most SPI NOR flashes expect 2 byte commands. Parse the 2-byte opcode
from SPI MEM and set it up in the CQSPI_REG_OP_EXT_LOWER register.

Increment the delay needed before issuing indirect writes because larger
delay is needed for DTR mode. With the current delay some writes end up
missing.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 281 +++++++++++++++++++++++++-----
 1 file changed, 242 insertions(+), 39 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 90040664e1b9..06a65e9a8a60 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -52,6 +52,7 @@ struct cqspi_flash_pdata {
 	u8		inst_width;
 	u8		addr_width;
 	u8		data_width;
+	bool		dtr;
 	u8		cs;
 };
 
@@ -111,6 +112,8 @@ struct cqspi_driver_platdata {
 #define CQSPI_REG_CONFIG_CHIPSELECT_LSB		10
 #define CQSPI_REG_CONFIG_DMA_MASK		BIT(15)
 #define CQSPI_REG_CONFIG_BAUD_LSB		19
+#define CQSPI_REG_CONFIG_DTR_PROTO		BIT(24)
+#define CQSPI_REG_CONFIG_DUAL_OPCODE		BIT(30)
 #define CQSPI_REG_CONFIG_IDLE_LSB		31
 #define CQSPI_REG_CONFIG_CHIPSELECT_MASK	0xF
 #define CQSPI_REG_CONFIG_BAUD_MASK		0xF
@@ -173,6 +176,9 @@ struct cqspi_driver_platdata {
 #define CQSPI_REG_SDRAMLEVEL_RD_MASK		0xFFFF
 #define CQSPI_REG_SDRAMLEVEL_WR_MASK		0xFFFF
 
+#define CQSPI_REG_WR_COMPLETION_CTRL		0x38
+#define CQSPI_REG_WR_DISABLE_AUTO_POLL		BIT(14)
+
 #define CQSPI_REG_IRQSTATUS			0x40
 #define CQSPI_REG_IRQMASK			0x44
 
@@ -216,6 +222,14 @@ struct cqspi_driver_platdata {
 #define CQSPI_REG_CMDWRITEDATALOWER		0xA8
 #define CQSPI_REG_CMDWRITEDATAUPPER		0xAC
 
+#define CQSPI_REG_POLLING_STATUS		0xB0
+#define CQSPI_REG_POLLING_STATUS_DUMMY_LSB	16
+
+#define CQSPI_REG_OP_EXT_LOWER			0xE0
+#define CQSPI_REG_OP_EXT_READ_LSB		24
+#define CQSPI_REG_OP_EXT_WRITE_LSB		16
+#define CQSPI_REG_OP_EXT_STIG_LSB		0
+
 /* Interrupt status bits */
 #define CQSPI_REG_IRQ_MODE_ERR			BIT(0)
 #define CQSPI_REG_IRQ_UNDERFLOW			BIT(1)
@@ -290,15 +304,80 @@ static unsigned int cqspi_calc_rdreg(struct cqspi_flash_pdata *f_pdata)
 	return rdreg;
 }
 
-static unsigned int cqspi_calc_dummy(const struct spi_mem_op *op)
+static unsigned int cqspi_calc_dummy(const struct spi_mem_op *op, bool dtr)
 {
 	unsigned int dummy_clk;
 
 	dummy_clk = op->dummy.nbytes * (8 / op->dummy.buswidth);
+	if (dtr)
+		dummy_clk /= 2;
 
 	return dummy_clk;
 }
 
+static int cqspi_set_protocol(struct cqspi_flash_pdata *f_pdata,
+			      const struct spi_mem_op *op)
+{
+	f_pdata->inst_width = CQSPI_INST_TYPE_SINGLE;
+	f_pdata->addr_width = CQSPI_INST_TYPE_SINGLE;
+	f_pdata->data_width = CQSPI_INST_TYPE_SINGLE;
+	f_pdata->dtr = op->data.dtr && op->cmd.dtr && op->addr.dtr;
+
+	switch (op->data.buswidth) {
+	case 0:
+		break;
+	case 1:
+		f_pdata->data_width = CQSPI_INST_TYPE_SINGLE;
+		break;
+	case 2:
+		f_pdata->data_width = CQSPI_INST_TYPE_DUAL;
+		break;
+	case 4:
+		f_pdata->data_width = CQSPI_INST_TYPE_QUAD;
+		break;
+	case 8:
+		f_pdata->data_width = CQSPI_INST_TYPE_OCTAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Right now we only support 8-8-8 DTR mode. */
+	if (f_pdata->dtr) {
+		switch (op->cmd.buswidth) {
+		case 0:
+			break;
+		case 8:
+			f_pdata->inst_width = CQSPI_INST_TYPE_OCTAL;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		switch (op->addr.buswidth) {
+		case 0:
+			break;
+		case 8:
+			f_pdata->addr_width = CQSPI_INST_TYPE_OCTAL;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		switch (op->data.buswidth) {
+		case 0:
+			break;
+		case 8:
+			f_pdata->data_width = CQSPI_INST_TYPE_OCTAL;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static int cqspi_wait_idle(struct cqspi_st *cqspi)
 {
 	const unsigned int poll_idle_retry = 3;
@@ -356,13 +435,69 @@ static int cqspi_exec_flash_cmd(struct cqspi_st *cqspi, unsigned int reg)
 	return cqspi_wait_idle(cqspi);
 }
 
+static int cqspi_setup_opcode_ext(struct cqspi_flash_pdata *f_pdata,
+				  const struct spi_mem_op *op,
+				  unsigned int shift)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	void __iomem *reg_base = cqspi->iobase;
+	unsigned int reg;
+	u8 ext;
+
+	if (op->cmd.nbytes != 2)
+		return -EINVAL;
+
+	/* Opcode extension is the LSB. */
+	ext = op->cmd.opcode & 0xff;
+
+	reg = readl(reg_base + CQSPI_REG_OP_EXT_LOWER);
+	reg &= ~(0xff << shift);
+	reg |= ext << shift;
+	writel(reg, reg_base + CQSPI_REG_OP_EXT_LOWER);
+
+	return 0;
+}
+
+static int cqspi_enable_dtr(struct cqspi_flash_pdata *f_pdata,
+			    const struct spi_mem_op *op, unsigned int shift,
+			    bool enable)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	void __iomem *reg_base = cqspi->iobase;
+	unsigned int reg;
+	int ret;
+
+	reg = readl(reg_base + CQSPI_REG_CONFIG);
+
+	/*
+	 * We enable dual byte opcode here. The callers have to set up the
+	 * extension opcode based on which type of operation it is.
+	 */
+	if (enable) {
+		reg |= CQSPI_REG_CONFIG_DTR_PROTO;
+		reg |= CQSPI_REG_CONFIG_DUAL_OPCODE;
+
+		/* Set up command opcode extension. */
+		ret = cqspi_setup_opcode_ext(f_pdata, op, shift);
+		if (ret)
+			return ret;
+	} else {
+		reg &= ~CQSPI_REG_CONFIG_DTR_PROTO;
+		reg &= ~CQSPI_REG_CONFIG_DUAL_OPCODE;
+	}
+
+	writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+	return cqspi_wait_idle(cqspi);
+}
+
 static int cqspi_command_read(struct cqspi_flash_pdata *f_pdata,
 			      const struct spi_mem_op *op)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	void __iomem *reg_base = cqspi->iobase;
 	u8 *rxbuf = op->data.buf.in;
-	u8 opcode = op->cmd.opcode;
+	u8 opcode;
 	size_t n_rx = op->data.nbytes;
 	unsigned int rdreg;
 	unsigned int reg;
@@ -370,6 +505,15 @@ static int cqspi_command_read(struct cqspi_flash_pdata *f_pdata,
 	size_t read_len;
 	int status;
 
+	status = cqspi_set_protocol(f_pdata, op);
+	if (status)
+		return status;
+
+	status = cqspi_enable_dtr(f_pdata, op, CQSPI_REG_OP_EXT_STIG_LSB,
+				  f_pdata->dtr);
+	if (status)
+		return status;
+
 	if (!n_rx || n_rx > CQSPI_STIG_DATA_LEN_MAX || !rxbuf) {
 		dev_err(&cqspi->pdev->dev,
 			"Invalid input argument, len %zu rxbuf 0x%p\n",
@@ -377,12 +521,17 @@ static int cqspi_command_read(struct cqspi_flash_pdata *f_pdata,
 		return -EINVAL;
 	}
 
+	if (f_pdata->dtr)
+		opcode = op->cmd.opcode >> 8;
+	else
+		opcode = op->cmd.opcode;
+
 	reg = opcode << CQSPI_REG_CMDCTRL_OPCODE_LSB;
 
 	rdreg = cqspi_calc_rdreg(f_pdata);
 	writel(rdreg, reg_base + CQSPI_REG_RD_INSTR);
 
-	dummy_clk = cqspi_calc_dummy(op);
+	dummy_clk = cqspi_calc_dummy(op, f_pdata->dtr);
 	if (dummy_clk > CQSPI_DUMMY_CLKS_MAX)
 		return -EOPNOTSUPP;
 
@@ -421,12 +570,22 @@ static int cqspi_command_write(struct cqspi_flash_pdata *f_pdata,
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	void __iomem *reg_base = cqspi->iobase;
-	const u8 opcode = op->cmd.opcode;
+	u8 opcode;
 	const u8 *txbuf = op->data.buf.out;
 	size_t n_tx = op->data.nbytes;
 	unsigned int reg;
 	unsigned int data;
 	size_t write_len;
+	int ret;
+
+	ret = cqspi_set_protocol(f_pdata, op);
+	if (ret)
+		return ret;
+
+	ret = cqspi_enable_dtr(f_pdata, op, CQSPI_REG_OP_EXT_STIG_LSB,
+			       f_pdata->dtr);
+	if (ret)
+		return ret;
 
 	if (n_tx > CQSPI_STIG_DATA_LEN_MAX || (n_tx && !txbuf)) {
 		dev_err(&cqspi->pdev->dev,
@@ -435,6 +594,14 @@ static int cqspi_command_write(struct cqspi_flash_pdata *f_pdata,
 		return -EINVAL;
 	}
 
+	reg = cqspi_calc_rdreg(f_pdata);
+	writel(reg, reg_base + CQSPI_REG_RD_INSTR);
+
+	if (f_pdata->dtr)
+		opcode = op->cmd.opcode >> 8;
+	else
+		opcode = op->cmd.opcode;
+
 	reg = opcode << CQSPI_REG_CMDCTRL_OPCODE_LSB;
 
 	if (op->addr.nbytes) {
@@ -474,12 +641,24 @@ static int cqspi_read_setup(struct cqspi_flash_pdata *f_pdata,
 	void __iomem *reg_base = cqspi->iobase;
 	unsigned int dummy_clk = 0;
 	unsigned int reg;
+	int ret;
+	u8 opcode;
 
-	reg = op->cmd.opcode << CQSPI_REG_RD_INSTR_OPCODE_LSB;
+	ret = cqspi_enable_dtr(f_pdata, op, CQSPI_REG_OP_EXT_READ_LSB,
+			       f_pdata->dtr);
+	if (ret)
+		return ret;
+
+	if (f_pdata->dtr)
+		opcode = op->cmd.opcode >> 8;
+	else
+		opcode = op->cmd.opcode;
+
+	reg = opcode << CQSPI_REG_RD_INSTR_OPCODE_LSB;
 	reg |= cqspi_calc_rdreg(f_pdata);
 
 	/* Setup dummy clock cycles */
-	dummy_clk = cqspi_calc_dummy(op);
+	dummy_clk = cqspi_calc_dummy(op, f_pdata->dtr);
 
 	if (dummy_clk > CQSPI_DUMMY_CLKS_MAX)
 		return -EOPNOTSUPP;
@@ -594,15 +773,43 @@ static int cqspi_write_setup(struct cqspi_flash_pdata *f_pdata,
 			     const struct spi_mem_op *op)
 {
 	unsigned int reg;
+	int ret;
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	void __iomem *reg_base = cqspi->iobase;
+	u8 opcode;
+
+	ret = cqspi_enable_dtr(f_pdata, op, CQSPI_REG_OP_EXT_WRITE_LSB,
+			       f_pdata->dtr);
+	if (ret)
+		return ret;
+
+	if (f_pdata->dtr)
+		opcode = op->cmd.opcode >> 8;
+	else
+		opcode = op->cmd.opcode;
 
 	/* Set opcode. */
-	reg = op->cmd.opcode << CQSPI_REG_WR_INSTR_OPCODE_LSB;
+	reg = opcode << CQSPI_REG_WR_INSTR_OPCODE_LSB;
+	reg |= f_pdata->data_width << CQSPI_REG_WR_INSTR_TYPE_DATA_LSB;
+	reg |= f_pdata->addr_width << CQSPI_REG_WR_INSTR_TYPE_ADDR_LSB;
 	writel(reg, reg_base + CQSPI_REG_WR_INSTR);
 	reg = cqspi_calc_rdreg(f_pdata);
 	writel(reg, reg_base + CQSPI_REG_RD_INSTR);
 
+	if (f_pdata->dtr) {
+		/*
+		 * Some flashes like the cypress Semper flash expect a 4-byte
+		 * dummy address with the Read SR command in DTR mode, but this
+		 * controller does not support sending address with the Read SR
+		 * command. So, disable write completion polling on the
+		 * controller's side. spi-nor will take care of polling the
+		 * status register.
+		 */
+		reg = readl(reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
+		reg |= CQSPI_REG_WR_DISABLE_AUTO_POLL;
+		writel(reg, reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
+	}
+
 	reg = readl(reg_base + CQSPI_REG_SIZE);
 	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
 	reg |= (op->addr.nbytes - 1);
@@ -856,35 +1063,6 @@ static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
 		cqspi_controller_enable(cqspi, 1);
 }
 
-static int cqspi_set_protocol(struct cqspi_flash_pdata *f_pdata,
-			      const struct spi_mem_op *op)
-{
-	f_pdata->inst_width = CQSPI_INST_TYPE_SINGLE;
-	f_pdata->addr_width = CQSPI_INST_TYPE_SINGLE;
-	f_pdata->data_width = CQSPI_INST_TYPE_SINGLE;
-
-	if (op->data.dir == SPI_MEM_DATA_IN) {
-		switch (op->data.buswidth) {
-		case 1:
-			f_pdata->data_width = CQSPI_INST_TYPE_SINGLE;
-			break;
-		case 2:
-			f_pdata->data_width = CQSPI_INST_TYPE_DUAL;
-			break;
-		case 4:
-			f_pdata->data_width = CQSPI_INST_TYPE_QUAD;
-			break;
-		case 8:
-			f_pdata->data_width = CQSPI_INST_TYPE_OCTAL;
-			break;
-		default:
-			return -EINVAL;
-		}
-	}
-
-	return 0;
-}
-
 static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
 			   const struct spi_mem_op *op)
 {
@@ -902,7 +1080,16 @@ static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
 	if (ret)
 		return ret;
 
-	if (cqspi->use_direct_mode && ((to + len) <= cqspi->ahb_size)) {
+	/*
+	 * Some flashes like the Cypress Semper flash expect a dummy 4-byte
+	 * address (all 0s) with the read status register command in DTR mode.
+	 * But this controller does not support sending dummy address bytes to
+	 * the flash when it is polling the write completion register in DTR
+	 * mode. So, we can not use direct mode when in DTR mode for writing
+	 * data.
+	 */
+	if (!f_pdata->dtr && cqspi->use_direct_mode &&
+	    ((to + len) <= cqspi->ahb_size)) {
 		memcpy_toio(cqspi->ahb_base + to, buf, len);
 		return cqspi_wait_idle(cqspi);
 	}
@@ -1072,6 +1259,8 @@ static int cqspi_check_buswidth_req(struct spi_mem *mem, u8 buswidth, bool tx)
 static bool cqspi_supports_mem_op(struct spi_mem *mem,
 				  const struct spi_mem_op *op)
 {
+	bool all_true, all_false;
+
 	if (cqspi_check_buswidth_req(mem, op->cmd.buswidth, true))
 		return false;
 
@@ -1088,6 +1277,19 @@ static bool cqspi_supports_mem_op(struct spi_mem *mem,
 				     op->data.dir == SPI_MEM_DATA_OUT))
 		return false;
 
+	all_true = op->cmd.dtr && op->addr.dtr && op->dummy.dtr &&
+		   op->data.dtr;
+	all_false = !op->cmd.dtr && !op->addr.dtr && !op->dummy.dtr &&
+		    !op->data.dtr;
+
+	/* Mixed DTR modes not supported. */
+	if (!(all_true || all_false))
+		return false;
+
+	/* DTR mode opcodes should be 2 bytes. */
+	if (all_true && op->cmd.nbytes != 2)
+		return false;
+
 	return true;
 }
 
@@ -1365,10 +1567,10 @@ static int cqspi_probe(struct platform_device *pdev)
 	ddata  = of_device_get_match_data(dev);
 	if (ddata) {
 		if (ddata->quirks & CQSPI_NEEDS_WR_DELAY)
-			cqspi->wr_delay = 5 * DIV_ROUND_UP(NSEC_PER_SEC,
+			cqspi->wr_delay = 50 * DIV_ROUND_UP(NSEC_PER_SEC,
 						cqspi->master_ref_clk_hz);
 		if (ddata->hwcaps_mask & CQSPI_SUPPORTS_OCTAL)
-			master->mode_bits |= SPI_RX_OCTAL;
+			master->mode_bits |= SPI_RX_OCTAL | SPI_TX_OCTAL;
 		if (!(ddata->quirks & CQSPI_DISABLE_DAC_MODE))
 			cqspi->use_direct_mode = true;
 	}
@@ -1510,3 +1712,4 @@ MODULE_AUTHOR("Ley Foon Tan <lftan@altera.com>");
 MODULE_AUTHOR("Graham Moore <grmoore@opensource.altera.com>");
 MODULE_AUTHOR("Vadivel Murugan R <vadivel.muruganx.ramuthevar@intel.com>");
 MODULE_AUTHOR("Vignesh Raghavendra <vigneshr@ti.com>");
+MODULE_AUTHOR("Pratyush Yadav <p.yadav@ti.com>");
-- 
2.28.0

