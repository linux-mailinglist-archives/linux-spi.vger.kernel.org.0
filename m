Return-Path: <linux-spi+bounces-12248-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9A6D0BA98
	for <lists+linux-spi@lfdr.de>; Fri, 09 Jan 2026 18:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CEFC30E5E9F
	for <lists+linux-spi@lfdr.de>; Fri,  9 Jan 2026 17:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A2736656B;
	Fri,  9 Jan 2026 17:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l4DhprWE"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49D330149F;
	Fri,  9 Jan 2026 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979114; cv=none; b=FoAkV+SS5iH+TgtnZqSol72sVMoEfNQFeCE5uD1TcundnacNukkgTqHgi4G39wklzCOmryuPLYuA1PKRzmD+vEtjQwH4QIZEhfcuLssI8NFx/pnlx+Q/YQLGfqE4yg71kDoqUJh1/6hNLvQuRja1x94tlplkS7ps0yfAWnDcXjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979114; c=relaxed/simple;
	bh=t2/eAaKJ9Xy8Li8YXfUEutFre1NJlcHvaAFMV0Kgiuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fB0Dh0ROF46fxTlrSY7hVuhLjMC7Q6I8y1pnxeF0Fg0bM5lfQdPGWMlTKyN4D2NQ8XxT6PlV8Nh4vUebA1JlLrTH76y8GLaK1DDxPPFCnQMeHq1l0j8azdcyfQOaSppWF15/csX4XahQqVEY9QDcgbkNftJs6ITK+djaKG88HEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l4DhprWE; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 21635C1F6E4;
	Fri,  9 Jan 2026 17:18:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6A94F606C6;
	Fri,  9 Jan 2026 17:18:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E2028103C8956;
	Fri,  9 Jan 2026 18:18:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767979105; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Ba70zlYcbz8QlJI8mSBGaiXcm4X/itTgn1V4VCKgo+E=;
	b=l4DhprWEs5zbKkrQZO+XkLm+NE+5V/RcLPIos0dLXX01VbFKN3IP/Ou8JbsNWVZ6tb/Tzo
	VwUeIRl6DaaNK6kH+bR6imsyI2XRXfADra4GhO29uRY4Lc7hfA1CnmvuB/uRz8AEN+JjUw
	ErTL8HMqvUTi2fAs0c6G2jjIPFfU+yLDoqh8nSRbdIcHGnffpScPTVduslqBfVMdV3bJoo
	s+PkqQyLIowQ5fgqwL//6Ng6yfoWktMK0gmrI/HRYSZV9aFIddGtzXq2frc6yk1SrY1IXP
	pFfYpJE+/M9A6jAFeICx2qynl2KrXmZS01+Q81XpmMnrD9WJv0KxBheGxOkeTA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 09 Jan 2026 18:18:04 +0100
Subject: [PATCH v2 06/27] mtd: spinand: Remove stale definitions
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-winbond-v6-17-rc1-oddr-v2-6-1fff6a2ddb80@bootlin.com>
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

SPI NAND command values are directly included in the macros defining the
ops. These are stale definitions, they are unused so drop them.

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/linux/mtd/spinand.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 049d55c38d52..ad2773f1f963 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -232,12 +232,6 @@
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_DATA_OUT(len, buf, 8))
 
-/**
- * Standard SPI NAND flash commands
- */
-#define SPINAND_CMD_PROG_LOAD_X4		0x32
-#define SPINAND_CMD_PROG_LOAD_RDM_DATA_X4	0x34
-
 /* feature register */
 #define REG_BLOCK_LOCK		0xa0
 #define BL_ALL_UNLOCKED		0x00

-- 
2.51.1


