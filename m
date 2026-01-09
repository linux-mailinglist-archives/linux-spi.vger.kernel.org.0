Return-Path: <linux-spi+bounces-12267-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B4607D0B9AB
	for <lists+linux-spi@lfdr.de>; Fri, 09 Jan 2026 18:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8184E3024762
	for <lists+linux-spi@lfdr.de>; Fri,  9 Jan 2026 17:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177E536C5A5;
	Fri,  9 Jan 2026 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TJVhB286"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4434366DAC
	for <linux-spi@vger.kernel.org>; Fri,  9 Jan 2026 17:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979135; cv=none; b=rvHa4UsNYWtxPY3y6csAzufREaX2IvmUlx5wyiY4aF8gP+be7+bFAXW79+G9d04vY5V2zNU453rRVT/N9SgzD8Vj0LTfy2vHWtp2TjeA2SuNVolkff26XX7U7X+5B2WudpMjWZuLxQe0JHwUqg/GNbhtbgH1ShutCrUAHjoMOng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979135; c=relaxed/simple;
	bh=l+IfYgAQS0kJ8P7LR4L2Gamj+a9rNWbq9rDGHVCXRWE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zph7FkrsP624Q2v0bb7VVqUYDjTlbefDeyM7kri6z6HEoTNIppL2p/rRcBuX6TB/IZRCNTTVUwX86u9xRRSz9lXyEEAL2Uej0lWFHmvRTZqyKBzY37/XkF08KvrV6Uvswts3KrycwPZQCBAUfeGBSrDJyhH/+vGuB2pwsVXywS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TJVhB286; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 400CD4E4202D;
	Fri,  9 Jan 2026 17:18:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 14B18606C6;
	Fri,  9 Jan 2026 17:18:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6E6D3103C89AB;
	Fri,  9 Jan 2026 18:18:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767979131; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=G/7Ycy/ogVyXcqM2ko9UNgXCQm9s/CNPDNAu6YdiZO4=;
	b=TJVhB286dsU5B7RGpUhDq4AEeS/PK1NFAvtQ9Wz5RZOgu72Vv+LRGhbnota89w01ZSyEaZ
	qLV2iKK556/+pua0km2hQdchoS5gHuDaYwP8LDjKNVonlC3G9w9uEr8xYUA0kF/Jza6I3c
	6OQibYHC2/tNBocP5BTFDgQFStX3gDv5c7kJxNoOykFxK6vK+U+eqodaqSceD8wJ6HfCF2
	ndxlCIsTfErY8uG4vMHn0AtXdXTuZNNB/w8LSI4CVY/y6hGTeKYqTznDuF+jclbZJIF3EB
	CrwFzAhd6LToSCu8suRcKhk0t4VIXcMc74ugefFDTQi7XzK1cqZBp4ZA1XuuEQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 09 Jan 2026 18:18:23 +0100
Subject: [PATCH v2 25/27] mtd: spinand: Warn if using SSDR-only vendor
 commands in a non SSDR mode
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-winbond-v6-17-rc1-oddr-v2-25-1fff6a2ddb80@bootlin.com>
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

Both Macronix and Winbond have chip specific operations which are SSDR
only. Trying to use them in an ODTR setup will fail and doing this is a
pure software bug. Warn explicitly in this case.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/macronix.c | 2 ++
 drivers/mtd/nand/spi/winbond.c  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index 6b7cbcc6e287..84be5e0402b5 100644
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
index 419f4303a0dc..90e4ece00cf5 100644
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
2.51.1


