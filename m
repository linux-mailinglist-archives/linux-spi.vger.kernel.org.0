Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09BF51B1F8A
	for <lists+linux-spi@lfdr.de>; Tue, 21 Apr 2020 09:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgDUHJN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Apr 2020 03:09:13 -0400
Received: from twhmllg3.macronix.com ([122.147.135.201]:50590 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbgDUHJN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Apr 2020 03:09:13 -0400
Received: from TWHMLLG3.macronix.com (localhost [127.0.0.2] (may be forged))
        by TWHMLLG3.macronix.com with ESMTP id 03L6efEx046656
        for <linux-spi@vger.kernel.org>; Tue, 21 Apr 2020 14:40:41 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id 03L6dnMZ045498;
        Tue, 21 Apr 2020 14:39:52 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     broonie@kernel.org, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com
Cc:     juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v2 3/5] mtd: spi-nor: Parse BFPT DWORD-18,19 and 20 for Octal 8D-8D-8D mode
Date:   Tue, 21 Apr 2020 14:39:45 +0800
Message-Id: <1587451187-6889-4-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1587451187-6889-1-git-send-email-masonccyang@mxic.com.tw>
References: <1587451187-6889-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG3.macronix.com 03L6dnMZ045498
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Based on JESD216C BFPT(Basic Flash Parameter Table) to add:
18th DWORD:
Octal DTR(8D-8D-8D) command and command extension (00b: same, 01b: inverse)
- Get extension command type

19th DWORD:
Octal mode enable sequences by two instructions or write CFG Reg2
- Get enable Octal mode sequences
- implemented Read/write CFG Reg 2 function
- setup the call-back function for octal mode enable

20th DWORD:
Maximum operation speed of device in Octal mode
- Get the Octal maximum operation speed

Also defined the relevant macros and enum to add such modes and make sure
op->xxx.dtr fields, command nbytes and extension command are properly
filled and unmask DTR and X-X-X modes in spi_nor_spimem_adjust_hwcaps()
so that DTR and X-X-X support detection is done through
spi_mem_supports_op().

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 drivers/mtd/spi-nor/core.c  | 220 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/mtd/spi-nor/core.h  |  17 ++++
 drivers/mtd/spi-nor/sfdp.c  | 116 +++++++++++++++++++++++
 drivers/mtd/spi-nor/sfdp.h  |  16 +++-
 include/linux/mtd/spi-nor.h |  51 +++++++++-
 5 files changed, 404 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index cc68ea8..b67c65d 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -40,6 +40,47 @@
 
 #define SPI_NOR_MAX_ADDR_WIDTH	4
 
+#define SET_SPIMEM_OP_FULL_OCTAL_READ_BUSWIDTH()	\
+	{						\
+		op.cmd.buswidth = 8;			\
+		op.addr.buswidth = 8;			\
+		op.dummy.buswidth = 8;			\
+		op.data.buswidth = 8;			\
+		op.cmd.nbytes = 2;			\
+	}
+
+#define SET_SPIMEM_OP_FULL_OCTAL_WRITE_BUSWIDTH()	\
+	{						\
+		op.cmd.buswidth = 8;			\
+		op.addr.buswidth = 8;			\
+		op.data.buswidth = 8;			\
+		op.cmd.nbytes = 2;			\
+	}
+
+#define SET_SPIMEM_OP_DTR_READ()			\
+	{						\
+		op.dummy.nbytes *= 2;			\
+		op.cmd.dtr = true;			\
+		op.addr.dtr = true;			\
+		op.dummy.dtr = true;			\
+		op.data.dtr = true;			\
+	}
+
+#define SET_SPIMEM_OP_DTR_WRITE()			\
+	{						\
+		op.cmd.dtr = true;			\
+		op.addr.dtr = true;			\
+		op.data.dtr = true;			\
+	}
+
+#define SET_OCTAL_EXTION_OPCODE()				\
+	{							\
+		if (nor->ext_cmd_mode == EXT_CMD_IS_INVERSE)	\
+			op.cmd.ext_opcode = ~op.cmd.opcode;	\
+		else						\
+			op.cmd.ext_opcode = op.cmd.opcode;	\
+	}
+
 /**
  * spi_nor_spimem_bounce() - check if a bounce buffer is needed for the data
  *                           transfer
@@ -113,6 +154,16 @@ static ssize_t spi_nor_spimem_read_data(struct spi_nor *nor, loff_t from,
 	/* convert the dummy cycles to the number of bytes */
 	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
 
