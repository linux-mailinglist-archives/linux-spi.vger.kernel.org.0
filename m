Return-Path: <linux-spi+bounces-10955-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 142FCC26620
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 18:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E011B4FA4B3
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 17:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7D8306484;
	Fri, 31 Oct 2025 17:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UEe5WHxT"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A796B34EEEF
	for <linux-spi@vger.kernel.org>; Fri, 31 Oct 2025 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931717; cv=none; b=lQxrvCz5JmVzB/CEk040jG5tpB+l2S1sf1VmYHkzaTpAGWE9K1s8qzXm36SHQdZqJl6jPvgTGk0G3kTfKUM1nawnY7XxFjEm1QrgcBR313isYAukTr5rc4rEmjnS+jIik2Hg72HPbSk/fBJXF7D2bHKGysoJy5b+ebLvdT0rDAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931717; c=relaxed/simple;
	bh=BcT58DCMpYImSfCLXscwx0J/YNnF0Oe9IqpvZNcgQ78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=COIwpSOLeaGhq9j/Jk4SYwz4GQVrbFjP0qCOPgspkj1Iyqi4fyL1ZFvPeJQCQAudcVAtq9d6wImh+Z8g2XqHFs7+qBqmWEFsNKcnTBkji325XM05xAqk0ylvVAq6g4WYtCXcFHx0hZdRgSPK1hbOWkN0rkd2ilnKxhKnNIfgGZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UEe5WHxT; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E42D7C0E95B;
	Fri, 31 Oct 2025 17:28:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7461360704;
	Fri, 31 Oct 2025 17:28:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A938211818466;
	Fri, 31 Oct 2025 18:28:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761931713; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qLn8pqGpyg4U7OLjWyRrfWQycUAFq+5725pA6nA01gM=;
	b=UEe5WHxTMWNUU4sVtZJCYJu6Mgx3Z7Fcdlhkt0JsnLfHxQPyeTuP7KXuMD5arq8/mWdo95
	4/QFu7UYGaPOYcbWh5NYEIOtRY9N76+ZDZw2YIwior6GT6Td4xU4YIhA14Fo5v6Cb73BTT
	yWms+2/LBhlpVdl8SDCxgYsiRBC3h9QyJh/gYc0xxngoqMw61s3tAMYXxEMrGPl8MwssBT
	J9uX6M4FZNnA7F7+ndzl2Yk2K7+YlAXa13JnA9JC+sOpoA+vFUHDMEay7yME4roDBsaZy1
	y52H258HZf+jgJxxEFxstc4pNJ6L+PUQOQkHH94HQaH1HFNwFsF6rzimSfzcEg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 31 Oct 2025 18:27:02 +0100
Subject: [PATCH 18/28] mtd: spinand: winbond: Register W35N vendor specific
 operation
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-winbond-v6-17-rc1-oddr-v1-18-be42de23ebf1@bootlin.com>
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

Provide the Winbond W35N specific "write VCR register" operation to let
the core verify it is supported by the controller before using it.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/winbond.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 36053f35ee5e84eb355343443a28d274cf7ea5c3..1c13dba08369c48ca26381c634abcea4e7360f30 100644
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
2.51.0


