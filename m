Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4919429914
	for <lists+linux-spi@lfdr.de>; Mon, 11 Oct 2021 23:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbhJKVmr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Oct 2021 17:42:47 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52728 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235380AbhJKVmq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Oct 2021 17:42:46 -0400
X-Greylist: delayed 3227 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Oct 2021 17:42:41 EDT
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19BKkhNc070935;
        Mon, 11 Oct 2021 15:46:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1633985203;
        bh=CASUc+JvQlKfMHsjOUu+uMJGKuCWgnI+FiOL7ZWrJQo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=bU+vpQKS461/fk50n4GpL/J16aZYZ+9aHDE6pwvpsSuPxG+D/cN4xnSHUoNmOuUYF
         TcC6q+NjzlIXSuw9ZW3iYrkK2j8pJZ8xcHlmp4dqOZojnGzVmrb/kkwq7/KhM6VhQp
         7BTzltvEiBwmytCaxkTdI1WXgM0ZgGPbO2AFGnwg=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19BKkhdE055206
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Oct 2021 15:46:43 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 11
 Oct 2021 15:46:43 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 11 Oct 2021 15:46:43 -0500
Received: from LT5CD112GSQZ.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19BKkKEh069811;
        Mon, 11 Oct 2021 15:46:38 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Apurva Nandan <a-nandan@ti.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
CC:     <p.yadav@ti.com>
Subject: [PATCH v2 03/14] mtd: spinand: Patch spi_mem_op for the SPI IO protocol using reg_proto
Date:   Tue, 12 Oct 2021 02:16:08 +0530
Message-ID: <20211011204619.81893-4-a-nandan@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211011204619.81893-1-a-nandan@ti.com>
References: <20211011204619.81893-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Currently, the op macros in spinand.h don't give the option to setup
any non-array access instructions for Dual/Quad/Octal DTR SPI bus.
Having a function that patches the op based on reg_proto would be
better than trying to write all the setup logic in op macros.

Create a spimem_patch_op() that would patch cmd, addr, dummy and data
phase of the spi_mem op, for the given spinand->reg_proto. And hence,
call the spimem_patch_op() before executing any spi_mem op.

Note: In this commit, spimem_patch_op() isn't called in the
read_reg_op(), write_reg_op() and wait() functions, as they need
modifications in address value and data nbytes when in Octal DTR mode.
This will be fixed in a later commit.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 drivers/mtd/nand/spi/core.c | 49 +++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index d82a3e6d9bb5..11746d858f87 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -20,6 +20,49 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 
+/**
+ * spinand_patch_op() - Helper function to patch the spi_mem op based on the
+ *			spinand->reg_proto
+ * @spinand: the spinand device
+ * @op: the spi_mem op to patch
+ *
+ * Set up buswidth and dtr fields for cmd, addr, dummy and data phase. Also
+ * adjust cmd opcode and dummy nbytes. This function doesn't make any changes
+ * to addr val or data buf.
+ */
+static void spinand_patch_op(const struct spinand_device *spinand,
+			     struct spi_mem_op *op)
+{
+	u8 op_buswidth = SPINAND_PROTO_BUSWIDTH(spinand->reg_proto);
+	u8 op_is_dtr = SPINAND_PROTO_IS_DTR(spinand->reg_proto);
+
+	if (spinand->reg_proto == SPINAND_SINGLE_STR)
+		return;
+
+	op->cmd.buswidth = op_buswidth;
+	op->cmd.dtr = op_is_dtr;
+	if (spinand->reg_proto == SPINAND_OCTAL_DTR) {
+		op->cmd.opcode = (op->cmd.opcode << 8) | op->cmd.opcode;
+		op->cmd.nbytes = 2;
+	}
+
+	if (op->addr.nbytes) {
+		op->addr.buswidth = op_buswidth;
+		op->addr.dtr = op_is_dtr;
+	}
+
+	if (op->dummy.nbytes) {
+		op->dummy.buswidth = op_buswidth;
+		op->dummy.dtr = op_is_dtr;
+		op->dummy.nbytes <<= op_is_dtr;
+	}
+
+	if (op->data.nbytes) {
+		op->data.buswidth = op_buswidth;
+		op->data.dtr = op_is_dtr;
+	}
+}
+
 static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
 {
 	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(reg,
@@ -343,6 +386,7 @@ static int spinand_write_enable_op(struct spinand_device *spinand)
 {
 	struct spi_mem_op op = SPINAND_WR_EN_DIS_OP(true);
 
+	spinand_patch_op(spinand, &op);
 	return spi_mem_exec_op(spinand->spimem, &op);
 }
 
@@ -353,6 +397,7 @@ static int spinand_load_page_op(struct spinand_device *spinand,
 	unsigned int row = nanddev_pos_to_row(nand, &req->pos);
 	struct spi_mem_op op = SPINAND_PAGE_READ_OP(row);
 
+	spinand_patch_op(spinand, &op);
 	return spi_mem_exec_op(spinand->spimem, &op);
 }
 
@@ -477,6 +522,7 @@ static int spinand_program_op(struct spinand_device *spinand,
 	unsigned int row = nanddev_pos_to_row(nand, &req->pos);
 	struct spi_mem_op op = SPINAND_PROG_EXEC_OP(row);
 
+	spinand_patch_op(spinand, &op);
 	return spi_mem_exec_op(spinand->spimem, &op);
 }
 
@@ -487,6 +533,7 @@ static int spinand_erase_op(struct spinand_device *spinand,
 	unsigned int row = nanddev_pos_to_row(nand, pos);
 	struct spi_mem_op op = SPINAND_BLK_ERASE_OP(row);
 
+	spinand_patch_op(spinand, &op);
 	return spi_mem_exec_op(spinand->spimem, &op);
 }
 
@@ -533,6 +580,7 @@ static int spinand_read_id_op(struct spinand_device *spinand, u8 naddr,
 		naddr, ndummy, spinand->scratchbuf, SPINAND_MAX_ID_LEN);
 	int ret;
 
+	spinand_patch_op(spinand, &op);
 	ret = spi_mem_exec_op(spinand->spimem, &op);
 	if (!ret)
 		memcpy(buf, spinand->scratchbuf, SPINAND_MAX_ID_LEN);
@@ -545,6 +593,7 @@ static int spinand_reset_op(struct spinand_device *spinand)
 	struct spi_mem_op op = SPINAND_RESET_OP;
 	int ret;
 
+	spinand_patch_op(spinand, &op);
 	ret = spi_mem_exec_op(spinand->spimem, &op);
 	if (ret)
 		return ret;
-- 
2.25.1

