Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B003C7100
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jul 2021 15:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbhGMNJg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Jul 2021 09:09:36 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44166 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236488AbhGMNJe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Jul 2021 09:09:34 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16DD6Xgf010860;
        Tue, 13 Jul 2021 08:06:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626181593;
        bh=lXMuQl4iXM6+niHo/pjTIlA3/7u9eumEgfJ0bgdkLHU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pldFiUmmz2Wl4hAEppJ+VQzMGtjHaIn+UoNhjBoB47foJq+HDyRLvnG60/H3amBkw
         PBqmciSGY7RfcrBVktkhy1f9GN8swC7DiVb0DiUyglktMtFd+IaghRfqQ3Ss33tiDL
         SlmOiqMB3tEj8ujILnhVbE043WEzXydnHSWNhA/E=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16DD6XvI101459
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Jul 2021 08:06:33 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 13
 Jul 2021 08:06:32 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 13 Jul 2021 08:06:32 -0500
Received: from LT5CD112GSQZ.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16DD5daK109825;
        Tue, 13 Jul 2021 08:06:29 -0500
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
Subject: [PATCH 10/13] mtd: spinand: Add octal_dtr_enable() for Winbond manufacturer_ops
Date:   Tue, 13 Jul 2021 13:05:35 +0000
Message-ID: <20210713130538.646-11-a-nandan@ti.com>
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
index a7052a9ca171..58cda07c15a0 100644
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
@@ -142,8 +150,42 @@ static int winbond_write_vcr_op(struct spinand_device *spinand, u8 reg, u8 val)
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
2.17.1

