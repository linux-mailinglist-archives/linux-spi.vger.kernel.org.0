Return-Path: <linux-spi+bounces-10959-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834C1C2660E
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 18:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8922742749C
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 17:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CB23559E5;
	Fri, 31 Oct 2025 17:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hqNZ/wsU"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD123557E0
	for <linux-spi@vger.kernel.org>; Fri, 31 Oct 2025 17:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931723; cv=none; b=P7TUruhFe5nBSVsfVWxkWDo8Yui5LAmF3LVp2KaoqQn5AJe/J/L/6GdjIvNL8qjtcJi5Uo9zZOtUC9ZxI3kiqPEU9qAwGr7UkP37QxYisBa+XWHmirnriwoa/uIG2J3whOZUPdESIgoUYmRvDDNRm8VDpq85CrAwFkPM//xkRGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931723; c=relaxed/simple;
	bh=iX+n9HzY/YkNmOzBAg84DXwptwGF3y7LQxR8/FtomhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iimk1gKdPjXzqxXGxSr7PMX1+X6wXB+gOy1X4rQ3eMbKD/7/c0Mcc1KFVbNvCJm2SZurG3rTKXMzp6c9B+V5PqcdTI4lkeupIJBzJey4Zti0ca0ln8GLPTvGMruDgerbytkUEal6EW8BA1lx6VymcVhxtYXDzIXl2W7uhstyVlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hqNZ/wsU; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 636834E41415;
	Fri, 31 Oct 2025 17:28:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3ACC160704;
	Fri, 31 Oct 2025 17:28:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B053A11818007;
	Fri, 31 Oct 2025 18:28:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761931719; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0TkMp9aMwcsGosTWrhdTtxz4Lwc7YIxnivcDZ+k6Uqo=;
	b=hqNZ/wsUGkTKZq0riG/RmSnnIu+QPPr5pXIU6713zaYh/NXlRythOCClzvCx1gGf3gP5dh
	yuDeya8OSJEaPvBDjz9H7XBH6q3G92VWEGDKFegdGjw8rY7TydMlKET3/ntMuEmC8Moqx3
	5GvTE+YcEf0nwT2FSO5G3gFnVLKnH2g998eTODG+mg2ILBDdv+x0dKwxoCNp8CuJRd6s01
	U7K9wgK6oNMpFuXhFBxa2+ZLzLGRmG9mTCPMHWA2O1974jWEPBk1YDGcotII5jhekKbfbK
	bn51RrZRAgPew1eXsdTJN+9Hc6WAMsXJzpRRDASkSIpU1SEo1zlzeFZqsgBfqA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 31 Oct 2025 18:27:06 +0100
Subject: [PATCH 22/28] mtd: spinand: Gather all the bus interface steps in
 one single function
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-winbond-v6-17-rc1-oddr-v1-22-be42de23ebf1@bootlin.com>
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
index 7c01516c6b6acb41d2cc080d6fbaaa5ace661602..caf549617f369ada2c1712e863e563ae547ca0e6 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -177,18 +177,9 @@ static int spinand_init_cfg_cache(struct spinand_device *spinand)
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
@@ -1306,12 +1297,6 @@ static int spinand_manufacturer_init(struct spinand_device *spinand)
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
 
@@ -1517,6 +1502,31 @@ static int spinand_detect(struct spinand_device *spinand)
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
@@ -1527,10 +1537,6 @@ static int spinand_init_flash(struct spinand_device *spinand)
 	if (ret)
 		return ret;
 
-	ret = spinand_init_quad_enable(spinand);
-	if (ret)
-		return ret;
-
 	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
 	if (ret)
 		return ret;
@@ -1543,19 +1549,25 @@ static int spinand_init_flash(struct spinand_device *spinand)
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
2.51.0


