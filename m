Return-Path: <linux-spi+bounces-10951-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0294CC265DE
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 18:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B70C6403F94
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 17:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8175134F482;
	Fri, 31 Oct 2025 17:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hNMbrx24"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A941034EF0B;
	Fri, 31 Oct 2025 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931712; cv=none; b=AvBCIjxzCKwQ5OWWLjW+8FuLUl67xZ7cjOUvQ3EPEnzALY6J1oBeeYkJ4U9gwe99UIT0FFMtrJI5wfyBrbdBmZ9mebXRpvNi40zqsyLM3uFVxXTEr4rCpQAb6gIHeq/FVtxLfdIPWs49/Rn1uWOcvH2Y/+skWpprY3ZbPR6p+qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931712; c=relaxed/simple;
	bh=07EOgXth6XkPkHWngakcKndxm5s+WUTbZtg+4rzo0eQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MnbxIg1xgHyy4Guy3Rk7FvYRglBTCRSTB8SPdbxR4GIaOpFleLDQXFk0TVyyZrGBhG5UScaYxpZdjUh7NBY5yfhJBM0C8LpKkdpeVOGKsp1EtnNVaf78kNDgq0JMKrzyi+cJFp62G67HyqA5RgYUvSaf+f8l1//FyB7YpzkWN6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hNMbrx24; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 485E51A17C4;
	Fri, 31 Oct 2025 17:28:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 206F360704;
	Fri, 31 Oct 2025 17:28:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6685E11818468;
	Fri, 31 Oct 2025 18:28:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761931708; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=mXik5j5I11be7gGeEVhCzfvaeTWInz7PcYTvkv28QF0=;
	b=hNMbrx24fu986J8m5f1/dnFgNLgPP2fiWJWkjZkyUgfgDAF7g1MBpAjsjzFp3+r43dZiQb
	FaUqXKKkGcO7EcFKlORnUtq/ezPZfNS+gPEiWATs1WLqyIRepEtBhAJWBlUpfN+IO19ZLP
	FjC3SeNvxJfaiT8TVReVsGcdFRlErz53p1uckIHnF47XO/utmjUihp4LhmH73wtJj82tuO
	Q1zzXLRixFIp/yOlUOA16mHQeoMqMVWZT8bmINveTGX9W/9Vbxx8uFy747VD5+fiBlO6gG
	9jV6+SOVxonAzMq5GjOgMxFv++cArYbstP9kLu0JqElIzD26/YTMmC4T+piNZA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 31 Oct 2025 18:26:58 +0100
Subject: [PATCH 14/28] mtd: spinand: winbond: Convert W35N specific
 operation to SPINAND_OP()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-winbond-v6-17-rc1-oddr-v1-14-be42de23ebf1@bootlin.com>
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

Winbond W35N* chips require a vendor specific operation to write their
VCR register (a configuration register, typically used for tuning the
number of dummy cycles and switching to a different bus
interface). Instead of defining this op only in the function that needs
it, hiding it from the core, make it a proper define like all other
spi-mem operations, and implement the necessary spinand_fill_*_op()
helper to make the SPINAND_OP() macro work. This way we can use it from
any function without any extra handling outside of this helper when we
will convert the core to support octal DDR busses.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/winbond.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index dde59f8f63f511a298a43a5b43fe07c1d726f179..3003ad7e83ee8f553ec82a0326422916c0ed794c 100644
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
2.51.0


