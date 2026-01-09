Return-Path: <linux-spi+bounces-12259-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD1BD0BA38
	for <lists+linux-spi@lfdr.de>; Fri, 09 Jan 2026 18:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 705E130213EB
	for <lists+linux-spi@lfdr.de>; Fri,  9 Jan 2026 17:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44F936B066;
	Fri,  9 Jan 2026 17:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tbS1LKI/"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8B33659F9
	for <linux-spi@vger.kernel.org>; Fri,  9 Jan 2026 17:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979124; cv=none; b=tecIdMGaegWBgpyx7yiJcUgCXtrtxF0C0aPVF5yOcgV+EZxBlq6H3tBikVYGiYJw09WZRBGEUDRb3h/bCf+bpDwTw+DDbgG/DlovB2C06PyRahy3eFmIBOVLTew/mst2PYVxBo7MiNpGhv0doBweNUEYPVQs+NwFnBDbhYVMcQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979124; c=relaxed/simple;
	bh=Ox0L1v3HiExI92/LUH/7t9BvWEIu09FtfkVzm2QMYtE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HEPfaXKLAp7/LN135JFAC2efpHIMYMhU+VGtMVhkSoBcu5VTFZ1Sii3T2vhv4TQQNKv77W6V8SRWM3bE0lX3pK3bzdBU9qplPrA0pcBBeGFzhhvUrw3THSmF3KEWu9RpUVIhuSz5uzdrQ7gQtgW9fGeHPFCKa1SPGpFbwGmk7b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tbS1LKI/; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D4CA41A2754;
	Fri,  9 Jan 2026 17:18:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A63B7606C6;
	Fri,  9 Jan 2026 17:18:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BE8B1103C89B9;
	Fri,  9 Jan 2026 18:18:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767979118; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ms4xzKXIpxyRYeFBoWeTIh6rA/J+YRqZaN/VfApNv70=;
	b=tbS1LKI/eb73Y9y03PSO8xpC3djkLri3PDl7xXIvP1Zx3T/6F966i52Zcsn2Dp759d+kcq
	rZySUp63Lg6ISx9Hc6Bba4pcTKmZtMRMNbB4QbD1UkiAXxMrTU0/Ba6aJxC7EohTN53XZo
	mrHBXUOKVKH0SkgYLjmbKePb+Tl6XQ4w1okHaaa2bExxLdxgptZj1gWen+wxFzIOaBkNVD
	xC7eZlEd/rcFdO0aDxyHdNINZd5b4nfrhkDPCt/DZWazHhLPVXStilcnMXjubY7CHQXMCI
	LQ1ckWE/F0UqRqpYNhP11KVV6U/OOcw29Tozmq5wEAUm1bWXVYNXWDZIcXa+7w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 09 Jan 2026 18:18:15 +0100
Subject: [PATCH v2 17/27] mtd: spinand: winbond: Register W35N vendor
 specific operation
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-winbond-v6-17-rc1-oddr-v2-17-1fff6a2ddb80@bootlin.com>
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

Provide the Winbond W35N specific "write VCR register" operation to let
the core verify it is supported by the controller before using it.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/winbond.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 36053f35ee5e..1c13dba08369 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -93,6 +93,9 @@ static SPINAND_OP_VARIANTS(update_cache_variants,
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_DATA_OUT(1, buf, 1))
 
+static SPINAND_OP_VARIANTS(winbond_w35_ops,
+		SPINAND_WINBOND_WRITE_VCR_1S_1S_1S(0, NULL));
+
 static struct spi_mem_op
 spinand_fill_winbond_write_vcr_op(struct spinand_device *spinand, u8 reg, void *valptr)
 {
@@ -469,6 +472,7 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &write_cache_octal_variants,
 					      &update_cache_octal_variants),
 		     0,
+		     SPINAND_INFO_VENDOR_OPS(&winbond_w35_ops),
 		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL),
 		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg)),
 	SPINAND_INFO("W35N02JW", /* 1.8V */
@@ -479,6 +483,7 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &write_cache_octal_variants,
 					      &update_cache_octal_variants),
 		     0,
+		     SPINAND_INFO_VENDOR_OPS(&winbond_w35_ops),
 		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL),
 		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg)),
 	SPINAND_INFO("W35N04JW", /* 1.8V */
@@ -489,6 +494,7 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &write_cache_octal_variants,
 					      &update_cache_octal_variants),
 		     0,
+		     SPINAND_INFO_VENDOR_OPS(&winbond_w35_ops),
 		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL),
 		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg)),
 	/* 2G-bit densities */

-- 
2.51.1


