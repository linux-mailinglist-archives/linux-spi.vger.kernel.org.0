Return-Path: <linux-spi+bounces-12244-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F68D0B97E
	for <lists+linux-spi@lfdr.de>; Fri, 09 Jan 2026 18:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 850AE3040213
	for <lists+linux-spi@lfdr.de>; Fri,  9 Jan 2026 17:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E37D365A13;
	Fri,  9 Jan 2026 17:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fZkuhbyn"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5E33659F0
	for <linux-spi@vger.kernel.org>; Fri,  9 Jan 2026 17:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979105; cv=none; b=UM+L6959VI+aseWyHfxlKSHb6sHOgV8mv3iBWicLf5q0Pw0lSjdWMIkBAYApbl1Lq8mb4e9MIuLl/v8JwaBxGBEw3Jk+H2moPoruMYLjIxlj8fB6DQTFD9W/yPJvGEsgzvnR4nS3+bqy2b9SzrKdNRWVp6lGze+dnWMAZf3O93w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979105; c=relaxed/simple;
	bh=L+WFaZEg4oo76+avTtmBhbTWOBzmGBPkcF+3yacI8mI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WFkvE6GxlspZr+7CUbc172Wy9iXotyLsLTncYI4KU9yz4VPqz/iKOztR8H3mvN79MF8rLTuRYXBjzwgIzv+3KtimVqHwjsOKBj/bHY/Bs/KhuJWiJDppPtTm4p4O+Cuj/lM6oHtIpFltVNDelLSD1lygh1FEBSTvwbBa2E0zo/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fZkuhbyn; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C23841A2753;
	Fri,  9 Jan 2026 17:18:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 988A9606C6;
	Fri,  9 Jan 2026 17:18:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 06108103C89AD;
	Fri,  9 Jan 2026 18:18:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767979100; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TdRhJU2g1aCtWJB6jVyDXMoLZUtYtJ3QCG7nSo0yd9g=;
	b=fZkuhbynJrZvzxDpARwKOTLI3aT3fjUyhlxHsZ06G115O4FLa1GKpHCfaXHScGSyaI9wck
	aLA61q9c2slPTNSddPoe8ODdLC4Oen3wdse/fMEAArrNSDuJxV5YUdpRCoZ5C2n6h7oVzQ
	KEEJCox7EXLcRnorC/jUkUeFyFZ9lAOO/NFTSdfEvg0Zb3YncDOEjtAU4mqd8OL5lC+pvT
	NuaIM87WIJwreaivgtDkddUZK9ACL4LaUo5JF5j6d7sqX2SZKNHoOCJN2oIrmcRzpU+DRB
	5wW/hjSx3j4YNEo4JLAUmfWHwPOHF6lAAfB7k0UzYkzbGXUe9BWHBS2AyjKveg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 09 Jan 2026 18:18:00 +0100
Subject: [PATCH v2 02/27] spi: spi-mem: Create a repeated address operation
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-winbond-v6-17-rc1-oddr-v2-2-1fff6a2ddb80@bootlin.com>
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

In octal DTR mode addresses may either be long enough to cover at least
two bytes (in which case the existing macro works), or otherwise for
single byte addresses, the byte must also be duplicated and sent twice:
on each front of the clock.

Create a macro for this common case.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/linux/spi/spi-mem.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 81c9c7e793b6..e4db0924898c 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -43,6 +43,14 @@
 		.dtr = true,					\
 	}
 
+#define SPI_MEM_DTR_OP_RPT_ADDR(__val, __buswidth)		\
+	{							\
+		.nbytes = 2,					\
+		.val = __val | __val << 8,			\
+		.buswidth = __buswidth,				\
+		.dtr = true,					\
+	}
+
 #define SPI_MEM_OP_NO_ADDR	{ }
 
 #define SPI_MEM_OP_DUMMY(__nbytes, __buswidth)			\

-- 
2.51.1


