Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B751B7E1D
	for <lists+linux-spi@lfdr.de>; Fri, 24 Apr 2020 20:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgDXSop (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Apr 2020 14:44:45 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34750 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729105AbgDXSoo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 24 Apr 2020 14:44:44 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03OIiV4H095213;
        Fri, 24 Apr 2020 13:44:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587753871;
        bh=PEVP1dFloY1yNwAb7FoOgS8KGRUu9K+g0OvKw2COVIc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qbQOPBGyao184tK4g3oFqFPbLXycnF4TgiO1DTdIABYazbm+NoZCUZuNO5Zk37k4Y
         1mpZ0WoQq8t1NmFJ2Okm2WQ45b3/kMNaw9EcIqXPG3TKcoP6wXjp7OvePmu/NS+15c
         VQYl+t7c4gcihfzX+2zRQLixfrR+dCtLpMMf81Yg=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03OIiV5X022185
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Apr 2020 13:44:31 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 24
 Apr 2020 13:44:31 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 24 Apr 2020 13:44:31 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03OIiAaA047967;
        Fri, 24 Apr 2020 13:44:27 -0500
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
Subject: [PATCH v4 04/16] mtd: spi-nor: add support for DTR protocol
Date:   Sat, 25 Apr 2020 00:13:58 +0530
Message-ID: <20200424184410.8578-5-p.yadav@ti.com>
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

Double Transfer Rate (DTR) is SPI protocol in which data is transferred
on each clock edge as opposed to on each clock cycle. Make
framework-level changes to allow supporting flashes in DTR mode.

Right now, mixed DTR modes are not supported. So, for example a mode
like 4S-4D-4D will not work. All phases need to be either DTR or STR.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/core.c  | 295 ++++++++++++++++++++++++++++--------
 drivers/mtd/spi-nor/core.h  |   6 +
 drivers/mtd/spi-nor/sfdp.c  |   9 +-
 include/linux/mtd/spi-nor.h |  48 ++++--
 4 files changed, 281 insertions(+), 77 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index cc68ea84318e..c8c1a3260e91 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -40,6 +40,76 @@
 
 #define SPI_NOR_MAX_ADDR_WIDTH	4
 
+/**
+ * spi_nor_get_cmd_ext() - Get the command opcode extension based on the
+ *			   extension type.
+ * @nor:		pointer to a 'struct spi_nor'
+ * @op:			pointer to the 'struct spi_mem_op' whose properties
+ *			need to be initialized.
+ *
+ * Right now, only "repeat" and "invert" are supported.
+ *
+ * Return: The opcode extension.
+ */
+static u8 spi_nor_get_cmd_ext(const struct spi_nor *nor,
+			      const struct spi_mem_op *op)
+{
+	switch (nor->cmd_ext_type) {
+	case SPI_NOR_EXT_INVERT:
+		return ~op->cmd.opcode;
+
+	case SPI_NOR_EXT_REPEAT:
+		return op->cmd.opcode;
+
+	default:
+		dev_err(nor->dev, "Unknown command extension type\n");
+		return 0;
+	}
+}
+
+/**
+ * spi_nor_spimem_setup_op() - Set up common properties of a spi-mem op.
+ * @nor:		pointer to a 'struct spi_nor'
+ * @op:			pointer to the 'struct spi_mem_op' whose properties
+ *			need to be initialized.
+ * @proto:		the protocol from which the properties need to be set.
+ */
+void spi_nor_spimem_setup_op(const struct spi_nor *nor,
+			     struct spi_mem_op *op,
+			     const enum spi_nor_protocol proto)
+{
+	u8 ext;
+
+	op->cmd.buswidth = spi_nor_get_protocol_inst_nbits(proto);
+
+	if (op->addr.nbytes)
+		op->addr.buswidth = spi_nor_get_protocol_addr_nbits(proto);
+
+	if (op->dummy.nbytes)
+		op->dummy.buswidth = spi_nor_get_protocol_addr_nbits(proto);
+
+	if (op->data.nbytes)
+		op->data.buswidth = spi_nor_get_protocol_data_nbits(proto);
+
+	if (spi_nor_protocol_is_dtr(proto)) {
+		/*
+		 * spi-mem supports mixed DTR modes, but right now we can only
+		 * have all phases either DTR or STR. IOW, spi-mem can have
+		 * something like 4S-4D-4D, but spi-nor can't. So, set all 4
+		 * phases to either DTR or STR.
+		 */
+		op->cmd.dtr = op->addr.dtr = op->dummy.dtr
+			       = op->data.dtr = true;
+
+		/* 2 bytes per clock cycle in DTR mode. */
+		op->dummy.nbytes *= 2;
+
+		ext = spi_nor_get_cmd_ext(nor, op);
+		op->cmd.opcode = (op->cmd.opcode << 8) | ext;
+		op->cmd.nbytes = 2;
+	}
+}
+
 /**
  * spi_nor_spimem_bounce() - check if a bounce buffer is needed for the data
  *                           transfer
@@ -104,14 +174,12 @@ static ssize_t spi_nor_spimem_read_data(struct spi_nor *nor, loff_t from,
 	ssize_t nbytes;
 	int error;
 
-	/* get transfer protocols. */
-	op.cmd.buswidth = spi_nor_get_protocol_inst_nbits(nor->read_proto);
-	op.addr.buswidth = spi_nor_get_protocol_addr_nbits(nor->read_proto);
-	op.dummy.buswidth = op.addr.buswidth;
-	op.data.buswidth = spi_nor_get_protocol_data_nbits(nor->read_proto);
+	spi_nor_spimem_setup_op(nor, &op, nor->read_proto);
 
 	/* convert the dummy cycles to the number of bytes */
 	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
+	if (spi_nor_protocol_is_dtr(nor->read_proto))
+		op.dummy.nbytes *= 2;
 
 	usebouncebuf = spi_nor_spimem_bounce(nor, &op);
 
@@ -169,13 +237,11 @@ static ssize_t spi_nor_spimem_write_data(struct spi_nor *nor, loff_t to,
 	ssize_t nbytes;
 	int error;
 
-	op.cmd.buswidth = spi_nor_get_protocol_inst_nbits(nor->write_proto);
-	op.addr.buswidth = spi_nor_get_protocol_addr_nbits(nor->write_proto);
-	op.data.buswidth = spi_nor_get_protocol_data_nbits(nor->write_proto);
-
 	if (nor->program_opcode == SPINOR_OP_AAI_WP && nor->sst_write_second)
 		op.addr.nbytes = 0;
 
+	spi_nor_spimem_setup_op(nor, &op, nor->write_proto);
+
 	if (spi_nor_spimem_bounce(nor, &op))
 		memcpy(nor->bouncebuf, buf, op.data.nbytes);
 
@@ -227,10 +293,16 @@ int spi_nor_write_enable(struct spi_nor *nor)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_NO_DATA);
 
+		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
+
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WREN,
-						     NULL, 0);
+		if (spi_nor_protocol_is_dtr(nor->reg_proto))
+			ret = -ENOTSUPP;
+		else
+			ret = nor->controller_ops->write_reg(nor,
+							     SPINOR_OP_WREN,
+							     NULL, 0);
 	}
 
 	if (ret)
