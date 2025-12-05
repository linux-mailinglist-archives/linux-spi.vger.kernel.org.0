Return-Path: <linux-spi+bounces-11797-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF48CA91AD
	for <lists+linux-spi@lfdr.de>; Fri, 05 Dec 2025 20:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CD5330AC02F
	for <lists+linux-spi@lfdr.de>; Fri,  5 Dec 2025 19:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F3E322B7C;
	Fri,  5 Dec 2025 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aKWi69wq"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6764431AABC
	for <linux-spi@vger.kernel.org>; Fri,  5 Dec 2025 19:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764963589; cv=none; b=Z7k0vqcFY/fXlvpVX5l0JP7i+Y4tVaZZxtKqdRRYSgfyTUbBtBINXitvhR/3WMOesYo8eXH1hKKkBOBsB7VNYA84S2I1JCvRMm2Fb2lgNmMUFzLeP0KnKiYty6YuVNj5jcsC367MVUCarojD29tFALgmgX+LX54XbsEumnkZihQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764963589; c=relaxed/simple;
	bh=0cukgJ5NKjqHVM+tQAlvy8PWi0Q1Fsr8fCIOzOzJR88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kc/71oDWNGyM2k9horcVbCwBPmDGgpy9womwQhCxOhJj8mEz2rIGWNkysBLKMWRrrll82O/q5fVsx5Nigqrw3tL8VHLSjVkwfQPrFVX7w3m15nZpdMM5nwt58t29TgYOB/e9UO+H275wao3S/wwafrLNcjKpXV4rYdj7MG+WAmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aKWi69wq; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 63EA1C1964F;
	Fri,  5 Dec 2025 19:39:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D70CC606AC;
	Fri,  5 Dec 2025 19:39:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 456D9102F170A;
	Fri,  5 Dec 2025 20:39:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764963585; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=EMGpx1MzAg6O8NLZEwbaJM17V1d6KdJfLT/hxVY3Xs4=;
	b=aKWi69wqYVysNMyrftPssWDmkIa8f8R9dT8gmxcN+8e0mdsA4bY3Pg33colA+ecbDjOTMy
	B56XCj5cmtA2GOpR0qlgG4kEqxeYU73gBu94dlmCrKWFTBWF3/7RzDBLGFMFzUUoZrioTu
	Xvrnm51iWn2q06pQ+dnHJJoAHkiyKQ0N6Y+7Z8jvY7T+lGJG+h9YoBI8K2Mp4+E/WWoiAt
	E9tqOrnuy9Mse6k60/dv5C7n10rrb4Tg4HXKq+TXBMCQ5tX21gSlJYQl63XTrFPoSgRYkT
	WfzD8yofRYqIGFo6sr5ULVyb9AY5LmSp0uC9klZkK1nDtkA2s4OSgA+iPaiPCw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 05 Dec 2025 20:38:54 +0100
Subject: [PATCH RFC 3/8] mtd: spinand: Drop ECC dirmaps
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-winbond-v6-18-rc1-cont-read-v1-3-01bc48631c73@bootlin.com>
References: <20251205-winbond-v6-18-rc1-cont-read-v1-0-01bc48631c73@bootlin.com>
In-Reply-To: <20251205-winbond-v6-18-rc1-cont-read-v1-0-01bc48631c73@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Michael Walle <mwalle@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Direct mappings are very static concepts, which allow us to reuse a
template to perform reads or writes in a very efficient manner after a
single initialization. With the introduction of pipelined ECC engines
for SPI controllers, the need to differentiate between an operation with
and without correction has arised. The chosen solution at that time has
been to create new direct mappings for these operations, jumping from 2
to 4 dirmaps per target. Enabling ECC was done by choosing the correct
dirmap.

Today, we need to further parametrize dirmaps. With the goal to enable
continuous reads on a wider range of devices, we will need more
flexibility regarding the read from cache operation template to pick at
run time, for instance to use shorter "continuous read from cache"
variants.

We could create other direct mappings, but it would increase the matrix
by a power of two, bringing the theoretical number of dirmaps to
8 (read/write, ecc, shorter read variants) per target. This grow is not
sustainable, so let's change how dirmaps work - a little bit.

Operations already carry an ECC parameter, use it to indicate whether
error correction is required or not. In practice this change happens
only at the core level, SPI controller drivers do not care about the
direct mapping structure in this case, they just pick whatever is in the
template as a base. As a result, we allow the core to dynamically change
the content of the templates.