+	if (spi_nor_protocol_is_8_8_8(nor->read_proto)) {
+		op.cmd.nbytes = 2;
+		SET_OCTAL_EXTION_OPCODE();
+
+		if (spi_nor_protocol_is_8D_8D_8D(nor->read_proto))
+			SET_SPIMEM_OP_DTR_READ();
+
+		memcpy(&nor->dirmap.rdesc->info.op_tmpl, &op, sizeof(op));
+	}
+
 	usebouncebuf = spi_nor_spimem_bounce(nor, &op);
 
 	if (nor->dirmap.rdesc) {
@@ -176,6 +227,16 @@ static ssize_t spi_nor_spimem_write_data(struct spi_nor *nor, loff_t to,
 	if (nor->program_opcode == SPINOR_OP_AAI_WP && nor->sst_write_second)
 		op.addr.nbytes = 0;
 
+	if (spi_nor_protocol_is_8_8_8(nor->write_proto)) {
+		op.cmd.nbytes = 2;
+		SET_OCTAL_EXTION_OPCODE();
+
+		if (spi_nor_protocol_is_8D_8D_8D(nor->write_proto))
+			SET_SPIMEM_OP_DTR_WRITE();
+
+		memcpy(&nor->dirmap.wdesc->info.op_tmpl, &op, sizeof(op));
+	}
+
 	if (spi_nor_spimem_bounce(nor, &op))
 		memcpy(nor->bouncebuf, buf, op.data.nbytes);
 
@@ -227,6 +288,15 @@ int spi_nor_write_enable(struct spi_nor *nor)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_NO_DATA);
 
+		if (spi_nor_protocol_is_8_8_8(nor->write_proto)) {
+			op.cmd.buswidth = 8;
+			op.cmd.nbytes = 2;
+			SET_OCTAL_EXTION_OPCODE();
+
+			if (spi_nor_protocol_is_8D_8D_8D(nor->write_proto))
+				op.cmd.dtr = true;
+		}
+
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
 		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WREN,
@@ -256,6 +326,15 @@ int spi_nor_write_disable(struct spi_nor *nor)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_NO_DATA);
 
+		if (spi_nor_protocol_is_8_8_8(nor->write_proto)) {
+			op.cmd.buswidth = 8;
+			op.cmd.nbytes = 2;
+			SET_OCTAL_EXTION_OPCODE();
+
+			if (spi_nor_protocol_is_8D_8D_8D(nor->write_proto))
+				op.cmd.dtr = true;
+		}
+
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
 		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WRDI,
@@ -287,6 +366,16 @@ static int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_DATA_IN(1, sr, 1));
 
+		if (spi_nor_protocol_is_8_8_8(nor->read_proto)) {
+			SET_SPIMEM_OP_FULL_OCTAL_READ_BUSWIDTH();
+			op.addr.nbytes = nor->params->rdsr_addr_nbytes;
+			op.dummy.nbytes = nor->params->rdsr_dummy_cycles;
+			SET_OCTAL_EXTION_OPCODE();
+
+			if (spi_nor_protocol_is_8D_8D_8D(nor->read_proto))
+				SET_SPIMEM_OP_DTR_READ();
+		}
+
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
 		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDSR,