@@ -256,10 +328,16 @@ int spi_nor_write_disable(struct spi_nor *nor)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_NO_DATA);
 
+		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
+
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WRDI,
-						     NULL, 0);
+		if (spi_nor_protocol_is_dtr(nor->reg_proto))
+			ret = -ENOTSUPP;
+		else
+			ret = nor->controller_ops->write_reg(nor,
+							     SPINOR_OP_WRDI,
+							     NULL, 0);
 	}
 
 	if (ret)
@@ -318,10 +396,15 @@ static int spi_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_DATA_IN(1, fsr, 1));
 
+		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
+
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDFSR,
-						    fsr, 1);
+		if (spi_nor_protocol_is_dtr(nor->reg_proto))
+			ret = -ENOTSUPP;
+		else
+			ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDFSR,
+							    fsr, 1);
 	}
 
 	if (ret)
@@ -350,9 +433,15 @@ static int spi_nor_read_cr(struct spi_nor *nor, u8 *cr)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_DATA_IN(1, cr, 1));
 
+		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
+
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDCR, cr, 1);
+		if (spi_nor_protocol_is_dtr(nor->reg_proto))
+			ret = -ENOTSUPP;
+		else
+			ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDCR,
+							    cr, 1);
 	}
 
 	if (ret)
@@ -383,12 +472,17 @@ int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 				  SPI_MEM_OP_NO_DUMMY,
 				  SPI_MEM_OP_NO_DATA);
 
