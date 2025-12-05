Return-Path: <linux-spi+bounces-11800-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B149CA91C7
	for <lists+linux-spi@lfdr.de>; Fri, 05 Dec 2025 20:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68B7F317478B
	for <lists+linux-spi@lfdr.de>; Fri,  5 Dec 2025 19:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF7632D7DB;
	Fri,  5 Dec 2025 19:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l0UnPVwa"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70541322B7E;
	Fri,  5 Dec 2025 19:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764963598; cv=none; b=qTVBsoihaNZuKsX7rr4Mbwkk9KEy5SsgVR1ZUyuBcjoOFJ/JUKeRHrGhvQxwYu82fCKZ9mF21mZATLrJgfgegL3eJuGD1zKZjUJweqSsZsdt//LbsjS12I45yvu1lbMSZWQSgjX8WP3uoug9Nn4BZIxQVqdfj3T3XEzITpfGsrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764963598; c=relaxed/simple;
	bh=vPU+4PGXnQKsNC72tkHF1EUG8fgwp0WizxbbC7wkK7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DggfXMV+kQtVap+3YAqDMkylnRAaGS8KKrEp+i4x7el0G4ACDATyBNvrbtGqiOFuDRHfic9EUGg/5Ngs/a+L3Qkaasrl4wj7vf3JOTPa1oICFkk5Q3i3cpfWuv/12Lvt6IZ394NIg/4h+qJJ+3iQQi652rS0D1Eyrpf4rIeRLl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l0UnPVwa; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 93921C1964F;
	Fri,  5 Dec 2025 19:39:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 15AB9606AC;
	Fri,  5 Dec 2025 19:39:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DA3F6102F18EA;
	Fri,  5 Dec 2025 20:39:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764963594; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=EkSh6VEYpuxxHIEG0meSRCtp2QS/BqvaPUatfSsQwyk=;
	b=l0UnPVwaxkv3cNVoVZhqxcBtHj/KIOZxR4infQxPfyFagCIgmhNDZrxDjBI5puCdWJc8+f
	DUWCSsjTC1lRV2W0N3O7Vb07COds0f9Llo9oTAHnY9MQ/gc5RF2AccEJanM8/9DGYCM6u0
	tafGBtWg+ZDkWmD0d/NidnUnLk8dpAWL6Ug16H237c2ECGdoTB633g5WiVIwQ9tF9xis/8
	9bXB3yk1O9XepqOXPAHFlppJSmrnaEcb1A7p5lxNRID4ClW0pkhk0KaBLr3ncywxFUqQk5
	AKNIhfgJntzOV/0pHNo8pRGRuegIkA/aTy1QyTORiHEmqKJaSKPSZKnKMFvbDw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 05 Dec 2025 20:38:57 +0100
Subject: [PATCH RFC 6/8] mtd: spinand: Use secondary ops for continuous
 reads
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-winbond-v6-18-rc1-cont-read-v1-6-01bc48631c73@bootlin.com>
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

In case a chip supports continuous reads, but uses a slightly different
cache operation for these, it may provide a secondary operation template
which will be used only during continuous cache read operations.

From a vendor driver point of view, enabling this feature implies
providing a new set of templates for these continuous read
operations. The core will automatically pick the fastest variant,
depending on the hardware capabilities.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/core.c | 51 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/mtd/spinand.h | 12 +++++++++++
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 209146f21326..37a0d0373942 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -399,6 +399,11 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 
 	rdesc = spinand->dirmaps[req->pos.plane].rdesc;
 
+	if (spinand->op_templates->cont_read_cache && req->continuous)
+		rdesc->info.op_tmpl = &rdesc->info.secondary_op_tmpl;
+	else
+		rdesc->info.op_tmpl = &rdesc->info.primary_op_tmpl;
+
 	if (nand->ecc.engine->integration == NAND_ECC_ENGINE_INTEGRATION_PIPELINED &&
 	    req->mode != MTD_OPS_RAW)
 		rdesc->info.op_tmpl->data.ecc = true;
