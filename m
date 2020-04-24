Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0AE31B7E24
	for <lists+linux-spi@lfdr.de>; Fri, 24 Apr 2020 20:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgDXSp2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Apr 2020 14:45:28 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44098 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729360AbgDXSp1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 24 Apr 2020 14:45:27 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03OIjGG0102893;
        Fri, 24 Apr 2020 13:45:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587753916;
        bh=Qo2f7PhAhhjKsL7Xom9p7Ab/gXdZIunEpPYDYWx0qQc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pS9UVtEDUW2TZH8+U/EdsqvBzGGz+aNSIjpHqLUlchm0wErCMpc3Hoo7jRlalbSyh
         6UEojlJrOkD9UDU7R7d67wT3Rk/CwjNJx/hddj2dnru0c+htu7N9FP9rVBpu6DIDNQ
         rY/rSrjvRYgz5IZIX8VKtPRBm4Jh0lVgiCGAWhxw=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03OIjGN2023193
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Apr 2020 13:45:16 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 24
 Apr 2020 13:45:15 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 24 Apr 2020 13:45:15 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03OIiAaL047967;
        Fri, 24 Apr 2020 13:45:12 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v4 15/16] mtd: spi-nor: add support for Cypress Semper flash
Date:   Sat, 25 Apr 2020 00:14:09 +0530
Message-ID: <20200424184410.8578-16-p.yadav@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200424184410.8578-1-p.yadav@ti.com>
References: <20200424184410.8578-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Cypress Semper flash is an xSPI compliant octal DTR flash. Add
support for using it in octal DTR mode.

The flash by default boots in a hybrid sector mode. But the sector map
table on the part I had was programmed incorrectly and the SMPT values
on the flash don't match the public datasheet. Specifically, in some
places erase type 3 was used instead of 4. In addition, the region sizes
were incorrect in some places. So, for testing I set CFR3N[3] to enable
uniform sector sizes. Since the uniform sector mode bit is a
non-volatile bit, this series does not change it to avoid making any
permanent changes to the flash configuration. The correct data to
implement a fixup is not available right now and will be done in a
follow-up patch if needed.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/spansion.c | 167 +++++++++++++++++++++++++++++++++
 1 file changed, 167 insertions(+)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 88183eba8ac1..cc75134f579c 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -8,6 +8,168 @@
 
 #include "core.h"
 
