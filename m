Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC60E429861
	for <lists+linux-spi@lfdr.de>; Mon, 11 Oct 2021 22:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbhJKUtq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Oct 2021 16:49:46 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44240 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhJKUtp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Oct 2021 16:49:45 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19BKlYhB120796;
        Mon, 11 Oct 2021 15:47:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1633985254;
        bh=aE9h+iCpn2bT2W0hUbw4QOpt5bFgcYuqQIMWifBo9M0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=OPgGLEnbJb7axirW0W1zFlv74snzAqIf0bWAf1HoyT7tD9lRYkpf8xzCu9rUQHcBm
         lXaLFLHpSB/MxQcb7bFDJQFXmWoJHqdkcIf/W8Ligi7RwB7omNjB2ZvPCzfAMIir3r
         5LSEKeNIeP1T87laksN2XJ98wgITQsvEHIVoMxfs=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19BKlYOt097449
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Oct 2021 15:47:34 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 11
 Oct 2021 15:47:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 11 Oct 2021 15:47:34 -0500
Received: from LT5CD112GSQZ.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19BKkKEq069811;
        Mon, 11 Oct 2021 15:47:28 -0500
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
Subject: [PATCH v2 12/14] mtd: spinand: Add adjust_op() in Winbond manufacturer_ops
Date:   Tue, 12 Oct 2021 02:16:17 +0530
Message-ID: <20211011204619.81893-13-a-nandan@ti.com>
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

Add implementation of adjust_op() manufacturer_ops for Winbond. This
handles the variations introduced in read register, read vcr, blk
erase, page read and program exec ops when operating in Octal DTR mode.
Read register operation requires 7 dummy cycles and read VCR operation
requires 8 dummy cycles in Octal DTR mode instead of default 0 dummy
cycle. Block erase, page read and program exec operations require
2 byte address in Octal DTR mode instead of default 3 bytes.

Datasheet: https://www.winbond.com/export/sites/winbond/datasheet/W35N01JW_Datasheet_Brief.pdf

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 drivers/mtd/nand/spi/winbond.c | 45 ++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index e2cb82d68f96..d962221d4082 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -16,6 +16,13 @@
 
 #define WINBOND_CFG_BUF_READ		BIT(3)
 
+#define WINBOND_BLK_ERASE_OPCODE	0xD8
+#define WINBOND_PAGE_READ_OPCODE	0x13
+#define WINBOND_PROG_EXEC_OPCODE	0x10
+#define WINBOND_READ_REG_OPCODE_1	0x05
+#define WINBOND_READ_REG_OPCODE_2	0x0F
+#define WINBOND_READ_VCR_OPCODE		0x85
+
 /* Octal DTR SPI mode (8D-8D-8D) with Data Strobe output*/
 #define WINBOND_IO_MODE_VCR_OCTAL_DTR	0xE7
 #define WINBOND_IO_MODE_VCR_ADDR	0x00
@@ -197,9 +204,47 @@ static int winbond_spinand_octal_dtr_enable(struct spinand_device *spinand)
 	return 0;
 }
 
+static void winbond_spinand_adjust_op(struct spi_mem_op *op,
+				      const enum spinand_proto reg_proto)
+{
+	/*
+	 * To support both 1 byte opcode and 2 byte opcodes, extract the MSB
+	 * byte from the opcode as the LSB byte in 2 byte opcode is treated as
+	 * don't care.
+	 */
+	u8 opcode = op->cmd.opcode >> (8 * (op->cmd.nbytes - 1));
+
+	if (reg_proto == SPINAND_OCTAL_DTR) {
+		switch (opcode) {
+		case WINBOND_READ_REG_OPCODE_1:
+		case WINBOND_READ_REG_OPCODE_2:
+			op->dummy.nbytes = 14;
+			op->dummy.buswidth = 8;
+			op->dummy.dtr = true;
+			return;
+
+		case WINBOND_READ_VCR_OPCODE:
+			op->dummy.nbytes = 16;
+			op->dummy.buswidth = 8;
+			op->dummy.dtr = true;
+			return;
+
+		case WINBOND_BLK_ERASE_OPCODE:
+		case WINBOND_PAGE_READ_OPCODE:
+		case WINBOND_PROG_EXEC_OPCODE:
+			op->addr.nbytes = 2;
+			return;
+
+		default:
+			return;
+		}
+	}
+}
+
 static const struct spinand_manufacturer_ops winbond_spinand_manuf_ops = {
 	.init = winbond_spinand_init,
 	.octal_dtr_enable = winbond_spinand_octal_dtr_enable,
+	.adjust_op = winbond_spinand_adjust_op,
 };
 
 const struct spinand_manufacturer winbond_spinand_manufacturer = {
-- 
2.25.1

