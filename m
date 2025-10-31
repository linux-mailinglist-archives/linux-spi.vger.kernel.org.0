Return-Path: <linux-spi+bounces-10961-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 742C0C26653
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 18:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE1BE4FB65B
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 17:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D0D3570A7;
	Fri, 31 Oct 2025 17:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DIRu8ElF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B283557E0;
	Fri, 31 Oct 2025 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931726; cv=none; b=U+39e3vM3VUPH8Ujr3aCkmAquDtXf6F+4ORsOKuA3TdMkWBmnul4f27qsEMRCBjkzTR2IeWOT3q+AvH/NB1/HcD7etbhK9+M1v22SKNrWMh2xMiDdb16JgMfultwM6/y9SETFY+S27MFDf2vwJkab9ht6GCaTkOgFyvReNQwGYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931726; c=relaxed/simple;
	bh=TNoYEQnBFh3gP20Y4ao1hqraCmPr6wCjj5wqZ3Qi4yM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RlwCP3fTewKbJTlPAPde1iBVGp5Z1HNOZA/38BsOroiwzUvzOqlvVlEbYDmK639LOx41gYEqv182GLbpXb9aPbhifKBse6iWD1O8j7RgIMqLUWnbvYK63rP63R5gXLahVit2Bvm3flCbiNPGDgmJoKJQDbff2T5u2WCvWq6+Ghs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DIRu8ElF; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3F794C0E958;
	Fri, 31 Oct 2025 17:28:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C377360704;
	Fri, 31 Oct 2025 17:28:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 165131181800A;
	Fri, 31 Oct 2025 18:28:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761931722; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=FbpwgQnTShOmE9iJ48pWQGNuCt29TUQkvkRo0eiMaAQ=;
	b=DIRu8ElFiW438LrY4NcGm9oQrY4vcnzVQZPDi4iKKpm7/ZB5O8TtTmVe6jmnVn8enww1hF
	TgcfgIcqEJOfcxL9Zo84uvwVL8K578F/R+u40MqpF1FKPWjQrSvVCJRiaWVfbUQ6mppSwl
	JZHPJLSgvZsKqQA56q8FR8atFup6k9Ez/FhMA4uYEB1EytTfKHJjmZ/Hbx1clnU/p8kEW0
	29UVz8Y/carl6Ts2izQDq5ExeOOIMwBMAOVYQ2tk1iwezo+jv9gLjMEKE4KXr2YnhoB/3B
	KmpW2mJREmWKk6fnIPk3Ig1Vw7MkueGWUz8ZBAIK3Os9Sc+zn/icIiZDKS6GGQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 31 Oct 2025 18:27:08 +0100
Subject: [PATCH 24/28] mtd: spinand: Propagate the bus interface across
 core helpers
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-winbond-v6-17-rc1-oddr-v1-24-be42de23ebf1@bootlin.com>
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

For now all drivers provide SSDR variants only. When we add support for
ODTR modes, there will be a need to differentiate the type of variant we
target as well as the need to check if we support one or the other type
of operations.

Pass this parameter to lower level helpers, which for now is unused, in
order to simplify the patch introducing ODTR support.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/core.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index fc7263fad7afbd084ecf015dd1d764d6683b46a8..0d98cc1d987e1f6387f6bb243cd3720949b01b0b 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1325,7 +1325,8 @@ static void spinand_init_ssdr_templates(struct spinand_device *spinand)
 }
 
 static int spinand_support_vendor_ops(struct spinand_device *spinand,
-				      const struct spinand_info *info)
+				      const struct spinand_info *info,
+				      enum spinand_bus_interface iface)
 {
 	int i;
 
@@ -1346,7 +1347,7 @@ static int spinand_support_vendor_ops(struct spinand_device *spinand,
 }
 
 static const struct spi_mem_op *
-spinand_select_op_variant(struct spinand_device *spinand,
+spinand_select_op_variant(struct spinand_device *spinand, enum spinand_bus_interface iface,
 			  const struct spinand_op_variants *variants)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
@@ -1439,28 +1440,28 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->read_retries = table[i].read_retries;
 		spinand->set_read_retry = table[i].set_read_retry;
 
-		op = spinand_select_op_variant(spinand,
+		op = spinand_select_op_variant(spinand, SSDR,
 					       info->op_variants.read_cache);
 		if (!op)
 			return -EOPNOTSUPP;
 
 		spinand->ssdr_op_templates.read_cache = op;
 
-		op = spinand_select_op_variant(spinand,
+		op = spinand_select_op_variant(spinand, SSDR,
 					       info->op_variants.write_cache);
 		if (!op)
 			return -EOPNOTSUPP;
 
 		spinand->ssdr_op_templates.write_cache = op;
 
-		op = spinand_select_op_variant(spinand,
+		op = spinand_select_op_variant(spinand, SSDR,
 					       info->op_variants.update_cache);
 		if (!op)
 			return -EOPNOTSUPP;
 
 		spinand->ssdr_op_templates.update_cache = op;
 
-		ret = spinand_support_vendor_ops(spinand, info);
+		ret = spinand_support_vendor_ops(spinand, info, SSDR);
 		if (ret)
 			return ret;
 

-- 
2.51.0


