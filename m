Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF00205AD9
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jun 2020 20:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387561AbgFWScO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Jun 2020 14:32:14 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58530 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733199AbgFWScO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 23 Jun 2020 14:32:14 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05NIW2ai085902;
        Tue, 23 Jun 2020 13:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592937122;
        bh=MUa2mABD6A4sTRDUceLSSsTwRoGhKHB3xPjHXwIQ78Y=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ICzvkqn10zA/JrVeu5TwaNUG0fyj9MCxpsNLOOjD3+zsX7iIZbKRfGEbV5DpNtnGn
         z/tAFTuuJeCdsdq+yhFq6RSChrbh+8V7L1ieYiyXyaJx1BgnqFME0V4CtlCNTX+ECR
         bwXdbcDMD6TzvytTuRyIyGaPFmZ5oAkkMIOXhZUA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05NIW2Sg040536
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Jun 2020 13:32:02 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 23
 Jun 2020 13:32:02 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 23 Jun 2020 13:32:02 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05NIUVJV000942;
        Tue, 23 Jun 2020 13:31:57 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v10 17/17] mtd: spi-nor: micron-st: allow using MT35XU512ABA in Octal DTR mode
Date:   Wed, 24 Jun 2020 00:00:30 +0530
Message-ID: <20200623183030.26591-18-p.yadav@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200623183030.26591-1-p.yadav@ti.com>
References: <20200623183030.26591-1-p.yadav@ti.com>
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
 drivers/mtd/spi-nor/micron-st.c | 103 +++++++++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 3dca5b9af3b6..447b0166de2e 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -8,10 +8,111 @@
 
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
+	if (enable) {
+		/* Use 20 dummy cycles for memory array reads. */
+		ret = spi_nor_write_enable(nor);
+		if (ret)
+			return ret;
+
+		*buf = 20;
+		op = (struct spi_mem_op)
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_MT_WR_ANY_REG, 1),
+				   SPI_MEM_OP_ADDR(addr_width,
+						   SPINOR_REG_MT_CFR1V, 1),
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_DATA_OUT(1, buf, 1));
+		ret = spi_mem_exec_op(nor->spimem, &op);
+		if (ret)
+			return ret;
+
+		ret = spi_nor_wait_till_ready(nor);
+		if (ret)
+			return ret;
+	}
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
+static void mt35xu512aba_default_init(struct spi_nor *nor)
+{
+	nor->params->octal_dtr_enable = spi_nor_micron_octal_dtr_enable;
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
+
+	/*
+	 * The BFPT quad enable field is set to a reserved value so the quad
+	 * enable function is ignored by spi_nor_parse_bfpt(). Make sure we
+	 * disable it.
+	 */
+	nor->params->quad_enable = NULL;
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
+			       SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ)
+		.fixups = &mt35xu512aba_fixups},
 	{ "mt35xu02g", INFO(0x2c5b1c, 0, 128 * 1024, 2048,
 			    SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ |
 			    SPI_NOR_4B_OPCODES) },
-- 
2.27.0

