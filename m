Return-Path: <linux-spi+bounces-10937-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1E6C26581
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 18:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007971A65E7E
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 17:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137FE30BB93;
	Fri, 31 Oct 2025 17:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0mbD0KPT"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BB9309F02;
	Fri, 31 Oct 2025 17:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931696; cv=none; b=Fd4HC8j2DZk5zPoiHoWAbyZa0WUWiWfvZuE809AP0hNcLu64QvuruqKpfwBRs7SAGBeRGqjhHpnmAu4Bwfk91q45oBorAd1mOuJoTcddYasnrSxNe5CLfMjAiixTt08ymdRgyt40jRtcySEvrvh8jtXpiRaqSJuLsGOhD5v8MD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931696; c=relaxed/simple;
	bh=mX89eJtEOIjPqb5TiEEkJfU1H4NCQ2v2Gs/X8mYcvyA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fF1Icdk8q23qbjBua/f3VdRYo5NSfeq8HncKxtFwIV8IxxC6LsyEB+j0FbymgEra4PgYZhTZ3LLg8jdxAQyXMpyYc3OqOZVmfrRfS1YcRUbWlE10MGzUk5xDhBsIGAjXSqZUXTMNgL7wpim0OCNcjQmP72JrDysa0OxMDNSziVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0mbD0KPT; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3706D4E4143C;
	Fri, 31 Oct 2025 17:28:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0816960704;
	Fri, 31 Oct 2025 17:28:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4C8051181800A;
	Fri, 31 Oct 2025 18:28:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761931691; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=oHqEV/g7XFmkq0UzLPDeIwZV/fV2EtIfxTRhi9zC2G8=;
	b=0mbD0KPT1S8Q8Ue7MzvbGhBFxqwNL0QzL4nZpL1eCu8ne+RM5g7oXJQ81BjqMRAwz9sQNa
	795Rb2z5UWU7jG0/k+L2EIsv6F3Np+Cu6v2t/7Vhk/DgLya4NtZpE3Cl4hEDJPGLqjtm7W
	qapdOmzpQLDdwqk2nJfCTlYNrqRkKSGnZbDJijg9cWfmyZn/e5bdworZewV8jnjaqOxIgf
	POLdpIv6/LQOZmCbIgvPc98ixwurVTCmdcZ/Ci2JrzwYeHKnYixxvaA3AoXnPm5fUbmftY
	QuVSl9E7peBkcYcaUV96Rmdlg5pfj1FecEqsfwtM+GVqJd0veK/WDajA5R5gqQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 31 Oct 2025 18:26:45 +0100
Subject: [PATCH 01/28] spi: spi-mem: Make the DTR command operation macro
 more suitable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-winbond-v6-17-rc1-oddr-v1-1-be42de23ebf1@bootlin.com>
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

In order to introduce DTR support in SPI NAND, a number of macros had to
be created in the spi-mem layer. One of them remained unused at this
point, SPI_MEM_DTR_OP_CMD. Being in the process of introducing octal DTR
support now, experience shows that as-is the macro is not useful. In
order to be really useful in octal DTR mode, the command opcode (one
byte) must always be transmitted on the 8 data lines on both the rising
and falling edge of the clock. Align the macro with the real needs by
duplicating the opcode in the buffer and doubling its size.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/linux/spi/spi-mem.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 82390712794c5a4dcef1319c19d74b77b6e1e724..81c9c7e793b6ab894675e0198d412d84b8525c2e 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -20,10 +20,10 @@
 		.opcode = __opcode,				\
 	}
 
-#define SPI_MEM_DTR_OP_CMD(__opcode, __buswidth)		\
+#define SPI_MEM_DTR_OP_RPT_CMD(__opcode, __buswidth)		\
 	{							\
-		.nbytes = 1,					\
-		.opcode = __opcode,				\
+		.nbytes = 2,					\
+		.opcode = __opcode | __opcode << 8,		\
 		.buswidth = __buswidth,				\
 		.dtr = true,					\
 	}

-- 
2.51.0


