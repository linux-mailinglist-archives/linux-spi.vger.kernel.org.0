Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D61429868
	for <lists+linux-spi@lfdr.de>; Mon, 11 Oct 2021 22:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbhJKUvL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Oct 2021 16:51:11 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44178 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbhJKUt0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Oct 2021 16:49:26 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19BKlFUd120594;
        Mon, 11 Oct 2021 15:47:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1633985235;
        bh=w7E6JyxIZUA2SdyIeNyt39TQ5DAkOg+qhHKv0x4dNcg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=OVQDwQByzoAHGuXrcyHr7ywvQdjNu304uTfkpW5s7TDx6lcFcUO71dg+2+jbZJZJ2
         NSWtoP8PC6V9weaQAlORVzPYzGgqnZWM1XO17aVi5r/pRvDCKANJUpa4RrFaho1i/h
         /J3mwA4QmOSh+OmSUZ5Dke0/8ST3M11fPt2rrP8s=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19BKlFEA096742
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Oct 2021 15:47:15 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 11
 Oct 2021 15:47:15 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 11 Oct 2021 15:47:15 -0500
Received: from LT5CD112GSQZ.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19BKkKEn069811;
        Mon, 11 Oct 2021 15:47:10 -0500
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
Subject: [PATCH v2 09/14] mtd: spinand: winbond: Add octal_dtr_enable() for manufacturer_ops
Date:   Tue, 12 Oct 2021 02:16:14 +0530
Message-ID: <20211011204619.81893-10-a-nandan@ti.com>
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

Add implementation of octal_dtr_enable() manufacturer_ops for Winbond.
To switch to Ocatl DTR mode, setting programmable dummy cycles and
SPI IO mode using the volatile configuration register is required. To
function at max 120MHz SPI clock in Octal DTR mode, 12 programmable
dummy clock cycle setting is required. (Default number of dummy cycle
are 8 clocks)

Set the programmable dummy cycle to 12 clocks, and SPI IO mode to
Octal DTR with Data Strobe in the VCR. Also, perform a READ ID
operation in Octal DTR SPI mode to ensure the switch was successful.

Datasheet: https://www.winbond.com/export/sites/winbond/datasheet/W35N01JW_Datasheet_Brief.pdf

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 drivers/mtd/nand/spi/winbond.c | 42 ++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 89d8ee801f56..e2cb82d68f96 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -16,6 +16,14 @@
 
 #define WINBOND_CFG_BUF_READ		BIT(3)
 
+/* Octal DTR SPI mode (8D-8D-8D) with Data Strobe output*/
+#define WINBOND_IO_MODE_VCR_OCTAL_DTR	0xE7
+#define WINBOND_IO_MODE_VCR_ADDR	0x00
+
+/* Use 12 dummy clk cycles for using Octal DTR SPI at max 120MHZ */
+#define WINBOND_DUMMY_CLK_COUNT		12
+#define WINBOND_DUMMY_CLK_VCR_ADDR	0x01
+
 static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
@@ -156,8 +164,42 @@ static int winbond_write_vcr_op(struct spinand_device *spinand, u8 reg, u8 val)
 	return 0;
 }
 
+static int winbond_spinand_octal_dtr_enable(struct spinand_device *spinand)
+{
+	int ret;
+	struct spi_mem_op op;
+
+	ret = winbond_write_vcr_op(spinand, WINBOND_DUMMY_CLK_VCR_ADDR,
+				   WINBOND_DUMMY_CLK_COUNT);
+	if (ret)
+		return ret;
+
+	ret = winbond_write_vcr_op(spinand, WINBOND_IO_MODE_VCR_ADDR,
+				   WINBOND_IO_MODE_VCR_OCTAL_DTR);
+	if (ret)
+		return ret;
+
+	/* Read flash ID to make sure the switch was successful. */
+	op = (struct spi_mem_op)
+		SPI_MEM_OP(SPI_MEM_OP_CMD_DTR(2, 0x9f9f, 8),
+			   SPI_MEM_OP_NO_ADDR,
+			   SPI_MEM_OP_DUMMY_DTR(16, 8),
+			   SPI_MEM_OP_DATA_IN_DTR(SPINAND_MAX_ID_LEN,
+						  spinand->scratchbuf, 8));
+
+	ret = spi_mem_exec_op(spinand->spimem, &op);
+	if (ret)
+		return ret;
+
+	if (memcmp(spinand->scratchbuf, spinand->id.data, SPINAND_MAX_ID_LEN))
+		return -EINVAL;
+
+	return 0;
+}
+
 static const struct spinand_manufacturer_ops winbond_spinand_manuf_ops = {
 	.init = winbond_spinand_init,
+	.octal_dtr_enable = winbond_spinand_octal_dtr_enable,
 };
 
 const struct spinand_manufacturer winbond_spinand_manufacturer = {
-- 
2.25.1

