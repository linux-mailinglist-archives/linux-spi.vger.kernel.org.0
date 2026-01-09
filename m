Return-Path: <linux-spi+bounces-12257-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 744E3D0BA29
	for <lists+linux-spi@lfdr.de>; Fri, 09 Jan 2026 18:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14CDF31047AA
	for <lists+linux-spi@lfdr.de>; Fri,  9 Jan 2026 17:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9896366DCB;
	Fri,  9 Jan 2026 17:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uiD8NIYz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB1336A03C
	for <linux-spi@vger.kernel.org>; Fri,  9 Jan 2026 17:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979122; cv=none; b=r45T05hqafhnKifJ7WvG7hhlZPocUzQDNmC0oqUCJhKpHJvFh+86HkxPSSal6YgjlO5t4gdQPqwo/pIRIHakg78ARmIQaFcy3gOBd+sw6isuxkdcqKnaKKC3UPAZkcgwxz32afBlqLKFm3VsbV7N32XpUBglgCjsrHIaylhhGZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979122; c=relaxed/simple;
	bh=e6AA+GM1Ciksp1i22yflYcy1vdvWSgpRsIlKD+ggmmI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mkN07uzsRA+PuzfKnMpVX1T7CV2Uo7bo+6WviUBKeNOrVP6lPzySi8Oyq8bnM4ZbJgSQDXgkTji67pV0gIsrUF28HhRl8csVDltnCmce58z5B1iNfbDHfua7rTa7zGMd+2KqFdFL7jA8QNonErIW64sA+QZpj68TuX6qKEMMPgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uiD8NIYz; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 501971A2753;
	Fri,  9 Jan 2026 17:18:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 25432606C6;
	Fri,  9 Jan 2026 17:18:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9609C103C89B8;
	Fri,  9 Jan 2026 18:18:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767979117; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lnokEMFB4NwttnDPKwrpdjjcxdmg3b5O6SJBXL7NJ0s=;
	b=uiD8NIYzaeFDctQYhOWJnQb5qr6Y7NUQoL60Npic3ffuF6iUrJ3fJAWmWTJxoIYp72dheG
	gr+7OgafM9T50STuFGgMKNcnYcMG7NW5QX7OUhkTH+zdXBRgf+0hf/EdJ5Yu8KXweaeKkW
	fNqcq0oJYRQscOgAUbsijhM+p/CtDT213TxCkA1KMr+IStc+VTQb0a9Rq7cskzIBNqS0T2
	zyxh9F6v4CwxRH5qCJGY9ZlsebSk77ZW83+MdBWghv1YVo9LBtqrVq3usPa+IoJtHUl3ma
	qsX6f105OSUxJgjP9lsjnGzfuUhMtD6A5xOEizlVL/xYFT14aEzbeQwbfC0XRA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 09 Jan 2026 18:18:14 +0100
Subject: [PATCH v2 16/27] mtd: spinand: winbond: Register W25N vendor
 specific operation
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-winbond-v6-17-rc1-oddr-v2-16-1fff6a2ddb80@bootlin.com>
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

Provide the Winbond W25N specific "select target" operation to let the
core verify it is supported by the controller before using it.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/winbond.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 3003ad7e83ee..36053f35ee5e 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -105,6 +105,9 @@ spinand_fill_winbond_write_vcr_op(struct spinand_device *spinand, u8 reg, void *
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_DATA_OUT(1, buf, 1))
 
+static SPINAND_OP_VARIANTS(winbond_w25_ops,
+		SPINAND_WINBOND_SELECT_TARGET_1S_0_1S(NULL));
+
 static struct spi_mem_op
 spinand_fill_winbond_select_target_op(struct spinand_device *spinand, void *valptr)
 {
@@ -497,6 +500,7 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
+		     SPINAND_INFO_VENDOR_OPS(&winbond_w25_ops),
 		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL),
 		     SPINAND_SELECT_TARGET(w25m02gv_select_target)),
 	SPINAND_INFO("W25N02JW", /* high-speed 1.8V */

-- 
2.51.1


