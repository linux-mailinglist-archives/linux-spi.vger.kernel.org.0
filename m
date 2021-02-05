Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393D2310956
	for <lists+linux-spi@lfdr.de>; Fri,  5 Feb 2021 11:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhBEKmT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Feb 2021 05:42:19 -0500
Received: from twhmllg3.macronix.com ([122.147.135.201]:57807 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhBEKjs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 5 Feb 2021 05:39:48 -0500
Received: from TWHMLLG3.macronix.com (localhost [127.0.0.2] (may be forged))
        by TWHMLLG3.macronix.com with ESMTP id 1159e663015502
        for <linux-spi@vger.kernel.org>; Fri, 5 Feb 2021 17:40:06 +0800 (GMT-8)
        (envelope-from zhengxunli@mxic.com.tw)
Received: from localhost.localdomain ([172.17.195.94])
        by TWHMLLG3.macronix.com with ESMTP id 1159cf8F014367;
        Fri, 5 Feb 2021 17:39:04 +0800 (GMT-8)
        (envelope-from zhengxunli@mxic.com.tw)
From:   zhengxunli <zhengxunli@mxic.com.tw>
To:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        miquel.raynal@bootlin.com, broonie@kernel.org, vigneshr@ti.com
Cc:     ycllin@mxic.com.tw, juliensu@mxic.com.tw,
        zhengxunli <zhengxunli@mxic.com.tw>
Subject: [PATCH v2 1/2] mtd: spi-nor: macronix: add support for Macronix octaflash
Date:   Fri,  5 Feb 2021 17:36:47 +0800
Message-Id: <1612517808-10010-2-git-send-email-zhengxunli@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1612517808-10010-1-git-send-email-zhengxunli@mxic.com.tw>
References: <1612517808-10010-1-git-send-email-zhengxunli@mxic.com.tw>
X-MAIL: TWHMLLG3.macronix.com 1159cf8F014367
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The ocatflash is an xSPI compliant octal DTR flash. Add support
for using it in octal DTR mode.

Enable Octal DTR mode with 20 dummy cycles to allow running at the
maximum supported frequency of 200Mhz.

Try to verify the flash ID to check whether the flash memory in octal
DTR mode is correct. When reading ID in OCTAL DTR mode, ID will appear
in a repeated manner. ex: ID[0] = 0xc2, ID[1] = 0xc2, ID[2] = 0x94,
ID[3] = 0x94... Rearrange the order so that the ID can pass.

Signed-off-by: zhengxunli <zhengxunli@mxic.com.tw>
---
 drivers/mtd/spi-nor/macronix.c | 121 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index 9203aba..7498978 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -8,6 +8,16 @@
 
 #include "core.h"
 
+#define SPINOR_OP_RD_CR2		0x71		/* Read configuration register 2 */
+#define SPINOR_OP_WR_CR2		0x72		/* Write configuration register 2 */
+#define SPINOR_OP_MXIC_DTR_RD		0xee		/* Fast Read opcode in DTR mode */
+#define SPINOR_REG_MXIC_CR2_MODE	0x00000000	/* For setting octal DTR mode */
+#define SPINOR_REG_MXIC_OPI_DTR_EN	0x2		/* Enable Octal DTR */
+#define SPINOR_REG_MXIC_OPI_DTR_DIS	0x1		/* Disable Octal DTR */
+#define SPINOR_REG_MXIC_CR2_DC		0x00000300	/* For setting dummy cycles */
+#define SPINOR_REG_MXIC_DC_20		0x0		/* Setting dummy cycles to 20 */
+#define MXIC_MAX_DC			20		/* Maximum value of dummy cycles */
+
 static int
 mx25l25635_post_bfpt_fixups(struct spi_nor *nor,
 			    const struct sfdp_parameter_header *bfpt_header,
@@ -33,6 +43,113 @@
 	.post_bfpt = mx25l25635_post_bfpt_fixups,
 };
 
+/**
+ * spi_nor_macronix_octal_dtr_enable() - Enable octal DTR on Macronix flashes.
+ * @nor:		pointer to a 'struct spi_nor'
+ * @enable:		whether to enable or disable Octal DTR
+ *
+ * This also sets the memory access dummy cycles to 20 to allow the flash to
+ * run at up to 200MHz.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_macronix_octal_dtr_enable(struct spi_nor *nor, bool enable)
+{
+	struct spi_mem_op op;
+	u8 *buf = nor->bouncebuf, i;
+	int ret;
+
+	if (enable) {
+		/* Use 20 dummy cycles for memory array reads. */
+		ret = spi_nor_write_enable(nor);
+		if (ret)
+			return ret;
+
+		*buf = SPINOR_REG_MXIC_DC_20;
+		op = (struct spi_mem_op)
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_CR2, 1),
+				   SPI_MEM_OP_ADDR(4, SPINOR_REG_MXIC_CR2_DC, 1),
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_DATA_OUT(1, buf, 1));
+
+		ret = spi_mem_exec_op(nor->spimem, &op);
+		if (ret)
+			return ret;
+
+		ret = spi_nor_wait_till_ready(nor);
+		if (ret)
+			return ret;
+
+		nor->read_dummy = MXIC_MAX_DC;
+	}
+
+	/* Set/unset the octal and DTR enable bits. */
+	ret = spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+
+	if (enable)
+		*buf = SPINOR_REG_MXIC_OPI_DTR_EN;
+	else
+		*buf = SPINOR_REG_MXIC_OPI_DTR_DIS;
+
+	op = (struct spi_mem_op)
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_CR2, 1),
+			   SPI_MEM_OP_ADDR(4, SPINOR_REG_MXIC_CR2_MODE, 1),
+			   SPI_MEM_OP_NO_DUMMY,
+			   SPI_MEM_OP_DATA_OUT(1, buf, 1));
+
+	if (!enable)
+		spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
+
+	ret = spi_mem_exec_op(nor->spimem, &op);
+	if (ret)
+		return ret;
+
+	/* Read flash ID to make sure the switch was successful. */
+	op = (struct spi_mem_op)
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDID, 1),
+			   SPI_MEM_OP_ADDR(enable ? 4 : 0, 0, 1),
+			   SPI_MEM_OP_DUMMY(enable ? 4 : 0, 1),
+			   SPI_MEM_OP_DATA_IN(SPI_NOR_MAX_ID_LEN, buf, 1));
+
+	if (enable)
+		spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
+
+	ret = spi_mem_exec_op(nor->spimem, &op);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nor->info->id_len; i++)
+		if (buf[i * 2] != nor->info->id[i])
+			return -EINVAL;
+
+	return 0;
+}
+
+static void octaflash_default_init(struct spi_nor *nor)
+{
+	nor->params->octal_dtr_enable = spi_nor_macronix_octal_dtr_enable;
+}
+
+static void octaflash_post_sfdp_fixup(struct spi_nor *nor)
+{
+	/* Set the Fast Read settings. */
+	nor->params->hwcaps.mask |= SNOR_HWCAPS_READ_8_8_8_DTR;
+	spi_nor_set_read_settings(&nor->params->reads[SNOR_CMD_READ_8_8_8_DTR],
+				  0, MXIC_MAX_DC, SPINOR_OP_MXIC_DTR_RD,
+				  SNOR_PROTO_8_8_8_DTR);
+
+	nor->cmd_ext_type = SPI_NOR_EXT_INVERT;
+	nor->params->rdsr_dummy = 4;
+	nor->params->rdsr_addr_nbytes = 4;
+}
+
+static struct spi_nor_fixups octaflash_fixups = {
+	.default_init = octaflash_default_init,
+	.post_sfdp = octaflash_post_sfdp_fixup,
+};
+
 static const struct flash_info macronix_parts[] = {
 	/* Macronix */
 	{ "mx25l512e",   INFO(0xc22010, 0, 64 * 1024,   1, SECT_4K) },
@@ -90,6 +207,10 @@
 	{ "mx66u2g45g",	 INFO(0xc2253c, 0, 64 * 1024, 4096,
 			      SECT_4K | SPI_NOR_DUAL_READ |
 			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ "mx66uw2g345g", INFO(0xc2943c, 0, 64 * 1024, 4096,
+			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
 };
 
 static void macronix_default_init(struct spi_nor *nor)
-- 
1.9.1

