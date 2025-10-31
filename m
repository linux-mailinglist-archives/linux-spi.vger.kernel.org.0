Return-Path: <linux-spi+bounces-10946-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 036FBC265B1
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 18:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7E216351A93
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 17:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB1633E363;
	Fri, 31 Oct 2025 17:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O0kyOun4"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1013434D4DB;
	Fri, 31 Oct 2025 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931706; cv=none; b=uCfQU43iI0umSvA3ItjCB3WRWKeSS64PGvG/rVCcxfDbaruGzPChcZzL0EtOXfw2MhNZhJJmb/ESrXTmRM9Gv3+MScOdyBj45kGymZ5k+gxiNtyPgP7whyQHR7PzrPfgWjWkTwJ+gOh8Hrz7n+gMOTsT2c/XRyKWkKVV5wjuqQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931706; c=relaxed/simple;
	bh=qdvthG7Vi7hQFdOvT+ivnIhyG3J4sTYCjUbLhGubPo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RLYDFmoAfcwWbdDUBAUDKloG7YGwKZPMOvHrdViLZ6Cg91rMDiaqhCBMhvEF0HemmejfGKJjfnT5uRH+Va6BWqUMWdCT9j8rMX5Hydm9uBmO0heB3BE5MX0S7HIM49x9acTX0HM/dMbMibw5TsEKYIx2N4pbOnX/ZqZsU8Ilr/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=O0kyOun4; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0167DC0E959;
	Fri, 31 Oct 2025 17:28:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8608B60704;
	Fri, 31 Oct 2025 17:28:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BC3CF1181800A;
	Fri, 31 Oct 2025 18:28:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761931701; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NIIPE8AFPeP5osbw/f33KrhgIWBKR4ROKxE3MEZAWO4=;
	b=O0kyOun4w5hAZ8dUflG9ocF/UJW2rYVknHSF6VfeevincXgycB8NWqZhAj4jNnAbpCEyOA
	ZJRXnSMsEMvCNt9u3lZnQJVjymWb4X/DPpAu8L/tqaFQrNAt51xKKeJ88uZCEC6aLaJp6T
	1cgBsoVejLS1KbV+vlSYIdaVpAn0VHnKCdAYpWjsyRIK4BZ4O8Bxr2tuNVGaBbWf7Dny7Z
	kB103sX6a/vt4fm9DhV5kbbqdS3ToPhPI6ROtw/7DfTVcz1/hq4wINc+Ijyun1H1IC0Zq5
	JIb/xiYh0B80oxny3noEK+e5+6U03YxggSFittqhj6S1KU7nWy8lQI+Pr0rk5Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 31 Oct 2025 18:26:53 +0100
Subject: [PATCH 09/28] mtd: spinand: Create an array of operation templates
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-winbond-v6-17-rc1-oddr-v1-9-be42de23ebf1@bootlin.com>
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

Currently, the SPI NAND core implementation directly calls macros to get
the various operations in shape. These macros are specific to the bus
interface, currently only supporting the single SDR interface (any
command following the 1S-XX-XX pattern).

Introducing support for other bus interfaces (such as octal DTR) would
mean that every user of these macros should become aware of the current
bus interface and act accordingly, picking up and adapting to the
current configuration. This would add quite a bit of boilerplate, be
repetitive as well as error prone in case we miss one occurrence.

Instead, let's create a table with all SPI NAND memory operations that
are currently supported. We initialize them with the same single SDR _OP
macros as before. This opens the possibility for users of the individual
macros to make use of these templates instead. This way, when we will add
another bus interface, we can just switch to another set of templates
and all users will magically fill in their spi_mem_op structures with
the correct ops.

The existing read, write and update cache variants are also moved in
this template array, which is barely noticeable by callers as we also
add a structure member pointing to it.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/core.c    | 38 +++++++++++++++++++++++++++----------
 drivers/mtd/nand/spi/winbond.c |  4 ++--
 include/linux/mtd/spinand.h    | 43 +++++++++++++++++++++++++++++++++---------
 3 files changed, 64 insertions(+), 21 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index d215cefcba3f37057a2ba036d86ae6638885a7f3..11d3b28a14339282360a5ef12be715e532105e73 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -184,9 +184,9 @@ static int spinand_init_quad_enable(struct spinand_device *spinand)
 	if (!(spinand->flags & SPINAND_HAS_QE_BIT))
 		return 0;
 
