Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA17C429912
	for <lists+linux-spi@lfdr.de>; Mon, 11 Oct 2021 23:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbhJKVmq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Oct 2021 17:42:46 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52728 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235360AbhJKVmo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Oct 2021 17:42:44 -0400
X-Greylist: delayed 3227 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Oct 2021 17:42:41 EDT
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19BKlj8w071329;
        Mon, 11 Oct 2021 15:47:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1633985265;
        bh=tuvJGDtfmxbDxCYN89TxVrBjoYFXrDF0qurPeskISLc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kKP2rKImMUnTwX9DAdlXkCDeabMU7funQMvaz1zCJvBl/nsAK5KxpzCvGE9Cd3Ykf
         uCe9iN0c/UOJ2aMXSzj3ptuTE/LvnaUJIu5BcvUevsm+zQxoiRxNv7HtdL3NGowKjE
         GQWYVhykAfFYgUoKR4zhoSE25ohcbmPtu78fTmZU=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19BKli6H056294
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Oct 2021 15:47:45 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 11
 Oct 2021 15:47:44 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 11 Oct 2021 15:47:44 -0500
Received: from LT5CD112GSQZ.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19BKkKEs069811;
        Mon, 11 Oct 2021 15:47:40 -0500
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
Subject: [PATCH v2 14/14] mtd: spinand: winbond: Add support for Winbond W35N01JW SPI NAND flash
Date:   Tue, 12 Oct 2021 02:16:19 +0530
Message-ID: <20211011204619.81893-15-a-nandan@ti.com>
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

Winbond W35N01JW is a SPI NAND flash supporting Octal DTR SPI protocol.
Add op_variants for W35N01JW, which include the Octal DTR read/write
page ops as well. Add W35N01JW's OOB layout functions for the
mtd_ooblayout_ops. Finally, add an entry for W35N01JW in spinand_info
table.

Datasheet: https://www.winbond.com/export/sites/winbond/datasheet/W35N01JW_Datasheet_Brief.pdf

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 drivers/mtd/nand/spi/winbond.c | 53 ++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 1857836f19d0..8f687b6a6697 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -47,6 +47,19 @@ static SPINAND_OP_VARIANTS(update_cache_variants_w25xxgv,
 		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD(false, 0, NULL, 0));
 
+static SPINAND_OP_VARIANTS(read_cache_variants_w35n01jw,
+		SPINAND_PAGE_READ_FROM_CACHE_OCTALIO_DTR_OP(0, 24, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_variants_w35n01jw,
+		SPINAND_PROG_LOAD_OCTALIO_DTR(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_variants_w35n01jw,
+		SPINAND_PROG_LOAD_OCTALIO_DTR(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD(false, 0, NULL, 0));
+
 static int w25m02gv_ooblayout_ecc(struct mtd_info *mtd, int section,
 				  struct mtd_oob_region *region)
 {
@@ -71,11 +84,40 @@ static int w25m02gv_ooblayout_free(struct mtd_info *mtd, int section,
 	return 0;
 }
 
+static int w35n01jw_ooblayout_ecc(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *region)
+{
+	if (section > 7)
+		return -ERANGE;
+
+	region->offset = (16 * section) + 12;
+	region->length = 4;
+
+	return 0;
+}
+
+static int w35n01jw_ooblayout_free(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *region)
+{
+	if (section > 7)
+		return -ERANGE;
+
+	region->offset = (16 * section) + 2;
+	region->length = 10;
+
+	return 0;
+}
+
 static const struct mtd_ooblayout_ops w25m02gv_ooblayout = {
 	.ecc = w25m02gv_ooblayout_ecc,
 	.free = w25m02gv_ooblayout_free,
 };
 
+static const struct mtd_ooblayout_ops w35n01jw_ooblayout = {
+	.ecc = w35n01jw_ooblayout_ecc,
+	.free = w35n01jw_ooblayout_free,
+};
+
 static int w25m02gv_select_target(struct spinand_device *spinand,
 				  unsigned int target)
 {
@@ -110,6 +152,17 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &update_cache_variants_w25xxgv),
 		     0,
 		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL)),
+	SPINAND_INFO("W35N01JW",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdc),
+		     NAND_MEMORG(1, 4096, 128, 64, 512, 20, 1, 1, 1),
+		     NAND_ECCREQ(1, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_w35n01jw,
+					      &write_cache_variants_w35n01jw,
+					      &update_cache_variants_w35n01jw),
+		     SPINAND_HAS_OCTAL_DTR_BIT | SPINAND_HAS_POR_CMD_BIT |
+		     SPINAND_HAS_CR_FEAT_BIT,
+		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL)),
+
 };
 
 static int winbond_spinand_init(struct spinand_device *spinand)
-- 
2.25.1

