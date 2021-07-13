Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD273C70F0
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jul 2021 15:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbhGMNJA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Jul 2021 09:09:00 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43672 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236276AbhGMNI7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Jul 2021 09:08:59 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16DD5owV010324;
        Tue, 13 Jul 2021 08:05:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626181550;
        bh=JcxS3BPguGIKB8ChrouzPygyBytSZSyQOD4ZRpL493I=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ydMJdmdxIpEcMC1t2f4eKKJnktpW8HIXfTeWQ6LHPZlQuqbtjt1djkbeBSdI8l4Ap
         8dQ7P2ulwRuaF18N2HyPyF2JuRGbaoh3qTt82TENYPi+9K9879qUANPmdp/Kj8/UMr
         wePtnFI7zrxy4w0FmFIuFMRBeWLPBHvZhfgc6DiA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16DD5oCi085738
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Jul 2021 08:05:50 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 13
 Jul 2021 08:05:49 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 13 Jul 2021 08:05:49 -0500
Received: from LT5CD112GSQZ.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16DD5daB109825;
        Tue, 13 Jul 2021 08:05:45 -0500
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
Subject: [PATCH 01/13] spi: spi-mem: Add DTR templates for cmd, address, dummy and data phase
Date:   Tue, 13 Jul 2021 13:05:26 +0000
Message-ID: <20210713130538.646-2-a-nandan@ti.com>
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

Setting dtr field of spi_mem_op is useful when creating templates
for DTR ops in spinand.h. Also, 2 bytes cmd phases are required when
operating in Octal DTR SPI mode.

Create new templates for dtr mode cmd, address, dummy and data phase
in spi_mem_op, which set the dtr field to 1 and also allow passing
the nbytes for the cmd phase.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 include/linux/spi/spi-mem.h | 87 ++++++++++++++++++++++++++-----------
 1 file changed, 61 insertions(+), 26 deletions(-)

diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 85e2ff7b840d..73e52a3ecf66 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -13,46 +13,81 @@
 
 #include <linux/spi/spi.h>
 
-#define SPI_MEM_OP_CMD(__opcode, __buswidth)			\
-	{							\
-		.buswidth = __buswidth,				\
-		.opcode = __opcode,				\
-		.nbytes = 1,					\
+#define SPI_MEM_OP_CMD_ALL_ARGS(__nbytes, __opcode, __buswidth, __dtr)	\
+	{								\
+		.buswidth = __buswidth,					\
+		.opcode = __opcode,					\
+		.nbytes = __nbytes,					\
+		.dtr = __dtr,						\
 	}
 
-#define SPI_MEM_OP_ADDR(__nbytes, __val, __buswidth)		\
-	{							\
-		.nbytes = __nbytes,				\
-		.val = __val,					\
-		.buswidth = __buswidth,				\
+#define SPI_MEM_OP_CMD(__opcode, __buswidth)				\
+	SPI_MEM_OP_CMD_ALL_ARGS(1, __opcode, __buswidth, 0)
+
+#define SPI_MEM_OP_CMD_DTR(__nbytes, __opcode, __buswidth)		\
+	SPI_MEM_OP_CMD_ALL_ARGS(__nbytes, __opcode, __buswidth, 1)
+
+#define SPI_MEM_OP_ADDR_ALL_ARGS(__nbytes, __val, __buswidth, __dtr)	\
+	{								\
+		.nbytes = __nbytes,					\
+		.val = __val,						\
+		.buswidth = __buswidth,					\
+		.dtr = __dtr,						\
 	}
 
+#define SPI_MEM_OP_ADDR(__nbytes, __val, __buswidth)			\
+	SPI_MEM_OP_ADDR_ALL_ARGS(__nbytes, __val, __buswidth, 0)
+
+#define SPI_MEM_OP_ADDR_DTR(__nbytes, __val, __buswidth)		\
+	SPI_MEM_OP_ADDR_ALL_ARGS(__nbytes, __val, __buswidth, 1)
+
 #define SPI_MEM_OP_NO_ADDR	{ }
 
-#define SPI_MEM_OP_DUMMY(__nbytes, __buswidth)			\
-	{							\
-		.nbytes = __nbytes,				\
-		.buswidth = __buswidth,				\
+#define SPI_MEM_OP_DUMMY_ALL_ARGS(__nbytes, __buswidth, __dtr)		\
+	{								\
+		.nbytes = __nbytes,					\
+		.buswidth = __buswidth,					\
+		.dtr = __dtr,						\
 	}
 
+#define SPI_MEM_OP_DUMMY(__nbytes, __buswidth)				\
+	SPI_MEM_OP_DUMMY_ALL_ARGS(__nbytes, __buswidth, 0)
+
+#define SPI_MEM_OP_DUMMY_DTR(__nbytes, __buswidth)			\
+	SPI_MEM_OP_DUMMY_ALL_ARGS(__nbytes, __buswidth, 1)
+
 #define SPI_MEM_OP_NO_DUMMY	{ }
 
-#define SPI_MEM_OP_DATA_IN(__nbytes, __buf, __buswidth)		\
-	{							\
-		.dir = SPI_MEM_DATA_IN,				\
-		.nbytes = __nbytes,				\
-		.buf.in = __buf,				\
-		.buswidth = __buswidth,				\
+#define SPI_MEM_OP_DATA_IN_ALL_ARGS(__nbytes, __buf, __buswidth, __dtr)	\
+	{								\
+		.dir = SPI_MEM_DATA_IN,					\
+		.nbytes = __nbytes,					\
+		.buf.in = __buf,					\
+		.buswidth = __buswidth,					\
+		.dtr = __dtr,						\
 	}
 
-#define SPI_MEM_OP_DATA_OUT(__nbytes, __buf, __buswidth)	\
-	{							\
-		.dir = SPI_MEM_DATA_OUT,			\
-		.nbytes = __nbytes,				\
-		.buf.out = __buf,				\
-		.buswidth = __buswidth,				\
+#define SPI_MEM_OP_DATA_IN(__nbytes, __buf, __buswidth)			\
+	SPI_MEM_OP_DATA_IN_ALL_ARGS(__nbytes, __buf, __buswidth, 0)
+
+#define SPI_MEM_OP_DATA_IN_DTR(__nbytes, __buf, __buswidth)		\
+	SPI_MEM_OP_DATA_IN_ALL_ARGS(__nbytes, __buf, __buswidth, 1)
+
+#define SPI_MEM_OP_DATA_OUT_ALL_ARGS(__nbytes, __buf, __buswidth, __dtr)\
+	{								\
+		.dir = SPI_MEM_DATA_OUT,				\
+		.nbytes = __nbytes,					\
+		.buf.out = __buf,					\
+		.buswidth = __buswidth,					\
+		.dtr = __dtr,						\
 	}
 
+#define SPI_MEM_OP_DATA_OUT(__nbytes, __buf, __buswidth)		\
+	SPI_MEM_OP_DATA_OUT_ALL_ARGS(__nbytes, __buf, __buswidth, 0)
+
+#define SPI_MEM_OP_DATA_OUT_DTR(__nbytes, __buf, __buswidth)		\
+	SPI_MEM_OP_DATA_OUT_ALL_ARGS(__nbytes, __buf, __buswidth, 1)
+
 #define SPI_MEM_OP_NO_DATA	{ }
 
 /**
-- 
2.17.1

