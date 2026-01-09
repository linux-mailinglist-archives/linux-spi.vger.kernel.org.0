Return-Path: <linux-spi+bounces-12264-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE098D0B99F
	for <lists+linux-spi@lfdr.de>; Fri, 09 Jan 2026 18:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 867E1302D68F
	for <lists+linux-spi@lfdr.de>; Fri,  9 Jan 2026 17:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DA436827D;
	Fri,  9 Jan 2026 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qFAxyJAM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396FD36C0C9;
	Fri,  9 Jan 2026 17:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979130; cv=none; b=h4pgA04qX3u/S4w4K6pkM5Cz9DaeBt/vYQX+0gGf/dhMnAwpNqP0+GVBADHoiXHbhweZDzRHPkwDVCF8RkhGdL15B9+/teKagvLIsY46u0Sfj6ozTwiNWPi5jzmv3xieZ5inFxICtfzf1g6MiGzw7rtwMrYBeHkCngNdTad3MWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979130; c=relaxed/simple;
	bh=jbqyPaRP34v8KSUKwJkVtB0AyfzoRRX5YaaQoe1SHoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sUBb7mDvDGmoiux/pWDBhuUyRSzhb2T6UQ73PUjq5qhxIzQEQTSJoGOqzNAVqIQ4LofIn3QUowj33bK/3FfGH5vYbgfL81ay5H42aIl6CTPrj4px0RVfYYT6S888pDpJ0lnTkUpYlKdYO0a/o0wrJ+cuB5wr0jAqL061zyxoNtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qFAxyJAM; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 174071A2753;
	Fri,  9 Jan 2026 17:18:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E1D25606C6;
	Fri,  9 Jan 2026 17:18:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2E61B103C89AB;
	Fri,  9 Jan 2026 18:18:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767979125; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=B1lJ7HTagSCXQak24k+E5wMJF7OUHHqDYZn/cpX8YLs=;
	b=qFAxyJAMLb9dmFmKXyEEX6aOVWiaZsvLf/JgV8Nu5MS2v0FWtQj5sUmWamEm8tqYjjdeDG
	RKPO/cdOiIdLVV/tFca8S+hzonDigZUasYPfCMo1egKvLX0DkeaaInf2k8OgCrS9jWZfeg
	yAqqMnmkWfo5UJHHhgR1ov+2Tm8VWKjPCNWpDLwHDrxx/jHzM8Ija3m5epByh+dkY5pytf
	2seIAYysMfVNLj0vPPSmzakb3OZ3EMfyGxm+AY8mZIjexLb3o2Sy/PZyyuiXqByl2O3lt9
	Y+2Ma7V+ixBNl2rQefpZ2A5U1lBaB9gHGCCj0mjDZruhLQbo+WW2b02UGwS2eg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 09 Jan 2026 18:18:20 +0100
Subject: [PATCH v2 22/27] mtd: spinand: Add support for setting a bus
 interface
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-winbond-v6-17-rc1-oddr-v2-22-1fff6a2ddb80@bootlin.com>
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

Create a bus interface enumeration, currently only containing the
one we support: SSDR, for single SDR, so any operation whose command is
sent over a single data line in SDR mode, ie. any operation matching
1S-XX-XX.

The main spinand_device structure gets a new parameter to store this
enumeration, for now unused. Of course it is set to SSDR during the SSDR
templates initialization to further clarify the state we are in at the
moment.

This member is subject to be used to know in which bus configuration we
and be updated by the core when we switch to faster mode(s).

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/core.c |  1 +
 include/linux/mtd/spinand.h | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 54a32cea3755..a5166b49020c 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1406,6 +1406,7 @@ static void spinand_init_ssdr_templates(struct spinand_device *spinand)
 	tmpl->page_read = (struct spi_mem_op)SPINAND_PAGE_READ_1S_1S_0_OP(0);
 	tmpl->prog_exec = (struct spi_mem_op)SPINAND_PROG_EXEC_1S_1S_0_OP(0);
 	spinand->op_templates = &spinand->ssdr_op_templates;
+	spinand->bus_iface = SSDR;
 }
 
 static int spinand_support_vendor_ops(struct spinand_device *spinand,
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 88871287c739..027923841bba 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -481,6 +481,14 @@ struct spinand_user_otp {
 	const struct spinand_user_otp_ops *ops;
 };
 
+/**
+ * enum spinand_bus_interface - SPI NAND bus interface types
+ * @SSDR: Bus configuration supporting all 1S-XX-XX operations, including dual and quad
+ */
+enum spinand_bus_interface {
+	SSDR,
+};
+
 /**
  * struct spinand_info - Structure used to describe SPI NAND chips
  * @model: model name
@@ -643,6 +651,7 @@ struct spinand_mem_ops {
  * @flags: NAND flags
  * @ssdr_op_templates: Templates for all single SDR SPI mem operations
  * @op_templates: Templates for all SPI mem operations
+ * @bus_iface: Current bus interface
  * @select_target: select a specific target/die. Usually called before sending
  *		   a command addressing a page or an eraseblock embedded in
  *		   this die. Only required if your chip exposes several dies
@@ -678,6 +687,7 @@ struct spinand_device {
 
 	struct spinand_mem_ops ssdr_op_templates;
 	struct spinand_mem_ops *op_templates;
+	enum spinand_bus_interface bus_iface;
 
 	struct spinand_dirmap *dirmaps;
 

-- 
2.51.1


