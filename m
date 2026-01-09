Return-Path: <linux-spi+bounces-12256-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65902D0B978
	for <lists+linux-spi@lfdr.de>; Fri, 09 Jan 2026 18:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA8CB3027A11
	for <lists+linux-spi@lfdr.de>; Fri,  9 Jan 2026 17:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11D036AB49;
	Fri,  9 Jan 2026 17:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YUrGheo4"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C43366543
	for <linux-spi@vger.kernel.org>; Fri,  9 Jan 2026 17:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979120; cv=none; b=g2CW2z83JDVX+bGW3clGYaTjuJ+ZE8/xfuFUUEZWums+zv8AVQM24rz8cXC36Xax4/7AiZWOgLnOTcgT4SGsw8skPo5o4Qxke3xmOwUjDpJqIXAZkjtkrN5zLInMnVWQfKKlYYtpHfs7eLUBOAdlnjuLGat+w+2YcFc7HgLi2zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979120; c=relaxed/simple;
	bh=T5mrn5eLWK+kknNvL9a96ce7ZXaGz/rSrwm7+sg8ok8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cxeoi4TBA1bE5aLMy/tHtfAEFWampfm1KrQcBON73r3+FhAviG6bz4AZVxKZz7F2sqHIX3OKmTjUy3n415NQ04qyyRJOq9mDVl69xWut4TyOfuPz+qsAwEBgxvSYwgMF7VHCcGGZk94RqUZKJ52QCsGWMXk7Yk/w7hgpPDbWShs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YUrGheo4; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1E8ED1A2752;
	Fri,  9 Jan 2026 17:18:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E8E14606C6;
	Fri,  9 Jan 2026 17:18:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7AE04103C89B7;
	Fri,  9 Jan 2026 18:18:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767979116; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=H4b/jihKaaRHLMkQa+3eYNM0Q4yLDy5j6pgAhk5XWgM=;
	b=YUrGheo4NfMN+KwLPa9bufow95Bh6nbD05IRmxzugQI757sJkTwatnZbQgPrm9npkUFx08
	v5skf33y2p6bMeTPsAcJ5yNhHnv6H9SJOJYq+nAEg106k1T0jiq0qH0bIKNWRPpD25EWVw
	eQKeSss0SRyHfnHInRV/dlds3xuB0WY7ktwNWSuGTStrxcEQxd3Pel6YxuzfblOreU5kV9
	Ae21h5TaNClqk3vgECGA8YPnEAY4Dkgi282kEhNMxqmKcLzjv/HcImRZfE1ffP+7EovBe9
	LmixS/h0zKsi4IKFL0JYOAk4PJ9CQ7kXVP2vC1YlCDdkicpygNcGMm/M9kVsMg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 09 Jan 2026 18:18:13 +0100
Subject: [PATCH v2 15/27] mtd: spinand: macronix: Register vendor specific
 operation
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-winbond-v6-17-rc1-oddr-v2-15-1fff6a2ddb80@bootlin.com>
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

Provide the Macronix specific "read ECC status register" operation so
that the core can verify if it is supported by the controller before
using it.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/macronix.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index a847ea8f49a8..6b7cbcc6e287 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -47,6 +47,9 @@ static SPINAND_OP_VARIANTS(update_cache_variants,
 		   SPI_MEM_OP_DUMMY(1, 1),				\
 		   SPI_MEM_OP_DATA_IN(1, buf, 1))
 
+static SPINAND_OP_VARIANTS(macronix_ops,
+		SPINAND_MACRONIX_READ_ECCSR_1S_0_1S(NULL));
+
 static struct spi_mem_op
 spinand_fill_macronix_read_eccsr_op(struct spinand_device *spinand, void *valptr)
 {
@@ -174,6 +177,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status)),
 	SPINAND_INFO("MX35LF2GE4AB",
@@ -195,6 +199,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_CONT_READ(macronix_set_cont_read),
@@ -208,6 +213,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_CONT_READ(macronix_set_cont_read),
@@ -278,6 +284,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status)),
 	SPINAND_INFO("MX31UF1GE4BC",
@@ -288,6 +295,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status)),
 
@@ -301,6 +309,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT |
 		     SPINAND_HAS_PROG_PLANE_SELECT_BIT |
 		     SPINAND_HAS_READ_PLANE_SELECT_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status)),
 	SPINAND_INFO("MX35UF4G24AD",
@@ -312,6 +321,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT |
 		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
@@ -324,6 +334,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
@@ -336,6 +347,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_CONT_READ(macronix_set_cont_read),
@@ -351,6 +363,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT |
 		     SPINAND_HAS_PROG_PLANE_SELECT_BIT |
 		     SPINAND_HAS_READ_PLANE_SELECT_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status)),
 	SPINAND_INFO("MX35UF2G24AD",
@@ -362,6 +375,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT |
 		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
@@ -374,6 +388,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
@@ -386,6 +401,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_CONT_READ(macronix_set_cont_read),
@@ -399,6 +415,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_CONT_READ(macronix_set_cont_read)),
@@ -410,6 +427,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status)),
 	SPINAND_INFO("MX35UF1G24AD",
@@ -420,6 +438,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
@@ -432,6 +451,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_CONT_READ(macronix_set_cont_read),
@@ -445,6 +465,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_CONT_READ(macronix_set_cont_read)),
@@ -456,6 +477,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status)),
 	SPINAND_INFO("MX3UF2GE4BC",
@@ -466,6 +488,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status)),
 };

-- 
2.51.1


