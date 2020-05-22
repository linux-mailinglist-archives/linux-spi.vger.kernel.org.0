Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6361DF20A
	for <lists+linux-spi@lfdr.de>; Sat, 23 May 2020 00:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731122AbgEVWln (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 May 2020 18:41:43 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35542 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731311AbgEVWlm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 May 2020 18:41:42 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04MMfP79072647;
        Fri, 22 May 2020 17:41:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590187285;
        bh=oMN/iHiwQjDWS2EDa3kGydbVWyIjwSamwfacAnOEz7U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=T2ODL8QSAc78nanqRS5larGgiQOQxI54GiWHCoZovAz7klB5ifYm6e+C42LeSOcQ1
         iIsGxPbDl+gmUrct57vAww8fSJqBAVm/kc8QuRE/0iNIQv5/fFKelEfKVGlabN/Jt3
         /GJJ9cUpcu8EtZ9brSq+Hob8V8B4m4uKoltN8+5U=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04MMfPlI079465
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 May 2020 17:41:25 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 22
 May 2020 17:41:25 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 22 May 2020 17:41:25 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04MMeh5e044559;
        Fri, 22 May 2020 17:41:20 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v8 07/19] mtd: spi-nor: sfdp: prepare BFPT parsing for JESD216 rev D
Date:   Sat, 23 May 2020 04:10:30 +0530
Message-ID: <20200522224042.29970-8-p.yadav@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200522224042.29970-1-p.yadav@ti.com>
References: <20200522224042.29970-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

JESD216 rev D makes BFPT 20 DWORDs. Update the BFPT size define to
reflect that.

The check for rev A or later compared the BFPT header length with the
maximum BFPT length, BFPT_DWORD_MAX. Since BFPT_DWORD_MAX was 16, and so
was the BFPT length for both rev A and B, this check worked fine. But
now, since BFPT_DWORD_MAX is 20, it means this check will also stop BFPT
parsing for rev A or B, since their length is 16.

So, instead check for BFPT_DWORD_MAX_JESD216 to stop BFPT parsing for
the first JESD216 version, and check for BFPT_DWORD_MAX_JESD216B for the
next two versions.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/sfdp.c | 7 ++++++-
 drivers/mtd/spi-nor/sfdp.h | 5 +++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 5cecc4ba2141..96960f2f3d7a 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -549,7 +549,7 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 				  SNOR_ERASE_TYPE_MASK;
 
 	/* Stop here if not JESD216 rev A or later. */
-	if (bfpt_header->length < BFPT_DWORD_MAX)
+	if (bfpt_header->length == BFPT_DWORD_MAX_JESD216)
 		return spi_nor_post_bfpt_fixups(nor, bfpt_header, &bfpt,
 						params);
 
@@ -605,6 +605,11 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 		return -EINVAL;
 	}
 
+	/* Stop here if JESD216 rev B. */
+	if (bfpt_header->length == BFPT_DWORD_MAX_JESD216B)
+		return spi_nor_post_bfpt_fixups(nor, bfpt_header, &bfpt,
+						params);
+
 	return spi_nor_post_bfpt_fixups(nor, bfpt_header, &bfpt, params);
 }
 
diff --git a/drivers/mtd/spi-nor/sfdp.h b/drivers/mtd/spi-nor/sfdp.h
index e0a8ded04890..f8198af43a63 100644
--- a/drivers/mtd/spi-nor/sfdp.h
+++ b/drivers/mtd/spi-nor/sfdp.h
@@ -10,11 +10,11 @@
 /* Basic Flash Parameter Table */
 
 /*
- * JESD216 rev B defines a Basic Flash Parameter Table of 16 DWORDs.
+ * JESD216 rev D defines a Basic Flash Parameter Table of 20 DWORDs.
  * They are indexed from 1 but C arrays are indexed from 0.
  */
 #define BFPT_DWORD(i)		((i) - 1)
-#define BFPT_DWORD_MAX		16
+#define BFPT_DWORD_MAX		20
 
 struct sfdp_bfpt {
 	u32	dwords[BFPT_DWORD_MAX];
@@ -22,6 +22,7 @@ struct sfdp_bfpt {
 
 /* The first version of JESD216 defined only 9 DWORDs. */
 #define BFPT_DWORD_MAX_JESD216			9
+#define BFPT_DWORD_MAX_JESD216B			16
 
 /* 1st DWORD. */
 #define BFPT_DWORD1_FAST_READ_1_1_2		BIT(16)
-- 
2.26.2

