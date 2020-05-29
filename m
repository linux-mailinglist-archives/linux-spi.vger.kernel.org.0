Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64FC41E76C7
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 09:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgE2HhN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 03:37:13 -0400
Received: from twhmllg4.macronix.com ([211.75.127.132]:24793 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgE2HhN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 May 2020 03:37:13 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG4.macronix.com with ESMTP id 04T7aHpv067318;
        Fri, 29 May 2020 15:36:18 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     broonie@kernel.org, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com, matthias.bgg@gmail.com
Cc:     p.yadav@ti.com, juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v4 1/7] mtd: spi-nor: sfdp: get octal mode maximum speed from BFPT
Date:   Fri, 29 May 2020 15:36:09 +0800
Message-Id: <1590737775-4798-2-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1590737775-4798-1-git-send-email-masonccyang@mxic.com.tw>
References: <1590737775-4798-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG4.macronix.com 04T7aHpv067318
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Get maximum operation speed of device in octal mode from
BFPT 20th DWORD.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 drivers/mtd/spi-nor/core.h |  2 ++
 drivers/mtd/spi-nor/sfdp.c | 36 ++++++++++++++++++++++++++++++++++++
 drivers/mtd/spi-nor/sfdp.h |  4 ++++
 3 files changed, 42 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 6f2f6b2..7a36b22 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -190,6 +190,7 @@ struct spi_nor_locking_ops {
  *
  * @size:		the flash memory density in bytes.
  * @page_size:		the page size of the SPI NOR flash memory.
+ * @octal_max_speed:	maximum operation speed of device in octal mode.
  * @hwcaps:		describes the read and page program hardware
  *			capabilities.
  * @reads:		read capabilities ordered by priority: the higher index
@@ -212,6 +213,7 @@ struct spi_nor_locking_ops {
 struct spi_nor_flash_parameter {
 	u64				size;
 	u32				page_size;
+	u16				octal_max_speed;
 
 	struct spi_nor_hwcaps		hwcaps;
 	struct spi_nor_read_command	reads[SNOR_CMD_READ_MAX];
diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index f6038d3..4d13f66 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2014, Freescale Semiconductor, Inc.
  */
 
+#include <linux/bitfield.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
 #include <linux/mtd/spi-nor.h>
@@ -26,6 +27,12 @@
 #define SFDP_JESD216A_MINOR	5
 #define SFDP_JESD216B_MINOR	6
 
+/* Basic Flash Parameter Table 20th DWORD, Max operation speed of device */
+struct octal_max_speed {
+	u8 idx; /* Bits value */
+	u16 hz; /* MHz */
+};
+
 struct sfdp_header {
 	u32		signature; /* Ox50444653U <=> "SFDP" */
 	u8		minor;
@@ -440,6 +447,22 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 	u32 addr;
 	u16 half;
 	u8 erase_mask;
+	static const struct octal_max_speed max_hz[] = {
+		/* Bits value, MHz */
+		{ 0x0c, 400 },
+		{ 0x0b, 333 },
+		{ 0x0a, 266 },
+		{ 0x09, 250 },
+		{ 0x08, 200 },
+		{ 0x07, 166 },
+		{ 0x06, 133 },
+		{ 0x05, 100 },
+		{ 0x04,  80 },
+		{ 0x03,  66 },
+		{ 0x02,  50 },
+		{ 0x01,  33 },
+	};
+	u8 idx;
 
 	/* JESD216 Basic Flash Parameter Table length is at least 9 DWORDs. */
 	if (bfpt_header->length < BFPT_DWORD_MAX_JESD216)
@@ -604,6 +627,19 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 		return -EINVAL;
 	}
 
+	/* Octal mode max speed */
+	idx = max(FIELD_GET(BFPT_DWORD20_OCTAL_DTR_MAX_SPEED,
+			    bfpt.dwords[BFPT_DWORD(20)]),
+		  FIELD_GET(BFPT_DWORD20_OCTAL_STR_MAX_SPEED,
+			    bfpt.dwords[BFPT_DWORD(20)]));
+
+	for (i = 0; i < ARRAY_SIZE(max_hz); i++) {
+		if (max_hz[i].idx == idx) {
+			params->octal_max_speed = max_hz[i].hz;
+			break;
+		}
+	}
+
 	return spi_nor_post_bfpt_fixups(nor, bfpt_header, &bfpt, params);
 }
 
diff --git a/drivers/mtd/spi-nor/sfdp.h b/drivers/mtd/spi-nor/sfdp.h
index e0a8ded..8ae6d9a 100644
--- a/drivers/mtd/spi-nor/sfdp.h
+++ b/drivers/mtd/spi-nor/sfdp.h
@@ -83,6 +83,10 @@ struct sfdp_bfpt {
 #define BFPT_DWORD15_QER_SR2_BIT1_NO_RD		(0x4UL << 20)
 #define BFPT_DWORD15_QER_SR2_BIT1		(0x5UL << 20) /* Spansion */
 
+#define BFPT_DWORD20_OCTAL_MAX_SPEED_MASK       GENMASK(31, 16)
+#define BFPT_DWORD20_OCTAL_DTR_MAX_SPEED        GENMASK(31, 28)
+#define BFPT_DWORD20_OCTAL_STR_MAX_SPEED        GENMASK(19, 16)
+
 struct sfdp_parameter_header {
 	u8		id_lsb;
 	u8		minor;
-- 
1.9.1