-	if (spinand->op_templates.read_cache->data.buswidth == 4 ||
-	    spinand->op_templates.write_cache->data.buswidth == 4 ||
-	    spinand->op_templates.update_cache->data.buswidth == 4)
+	if (spinand->op_templates->read_cache->data.buswidth == 4 ||
+	    spinand->op_templates->write_cache->data.buswidth == 4 ||
+	    spinand->op_templates->update_cache->data.buswidth == 4)
 		enable = true;
 
 	return spinand_upd_cfg(spinand, CFG_QUAD_ENABLE,
@@ -1154,7 +1154,7 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	info.offset = plane << fls(nand->memorg.pagesize);
 
 	info.length = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
-	info.op_tmpl = *spinand->op_templates.update_cache;
+	info.op_tmpl = *spinand->op_templates->update_cache;
 	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
 					  spinand->spimem, &info);
 	if (IS_ERR(desc))
@@ -1162,7 +1162,7 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].wdesc = desc;
 
-	info.op_tmpl = *spinand->op_templates.read_cache;
+	info.op_tmpl = *spinand->op_templates->read_cache;
 	desc = spinand_create_rdesc(spinand, &info);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
@@ -1177,7 +1177,7 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	}
 
 	info.length = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
-	info.op_tmpl = *spinand->op_templates.update_cache;
+	info.op_tmpl = *spinand->op_templates->update_cache;
 	info.op_tmpl.data.ecc = true;
 	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
 					  spinand->spimem, &info);
@@ -1186,7 +1186,7 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].wdesc_ecc = desc;
 
-	info.op_tmpl = *spinand->op_templates.read_cache;
+	info.op_tmpl = *spinand->op_templates->read_cache;
 	info.op_tmpl.data.ecc = true;
 	desc = spinand_create_rdesc(spinand, &info);
 	if (IS_ERR(desc))
@@ -1322,6 +1322,22 @@ static void spinand_manufacturer_cleanup(struct spinand_device *spinand)
 		return spinand->manufacturer->ops->cleanup(spinand);
 }
 
+static void spinand_init_ssdr_templates(struct spinand_device *spinand)
+{
+	struct spinand_mem_ops *tmpl = &spinand->ssdr_op_templates;
+
+	tmpl->reset = (struct spi_mem_op)SPINAND_RESET_1S_0_0_OP;
+	tmpl->readid = (struct spi_mem_op)SPINAND_READID_1S_1S_1S_OP(0, 0, NULL, 0);
+	tmpl->wr_en = (struct spi_mem_op)SPINAND_WR_EN_1S_0_0_OP;
+	tmpl->wr_dis = (struct spi_mem_op)SPINAND_WR_DIS_1S_0_0_OP;
+	tmpl->set_feature = (struct spi_mem_op)SPINAND_SET_FEATURE_1S_1S_1S_OP(0, NULL);
+	tmpl->get_feature = (struct spi_mem_op)SPINAND_GET_FEATURE_1S_1S_1S_OP(0, NULL);
+	tmpl->blk_erase = (struct spi_mem_op)SPINAND_BLK_ERASE_1S_1S_0_OP(0);
+	tmpl->page_read = (struct spi_mem_op)SPINAND_PAGE_READ_1S_1S_0_OP(0);
+	tmpl->prog_exec = (struct spi_mem_op)SPINAND_PROG_EXEC_1S_1S_0_OP(0);
+	spinand->op_templates = &spinand->ssdr_op_templates;
+}
+
 static const struct spi_mem_op *
 spinand_select_op_variant(struct spinand_device *spinand,
 			  const struct spinand_op_variants *variants)
@@ -1420,21 +1436,21 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		if (!op)
 			return -EOPNOTSUPP;
 
-		spinand->op_templates.read_cache = op;
+		spinand->ssdr_op_templates.read_cache = op;
 
 		op = spinand_select_op_variant(spinand,
 					       info->op_variants.write_cache);
 		if (!op)
 			return -EOPNOTSUPP;
 
-		spinand->op_templates.write_cache = op;
+		spinand->ssdr_op_templates.write_cache = op;
 
 		op = spinand_select_op_variant(spinand,
 					       info->op_variants.update_cache);
 		if (!op)
 			return -EOPNOTSUPP;
 
