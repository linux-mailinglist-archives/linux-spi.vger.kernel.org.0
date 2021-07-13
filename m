Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A448B3C70F9
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jul 2021 15:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbhGMNJO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Jul 2021 09:09:14 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44028 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbhGMNJO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Jul 2021 09:09:14 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16DD6EvV010456;
        Tue, 13 Jul 2021 08:06:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626181574;
        bh=uFIGS9or9g64JHvjFEOHyBuSmYIom1KO6yATBzd+i8k=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=uXgdlz99rwGtyDbU1ZNcol1HBO9+0TQptkJXdmv1rnSQL1KjdLZIAEqMseSp8QYY1
         X4kPmTfA2wbn3MNn2q0MV7DlaLyg1TMxGgGuRBF5s5srcKEY09PJuvMobWi6cw/P9I
         X7zJHw8PgILxwfP9yF/sRgu90zv5exmLGOSPLaIE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16DD6E0x004685
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Jul 2021 08:06:14 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 13
 Jul 2021 08:06:13 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 13 Jul 2021 08:06:13 -0500
Received: from LT5CD112GSQZ.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16DD5daG109825;
        Tue, 13 Jul 2021 08:06:09 -0500
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
Subject: [PATCH 06/13] mtd: spinand: Add macros for Octal DTR page read and write operations
Date:   Tue, 13 Jul 2021 13:05:31 +0000
Message-ID: <20210713130538.646-7-a-nandan@ti.com>
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

Define new PAGE_READ_FROM_CACHE and PROG_LOAD op templates for Octal
DTR SPI mode. These templates would used in op_variants and
op_templates for defining Octal DTR read from cache and write to
cache operations.

Datasheet: https://www.winbond.com/export/sites/winbond/datasheet/W35N01JW_Datasheet_Brief.pdf

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 include/linux/mtd/spinand.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index ebb19b2cec84..35816b8cfe81 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -122,6 +122,12 @@
 		   SPI_MEM_OP_DUMMY(ndummy, 4),				\
 		   SPI_MEM_OP_DATA_IN(len, buf, 4))
 
+#define SPINAND_PAGE_READ_FROM_CACHE_OCTALIO_DTR_OP(addr, ndummy, buf, len) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD_DTR(2, 0x9d9d, 8),			\
+		   SPI_MEM_OP_ADDR_DTR(2, addr, 8),			\
+		   SPI_MEM_OP_DUMMY_DTR(ndummy, 8),			\
+		   SPI_MEM_OP_DATA_IN_DTR(len, buf, 8))
+
 #define SPINAND_PROG_EXEC_OP(addr)					\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x10, 1),				\
 		   SPI_MEM_OP_ADDR(3, addr, 1),				\
@@ -140,6 +146,12 @@
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_DATA_OUT(len, buf, 4))
 
+#define SPINAND_PROG_LOAD_OCTALIO_DTR(reset, addr, buf, len)		\
+	SPI_MEM_OP(SPI_MEM_OP_CMD_DTR(2, reset ? 0x0202 : 0x8484, 8),	\
+		   SPI_MEM_OP_ADDR_DTR(2, addr, 8),			\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_DATA_OUT_DTR(len, buf, 8))
+
 #define SPINAND_PROTO_BUSWIDTH_MASK	GENMASK(6, 0)
 #define SPINAND_PROTO_DTR_BIT		BIT(7)
 
-- 
2.17.1

