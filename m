Return-Path: <linux-spi+bounces-12268-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B08D0B9B4
	for <lists+linux-spi@lfdr.de>; Fri, 09 Jan 2026 18:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 010953032033
	for <lists+linux-spi@lfdr.de>; Fri,  9 Jan 2026 17:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B9836CDE8;
	Fri,  9 Jan 2026 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rQD3nUtq"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A1936C5A0
	for <linux-spi@vger.kernel.org>; Fri,  9 Jan 2026 17:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979137; cv=none; b=O19FqCaGIt7wYGMhGyabBRTNNSAF8pFRxOlfdJsuk5TQ1X41cfj7Qy6QyxisdsFsqSRKj+5HvV2UGzwDJLQ/whDapMn92mXrvbFmoWYDTN6UAZBz4eVgpxX2AT5AlXGnByHfJ7fRWW3d47raOl/edq7WcLs48ZpmpJzDB3IfqV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979137; c=relaxed/simple;
	bh=n49egCOuT3hbLr1wY7eK3B3fGNpwZaWGiuFQnEjbip0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sh0M5gFRycUzAfZ5NVP/wnp513wemwqLTXBp34EuFR8VZpOXwdS8TRG3YGWtMxQRpzK6E0T+Np+xl/6dsxZh6Ws1BEVIojPG4xxfHk1oLghhy6ie/NKbDupdkkQAfnmzw19eXbDNQQ3L86Z6dPbBz74sNp0Z4voAlSfDy7r74xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rQD3nUtq; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3EE44C1F6E5;
	Fri,  9 Jan 2026 17:18:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 86F2D606C6;
	Fri,  9 Jan 2026 17:18:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0243E103C89AF;
	Fri,  9 Jan 2026 18:18:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767979133; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kJNVCsG0Zk4FcaaKTxivXNZ2w3c05JJL982sKu8nc/Q=;
	b=rQD3nUtqDi5mqI219hNgWsJGehQ/YnDBPT4nqtf3sjsYvHpfnL4ckFLMRl7ESjMCt5o8c0
	Sffi46oeBEiipnqbzluHSFatlIPyHnQdmxa2IzXasoZhSrhAxQlPKoip2amKIkyOsf9Le0
	IJX4aBxDn4Pi45AwKwEo76b3WUOkBGYRBo9MEywZZla0kU8KWWBgArO1YhMHE+TqkAsP8t
	MXApixlMKDYrfNqhCFrmACPxZkaQcG3NJ4eWbcunpyVRKD1xag1mvauTiGiRR1hqVNFKT/
	rptiMvvol+eYNOn8xiavkoSw7ScJOJS7H6HyeyPN8sVFOwlQ6AGWwbH9b61wVw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 09 Jan 2026 18:18:25 +0100
Subject: [PATCH v2 27/27] mtd: spinand: winbond: W35N octal DTR support
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-winbond-v6-17-rc1-oddr-v2-27-1fff6a2ddb80@bootlin.com>
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

Extend the support for the W35N chip family by supporting the ODTR bus
interface. The chip is capable to run in this mode, which brings a
significant performance improvement.

1S-8S-8S:

   # flash_speed /dev/mtd0 -c1 -d
   eraseblock write speed is 7529 KiB/s
   eraseblock read speed is 15058 KiB/s

8D-8D-8D:

   # flash_speed /dev/mtd0 -c1 -d
   eraseblock write speed is 9481 KiB/s
   eraseblock read speed is 23272 KiB/s

This is +55% read speed and +26% write speed with the same hardware.

Tests have been conducted with a TI AM62A7 using the Cadence quad SPI
controller.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/winbond.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 90e4ece00cf5..8430ae307be0 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -36,6 +36,8 @@
  */
 
 static SPINAND_OP_VARIANTS(read_cache_octal_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_8D_8D_8D_OP(0, 24, NULL, 0, 120 * HZ_PER_MHZ),
+		SPINAND_PAGE_READ_FROM_CACHE_8D_8D_8D_OP(0, 16, NULL, 0, 86 * HZ_PER_MHZ),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1D_8D_OP(0, 3, NULL, 0, 120 * HZ_PER_MHZ),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1D_8D_OP(0, 2, NULL, 0, 105 * HZ_PER_MHZ),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_8S_8S_OP(0, 20, NULL, 0, 0),
@@ -48,11 +50,13 @@ static SPINAND_OP_VARIANTS(read_cache_octal_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_octal_variants,
+		SPINAND_PROG_LOAD_8D_8D_8D_OP(true, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_8S_8S_OP(true, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_8S_OP(0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
 
 static SPINAND_OP_VARIANTS(update_cache_octal_variants,
+		SPINAND_PROG_LOAD_8D_8D_8D_OP(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_8S_8S_OP(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
@@ -93,13 +97,22 @@ static SPINAND_OP_VARIANTS(update_cache_variants,
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_DATA_OUT(1, buf, 1))
 
+#define SPINAND_WINBOND_WRITE_VCR_8D_8D_8D(reg, buf)			\
+	SPI_MEM_OP(SPI_MEM_DTR_OP_RPT_CMD(0x81, 8),			\
+		   SPI_MEM_DTR_OP_ADDR(4, reg, 8),			\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_DTR_OP_DATA_OUT(2, buf, 8))
+
 static SPINAND_OP_VARIANTS(winbond_w35_ops,
-		SPINAND_WINBOND_WRITE_VCR_1S_1S_1S(0, NULL));
+		SPINAND_WINBOND_WRITE_VCR_1S_1S_1S(0, NULL),
+		SPINAND_WINBOND_WRITE_VCR_8D_8D_8D(0, NULL));
 
 static struct spi_mem_op
 spinand_fill_winbond_write_vcr_op(struct spinand_device *spinand, u8 reg, void *valptr)
 {
-	return (struct spi_mem_op)SPINAND_WINBOND_WRITE_VCR_1S_1S_1S(reg, valptr);
+	return (spinand->bus_iface == SSDR) ?
+		(struct spi_mem_op)SPINAND_WINBOND_WRITE_VCR_1S_1S_1S(reg, valptr) :
+		(struct spi_mem_op)SPINAND_WINBOND_WRITE_VCR_8D_8D_8D(reg, valptr);
 }
 
 #define SPINAND_WINBOND_SELECT_TARGET_1S_0_1S(buf)			\
@@ -390,6 +403,9 @@ static int w35n0xjw_vcr_cfg(struct spinand_device *spinand,
 	case SSDR:
 		ref_op = spinand->ssdr_op_templates.read_cache;
 		break;
+	case ODTR:
+		ref_op = spinand->odtr_op_templates.read_cache;
+		break;
 	default:
 		return -EOPNOTSUPP;
 	};

-- 
2.51.1