-		spinand->op_templates.update_cache = op;
+		spinand->ssdr_op_templates.update_cache = op;
 
 		return 0;
 	}
@@ -1549,6 +1565,8 @@ static int spinand_init(struct spinand_device *spinand)
 	if (!spinand->scratchbuf)
 		return -ENOMEM;
 
+	spinand_init_ssdr_templates(spinand);
+
 	ret = spinand_detect(spinand);
 	if (ret)
 		goto err_free_bufs;
diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 4870b2d5edb2a1f8081b87bbe9de549c73272d7c..d5799c2df06520de6cb5c5b771ceeb9d11ddf1fb 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -291,7 +291,7 @@ static int w25n0xjw_hs_cfg(struct spinand_device *spinand)
 	u8 sr4;
 	int ret;
 
-	op = spinand->op_templates.read_cache;
+	op = spinand->op_templates->read_cache;
 	if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
 		hs = false;
 	else if (op->cmd.buswidth == 1 && op->addr.buswidth == 1 &&
@@ -355,7 +355,7 @@ static int w35n0xjw_vcr_cfg(struct spinand_device *spinand)
 	u8 io_mode;
 	int ret;
 
-	op = spinand->op_templates.read_cache;
+	op = spinand->op_templates->read_cache;
 
 	single = (op->cmd.buswidth == 1 && op->addr.buswidth == 1 && op->data.buswidth == 1);
 	dtr = (op->cmd.dtr || op->addr.dtr || op->data.dtr);
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 8c490a03b2e000bc18d692d72cfd20b151db023c..4afebaf5f0195b9bc617ea1f125f637f76fff9f8 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -598,6 +598,36 @@ struct spinand_dirmap {
 	struct spi_mem_dirmap_desc *rdesc_ecc;
 };
 
+/**
+ * struct spinand_mem_ops - SPI NAND memory operations
+ * @reset: reset op template
+ * @readid: read ID op template
+ * @wr_en: write enable op template
+ * @wr_dis: write disable op template
+ * @set_feature: set feature op template
+ * @get_feature: get feature op template
+ * @blk_erase: blk erase op template
+ * @page_read: page read op template
+ * @prog_exec: prog exec op template
+ * @read_cache: read cache op template
+ * @write_cache: write cache op template
+ * @update_cache: update cache op template
+ */
+struct spinand_mem_ops {
+	struct spi_mem_op reset;
+	struct spi_mem_op readid;
+	struct spi_mem_op wr_en;
+	struct spi_mem_op wr_dis;
+	struct spi_mem_op set_feature;
+	struct spi_mem_op get_feature;
+	struct spi_mem_op blk_erase;
+	struct spi_mem_op page_read;
+	struct spi_mem_op prog_exec;
+	const struct spi_mem_op *read_cache;
+	const struct spi_mem_op *write_cache;
+	const struct spi_mem_op *update_cache;
+};
+
 /**
  * struct spinand_device - SPI NAND device instance
  * @base: NAND device instance
@@ -605,10 +635,8 @@ struct spinand_dirmap {
  * @lock: lock used to serialize accesses to the NAND
  * @id: NAND ID as returned by READ_ID
  * @flags: NAND flags
- * @op_templates: various SPI mem op templates
- * @op_templates.read_cache: read cache op template
- * @op_templates.write_cache: write cache op template
- * @op_templates.update_cache: update cache op template
+ * @ssdr_op_templates: Templates for all single SDR SPI mem operations
+ * @op_templates: Templates for all SPI mem operations
  * @select_target: select a specific target/die. Usually called before sending
  *		   a command addressing a page or an eraseblock embedded in
  *		   this die. Only required if your chip exposes several dies
@@ -642,11 +670,8 @@ struct spinand_device {
 	struct spinand_id id;
 	u32 flags;
 
-	struct {
-		const struct spi_mem_op *read_cache;
-		const struct spi_mem_op *write_cache;
-		const struct spi_mem_op *update_cache;
-	} op_templates;
+	struct spinand_mem_ops ssdr_op_templates;
+	struct spinand_mem_ops *op_templates;
 
 	struct spinand_dirmap *dirmaps;
 

-- 
2.51.0