He who can do more can do less, so during the checking steps, make sure
to enable the ECC requirement just for the time of the checks.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/core.c | 52 +++++++++++++++++----------------------------
 include/linux/mtd/spinand.h |  2 --
 2 files changed, 20 insertions(+), 34 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 3765fcc95c4a..086c9f293373 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -397,10 +397,13 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 		}
 	}
 
-	if (req->mode == MTD_OPS_RAW)
-		rdesc = spinand->dirmaps[req->pos.plane].rdesc;
+	rdesc = spinand->dirmaps[req->pos.plane].rdesc;
+
+	if (nand->ecc.engine->integration == NAND_ECC_ENGINE_INTEGRATION_PIPELINED &&
+	    req->mode != MTD_OPS_RAW)
+		rdesc->info.op_tmpl.data.ecc = true;
 	else
-		rdesc = spinand->dirmaps[req->pos.plane].rdesc_ecc;
+		rdesc->info.op_tmpl.data.ecc = false;
 
 	if (spinand->flags & SPINAND_HAS_READ_PLANE_SELECT_BIT)
 		column |= req->pos.plane << fls(nanddev_page_size(nand));
@@ -489,10 +492,13 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 			       req->ooblen);
 	}
 
-	if (req->mode == MTD_OPS_RAW)
-		wdesc = spinand->dirmaps[req->pos.plane].wdesc;
+	wdesc = spinand->dirmaps[req->pos.plane].wdesc;
+
+	if (nand->ecc.engine->integration == NAND_ECC_ENGINE_INTEGRATION_PIPELINED &&
+	    req->mode != MTD_OPS_RAW)
+		wdesc->info.op_tmpl.data.ecc = true;
 	else
-		wdesc = spinand->dirmaps[req->pos.plane].wdesc_ecc;
+		wdesc->info.op_tmpl.data.ecc = false;
 
 	if (spinand->flags & SPINAND_HAS_PROG_PLANE_SELECT_BIT)
 		column |= req->pos.plane << fls(nanddev_page_size(nand));
@@ -1133,12 +1139,17 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	struct nand_device *nand = spinand_to_nand(spinand);
 	struct spi_mem_dirmap_info info = { 0 };
 	struct spi_mem_dirmap_desc *desc;
+	bool enable_ecc = false;
+
+	if (nand->ecc.engine->integration == NAND_ECC_ENGINE_INTEGRATION_PIPELINED)
+		enable_ecc = true;
 
 	/* The plane number is passed in MSB just above the column address */
 	info.offset = plane << fls(nand->memorg.pagesize);
 
+	/* Write descriptor */
 	info.length = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
-	info.op_tmpl = *spinand->op_templates->update_cache;
+	info.op_tmpl.data.ecc = enable_ecc;
 	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
 					  spinand->spimem, &info);
 	if (IS_ERR(desc))
@@ -1146,38 +1157,15 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].wdesc = desc;
 
+	/* Read descriptor */
 	info.op_tmpl = *spinand->op_templates->read_cache;
+	info.op_tmpl.data.ecc = enable_ecc;
 	desc = spinand_create_rdesc(spinand, &info);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 
 	spinand->dirmaps[plane].rdesc = desc;
 
-	if (nand->ecc.engine->integration != NAND_ECC_ENGINE_INTEGRATION_PIPELINED) {
-		spinand->dirmaps[plane].wdesc_ecc = spinand->dirmaps[plane].wdesc;
-		spinand->dirmaps[plane].rdesc_ecc = spinand->dirmaps[plane].rdesc;
-
-		return 0;
-	}
-
-	info.length = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
-	info.op_tmpl = *spinand->op_templates->update_cache;
-	info.op_tmpl.data.ecc = true;
-	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
-					  spinand->spimem, &info);
-	if (IS_ERR(desc))
-		return PTR_ERR(desc);
-
-	spinand->dirmaps[plane].wdesc_ecc = desc;
-
-	info.op_tmpl = *spinand->op_templates->read_cache;
-	info.op_tmpl.data.ecc = true;
-	desc = spinand_create_rdesc(spinand, &info);
-	if (IS_ERR(desc))
-		return PTR_ERR(desc);
-
-	spinand->dirmaps[plane].rdesc_ecc = desc;
-
 	return 0;
 }
 
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index a90e873cf693..5ca1181048f7 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -681,8 +681,6 @@ struct spinand_info {
 struct spinand_dirmap {
 	struct spi_mem_dirmap_desc *wdesc;
 	struct spi_mem_dirmap_desc *rdesc;
-	struct spi_mem_dirmap_desc *wdesc_ecc;
-	struct spi_mem_dirmap_desc *rdesc_ecc;
 };
 
 /**

-- 
2.51.1


