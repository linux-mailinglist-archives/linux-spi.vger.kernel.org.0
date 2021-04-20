Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7A63652C0
	for <lists+linux-spi@lfdr.de>; Tue, 20 Apr 2021 09:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhDTHCI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Apr 2021 03:02:08 -0400
Received: from twhmllg3.macronix.com ([122.147.135.201]:23596 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbhDTHCE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Apr 2021 03:02:04 -0400
Received: from TWHMLLG3.macronix.com (localhost [127.0.0.2] (may be forged))
        by TWHMLLG3.macronix.com with ESMTP id 13K6V2xk084131
        for <linux-spi@vger.kernel.org>; Tue, 20 Apr 2021 14:31:02 +0800 (GMT-8)
        (envelope-from zhengxunli@mxic.com.tw)
Received: from localhost.localdomain ([172.17.195.94])
        by TWHMLLG3.macronix.com with ESMTP id 13K6UM7d083760;
        Tue, 20 Apr 2021 14:30:36 +0800 (GMT-8)
        (envelope-from zhengxunli@mxic.com.tw)
From:   Zhengxun Li <zhengxunli@mxic.com.tw>
To:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Cc:     tudor.ambarus@microchip.com, miquel.raynal@bootlin.com,
        broonie@kernel.org, jaimeliao@mxic.com.tw,
        Zhengxun Li <zhengxunli@mxic.com.tw>
Subject: [PATCH v3 2/3] mtd: spi-nor: macronix: add support for Macronix octaflash series
Date:   Tue, 20 Apr 2021 14:29:38 +0800
Message-Id: <1618900179-14546-3-git-send-email-zhengxunli@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1618900179-14546-1-git-send-email-zhengxunli@mxic.com.tw>
References: <1618900179-14546-1-git-send-email-zhengxunli@mxic.com.tw>
X-MAIL: TWHMLLG3.macronix.com 13K6UM7d083760
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add 1.8V and 3V Octal NOR Flash IDs.
MX25 series : Serial NOR Flash.
MX66 series : Serial NOR Flash with stacked die.
LM/UM series : Up to 250MHz clock frequency with both DTR/STR operation.
LW/UW series : Support simultaneous Read-while-Write operation in multiple
	       bank architecture. Read-while-write feature which means read
	       data one bank while another bank is programing or erasing.

MX25LM : 3.0V Octal I/O
 -https://www.mxic.com.tw/Lists/Datasheet/Attachments/7841/MX25LM51245G,%203V,%20512Mb,%20v1.1.pdf

MX25UM : 1.8V Octal I/O
 -https://www.mxic.com.tw/Lists/Datasheet/Attachments/7525/MX25UM51245G%20Extreme%20Speed,%201.8V,%20512Mb,%20v1.0.pdf

MX66LM : 3.0V Octal I/O with stacked die
 -https://www.mxic.com.tw/Lists/Datasheet/Attachments/7929/MX66LM1G45G,%203V,%201Gb,%20v1.1.pdf

MX66UM : 1.8V Octal I/O with stacked die
 -https://www.mxic.com.tw/Lists/Datasheet/Attachments/7721/MX66UM1G45G,%201.8V,%201Gb,%20v1.1.pdf

MX25LW : 3.0V Octal I/O with Read-while-Write
MX25UW : 1.8V Octal I/O with Read-while-Write
MX66LW : 3.0V Octal I/O with Read-while-Write and stack die
MX66UW : 1.8V Octal I/O with Read-while-Write and stack die

About LW/UW series, please contact us freely if you have any
questions. For adding Octal NOR Flash IDs, we have validated
each Flash on plateform zynq-picozed.

Signed-off-by: Zhengxun Li <zhengxunli@mxic.com.tw>
---
 drivers/mtd/spi-nor/macronix.c | 100 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index 881eaf8..8c1cf1b 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -203,6 +203,106 @@ static void octaflash_post_sfdp_fixup(struct spi_nor *nor)
 	{ "mx66u2g45g",	 INFO(0xc2253c, 0, 64 * 1024, 4096,
 			      SECT_4K | SPI_NOR_DUAL_READ |
 			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ "mx66lm2g45g", INFO(0xc2853c, 0, 64 * 1024, 4096,
+			      SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			      SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx66lm1g45g", INFO(0xc2853b, 0, 32 * 1024, 4096,
+			      SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			      SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx66lw1g45g", INFO(0xc2863b, 0, 32 * 1024, 4096,
+			      SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			      SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx25lm51245g", INFO(0xc2853a, 0, 16 * 1024, 4096,
+			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx25lw51245g", INFO(0xc2863a, 0, 16 * 1024, 4096,
+			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx25lm25645g", INFO(0xc28539, 0, 8 * 1024, 4096,
+			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx25lw25645g", INFO(0xc28639, 0, 8 * 1024, 4096,
+			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx66um2g45g", INFO(0xc2803c, 0, 64 * 1024, 4096,
+			      SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			      SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx66uw2g345g", INFO(0xc2843c, 0, 64 * 1024, 4096,
+			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx66uw2g345gx0", INFO(0xc2943c, 0, 64 * 1024, 4096,
+				 SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+				 SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx66um1g45g", INFO(0xc2803b, 0, 32 * 1024, 4096,
+			      SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			      SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx66um1g45g40", INFO(0xc2808b, 0, 32 * 1024, 4096,
+				SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+				SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx66uw1g45g", INFO(0xc2813b, 0, 32 * 1024, 4096,
+			      SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			      SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx25um51245g", INFO(0xc2803a, 0, 16 * 1024, 4096,
+			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx25uw51245g", INFO(0xc2813a, 0, 16 * 1024, 4096,
+			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx25uw51345g", INFO(0xc2843a, 0, 16 * 1024, 4096,
+			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx25um25645g", INFO(0xc28039, 0, 8 * 1024, 4096,
+			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx25uw25645g", INFO(0xc28139, 0, 8 * 1024, 4096,
+			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx25um25345g", INFO(0xc28339, 0, 8 * 1024, 4096,
+			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx25uw25345g", INFO(0xc28439, 0, 8 * 1024, 4096,
+			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx25uw12845g", INFO(0xc28138, 0, 4 * 1024, 4096,
+			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx25uw12a45g", INFO(0xc28938, 0, 4 * 1024, 4096,
+			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx25uw12345g", INFO(0xc28438, 0, 4 * 1024, 4096,
+			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx25uw6445g", INFO(0xc28137, 0, 2 * 1024, 4096,
+			      SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			      SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx25uw6345g", INFO(0xc28437, 0, 2 * 1024, 4096,
+			      SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			      SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
 };
 
 static void macronix_default_init(struct spi_nor *nor)
-- 
1.9.1

