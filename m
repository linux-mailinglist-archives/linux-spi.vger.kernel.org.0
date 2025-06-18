Return-Path: <linux-spi+bounces-8639-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1615AADEBB1
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 14:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C61D01633F8
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 12:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B9D2EA15F;
	Wed, 18 Jun 2025 12:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MglZrE1y"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659172DFF3E;
	Wed, 18 Jun 2025 12:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750248944; cv=none; b=T1E81igpaOIGKy8KVO5ZXiMlHSuScN+TPkOSJsaGgSLiR8t4jk4JOpMW2Am/w3bqZpfuAaawApD7Aa03r3VpRMSrXAfSs96Uqcl3i5BpKpotc34zUOHb+M04hhsBOkpnzVwvpaQvRsU/08Gx1nTNtwaRzvV/QP0DH8497ipZAuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750248944; c=relaxed/simple;
	bh=PJqlwNmNogp5tPbUgIRddpDmiCztISqBqa7iQ0IIvUE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OW7JRGXXRBTGLNY7lMUolfITHRTBE9vWc6XvKdqQThcb7N/G0ao6lYilNyOX7oJkRj/K2ovjc+aAuAu65WhocVpnfBlRVyMd6g2BXXTL/3jxrUfIFUMlxgd9KqwXSMJYE/MuuwJQr7ar+LcEzdLwXmaO5vnw2JGAaO2jgc4uXuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MglZrE1y; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 14DC24385C;
	Wed, 18 Jun 2025 12:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750248939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dIvHGU927pY0BXWg4mI0S7APaZ3Put7t3e/0sszfM/c=;
	b=MglZrE1yuTuYqz3SrTVEAGp9j10sovR5F0Q800kE0h9qdtHs1o4xn/VhQ6WrqBV1Qg5TrT
	NdFbtmaOFCOeZhHAa38yG4dLucgw96gC32fKcBXPw2SFYPXyN32i7mhHXSiyX7kGdk1tT4
	pkIw6vuMZqx555QbF4jsqX9+fNFvUwsnTM+ey6BOXAnTha3dRH3AwUomZ926VsAVIxKECQ
	A/0f+WtQvNaRyfGtCH/+xXHiQIBH2Njq7k0NEI0NhadmqhpGLfK8FbDlEa8cGwHSHUxcXP
	BKfQhlZ0jMr1dD22ITkN+evGEFSThwt6h3lNHVg7hvnH8gr34gAboy71CpzsBA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 18 Jun 2025 14:14:24 +0200
Subject: [PATCH 7/8] mtd: spinand: winbond: Enable high-speed modes on
 w35n0xjw
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-winbond-6-16-rc1-octal-phy-upstream-v1-7-513202126013@bootlin.com>
References: <20250618-winbond-6-16-rc1-octal-phy-upstream-v1-0-513202126013@bootlin.com>
In-Reply-To: <20250618-winbond-6-16-rc1-octal-phy-upstream-v1-0-513202126013@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Yogesh S <yogeshs@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Steam Lin <STLin2@winbond.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvieduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelgfehvdduieefieeikeffgffggfdttdeugeffieetheeuleelfeehffdtffetveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpeeinecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrgeeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeihohhgvghshhhssehtihdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtp
 hhtthhopehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepuffvnfhinhdvseifihhnsghonhgurdgtohhmpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrgh
X-GND-Sasl: miquel.raynal@bootlin.com

w35n0xjw chips can run at up to 166MHz in octal mode, but this is only
possible after programming various VCR registers.

Implement the new ->configure_chip() hook for this purpose.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/core.c    |  2 +-
 drivers/mtd/nand/spi/winbond.c | 95 ++++++++++++++++++++++++++++++++++++++++--
 include/linux/mtd/spinand.h    |  1 +
 3 files changed, 94 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 67786831b30df13b1f35c0e478a049ef7b3be4b7..77e17478997c09ee076b3e2db2ae16c868640ba3 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -360,7 +360,7 @@ static void spinand_ondie_ecc_save_status(struct nand_device *nand, u8 status)
 		engine_conf->status = status;
 }
 
