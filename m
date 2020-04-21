Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191B31B1F88
	for <lists+linux-spi@lfdr.de>; Tue, 21 Apr 2020 09:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgDUHJJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Apr 2020 03:09:09 -0400
Received: from twhmllg3.macronix.com ([122.147.135.201]:50586 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgDUHJI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Apr 2020 03:09:08 -0400
Received: from TWHMLLG3.macronix.com (localhost [127.0.0.2] (may be forged))
        by TWHMLLG3.macronix.com with ESMTP id 03L6efsP046635
        for <linux-spi@vger.kernel.org>; Tue, 21 Apr 2020 14:40:41 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id 03L6dnMa045498;
        Tue, 21 Apr 2020 14:39:53 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     broonie@kernel.org, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com
Cc:     juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v2 4/5] mtd: spi-nor: macronix: Add Octal 8D-8D-8D supports for Macronix mx25uw51245g
Date:   Tue, 21 Apr 2020 14:39:46 +0800
Message-Id: <1587451187-6889-5-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1587451187-6889-1-git-send-email-masonccyang@mxic.com.tw>
References: <1587451187-6889-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG3.macronix.com 03L6dnMa045498
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Macronix mx25uw51245g is a SPI NOR that supports 1-1-1/8-8-8 mode and
JEDEC216D spec. included BFPT DWORD-18,19, 20 and xSPI profile 1.0 table.

Correct the dummy cycles for various frequency after xSPI 1.0 table parsed.

Enable mx25uw51245g to Octal 8D-8D-8D mode by writing CFG Reg2 in the
late initialization of default flash parameters spi_nor_late_init_params();

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 drivers/mtd/spi-nor/macronix.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index ab0f963..46bcfe5 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -8,6 +8,43 @@
 
 #include "core.h"
 
+#define MXIC_CR2_DUMMY_SET_ADDR 0x300
+
+/* Fixup the dummy cycles after SFDP xSPI 1.0 parsed */
+static void mx25uw51245g_post_sfdp_fixups(struct spi_nor *nor)
+{
+	struct spi_nor_flash_parameter *params = nor->params;
+	int ret;
+	u8 rdc, wdc;
+
+	ret = spi_nor_read_cr2(nor, MXIC_CR2_DUMMY_SET_ADDR, &rdc);
+	if (ret)
+		return;
+
+	/* Refer to dummy cycle and frequency table(MHz) */
+	switch (params->dummy_cycles) {
+	case 10:	/* 10 dummy cycles for 104 MHz */
+		wdc = 5;
+		break;
+	case 12:	/* 12 dummy cycles for 133 MHz */
+		wdc = 4;
+		break;
+	case 16:	/* 16 dummy cycles for 166 MHz */
+		wdc = 2;
+		break;
+	case 20:	/* 20 dummy cycles for 200 MHz */
+	default:
+		wdc = 0;
+	}
+
+	if (rdc != wdc)
+		spi_nor_write_cr2(nor, MXIC_CR2_DUMMY_SET_ADDR, &wdc);
+}
+
+static struct spi_nor_fixups mx25uw51245g_fixups = {
+	.post_sfdp = mx25uw51245g_post_sfdp_fixups,
+};
+
 static int
 mx25l25635_post_bfpt_fixups(struct spi_nor *nor,
 			    const struct sfdp_parameter_header *bfpt_header,
@@ -78,6 +115,10 @@
 			      SPI_NOR_QUAD_READ) },
 	{ "mx66l1g55g",  INFO(0xc2261b, 0, 64 * 1024, 2048,
 			      SPI_NOR_QUAD_READ) },
+	{ "mx25uw51245g",  INFO(0xc2813a, 0, 64 * 1024, 1024,
+				SECT_4K | SPI_NOR_4B_OPCODES |
+				SPI_NOR_OCTAL_RD_WR)
+				.fixups = &mx25uw51245g_fixups },
 };
 
 static void macronix_default_init(struct spi_nor *nor)
-- 
1.9.1

