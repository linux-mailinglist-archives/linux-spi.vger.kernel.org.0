Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125793C70F3
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jul 2021 15:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbhGMNJC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Jul 2021 09:09:02 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51916 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236509AbhGMNJB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Jul 2021 09:09:01 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16DD5xO6073273;
        Tue, 13 Jul 2021 08:05:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626181559;
        bh=wOeelgD35VXJcTWVNjU1ob5kt3+vg6MXZy2vU/+9Qp0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=bjoev2fXH8g6EqbhaG2XgAFUJE9EL7e8kRhdtJdT1a59ejXKO04vQAkKbPLaVxL/z
         HJhJywkTMVclJRKvgZoAsgZkohoS0XKZ3SdDHFqjnAJnfenj60H34lmVo9Ctb5YwJ6
         4MoTPY8rL9ofzR1tdjX92IDrgkHHhc326feE2WYk=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16DD5xcB085853
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Jul 2021 08:05:59 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 13
 Jul 2021 08:05:59 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 13 Jul 2021 08:05:59 -0500
Received: from LT5CD112GSQZ.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16DD5daD109825;
        Tue, 13 Jul 2021 08:05:55 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
CC:     Apurva Nandan <a-nandan@ti.com>, Pratyush Yadav <p.yadav@ti.com>
Subject: [PATCH 03/13] mtd: spinand: Setup spi_mem_op for the SPI IO protocol using reg_proto
Date:   Tue, 13 Jul 2021 13:05:28 +0000
Message-ID: <20210713130538.646-4-a-nandan@ti.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20210713130538.646-1-a-nandan@ti.com>
References: <20210713130538.646-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Currently, the op macros in spinand.h don't give the option to setup
any non-array access instructions for Dual/Quad/Octal DTR SPI bus.
Having a function that setups the op based on reg_proto would be
better than trying to write all the setup logic in op macros.

Create a spimem_setup_op() that would setup cmd, addr, dummy and data
phase of the spi_mem op, for the given spinand->reg_proto. And hence,
call the spimem_setup_op() before executing any spi_mem op.

Note: In this commit, spimem_setup_op() isn't called in the
read_reg_op(), write_reg_op() and wait() functions, as they need
modifications in address value and data nbytes when in Octal DTR mode.
This will be fixed in a later commit.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 drivers/mtd/nand/spi/core.c | 51 +++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index a4f25649e293..2e59faecc8f5 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -20,6 +20,51 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 
+/**
+ * spinand_setup_op() - Helper function to setup the spi_mem op based on the
+ *			spinand->reg_proto
+ * @spinand: the spinand device
+ * @op: the spi_mem op to setup
+ *
+ * Set up buswidth and dtr fields for cmd, addr, dummy and data phase. Also
+ * adjust cmd opcode and dummy nbytes. This function doesn't make any changes
+ * to addr val or data buf.
+ */
+static void spinand_setup_op(const struct spinand_device *spinand,
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
+		if (op_is_dtr) {
+			op->dummy.nbytes *= 2;
+			op->dummy.dtr = true;
+		}
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
@@ -341,6 +386,7 @@ static int spinand_write_enable_op(struct spinand_device *spinand)
 {
 	struct spi_mem_op op = SPINAND_WR_EN_DIS_OP(true);
 
+	spinand_setup_op(spinand, &op);
 	return spi_mem_exec_op(spinand->spimem, &op);
 }
 
@@ -351,6 +397,7 @@ static int spinand_load_page_op(struct spinand_device *spinand,
 	unsigned int row = nanddev_pos_to_row(nand, &req->pos);
 	struct spi_mem_op op = SPINAND_PAGE_READ_OP(row);
 
+	spinand_setup_op(spinand, &op);
 	return spi_mem_exec_op(spinand->spimem, &op);
 }
 
@@ -475,6 +522,7 @@ static int spinand_program_op(struct spinand_device *spinand,
 	unsigned int row = nanddev_pos_to_row(nand, &req->pos);
 	struct spi_mem_op op = SPINAND_PROG_EXEC_OP(row);
 
+	spinand_setup_op(spinand, &op);
 	return spi_mem_exec_op(spinand->spimem, &op);
 }
 
@@ -485,6 +533,7 @@ static int spinand_erase_op(struct spinand_device *spinand,
 	unsigned int row = nanddev_pos_to_row(nand, pos);
 	struct spi_mem_op op = SPINAND_BLK_ERASE_OP(row);
 
+	spinand_setup_op(spinand, &op);
 	return spi_mem_exec_op(spinand->spimem, &op);
 }
 
@@ -531,6 +580,7 @@ static int spinand_read_id_op(struct spinand_device *spinand, u8 naddr,
 		naddr, ndummy, spinand->scratchbuf, SPINAND_MAX_ID_LEN);
 	int ret;
 
+	spinand_setup_op(spinand, &op);
 	ret = spi_mem_exec_op(spinand->spimem, &op);
 	if (!ret)
 		memcpy(buf, spinand->scratchbuf, SPINAND_MAX_ID_LEN);
@@ -543,6 +593,7 @@ static int spinand_reset_op(struct spinand_device *spinand)
 	struct spi_mem_op op = SPINAND_RESET_OP;
 	int ret;
 
+	spinand_setup_op(spinand, &op);
 	ret = spi_mem_exec_op(spinand->spimem, &op);
 	if (ret)
 		return ret;
-- 
2.17.1