@@ -300,6 +389,92 @@ static int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
 }
 
 /**
+ * spi_nor_read_cr2() - Read the Configuration Register 2.
+ * @nor:	pointer to 'struct spi_nor'.
+ * @addr:	offset address to read.
+ * @cr2:	pointer to a DMA-able buffer where the value of the
+ *              Configuration Register 2  will be written.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int spi_nor_read_cr2(struct spi_nor *nor, u32 addr, u8 *cr2)
+{
+	int ret;
+
+	if (nor->spimem) {
+		struct spi_mem_op op =
+			SPI_MEM_OP(SPI_MEM_OP_CMD(nor->params->rd_reg_cmd, 1),
+				   SPI_MEM_OP_ADDR(4, addr, 1),
+				   SPI_MEM_OP_DUMMY(4, 1),
+				   SPI_MEM_OP_DATA_IN(1, cr2, 1));
+
+		if (spi_nor_protocol_is_8_8_8(nor->read_proto)) {
+			SET_SPIMEM_OP_FULL_OCTAL_READ_BUSWIDTH();
+			SET_OCTAL_EXTION_OPCODE();
+
+			if (spi_nor_protocol_is_8D_8D_8D(nor->read_proto))
+				SET_SPIMEM_OP_DTR_READ();
+		}
+
+		ret = spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret = nor->controller_ops->read_reg(nor,
+						    nor->params->rd_reg_cmd,
+						    cr2, 1);
+	}
+
+	if (ret)
+		dev_dbg(nor->dev, "error %d reading CR2\n", ret);
+
+	return ret;
+}
+
+/**
+ * spi_nor_write_cr2() - Write the Configuration Register 2.
+ * @nor:	pointer to 'struct spi_nor'.
+ * @addr:	offset address to write.
+ * @cr2:	pointer to a DMA-able buffer where the value of the
+ *              Configuratin Register 2 will be read.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int spi_nor_write_cr2(struct spi_nor *nor, u32 addr, u8 *cr2)
+{
+	int ret;
+
+	ret = spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+
+	if (nor->spimem) {
+		struct spi_mem_op op =
+			SPI_MEM_OP(SPI_MEM_OP_CMD(nor->params->wr_reg_cmd, 1),
+				   SPI_MEM_OP_ADDR(4, addr, 1),
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_DATA_OUT(1, cr2, 1));
+
+		if (spi_nor_protocol_is_8_8_8(nor->write_proto)) {
+			SET_SPIMEM_OP_FULL_OCTAL_WRITE_BUSWIDTH();
+			SET_OCTAL_EXTION_OPCODE();
+
+			if (spi_nor_protocol_is_8D_8D_8D(nor->write_proto))
+				SET_SPIMEM_OP_DTR_WRITE();
+		}
+
+		ret = spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret = nor->controller_ops->write_reg(nor,
+						     nor->params->wr_reg_cmd,
+						     cr2, 1);
+	}
+
+	if (ret)
+		dev_dbg(nor->dev, "error %d write CFG Reg 2\n", ret);
+
+	return ret;
+}
+
+/**
  * spi_nor_read_fsr() - Read the Flag Status Register.
  * @nor:	pointer to 'struct spi_nor'
  * @fsr:	pointer to a DMA-able buffer where the value of the
@@ -1002,6 +1177,15 @@ static int spi_nor_erase_chip(struct spi_nor *nor)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_NO_DATA);
 
+		if (spi_nor_protocol_is_8_8_8(nor->write_proto)) {
+			op.cmd.buswidth = 8;
+			op.cmd.nbytes = 2;
+			SET_OCTAL_EXTION_OPCODE();
+
+			if (spi_nor_protocol_is_8D_8D_8D(nor->write_proto))
+				op.cmd.dtr = true;
+		}
+
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
 		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_CHIP_ERASE,
@@ -1144,6 +1328,18 @@ static int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_NO_DATA);
 
+		if (spi_nor_protocol_is_8_8_8(nor->write_proto)) {
+			op.cmd.buswidth = 8;
+			op.addr.buswidth = 8;
+			op.cmd.nbytes = 2;
+			SET_OCTAL_EXTION_OPCODE();
+
+			if (spi_nor_protocol_is_8D_8D_8D(nor->write_proto)) {
+				op.cmd.dtr = true;
+				op.addr.dtr = true;
+			}
+		}
+
 		return spi_mem_exec_op(nor->spimem, &op);
 	} else if (nor->controller_ops->erase) {
 		return nor->controller_ops->erase(nor, addr);
@@ -2204,7 +2400,7 @@ static int spi_nor_check(struct spi_nor *nor)
 	return 0;
 }
 
-static void
+void
 spi_nor_set_read_settings(struct spi_nor_read_command *read,
 			  u8 num_mode_clocks,
 			  u8 num_wait_states,
@@ -2253,6 +2449,7 @@ int spi_nor_hwcaps_read2cmd(u32 hwcaps)
 		{ SNOR_HWCAPS_READ_1_8_8,	SNOR_CMD_READ_1_8_8 },
 		{ SNOR_HWCAPS_READ_8_8_8,	SNOR_CMD_READ_8_8_8 },
 		{ SNOR_HWCAPS_READ_1_8_8_DTR,	SNOR_CMD_READ_1_8_8_DTR },
+		{ SNOR_HWCAPS_READ_8_8_8_DTR,	SNOR_CMD_READ_8_8_8_DTR },
 	};
 
 	return spi_nor_hwcaps2cmd(hwcaps, hwcaps_read2cmd,
@@ -2269,6 +2466,7 @@ static int spi_nor_hwcaps_pp2cmd(u32 hwcaps)
 		{ SNOR_HWCAPS_PP_1_1_8,		SNOR_CMD_PP_1_1_8 },
 		{ SNOR_HWCAPS_PP_1_8_8,		SNOR_CMD_PP_1_8_8 },
 		{ SNOR_HWCAPS_PP_8_8_8,		SNOR_CMD_PP_8_8_8 },
+		{ SNOR_HWCAPS_PP_8_8_8_DTR,	SNOR_CMD_PP_8_8_8_DTR },
 	};
 
 	return spi_nor_hwcaps2cmd(hwcaps, hwcaps_pp2cmd,
@@ -2368,12 +2566,6 @@ static int spi_nor_spimem_check_pp(struct spi_nor *nor,
 	struct spi_nor_flash_parameter *params = nor->params;
 	unsigned int cap;
 
-	/* DTR modes are not supported yet, mask them all. */
-	*hwcaps &= ~SNOR_HWCAPS_DTR;
-
-	/* X-X-X modes are not supported yet, mask them all. */
-	*hwcaps &= ~SNOR_HWCAPS_X_X_X;
-
 	for (cap = 0; cap < sizeof(*hwcaps) * BITS_PER_BYTE; cap++) {
 		int rdidx, ppidx;
 
@@ -2614,7 +2806,6 @@ static int spi_nor_default_setup(struct spi_nor *nor,
 	 * controller and the SPI flash memory.
 	 */
 	shared_mask = hwcaps->mask & params->hwcaps.mask;
-
 	if (nor->spimem) {
 		/*
 		 * When called from spi_nor_probe(), all caps are set and we
@@ -2831,12 +3022,21 @@ static void spi_nor_post_sfdp_fixups(struct spi_nor *nor)
  */
 static void spi_nor_late_init_params(struct spi_nor *nor)
 {
+	struct spi_nor_flash_parameter *params = nor->params;
+	int ret = 0;
+
 	/*
 	 * NOR protection support. When locking_ops are not provided, we pick
 	 * the default ones.
 	 */
 	if (nor->flags & SNOR_F_HAS_LOCK && !nor->params->locking_ops)
 		nor->params->locking_ops = &spi_nor_sr_locking_ops;
+
+	if (nor->params->xspi_enable)
+		ret = nor->params->xspi_enable(nor,
+					       (params->dtr_read_cmd) ? 1 : 0);
+	if (ret)
+		dev_err(nor->dev, " enable xSPI mode failed %d\n", ret);
 }
 
 /**
@@ -2886,8 +3086,8 @@ static int spi_nor_init_params(struct spi_nor *nor)
 
 	spi_nor_manufacturer_init_params(nor);
 
-	if ((nor->info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)) &&
-	    !(nor->info->flags & SPI_NOR_SKIP_SFDP))
+	if ((nor->info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+	     SPI_NOR_OCTAL_RD_WR)) && !(nor->info->flags & SPI_NOR_SKIP_SFDP))
 		spi_nor_sfdp_init_params(nor);
 
 	spi_nor_post_sfdp_fixups(nor);
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 2ea11fa..ef32b86 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -62,6 +62,7 @@ enum spi_nor_read_command_index {
 	SNOR_CMD_READ_1_8_8,
 	SNOR_CMD_READ_8_8_8,
 	SNOR_CMD_READ_1_8_8_DTR,
+	SNOR_CMD_READ_8_8_8_DTR,
 
 	SNOR_CMD_READ_MAX
 };
@@ -78,6 +79,7 @@ enum spi_nor_pp_command_index {
 	SNOR_CMD_PP_1_1_8,
 	SNOR_CMD_PP_1_8_8,
 	SNOR_CMD_PP_8_8_8,
+	SNOR_CMD_PP_8_8_8_DTR,
 
 	SNOR_CMD_PP_MAX
 };
@@ -208,6 +210,8 @@ struct spi_nor_locking_ops {
  *                      e.g. different opcodes, specific address calculation,
  *                      page size, etc.
  * @locking_ops:	SPI NOR locking methods.
+ * @xspi_enable:	enables xSPI Octal mode for 8S-8S-8S/8D-8D-8D.
+ * @octal_max_speed:	xSPI Octal maximum operation speed (MHz).
  * @dtr_read_cmd:	xSPI Octal DTR Read Fast command.
  * @rdsr_addr_nbytes:	xSPI Octal address bytes for read status register.
  * @rdsr_dummy_cycles:	xSPI Octal dummy cycles for read status register.
@@ -232,6 +236,11 @@ struct spi_nor_flash_parameter {
 
 	const struct spi_nor_locking_ops *locking_ops;
 
+	/* BFPT DWORD19 Octal mode enable sequences */
+	int (*xspi_enable)(struct spi_nor *nor, bool dtr);
+	/* BFPT DWORD20 Maximum operation speed of device in Octal mode */
+	u16 octal_max_speed;
+
 	/* xSPI profile 1.0 parameter for Octal 8S-8S-8S/8D-8D-8D */
 	u8 dtr_read_cmd;
 	u8 rdsr_addr_nbytes;
@@ -325,6 +334,7 @@ struct flash_info {
 					 * BP3 is bit 6 of status register.
 					 * Must be used with SPI_NOR_4BIT_BP.
 					 */
+#define SPI_NOR_OCTAL_RD_WR	BIT(19)	/* Flash supports Octal Read & Write */
 
 	/* Part specific fixup hooks. */
 	const struct spi_nor_fixups *fixups;
@@ -413,6 +423,8 @@ struct spi_nor_manufacturer {
 extern const struct spi_nor_manufacturer spi_nor_xilinx;
 extern const struct spi_nor_manufacturer spi_nor_xmc;
 
+int spi_nor_read_cr2(struct spi_nor *nor, u32 addr, u8 *cr2);
+int spi_nor_write_cr2(struct spi_nor *nor, u32 addr, u8 *cr2);
 int spi_nor_write_enable(struct spi_nor *nor);
 int spi_nor_write_disable(struct spi_nor *nor);
 int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable);
@@ -432,6 +444,11 @@ ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
 
 int spi_nor_hwcaps_read2cmd(u32 hwcaps);
 u8 spi_nor_convert_3to4_read(u8 opcode);
+void spi_nor_set_read_settings(struct spi_nor_read_command *read,
+			       u8 num_mode_clocks,
+			       u8 num_wait_states,
+			       u8 opcode,
+			       enum spi_nor_protocol proto);
 void spi_nor_set_pp_settings(struct spi_nor_pp_command *pp, u8 opcode,
 			     enum spi_nor_protocol proto);
 
diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 26814a1..85a8509 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -50,6 +50,12 @@ struct xspi_dummy_cycles {
 	u8 shift;	/* Bit shift */
 };
 
+/* Basic Flash Parameter Table 20th DWORD, Max operation speed of device */
+struct octal_max_speed {
+	u8 idx;	/* Bits value */
+	u16 hz;	/* MHz */
+};
+
 struct sfdp_header {
 	u32		signature; /* Ox50444653U <=> "SFDP" */
 	u8		minor;
@@ -423,6 +429,64 @@ static void spi_nor_regions_sort_erase_types(struct spi_nor_erase_map *map)
 }
 
 /**
+ * spi_nor_cfg_reg2_octal_enable() - enable octal mode by CFG Reg 2
+ * @nor:               pointer to a 'struct spi_nor'
+ * @dtr:               true for DTR mode
+ *
+ * The Basic Flash Parameter Table 19th DWORD defined the Octal mode
+ * enable sequences by writing CFG Reg 2, 1: 8S-8S-8S, 2: 8D-8D-8D.
+ *
+ * Set Octal mode read/PP command, protocol and read dummy cycles.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_cfg_reg2_octal_enable(struct spi_nor *nor, bool dtr)
+{
+	struct spi_nor_flash_parameter *p = nor->params;
+	int ret;
+	u8 cr2 = 0;
+
+	if (!(nor->spimem->spi->mode & (SPI_RX_OCTAL | SPI_TX_OCTAL)))
+		return -ENOTSUPP;
+
+	if (dtr) {
+		cr2 |= CR2_OCTAL_MODE_DTR;
+		ret = spi_nor_write_cr2(nor, CR2_OCTAL_MODE_ADDR, &cr2);
+		if (ret)
+			return ret;
+
+		/* Octal 8D-8D-8D mode */
+		p->hwcaps.mask |= SNOR_HWCAPS_OPI_FULL_DTR;
+		spi_nor_set_read_settings(&p->reads[SNOR_CMD_READ_8_8_8_DTR],
+					  0, p->dummy_cycles,
+					  p->dtr_read_cmd,
+					  SNOR_PROTO_8_8_8_DTR);
+
+		spi_nor_set_pp_settings(&p->page_programs
+					[SNOR_CMD_PP_8_8_8_DTR],
+					SPINOR_OP_PP_8D_8D_8D,
+					SNOR_PROTO_8_8_8_DTR);
+	} else {
+		cr2 |= CR2_OCTAL_MODE_STR;
+		ret = spi_nor_write_cr2(nor, CR2_OCTAL_MODE_ADDR, &cr2);
+		if (ret)
+			return ret;
+
+		/* Octal 8S-8S-8S mode */
+		p->hwcaps.mask |= SNOR_HWCAPS_OPI_FULL_STR;
+		spi_nor_set_read_settings(&p->reads[SNOR_CMD_READ_8_8_8],
+					  0, p->dummy_cycles,
+					  SPINOR_OP_READ_8_8_8,
+					  SNOR_PROTO_8_8_8);
+
+		spi_nor_set_pp_settings(&p->page_programs[SNOR_CMD_PP_8_8_8],
+					SPINOR_OP_PP_8_8_8,
+					SNOR_PROTO_8_8_8);
+	}
+	return 0;
+}
+
+/**
  * spi_nor_parse_bfpt() - read and parse the Basic Flash Parameter Table.
  * @nor:		pointer to a 'struct spi_nor'
  * @bfpt_header:	pointer to the 'struct sfdp_parameter_header' describing
@@ -464,6 +528,22 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 	u32 addr;
 	u16 half;
 	u8 erase_mask;
+	static const struct octal_max_speed max_hz[] = {
+		/* Bits value, MHz */
+		{ 0x0c, 400 },
+		{ 0x0b, 333 },
+		{ 0x0a, 266 },
+		{ 0x09, 250 },
+		{ 0x08, 200 },
+		{ 0x07, 166 },
+		{ 0x06, 133 },
+		{ 0x05, 100 },
+		{ 0x04,  80 },
+		{ 0x03,  66 },
+		{ 0x02,  50 },
+		{ 0x01,  33 },
+	};
+	u8 idx;
 
 	/* JESD216 Basic Flash Parameter Table length is at least 9 DWORDs. */
 	if (bfpt_header->length < BFPT_DWORD_MAX_JESD216)
@@ -628,6 +708,42 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 		return -EINVAL;
 	}
 
