Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49C142990D
	for <lists+linux-spi@lfdr.de>; Mon, 11 Oct 2021 23:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhJKVmn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Oct 2021 17:42:43 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52728 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbhJKVmm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Oct 2021 17:42:42 -0400
X-Greylist: delayed 3227 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Oct 2021 17:42:41 EDT
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19BKkW0m070905;
        Mon, 11 Oct 2021 15:46:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1633985192;
        bh=mqz2lz88cZxIXXKJa69T+JAfW3Se31KHQgsxwq0MR14=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=i/RHTVViOUe5kHGTH96/fPfBsPvSKzrYa27+hwWI6XNv4aJUBy35AjRigSF3k5rAG
         hNIsVnd+g/Iau46dSfoEpsv/c0riP2i5Amj7UxFweFEo6WlM6iShl4ahBMiqr6pDve
         +v0zD0GOh05Umgbsbdt8r3RPDTI79io/lHuLNztA=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19BKkWat105012
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Oct 2021 15:46:32 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 11
 Oct 2021 15:46:31 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 11 Oct 2021 15:46:31 -0500
Received: from LT5CD112GSQZ.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19BKkKEf069811;
        Mon, 11 Oct 2021 15:46:27 -0500
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
Subject: [PATCH v2 01/14] spi: spi-mem: Add DTR templates for cmd, address, dummy and data phase
Date:   Tue, 12 Oct 2021 02:16:06 +0530
Message-ID: <20211011204619.81893-2-a-nandan@ti.com>
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

Setting dtr field of spi_mem_op is useful when creating templates
for DTR ops in spinand.h. Also, 2 bytes cmd phases are required when
operating in Octal DTR SPI mode.

Create new templates for dtr mode cmd, address, dummy and data phase
in spi_mem_op, which set the dtr field to 1 and also allow passing
the nbytes for the cmd phase.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 include/linux/spi/spi-mem.h | 41 +++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 85e2ff7b840d..4a99e26aa0b6 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -20,6 +20,14 @@
 		.nbytes = 1,					\
 	}
 
+#define SPI_MEM_OP_CMD_DTR(__nbytes, __opcode, __buswidth)	\
+	{							\
+		.buswidth = __buswidth,				\
+		.opcode = __opcode,				\
+		.nbytes = __nbytes,				\
+		.dtr = 1,					\
+	}
+
 #define SPI_MEM_OP_ADDR(__nbytes, __val, __buswidth)		\
 	{							\
 		.nbytes = __nbytes,				\
@@ -27,6 +35,14 @@
 		.buswidth = __buswidth,				\
 	}
 
+#define SPI_MEM_OP_ADDR_DTR(__nbytes, __val, __buswidth)	\
+	{							\
+		.nbytes = __nbytes,				\
+		.val = __val,					\
+		.buswidth = __buswidth,				\
+		.dtr = 1,					\
+	}
+
 #define SPI_MEM_OP_NO_ADDR	{ }
 
 #define SPI_MEM_OP_DUMMY(__nbytes, __buswidth)			\
@@ -35,6 +51,13 @@
 		.buswidth = __buswidth,				\
 	}
 
+#define SPI_MEM_OP_DUMMY_DTR(__nbytes, __buswidth)		\
+	{							\
+		.nbytes = __nbytes,				\
+		.buswidth = __buswidth,				\
+		.dtr = 1,					\
+	}
+
 #define SPI_MEM_OP_NO_DUMMY	{ }
 
 #define SPI_MEM_OP_DATA_IN(__nbytes, __buf, __buswidth)		\
@@ -45,6 +68,15 @@
 		.buswidth = __buswidth,				\
 	}
 
+#define SPI_MEM_OP_DATA_IN_DTR(__nbytes, __buf, __buswidth)	\
+	{							\
+		.dir = SPI_MEM_DATA_IN,				\
+		.nbytes = __nbytes,				\
+		.buf.in = __buf,				\
+		.buswidth = __buswidth,				\
+		.dtr = 1,					\
+	}
+
 #define SPI_MEM_OP_DATA_OUT(__nbytes, __buf, __buswidth)	\
 	{							\
 		.dir = SPI_MEM_DATA_OUT,			\
@@ -53,6 +85,15 @@
 		.buswidth = __buswidth,				\
 	}
 
+#define SPI_MEM_OP_DATA_OUT_DTR(__nbytes, __buf, __buswidth)	\
+	{							\
+		.dir = SPI_MEM_DATA_OUT,			\
+		.nbytes = __nbytes,				\
+		.buf.out = __buf,				\
+		.buswidth = __buswidth,				\
+		.dtr = 1,					\
+	}
+
 #define SPI_MEM_OP_NO_DATA	{ }
 
 /**
-- 
2.25.1