+		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
+
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->write_reg(nor,
-						     enable ? SPINOR_OP_EN4B :
-							      SPINOR_OP_EX4B,
-						     NULL, 0);
+		if (spi_nor_protocol_is_dtr(nor->reg_proto))
+			ret = -ENOTSUPP;
+		else
+			ret = nor->controller_ops->write_reg(nor,
+						enable ? SPINOR_OP_EN4B :
+							 SPINOR_OP_EX4B,
+						NULL, 0);
 	}
 
 	if (ret)
@@ -419,10 +513,15 @@ static int spansion_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 1));
 
+		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
+
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_BRWR,
-						     nor->bouncebuf, 1);
+		if (spi_nor_protocol_is_dtr(nor->reg_proto))
+			ret = -ENOTSUPP;
+		else
+			ret = nor->controller_ops->write_reg(nor, SPINOR_OP_BRWR,
+							     nor->bouncebuf, 1);
 	}
 
 	if (ret)
@@ -451,10 +550,16 @@ int spi_nor_write_ear(struct spi_nor *nor, u8 ear)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 1));
 
+		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
+
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WREAR,
-						     nor->bouncebuf, 1);
+		if (spi_nor_protocol_is_dtr(nor->reg_proto))
+			ret = -ENOTSUPP;
+		else
+			ret = nor->controller_ops->write_reg(nor,
+							     SPINOR_OP_WREAR,
+							     nor->bouncebuf, 1);
 	}
 
 	if (ret)
@@ -482,10 +587,16 @@ int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_DATA_IN(1, sr, 1));
 
+		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
+
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_XRDSR,
-						    sr, 1);
+		if (spi_nor_protocol_is_dtr(nor->reg_proto))
+			ret = -ENOTSUPP;
+		else
+			ret = nor->controller_ops->read_reg(nor,
+							    SPINOR_OP_XRDSR,
+							    sr, 1);
 	}
 
 	if (ret)
@@ -527,10 +638,16 @@ static void spi_nor_clear_sr(struct spi_nor *nor)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_NO_DATA);
 
+		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
+
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_CLSR,
-						     NULL, 0);
+		if (spi_nor_protocol_is_dtr(nor->reg_proto))
+			ret = -ENOTSUPP;
+		else
+			ret = nor->controller_ops->write_reg(nor,
+							     SPINOR_OP_CLSR,
+							     NULL, 0);
 	}
 
 	if (ret)
@@ -591,10 +708,16 @@ static void spi_nor_clear_fsr(struct spi_nor *nor)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_NO_DATA);
 
+		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
+
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_CLFSR,
-						     NULL, 0);
+		if (spi_nor_protocol_is_dtr(nor->reg_proto))
+			ret = -ENOTSUPP;
+		else
+			ret = nor->controller_ops->write_reg(nor,
+							     SPINOR_OP_CLFSR,
+							     NULL, 0);
 	}
 
 	if (ret)
@@ -735,10 +858,16 @@ static int spi_nor_write_sr(struct spi_nor *nor, const u8 *sr, size_t len)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_DATA_OUT(len, sr, 1));
 
