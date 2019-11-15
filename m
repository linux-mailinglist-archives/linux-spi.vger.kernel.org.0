Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 744EBFDA58
	for <lists+linux-spi@lfdr.de>; Fri, 15 Nov 2019 11:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfKOKEC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 Nov 2019 05:04:02 -0500
Received: from twhmllg3.macronix.com ([122.147.135.201]:20683 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfKOKEC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 Nov 2019 05:04:02 -0500
Received: from TWHMLLG3.macronix.com (localhost [127.0.0.2] (may be forged))
        by TWHMLLG3.macronix.com with ESMTP id xAF8xw8U046952
        for <linux-spi@vger.kernel.org>; Fri, 15 Nov 2019 16:59:58 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id xAF8wWGv046218;
        Fri, 15 Nov 2019 16:58:34 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     broonie@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        marek.vasut@gmail.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, vigneshr@ti.com,
        bbrezillon@kernel.org, tudor.ambarus@microchip.com
Cc:     juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        Mason Yang <masonccyang@mxic.com.tw>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 2/4] mtd: spi-nor: Add support for Octal 8D-8D-8D mode
Date:   Fri, 15 Nov 2019 16:58:06 +0800
Message-Id: <1573808288-19365-3-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1573808288-19365-1-git-send-email-masonccyang@mxic.com.tw>
References: <1573808288-19365-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG3.macronix.com xAF8wWGv046218
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

According to JESD216C (JEDEC Basic Flash Parameter Table 18th DWORD)
Octal DTR(8D-8D-8D) command and command extension (00b: same, 01b: inverse)
to add extension command mode in spi_nor struct and to add write_cr2
(Write CFG Reg 2) for 8-8-8/8D-8D-8D mode sequences enable.

Define the relevant macrons and enum to add such modes and make sure
op->xxx.dtr fields, command nbytes and extension command are properly
filled and unmask DTR and X-X-X modes in spi_nor_spimem_adjust_hwcaps()
so that DTR and X-X-X support detection is done through
spi_mem_supports_op().

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 drivers/mtd/spi-nor/spi-nor.c | 159 ++++++++++++++++++++++++++++++++++++++++--
 include/linux/mtd/spi-nor.h   |  58 +++++++++++++--
 2 files changed, 206 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 7acf4a9..4cdf52d 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -320,6 +320,23 @@ static ssize_t spi_nor_spimem_read_data(struct spi_nor *nor, loff_t from,
 	/* convert the dummy cycles to the number of bytes */
 	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
 
+	if (spi_nor_protocol_is_8_8_8(nor->read_proto)) {
+		op.cmd.nbytes = 2;
+
+		if (nor->ext_cmd_mode == EXT_CMD_IS_INVERSE)
+			op.cmd.ext_opcode = ~nor->read_opcode;
+		else
+			op.cmd.ext_opcode = nor->read_opcode;
+
+		if (spi_nor_protocol_is_8D_8D_8D(nor->read_proto)) {
+			op.dummy.nbytes *= 2;
+			op.cmd.dtr = true;
+			op.addr.dtr = true;
+			op.dummy.dtr = true;
+			op.data.dtr = true;
+		}
+	}
+
 	return spi_nor_spimem_xfer_data(nor, &op);
 }
 
@@ -367,6 +384,21 @@ static ssize_t spi_nor_spimem_write_data(struct spi_nor *nor, loff_t to,
 	if (nor->program_opcode == SPINOR_OP_AAI_WP && nor->sst_write_second)
 		op.addr.nbytes = 0;
 
+	if (spi_nor_protocol_is_8_8_8(nor->write_proto)) {
+		op.cmd.nbytes = 2;
+
+		if (nor->ext_cmd_mode == EXT_CMD_IS_INVERSE)
+			op.cmd.ext_opcode = ~nor->program_opcode;
+		else
+			op.cmd.ext_opcode = nor->program_opcode;
+
+		if (spi_nor_protocol_is_8D_8D_8D(nor->write_proto)) {
+			op.cmd.dtr = true;
+			op.addr.dtr = true;
+			op.data.dtr = true;
+		}
+	}
+
 	return spi_nor_spimem_xfer_data(nor, &op);
 }
 
@@ -404,6 +436,30 @@ static int read_sr(struct spi_nor *nor)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_DATA_IN(1, nor->bouncebuf, 1));
 
