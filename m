Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671B73C70F7
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jul 2021 15:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbhGMNJI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Jul 2021 09:09:08 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51974 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236591AbhGMNJG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Jul 2021 09:09:06 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16DD644V073299;
        Tue, 13 Jul 2021 08:06:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626181564;
        bh=1k4ivvZ3xXy03Q4E8raaV+ou93EXAdzBGlKPdFnNSkw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=LPhI6E8Vkm3LJSfa8HpdGxV+WiA5bLMh5wjpMvwxCQlJQhiktKNs8vSrtb43yASIt
         WlB0tUxQkdppes4njA6l6ddvjPkRFIutoourP5oYct4T2BcQiM9WnvjIC/sYVUEv4N
         /koF7j5K1EdEFM676rWq2g2o1Hnm74eLIXQoQfck=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16DD64cl091370
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Jul 2021 08:06:04 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 13
 Jul 2021 08:06:04 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 13 Jul 2021 08:06:04 -0500
Received: from LT5CD112GSQZ.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16DD5daE109825;
        Tue, 13 Jul 2021 08:05:59 -0500
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
Subject: [PATCH 04/13] mtd: spinand: Fix odd byte addr and data phase in read/write reg op and write VCR op for Octal DTR mode
Date:   Tue, 13 Jul 2021 13:05:29 +0000
Message-ID: <20210713130538.646-5-a-nandan@ti.com>
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

In Octal DTR SPI mode, 2 bytes of data gets transmitted over one clock
cycle, and half-cycle instruction phases aren't supported yet. So,
every DTR spi_mem_op needs to have even nbytes in all phases for
non-erratic behaviour from the SPI controller.

The odd length cmd and dummy phases get handled by spimem_setup_op()
but the odd length address and data phases need to be handled according
to the use case. For example in Octal DTR mode, read register operation
has one byte long address and data phase. So it needs to extend it
by adding a suitable extra byte in addr and reading 2 bytes of data,
discarding the second byte.

Handle address and data phases for Octal DTR mode in read/write
register and write volatile configuration register operations
by adding a suitable extra byte in the address and data phase.

Create spimem_setup_reg_op() helper function to ease setting up
read/write register operations in other functions, e.g. wait().

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 drivers/mtd/nand/spi/core.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 2e59faecc8f5..a5334ad34f96 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -65,12 +65,27 @@ static void spinand_setup_op(const struct spinand_device *spinand,
 	}
 }
 
+static void spinand_setup_reg_op(const struct spinand_device *spinand,
+				 struct spi_mem_op *op)
+{
+	if (spinand->reg_proto == SPINAND_OCTAL_DTR) {
+		/*
+		 * Assigning same first and second byte will result in constant
+		 * bits on ths SPI bus between positive and negative clock edges
+		 */
+		op->addr.val = (op->addr.val << 8) | op->addr.val;
+		op->addr.nbytes = 2;
+		op->data.nbytes = 2;
+	}
+	spinand_setup_op(spinand, op);
+}
+
 static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
 {
-	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(reg,
-						      spinand->scratchbuf);
+	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(reg, spinand->scratchbuf);
 	int ret;
 
+	spinand_setup_reg_op(spinand, &op);
 	ret = spi_mem_exec_op(spinand->spimem, &op);
 	if (ret)
 		return ret;
@@ -81,10 +96,10 @@ static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
 
 static int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val)
 {
-	struct spi_mem_op op = SPINAND_SET_FEATURE_OP(reg,
-						      spinand->scratchbuf);
+	struct spi_mem_op op = SPINAND_SET_FEATURE_OP(reg, spinand->scratchbuf);
 
-	*spinand->scratchbuf = val;
+	spinand_setup_reg_op(spinand, &op);
+	memset(spinand->scratchbuf, val, op.data.nbytes);
 	return spi_mem_exec_op(spinand->spimem, &op);
 }
 
@@ -547,6 +562,7 @@ static int spinand_wait(struct spinand_device *spinand,
 	u8 status;
 	int ret;
 
+	spinand_setup_reg_op(spinand, &op);
 	ret = spi_mem_poll_status(spinand->spimem, &op, STATUS_BUSY, 0,
 				  initial_delay_us,
 				  poll_delay_us,
-- 
2.17.1

