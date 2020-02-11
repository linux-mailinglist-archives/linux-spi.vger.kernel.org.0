Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66BC5158FFE
	for <lists+linux-spi@lfdr.de>; Tue, 11 Feb 2020 14:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgBKNe2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 Feb 2020 08:34:28 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55716 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbgBKNe0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 Feb 2020 08:34:26 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01BDY8TN130314;
        Tue, 11 Feb 2020 07:34:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581428048;
        bh=oxzh4C7KqjCeurLvFg3+mMLTcJ3kM+cj9SbzjeDFlvY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xVOXcSr8CUZGRRL2r5aSYulikUteqbnOTYwU0qAl5K7SdaJiJ+CJONA60ANWuXrJE
         yUSiARu8Yeuoe7CsVeqBNPmZ2ia00iSLfy50SgX6mNxatQ04V+amTlWuz/LucLzLea
         oAIu2QWz0M3PBVqfo41yiLvlFKbS53ZC1oSlnMS0=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01BDY7ol070639
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Feb 2020 07:34:08 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 11
 Feb 2020 07:34:07 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 11 Feb 2020 07:34:07 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01BDXm5M087522;
        Tue, 11 Feb 2020 07:34:05 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>
Subject: [PATCH 5/9] mtd: spi-nor: get command opcode extension type from BFPT
Date:   Tue, 11 Feb 2020 19:03:44 +0530
Message-ID: <20200211133348.15558-6-p.yadav@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211133348.15558-1-p.yadav@ti.com>
References: <20200211133348.15558-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Some devices in DTR mode expect an extra command byte called the
extension. The extension can either be same as the opcode, bitwise
inverse of the opcode, or another additional byte forming a 16-byte
opcode. Get the extension type from the BFPT. For now, only flashes with
"repeat" and "inverse" extensions are supported.

As of JESD216D.01, BFPT is 20 DWORDs, so update the table size to
reflect that.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 371e56f3cdab..ff0b25754939 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -79,11 +79,11 @@ struct sfdp_header {
 /* Basic Flash Parameter Table */
 
 /*
- * JESD216 rev B defines a Basic Flash Parameter Table of 16 DWORDs.
- * They are indexed from 1 but C arrays are indexed from 0.
+ * JESD216 rev D defines a Basic Flash Parameter Table of 20 DWORDs. They are
+ * indexed from 1 but C arrays are indexed from 0.
  */
 #define BFPT_DWORD(i)		((i) - 1)
-#define BFPT_DWORD_MAX		16
+#define BFPT_DWORD_MAX		20
 
 /* The first version of JESD216 defined only 9 DWORDs. */
 #define BFPT_DWORD_MAX_JESD216			9
@@ -148,6 +148,12 @@ struct sfdp_header {
 #define BFPT_DWORD15_QER_SR2_BIT1_NO_RD		(0x4UL << 20)
 #define BFPT_DWORD15_QER_SR2_BIT1		(0x5UL << 20) /* Spansion */
 
+#define BFPT_DWORD18_CMD_EXT_MASK		GENMASK(30, 29)
+#define BFPT_DWORD18_CMD_EXT_REP		(0x0UL << 29) /* Repeat */
+#define BFPT_DWORD18_CMD_EXT_INV		(0x1UL << 29) /* Invert */
+#define BFPT_DWORD18_CMD_EXT_RES		(0x2UL << 29) /* Reserved */
+#define BFPT_DWORD18_CMD_EXT_16B		(0x3UL << 29) /* 16-bit opcode */
+
 struct sfdp_bfpt {
 	u32	dwords[BFPT_DWORD_MAX];
 };
@@ -3867,6 +3873,24 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 		return -EINVAL;
 	}
 
+	/* 8D-8D-8D command extension. */
+	switch (bfpt.dwords[BFPT_DWORD(18)] & BFPT_DWORD18_CMD_EXT_MASK) {
+	case BFPT_DWORD18_CMD_EXT_REP:
+		nor->cmd_ext = SPI_MEM_EXT_REPEAT;
+		break;
+
+	case BFPT_DWORD18_CMD_EXT_INV:
+		nor->cmd_ext = SPI_MEM_EXT_INVERT;
+		break;
+
+	case BFPT_DWORD18_CMD_EXT_RES:
+		return -EINVAL;
+
+	case BFPT_DWORD18_CMD_EXT_16B:
+		dev_err(nor->dev, "16-bit opcodes not supported\n");
+		return -ENOTSUPP;
+	}
+
 	return spi_nor_post_bfpt_fixups(nor, bfpt_header, &bfpt, params);
 }
 
-- 
2.25.0