+		if (spi_nor_protocol_is_8_8_8(nor->read_proto)) {
+			op.cmd.buswidth = 8;
+			op.addr.buswidth = 8;
+			op.dummy.buswidth = 8;
+			op.data.buswidth = 8;
+			op.cmd.nbytes = 2;
+			op.addr.nbytes = 4;
+			op.dummy.nbytes = 4;
+			op.addr.val = 0;
+
+			if (nor->ext_cmd_mode == EXT_CMD_IS_INVERSE)
+				op.cmd.ext_opcode = ~SPINOR_OP_RDSR;
+			else
+				op.cmd.ext_opcode = SPINOR_OP_RDSR;
+
+			if (spi_nor_protocol_is_8D_8D_8D(nor->read_proto)) {
+				op.dummy.nbytes *= 2;
+				op.cmd.dtr = true;
+				op.addr.dtr = true;
+				op.dummy.dtr = true;
+				op.data.dtr = true;
+			}
+		}
+
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
 		ret = nor->read_reg(nor, SPINOR_OP_RDSR, nor->bouncebuf, 1);
@@ -508,6 +564,19 @@ static int write_enable(struct spi_nor *nor)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_NO_DATA);
 
+		if (spi_nor_protocol_is_8_8_8(nor->write_proto)) {
+			op.cmd.buswidth = 8;
+			op.cmd.nbytes = 2;
+
+			if (spi_nor_protocol_is_8D_8D_8D(nor->write_proto))
+				op.cmd.dtr = true;
+
+			if (nor->ext_cmd_mode == EXT_CMD_IS_INVERSE)
+				op.cmd.ext_opcode = ~SPINOR_OP_WREN;
+			else
+				op.cmd.ext_opcode = SPINOR_OP_WREN;
+		}
+
 		return spi_mem_exec_op(nor->spimem, &op);
 	}
 
@@ -526,12 +595,65 @@ static int write_disable(struct spi_nor *nor)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_NO_DATA);
 
+		if (spi_nor_protocol_is_8_8_8(nor->write_proto)) {
+			op.cmd.buswidth = 8;
+			op.cmd.nbytes = 2;
+
+			if (spi_nor_protocol_is_8D_8D_8D(nor->write_proto))
+				op.cmd.dtr = true;
+
+			if (nor->ext_cmd_mode == EXT_CMD_IS_INVERSE)
+				op.cmd.ext_opcode = ~SPINOR_OP_WRDI;
+			else
+				op.cmd.ext_opcode = SPINOR_OP_WRDI;
+		}
+
 		return spi_mem_exec_op(nor->spimem, &op);
 	}
 
 	return nor->write_reg(nor, SPINOR_OP_WRDI, NULL, 0);
 }
 
+/*
+ * Write configuration register 2 one byte
+ * Returns negative if error occurred.
+ */
+static int write_cr2(struct spi_nor *nor, u32 addr, u8 val)
+{
+	write_enable(nor);
+
+	nor->bouncebuf[0] = val;
+	if (nor->spimem) {
+		struct spi_mem_op op =
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRCR2, 1),
+				   SPI_MEM_OP_ADDR(4, addr, 1),
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 1));
+
+		if (spi_nor_protocol_is_8_8_8(nor->write_proto)) {
+			op.cmd.buswidth = 8;
+			op.addr.buswidth = 8;
+			op.data.buswidth = 8;
+			op.cmd.nbytes = 2;
+
+			if (spi_nor_protocol_is_8D_8D_8D(nor->write_proto)) {
+				op.cmd.dtr = true;
+				op.addr.dtr = true;
+				op.data.dtr = true;
+			}
+
+			if (nor->ext_cmd_mode == EXT_CMD_IS_INVERSE)
+				op.cmd.ext_opcode = ~SPINOR_OP_WRCR2;
+			else
+				op.cmd.ext_opcode = SPINOR_OP_WRCR2;
+		}
+
+		return spi_mem_exec_op(nor->spimem, &op);
+	}
+
+	return -ENOTSUPP;
+}
+
 static struct spi_nor *mtd_to_spi_nor(struct mtd_info *mtd)
 {
 	return mtd->priv;
@@ -868,6 +990,19 @@ static int erase_chip(struct spi_nor *nor)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_NO_DATA);
 
+		if (spi_nor_protocol_is_8_8_8(nor->write_proto)) {
+			op.cmd.buswidth = 8;
+			op.cmd.nbytes = 2;
+
+			if (spi_nor_protocol_is_8D_8D_8D(nor->write_proto))
+				op.cmd.dtr = true;
+
+			if (nor->ext_cmd_mode == EXT_CMD_IS_INVERSE)
+				op.cmd.ext_opcode = ~SPINOR_OP_CHIP_ERASE;
+			else
+				op.cmd.ext_opcode = SPINOR_OP_CHIP_ERASE;
+		}
+
 		return spi_mem_exec_op(nor->spimem, &op);
 	}
 
