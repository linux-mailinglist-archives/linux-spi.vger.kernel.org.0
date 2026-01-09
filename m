Return-Path: <linux-spi+bounces-12247-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAEAD0B9B7
	for <lists+linux-spi@lfdr.de>; Fri, 09 Jan 2026 18:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02EEB30208DC
	for <lists+linux-spi@lfdr.de>; Fri,  9 Jan 2026 17:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF4836656E;
	Fri,  9 Jan 2026 17:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wVJ+MX0p"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380EA368261
	for <linux-spi@vger.kernel.org>; Fri,  9 Jan 2026 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979111; cv=none; b=dGkPTv4a01ubw7PAt44aiax2bmSqzxy83IMt55wB60s0S5y7m9EuDqOQmm4ELBfVG4S7q+20xeA7DGoWO+FAKHXvhz8woHn8SCviVnDJjljeaqLj8k+Ea7+tNZQESiZX4uc0rVNtXz5UaYTRe1g/ij9SrnkuhcsxpLln/8QVLBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979111; c=relaxed/simple;
	bh=IJQIQ1qPwnyGsodqhdDYlPN0s9/YWzU7C+O/2+1S0xM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LcGjdM3oEoMHeCczpU7U8onqLH4UvmYl8hQOo8Urtw+ct+idFuCz7sGsEPc6U3GA/Y3ETWttnDdnWr/6dNK2WO5KqhszXiNyP5Jcvd8baPRv6P2CBxZx9Q+tXqBDZFSpt460vmmK3bKv4CqBfKoupYLzkwyR9kp5mslEl61Zfek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wVJ+MX0p; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8D3934E42029;
	Fri,  9 Jan 2026 17:18:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 64C0A606C6;
	Fri,  9 Jan 2026 17:18:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B60D9103C89AD;
	Fri,  9 Jan 2026 18:18:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767979104; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=v22HJHx8//qB5/a5Mqzhu2mFFylXUtBtPnkP97yMpsw=;
	b=wVJ+MX0pEoXe/7NLlNWUtxxBoI/lzU9mojd2jzQG93nDEXa3RsmSGhB2bptt7G/SnTRLBZ
	4fVO/5/czzugN6vkX+kUET3HUqmF7ItOAUTQCFXdFN23Fvu+caG/fpIpu9+D7N1tKjLayU
	aygZjlNhJmmDNDdS0lfgK/tGMdWbBrUBmZJr2ecHtKLAOGYkY6BcZZFvbiRrLsfFBFHn46
	Nk1ZS8cYeFI8tW4tkX6/4m7X0O4FV3mdBenwQeSlCBOKAjNkbzAZA1KuWVAOhaCuh2E3TC
	v+4o/eg0J7/n3tVsTOWbLFUwp4Ec+6vRljUCyKTi43fewgVX+rLrkF8QsmWjKQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 09 Jan 2026 18:18:03 +0100
Subject: [PATCH v2 05/27] mtd: spinand: Add missing check
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-winbond-v6-17-rc1-oddr-v2-5-1fff6a2ddb80@bootlin.com>
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

The update cache variant is mandatory, both read and write versions are
being checked, but not this one. All chip drivers seem to implement this
variant, so there should be no breakage.

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
The core has been like that since the begining, I do not think this
patch should be backported, hence no Fixes tag. This barely
qualifies as a fix anyway.
---
 drivers/mtd/nand/spi/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 62447801abb1..8acea0372f21 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1432,6 +1432,9 @@ int spinand_match_and_init(struct spinand_device *spinand,
 
 		op = spinand_select_op_variant(spinand,
 					       info->op_variants.update_cache);
+		if (!op)
+			return -ENOTSUPP;
+
 		spinand->op_templates.update_cache = op;
 
 		return 0;

-- 
2.51.1


