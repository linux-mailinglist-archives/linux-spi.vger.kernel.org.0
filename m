Return-Path: <linux-spi+bounces-10950-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0324DC265C6
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 18:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A4038351849
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 17:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F6F34F251;
	Fri, 31 Oct 2025 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ff+PzoKB"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6705534E770;
	Fri, 31 Oct 2025 17:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931711; cv=none; b=qje5PsJ22tAR+zoJeUqURxuV4bOtfHdDQKgeLUxhHis0jAPZdMlBTdLebB6m9Y7LU7epfAt5QyplTrKZ2kB7ldLOmKWMb/RVvc+tK3uuWDy8YQwXc0IZ/JXs3C7hcpf5o9Sk2GxOKBV1unAtQg2pbsAU5oV2ErRYnQ4e1JwHt9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931711; c=relaxed/simple;
	bh=O51E92q0HPpkwU3k3rtTN1TcSTHfPCvZ4DMZw7Q4hTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DM76WHtTh+Uea1gx95YbAFJ2s6BBp2CLbUtXLdbuzv935ggZCydugDdzuF14YsjmIYnFZSnb03onnLm+CyxzyrKjNdM/8kI8jeNX+L8FjySMtQjxZSgH4CiunjfCUJjw52qGGwSYxiDY+m1Mbk9Ul+FlvUzlEzEkwRwZoJWCRvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ff+PzoKB; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 41A0BC0E959;
	Fri, 31 Oct 2025 17:28:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C680160704;
	Fri, 31 Oct 2025 17:28:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0665D1181800A;
	Fri, 31 Oct 2025 18:28:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761931707; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0D819DjHSpaRd5sIkugzSV64SQrVD1HOP8VmsLdk4Cc=;
	b=ff+PzoKBP81lcSIDzQLMSk0h88WMACbVcd1/DCo/j/SjoCpU1K14DqJD148RjQbuEFs5ra
	jCa198t0lPKipwaWH8Zc+PmsXA1LifdU6zAWhc7D5Xry46x6ZX1TLzQr4dz2leRiYNzs/M
	eTeJpOpH4xuurPTO/15yXJtHNs5KImf9T0cmx2+148VFibhq8ojRvrB1FNsWWLlrHFfOi4
	9d7rAy+3JfvBhwUqKRq2/URpkERT1NSie6vhohmVXdX5Z2h8tLj99ZIQhZFu2ZU3V4rnAo
	SJgjtdfHAChcgw+4bDAyj1oKHNS5aMZ+/k/YM1bVBWiAatqj3UPntvJAj2Igog==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 31 Oct 2025 18:26:57 +0100
Subject: [PATCH 13/28] mtd: spinand: winbond: Convert W25N specific
 operation to SPINAND_OP()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-winbond-v6-17-rc1-oddr-v1-13-be42de23ebf1@bootlin.com>
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

Winbond W25N* chips require a vendor specific operation to select the
target. Instead of defining this op only in the function that
needs it, hiding it from the core, make it a proper define like all
other spi-mem operations, and implement the necessary
spinand_fill_*_op() helper to make the SPINAND_OP() macro work. This way
we can use it from any function without any extra handling outside of
this helper when we will convert the core to support octal DDR busses.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/winbond.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index bfec5d037f25b81a3c90feba666fe8283a41ddb1..dde59f8f63f511a298a43a5b43fe07c1d726f179 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -87,6 +87,18 @@ static SPINAND_OP_VARIANTS(update_cache_variants,
 		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
+#define SPINAND_WINBOND_SELECT_TARGET_1S_0_1S(buf)			\
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0xc2, 1),				\
+		   SPI_MEM_OP_NO_ADDR,					\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_DATA_OUT(1, buf, 1))
+
+static struct spi_mem_op
+spinand_fill_winbond_select_target_op(struct spinand_device *spinand, void *valptr)
+{
+	return (struct spi_mem_op)SPINAND_WINBOND_SELECT_TARGET_1S_0_1S(valptr);
+}
+
 static int w25m02gv_ooblayout_ecc(struct mtd_info *mtd, int section,
 				  struct mtd_oob_region *region)
 {
@@ -119,12 +131,8 @@ static const struct mtd_ooblayout_ops w25m02gv_ooblayout = {
 static int w25m02gv_select_target(struct spinand_device *spinand,
 				  unsigned int target)
 {
-	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(0xc2, 1),
-					  SPI_MEM_OP_NO_ADDR,
-					  SPI_MEM_OP_NO_DUMMY,
-					  SPI_MEM_OP_DATA_OUT(1,
-							spinand->scratchbuf,
-							1));
+	struct spi_mem_op op = SPINAND_OP(spinand, winbond_select_target,
+					  spinand->scratchbuf);
 
 	*spinand->scratchbuf = target;
 	return spi_mem_exec_op(spinand->spimem, &op);

-- 
2.51.0


