Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05AAC42985F
	for <lists+linux-spi@lfdr.de>; Mon, 11 Oct 2021 22:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbhJKUtd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Oct 2021 16:49:33 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44214 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbhJKUtc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Oct 2021 16:49:32 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19BKlMaR120704;
        Mon, 11 Oct 2021 15:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1633985242;
        bh=hBEDCpCpkhr3SrNZvFGRX6rQTq6Kf0koSfT3CM+ThKQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pWIhzd3oeF7jkKgeAsZvwS1ZbJqh6F6rAMek4Chk38aYOdU7o5SipFdQYnnCScPgL
         Hudnwts3jkcUyLkcXHxZweaS0yJ5WCIl0d/zV8aljQWOOyDoy4x31S49WUx/Yccp6e
         jaQ6MIIRykLABlifs4MrD73TgrYPQsxsvTWU8AR4=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19BKlME9096816
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Oct 2021 15:47:22 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 11
 Oct 2021 15:47:22 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 11 Oct 2021 15:47:22 -0500
Received: from LT5CD112GSQZ.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19BKkKEo069811;
        Mon, 11 Oct 2021 15:47:16 -0500
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
Subject: [PATCH v2 10/14] mtd: spinand: Add support for Power-on-Reset (PoR) instruction
Date:   Tue, 12 Oct 2021 02:16:15 +0530
Message-ID: <20211011204619.81893-11-a-nandan@ti.com>
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

Manufacturers like Gigadevice and Winbond are adding Power-on-Reset
functionality in their SPI NAND flash chips. PoR instruction consists
of a 66h command followed by 99h command, and is different from the FFh
reset. The reset command FFh just clears the status only registers,
while the PoR command erases all the configurations written to the
flash and is equivalent to a power-down -> power-up cycle.

Add support for the Power-on-Reset command for any flash that provides
this feature.

Datasheet: https://www.winbond.com/export/sites/winbond/datasheet/W35N01JW_Datasheet_Brief.pdf

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 drivers/mtd/nand/spi/core.c | 43 +++++++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h | 17 +++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 2bea21bd9747..9b570570ee81 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -9,6 +9,7 @@
 
 #define pr_fmt(fmt)	"spi-nand: " fmt
 
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
@@ -668,6 +669,48 @@ static int spinand_reset_op(struct spinand_device *spinand)
 			    NULL);
 }
 
+static int spinand_power_on_rst_op(struct spinand_device *spinand)
+{
+	struct spi_mem_op op;
+	int ret;
+
+	if (!(spinand->flags & SPINAND_HAS_POR_CMD_BIT))
+		return -EOPNOTSUPP;
+
+	/*
+	 * If flash is in a busy state, wait for it to finish the operation.
+	 * As the operation is unknown, use reset poll delays here.
+	 */
+	ret = spinand_wait(spinand,
+			   SPINAND_RESET_INITIAL_DELAY_US,
+			   SPINAND_RESET_POLL_DELAY_US,
+			   NULL);
+	if (ret)
+		return ret;
+
+	op = (struct spi_mem_op)SPINAND_EN_POWER_ON_RST_OP;
+
+	spinand_patch_op(spinand, &op);
+	ret = spi_mem_exec_op(spinand->spimem, &op);
+	if (ret)
+		return ret;
+
+	op = (struct spi_mem_op)SPINAND_POWER_ON_RST_OP;
+
+	spinand_patch_op(spinand, &op);
+	ret = spi_mem_exec_op(spinand->spimem, &op);
+	if (ret)
+		return ret;
+
+	/* PoR can take max 500 us to complete, so sleep for 600 to 700 us*/
+	usleep_range(SPINAND_POR_MIN_DELAY_US, SPINAND_POR_MAX_DELAY_US);
+
+	dev_dbg(&spinand->spimem->spi->dev,
+		"%s SPI NAND reset to Power-On-Reset state.\n",
+		spinand->manufacturer->name);
+	return 0;
+}
+
 static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
 {
 	return spinand_write_reg_op(spinand, REG_BLOCK_LOCK, lock);
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 21a4e5adcd59..baaf8e94f301 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -26,6 +26,18 @@
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_NO_DATA)
 
+#define SPINAND_EN_POWER_ON_RST_OP					\
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x66, 1),				\
+		   SPI_MEM_OP_NO_ADDR,					\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_NO_DATA)
+
+#define SPINAND_POWER_ON_RST_OP						\
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x99, 1),				\
+		   SPI_MEM_OP_NO_ADDR,					\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_NO_DATA)
+
 #define SPINAND_WR_EN_DIS_OP(enable)					\
 	SPI_MEM_OP(SPI_MEM_OP_CMD((enable) ? 0x06 : 0x04, 1),		\
 		   SPI_MEM_OP_NO_ADDR,					\
@@ -218,6 +230,8 @@ struct spinand_device;
  * reading/programming/erasing when the RESET occurs. Since we always
  * issue a RESET when the device is IDLE, 5us is selected for both initial
  * and poll delay.
+ * Power on Reset can take upto 500 us to complete, so sleep for 600 us
+ * to 700 us safely.
  */
 #define SPINAND_READ_INITIAL_DELAY_US	6
 #define SPINAND_READ_POLL_DELAY_US	5
@@ -227,6 +241,8 @@ struct spinand_device;
 #define SPINAND_WRITE_POLL_DELAY_US	15
 #define SPINAND_ERASE_INITIAL_DELAY_US	250
 #define SPINAND_ERASE_POLL_DELAY_US	50
+#define SPINAND_POR_MIN_DELAY_US	600
+#define SPINAND_POR_MAX_DELAY_US	700
 
 #define SPINAND_WAITRDY_TIMEOUT_MS	400
 
@@ -351,6 +367,7 @@ struct spinand_ecc_info {
 #define SPINAND_HAS_QE_BIT		BIT(0)
 #define SPINAND_HAS_CR_FEAT_BIT		BIT(1)
 #define SPINAND_HAS_OCTAL_DTR_BIT	BIT(2)
+#define SPINAND_HAS_POR_CMD_BIT		BIT(3)
 
 /**
  * struct spinand_ondie_ecc_conf - private SPI-NAND on-die ECC engine structure
-- 
2.25.1