@@ -1123,6 +1128,7 @@ static struct spi_mem_dirmap_desc *spinand_create_rdesc(
 		 * its spi controller, use regular reading
 		 */
 		spinand->cont_read_possible = false;
+		memset(&info->secondary_op_tmpl, 0, sizeof(info->secondary_op_tmpl));
 
 		info->length = nanddev_page_size(nand) +
 			       nanddev_per_page_oobsize(nand);
@@ -1139,11 +1145,24 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	struct nand_device *nand = spinand_to_nand(spinand);
 	struct spi_mem_dirmap_info info = { 0 };
 	struct spi_mem_dirmap_desc *desc;
-	bool enable_ecc = false;
+	bool enable_ecc = false, secondary_op = false;
 
 	if (nand->ecc.engine->integration == NAND_ECC_ENGINE_INTEGRATION_PIPELINED)
 		enable_ecc = true;
 
+	if (spinand->cont_read_possible && spinand->op_templates->cont_read_cache)
+		secondary_op = true;
+
+	/*
+	 * Continuous read implies that only the main data is retrieved, backed
+	 * by an on-die ECC engine. It is not possible to use a pipelind ECC
+	 * engine with continuous read.
+	 */
+	if (enable_ecc && secondary_op) {
+		secondary_op = false;
+		spinand->cont_read_possible = false;
+	}
+
 	/* The plane number is passed in MSB just above the column address */
 	info.offset = plane << fls(nand->memorg.pagesize);
 
@@ -1161,6 +1180,10 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	/* Read descriptor */
 	info.primary_op_tmpl = *spinand->op_templates->read_cache;
 	info.primary_op_tmpl.data.ecc = enable_ecc;
+	if (secondary_op) {
+		info.secondary_op_tmpl = *spinand->op_templates->cont_read_cache;
+		info.secondary_op_tmpl.data.ecc = enable_ecc;
+	}
 	desc = spinand_create_rdesc(spinand, &info);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
@@ -1505,6 +1528,27 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		if (ret)
 			return ret;
 
+		op = spinand_select_op_variant(spinand, SSDR,
+					       info->op_variants.cont_read_cache);
+		if (op) {
+			const struct spi_mem_op *read_op = spinand->ssdr_op_templates.read_cache;
+
+			/*
+			 * Sometimes the fastest continuous read variant may not
+			 * be supported. In this case, prefer to use the fastest
+			 * read from cache variant and disable continuous reads.
+			 */
+			if (read_op->cmd.buswidth != op->cmd.buswidth ||
+			    read_op->cmd.dtr != op->cmd.dtr ||
+			    read_op->addr.buswidth != op->addr.buswidth ||
+			    read_op->addr.dtr != op->addr.dtr ||
+			    read_op->cmd.buswidth != op->cmd.buswidth ||
+			    read_op->cmd.dtr != op->cmd.dtr)
+				spinand->cont_read_possible = false;
+			else
+				spinand->ssdr_op_templates.cont_read_cache = op;
+		}
+
 		/* I/O variants selection with octo-spi DDR commands (optional) */
 
 		ret = spinand_init_odtr_instruction_set(spinand);
@@ -1527,6 +1571,11 @@ int spinand_match_and_init(struct spinand_device *spinand,
 					       info->op_variants.update_cache);
 		spinand->odtr_op_templates.update_cache = op;
 
+		op = spinand_select_op_variant(spinand, ODTR,
+					       info->op_variants.cont_read_cache);
+		if (op)
+			spinand->odtr_op_templates.cont_read_cache = op;
+
 		return 0;
 	}
 
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 5ca1181048f7..5ec7d756df8b 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -573,6 +573,7 @@ enum spinand_bus_interface {
  * @op_variants.read_cache: variants of the read-cache operation
  * @op_variants.write_cache: variants of the write-cache operation
  * @op_variants.update_cache: variants of the update-cache operation
+ * @op_variants.cont_read_cache: variants of the continuous read-cache operation
  * @vendor_ops: vendor specific operations
  * @select_target: function used to select a target/die. Required only for
  *		   multi-die chips
@@ -597,6 +598,7 @@ struct spinand_info {
 		const struct spinand_op_variants *read_cache;
 		const struct spinand_op_variants *write_cache;
 		const struct spinand_op_variants *update_cache;
+		const struct spinand_op_variants *cont_read_cache;
 	} op_variants;
 	const struct spinand_op_variants *vendor_ops;
 	int (*select_target)(struct spinand_device *spinand,
@@ -626,6 +628,14 @@ struct spinand_info {
 		.update_cache = __update,				\
 	}
 
+#define SPINAND_INFO_OP_VARIANTS_WITH_CONT(__read, __write, __update, __cont_read) \
+	{								\
+		.read_cache = __read,					\
+		.write_cache = __write,					\
+		.update_cache = __update,				\
+		.cont_read_cache = __cont_read,				\
+	}
+
 #define SPINAND_INFO_VENDOR_OPS(__ops)					\
 	.vendor_ops = __ops
 
@@ -697,6 +707,7 @@ struct spinand_dirmap {
  * @read_cache: read cache op template
  * @write_cache: write cache op template
  * @update_cache: update cache op template
+ * @cont_read_cache: continuous read cache op template (optional)
  */
 struct spinand_mem_ops {
 	struct spi_mem_op reset;
@@ -711,6 +722,7 @@ struct spinand_mem_ops {
 	const struct spi_mem_op *read_cache;
 	const struct spi_mem_op *write_cache;
 	const struct spi_mem_op *update_cache;
+	const struct spi_mem_op *cont_read_cache;
 };
 
 /**

-- 
2.51.1


