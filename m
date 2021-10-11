Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E692842990F
	for <lists+linux-spi@lfdr.de>; Mon, 11 Oct 2021 23:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbhJKVmo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Oct 2021 17:42:44 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52728 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbhJKVmn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Oct 2021 17:42:43 -0400
X-Greylist: delayed 3227 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Oct 2021 17:42:41 EDT
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19BKknQn070955;
        Mon, 11 Oct 2021 15:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1633985209;
        bh=zuAnALlNlpxKf8XxKC5WEtmIbZqVguvc3Q0C3DzvGGs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UoLlY5j4IzTnUDuQDYGeq+cA6N1uER9VLr7a5yRy4D+o0pOjrQ8GRvEeXDtAV3r2v
         1raSQOPIFVo9vPvYjZUHCNLR7bkxwbzEYUfBS7fIlqOlK56vXSo+j2swtcb4g0TjRc
         ieR4nfFB8YcIyv2M9cYLAw4fttIY/H4gqsIwnSnI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19BKknFl105109
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Oct 2021 15:46:49 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 11
 Oct 2021 15:46:49 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 11 Oct 2021 15:46:48 -0500
Received: from LT5CD112GSQZ.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19BKkKEi069811;
        Mon, 11 Oct 2021 15:46:43 -0500
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
Subject: [PATCH v2 04/14] mtd: spinand: Fix odd byte addr and data phase in read and write reg op for Octal DTR mode
Date:   Tue, 12 Oct 2021 02:16:09 +0530
Message-ID: <20211011204619.81893-5-a-nandan@ti.com>
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

In Octal DTR SPI mode, 2 bytes of data gets transmitted over one clock
cycle, and half-cycle instruction phases aren't supported yet. So,
every DTR spi_mem_op needs to have even nbytes in all phases for
non-erratic behaviour from the SPI controller.

The odd length cmd and dummy phases get handled by spimem_patch_op()
but the odd length address and data phases need to be handled according
to the use case. For example in Octal DTR mode, read register operation
has one byte long address and data phase. So it needs to extend it
by adding a suitable extra byte in addr and reading 2 bytes of data,
discarding the second byte.

Handle address and data phases for Octal DTR mode in read and write
register operations by adding a suitable extra byte in the address and
data phase.

Create spimem_patch_reg_op() helper function to ease setting up
read/write register operations in other functions, e.g. wait().

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 drivers/mtd/nand/spi/core.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 11746d858f87..4da794ae728d 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -63,12 +63,29 @@ static void spinand_patch_op(const struct spinand_device *spinand,
 	}
 }
 
+static void spinand_patch_reg_op(const struct spinand_device *spinand,
+				 struct spi_mem_op *op)
+{
+	if (spinand->reg_proto == SPINAND_OCTAL_DTR) {
+		/*
+		 * Assigning same first and second byte will result in constant
+		 * bits on the SPI bus between positive and negative clock edges
+		 */
+		op->addr.val = (op->addr.val << 8) | op->addr.val;
+		op->addr.nbytes = 2;
+		op->data.nbytes = 2;
+	}
+
+	spinand_patch_op(spinand, op);
+}
+
 static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
 {
 	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(reg,
 						      spinand->scratchbuf);
 	int ret;
 
+	spinand_patch_reg_op(spinand, &op);
 	ret = spi_mem_exec_op(spinand->spimem, &op);
 	if (ret)
 		return ret;
@@ -82,7 +99,8 @@ static int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val)
 	struct spi_mem_op op = SPINAND_SET_FEATURE_OP(reg,
 						      spinand->scratchbuf);
 
-	*spinand->scratchbuf = val;
+	spinand_patch_reg_op(spinand, &op);
+	memset(spinand->scratchbuf, val, op.data.nbytes);
 	return spi_mem_exec_op(spinand->spimem, &op);
 }
 
@@ -547,6 +565,7 @@ static int spinand_wait(struct spinand_device *spinand,
 	u8 status;
 	int ret;
 
+	spinand_patch_reg_op(spinand, &op);
 	ret = spi_mem_poll_status(spinand->spimem, &op, STATUS_BUSY, 0,
 				  initial_delay_us,
 				  poll_delay_us,
-- 
2.25.1

