Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3D57158FFC
	for <lists+linux-spi@lfdr.de>; Tue, 11 Feb 2020 14:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbgBKNeZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 Feb 2020 08:34:25 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57938 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbgBKNeW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 Feb 2020 08:34:22 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01BDY5b3085659;
        Tue, 11 Feb 2020 07:34:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581428045;
        bh=ai88WCP5SKZSSL0FxIM4l73lBCLmcfoDuLUcfpa2/C0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lr6bmJnK1v85zBrKH9kKmhl600X2onb5vDR3RFj0B1SMESJ0gCyIlGanyEKmorBvN
         WGq4aT2PGjSstFH/a2uqMDiVRyDYwLX+NGOaZLvgrNHTt8UK6Zz8G+uQhLhrjLjVz8
         G29riTK7G2D4cd5O5x54zc5IH+GW50YUQeejvdz0=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01BDY5ck070559
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Feb 2020 07:34:05 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 11
 Feb 2020 07:34:04 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 11 Feb 2020 07:34:04 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01BDXm5L087522;
        Tue, 11 Feb 2020 07:34:01 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>
Subject: [PATCH 4/9] mtd: spi-nor: add support for DTR protocol
Date:   Tue, 11 Feb 2020 19:03:43 +0530
Message-ID: <20200211133348.15558-5-p.yadav@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211133348.15558-1-p.yadav@ti.com>
References: <20200211133348.15558-1-p.yadav@ti.com>
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
 drivers/mtd/spi-nor/spi-nor.c | 245 ++++++++++++++++++++++++++--------
 include/linux/mtd/spi-nor.h   |  34 +++--
 2 files changed, 213 insertions(+), 66 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 4fc632ec18fe..371e56f3cdab 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -238,6 +238,7 @@ struct flash_info {
 					 * status register. Must be used with
 					 * SPI_NOR_HAS_TB.
 					 */
+#define SPI_NOR_OCTAL_DTR_READ	BIT(18)	/* Flash supports octal DTR Read. */
 
 	/* Part specific fixup hooks. */
 	const struct spi_nor_fixups *fixups;
@@ -245,6 +246,46 @@ struct flash_info {
 
 #define JEDEC_MFR(info)	((info)->id[0])
 
+/**
+ * spi_nor_spimem_setup_op() - Set up common properties of a spi-mem op.
+ * @nor:		pointer to a 'struct spi_nor'
+ * @op:			pointer to the 'struct spi_mem_op' whose properties
+ *			need to be initialized.
+ * @proto:		the protocol from which the properties need to be set.
+ */
+static void spi_nor_spimem_setup_op(const struct spi_nor *nor,
+				    struct spi_mem_op *op,
+				    const enum spi_nor_protocol proto)
+{
+
+	op->cmd.buswidth = spi_nor_get_protocol_inst_nbits(proto);
+
+	if (op->addr.nbytes)
+		op->addr.buswidth = spi_nor_get_protocol_addr_nbits(proto);
+
+	if (op->dummy.nbytes)
+		op->dummy.buswidth = spi_nor_get_protocol_addr_nbits(proto);
+
+	if (op->data.buf.in || op->data.buf.out)
+		op->data.buswidth = spi_nor_get_protocol_data_nbits(proto);
+
+	if (spi_nor_protocol_is_dtr(proto)) {
+		/*
+		 * spi-mem supports mixed DTR modes, but right now we can only
+		 * have all phases either DTR or STR. IOW, spi-mem can have
+		 * something like 4S-4D-4D, but spi-nor can't. So, set all 4
+		 * phases to either DTR or STR.
+		 */
+		op->cmd.is_dtr = op->addr.is_dtr = op->dummy.is_dtr
+			       = op->data.is_dtr = true;
+
+		/* 2 bytes per clock cycle in DTR mode. */
+		op->dummy.nbytes *= 2;
+
+		op->cmd.ext_type = nor->cmd_ext;
+	}
+}
+
 /**
  * spi_nor_spimem_xfer_data() - helper function to read/write data to
  *                              flash's memory region
@@ -316,14 +357,12 @@ static ssize_t spi_nor_spimem_read_data(struct spi_nor *nor, loff_t from,
 			   SPI_MEM_OP_DUMMY(nor->read_dummy, 1),
 			   SPI_MEM_OP_DATA_IN(len, buf, 1));
 
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
 
 	return spi_nor_spimem_xfer_data(nor, &op);
 }
@@ -365,13 +404,11 @@ static ssize_t spi_nor_spimem_write_data(struct spi_nor *nor, loff_t to,
 			   SPI_MEM_OP_NO_DUMMY,
 			   SPI_MEM_OP_DATA_OUT(len, buf, 1));
 
-	op.cmd.buswidth = spi_nor_get_protocol_inst_nbits(nor->write_proto);
-	op.addr.buswidth = spi_nor_get_protocol_addr_nbits(nor->write_proto);
-	op.data.buswidth = spi_nor_get_protocol_data_nbits(nor->write_proto);
-
 	if (nor->program_opcode == SPINOR_OP_AAI_WP && nor->sst_write_second)
 		op.addr.nbytes = 0;
 
+	spi_nor_spimem_setup_op(nor, &op, nor->write_proto);
+
 	return spi_nor_spimem_xfer_data(nor, &op);
 }
 
@@ -410,10 +447,16 @@ static int spi_nor_write_enable(struct spi_nor *nor)
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
@@ -439,10 +482,16 @@ static int spi_nor_write_disable(struct spi_nor *nor)
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
@@ -501,10 +550,15 @@ static int spi_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
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
@@ -533,9 +587,15 @@ static int spi_nor_read_cr(struct spi_nor *nor, u8 *cr)
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
@@ -566,12 +626,17 @@ static int macronix_set_4byte(struct spi_nor *nor, bool enable)
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
@@ -624,10 +689,15 @@ static int spansion_set_4byte(struct spi_nor *nor, bool enable)
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
@@ -656,10 +726,16 @@ static int spi_nor_write_ear(struct spi_nor *nor, u8 ear)
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
@@ -719,10 +795,16 @@ static int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr)
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
@@ -764,10 +846,16 @@ static void spi_nor_clear_sr(struct spi_nor *nor)
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
@@ -817,10 +905,16 @@ static void spi_nor_clear_fsr(struct spi_nor *nor)
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
@@ -950,10 +1044,16 @@ static int spi_nor_write_sr(struct spi_nor *nor, const u8 *sr, size_t len)
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
@@ -1152,10 +1252,16 @@ static int spi_nor_write_sr2(struct spi_nor *nor, const u8 *sr2)
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
@@ -1186,10 +1292,16 @@ static int spi_nor_read_sr2(struct spi_nor *nor, u8 *sr2)
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
@@ -1217,10 +1329,16 @@ static int spi_nor_erase_chip(struct spi_nor *nor)
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
@@ -1379,7 +1497,11 @@ static int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
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
@@ -3045,6 +3167,7 @@ static int spi_nor_hwcaps_read2cmd(u32 hwcaps)
 		{ SNOR_HWCAPS_READ_1_8_8,	SNOR_CMD_READ_1_8_8 },
 		{ SNOR_HWCAPS_READ_8_8_8,	SNOR_CMD_READ_8_8_8 },
 		{ SNOR_HWCAPS_READ_1_8_8_DTR,	SNOR_CMD_READ_1_8_8_DTR },
+		{ SNOR_HWCAPS_READ_8_8_8_DTR,	SNOR_CMD_READ_8_8_8_DTR },
 	};
 
 	return spi_nor_hwcaps2cmd(hwcaps, hwcaps_read2cmd,
@@ -3061,6 +3184,7 @@ static int spi_nor_hwcaps_pp2cmd(u32 hwcaps)
 		{ SNOR_HWCAPS_PP_1_1_8,		SNOR_CMD_PP_1_1_8 },
 		{ SNOR_HWCAPS_PP_1_8_8,		SNOR_CMD_PP_1_8_8 },
 		{ SNOR_HWCAPS_PP_8_8_8,		SNOR_CMD_PP_8_8_8 },
+		{ SNOR_HWCAPS_PP_8_8_8_DTR,	SNOR_CMD_PP_8_8_8_DTR },
 	};
 
 	return spi_nor_hwcaps2cmd(hwcaps, hwcaps_pp2cmd,
@@ -3184,13 +3308,11 @@ static int spi_nor_spimem_check_readop(struct spi_nor *nor,
 					  SPI_MEM_OP_DUMMY(0, 1),
 					  SPI_MEM_OP_DATA_IN(0, NULL, 1));
 
-	op.cmd.buswidth = spi_nor_get_protocol_inst_nbits(read->proto);
-	op.addr.buswidth = spi_nor_get_protocol_addr_nbits(read->proto);
-	op.data.buswidth = spi_nor_get_protocol_data_nbits(read->proto);
-	op.dummy.buswidth = op.addr.buswidth;
 	op.dummy.nbytes = (read->num_mode_clocks + read->num_wait_states) *
 			  op.dummy.buswidth / 8;
 
+	spi_nor_spimem_setup_op(nor, &op, nor->read_proto);
+
 	return spi_nor_spimem_check_op(nor, &op);
 }
 
@@ -3210,9 +3332,7 @@ static int spi_nor_spimem_check_pp(struct spi_nor *nor,
 					  SPI_MEM_OP_NO_DUMMY,
 					  SPI_MEM_OP_DATA_OUT(0, NULL, 1));
 
-	op.cmd.buswidth = spi_nor_get_protocol_inst_nbits(pp->proto);
-	op.addr.buswidth = spi_nor_get_protocol_addr_nbits(pp->proto);
-	op.data.buswidth = spi_nor_get_protocol_data_nbits(pp->proto);
+	spi_nor_spimem_setup_op(nor, &op, nor->write_proto);
 
 	return spi_nor_spimem_check_op(nor, &op);
 }
@@ -3230,11 +3350,10 @@ spi_nor_spimem_adjust_hwcaps(struct spi_nor *nor, u32 *hwcaps)
 	struct spi_nor_flash_parameter *params =  &nor->params;
 	unsigned int cap;
 
-	/* DTR modes are not supported yet, mask them all. */
-	*hwcaps &= ~SNOR_HWCAPS_DTR;
-
-	/* X-X-X modes are not supported yet, mask them all. */
-	*hwcaps &= ~SNOR_HWCAPS_X_X_X;
+	/* 2-2-2 and 4-4-4 modes are not supported yet, mask them all. */
+	*hwcaps &= ~(SNOR_HWCAPS_READ_2_2_2 |	\
+		     SNOR_HWCAPS_READ_4_4_4 |	\
+		     SNOR_HWCAPS_PP_4_4_4);
 
 	for (cap = 0; cap < sizeof(*hwcaps) * BITS_PER_BYTE; cap++) {
 		int rdidx, ppidx;
@@ -4240,9 +4359,16 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
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
@@ -4797,6 +4923,13 @@ static void spi_nor_info_init_params(struct spi_nor *nor)
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
@@ -4924,7 +5057,8 @@ static void spi_nor_init_params(struct spi_nor *nor)
 
 	spi_nor_manufacturer_init_params(nor);
 
-	if ((nor->info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)) &&
+	if ((nor->info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+				 SPI_NOR_OCTAL_READ | SPI_NOR_OCTAL_DTR_READ)) &&
 	    !(nor->info->flags & SPI_NOR_SKIP_SFDP))
 		spi_nor_sfdp_init_params(nor);
 
@@ -4984,7 +5118,9 @@ static int spi_nor_init(struct spi_nor *nor)
 		return err;
 	}
 
-	if (nor->addr_width == 4 && !(nor->flags & SNOR_F_4B_OPCODES)) {
+	if (nor->addr_width == 4 &&
+	    !(nor->info->flags & SPI_NOR_OCTAL_DTR_READ) &&
+	    !(nor->flags & SNOR_F_4B_OPCODES)) {
 		/*
 		 * If the RESET# pin isn't hooked up properly, or the system
 		 * otherwise doesn't perform a reset command in the boot
@@ -5038,6 +5174,9 @@ static int spi_nor_set_addr_width(struct spi_nor *nor)
 {
 	if (nor->addr_width) {
 		/* already configured from SFDP */
+	} else if (spi_nor_protocol_is_dtr(nor->read_proto)) {
+		 /* Always use 4-byte addresses in DTR mode. */
+		nor->addr_width = 4;
 	} else if (nor->info->addr_width) {
 		nor->addr_width = nor->info->addr_width;
 	} else if (nor->mtd.size > 0x1000000) {
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 5abd91cc6dfa..364f37276d78 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -195,6 +195,7 @@ enum spi_nor_protocol {
 	SNOR_PROTO_1_2_2_DTR = SNOR_PROTO_DTR(1, 2, 2),
 	SNOR_PROTO_1_4_4_DTR = SNOR_PROTO_DTR(1, 4, 4),
 	SNOR_PROTO_1_8_8_DTR = SNOR_PROTO_DTR(1, 8, 8),
+	SNOR_PROTO_8_8_8_DTR = SNOR_PROTO_DTR(8, 8, 8),
 };
 
 static inline bool spi_nor_protocol_is_dtr(enum spi_nor_protocol proto)
@@ -345,7 +346,7 @@ struct spi_nor_hwcaps {
  * then Quad SPI protocols before Dual SPI protocols, Fast Read and lastly
  * (Slow) Read.
  */
-#define SNOR_HWCAPS_READ_MASK		GENMASK(14, 0)
+#define SNOR_HWCAPS_READ_MASK		GENMASK(15, 0)
 #define SNOR_HWCAPS_READ		BIT(0)
 #define SNOR_HWCAPS_READ_FAST		BIT(1)
 #define SNOR_HWCAPS_READ_1_1_1_DTR	BIT(2)
@@ -362,11 +363,12 @@ struct spi_nor_hwcaps {
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
@@ -377,18 +379,19 @@ struct spi_nor_hwcaps {
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
@@ -399,7 +402,8 @@ struct spi_nor_hwcaps {
 #define SNOR_HWCAPS_DTR		(SNOR_HWCAPS_READ_1_1_1_DTR |	\
 				 SNOR_HWCAPS_READ_1_2_2_DTR |	\
 				 SNOR_HWCAPS_READ_1_4_4_DTR |	\
-				 SNOR_HWCAPS_READ_1_8_8_DTR)
+				 SNOR_HWCAPS_READ_1_8_8_DTR |	\
+				 SNOR_HWCAPS_READ_8_8_8_DTR)
 
 #define SNOR_HWCAPS_ALL		(SNOR_HWCAPS_READ_MASK |	\
 				 SNOR_HWCAPS_PP_MASK)
@@ -438,6 +442,7 @@ enum spi_nor_read_command_index {
 	SNOR_CMD_READ_1_8_8,
 	SNOR_CMD_READ_8_8_8,
 	SNOR_CMD_READ_1_8_8_DTR,
+	SNOR_CMD_READ_8_8_8_DTR,
 
 	SNOR_CMD_READ_MAX
 };
@@ -454,6 +459,7 @@ enum spi_nor_pp_command_index {
 	SNOR_CMD_PP_1_1_8,
 	SNOR_CMD_PP_1_8_8,
 	SNOR_CMD_PP_8_8_8,
+	SNOR_CMD_PP_8_8_8_DTR,
 
 	SNOR_CMD_PP_MAX
 };
@@ -570,6 +576,7 @@ struct flash_info;
  * @program_opcode:	the program opcode
  * @sst_write_second:	used by the SST write operation
  * @flags:		flag options for the current SPI-NOR (SNOR_F_*)
+ * @cmd_ext:		the command opcode extension for DTR mode.
  * @read_proto:		the SPI protocol for read operations
  * @write_proto:	the SPI protocol for write operations
  * @reg_proto		the SPI protocol for read_reg/write_reg/erase operations
@@ -599,6 +606,7 @@ struct spi_nor {
 	enum spi_nor_protocol	reg_proto;
 	bool			sst_write_second;
 	u32			flags;
+	enum spi_mem_cmd_ext	cmd_ext;
 
 	const struct spi_nor_controller_ops *controller_ops;
 
-- 
2.25.0

