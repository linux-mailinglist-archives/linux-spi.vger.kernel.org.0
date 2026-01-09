Return-Path: <linux-spi+bounces-12249-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 404AED0BA9B
	for <lists+linux-spi@lfdr.de>; Fri, 09 Jan 2026 18:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB60C3067DEB
	for <lists+linux-spi@lfdr.de>; Fri,  9 Jan 2026 17:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA690366576;
	Fri,  9 Jan 2026 17:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="anUYVoSF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D515369970
	for <linux-spi@vger.kernel.org>; Fri,  9 Jan 2026 17:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979114; cv=none; b=LCBkemJS3SmbRBlKwtVXCEbV86l9cyTEa+lQ6Fe8Dk5NZwUb6CK34nENy4gCx7p7fyAY6ioKZKdxlYK3AQlndJQ4CpXjaEH5FtJQ84cbHOGAOvD+W5rmHajZA5gYuj4LF8cEx43Ejm4XIx8cxXFLR1CDMmP7MLV7MtxwtpcwI6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979114; c=relaxed/simple;
	bh=3cnZl6iBYq20G1oigmirIZU3zYFeD3CzrUt2kAf0RZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KJxMI4rh4oFAGFsOoOyHrQLz1B1ABPqmuyB40q1sncnA3Q8ee6CPg0p/0Yvy69tthR/MPgY/B4SxSLAKxSFjMk6OmDMkAkZbngoRuga+1yXveeqkxD3SaKPv0A1CVqbGtfS09IgLSreFC5XLFixfGh8bfQ2Endvos45o0NYnryI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=anUYVoSF; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 701F9C1F6E5;
	Fri,  9 Jan 2026 17:18:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B8A2D606C6;
	Fri,  9 Jan 2026 17:18:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 23A93103C89B0;
	Fri,  9 Jan 2026 18:18:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767979108; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+jxMeS1xeb2E/hPVCFWCVOrKjIjBVGxQ/ROrL992r1Q=;
	b=anUYVoSF/XEgcDp6AyMCYYU4XpfSBdPg8hGKre023w+RWt7yJh0T0Nd3i3Kr5jrdQta2v4
	WT+2Dk3YY0Wboj3L4MyE5Cm2Jb/9YwErd6zxfLmhN9VtXuEd9awgxsAZ3gwieFmbRWih5t
	Es1nOOTSXTrZl7ySmeGZjK7/EjVyn2PpFyUgudVh76nTzgKeDBYWy/1ZNEkhHaCDlHCHcE
	XdxgTiVJQlt0ONb3wwDPi43vIShbeXHyxRIEmJTMDv2A/Npvx36Gem/YWTZ13ESZdwW34c
	RXvo2YVvlIelwY8Rc8M9YP6Yi2CDBouoenRzxJrPhlpU4kgBqzksa/i1q+iAog==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 09 Jan 2026 18:18:06 +0100
Subject: [PATCH v2 08/27] mtd: spinand: Decouple write enable and write
 disable operations
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-winbond-v6-17-rc1-oddr-v2-8-1fff6a2ddb80@bootlin.com>
References: <20260109-winbond-v6-17-rc1-oddr-v2-0-1fff6a2ddb80@bootlin.com>
In-Reply-To: <20260109-winbond-v6-17-rc1-oddr-v2-0-1fff6a2ddb80@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

In order to introduce templates for all operations and not only for page
helpers (in order to introduce octal DDR support), decouple the WR_EN
and WR_DIS operations into two separate macros.

Adapt the callers accordingly.

There is no functional change.

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/core.c   |  2 +-
 drivers/mtd/nand/spi/esmt.c   |  2 +-
 drivers/mtd/nand/spi/micron.c |  2 +-
 include/linux/mtd/spinand.h   | 10 ++++++++--
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 3abc56e4d23f..b6613f2651bd 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -362,7 +362,7 @@ static void spinand_ondie_ecc_save_status(struct nand_device *nand, u8 status)
 
 int spinand_write_enable_op(struct spinand_device *spinand)
 {
-	struct spi_mem_op op = SPINAND_WR_EN_DIS_1S_0_0_OP(true);
+	struct spi_mem_op op = SPINAND_WR_EN_1S_0_0_OP;
 
 	return spi_mem_exec_op(spinand->spimem, &op);
 }
diff --git a/drivers/mtd/nand/spi/esmt.c b/drivers/mtd/nand/spi/esmt.c
index e60e4ac1fd6f..adadc01e8f2f 100644
--- a/drivers/mtd/nand/spi/esmt.c
+++ b/drivers/mtd/nand/spi/esmt.c
@@ -138,7 +138,7 @@ static int f50l1g41lb_user_otp_info(struct spinand_device *spinand, size_t len,
 static int f50l1g41lb_otp_lock(struct spinand_device *spinand, loff_t from,
 			       size_t len)
 {
-	struct spi_mem_op write_op = SPINAND_WR_EN_DIS_1S_0_0_OP(true);
+	struct spi_mem_op write_op = SPINAND_WR_EN_1S_0_0_OP;
 	struct spi_mem_op exec_op = SPINAND_PROG_EXEC_1S_1S_0_OP(0);
 	u8 status;
 	int ret;
diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index a49d7cb6a96d..b8130e04e8e7 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -251,7 +251,7 @@ static int mt29f2g01abagd_user_otp_info(struct spinand_device *spinand,
 static int mt29f2g01abagd_otp_lock(struct spinand_device *spinand, loff_t from,
 				   size_t len)
 {
-	struct spi_mem_op write_op = SPINAND_WR_EN_DIS_1S_0_0_OP(true);
+	struct spi_mem_op write_op = SPINAND_WR_EN_1S_0_0_OP;
 	struct spi_mem_op exec_op = SPINAND_PROG_EXEC_1S_1S_0_OP(0);
 	u8 status;
 	int ret;
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index ad2773f1f963..f7621b47b28f 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -26,8 +26,14 @@
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_NO_DATA)
 
-#define SPINAND_WR_EN_DIS_1S_0_0_OP(enable)					\
-	SPI_MEM_OP(SPI_MEM_OP_CMD((enable) ? 0x06 : 0x04, 1),		\
+#define SPINAND_WR_EN_1S_0_0_OP						\
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x06, 1),				\
+		   SPI_MEM_OP_NO_ADDR,					\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_NO_DATA)
+
+#define SPINAND_WR_DIS_1S_0_0_OP					\
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x04, 1),				\
 		   SPI_MEM_OP_NO_ADDR,					\
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_NO_DATA)

-- 
2.51.1