@@ -945,6 +1080,22 @@ static int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_NO_DATA);
 
+		if (spi_nor_protocol_is_8_8_8(nor->write_proto)) {
+			op.cmd.buswidth = 8;
+			op.addr.buswidth = 8;
+			op.cmd.nbytes = 2;
+
+			if (spi_nor_protocol_is_8D_8D_8D(nor->write_proto)) {
+				op.cmd.dtr = true;
+				op.addr.dtr = true;
+			}
+
+			if (nor->ext_cmd_mode == EXT_CMD_IS_INVERSE)
+				op.cmd.ext_opcode = ~nor->erase_opcode;
+			else
+				op.cmd.ext_opcode = nor->erase_opcode;
+		}
+
 		return spi_mem_exec_op(nor->spimem, &op);
 	}
 
@@ -2825,6 +2976,7 @@ static int spi_nor_hwcaps_read2cmd(u32 hwcaps)
 		{ SNOR_HWCAPS_READ_1_8_8,	SNOR_CMD_READ_1_8_8 },
 		{ SNOR_HWCAPS_READ_8_8_8,	SNOR_CMD_READ_8_8_8 },
 		{ SNOR_HWCAPS_READ_1_8_8_DTR,	SNOR_CMD_READ_1_8_8_DTR },
+		{ SNOR_HWCAPS_READ_8_8_8_DTR,	SNOR_CMD_READ_8D_8D_8D },
 	};
 
 	return spi_nor_hwcaps2cmd(hwcaps, hwcaps_read2cmd,
@@ -2841,6 +2993,7 @@ static int spi_nor_hwcaps_pp2cmd(u32 hwcaps)
 		{ SNOR_HWCAPS_PP_1_1_8,		SNOR_CMD_PP_1_1_8 },
 		{ SNOR_HWCAPS_PP_1_8_8,		SNOR_CMD_PP_1_8_8 },
 		{ SNOR_HWCAPS_PP_8_8_8,		SNOR_CMD_PP_8_8_8 },
+		{ SNOR_HWCAPS_PP_8_8_8_DTR,	SNOR_CMD_PP_8D_8D_8D },
 	};
 
 	return spi_nor_hwcaps2cmd(hwcaps, hwcaps_pp2cmd,
@@ -3010,12 +3163,6 @@ static int spi_nor_spimem_check_pp(struct spi_nor *nor,
 	struct spi_nor_flash_parameter *params =  &nor->params;
 	unsigned int cap;
 
-	/* DTR modes are not supported yet, mask them all. */
-	*hwcaps &= ~SNOR_HWCAPS_DTR;
-
-	/* X-X-X modes are not supported yet, mask them all. */
-	*hwcaps &= ~SNOR_HWCAPS_X_X_X;
-
 	for (cap = 0; cap < sizeof(*hwcaps) * BITS_PER_BYTE; cap++) {
 		int rdidx, ppidx;
 
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index fc0b4b1..2e720ca 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -84,6 +84,9 @@
 #define SPINOR_OP_BE_4K_4B	0x21	/* Erase 4KiB block */
 #define SPINOR_OP_BE_32K_4B	0x5c	/* Erase 32KiB block */
 #define SPINOR_OP_SE_4B		0xdc	/* Sector erase (usually 64KiB) */
+#define SPINOR_OP_READ_8_8_8	SPINOR_OP_READ_1_4_4_4B
+#define SPINOR_OP_PP_8_8_8	SPINOR_OP_PP_4B
+#define SPINOR_OP_PP_8D_8D_8D	SPINOR_OP_PP_4B
 
 /* Double Transfer Rate opcodes - defined in JEDEC JESD216B. */
 #define SPINOR_OP_READ_1_1_1_DTR	0x0d
@@ -93,6 +96,7 @@
 #define SPINOR_OP_READ_1_1_1_DTR_4B	0x0e
 #define SPINOR_OP_READ_1_2_2_DTR_4B	0xbe
 #define SPINOR_OP_READ_1_4_4_DTR_4B	0xee
+#define SPINOR_OP_READ_8D_8D_8D		SPINOR_OP_READ_1_4_4_DTR_4B
 
 /* Used for SST flashes only. */
 #define SPINOR_OP_BP		0x02	/* Byte program */
@@ -107,6 +111,8 @@
 #define XSR_PAGESIZE		BIT(0)	/* Page size in Po2 or Linear */
 #define XSR_RDY			BIT(7)	/* Ready */
 
+/* Write CFG Reg 2 - defined in JEDEC JESD216C. */
+#define SPINOR_OP_WRCR2		0x72	/* Write configuration register 2 */
 
 /* Used for Macronix and Winbond flashes. */
 #define SPINOR_OP_EN4B		0xb7	/* Enter 4-byte mode */
@@ -150,6 +156,13 @@
 /* Status Register 2 bits. */
 #define SR2_QUAD_EN_BIT7	BIT(7)
 
+/* Configuration register 2, offset 0 */
+#define CR2_REG0		0x0
+#define CR2_REG0_MODE_MASK	GENMASK(1, 0)
+#define CR2_REG0_MODE_SPI	0
+#define CR2_REG0_MODE_OPI_STR	1
+#define CR2_REG0_MODE_OPI_DTR	2
+
 /* Supported SPI protocols */
 #define SNOR_PROTO_INST_MASK	GENMASK(23, 16)
 #define SNOR_PROTO_INST_SHIFT	16
@@ -170,6 +183,7 @@
 	 SNOR_PROTO_DATA_MASK)
 
 #define SNOR_PROTO_IS_DTR	BIT(24)	/* Double Transfer Rate */
+#define SNOR_PROTO_IS_8D_8D_8D	BIT(25) /* Full Octal DTR */
 
 #define SNOR_PROTO_STR(_inst_nbits, _addr_nbits, _data_nbits)	\
 	(SNOR_PROTO_INST(_inst_nbits) |				\
@@ -179,6 +193,10 @@
 	(SNOR_PROTO_IS_DTR |					\
 	 SNOR_PROTO_STR(_inst_nbits, _addr_nbits, _data_nbits))
 
+#define SNOR_PROTO_8D_8D_8D(_nbits)				\
+	(SNOR_PROTO_IS_8D_8D_8D |				\
+	 SNOR_PROTO_STR(_nbits, _nbits, _nbits))
+
 enum spi_nor_protocol {
 	SNOR_PROTO_1_1_1 = SNOR_PROTO_STR(1, 1, 1),
 	SNOR_PROTO_1_1_2 = SNOR_PROTO_STR(1, 1, 2),
@@ -195,6 +213,7 @@ enum spi_nor_protocol {
 	SNOR_PROTO_1_2_2_DTR = SNOR_PROTO_DTR(1, 2, 2),
 	SNOR_PROTO_1_4_4_DTR = SNOR_PROTO_DTR(1, 4, 4),
 	SNOR_PROTO_1_8_8_DTR = SNOR_PROTO_DTR(1, 8, 8),
+	SNOR_PROTO_8_8_8_DTR = SNOR_PROTO_8D_8D_8D(8),
 };
 
 static inline bool spi_nor_protocol_is_dtr(enum spi_nor_protocol proto)
@@ -202,6 +221,16 @@ static inline bool spi_nor_protocol_is_dtr(enum spi_nor_protocol proto)
 	return !!(proto & SNOR_PROTO_IS_DTR);
 }
 
+static inline bool spi_nor_protocol_is_8_8_8(enum spi_nor_protocol proto)
+{
+	return !!(proto & SNOR_PROTO_8_8_8);
+}
+
+static inline bool spi_nor_protocol_is_8D_8D_8D(enum spi_nor_protocol proto)
+{
+	return !!(proto & SNOR_PROTO_IS_8D_8D_8D);
+}
+
 static inline u8 spi_nor_get_protocol_inst_nbits(enum spi_nor_protocol proto)
 {
 	return ((unsigned long)(proto & SNOR_PROTO_INST_MASK)) >>
@@ -349,7 +378,7 @@ struct spi_nor_hwcaps {
  * then Quad SPI protocols before Dual SPI protocols, Fast Read and lastly
  * (Slow) Read.
  */
-#define SNOR_HWCAPS_READ_MASK		GENMASK(14, 0)
+#define SNOR_HWCAPS_READ_MASK		GENMASK(15, 0)
 #define SNOR_HWCAPS_READ		BIT(0)
 #define SNOR_HWCAPS_READ_FAST		BIT(1)
 #define SNOR_HWCAPS_READ_1_1_1_DTR	BIT(2)
@@ -366,11 +395,12 @@ struct spi_nor_hwcaps {
 #define SNOR_HWCAPS_READ_4_4_4		BIT(9)
 #define SNOR_HWCAPS_READ_1_4_4_DTR	BIT(10)
 
-#define SNOR_HWCAPS_READ_OCTAL		GENMASK(14, 11)
+#define SNOR_HWCAPS_READ_OCTAL		GENMASK(15, 11)
 #define SNOR_HWCAPS_READ_1_1_8		BIT(11)
 #define SNOR_HWCAPS_READ_1_8_8		BIT(12)
 #define SNOR_HWCAPS_READ_8_8_8		BIT(13)
 #define SNOR_HWCAPS_READ_1_8_8_DTR	BIT(14)
+#define SNOR_HWCAPS_READ_8_8_8_DTR	BIT(15)
 
 /*
  * Page Program capabilities.
@@ -381,7 +411,7 @@ struct spi_nor_hwcaps {
  * JEDEC/SFDP standard to define them. Also at this moment no SPI flash memory
  * implements such commands.
  */
-#define SNOR_HWCAPS_PP_MASK	GENMASK(22, 16)
+#define SNOR_HWCAPS_PP_MASK	GENMASK(23, 16)
 #define SNOR_HWCAPS_PP		BIT(16)
 
 #define SNOR_HWCAPS_PP_QUAD	GENMASK(19, 17)
@@ -389,10 +419,17 @@ struct spi_nor_hwcaps {
 #define SNOR_HWCAPS_PP_1_4_4	BIT(18)
 #define SNOR_HWCAPS_PP_4_4_4	BIT(19)
 
-#define SNOR_HWCAPS_PP_OCTAL	GENMASK(22, 20)
+#define SNOR_HWCAPS_PP_OCTAL	GENMASK(23, 20)
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
@@ -403,7 +440,9 @@ struct spi_nor_hwcaps {
 #define SNOR_HWCAPS_DTR		(SNOR_HWCAPS_READ_1_1_1_DTR |	\
 				 SNOR_HWCAPS_READ_1_2_2_DTR |	\
 				 SNOR_HWCAPS_READ_1_4_4_DTR |	\
-				 SNOR_HWCAPS_READ_1_8_8_DTR)
+				 SNOR_HWCAPS_READ_1_8_8_DTR |	\
+				 SNOR_HWCAPS_READ_8_8_8_DTR |	\
+				 SNOR_HWCAPS_PP_8_8_8_DTR)
 
 #define SNOR_HWCAPS_ALL		(SNOR_HWCAPS_READ_MASK |	\
 				 SNOR_HWCAPS_PP_MASK)
@@ -442,6 +481,7 @@ enum spi_nor_read_command_index {
 	SNOR_CMD_READ_1_8_8,
 	SNOR_CMD_READ_8_8_8,
 	SNOR_CMD_READ_1_8_8_DTR,
+	SNOR_CMD_READ_8D_8D_8D,
 
 	SNOR_CMD_READ_MAX
 };
@@ -458,6 +498,7 @@ enum spi_nor_pp_command_index {
 	SNOR_CMD_PP_1_1_8,
 	SNOR_CMD_PP_1_8_8,
 	SNOR_CMD_PP_8_8_8,
+	SNOR_CMD_PP_8D_8D_8D,
 
 	SNOR_CMD_PP_MAX
 };
@@ -528,6 +569,11 @@ struct spi_nor_flash_parameter {
  */
 struct flash_info;
 
+enum extension_cmd_mode {
+	EXT_CMD_IS_CMD,
+	EXT_CMD_IS_INVERSE,
+};
+
 /**
  * struct spi_nor - Structure for defining a the SPI NOR layer
  * @mtd:		point to a mtd_info structure
@@ -537,6 +583,7 @@ struct spi_nor_flash_parameter {
  * @bouncebuf:		bounce buffer used when the buffer passed by the MTD
  *                      layer is not DMA-able
  * @bouncebuf_size:	size of the bounce buffer
+ * @ext_cmd_mode:	extension command mode, 0: same, 1: inverse
  * @info:		spi-nor part JDEC MFR id and other info
  * @page_size:		the page size of the SPI NOR
  * @addr_width:		number of address bytes
@@ -575,6 +622,7 @@ struct spi_nor {
 	struct spi_mem		*spimem;
 	u8			*bouncebuf;
 	size_t			bouncebuf_size;
+	enum extension_cmd_mode	ext_cmd_mode;
 	const struct flash_info	*info;
 	u32			page_size;
 	u8			addr_width;
-- 
1.9.1

