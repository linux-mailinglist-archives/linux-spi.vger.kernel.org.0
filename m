Return-Path: <linux-spi+bounces-10949-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B29C265C3
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 18:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EA12D351A1A
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 17:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF5934E777;
	Fri, 31 Oct 2025 17:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RDm77a5+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC48C34D90C
	for <linux-spi@vger.kernel.org>; Fri, 31 Oct 2025 17:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931709; cv=none; b=okwJno6dS5U7Yb9L7jOtjzdsiYPh+abET9dXWyLjV1i1gQoPL73Lpf67blFMlQg7nZKP4gHcnGnEO2qO46ZL9aJ++LaqqRlp+/4kaWJ2KFN71wXpZ+XccR5dGGBfuQIJF8/qCE5xQOuFqsfRHWkM6QsugBxvxEcMZlr9Rrd8134=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931709; c=relaxed/simple;
	bh=Pn0tD7LrmNWafD1Jjr21VFXRXXm0MSOuVgcb355pWqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DxPjZZssIlqMPY3tuu8of2mAz/OhktRA9H1JdKp7unQudhHzOJgaKu/7KkzPsmAQCQxj0eChx5XrOrrIumnIRJrURVsTj+tboiAOMvBbeVC0vGsoKAD93b39c/OrxY20FDQWWIqwyJszdsgCIc6xrclcaW7usVXSYvjAZVqxxtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RDm77a5+; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D425EC0E95B;
	Fri, 31 Oct 2025 17:28:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 65C1C60704;
	Fri, 31 Oct 2025 17:28:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AE40411818007;
	Fri, 31 Oct 2025 18:28:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761931705; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jv1QAVetYv+kcwEdo8dQ+dRsDCLD1VFydP/2jra5dV0=;
	b=RDm77a5+ViA3+FA61T1BqPeY3a93LpZKgl/UxpqC6/BRo74xapkI3+wodHs7QQJX+8Ed2c
	mbVBNyeiF/XugST1XsO0/R9TbIAGIyD3EIP5XpB51rZpBt6mor+m7yjn2KU6Rcb7CW0ott
	F2c8iyu0af8g3/AGYdmirCFoGWtncwXjJcVFeTsbcyQgnUZSN0mhiOv16UqNtV0wV7QLjN
	5cRY0Td+sKBZotjGsFLaKOh6q9FuN7V7yzeczqDyOew5VSbnF3IrrqV78BTA16KFVn/OHG
	wCpcPp91zJZQU6finFtuoa3w3nIiUKtQDOpmee3FNmay6h/kiClMqDOn3W1g9Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 31 Oct 2025 18:26:56 +0100
Subject: [PATCH 12/28] mtd: spinand: macronix: Convert vendor specific
 operation to SPINAND_OP()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-winbond-v6-17-rc1-oddr-v1-12-be42de23ebf1@bootlin.com>
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
In-Reply-To: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Macronix chips require a vendor specific operation to read the ECC
status register. Instead of defining this op only in the function that
needs it, hiding it from the core, make it a proper define like all
other spi-mem operations, and implement the necessary
spinand_fill_*_op() helper to make the SPINAND_OP() macro work. This way
we can use it from any function without any extra handling outside of
this helper when we will convert the core to support octal DDR busses.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/macronix.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index 143cc120bdec1300f8fe60e951c4da9174668677..a847ea8f49a8a7005405f6083a4aaac942974998 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -41,6 +41,18 @@ static SPINAND_OP_VARIANTS(update_cache_variants,
 		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
+#define SPINAND_MACRONIX_READ_ECCSR_1S_0_1S(buf)			\
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x7c, 1),				\
+		   SPI_MEM_OP_NO_ADDR,					\
+		   SPI_MEM_OP_DUMMY(1, 1),				\
+		   SPI_MEM_OP_DATA_IN(1, buf, 1))
+
+static struct spi_mem_op
+spinand_fill_macronix_read_eccsr_op(struct spinand_device *spinand, void *valptr)
+{
+	return (struct spi_mem_op)SPINAND_MACRONIX_READ_ECCSR_1S_0_1S(valptr);
+}
+
 static int mx35lfxge4ab_ooblayout_ecc(struct mtd_info *mtd, int section,
 				      struct mtd_oob_region *region)
 {
@@ -67,12 +79,10 @@ static const struct mtd_ooblayout_ops mx35lfxge4ab_ooblayout = {
 static int macronix_get_eccsr(struct spinand_device *spinand, u8 *eccsr)
 {
 	struct macronix_priv *priv = spinand->priv;
-	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(0x7c, 1),
-					  SPI_MEM_OP_NO_ADDR,
-					  SPI_MEM_OP_DUMMY(1, 1),
-					  SPI_MEM_OP_DATA_IN(1, eccsr, 1));
+	struct spi_mem_op op = SPINAND_OP(spinand, macronix_read_eccsr, eccsr);
+	int ret;
 
-	int ret = spi_mem_exec_op(spinand->spimem, &op);
+	ret = spi_mem_exec_op(spinand->spimem, &op);
 	if (ret)
 		return ret;
 

-- 
2.51.0


