Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82674FDA56
	for <lists+linux-spi@lfdr.de>; Fri, 15 Nov 2019 11:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfKOKD7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 Nov 2019 05:03:59 -0500
Received: from twhmllg3.macronix.com ([122.147.135.201]:20679 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfKOKD7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 Nov 2019 05:03:59 -0500
X-Greylist: delayed 3848 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Nov 2019 05:03:59 EST
Received: from TWHMLLG3.macronix.com (localhost [127.0.0.2] (may be forged))
        by TWHMLLG3.macronix.com with ESMTP id xAF8xoZr046888
        for <linux-spi@vger.kernel.org>; Fri, 15 Nov 2019 16:59:50 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id xAF8wWGw046218;
        Fri, 15 Nov 2019 16:58:35 +0800 (GMT-8)
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
Subject: [PATCH 3/4] mtd: spi-nor: Add Octal 8D-8D-8D mode support for Macronix mx25uw51245g
Date:   Fri, 15 Nov 2019 16:58:07 +0800
Message-Id: <1573808288-19365-4-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1573808288-19365-1-git-send-email-masonccyang@mxic.com.tw>
References: <1573808288-19365-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG3.macronix.com xAF8wWGw046218
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

mx25uw51245g is a SPI NOR that supports 1-1-1/8-8-8 mode and the SFDPRD
command but returns an empty SFDP page. This forces us to add a new entry
in the flash_info table and patch spi_nor_fixups hooks to tweak flash
parameters for spi_nor_read/pp_setting() and then to enter
Octal 8D-8D-8D modes.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 drivers/mtd/spi-nor/spi-nor.c | 114 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/mtd/spi-nor.h   |   3 ++
 2 files changed, 117 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 4cdf52d..9013590 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -615,6 +615,56 @@ static int write_disable(struct spi_nor *nor)
 }
 
 /*
+ * Read configuration register 2, returning its value in the
+ * location. Return the configuration register 2 value.
+ * Returns negative if error occurred.
+ */
+static int read_cr2(struct spi_nor *nor, u32 addr)
+{
+	int ret;
+
+	if (nor->spimem) {
+		struct spi_mem_op op =
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDCR2, 1),
+				   SPI_MEM_OP_ADDR(4, addr, 1),
+				   SPI_MEM_OP_DUMMY(4, 1),
+				   SPI_MEM_OP_DATA_IN(1, nor->bouncebuf, 1));
+
+		if (spi_nor_protocol_is_8_8_8(nor->read_proto)) {
+			op.cmd.buswidth = 8;
+			op.addr.buswidth = 8;
+			op.dummy.buswidth = 8;
+			op.data.buswidth = 8;
+			op.cmd.nbytes = 2;
+
+			if (spi_nor_protocol_is_8D_8D_8D(nor->read_proto)) {
+				op.dummy.nbytes *= 2;
+				op.cmd.dtr = true;
+				op.addr.dtr = true;
+				op.dummy.dtr = true;
+				op.data.dtr = true;
+			}
+
+			if (nor->ext_cmd_mode == EXT_CMD_IS_INVERSE)
+				op.cmd.ext_opcode = ~SPINOR_OP_RDCR2;
+			else
+				op.cmd.ext_opcode = SPINOR_OP_RDCR2;
+		}
+
+		ret = spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret = -ENOTSUPP;
+	}
+
+	if (ret < 0) {
+		dev_err(nor->dev, "error %d reading CR\n", ret);
+		return ret;
+	}
+
+	return nor->bouncebuf[0];
+}
+
+/*
  * Write configuration register 2 one byte
  * Returns negative if error occurred.
  */
@@ -2275,10 +2325,72 @@ static int spi_nor_spansion_clear_sr_bp(struct spi_nor *nor)
 	return 0;
 }
 