-static int spinand_write_enable_op(struct spinand_device *spinand)
+int spinand_write_enable_op(struct spinand_device *spinand)
 {
 	struct spi_mem_op op = SPINAND_WR_EN_DIS_1S_0_0_OP(true);
 
diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 18ae6f58a546e184a54ce0ea74b9b3fe03a10f72..53890b1da65cd4b2a956edde48c591c043242399 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/mtd/spinand.h>
 #include <linux/units.h>
+#include <linux/delay.h>
 
 #define SPINAND_MFR_WINBOND		0xEF
 
@@ -21,14 +22,26 @@
 #define W25N0XJW_SR4			0xD0
 #define W25N0XJW_SR4_HS			BIT(2)
 
+#define W35N01JW_VCR_IO_MODE			0x00
+#define W35N01JW_VCR_IO_MODE_SINGLE_SDR		0xFF
+#define W35N01JW_VCR_IO_MODE_OCTAL_SDR		0xDF
+#define W35N01JW_VCR_IO_MODE_OCTAL_DDR_DS	0xE7
+#define W35N01JW_VCR_IO_MODE_OCTAL_DDR		0xC7
+#define W35N01JW_VCR_DUMMY_CLOCK_REG	0x01
+
 /*
  * "X2" in the core is equivalent to "dual output" in the datasheets,
  * "X4" in the core is equivalent to "quad output" in the datasheets.
  */
 
 static SPINAND_OP_VARIANTS(read_cache_octal_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1D_8D_OP(0, 3, NULL, 0, 120 * HZ_PER_MHZ),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1D_8D_OP(0, 2, NULL, 0, 105 * HZ_PER_MHZ),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_8S_8S_OP(0, 20, NULL, 0, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_8S_8S_OP(0, 16, NULL, 0, 162 * HZ_PER_MHZ),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_8S_8S_OP(0, 12, NULL, 0, 124 * HZ_PER_MHZ),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_8S_8S_OP(0, 8, NULL, 0, 86 * HZ_PER_MHZ),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_8S_OP(0, 2, NULL, 0, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_8S_OP(0, 1, NULL, 0, 133 * HZ_PER_MHZ),
 		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
@@ -269,6 +282,79 @@ static int w25n0xjw_hs_cfg(struct spinand_device *spinand)
 	return 0;
 }
 
+static int w35n0xjw_write_vcr(struct spinand_device *spinand, u8 reg, u8 val)
+{
+	struct spi_mem_op op =
+		SPI_MEM_OP(SPI_MEM_OP_CMD(0x81, 1),
+			   SPI_MEM_OP_ADDR(3, reg, 1),
+			   SPI_MEM_OP_NO_DUMMY,
+			   SPI_MEM_OP_DATA_OUT(1, spinand->scratchbuf, 1));
+	int ret;
+
+	*spinand->scratchbuf = val;
+
+	ret = spinand_write_enable_op(spinand);
+	if (ret)
+		return ret;
+
+	ret = spi_mem_exec_op(spinand->spimem, &op);
+	if (ret)
+		return ret;
+
+	/*
+	 * Write VCR operation doesn't set the busy bit in SR, which means we
+	 * cannot perform a status poll. Minimum time of 50ns is needed to
+	 * complete the write.
+	 */
+	ndelay(50);
+
+	return 0;
+}
+
+static int w35n0xjw_vcr_cfg(struct spinand_device *spinand)
+{
+	const struct spi_mem_op *op;
+	unsigned int dummy_cycles;
+	bool dtr, single;
+	u8 io_mode;
+	int ret;
+
+	op = spinand->op_templates.read_cache;
+
+	single = (op->cmd.buswidth == 1 && op->addr.buswidth == 1 && op->data.buswidth == 1);
+	dtr = (op->cmd.dtr || op->addr.dtr || op->data.dtr);
+	if (single && !dtr)
+		io_mode = W35N01JW_VCR_IO_MODE_SINGLE_SDR;
+	else if (!single && !dtr)
+		io_mode = W35N01JW_VCR_IO_MODE_OCTAL_SDR;
+	else if (!single && dtr)
+		io_mode = W35N01JW_VCR_IO_MODE_OCTAL_DDR;
+	else
+		return -EINVAL;
+
+	ret = w35n0xjw_write_vcr(spinand, W35N01JW_VCR_IO_MODE, io_mode);
+	if (ret)
+		return ret;
+
+	dummy_cycles = ((op->dummy.nbytes * 8) / op->dummy.buswidth) / (op->dummy.dtr ? 2 : 1);
+	switch (dummy_cycles) {
+	case 8:
+	case 12:
+	case 16:
+	case 20:
+	case 24:
+	case 28:
+		break;
+	default:
+		return -EINVAL;
+	}
+	ret = w35n0xjw_write_vcr(spinand, W35N01JW_VCR_DUMMY_CLOCK_REG, dummy_cycles);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static const struct spinand_info winbond_spinand_table[] = {
 	/* 512M-bit densities */
 	SPINAND_INFO("W25N512GW", /* 1.8V */
@@ -326,7 +412,8 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &write_cache_octal_variants,
 					      &update_cache_octal_variants),
 		     0,
-		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL)),
+		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL),
+		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg)),
 	SPINAND_INFO("W35N02JW", /* 1.8V */
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdf, 0x22),
 		     NAND_MEMORG(1, 4096, 128, 64, 512, 10, 1, 2, 1),
@@ -335,7 +422,8 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &write_cache_octal_variants,
 					      &update_cache_octal_variants),
 		     0,
-		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL)),
+		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL),
+		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg)),
 	SPINAND_INFO("W35N04JW", /* 1.8V */
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdf, 0x23),
 		     NAND_MEMORG(1, 4096, 128, 64, 512, 10, 1, 4, 1),
@@ -344,7 +432,8 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &write_cache_octal_variants,
 					      &update_cache_octal_variants),
 		     0,
-		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL)),
+		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL),
+		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg)),
 	/* 2G-bit densities */
 	SPINAND_INFO("W25M02GV", /* 2x1G-bit 3.3V */
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xab, 0x21),
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 53c881e41fc7edac7a526fa7eb6134c4f520054d..27a45bdab7ec97a68482ae28723f7ddc0f95980b 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -741,6 +741,7 @@ int spinand_match_and_init(struct spinand_device *spinand,
 int spinand_upd_cfg(struct spinand_device *spinand, u8 mask, u8 val);
 int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val);
 int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val);
+int spinand_write_enable_op(struct spinand_device *spinand);
 int spinand_select_target(struct spinand_device *spinand, unsigned int target);
 
 int spinand_wait(struct spinand_device *spinand, unsigned long initial_delay_us,

-- 
2.48.1


