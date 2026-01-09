Return-Path: <linux-spi+bounces-12253-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6EED0B9D8
	for <lists+linux-spi@lfdr.de>; Fri, 09 Jan 2026 18:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E578730BF6A5
	for <lists+linux-spi@lfdr.de>; Fri,  9 Jan 2026 17:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E128636A01F;
	Fri,  9 Jan 2026 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B/LGMcFR"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23202363C7D;
	Fri,  9 Jan 2026 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979117; cv=none; b=apYSSnR/UY0h27r9pLViERO2/25J3+WZGZl+kWF90OkMaXtP9tEfj+r6NeDR5rlr5JiaTxGygPLA7Zldkc8u92CIcvihKAIHiAxPNJI4ra9w5Ml/E9OI4Q6rB1iU1Odq7fgxXHUm90gE9EoWG/K5L2EPR6Ye54fAOd6+NciocYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979117; c=relaxed/simple;
	bh=WcGEMjOmQjM6t96flwtOxzEtnWtvRoR1/zJTT8U0FFE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NHUVEM06YzuF5hl9P+xcfvmlmjLwnjwInhN+YGHk3dUiD+2crXIxFhA+ItCBbFPWP2znH5ifPDnimQj/D+dSq9itxEbXesNZC0uA+ZywDBGeEwAHz5uXazaxfYA5T90iDVR6++ucCU+duLq5lrvMgWIUAcJk76JlDgmeGi8aQwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B/LGMcFR; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A00594E42029;
	Fri,  9 Jan 2026 17:18:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7557A606C6;
	Fri,  9 Jan 2026 17:18:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CC50D103C89B4;
	Fri,  9 Jan 2026 18:18:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767979111; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4zjmlLEWJ7QiWDqCO5iOkGGWDWg9nbW2A4ll6YCRUWA=;
	b=B/LGMcFRBzv6EB4j2c0orh3cOwxmyU5vLKT8cWE6pXSo3dOam9Qlmkxis31MCOFDMjOEWJ
	9Woy8QXW8qyBncApfqGJfJu5967gIV0WvoTChgzqGdrnk+QXJvjWh6PKIGobvtqWElc7zW
	kObxAOHcp+x4HYAT48VfE6sK1iVPr5SogSEAzu5fwdCnl+cLQ1dYjgBPVcy6JBZmGqOu7a
	alPc8/JLSj7WdeE5Hu9JDXjbMkh9OlrRJ46zQEWHek8zdmWQrHlwq8j5tgo8DuB7oqGbVv
	kMIfuZDYeTVLFE/LaYh98KDk6XeixcHTniEaTgI7Pl2wnyyI3FzQiFilf8llpg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 09 Jan 2026 18:18:09 +0100
Subject: [PATCH v2 11/27] mtd: spinand: macronix: Convert vendor specific
 operation to SPINAND_OP()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-winbond-v6-17-rc1-oddr-v2-11-1fff6a2ddb80@bootlin.com>
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

Macronix chips require a vendor specific operation to read the ECC
status register. Instead of defining this op only in the function that
needs it, hiding it from the core, make it a proper define like all
other spi-mem operations, and implement the necessary
spinand_fill_*_op() helper to make the SPINAND_OP() macro work. This way
we can use it from any function without any extra handling outside of
this helper when we will convert the core to support octal DDR busses.

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/macronix.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index 143cc120bdec..a847ea8f49a8 100644
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
2.51.1


