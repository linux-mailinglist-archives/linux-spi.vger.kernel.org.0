Return-Path: <linux-spi+bounces-11796-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B819CA91AA
	for <lists+linux-spi@lfdr.de>; Fri, 05 Dec 2025 20:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BB5931024B8
	for <lists+linux-spi@lfdr.de>; Fri,  5 Dec 2025 19:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0A8322B62;
	Fri,  5 Dec 2025 19:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kdl8sj1F"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E1E2D29D6
	for <linux-spi@vger.kernel.org>; Fri,  5 Dec 2025 19:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764963587; cv=none; b=ciYRbiG2YlvPg2nFpa2/4xU4Abu5lwXX4XrEtTakJYEmAZD31Tdvs1BGxOuFFFknfTRO4ARjuKY5bGG5Ax62NM+PDE0lkAdxH15fxXMCajJXshPl+e0/BIPC/e4teZxoe7dc7wax31/Q1Raxonhjl3evmXMJ0zZrvA62zk8ojp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764963587; c=relaxed/simple;
	bh=mQaaxpYiYEA4WG+VkY9JcwF+LpKCHCFQheQhakl466s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YdKdIhI1yOP2bc6ywk2Nx5QHnNeyLRmyB8gggpN0VvbwBeLUTac85p17zPRwki4Ht1Ov2DRTPqqoNofGQj6VkOKit5Wrt0hWTqiCvHXGn5Mw91t0bNafvb/drv+bldErfQlkup5qyNbOQsCVvoY/LYe/OWOdvJ/4HuVHwyKFuYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kdl8sj1F; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B6F064E41A74;
	Fri,  5 Dec 2025 19:39:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8EB41606AC;
	Fri,  5 Dec 2025 19:39:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 38787102F18E2;
	Fri,  5 Dec 2025 20:39:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764963582; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=GsPfW5nIrd5pUnvoNUZwEFGa4mbzSWlHyDo81A+WvbQ=;
	b=kdl8sj1F1iOIT4hz0E2OFm3VYpUtyMOasoawoaUZOU4bJdRlkRuR/L5h2wxiuywE2ulpU1
	5OJsczM5hBpkRyWlluHcWhpAP9Jo1VA34C6Ta5XZEbFakxra7daw+eYFGAI3ZAQyDCXr+9
	sKVUGXfn+6U4Jct+kwy0Grz5r0LOFHCH1qngzo+s4h5axTMBDKD7I7GT52IIKRSp7P41CF
	hymHESESD6jzDg3HlGIZL/4XbLYln7uigDGjCQopihp5DB26Anl+7TKEr0z2s3HJzZm5VA
	zoaJb+dPuaZVhvkpJX33okuFuRxUxr1mYSCU1IcvS8jmEfF6xFk3PHMPh7QwZQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 05 Dec 2025 20:38:53 +0100
Subject: [PATCH RFC 2/8] mtd: spinand: Expose spinand_op_is_odtr()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-winbond-v6-18-rc1-cont-read-v1-2-01bc48631c73@bootlin.com>
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

This helper is going to be needed in a vendor driver, so expose it.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/core.c | 2 +-
 include/linux/mtd/spinand.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index f19150740979..3765fcc95c4a 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1300,7 +1300,7 @@ static void spinand_manufacturer_cleanup(struct spinand_device *spinand)
 		return spinand->manufacturer->ops->cleanup(spinand);
 }
 
-static bool spinand_op_is_odtr(const struct spi_mem_op *op)
+bool spinand_op_is_odtr(const struct spi_mem_op *op)
 {
 	return op->cmd.dtr && op->cmd.buswidth == 8;
 }
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index eb8ae164b3aa..a90e873cf693 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -944,6 +944,8 @@ static inline void spinand_set_of_node(struct spinand_device *spinand,
 	nanddev_set_of_node(&spinand->base, np);
 }
 
+bool spinand_op_is_odtr(const struct spi_mem_op *op);
+
 int spinand_match_and_init(struct spinand_device *spinand,
 			   const struct spinand_info *table,
 			   unsigned int table_size,

-- 
2.51.1