+		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
+
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR,
-						     sr, len);
+		if (spi_nor_protocol_is_dtr(nor->reg_proto))
+			ret = -ENOTSUPP;
+		else
+			ret = nor->controller_ops->write_reg(nor,
+							     SPINOR_OP_WRSR,
+							     sr, len);
 	}
 
 	if (ret) {
@@ -937,10 +1066,16 @@ static int spi_nor_write_sr2(struct spi_nor *nor, const u8 *sr2)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_DATA_OUT(1, sr2, 1));
 
+		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
+
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR2,
-						     sr2, 1);
+		if (spi_nor_protocol_is_dtr(nor->reg_proto))
+			ret = -ENOTSUPP;
+		else
+			ret = nor->controller_ops->write_reg(nor,
+							     SPINOR_OP_WRSR2,
+							     sr2, 1);
 	}
 
 	if (ret) {
@@ -971,10 +1106,16 @@ static int spi_nor_read_sr2(struct spi_nor *nor, u8 *sr2)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_DATA_IN(1, sr2, 1));
 
+		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
+
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDSR2,
-						    sr2, 1);
+		if (spi_nor_protocol_is_dtr(nor->reg_proto))
+			ret = -ENOTSUPP;
+		else
+			ret = nor->controller_ops->read_reg(nor,
+							    SPINOR_OP_RDSR2,
+							    sr2, 1);
 	}
 
 	if (ret)
@@ -1002,10 +1143,16 @@ static int spi_nor_erase_chip(struct spi_nor *nor)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_NO_DATA);
 
+		spi_nor_spimem_setup_op(nor, &op, nor->write_proto);
+
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_CHIP_ERASE,
-						     NULL, 0);
+		if (spi_nor_protocol_is_dtr(nor->write_proto))
+			ret = -ENOTSUPP;
+		else
+			ret = nor->controller_ops->write_reg(nor,
+							     SPINOR_OP_CHIP_ERASE,
+							     NULL, 0);
 	}
 
 	if (ret)
@@ -1144,7 +1291,11 @@ static int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_NO_DATA);
 
+		spi_nor_spimem_setup_op(nor, &op, nor->write_proto);
+
 		return spi_mem_exec_op(nor->spimem, &op);
+	} else if (spi_nor_protocol_is_dtr(nor->write_proto)) {
+		return -ENOTSUPP;
 	} else if (nor->controller_ops->erase) {
 		return nor->controller_ops->erase(nor, addr);
 	}
@@ -2253,6 +2404,7 @@ int spi_nor_hwcaps_read2cmd(u32 hwcaps)
 		{ SNOR_HWCAPS_READ_1_8_8,	SNOR_CMD_READ_1_8_8 },
 		{ SNOR_HWCAPS_READ_8_8_8,	SNOR_CMD_READ_8_8_8 },
 		{ SNOR_HWCAPS_READ_1_8_8_DTR,	SNOR_CMD_READ_1_8_8_DTR },
+		{ SNOR_HWCAPS_READ_8_8_8_DTR,	SNOR_CMD_READ_8_8_8_DTR },
 	};
 
 	return spi_nor_hwcaps2cmd(hwcaps, hwcaps_read2cmd,
@@ -2269,6 +2421,7 @@ static int spi_nor_hwcaps_pp2cmd(u32 hwcaps)
 		{ SNOR_HWCAPS_PP_1_1_8,		SNOR_CMD_PP_1_1_8 },
 		{ SNOR_HWCAPS_PP_1_8_8,		SNOR_CMD_PP_1_8_8 },
 		{ SNOR_HWCAPS_PP_8_8_8,		SNOR_CMD_PP_8_8_8 },
+		{ SNOR_HWCAPS_PP_8_8_8_DTR,	SNOR_CMD_PP_8_8_8_DTR },
 	};
 
 	return spi_nor_hwcaps2cmd(hwcaps, hwcaps_pp2cmd,
@@ -2322,13 +2475,11 @@ static int spi_nor_spimem_check_readop(struct spi_nor *nor,
 					  SPI_MEM_OP_DUMMY(0, 1),
 					  SPI_MEM_OP_DATA_IN(0, NULL, 1));
 
-	op.cmd.buswidth = spi_nor_get_protocol_inst_nbits(read->proto);
-	op.addr.buswidth = spi_nor_get_protocol_addr_nbits(read->proto);
-	op.data.buswidth = spi_nor_get_protocol_data_nbits(read->proto);
-	op.dummy.buswidth = op.addr.buswidth;
 	op.dummy.nbytes = (read->num_mode_clocks + read->num_wait_states) *
 			  op.dummy.buswidth / 8;
 
+	spi_nor_spimem_setup_op(nor, &op, read->proto);
+
 	return spi_nor_spimem_check_op(nor, &op);
 }
 
