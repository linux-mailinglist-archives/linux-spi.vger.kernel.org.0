Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFFC3C710D
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jul 2021 15:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236603AbhGMNKt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Jul 2021 09:10:49 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44012 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236636AbhGMNJK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Jul 2021 09:09:10 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16DD692Y010440;
        Tue, 13 Jul 2021 08:06:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626181569;
        bh=8RzEa7awEZEDwwWTSJhzA++iT0OALTq3Az0pHKaR+oQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=zFoa0+nq67e3TIX/C15TP3zL+MQ8BoFcTrsYQK+PRI3UGonWq6yJWgZHgnBOV+ceW
         +E639dxn8aqXzJ8c9N9dmrWOF1UZThaI1p4/ixNpGFaVM7imX7CCkexRXME7OXuiBv
         93B505jPBijDmQC4khE6GLe2RVyO9G64DshBmk1E=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16DD69SY004591
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Jul 2021 08:06:09 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 13
 Jul 2021 08:06:09 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 13 Jul 2021 08:06:09 -0500
Received: from LT5CD112GSQZ.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16DD5daF109825;
        Tue, 13 Jul 2021 08:06:04 -0500
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
Subject: [PATCH 05/13] mtd: spinand: Add adjust_op() in manufacturer_ops to modify the ops for manufacturer specific changes
Date:   Tue, 13 Jul 2021 13:05:30 +0000
Message-ID: <20210713130538.646-6-a-nandan@ti.com>
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
index a5334ad34f96..1e619b6d777f 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -63,6 +63,9 @@ static void spinand_setup_op(const struct spinand_device *spinand,
 		op->data.buswidth = op_buswidth;
 		op->data.dtr = op_is_dtr;
 	}
+
+	if (spinand->manufacturer->ops->adjust_op)
+		spinand->manufacturer->ops->adjust_op(op, spinand->reg_proto);
 }
 
 static void spinand_setup_reg_op(const struct spinand_device *spinand,
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
2.17.1

