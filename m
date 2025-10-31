Return-Path: <linux-spi+bounces-10962-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FBAC265FC
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 18:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A279F1887DFF
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 17:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AED3563F4;
	Fri, 31 Oct 2025 17:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vJNmRXNz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9044F3563EC;
	Fri, 31 Oct 2025 17:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931727; cv=none; b=SR6PRzD6pzBZlLKuZuc0zOShwF/nZ+Qqag5e8K7IwJ4NqTllyV4xpGLwFMPMsOK5XhGi5qaVBxspM1omJwl8qpFAg8f79PHITkLNBcK9Vs/tz5QP5uzjKjDG96J9/eOakNva5MU/ikkceFyCH+zTsy/RwOkSL4CMQVyp8gK38NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931727; c=relaxed/simple;
	bh=mBN3LCDcD7yvayMmGfg/IOuhZVrAXSUpzGarOGcRvmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VCLlbMq1mpEOK6QfyRs2lkCsYKETxeGqFCsvheC4rA/qIvfzE3Tl2GC/v+GZC49KdgBSNKSflcBbAHuG8Qm2mwoFfqRsq5eH5yigHxHD0FSXuiB1ox3mCZYDfZSIq779WcdYCHsSlLRVOku009qX8c5f2lGsCC97jydDT4OxA9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vJNmRXNz; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1892D4E41434;
	Fri, 31 Oct 2025 17:28:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E4A4F60704;
	Fri, 31 Oct 2025 17:28:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6478411818007;
	Fri, 31 Oct 2025 18:28:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761931723; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1AlxpEmOzkdHU55IN1x55ULPTzeTpk4t+gKIBhPki5c=;
	b=vJNmRXNz3oDvVJ1FnQQieTAov+RBMej4MMh2r2w4tS3K/b6clMI6/YalgI8CUvhCt0DB3B
	GXopmiFUpwXfQ6se8A3WdbUVSPTnqqXPSZC+2ETRwiBpmBQgmNuFduM/9nHY5AlnTUW1SY
	2hjjC24hDbfYF6LZzmoBfr4wA7Rd2uVszF4M8lyGh0s9gVzD1tP3geXxETHMa0JfKr/cI2
	QLvZakIoEUvKAbER94qALH59ikc5fR6UP7OI1ThE5S9G9yWveGwmL0kWFA0UR922jkSuOn
	S8inmMdlfEHkvC8OM3yDZQodIXvY3XFfuGwjpl2SwJVVoiv5JmsUkPMaBLvqaA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 31 Oct 2025 18:27:09 +0100
Subject: [PATCH 25/28] mtd: spinand: Give the bus interface to the
 configuration helper
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-winbond-v6-17-rc1-oddr-v1-25-be42de23ebf1@bootlin.com>
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
index 0d98cc1d987e1f6387f6bb243cd3720949b01b0b..044a84d7b47bf08a14f2310b971cdc85267b0fd2 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1521,7 +1521,7 @@ static int spinand_configure_chip(struct spinand_device *spinand)
 		return ret;
 
 	if (spinand->configure_chip) {
-		ret = spinand->configure_chip(spinand);
+		ret = spinand->configure_chip(spinand, SSDR);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 1d79a8ae79206af7d823018c4603b3bd36a0dd88..419f4303a0dc7518017e2bd422584813dca14d48 100644
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
index 7d059956c81a3a6fd337bab43fb4f1130997ab0f..94348344208861c9e1ca36bd86e206225cbbd816 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -528,7 +528,8 @@ struct spinand_info {
 	const struct spinand_op_variants *vendor_ops;
 	int (*select_target)(struct spinand_device *spinand,
 			     unsigned int target);
-	int (*configure_chip)(struct spinand_device *spinand);
+	int (*configure_chip)(struct spinand_device *spinand,
+			      enum spinand_bus_interface iface);
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
 	struct spinand_fact_otp fact_otp;
@@ -703,7 +704,8 @@ struct spinand_device {
 	const struct spinand_manufacturer *manufacturer;
 	void *priv;
 
-	int (*configure_chip)(struct spinand_device *spinand);
+	int (*configure_chip)(struct spinand_device *spinand,
+			      enum spinand_bus_interface iface);
 	bool cont_read_possible;
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);

-- 
2.51.0


