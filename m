Return-Path: <linux-spi+bounces-12251-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9E3D0B9C3
	for <lists+linux-spi@lfdr.de>; Fri, 09 Jan 2026 18:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42F9D30AAB4F
	for <lists+linux-spi@lfdr.de>; Fri,  9 Jan 2026 17:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158A8369969;
	Fri,  9 Jan 2026 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AtRg/7QQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEE1369225;
	Fri,  9 Jan 2026 17:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979115; cv=none; b=T7pkdlZCxLI8ED8QXa6eQmQ+EiY0cGGe5D91JuXNI6XtKDGQXFNsutcI5V1VeWzTVi3sCvK1wKLtjLbYhcr56XWDdNBtatl3vvzmo6FrMnhVvA0127gbsyCck/uP98l4Mg6ZfOU8qYBCi5d/JZOOEzWPCv6oCI+5bxmkCYNHicE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979115; c=relaxed/simple;
	bh=bLXQwY2X+HWDmSjIH+88jisc8V0Mv2LIfYmZ6hOFc4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kzvD691sB/ngOgRphVK1Af7SYh700x9bK3EtOKo+kOutfNnk8U6SpTu9R/YVPTtHPJ2wK4qo0sJln9uhAyg4PGWtDPgl14qZELZzQEnIfwY96Fr//b+PANBuJX0oMAUfFZc0dy+DTyxK4hNBob933Ql4F9eH9cLJKbASI3m4YTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AtRg/7QQ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BE0A81A2751;
	Fri,  9 Jan 2026 17:18:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 90AD6606C6;
	Fri,  9 Jan 2026 17:18:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 057F3103C89AF;
	Fri,  9 Jan 2026 18:18:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767979106; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3fZHdLVT5PZs+GglC5vvX4FQ5Jnb/RN7FPEdbUSBxJw=;
	b=AtRg/7QQnelwa/V+wRQj9SopmraxNZaszEiPYvTqD0ygrJbZIRiwAKsy0r1oAlVclVD/Zd
	JR/rvSvqZqs1z0V6bRAmcaRmtxK5HTTkVerx0k2RPzZiJS2CcGgKfvs0qVgjZTWXPdZIRx
	3yNs5R9mxhK0yPr8iN4Tz7bq35nlGDA4mJUavhfaA3DukYRK87SU2m1wHa2cvMyVPMNzzU
	EMF9N2u9r3kgO+oShf1AVdrxa+jb8t9ChmCaAJwVybEg65DoOnpVARVjNcxRfVLXLV83R8
	xUH95GqE3dkTDkcHDy2opfdu6BB+jxeIJzyAvVY/D0IiA1tvEfDGEttU3ohOJw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 09 Jan 2026 18:18:05 +0100
Subject: [PATCH v2 07/27] mtd: spinand: Use standard return values
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-winbond-v6-17-rc1-oddr-v2-7-1fff6a2ddb80@bootlin.com>
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

Replace -ENOTSUPP with -EOPNOTSUPP which is as relevant in this case but
is standard.

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 8acea0372f21..3abc56e4d23f 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1419,28 +1419,28 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		op = spinand_select_op_variant(spinand,
 					       info->op_variants.read_cache);
 		if (!op)
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 
 		spinand->op_templates.read_cache = op;
 
 		op = spinand_select_op_variant(spinand,
 					       info->op_variants.write_cache);
 		if (!op)
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 
 		spinand->op_templates.write_cache = op;
 
 		op = spinand_select_op_variant(spinand,
 					       info->op_variants.update_cache);
 		if (!op)
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 
 		spinand->op_templates.update_cache = op;
 
 		return 0;
 	}
 
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static int spinand_detect(struct spinand_device *spinand)

-- 
2.51.1


