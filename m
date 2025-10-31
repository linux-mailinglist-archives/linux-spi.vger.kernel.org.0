Return-Path: <linux-spi+bounces-10957-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5E4C26638
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 18:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B7EA4FAB49
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 17:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6546354AFC;
	Fri, 31 Oct 2025 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rwSz6Vkb"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A0B351FB9;
	Fri, 31 Oct 2025 17:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931720; cv=none; b=rITdJdgTkAUk58gfaJIXSYSeFjwHRdrQsBAIHNffzLkxJxBr8g4P2ah1Ahq15ukzByzUq9FcT1D2oG4IuazQfN1yRd7S/RQhYrX/bRFH9x0k0FkUpH1dJHKSvDASlSKoHeA957fblRXQ7uFeEC4KUC1CvZ62jbqwmFa6kZhL2Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931720; c=relaxed/simple;
	bh=UZHRF27En+zsCs8vMqc7Q9eAF5nNS57+m2aqEESwh/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lvNm59RDmjP0y2ElnTfAFLk2Wo8OzTRFu7lBmmFAn7OA3uLtYIwqqNue2md73Cd6E4pTBBMOvU1LSsImi7ZeBy8bfMGPbl4508/Z0EQqNsLNzIh6GLfQpyLJ/LV/G4JG4HkcbBDxgNskNcVBNs/1xKuP1f+AKJ7iPJo77gn4U2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rwSz6Vkb; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A8FA94E41434;
	Fri, 31 Oct 2025 17:28:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8043E60704;
	Fri, 31 Oct 2025 17:28:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 07F311181800B;
	Fri, 31 Oct 2025 18:28:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761931716; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YwdHq0kXuW83TPzSi0AdbC2T+tsymu7wdChzedkkepA=;
	b=rwSz6VkbJ8BeEwaHaLBJ4x9IeS5VgVVviBj3M0h1uoTERcC83xmMtIGaJdC80qe/dHwSc3
	CmcpbJSAEQcq2W36x/GefC4omRghnWshMWt8+t0qAZTqEt5L+TkLTLhRCee5DX6J9DpFzH
	uKXWbUgLH5Hgrpc5cjRv7kb0E1lK5OrbRhKtS8hU0A3Tk6lKkX/JN721RqQXVuEvmeWw/Q
	/zI4iQBi4ousSCGPE0I3bUT0bYd4bLXuIxf6K8yqmj1OuJXsA3dsypgXQv+RHb9U1wFzsI
	RsWmY526HllUZCu7CIVeYLg2Z2eGgWeQeIRVI+Wn848DavF7rrItrIfoW60Mkw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 31 Oct 2025 18:27:04 +0100
Subject: [PATCH 20/28] mtd: spinand: winbond: Rename IO_MODE register macro
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-winbond-v6-17-rc1-oddr-v1-20-be42de23ebf1@bootlin.com>
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

Suffix the macro name with *_REG to align with the rest of the driver.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/winbond.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 7eade2251f7b5b2a96c0a7528ca6d64ba6d8233e..b169636376835157c64bce17a4f32549e1c1eb9f 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -22,7 +22,7 @@
 #define W25N0XJW_SR4			0xD0
 #define W25N0XJW_SR4_HS			BIT(2)
 
-#define W35N01JW_VCR_IO_MODE			0x00
+#define W35N01JW_VCR_IO_MODE_REG	0x00
 #define W35N01JW_VCR_IO_MODE_SINGLE_SDR		0xFF
 #define W35N01JW_VCR_IO_MODE_OCTAL_SDR		0xDF
 #define W35N01JW_VCR_IO_MODE_OCTAL_DDR_DS	0xE7
@@ -392,7 +392,7 @@ static int w35n0xjw_vcr_cfg(struct spinand_device *spinand)
 	else
 		return -EINVAL;
 
-	ret = w35n0xjw_write_vcr(spinand, W35N01JW_VCR_IO_MODE, io_mode);
+	ret = w35n0xjw_write_vcr(spinand, W35N01JW_VCR_IO_MODE_REG, io_mode);
 	if (ret)
 		return ret;
 

-- 
2.51.0


