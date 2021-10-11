Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7262429858
	for <lists+linux-spi@lfdr.de>; Mon, 11 Oct 2021 22:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbhJKUtK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Oct 2021 16:49:10 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44024 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbhJKUtK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Oct 2021 16:49:10 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19BKkxfT120542;
        Mon, 11 Oct 2021 15:46:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1633985219;
        bh=W8E5Bn4VYPSr1mS64s78PJRsdrTe25Hy2Dg1pmFYSZE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=IZ4Sia+E0XahxqDjV9/u2MDbcDKQ7ffPaz3Dlv81CxewR0z1NjRYLuv4sn9rf8T2m
         RjiyQjCoe4HSuxTswjFCZ6DphWSGBL0yYJSSaCIrYmEVARbJol1YGt32cZh3kqzXNv
         21jtrI9PbdoDOtUV8+WdiVfPCjkxlk2j32hqL9wU=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19BKkxJ2055305
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Oct 2021 15:46:59 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 11
 Oct 2021 15:46:59 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 11 Oct 2021 15:46:59 -0500
Received: from LT5CD112GSQZ.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19BKkKEk069811;
        Mon, 11 Oct 2021 15:46:54 -0500
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
Subject: [PATCH v2 06/14] mtd: spinand: Add macros for Octal DTR page read and write operations
Date:   Tue, 12 Oct 2021 02:16:11 +0530
Message-ID: <20211011204619.81893-7-a-nandan@ti.com>
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

Define new PAGE_READ_FROM_CACHE and PROG_LOAD op templates for Octal
DTR SPI mode. These templates will be used in op_variants and
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
2.25.1

