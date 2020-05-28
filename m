Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676CE1E5A06
	for <lists+linux-spi@lfdr.de>; Thu, 28 May 2020 10:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgE1H7V (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 May 2020 03:59:21 -0400
Received: from twhmllg4.macronix.com ([122.147.135.202]:31281 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgE1H7U (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 May 2020 03:59:20 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG4.macronix.com with ESMTP id 04S7wMHd030973;
        Thu, 28 May 2020 15:58:26 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     broonie@kernel.org, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com, matthias.bgg@gmail.com
Cc:     p.yadav@ti.com, juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Subject: [PATCH v3 04/14] mtd: spi-nor: sfdp: prepare BFPT parsing for JESD216 rev D
Date:   Thu, 28 May 2020 15:58:06 +0800
Message-Id: <1590652696-8844-5-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1590652696-8844-1-git-send-email-masonccyang@mxic.com.tw>
References: <1590652696-8844-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG4.macronix.com 04S7wMHd030973
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Pratyush Yadav <p.yadav@ti.com>

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
index f917631..c289395 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -548,7 +548,7 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 				  SNOR_ERASE_TYPE_MASK;
 
 	/* Stop here if not JESD216 rev A or later. */
-	if (bfpt_header->length < BFPT_DWORD_MAX)
+	if (bfpt_header->length == BFPT_DWORD_MAX_JESD216)
 		return spi_nor_post_bfpt_fixups(nor, bfpt_header, &bfpt,
 						params);
 
@@ -604,6 +604,11 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
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
index e0a8ded..f8198af 100644
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
1.9.1