+	/* 8D-8D-8D command extension. */
+	switch (bfpt.dwords[BFPT_DWORD(18)] & BFPT_DWORD18_CMD_EXT_MASK) {
+	case BFPT_DWORD18_CMD_EXT_REP:
+		nor->ext_cmd_mode = EXT_CMD_IS_REPEAT;
+		break;
+	case BFPT_DWORD18_CMD_EXT_INV:
+		nor->ext_cmd_mode = EXT_CMD_IS_INVERSE;
+		break;
+	default:
+		break;
+	}
+
+	/* Octal mode enable sequences. */
+	switch (bfpt.dwords[BFPT_DWORD(19)] & BFPT_DWORD19_OCTAL_SEQ_MASK) {
+	case BFPT_DWORD19_TWO_INST:
+		break;
+	case BFPT_DWORD19_CFG_REG2:
+		params->xspi_enable = spi_nor_cfg_reg2_octal_enable;
+		break;
+	default:
+		break;
+	}
+
+	/* Octal mode max speed */
+	idx = max(FIELD_GET(BFPT_DWORD20_OCTAL_DTR_MAX_SPEED,
+			    bfpt.dwords[BFPT_DWORD(20)]),
+		  FIELD_GET(BFPT_DWORD20_OCTAL_STR_MAX_SPEED,
+			    bfpt.dwords[BFPT_DWORD(20)]));
+
+	for (i = 0; i < ARRAY_SIZE(max_hz); i++) {
+		if (max_hz[i].idx == idx) {
+			params->octal_max_speed = max_hz[i].hz;
+			break;
+		}
+	}
+
 	return spi_nor_post_bfpt_fixups(nor, bfpt_header, &bfpt, params);
 }
 