+/* For Cypress flash. */
+#define SPINOR_OP_RD_ANY_REG			0x65	/* Read any register */
+#define SPINOR_OP_WR_ANY_REG			0x71	/* Write any register */
+#define SPINOR_REG_CYPRESS_CFR2V		0x00800003
+#define SPINOR_REG_CYPRESS_CFR2V_MEMLAT_8_20	0x8
+#define SPINOR_REG_CYPRESS_CFR3V		0x00800004
+#define SPINOR_REG_CYPRESS_CFR3V_PGSZ		BIT(4) /* Page size. */
+#define SPINOR_REG_CYPRESS_CFR4V		0x00800005
+#define SPINOR_REG_CYPRESS_CFR5V		0x00800006
+#define SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_EN	0x3
+#define SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_DS	0
+#define SPINOR_OP_CYPRESS_RD_FAST		0xee
+
+/**
+ * spi_nor_cypress_octal_enable() - Enable octal DTR mode on Cypress flashes.
+ * @nor:		pointer to a 'struct spi_nor'
+ *
+ * This also sets the memory access latency cycles to 20, which is the default
+ * in the spi-nor framework.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_cypress_octal_enable(struct spi_nor *nor, bool enable)
+{
+	struct spi_mem_op op;
+	u8 *buf = nor->bouncebuf;
+	u8 addr_width;
+	int ret;
+
+	if (enable)
+		addr_width = 3;
+	else
+		addr_width = 4;
+
+	if (enable) {
+		/* Use 20 dummy cycles for memory array reads. */
+		ret = spi_nor_write_enable(nor);
+		if (ret)
+			return ret;
+
+		*buf = SPINOR_REG_CYPRESS_CFR2V_MEMLAT_8_20;
+		op = (struct spi_mem_op)
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_ANY_REG, 1),
+				   SPI_MEM_OP_ADDR(addr_width,
+						   SPINOR_REG_CYPRESS_CFR2V,
+						   1),
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_DATA_OUT(1, buf, 1));
+		ret = spi_mem_exec_op(nor->spimem, &op);
+		if (ret) {
+			dev_warn(nor->dev,
+				 "failed to set default memory latency value: %d\n",
+				 ret);
+			return ret;
+		}
+		ret = spi_nor_wait_till_ready(nor);
+		if (ret)
+			return ret;
+
+		nor->read_dummy = 20;
+	}
+
+	/* Set/unset the octal and DTR enable bits. */
+	ret = spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+
+	if (enable)
+		*buf = SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_EN;
+	else
+		*buf = SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_DS;
+	op = (struct spi_mem_op)
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_ANY_REG, 1),
+			   SPI_MEM_OP_ADDR(addr_width,
+					   SPINOR_REG_CYPRESS_CFR5V,
+					   1),
+			   SPI_MEM_OP_NO_DUMMY,
+			   SPI_MEM_OP_DATA_OUT(1, buf, 1));
+
+	if (!enable)
+		spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
+
+	ret = spi_mem_exec_op(nor->spimem, &op);
+	if (ret) {
+		dev_warn(nor->dev, "Failed to enable octal DTR mode\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void s28hs512t_default_init(struct spi_nor *nor)
+{
+	nor->params->octal_dtr_enable = spi_nor_cypress_octal_enable;
+}
+
+static void s28hs512t_post_sfdp_fixup(struct spi_nor *nor)
+{
+	/*
+	 * On older versions of the flash the xSPI Profile 1.0 table has the
+	 * 8D-8D-8D Fast Read opcode as 0x00. But it actually should be 0xEE.
+	 */
+	if (nor->params->reads[SNOR_CMD_READ_8_8_8_DTR].opcode == 0)
+		nor->params->reads[SNOR_CMD_READ_8_8_8_DTR].opcode =
+			SPINOR_OP_CYPRESS_RD_FAST;
+
+	/* This flash is also missing the 4-byte Page Program opcode bit. */
+	spi_nor_set_pp_settings(&nor->params->page_programs[SNOR_CMD_PP],
+				SPINOR_OP_PP_4B, SNOR_PROTO_1_1_1);
+	/*
+	 * Since xSPI Page Program opcode is backward compatible with
+	 * Legacy SPI, use Legacy SPI opcode there as well.
+	 */
+	spi_nor_set_pp_settings(&nor->params->page_programs[SNOR_CMD_PP_8_8_8_DTR],
+				SPINOR_OP_PP_4B, SNOR_PROTO_8_8_8_DTR);
+
+	/*
+	 * The xSPI Profile 1.0 table advertises the number of additional
+	 * address bytes needed for Read Status Register command as 0 but the
+	 * actual value for that is 4.
+	 */
+	nor->params->rdsr_addr_nbytes = 4;
+}
+
+static int s28hs512t_post_bfpt_fixup(struct spi_nor *nor,
+				     const struct sfdp_parameter_header *bfpt_header,
+				     const struct sfdp_bfpt *bfpt,
+				     struct spi_nor_flash_parameter *params)
+{
+	struct spi_mem_op op;
+	u8 *buf = nor->bouncebuf;
+	u8 addr_width = 3;
+	int ret;
+
+	/*
+	 * The BFPT table advertises a 512B page size but the page size is
+	 * actually configurable (with the default being 256B). Read from
+	 * CFR3V[4] and set the correct size.
+	 */
+	op = (struct spi_mem_op)
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RD_ANY_REG, 1),
+			   SPI_MEM_OP_ADDR(addr_width, SPINOR_REG_CYPRESS_CFR3V, 1),
+			   SPI_MEM_OP_NO_DUMMY,
+			   SPI_MEM_OP_DATA_IN(1, buf, 1));
+	ret = spi_mem_exec_op(nor->spimem, &op);
+	if (ret)
+		return ret;
+
+	if (*buf & SPINOR_REG_CYPRESS_CFR3V_PGSZ)
+		params->page_size = 512;
+	else
+		params->page_size = 256;
+
+	return 0;
+}
+
+static struct spi_nor_fixups s28hs512t_fixups = {
+	.default_init = s28hs512t_default_init,
+	.post_sfdp = s28hs512t_post_sfdp_fixup,
+	.post_bfpt = s28hs512t_post_bfpt_fixup,
+};
+
 static const struct flash_info spansion_parts[] = {
 	/* Spansion/Cypress -- single (large) sector size only, at least
 	 * for the chips listed here (without boot sectors).
@@ -72,6 +234,11 @@ static const struct flash_info spansion_parts[] = {
 	{ "s25fl256l",  INFO(0x016019,      0,  64 * 1024, 512,
 			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
 			     SPI_NOR_4B_OPCODES) },
+	{ "s28hs512t",   INFO(0x345b1a,      0, 256 * 1024, 256,
+			     SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			     SPI_NOR_SOFT_RESET)
+		.fixups = &s28hs512t_fixups,
+	},
 };
 
 static void spansion_post_sfdp_fixups(struct spi_nor *nor)
-- 
2.25.0

