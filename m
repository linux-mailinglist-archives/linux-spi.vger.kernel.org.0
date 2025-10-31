Return-Path: <linux-spi+bounces-10965-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF32C26608
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 18:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 72F49352145
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 17:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F263357A54;
	Fri, 31 Oct 2025 17:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Vncpdjk7"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F08309EED
	for <linux-spi@vger.kernel.org>; Fri, 31 Oct 2025 17:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931731; cv=none; b=e2Z/hZcVo9YDtMgcCoTC0ERZ/0L6X1J52csKf93VQ51fRuM0xUzeJNNMic+Er5YqPQ+RBVm9V9knBYol7Wu9gZjkmsT60CEE1gfgCQm3NT+5q//aeQ8Na+wIiXzM+0lX/DP5FG8XQlQrfrKeiQPcJ5gH091HtDPA7gNYnVbVPjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931731; c=relaxed/simple;
	bh=e9FC+3UzvkjqWZ+ix07WU+iFe6vTYQmUx/syuc42dF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sU592GACep6BiE/3/1BDIEoYci/qaDqUhSj8Op/uCNEnHHxbnPaalxXe1srILGBA1riu4uj7gw7m7UWNW1QxwPND0+ila4yL3Iv7mFjB3yAX45/9IRHm5miwMkm+XT5Ye6uwYFsdLHIBQ6VGfo1hWzD1klvtobh9Wm1yzR/NpH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Vncpdjk7; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id AD4061A17C5;
	Fri, 31 Oct 2025 17:28:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7F16360704;
	Fri, 31 Oct 2025 17:28:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0D1F011818007;
	Fri, 31 Oct 2025 18:28:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761931726; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Yqsm5byi+NRPnRhNkd8UBM/Bmv6Ofu8I+HrZRoBLCI0=;
	b=Vncpdjk72ik/OAK7vIr+QdHzNB7KIZeweosE6fE9DJRk/oLB1X2XDCYOzOdCCSK7hpuIJS
	6pbUX//afKCvZVnkDCtmN480fbGITJFS/X2fVGGEDckMaE+2dntQvo+l9D3s74DEZf7AzJ
	KCm76pLqqO3+GxlXoCczI+Sf1Qp4sKr75ZGhRqGgSw5A5aXNHanWDRuxmbJgTjeBEG4PZb
	3pVYOMO95HZOL2m+R+dAgC8w/0EkYOpZnRlQ+qN64e2R/OgqmN7xwAc22vQ48pKZm8EYke
	1LePAD795uNNNyBM64E7koiaGE23wn5NwasJkrKAqBJKA0V9vW1QPU9f90vg/g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 31 Oct 2025 18:27:12 +0100
Subject: [PATCH 28/28] mtd: spinand: winbond: W35N octal DTR support
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-winbond-v6-17-rc1-oddr-v1-28-be42de23ebf1@bootlin.com>
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
index 90e4ece00cf5e727df87cb2367d9f85a2a6759bb..8430ae307be0fefded8e27109403a59b9b17b089 100644
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
2.51.0