diff --git a/drivers/mtd/spi-nor/sfdp.h b/drivers/mtd/spi-nor/sfdp.h
index e0a8ded..7a55b4d 100644
--- a/drivers/mtd/spi-nor/sfdp.h
+++ b/drivers/mtd/spi-nor/sfdp.h
@@ -10,11 +10,11 @@
 /* Basic Flash Parameter Table */
 
 /*
- * JESD216 rev B defines a Basic Flash Parameter Table of 16 DWORDs.
+ * JESD216 rev D defines a Basic Flash Parameter Table of 20 DWORDs.
  * They are indexed from 1 but C arrays are indexed from 0.
  */
 #define BFPT_DWORD(i)		((i) - 1)
-#define BFPT_DWORD_MAX		16
+#define BFPT_DWORD_MAX		20
 
 struct sfdp_bfpt {
 	u32	dwords[BFPT_DWORD_MAX];
@@ -83,6 +83,18 @@ struct sfdp_bfpt {
 #define BFPT_DWORD15_QER_SR2_BIT1_NO_RD		(0x4UL << 20)
 #define BFPT_DWORD15_QER_SR2_BIT1		(0x5UL << 20) /* Spansion */
 
+#define BFPT_DWORD18_CMD_EXT_MASK		GENMASK(30, 29)
+#define BFPT_DWORD18_CMD_EXT_REP		(0x0UL << 29) /* Repeat */
+#define BFPT_DWORD18_CMD_EXT_INV		(0x1UL << 29) /* Invert */
+
+#define BFPT_DWORD19_OCTAL_SEQ_MASK		GENMASK(6, 5)
+#define BFPT_DWORD19_TWO_INST			(0x1UL << 5) /* Two Inst. */
+#define BFPT_DWORD19_CFG_REG2			(0x2UL << 5) /* CFG Reg2  */
+
+#define BFPT_DWORD20_OCTAL_MAX_SPEED_MASK	GENMASK(31, 16)
+#define BFPT_DWORD20_OCTAL_DTR_MAX_SPEED	GENMASK(31, 28)
+#define BFPT_DWORD20_OCTAL_STR_MAX_SPEED	GENMASK(19, 16)
+
 struct sfdp_parameter_header {
 	u8		id_lsb;
 	u8		minor;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 1e2af0e..778b52e 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -68,6 +68,9 @@
 #define SPINOR_OP_BE_4K_4B	0x21	/* Erase 4KiB block */
 #define SPINOR_OP_BE_32K_4B	0x5c	/* Erase 32KiB block */
 #define SPINOR_OP_SE_4B		0xdc	/* Sector erase (usually 64KiB) */
+#define SPINOR_OP_READ_8_8_8	SPINOR_OP_READ_1_4_4_4B
+#define SPINOR_OP_PP_8_8_8	SPINOR_OP_PP_4B
+#define SPINOR_OP_PP_8D_8D_8D	SPINOR_OP_PP_4B
 
 /* Double Transfer Rate opcodes - defined in JEDEC JESD216B. */
 #define SPINOR_OP_READ_1_1_1_DTR	0x0d
@@ -91,7 +94,6 @@
 #define XSR_PAGESIZE		BIT(0)	/* Page size in Po2 or Linear */
 #define XSR_RDY			BIT(7)	/* Ready */
 
-
 /* Used for Macronix and Winbond flashes. */
 #define SPINOR_OP_EN4B		0xb7	/* Enter 4-byte mode */
 #define SPINOR_OP_EX4B		0xe9	/* Exit 4-byte mode */
@@ -137,6 +139,13 @@
 #define SR2_QUAD_EN_BIT1	BIT(1)
 #define SR2_QUAD_EN_BIT7	BIT(7)
 
+/* Configuration Register 2, JEDEC216-D */
+#define CR2_OCTAL_MODE_ADDR	0x0
+#define CR2_OCTAL_MODE_MASK	GENMASK(1, 0)
+#define CR2_SPI_MODE		0
+#define CR2_OCTAL_MODE_STR	1
+#define CR2_OCTAL_MODE_DTR	2
+
 /* Supported SPI protocols */
 #define SNOR_PROTO_INST_MASK	GENMASK(23, 16)
 #define SNOR_PROTO_INST_SHIFT	16
@@ -157,15 +166,21 @@
 	 SNOR_PROTO_DATA_MASK)
 
 #define SNOR_PROTO_IS_DTR	BIT(24)	/* Double Transfer Rate */
+#define SNOR_PROTO_IS_FULL_DTR	BIT(25)	/* Full Double Transfer Rate */
 
 #define SNOR_PROTO_STR(_inst_nbits, _addr_nbits, _data_nbits)	\
 	(SNOR_PROTO_INST(_inst_nbits) |				\
 	 SNOR_PROTO_ADDR(_addr_nbits) |				\
 	 SNOR_PROTO_DATA(_data_nbits))
+
 #define SNOR_PROTO_DTR(_inst_nbits, _addr_nbits, _data_nbits)	\
 	(SNOR_PROTO_IS_DTR |					\
 	 SNOR_PROTO_STR(_inst_nbits, _addr_nbits, _data_nbits))
 
+#define SNOR_PROTO_8D_8D_8D(_inst_nbits, _addr_nbits, _data_nbits)	\
+	(SNOR_PROTO_IS_FULL_DTR |					\
+	SNOR_PROTO_DTR(_inst_nbits, _addr_nbits, _data_nbits))
+
 enum spi_nor_protocol {
 	SNOR_PROTO_1_1_1 = SNOR_PROTO_STR(1, 1, 1),
 	SNOR_PROTO_1_1_2 = SNOR_PROTO_STR(1, 1, 2),
@@ -182,6 +197,7 @@ enum spi_nor_protocol {
 	SNOR_PROTO_1_2_2_DTR = SNOR_PROTO_DTR(1, 2, 2),
 	SNOR_PROTO_1_4_4_DTR = SNOR_PROTO_DTR(1, 4, 4),
 	SNOR_PROTO_1_8_8_DTR = SNOR_PROTO_DTR(1, 8, 8),
+	SNOR_PROTO_8_8_8_DTR = SNOR_PROTO_8D_8D_8D(8, 8, 8),
 };
 
 static inline bool spi_nor_protocol_is_dtr(enum spi_nor_protocol proto)
@@ -189,6 +205,16 @@ static inline bool spi_nor_protocol_is_dtr(enum spi_nor_protocol proto)
 	return !!(proto & SNOR_PROTO_IS_DTR);
 }
 
+static inline bool spi_nor_protocol_is_8_8_8(enum spi_nor_protocol proto)
+{
+	return !!(proto & SNOR_PROTO_8_8_8);
+}
+
+static inline bool spi_nor_protocol_is_8D_8D_8D(enum spi_nor_protocol proto)
+{
+	return !!(proto & SNOR_PROTO_IS_FULL_DTR);
+}
+
 static inline u8 spi_nor_get_protocol_inst_nbits(enum spi_nor_protocol proto)
 {
 	return ((unsigned long)(proto & SNOR_PROTO_INST_MASK)) >>
@@ -228,7 +254,7 @@ struct spi_nor_hwcaps {
  * then Quad SPI protocols before Dual SPI protocols, Fast Read and lastly
  * (Slow) Read.
  */
-#define SNOR_HWCAPS_READ_MASK		GENMASK(14, 0)
+#define SNOR_HWCAPS_READ_MASK		GENMASK(15, 0)
 #define SNOR_HWCAPS_READ		BIT(0)
 #define SNOR_HWCAPS_READ_FAST		BIT(1)
 #define SNOR_HWCAPS_READ_1_1_1_DTR	BIT(2)
@@ -250,6 +276,7 @@ struct spi_nor_hwcaps {
 #define SNOR_HWCAPS_READ_1_8_8		BIT(12)
 #define SNOR_HWCAPS_READ_8_8_8		BIT(13)
 #define SNOR_HWCAPS_READ_1_8_8_DTR	BIT(14)
+#define SNOR_HWCAPS_READ_8_8_8_DTR	BIT(15)
 
 /*
  * Page Program capabilities.
@@ -260,7 +287,7 @@ struct spi_nor_hwcaps {
  * JEDEC/SFDP standard to define them. Also at this moment no SPI flash memory
  * implements such commands.
  */
-#define SNOR_HWCAPS_PP_MASK	GENMASK(22, 16)
+#define SNOR_HWCAPS_PP_MASK	GENMASK(23, 16)
 #define SNOR_HWCAPS_PP		BIT(16)
 
 #define SNOR_HWCAPS_PP_QUAD	GENMASK(19, 17)
@@ -272,6 +299,13 @@ struct spi_nor_hwcaps {
 #define SNOR_HWCAPS_PP_1_1_8	BIT(20)
 #define SNOR_HWCAPS_PP_1_8_8	BIT(21)
 #define SNOR_HWCAPS_PP_8_8_8	BIT(22)
+#define SNOR_HWCAPS_PP_8_8_8_DTR	BIT(23)
+
+#define SNOR_HWCAPS_OPI_FULL_STR	(SNOR_HWCAPS_READ_8_8_8 | \
+					 SNOR_HWCAPS_PP_8_8_8)
+
+#define SNOR_HWCAPS_OPI_FULL_DTR	(SNOR_HWCAPS_READ_8_8_8_DTR | \
+					 SNOR_HWCAPS_PP_8_8_8_DTR)
 
 #define SNOR_HWCAPS_X_X_X	(SNOR_HWCAPS_READ_2_2_2 |	\
 				 SNOR_HWCAPS_READ_4_4_4 |	\
@@ -282,7 +316,9 @@ struct spi_nor_hwcaps {
 #define SNOR_HWCAPS_DTR		(SNOR_HWCAPS_READ_1_1_1_DTR |	\
 				 SNOR_HWCAPS_READ_1_2_2_DTR |	\
 				 SNOR_HWCAPS_READ_1_4_4_DTR |	\
-				 SNOR_HWCAPS_READ_1_8_8_DTR)
+				 SNOR_HWCAPS_READ_1_8_8_DTR |	\
+				 SNOR_HWCAPS_READ_8_8_8_DTR |	\
+				 SNOR_HWCAPS_PP_8_8_8_DTR)
 
 #define SNOR_HWCAPS_ALL		(SNOR_HWCAPS_READ_MASK |	\
 				 SNOR_HWCAPS_PP_MASK)
@@ -326,6 +362,11 @@ struct spi_nor_controller_ops {
 struct spi_nor_manufacturer;
 struct spi_nor_flash_parameter;
 
+enum extension_cmd_mode {
+	EXT_CMD_IS_REPEAT,
+	EXT_CMD_IS_INVERSE,
+};
+
 /**
  * struct spi_nor - Structure for defining a the SPI NOR layer
  * @mtd:		point to a mtd_info structure
@@ -335,6 +376,7 @@ struct spi_nor_controller_ops {
  * @bouncebuf:		bounce buffer used when the buffer passed by the MTD
  *                      layer is not DMA-able
  * @bouncebuf_size:	size of the bounce buffer
+ * @ext_cmd_mode:	xspi extension command mode, 0: repeat, 1:inverse
  * @info:		spi-nor part JDEC MFR id and other info
  * @manufacturer:	spi-nor manufacturer
  * @page_size:		the page size of the SPI NOR
@@ -363,6 +405,7 @@ struct spi_nor {
 	struct spi_mem		*spimem;
 	u8			*bouncebuf;
 	size_t			bouncebuf_size;
+	enum extension_cmd_mode ext_cmd_mode;
 	const struct flash_info	*info;
 	const struct spi_nor_manufacturer *manufacturer;
 	u32			page_size;
-- 
1.9.1