@@ -2348,9 +2499,7 @@ static int spi_nor_spimem_check_pp(struct spi_nor *nor,
 					  SPI_MEM_OP_NO_DUMMY,
 					  SPI_MEM_OP_DATA_OUT(0, NULL, 1));
 
-	op.cmd.buswidth = spi_nor_get_protocol_inst_nbits(pp->proto);
-	op.addr.buswidth = spi_nor_get_protocol_addr_nbits(pp->proto);
-	op.data.buswidth = spi_nor_get_protocol_data_nbits(pp->proto);
+	spi_nor_spimem_setup_op(nor, &op, pp->proto);
 
 	return spi_nor_spimem_check_op(nor, &op);
 }
@@ -2368,11 +2517,10 @@ spi_nor_spimem_adjust_hwcaps(struct spi_nor *nor, u32 *hwcaps)
 	struct spi_nor_flash_parameter *params = nor->params;
 	unsigned int cap;
 
-	/* DTR modes are not supported yet, mask them all. */
-	*hwcaps &= ~SNOR_HWCAPS_DTR;
-
-	/* X-X-X modes are not supported yet, mask them all. */
-	*hwcaps &= ~SNOR_HWCAPS_X_X_X;
+	/* 2-2-2 and 4-4-4 modes are not supported yet, mask them all. */
+	*hwcaps &= ~(SNOR_HWCAPS_READ_2_2_2 |
+		     SNOR_HWCAPS_READ_4_4_4 |
+		     SNOR_HWCAPS_PP_4_4_4);
 
 	for (cap = 0; cap < sizeof(*hwcaps) * BITS_PER_BYTE; cap++) {
 		int rdidx, ppidx;
@@ -2779,6 +2927,13 @@ static void spi_nor_info_init_params(struct spi_nor *nor)
 	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP],
 				SPINOR_OP_PP, SNOR_PROTO_1_1_1);
 
+	/*
+	 * Since xSPI Page Program opcode is backward compatible with
+	 * Legacy SPI, use Legacy SPI opcode there as well.
+	 */
+	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP_8_8_8_DTR],
+				SPINOR_OP_PP, SNOR_PROTO_8_8_8_DTR);
+
 	/*
 	 * Sector Erase settings. Sort Erase Types in ascending order, with the
 	 * smallest erase size starting at BIT(0).
@@ -2886,7 +3041,8 @@ static int spi_nor_init_params(struct spi_nor *nor)
 
 	spi_nor_manufacturer_init_params(nor);
 
-	if ((nor->info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)) &&
+	if ((nor->info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+				 SPI_NOR_OCTAL_READ | SPI_NOR_OCTAL_DTR_READ)) &&
 	    !(nor->info->flags & SPI_NOR_SKIP_SFDP))
 		spi_nor_sfdp_init_params(nor);
 
@@ -2948,7 +3104,9 @@ static int spi_nor_init(struct spi_nor *nor)
 		return err;
 	}
 
-	if (nor->addr_width == 4 && !(nor->flags & SNOR_F_4B_OPCODES)) {
+	if (nor->addr_width == 4 &&
+	    !(nor->info->flags & SPI_NOR_OCTAL_DTR_READ) &&
+	    !(nor->flags & SNOR_F_4B_OPCODES)) {
 		/*
 		 * If the RESET# pin isn't hooked up properly, or the system
 		 * otherwise doesn't perform a reset command in the boot
@@ -3007,6 +3165,9 @@ static int spi_nor_set_addr_width(struct spi_nor *nor)
 {
 	if (nor->addr_width) {
 		/* already configured from SFDP */
