Return-Path: <linux-spi+bounces-10960-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EABC2664A
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 18:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D7624FB368
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 17:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAE53563CD;
	Fri, 31 Oct 2025 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OQU8H40z"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1C435581B
	for <linux-spi@vger.kernel.org>; Fri, 31 Oct 2025 17:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931724; cv=none; b=WYPB04dXJQPnJ0fXW0LJ0qhUvuYFw88e2QduJNMgbpAafFxNmOwZML3oxXzYH8RDu7o94Mkg6nfNF8yrCN0nq8EKKqAb/TvnucQptNdYz31N44qXGGDs/CmesuPL/IWqmPEqwA53uaoLgR8wipngW13Yu7vCu9DqgV/FiBsgEr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931724; c=relaxed/simple;
	bh=zJmzCZukFrUHaKsBwk+BpBUSinGesW5h8IXqGaaPpxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XCBzjT4gb4/AtMLKFjbM3/mQgLI7LNzeOXADf/x0nyrs/5Kz6uOuoa1K5QOQor+8RhxQEcOpJE4ea4EKpSDQaY0EiVrvhaOB5WU9YSiHSYklrsJ79o08wiX5Y7HD6+zJZfdTfstyM/EAi9y8NBhi+fUJElmD45wz/7oetrLWjjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OQU8H40z; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9323E1A17C4;
	Fri, 31 Oct 2025 17:28:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6A9AB60704;
	Fri, 31 Oct 2025 17:28:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DB15C1181800B;
	Fri, 31 Oct 2025 18:28:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761931720; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dDe4j5e1a+Bm1K5ZQ2VOjxbCwe35OfOvHUNHbqYEBCM=;
	b=OQU8H40zhHDYyzpyBy35Qe++qVhY8HighZjajGJghAuu4atrS+eNn2O2JBTc4ACXcYTz5/
	2ua93PkmSv17jrw7i9lq/knC8bQtCvkoiLC+MKZq3iCDizD2yzgJz2qgSBG9hoKA8pYMvx
	ZBOQ9gpmwKclyA7hOlCiwQNH9VtXDcfk92oKOnAR87vYXwiyr5VTgFbJ/qmSeYlVZyKC+t
	d79SLWKyIUSEEeOQxF0unF2JMpWGixWuttehktjYeq/xV+ZqButVQtpFIqhGEWESGAUSu9
	kOVMCmKOw76BjYRzH5u8pgcAkKS7Rs7yTBAhPmoRtpX6QDw9Lt2IppeEFllG3g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 31 Oct 2025 18:27:07 +0100
Subject: [PATCH 23/28] mtd: spinand: Add support for setting a bus
 interface
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-winbond-v6-17-rc1-oddr-v1-23-be42de23ebf1@bootlin.com>
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
index caf549617f369ada2c1712e863e563ae547ca0e6..fc7263fad7afbd084ecf015dd1d764d6683b46a8 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1321,6 +1321,7 @@ static void spinand_init_ssdr_templates(struct spinand_device *spinand)
 	tmpl->page_read = (struct spi_mem_op)SPINAND_PAGE_READ_1S_1S_0_OP(0);
 	tmpl->prog_exec = (struct spi_mem_op)SPINAND_PROG_EXEC_1S_1S_0_OP(0);
 	spinand->op_templates = &spinand->ssdr_op_templates;
+	spinand->bus_iface = SSDR;
 }
 
 static int spinand_support_vendor_ops(struct spinand_device *spinand,
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 0565cdeb3f7b652699d420a8c05c3fe53fcc2253..7d059956c81a3a6fd337bab43fb4f1130997ab0f 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -480,6 +480,14 @@ struct spinand_user_otp {
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
@@ -642,6 +650,7 @@ struct spinand_mem_ops {
  * @flags: NAND flags
  * @ssdr_op_templates: Templates for all single SDR SPI mem operations
  * @op_templates: Templates for all SPI mem operations
+ * @bus_iface: Current bus interface
  * @select_target: select a specific target/die. Usually called before sending
  *		   a command addressing a page or an eraseblock embedded in
  *		   this die. Only required if your chip exposes several dies
@@ -677,6 +686,7 @@ struct spinand_device {
 
 	struct spinand_mem_ops ssdr_op_templates;
 	struct spinand_mem_ops *op_templates;
+	enum spinand_bus_interface bus_iface;
 
 	struct spinand_dirmap *dirmaps;
 

-- 
2.51.0


