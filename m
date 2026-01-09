Return-Path: <linux-spi+bounces-12263-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7695FD0BA2A
	for <lists+linux-spi@lfdr.de>; Fri, 09 Jan 2026 18:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01E473077473
	for <lists+linux-spi@lfdr.de>; Fri,  9 Jan 2026 17:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1F036B07B;
	Fri,  9 Jan 2026 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2GWdC6RF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B85366DAC;
	Fri,  9 Jan 2026 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979127; cv=none; b=ovpmqVgXqaeOj/k5P+waahdHXOrvz5BH+dGEEpamPLRtD/Es7nmdBQp/Z481w7vFg/WRZo6/S++hyI3V9zpLonsEOwBZQbEI19damXCGuLo5fmLD7avBH0GXNt/n6Twhn1gzv/PhYyE/+ofi/bwNZqxQBXzoZQ1KZqBdP1GBVAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979127; c=relaxed/simple;
	bh=ZBa9WI9sNZf/R3HFBY0G831aCKS+wM03PWRWgU0Aikk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pfBYQVLJR1Ik0vhWevdvDitGjEtRW/xVbgIHq3BoMFEau1wI9EpUzZfjSS0FLSE8BQEBfoitJX6BopIqsy8fKUWOI2Q5fzFB3AwPx54d30BZ45T68TrcpVt2SdC+JwONmUTy+DzpLFFHimAbMQJ+gZymENZbqiWmrnuDVgJqHZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2GWdC6RF; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B0FE84E4202B;
	Fri,  9 Jan 2026 17:18:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 89E25606C6;
	Fri,  9 Jan 2026 17:18:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D1BBA103C89BD;
	Fri,  9 Jan 2026 18:18:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767979123; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=71VfqlwpnO88b/BySfbu5HhBv3rjVPZdc4UiUGls3+g=;
	b=2GWdC6RFF/oN61uiGb0U2Bfk6QtlTupk4CCJ0UftEV2hk0MCSwA5glgEp3PMl2sI6bZVai
	cFI8myiIMfCBF7H4m8iJKjTEz4zmN7Se4ua7TEr4wsGgN/pUIFmQxrONiS4U7WVk8Wbfjw
	nI3WgT2zIjTkpGfQ/id93LVlU8/4ywafoyphM20J7wYcARplx+fMsOOCM5vF/EwySwAwqK
	x4Nj4vIdOCf/QVJ8POdb5FGYGXKC1GjR7qxlXFI5U94zmx1nfYRgywARbIXYEvXHX3E84w
	QPBWJPGZrbNmvv+5vCXb6C+77YSToZOC2XCCwSGt3QUUc7HvSUo0wBG7kpkW4Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 09 Jan 2026 18:18:19 +0100
Subject: [PATCH v2 21/27] mtd: spinand: Gather all the bus interface steps
 in one single function
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-winbond-v6-17-rc1-oddr-v2-21-1fff6a2ddb80@bootlin.com>
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

Writing the quad enable bit in one helper and doing the chip
configuration in another does not make much sense from a bus interface
setup point of view.

Instead, let's create a broader helper which is going to be in charge of
all the bus configuration steps at once. This will specifically allow to
transition to octal DDR mode, and even fallback to quad (if suppoorted)
or single mode otherwise.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/core.c | 62 +++++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 88d87a96ddb0..54a32cea3755 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -261,18 +261,9 @@ static int spinand_init_cfg_cache(struct spinand_device *spinand)
 	return 0;
 }
 
-static int spinand_init_quad_enable(struct spinand_device *spinand)
+static int spinand_init_quad_enable(struct spinand_device *spinand,
+				    bool enable)
 {
-	bool enable = false;
-
-	if (!(spinand->flags & SPINAND_HAS_QE_BIT))
-		return 0;
-
-	if (spinand->op_templates->read_cache->data.buswidth == 4 ||
-	    spinand->op_templates->write_cache->data.buswidth == 4 ||
-	    spinand->op_templates->update_cache->data.buswidth == 4)
-		enable = true;
-
 	return spinand_upd_cfg(spinand, CFG_QUAD_ENABLE,
 			       enable ? CFG_QUAD_ENABLE : 0);
 }
@@ -1391,12 +1382,6 @@ static int spinand_manufacturer_init(struct spinand_device *spinand)
 			return ret;
 	}
 
-	if (spinand->configure_chip) {
-		ret = spinand->configure_chip(spinand);
-		if (ret)
-			return ret;
-	}
-
 	return 0;
 }
 
@@ -1602,6 +1587,31 @@ static int spinand_detect(struct spinand_device *spinand)
 	return 0;
 }
 
+static int spinand_configure_chip(struct spinand_device *spinand)
+{
+	bool quad_enable = false;
+	int ret;
+
+	if (spinand->flags & SPINAND_HAS_QE_BIT) {
+		if (spinand->ssdr_op_templates.read_cache->data.buswidth == 4 ||
+		    spinand->ssdr_op_templates.write_cache->data.buswidth == 4 ||
+		    spinand->ssdr_op_templates.update_cache->data.buswidth == 4)
+			quad_enable = true;
+	}
+
+	ret = spinand_init_quad_enable(spinand, quad_enable);
+	if (ret)
+		return ret;
+
+	if (spinand->configure_chip) {
+		ret = spinand->configure_chip(spinand);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
 static int spinand_init_flash(struct spinand_device *spinand)
 {
 	struct device *dev = &spinand->spimem->spi->dev;
@@ -1612,10 +1622,6 @@ static int spinand_init_flash(struct spinand_device *spinand)
 	if (ret)
 		return ret;
 
-	ret = spinand_init_quad_enable(spinand);
-	if (ret)
-		return ret;
-
 	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
 	if (ret)
 		return ret;
@@ -1628,19 +1634,25 @@ static int spinand_init_flash(struct spinand_device *spinand)
 		return ret;
 	}
 
+	ret = spinand_configure_chip(spinand);
+	if (ret)
+		goto manuf_cleanup;
+
 	/* After power up, all blocks are locked, so unlock them here. */
 	for (i = 0; i < nand->memorg.ntargets; i++) {
 		ret = spinand_select_target(spinand, i);
 		if (ret)
-			break;
+			goto manuf_cleanup;
 
 		ret = spinand_lock_block(spinand, BL_ALL_UNLOCKED);
 		if (ret)
-			break;
+			goto manuf_cleanup;
 	}
 
-	if (ret)
-		spinand_manufacturer_cleanup(spinand);
+	return 0;
+
+manuf_cleanup:
+	spinand_manufacturer_cleanup(spinand);
 
 	return ret;
 }

-- 
2.51.1


