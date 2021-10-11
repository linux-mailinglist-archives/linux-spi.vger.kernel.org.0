Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0E042985A
	for <lists+linux-spi@lfdr.de>; Mon, 11 Oct 2021 22:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbhJKUtO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Oct 2021 16:49:14 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60146 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbhJKUtO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Oct 2021 16:49:14 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19BKksYE036494;
        Mon, 11 Oct 2021 15:46:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1633985214;
        bh=on8W3HPPfhJxHFSTbC30TeTqZ/NdxJ0M2DbWqQ2CJCY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=IKP5tfY0w35lyYOnrrR2LD22aZXC85Z+5DWM/5Pkt0B287UAaWGBDGjOi+IPfLX65
         KhpRhCgIsRl2HISVvq2pVDRbunGUBuBvu/+CN5OjZQMV8pLbCekWmbbnH6nDsnFxN/
         dSX3MTzGP99AWgNzTWSS/XMYzrBaBkcnz0CwYkoU=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19BKksiO055277
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Oct 2021 15:46:54 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 11
 Oct 2021 15:46:54 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 11 Oct 2021 15:46:54 -0500
Received: from LT5CD112GSQZ.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19BKkKEj069811;
        Mon, 11 Oct 2021 15:46:49 -0500
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
Subject: [PATCH v2 05/14] mtd: spinand: Add adjust_op() in manufacturer_ops to modify the ops for manufacturer specific changes
Date:   Tue, 12 Oct 2021 02:16:10 +0530
Message-ID: <20211011204619.81893-6-a-nandan@ti.com>
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

Manufacturers might use a variation of standard SPI NAND flash
instructions, e.g. Winbond W35N01JW changes the dummy cycle length for
read register commands when in Octal DTR mode.

Add new function in manufacturer_ops: adjust_op(), which can be called
to correct the spi_mem op for any alteration in the instruction made by
the manufacturers. And hence, this function can also be used for
incorporating variations of SPI instructions in Octal DTR mode.

Datasheet: https://www.winbond.com/export/sites/winbond/datasheet/W35N01JW_Datasheet_Brief.pdf

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 drivers/mtd/nand/spi/core.c | 3 +++
 include/linux/mtd/spinand.h | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 4da794ae728d..8e6cf7941a0f 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -61,6 +61,9 @@ static void spinand_patch_op(const struct spinand_device *spinand,
 		op->data.buswidth = op_buswidth;
 		op->data.dtr = op_is_dtr;
 	}
+
+	if (spinand->manufacturer->ops->adjust_op)
+		spinand->manufacturer->ops->adjust_op(op, spinand->reg_proto);
 }
 
 static void spinand_patch_reg_op(const struct spinand_device *spinand,
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index f6093cd98d7b..ebb19b2cec84 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -257,6 +257,8 @@ struct spinand_devid {
 /**
  * struct manufacurer_ops - SPI NAND manufacturer specific operations
  * @init: initialize a SPI NAND device
+ * @adjust_op: modify the ops for any variation in their cmd, address, dummy or
+ *	       data phase by the manufacturer
  * @cleanup: cleanup a SPI NAND device
  *
  * Each SPI NAND manufacturer driver should implement this interface so that
@@ -264,6 +266,8 @@ struct spinand_devid {
  */
 struct spinand_manufacturer_ops {
 	int (*init)(struct spinand_device *spinand);
+	void (*adjust_op)(struct spi_mem_op *op,
+			  const enum spinand_proto reg_proto);
 	void (*cleanup)(struct spinand_device *spinand);
 };
 
-- 
2.25.1

