Return-Path: <linux-spi+bounces-10953-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBD0C2661A
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 18:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79D494FA1FA
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 17:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060F0350A06;
	Fri, 31 Oct 2025 17:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gpthj2Fs"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E810534FF7C
	for <linux-spi@vger.kernel.org>; Fri, 31 Oct 2025 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931715; cv=none; b=l12ElhuOAM9kr0jvKBA54Y0dxWArF1SkVKYebVoEVGUsnbQ03EDfOhXe07XASH+iV8aB6QtcSj9xwLk2mGoV3YgEwYH3DpHSoFUT+W+oB6nNzxrvtM5wqabvZfkl8xJ+PYPC2jU17MdY38zhWfskWMRJxe0LwNI2almsX1TLnNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931715; c=relaxed/simple;
	bh=SwofGuta5o6W85LlbaSEKjS7hlS8I8TpmVta/kJFyr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qqncu4KKqOPe1QRJMCw2FeqFxTTtew/uzhQ8BgkxfHb/flv4hlVl/V70UszUWg/1faTJPcrfPzEUy3i0ss/S5lxQ+EOFJ1FNNwKdg7FYfjBEzSyXdkgwWeLftjWbM2A6vUArXN1QI0YUqJMzczz0RQAvoG6mJtVkQKqySu26ZMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gpthj2Fs; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D1CD5C0E95A;
	Fri, 31 Oct 2025 17:28:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 62E5960704;
	Fri, 31 Oct 2025 17:28:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C039411818007;
	Fri, 31 Oct 2025 18:28:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761931709; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZnZdiNJPbIqvHm/HDag2fb8foKcg/2VPHnNDy+534Sc=;
	b=gpthj2FszYm3wOTAqiSK3W+RfJBtylUVIZ+zV2ruI3xuhvmtaMrXhuh1XzdpXJsAHq+R1o
	89HHVe7LwxFqaQtm2lv/PCN7OSQ2UNeeX07xooxQ9mFgz7moCStfaOwJCXraDPze8FPCP5
	Y+80heOSuOgs3I2tDYLWGCNACHSVw2IZV0rG5DICtcoo5Kke4mNRBVZ1eN3Tcem3tbc+n4
	gmAkF7E7zQ/LP1DjWcpgG3QaQzwCIQlkqIqbUtKzC2WE+qVF74XUVFQVEemEK6s6eA0yVi
	U4MzWcqcBUU7ayKKvKgmE8VORtMuM3g5m/HJM6lvaDDHO3L3X/4NVy4D8405UA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 31 Oct 2025 18:26:59 +0100
Subject: [PATCH 15/28] mtd: spinand: List vendor specific operations and
 make sure they are supported
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-winbond-v6-17-rc1-oddr-v1-15-be42de23ebf1@bootlin.com>
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

It is probably safe to expect that all SPI controller drivers will ever
support all the most basic SPI NAND operations, such as write enable,
register reads, page program, block erases, etc. However, what about
vendor specific operations? So far nobody complained about it, but as we
are about to introduce octal DTR support, and as none of the SPI NAND
instruction set is defined in any standard, we must remain careful about
these extra operations.

One way to make sure we do not blindly get ourselves in strange
situations with vendor commands failing silently is to make the check
once for all, while probing the chip. However at this stage we have no
such list, so let's add the necessary infrastructure to allow:
- registering vendor operations,
- checking they are actually supported when appropriate.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/core.c | 26 ++++++++++++++++++++++++++
 include/linux/mtd/spinand.h |  5 +++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index d4f46a17f77e15ac0ab26397e88d37119636b003..7c01516c6b6acb41d2cc080d6fbaaa5ace661602 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1338,6 +1338,27 @@ static void spinand_init_ssdr_templates(struct spinand_device *spinand)
 	spinand->op_templates = &spinand->ssdr_op_templates;
 }
 
+static int spinand_support_vendor_ops(struct spinand_device *spinand,
+				      const struct spinand_info *info)
+{
+	int i;
+
+	/*
+	 * The vendor ops array is only used in order to verify this chip and all its memory
+	 * operations are supported. If we see patterns emerging, we could ideally name these
+	 * operations and define them at the SPI NAND core level instead.
+	 * For now, this only serves as a sanity check.
+	 */
+	for (i = 0; i < info->vendor_ops->nops; i++) {
+		const struct spi_mem_op *op = &info->vendor_ops->ops[i];
+
+		if (!spi_mem_supports_op(spinand->spimem, op))
+			return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 static const struct spi_mem_op *
 spinand_select_op_variant(struct spinand_device *spinand,
 			  const struct spinand_op_variants *variants)
@@ -1407,6 +1428,7 @@ int spinand_match_and_init(struct spinand_device *spinand,
 	u8 *id = spinand->id.data;
 	struct nand_device *nand = spinand_to_nand(spinand);
 	unsigned int i;
+	int ret;
 
 	for (i = 0; i < table_size; i++) {
 		const struct spinand_info *info = &table[i];
@@ -1452,6 +1474,10 @@ int spinand_match_and_init(struct spinand_device *spinand,
 
 		spinand->ssdr_op_templates.update_cache = op;
 
+		ret = spinand_support_vendor_ops(spinand, info);
+		if (ret)
+			return ret;
+
 		return 0;
 	}
 
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index a8fd04a67cfa9925bd68c57539d86e0816b76274..0565cdeb3f7b652699d420a8c05c3fe53fcc2253 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -492,6 +492,7 @@ struct spinand_user_otp {
  * @op_variants.read_cache: variants of the read-cache operation
  * @op_variants.write_cache: variants of the write-cache operation
  * @op_variants.update_cache: variants of the update-cache operation
+ * @vendor_ops: vendor specific operations
  * @select_target: function used to select a target/die. Required only for
  *		   multi-die chips
  * @configure_chip: Align the chip configuration with the core settings
@@ -516,6 +517,7 @@ struct spinand_info {
 		const struct spinand_op_variants *write_cache;
 		const struct spinand_op_variants *update_cache;
 	} op_variants;
+	const struct spinand_op_variants *vendor_ops;
 	int (*select_target)(struct spinand_device *spinand,
 			     unsigned int target);
 	int (*configure_chip)(struct spinand_device *spinand);
@@ -542,6 +544,9 @@ struct spinand_info {
 		.update_cache = __update,				\
 	}
 
+#define SPINAND_INFO_VENDOR_OPS(__ops)					\
+	.vendor_ops = __ops
+
 #define SPINAND_ECCINFO(__ooblayout, __get_status)			\
 	.eccinfo = {							\
 		.ooblayout = __ooblayout,				\

-- 
2.51.0


