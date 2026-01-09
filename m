Return-Path: <linux-spi+bounces-12266-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56000D0BAEC
	for <lists+linux-spi@lfdr.de>; Fri, 09 Jan 2026 18:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E88D43148EB4
	for <lists+linux-spi@lfdr.de>; Fri,  9 Jan 2026 17:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A293659FB;
	Fri,  9 Jan 2026 17:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="m1OjgYCJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2893E36C0DB;
	Fri,  9 Jan 2026 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979135; cv=none; b=mjcwwpSnHYtqPf0terZHUB0zcbCbhlB/+gQdsoLecHCiE6YnHpCRMkbMTZgPx4OkD7Z9ClniD4bto1TLDbbdhKgbabMZNwwc+JA2NQn9THtQdCSifUMTD5XeZhMO17MIhNTNDj2cod4mOxfbJqDz1mzA46rxWw2nv4XqKMqa3SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979135; c=relaxed/simple;
	bh=lVGvdy+KRDPcYsrle+D1tHGNdKToec8xPzEgrjKSDgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VI81kO4Yc8TzjJ9pn9p3JDAnCGLMknx6+k7iYGjdXTiz2XPHMps/KYU49nrlEH4Nqos7XpyMv/sk130SqIjU2U1obf+ZvHH7718g8Olq3jjw/UMRzqxx0ihjYSdb1RjnkPlOw4NDK0rZ9/x9bI4yug7l7BKRQzu4GT9Kc3pyjCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=m1OjgYCJ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0A4A61A2752;
	Fri,  9 Jan 2026 17:18:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D43AD606C6;
	Fri,  9 Jan 2026 17:18:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CE173103C8956;
	Fri,  9 Jan 2026 18:18:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767979130; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=XWoEYvW6UTkurEFnLt3TZWYNsLRXIKXbu8O7GL39Atk=;
	b=m1OjgYCJbE2Pt2/lIyPBAsS4bjN0OHbj4JHexQn2QnPGFzjTwVJtplLDPTv7YhDgvoVlQY
	ACYBqHLhHZSEP5nwVZ5Qm+6jQMYr1otMoKeHa2Jm/gFsxfa7kLfl5i/NfWasWI8TPKp38v
	YM7FvLRH27QVf7MSbifvh8f9qCkh0fAbk3uPrVG0CKXtLzyPTZz4tw/KW4nV7xbbirB1SM
	1CDstgICLGMiluRNIZ6bJBe9wJLyRyjMw4y4nuRMjCmzd4VXuz94fSm4hD+9FCqiuYQtbt
	0XUT3ZPDpSObp/P80TkoRXJyaITrZH9JWHFTY0biXxT/4vQyljqda+Hdk3/XKg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 09 Jan 2026 18:18:22 +0100
Subject: [PATCH v2 24/27] mtd: spinand: Give the bus interface to the
 configuration helper
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-winbond-v6-17-rc1-oddr-v2-24-1fff6a2ddb80@bootlin.com>
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

The chip configuration hook is the one responsible to actually switch
the switch between bus interfaces. It is natural to give it the bus
interface we expect with a new parameter. For now the only value we can
give is SSDR, but this is subject to change in the future, so add a bit
of extra logic in the implementations of this callback to make sure
both the core and the chip driver are aligned on the request.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/core.c    |  2 +-
 drivers/mtd/nand/spi/winbond.c | 28 +++++++++++++++++++++-------
 include/linux/mtd/spinand.h    |  6 ++++--
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 019594182c60..1ac1d0181a91 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1606,7 +1606,7 @@ static int spinand_configure_chip(struct spinand_device *spinand)
 		return ret;
 
 	if (spinand->configure_chip) {
-		ret = spinand->configure_chip(spinand);
+		ret = spinand->configure_chip(spinand, SSDR);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 1d79a8ae7920..419f4303a0dc 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -311,13 +311,17 @@ static int w25n02kv_ecc_get_status(struct spinand_device *spinand,
 	return -EINVAL;
 }
 
-static int w25n0xjw_hs_cfg(struct spinand_device *spinand)
+static int w25n0xjw_hs_cfg(struct spinand_device *spinand,
+			   enum spinand_bus_interface iface)
 {
 	const struct spi_mem_op *op;
 	bool hs;
 	u8 sr4;
 	int ret;
 
+	if (iface != SSDR)
+		return -EOPNOTSUPP;
+
 	op = spinand->op_templates->read_cache;
 	if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
 		hs = false;
@@ -371,17 +375,25 @@ static int w35n0xjw_write_vcr(struct spinand_device *spinand, u8 reg, u8 val)
 	return 0;
 }
 
-static int w35n0xjw_vcr_cfg(struct spinand_device *spinand)
+static int w35n0xjw_vcr_cfg(struct spinand_device *spinand,
+			    enum spinand_bus_interface iface)
 {
-	const struct spi_mem_op *op;
+	const struct spi_mem_op *ref_op;
 	unsigned int dummy_cycles;
 	bool dtr, single;
 	u8 io_mode;
 	int ret;
 
-	op = spinand->op_templates->read_cache;
+	switch (iface) {
+	case SSDR:
+		ref_op = spinand->ssdr_op_templates.read_cache;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	};
 
-	dummy_cycles = ((op->dummy.nbytes * 8) / op->dummy.buswidth) / (op->dummy.dtr ? 2 : 1);
+	dummy_cycles = ((ref_op->dummy.nbytes * 8) / ref_op->dummy.buswidth) /
+		(ref_op->dummy.dtr ? 2 : 1);
 	switch (dummy_cycles) {
 	case 8:
 	case 12:
@@ -398,8 +410,10 @@ static int w35n0xjw_vcr_cfg(struct spinand_device *spinand)
 	if (ret)
 		return ret;
 
-	single = (op->cmd.buswidth == 1 && op->addr.buswidth == 1 && op->data.buswidth == 1);
-	dtr = (op->cmd.dtr && op->addr.dtr && op->data.dtr);
+	single = (ref_op->cmd.buswidth == 1 &&
+		  ref_op->addr.buswidth == 1 &&
+		  ref_op->data.buswidth == 1);
+	dtr = (ref_op->cmd.dtr && ref_op->addr.dtr && ref_op->data.dtr);
 	if (single && !dtr)
 		io_mode = W35N01JW_VCR_IO_MODE_SINGLE_SDR;
 	else if (!single && !dtr)
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 027923841bba..b7eb3eceb138 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -529,7 +529,8 @@ struct spinand_info {
 	const struct spinand_op_variants *vendor_ops;
 	int (*select_target)(struct spinand_device *spinand,
 			     unsigned int target);
-	int (*configure_chip)(struct spinand_device *spinand);
+	int (*configure_chip)(struct spinand_device *spinand,
+			      enum spinand_bus_interface iface);
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
 	struct spinand_fact_otp fact_otp;
@@ -704,7 +705,8 @@ struct spinand_device {
 	const struct spinand_manufacturer *manufacturer;
 	void *priv;
 
-	int (*configure_chip)(struct spinand_device *spinand);
+	int (*configure_chip)(struct spinand_device *spinand,
+			      enum spinand_bus_interface iface);
 	bool cont_read_possible;
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);

-- 
2.51.1