+	} else if (spi_nor_protocol_is_dtr(nor->read_proto)) {
+		 /* Always use 4-byte addresses in DTR mode. */
+		nor->addr_width = 4;
 	} else if (nor->info->addr_width) {
 		nor->addr_width = nor->info->addr_width;
 	} else if (nor->mtd.size > 0x1000000) {
@@ -3244,14 +3405,19 @@ static int spi_nor_create_read_dirmap(struct spi_nor *nor)
 	};
 	struct spi_mem_op *op = &info.op_tmpl;
 
-	/* get transfer protocols. */
-	op->cmd.buswidth = spi_nor_get_protocol_inst_nbits(nor->read_proto);
-	op->addr.buswidth = spi_nor_get_protocol_addr_nbits(nor->read_proto);
-	op->dummy.buswidth = op->addr.buswidth;
-	op->data.buswidth = spi_nor_get_protocol_data_nbits(nor->read_proto);
+	spi_nor_spimem_setup_op(nor, op, nor->read_proto);
 
 	/* convert the dummy cycles to the number of bytes */
 	op->dummy.nbytes = (nor->read_dummy * op->dummy.buswidth) / 8;
+	if (spi_nor_protocol_is_dtr(nor->read_proto))
+		op->dummy.nbytes *= 2;
+
+	/*
+	 * Since spi_nor_spimem_setup_op() only sets buswidth when the number
+	 * of data bytes is non-zero, the data buswidth won't be set here. So,
+	 * do it explicitly.
+	 */
+	op->data.buswidth = spi_nor_get_protocol_data_nbits(nor->read_proto);
 
 	nor->dirmap.rdesc = devm_spi_mem_dirmap_create(nor->dev, nor->spimem,
 						       &info);
@@ -3270,15 +3436,18 @@ static int spi_nor_create_write_dirmap(struct spi_nor *nor)
 	};
 	struct spi_mem_op *op = &info.op_tmpl;
 
-	/* get transfer protocols. */
-	op->cmd.buswidth = spi_nor_get_protocol_inst_nbits(nor->write_proto);
-	op->addr.buswidth = spi_nor_get_protocol_addr_nbits(nor->write_proto);
-	op->dummy.buswidth = op->addr.buswidth;
-	op->data.buswidth = spi_nor_get_protocol_data_nbits(nor->write_proto);
-
 	if (nor->program_opcode == SPINOR_OP_AAI_WP && nor->sst_write_second)
 		op->addr.nbytes = 0;
 
+	spi_nor_spimem_setup_op(nor, op, nor->write_proto);
+
+	/*
+	 * Since spi_nor_spimem_setup_op() only sets buswidth when the number
+	 * of data bytes is non-zero, the data buswidth won't be set here. So,
+	 * do it explicitly.
+	 */
+	op->data.buswidth = spi_nor_get_protocol_data_nbits(nor->write_proto);
+
 	nor->dirmap.wdesc = devm_spi_mem_dirmap_create(nor->dev, nor->spimem,
 						       &info);
 	return PTR_ERR_OR_ZERO(nor->dirmap.wdesc);
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 6f2f6b27173f..de1e3917889f 100644
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
@@ -311,6 +313,7 @@ struct flash_info {
 					 * BP3 is bit 6 of status register.
 					 * Must be used with SPI_NOR_4BIT_BP.
 					 */
+#define SPI_NOR_OCTAL_DTR_READ	BIT(19) /* Flash supports octal DTR Read. */
 
 	/* Part specific fixup hooks. */
 	const struct spi_nor_fixups *fixups;
@@ -399,6 +402,9 @@ extern const struct spi_nor_manufacturer spi_nor_winbond;
 extern const struct spi_nor_manufacturer spi_nor_xilinx;
 extern const struct spi_nor_manufacturer spi_nor_xmc;
 
+void spi_nor_spimem_setup_op(const struct spi_nor *nor,
+			     struct spi_mem_op *op,
+			     const enum spi_nor_protocol proto);
 int spi_nor_write_enable(struct spi_nor *nor);
 int spi_nor_write_disable(struct spi_nor *nor);
 int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable);
diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index f6038d3a3684..f917631c8110 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -1044,9 +1044,16 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
 	}
 
 	/* 4BAIT is the only SFDP table that indicates page program support. */
-	if (pp_hwcaps & SNOR_HWCAPS_PP)
+	if (pp_hwcaps & SNOR_HWCAPS_PP) {
 		spi_nor_set_pp_settings(&params_pp[SNOR_CMD_PP],
 					SPINOR_OP_PP_4B, SNOR_PROTO_1_1_1);
+		/*
+		 * Since xSPI Page Program opcode is backward compatible with
+		 * Legacy SPI, use Legacy SPI opcode there as well.
+		 */
+		spi_nor_set_pp_settings(&params_pp[SNOR_CMD_PP_8_8_8_DTR],
+					SPINOR_OP_PP_4B, SNOR_PROTO_8_8_8_DTR);
+	}
 	if (pp_hwcaps & SNOR_HWCAPS_PP_1_1_4)
 		spi_nor_set_pp_settings(&params_pp[SNOR_CMD_PP_1_1_4],
 					SPINOR_OP_PP_1_1_4_4B,
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 1cc8ed5d59ed..9bb41d9401c6 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -182,6 +182,7 @@ enum spi_nor_protocol {
 	SNOR_PROTO_1_2_2_DTR = SNOR_PROTO_DTR(1, 2, 2),
 	SNOR_PROTO_1_4_4_DTR = SNOR_PROTO_DTR(1, 4, 4),
 	SNOR_PROTO_1_8_8_DTR = SNOR_PROTO_DTR(1, 8, 8),
+	SNOR_PROTO_8_8_8_DTR = SNOR_PROTO_DTR(8, 8, 8),
 };
 
 static inline bool spi_nor_protocol_is_dtr(enum spi_nor_protocol proto)
@@ -228,7 +229,7 @@ struct spi_nor_hwcaps {
  * then Quad SPI protocols before Dual SPI protocols, Fast Read and lastly
  * (Slow) Read.
  */
-#define SNOR_HWCAPS_READ_MASK		GENMASK(14, 0)
+#define SNOR_HWCAPS_READ_MASK		GENMASK(15, 0)
 #define SNOR_HWCAPS_READ		BIT(0)
 #define SNOR_HWCAPS_READ_FAST		BIT(1)
 #define SNOR_HWCAPS_READ_1_1_1_DTR	BIT(2)
@@ -245,11 +246,12 @@ struct spi_nor_hwcaps {
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
@@ -260,18 +262,19 @@ struct spi_nor_hwcaps {
  * JEDEC/SFDP standard to define them. Also at this moment no SPI flash memory
  * implements such commands.
  */
-#define SNOR_HWCAPS_PP_MASK	GENMASK(22, 16)
-#define SNOR_HWCAPS_PP		BIT(16)
+#define SNOR_HWCAPS_PP_MASK		GENMASK(23, 16)
+#define SNOR_HWCAPS_PP			BIT(16)
 
-#define SNOR_HWCAPS_PP_QUAD	GENMASK(19, 17)
-#define SNOR_HWCAPS_PP_1_1_4	BIT(17)
-#define SNOR_HWCAPS_PP_1_4_4	BIT(18)
-#define SNOR_HWCAPS_PP_4_4_4	BIT(19)
+#define SNOR_HWCAPS_PP_QUAD		GENMASK(19, 17)
+#define SNOR_HWCAPS_PP_1_1_4		BIT(17)
+#define SNOR_HWCAPS_PP_1_4_4		BIT(18)
+#define SNOR_HWCAPS_PP_4_4_4		BIT(19)
 
-#define SNOR_HWCAPS_PP_OCTAL	GENMASK(22, 20)
-#define SNOR_HWCAPS_PP_1_1_8	BIT(20)
-#define SNOR_HWCAPS_PP_1_8_8	BIT(21)
-#define SNOR_HWCAPS_PP_8_8_8	BIT(22)
+#define SNOR_HWCAPS_PP_OCTAL		GENMASK(23, 20)
+#define SNOR_HWCAPS_PP_1_1_8		BIT(20)
+#define SNOR_HWCAPS_PP_1_8_8		BIT(21)
+#define SNOR_HWCAPS_PP_8_8_8		BIT(22)
+#define SNOR_HWCAPS_PP_8_8_8_DTR	BIT(23)
 
 #define SNOR_HWCAPS_X_X_X	(SNOR_HWCAPS_READ_2_2_2 |	\
 				 SNOR_HWCAPS_READ_4_4_4 |	\
@@ -282,7 +285,8 @@ struct spi_nor_hwcaps {
 #define SNOR_HWCAPS_DTR		(SNOR_HWCAPS_READ_1_1_1_DTR |	\
 				 SNOR_HWCAPS_READ_1_2_2_DTR |	\
 				 SNOR_HWCAPS_READ_1_4_4_DTR |	\
-				 SNOR_HWCAPS_READ_1_8_8_DTR)
+				 SNOR_HWCAPS_READ_1_8_8_DTR |	\
+				 SNOR_HWCAPS_READ_8_8_8_DTR)
 
 #define SNOR_HWCAPS_ALL		(SNOR_HWCAPS_READ_MASK |	\
 				 SNOR_HWCAPS_PP_MASK)
@@ -318,6 +322,22 @@ struct spi_nor_controller_ops {
 	int (*erase)(struct spi_nor *nor, loff_t offs);
 };
 
+/**
+ * enum spi_nor_cmd_ext - describes the command opcode extension in DTR mode
+ * @SPI_NOR_EXT_NONE: no extension. This is the default, and is used in Legacy
+ *		      SPI mode
+ * @SPI_NOR_EXT_REPEAT: the extension is same as the opcode
+ * @SPI_NOR_EXT_INVERT: the extension is the bitwise inverse of the opcode
+ * @SPI_NOR_EXT_HEX: the extension is any hex value. The command and opcode
+ *		     combine to form a 16-bit opcode.
+ */
+enum spi_nor_cmd_ext {
+	SPI_NOR_EXT_NONE = 0,
+	SPI_NOR_EXT_REPEAT,
+	SPI_NOR_EXT_INVERT,
+	SPI_NOR_EXT_HEX,
+};
+
 /*
  * Forward declarations that are used internally by the core and manufacturer
  * drivers.
@@ -345,6 +365,7 @@ struct spi_nor_flash_parameter;
  * @program_opcode:	the program opcode
  * @sst_write_second:	used by the SST write operation
  * @flags:		flag options for the current SPI-NOR (SNOR_F_*)
+ * @cmd_ext_type:	the command opcode extension type for DTR mode.
  * @read_proto:		the SPI protocol for read operations
  * @write_proto:	the SPI protocol for write operations
  * @reg_proto		the SPI protocol for read_reg/write_reg/erase operations
@@ -376,6 +397,7 @@ struct spi_nor {
 	enum spi_nor_protocol	reg_proto;
 	bool			sst_write_second;
 	u32			flags;
+	enum spi_nor_cmd_ext	cmd_ext_type;
 
 	const struct spi_nor_controller_ops *controller_ops;
 
-- 
2.25.0

