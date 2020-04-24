Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDD61B7E27
	for <lists+linux-spi@lfdr.de>; Fri, 24 Apr 2020 20:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbgDXSpc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Apr 2020 14:45:32 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34892 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729397AbgDXSpa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 24 Apr 2020 14:45:30 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03OIjKZ2095355;
        Fri, 24 Apr 2020 13:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587753920;
        bh=UH5bBvBGVrJjTafJ+gSzJOdBHusIlSmwCEeBQbkbkZU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=EQkzd/o73J4uLP5eHaM9zqdUohbUN1/szI6Z8qspz9uLmN0miLa+KbvpW4tYrZk8m
         siwdFNslG92nFNfi9i2EDl1K26qONCYGTmZJVfN6kNZ3p6B4g4SQ2aBbSIe/2nGSkd
         aqMVX+sCPsvq5zRgWKrVEsnuk2cVwtSuiCeG7HyE=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03OIjK3X086888;
        Fri, 24 Apr 2020 13:45:20 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 24
 Apr 2020 13:45:19 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 24 Apr 2020 13:45:19 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03OIiAaM047967;
        Fri, 24 Apr 2020 13:45:16 -0500
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
Subject: [PATCH v4 16/16] mtd: spi-nor: allow using MT35XU512ABA in Octal DTR mode
Date:   Sat, 25 Apr 2020 00:14:10 +0530
Message-ID: <20200424184410.8578-17-p.yadav@ti.com>
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

Since this flash doesn't have a Profile 1.0 table, the Octal DTR
capabilities are enabled in the post SFDP fixup, along with the 8D-8D-8D
fast read settings.

Enable Octal DTR mode with 20 dummy cycles to allow running at the
maximum supported frequency of 200Mhz.

The flash supports the soft reset sequence. So, add the flag in the
flash's info.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/micron-st.c | 113 +++++++++++++++++++++++++++++++-
 1 file changed, 112 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 02c0b53f6097..5a1f0428032f 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -8,10 +8,121 @@
 
 #include "core.h"
 
+#define SPINOR_OP_MT_DTR_RD	0xfd	/* Fast Read opcode in DTR mode */
+#define SPINOR_OP_MT_RD_ANY_REG	0x85	/* Read volatile register */
+#define SPINOR_OP_MT_WR_ANY_REG	0x81	/* Write volatile register */
+#define SPINOR_REG_MT_CFR0V	0x00	/* For setting octal DTR mode */
+#define SPINOR_REG_MT_CFR1V	0x01	/* For setting dummy cycles */
+#define SPINOR_MT_DTR_NO_DQS	0xc7	/* Enable Octal DTR without DQS. */
+#define SPINOR_MT_EXSPI		0xff	/* Enable Extended SPI (default) */
+
+static int spi_nor_micron_octal_dtr_enable(struct spi_nor *nor, bool enable)
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
+	ret = spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+
+	if (enable)
+		*buf = SPINOR_MT_DTR_NO_DQS;
+	else
+		*buf = SPINOR_MT_EXSPI;
+	op = (struct spi_mem_op)
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_MT_WR_ANY_REG, 1),
+			   SPI_MEM_OP_ADDR(addr_width, SPINOR_REG_MT_CFR0V, 1),
+			   SPI_MEM_OP_NO_DUMMY,
+			   SPI_MEM_OP_DATA_OUT(1, buf, 1));
+
+	if (!enable)
+		spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
+
+	ret = spi_mem_exec_op(nor->spimem, &op);
+	if (ret) {
+		dev_err(nor->dev, "Failed to enable octal DTR mode\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int mt35xu512aba_setup(struct spi_nor *nor,
+			      const struct spi_nor_hwcaps *hwcaps)
+{
+	struct spi_mem_op op;
+	u8 *buf = nor->bouncebuf;
+	u8 addr_width = 3;
+	int ret;
+
+	if (!nor->spimem) {
+		dev_err(nor->dev,
+			"operation not supported for non-spimem drivers\n");
+		return -ENOTSUPP;
+	}
+
+	/* Set dummy cycles for Fast Read to the default of 20. */
+	ret = spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+
+	*buf = 20;
+	op = (struct spi_mem_op)
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_MT_WR_ANY_REG, 1),
+			   SPI_MEM_OP_ADDR(addr_width, SPINOR_REG_MT_CFR1V, 1),
+			   SPI_MEM_OP_NO_DUMMY,
+			   SPI_MEM_OP_DATA_OUT(1, buf, 1));
+	ret = spi_mem_exec_op(nor->spimem, &op);
+	if (ret)
+		return ret;
+
+	ret = spi_nor_wait_till_ready(nor);
+	if (ret)
+		return ret;
+
+
+	return spi_nor_default_setup(nor, hwcaps);
+}
+
+static void mt35xu512aba_default_init(struct spi_nor *nor)
+{
+	nor->params->octal_dtr_enable = spi_nor_micron_octal_dtr_enable;
+	nor->params->setup = mt35xu512aba_setup;
+}
+
+static void mt35xu512aba_post_sfdp_fixup(struct spi_nor *nor)
+{
+	/* Set the Fast Read settings. */
+	nor->params->hwcaps.mask |= SNOR_HWCAPS_READ_8_8_8_DTR;
+	spi_nor_set_read_settings(&nor->params->reads[SNOR_CMD_READ_8_8_8_DTR],
+				  0, 20, SPINOR_OP_MT_DTR_RD,
+				  SNOR_PROTO_8_8_8_DTR);
+
+	nor->params->hwcaps.mask |= SNOR_HWCAPS_PP_8_8_8_DTR;
+
+	nor->cmd_ext_type = SPI_NOR_EXT_REPEAT;
+	nor->params->rdsr_dummy = 8;
+	nor->params->rdsr_addr_nbytes = 0;
+}
+
+static struct spi_nor_fixups mt35xu512aba_fixups = {
+	.default_init = mt35xu512aba_default_init,
+	.post_sfdp = mt35xu512aba_post_sfdp_fixup,
+};
+
 static const struct flash_info micron_parts[] = {
 	{ "mt35xu512aba", INFO(0x2c5b1a, 0, 128 * 1024, 512,
 			       SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ |
-			       SPI_NOR_4B_OPCODES) },
+			       SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ |
+			       SPI_NOR_SOFT_RESET)
+		.fixups = &mt35xu512aba_fixups},
 	{ "mt35xu02g", INFO(0x2c5b1c, 0, 128 * 1024, 2048,
 			    SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ |
 			    SPI_NOR_4B_OPCODES) },
-- 
2.25.0