+static void
+spi_nor_set_read_settings(struct spi_nor_read_command *read,
+			  u8 num_mode_clocks,
+			  u8 num_wait_states,
+			  u8 opcode,
+			  enum spi_nor_protocol proto);
+
+static void
+spi_nor_set_pp_settings(struct spi_nor_pp_command *pp,
+			u8 opcode,
+			enum spi_nor_protocol proto);
+
+static void
+mx25uw51245g_default_init(struct spi_nor *nor)
+{
+	struct spi_nor_flash_parameter *params = &nor->params;
+
+	if (!(nor->spimem->spi->mode & (SPI_RX_OCTAL | SPI_TX_OCTAL)))
+		return;
+
+	/* Octal 8S-8S-8S mode */
+	params->hwcaps.mask |= SNOR_HWCAPS_OPI_FULL_STR;
+	spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_8_8_8],
+				  0, 20, SPINOR_OP_READ_8_8_8,
+				  SNOR_PROTO_8_8_8);
+
+	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP_8_8_8],
+				SPINOR_OP_PP_8_8_8, SNOR_PROTO_8_8_8);
+
+	/* Octal 8D-8D-8D mode */
+	params->hwcaps.mask |= SNOR_HWCAPS_OPI_FULL_DTR;
+	spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_8D_8D_8D],
+				  0, 20, SPINOR_OP_READ_8D_8D_8D,
+				  SNOR_PROTO_8_8_8_DTR);
+
+	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP_8D_8D_8D],
+				SPINOR_OP_PP_8D_8D_8D, SNOR_PROTO_8_8_8_DTR);
+
+	nor->ext_cmd_mode = EXT_CMD_IS_INVERSE;
+}
+
+static void
+mx25uw51245g_post_sfdp_fixups(struct spi_nor *nor)
+{
+	struct spi_nor_flash_parameter *params = &nor->params;
+	u8 cr2;
+
+	cr2 = read_cr2(nor, CR2_REG0) & CR2_REG0_MODE_MASK;
+
+	if (params->hwcaps.mask & SNOR_HWCAPS_OPI_FULL_DTR)
+		cr2 |= CR2_REG0_MODE_OPI_DTR;
+	else if (params->hwcaps.mask & SNOR_HWCAPS_OPI_FULL_STR)
+		cr2 |= CR2_REG0_MODE_OPI_STR;
+
+	write_cr2(nor, CR2_REG0, cr2);
+}
+
 static struct spi_nor_fixups mx25l25635_fixups = {
 	.post_bfpt = mx25l25635_post_bfpt_fixups,
 };
 
+static struct spi_nor_fixups mx25uw51245g_fixups = {
+	.default_init = mx25uw51245g_default_init,
+	.post_sfdp = mx25uw51245g_post_sfdp_fixups,
+};
+
 static void gd25q256_default_init(struct spi_nor *nor)
 {
 	/*
@@ -2442,6 +2554,8 @@ static void gd25q256_default_init(struct spi_nor *nor)
 			 SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 			 .fixups = &mx25l25635_fixups },
 	{ "mx25u25635f", INFO(0xc22539, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_4B_OPCODES) },
+	{ "mx25uw51245g", INFO(0xc2813a, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_4B_OPCODES)
+				.fixups = &mx25uw51245g_fixups},
 	{ "mx25v8035f",  INFO(0xc22314, 0, 64 * 1024,  16,
 			 SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "mx25l25655e", INFO(0xc22619, 0, 64 * 1024, 512, 0) },
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 2e720ca..3aa54dd 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -114,6 +114,9 @@
 /* Write CFG Reg 2 - defined in JEDEC JESD216C. */
 #define SPINOR_OP_WRCR2		0x72	/* Write configuration register 2 */
 
+/* Used for Macronix flashes only */
+#define SPINOR_OP_RDCR2		0x71	/* Read configuration register 2 */
+
 /* Used for Macronix and Winbond flashes. */
 #define SPINOR_OP_EN4B		0xb7	/* Enter 4-byte mode */
 #define SPINOR_OP_EX4B		0xe9	/* Exit 4-byte mode */
-- 
1.9.1

