Return-Path: <linux-spi+bounces-12254-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CCED0BAA5
	for <lists+linux-spi@lfdr.de>; Fri, 09 Jan 2026 18:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FDE630AF9DE
	for <lists+linux-spi@lfdr.de>; Fri,  9 Jan 2026 17:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B07C366DC3;
	Fri,  9 Jan 2026 17:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UdsMaNco"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F569369996
	for <linux-spi@vger.kernel.org>; Fri,  9 Jan 2026 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979120; cv=none; b=haWTbHbXWli4OL8gZB8oR+6El9skVOHTMgUT5fkGGa8/AxPvwTqQ55zQ3sd7YgzRLBpo62o4xV6R3HAjrW3MYVm7FngnWAA1x4s+fMtQtlc5DhWoCljNFYLja59dPTAc1mc0X5q8dIcI7u82leXTOAiKMBjRROOjbBT9ft1vpaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979120; c=relaxed/simple;
	bh=C9hwsEV3wdatwD062DI30KDF+447ewMTinjMJ6/pCpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ub0gx8DZSrC/10pUbt31WGDYwqgcMIw4cFZM1hjQheO3Df1XBullm7pT+/fHn7SP5s8T4xHPnqg/ll1dAQks/6zp8zAFoS2yUyNcqTQ4ws9Q92S2zjWeb5MIlRlZoZWVCxbBnXP2KopQsADNOtcNQK5ofUaNwqnsRb+APHS1NHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UdsMaNco; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id DC4A44E4202C;
	Fri,  9 Jan 2026 17:18:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B1DD6606C6;
	Fri,  9 Jan 2026 17:18:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2A784103C89B6;
	Fri,  9 Jan 2026 18:18:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767979114; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ByaYUaNaJV4Ff78T5l6xTtVf1Fq+ywBCL3Mu7MTdSkQ=;
	b=UdsMaNcoXXLblizSSEA94E3C9P1gYOwOG3Vz5eSmiqJHjG5wg6BwLbw8AesjWv6FfCZVdy
	MJWXpNP5Y2g1QFUXsAOKSy81FE+msf1OCh1zcmjrOBTC6p5EuO8i9z5T7SwzQ8Qotnre56
	DkwcD5Uql3fcEqo9TV9KN9IC+68+4whP6QJw+XRHDijyQxyLKFjSO8BdnHf34tn1ZEadJi
	Loj5px3PcU+6lDYLHlzIEqqdZz423KFusUKE7TeNS/SseFaydMgk2PttoEXKB73M8X/E7r
	nBWITkh/C0maqJiWF9GauvknVG5/lFc7iJBRbASjgrn5fCCSEb7hBLwVAMnyDA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 09 Jan 2026 18:18:11 +0100
Subject: [PATCH v2 13/27] mtd: spinand: winbond: Convert W35N specific
 operation to SPINAND_OP()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-winbond-v6-17-rc1-oddr-v2-13-1fff6a2ddb80@bootlin.com>
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

Winbond W35N* chips require a vendor specific operation to write their
VCR register (a configuration register, typically used for tuning the
number of dummy cycles and switching to a different bus
interface). Instead of defining this op only in the function that needs
it, hiding it from the core, make it a proper define like all other
spi-mem operations, and implement the necessary spinand_fill_*_op()
helper to make the SPINAND_OP() macro work. This way we can use it from
any function without any extra handling outside of this helper when we
will convert the core to support octal DDR busses.

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/winbond.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index dde59f8f63f5..3003ad7e83ee 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -87,6 +87,18 @@ static SPINAND_OP_VARIANTS(update_cache_variants,
 		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
+#define SPINAND_WINBOND_WRITE_VCR_1S_1S_1S(reg, buf)			\
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x81, 1),				\
+		   SPI_MEM_OP_ADDR(3, reg, 1),				\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_DATA_OUT(1, buf, 1))
+
+static struct spi_mem_op
+spinand_fill_winbond_write_vcr_op(struct spinand_device *spinand, u8 reg, void *valptr)
+{
+	return (struct spi_mem_op)SPINAND_WINBOND_WRITE_VCR_1S_1S_1S(reg, valptr);
+}
+
 #define SPINAND_WINBOND_SELECT_TARGET_1S_0_1S(buf)			\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0xc2, 1),				\
 		   SPI_MEM_OP_NO_ADDR,					\
@@ -329,11 +341,8 @@ static int w25n0xjw_hs_cfg(struct spinand_device *spinand)
 
 static int w35n0xjw_write_vcr(struct spinand_device *spinand, u8 reg, u8 val)
 {
-	struct spi_mem_op op =
-		SPI_MEM_OP(SPI_MEM_OP_CMD(0x81, 1),
-			   SPI_MEM_OP_ADDR(3, reg, 1),
-			   SPI_MEM_OP_NO_DUMMY,
-			   SPI_MEM_OP_DATA_OUT(1, spinand->scratchbuf, 1));
+	struct spi_mem_op op = SPINAND_OP(spinand, winbond_write_vcr,
+					  reg, spinand->scratchbuf);
 	int ret;
 
 	*spinand->scratchbuf = val;

-- 
2.51.1


