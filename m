Return-Path: <linux-spi+bounces-10963-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A58C2666B
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 18:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF8684FBA80
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 17:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38A9357734;
	Fri, 31 Oct 2025 17:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W+sBhqYb"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3773570C8
	for <linux-spi@vger.kernel.org>; Fri, 31 Oct 2025 17:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931728; cv=none; b=OKmb6m2plE5G/3EelaOyjh3u5JBfOQSvsfefWGJSmicuWF2H2Zv3vJIQ8Ur8GhTdPD75ouI02sRtTfztMXkQmCauPOkj9IAk+malTW1VjPZXoHsSuOgilJ87lpyIoO4M1TDZXFfCuSYMPt3Aa8xyfScZfhsUHHT5b3sVpJCmoCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931728; c=relaxed/simple;
	bh=KwYaq0JIinQENfCbfinalTGQzbu4fX03j+FHzo0IfXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gZWL1Ts69WCYGGDLt0/8N3sNcQt5b8XIUwIppevRWWE2COzdbe/NTnEJp+6NcRZiXABYFdXCts5U/qW28lFN7lF0U3DWUpR5kclRtHELUm6ZB14nzLNKXpqQpmfYygSnNc8Lz4lAUDhkPxXvnl+foRKewDIc70s9Ko7wvwRxviM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W+sBhqYb; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 555D54E41442;
	Fri, 31 Oct 2025 17:28:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2C41160704;
	Fri, 31 Oct 2025 17:28:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8471311818466;
	Fri, 31 Oct 2025 18:28:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761931724; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=r4QdbcFBCx7yyVZucPnXkIWsxV+Bp5ag9tk3sEn1mAA=;
	b=W+sBhqYbh0YnF2BOR9j6yWodY+F0iL6iTI1C89zODzGruf9oYX65k7aEjAwT6FyBp7qLfI
	laKGbTNXjRpOr8Re7HQbifnYuH7DuxZK37+BWqoLUab9vpIOpNqBKhpN1DMb9S+8lOX132
	IbEPn+FdZhD5W5kNykWUNlrCKjCscdS4DNmeJpAKZ7x2K9ioYXxSrAz32dhqb5L5vlZ7qY
	l9urCVerHBXFWMu5tUgMBwBW6dAPdLjSd9Gvgi5v92xgTmassmRLZBGzld4ZkG1DqvoaZs
	246LY/1+aQ3zB4n+Jn6t6N/7xbjUNV9DMZb2hDpdGn9pnc3XAottbEdN60D5Hg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 31 Oct 2025 18:27:10 +0100
Subject: [PATCH 26/28] mtd: spinand: Warn if using SSDR-only vendor
 commands in a non SSDR mode
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-winbond-v6-17-rc1-oddr-v1-26-be42de23ebf1@bootlin.com>
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

Both Macronix and Winbond have chip specific operations which are SSDR
only. Trying to use them in an ODTR setup will fail and doing this is a
pure software bug. Warn explicitly in this case.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/macronix.c | 2 ++
 drivers/mtd/nand/spi/winbond.c  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index 6b7cbcc6e2872d3369b8eb765dede05c7299c896..84be5e0402b5db8787178dc0a39901b938b0d2e1 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -53,6 +53,8 @@ static SPINAND_OP_VARIANTS(macronix_ops,
 static struct spi_mem_op
 spinand_fill_macronix_read_eccsr_op(struct spinand_device *spinand, void *valptr)
 {
+	WARN_ON_ONCE(spinand->bus_iface != SSDR);
+
 	return (struct spi_mem_op)SPINAND_MACRONIX_READ_ECCSR_1S_0_1S(valptr);
 }
 
diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 419f4303a0dc7518017e2bd422584813dca14d48..90e4ece00cf5e727df87cb2367d9f85a2a6759bb 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -114,6 +114,8 @@ static SPINAND_OP_VARIANTS(winbond_w25_ops,
 static struct spi_mem_op
 spinand_fill_winbond_select_target_op(struct spinand_device *spinand, void *valptr)
 {
+	WARN_ON_ONCE(spinand->bus_iface != SSDR);
+
 	return (struct spi_mem_op)SPINAND_WINBOND_SELECT_TARGET_1S_0_1S(valptr);
 }
 

-- 
2.51.0


