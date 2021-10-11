Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276C9429856
	for <lists+linux-spi@lfdr.de>; Mon, 11 Oct 2021 22:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbhJKUsu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Oct 2021 16:48:50 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43992 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235039AbhJKUsu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Oct 2021 16:48:50 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19BKkbx6120461;
        Mon, 11 Oct 2021 15:46:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1633985197;
        bh=Xs0Y2QJh7ZkmtdvZp9Ye38YnqCIgeiTXXKjusd+pz1s=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lqakOCvuQbU6OPltcqNu8j+F/1m4SYtPY4lLXk5PoTl7PaAmG6OxGsBrucq6N2laM
         K2btrN5FyYnW0dJHQpmQW5rCAVnZyCMJlY4mlfianMEkD7HcZtizR26sSdYtUJyCnr
         hvmD0K9t7N5+8+y7lsmTI3namhZAGn7BZ5ClKMCg=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19BKkbpB055156
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Oct 2021 15:46:37 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 11
 Oct 2021 15:46:37 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 11 Oct 2021 15:46:37 -0500
Received: from LT5CD112GSQZ.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19BKkKEg069811;
        Mon, 11 Oct 2021 15:46:32 -0500
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
Subject: [PATCH v2 02/14] mtd: spinand: Add enum spinand_proto to indicate current SPI IO mode
Date:   Tue, 12 Oct 2021 02:16:07 +0530
Message-ID: <20211011204619.81893-3-a-nandan@ti.com>
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

Unlike Dual and Quad SPI modes flashes, Octal DTR SPI NAND flashes
require all instructions to be made in 8D-8D-8D protocol when the
flash is in Octal DTR mode. Hence, storing the current SPI IO mode
becomes necessary for correctly generating non-array access operations.

Store the current SPI IO mode in the spinand struct using a reg_proto
enum. This would act as a flag, denoting that the core should use
the given SPI protocol for non-page access operations.

Also provide basic macros for extracting buswidth and dtr mode
information from the spinand_proto enum.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 drivers/mtd/nand/spi/core.c |  2 ++
 include/linux/mtd/spinand.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 2c8685f1f2fa..d82a3e6d9bb5 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1155,6 +1155,7 @@ static void spinand_mtd_resume(struct mtd_info *mtd)
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	int ret;
 
+	spinand->reg_proto = SPINAND_SINGLE_STR;
 	ret = spinand_reset_op(spinand);
 	if (ret)
 		return;
@@ -1181,6 +1182,7 @@ static int spinand_init(struct spinand_device *spinand)
 	if (!spinand->scratchbuf)
 		return -ENOMEM;
 
+	spinand->reg_proto = SPINAND_SINGLE_STR;
 	ret = spinand_detect(spinand);
 	if (ret)
 		goto err_free_bufs;
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 6988956b8492..f6093cd98d7b 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -140,6 +140,31 @@
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_DATA_OUT(len, buf, 4))
 
+#define SPINAND_PROTO_BUSWIDTH_MASK	GENMASK(6, 0)
+#define SPINAND_PROTO_DTR_BIT		BIT(7)
+
+#define SPINAND_PROTO_STR(__buswidth)	\
+	((u8)(((__buswidth) - 1) & SPINAND_PROTO_BUSWIDTH_MASK))
+#define SPINAND_PROTO_DTR(__buswidth)	\
+	(SPINAND_PROTO_DTR_BIT | SPINAND_PROTO_STR(__buswidth))
+
+#define SPINAND_PROTO_BUSWIDTH(__proto)	\
+	((u8)(((__proto) & SPINAND_PROTO_BUSWIDTH_MASK) + 1))
+#define SPINAND_PROTO_IS_DTR(__proto)	(!!((__proto) & SPINAND_PROTO_DTR_BIT))
+
+/**
+ * enum spinand_proto - List allowable SPI protocol variants for read reg,
+ *			write reg, blk erase, write enable/disable, page read
+ *			and program exec operations.
+ */
+enum spinand_proto {
+	SPINAND_SINGLE_STR = SPINAND_PROTO_STR(1),
+	SPINAND_DUAL_STR = SPINAND_PROTO_STR(2),
+	SPINAND_QUAD_STR = SPINAND_PROTO_STR(4),
+	SPINAND_OCTAL_STR = SPINAND_PROTO_STR(8),
+	SPINAND_OCTAL_DTR = SPINAND_PROTO_DTR(8),
+};
+
 /**
  * Standard SPI NAND flash commands
  */
@@ -407,6 +432,9 @@ struct spinand_dirmap {
  *		   this die. Only required if your chip exposes several dies
  * @cur_target: currently selected target/die
  * @eccinfo: on-die ECC information
+ * @reg_proto: select a variant of SPI IO protocol (single, quad, octal or
+ *	       octal DTR) for read_reg/write_reg/erase operations. Update on
+ *	       successful transition into a different SPI IO protocol.
  * @cfg_cache: config register cache. One entry per die
  * @databuf: bounce buffer for data
  * @oobbuf: bounce buffer for OOB data
@@ -438,6 +466,8 @@ struct spinand_device {
 
 	struct spinand_ecc_info eccinfo;
 
+	enum spinand_proto reg_proto;
+
 	u8 *cfg_cache;
 	u8 *databuf;
 	u8 *oobbuf;
-- 
2.25.1

