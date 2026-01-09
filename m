Return-Path: <linux-spi+bounces-12261-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C440BD0BA08
	for <lists+linux-spi@lfdr.de>; Fri, 09 Jan 2026 18:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB8D730D3320
	for <lists+linux-spi@lfdr.de>; Fri,  9 Jan 2026 17:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9200036BCE8;
	Fri,  9 Jan 2026 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="V8rJzHi9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C47636AB76
	for <linux-spi@vger.kernel.org>; Fri,  9 Jan 2026 17:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979126; cv=none; b=NwEjAvmuTBS2H5XgMWcAFrsUXlz0WOiLn8A9rdmgcVS52KABn7scPJZz2OSQgE6NpAEICfYCxGIfdk2Trt+dKo8AUrF5JtIVdKt/jOz9SW5RjsFWeajiN3Vs8U4GTeT4VeFHdeyvUvaR0mUqmFAXxEYVlauIFKH2vup7q5jk2HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979126; c=relaxed/simple;
	bh=BV8D7nBZkFVhYpQyKB0DGYiE68OVjWx/XnDOI3/F8wY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qr/guAqh/wktc/sNnRiFEXHazULHpzTOSvBzHIaRR71Uu5+jjSZCeLGVDDe1SLtBf7m+dvkrgJ8GF5uWBFL08YMWVkmX75rwSoWum1AwA/vUdfyVszKPH1pUPmJU7J9zW6MGM6V2OLP8HGVpli/FPxtVoigK/8xmtmWPxkKxYWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=V8rJzHi9; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id AFEB5C1F6E6;
	Fri,  9 Jan 2026 17:18:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0426D606C6;
	Fri,  9 Jan 2026 17:18:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 542E4103C89BB;
	Fri,  9 Jan 2026 18:18:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767979121; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6HYIcnqwyFWxHq3DkqAqIbtZT7IZvCykXnPBw3eNAvA=;
	b=V8rJzHi926cmEs6Gy53noktAnngb4K3uRi6ofuWB8Sort6rU+WndQ4GbUql4ZuEhdOvnIZ
	y8u5z9GJePmW3A+ZiCM8ABQcD+dJsZkUP8BLZM2agaakpgN+xl7sMisaV9fJTd2cXImy9b
	Mdt0G8FFASpZuEKnBn9+InEVZvpAv4l2mQaeZhacHXfnKmR7nrqnvEMjzznV10QNWWJ89+
	nkEvX7DZuK3NgWDSkPNfVv6+vaxdjCOPP0sMlxA1nWo0h2xjWrKq6QuDJfbUqT1josmX8u
	lYP2M8i3FCFE55oqTSj/ADsqA/UqZjTJYJfBkcb23UAdhDVj/QGgWsq1EfMZIg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 09 Jan 2026 18:18:17 +0100
Subject: [PATCH v2 19/27] mtd: spinand: winbond: Rename IO_MODE register
 macro
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-winbond-v6-17-rc1-oddr-v2-19-1fff6a2ddb80@bootlin.com>
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

Suffix the macro name with *_REG to align with the rest of the driver.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/winbond.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 7eade2251f7b..b16963637683 100644
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
2.51.1


