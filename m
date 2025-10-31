Return-Path: <linux-spi+bounces-10943-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD09C265A5
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 18:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99CA6401498
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 17:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C33343D7C;
	Fri, 31 Oct 2025 17:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="df5R4CGM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292D8309EF4;
	Fri, 31 Oct 2025 17:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931701; cv=none; b=oXI+Nco67l5fUswTzf+Rdbnz27SQqqiUYL0/foejA7+s/Vf9pLjGV7fB75L3pVnxUyiXnuPabQ7w9fplXpoQWUmm5hcy81mudw+4P0T8HCBH4MY8QdDFHPGB1PGZWkkUVhMxuwXPyiixDLuYQtFGITUzIT+ZAUM8C8cvo5rbhNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931701; c=relaxed/simple;
	bh=K31AbGtb6456muVxrIlDCmYc3I9jukAaBIq1mP4VODQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A8CbGJjF8SG8qUyTBjfZq88fnuitxtzQ7W+I6tBucVKQk6qVugeaxmmtMxY3tDTMOYcTKaEbrHH+WyDOpws6nhxOsGgk0ha3x3WYrBlyrhorak1ltmwOt2WgN8TYbGVKA7k67scfmx98cJ6joI5OuM6H271EI1l0DY0HESZkfrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=df5R4CGM; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 99B1B1A17C4;
	Fri, 31 Oct 2025 17:28:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6ABFC60704;
	Fri, 31 Oct 2025 17:28:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A31A11181800B;
	Fri, 31 Oct 2025 18:28:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761931697; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=mLluG8puW16khAmDrjVJJH9/M5suelfU9smry8s1GdM=;
	b=df5R4CGMI5w+5S/Z1v/u2Gi7kUW5QflghJ+N20juWOd0iMxYA/KwG0RmviiS7FBA35ykd4
	JM1hMETT2xQzj4vPBWlKZD4N8OXTZW7OhalguaA0xHUVKrpWpgaZgWD+O5EQbxLElZkLHE
	vKHwYZH49VuwvZY+tDHIxm98v62fdtKzZujGEIIN/JbQkCRlKIXnTHpBABlrG0QJn31rfZ
	Pv+ZY3WkzYtRn+1Pwao/z6tSyPNlNPe7iYCBxjFHPSvVLmIVoUNOXC/GCMjALPjWxmAuvc
	/IAN5400v4+OmsI3z9aPYui3NJoyhfP3UD/Z5p3cvCW+uip32lvV3cm1C3cIZQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 31 Oct 2025 18:26:50 +0100
Subject: [PATCH 06/28] mtd: spinand: Remove stale definitions
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-winbond-v6-17-rc1-oddr-v1-6-be42de23ebf1@bootlin.com>
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

SPI NAND command values are directly included in the macros defining the
ops. These are stale definitions, they are unused so drop them.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/linux/mtd/spinand.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 1c741145e49717169152854718f784e0e519ea92..731a3156b2577032e1f9a767044f94aa262c3ec0 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -232,12 +232,6 @@
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_DATA_OUT(len, buf, 8))
 
-/**
- * Standard SPI NAND flash commands
- */
-#define SPINAND_CMD_PROG_LOAD_X4		0x32
-#define SPINAND_CMD_PROG_LOAD_RDM_DATA_X4	0x34
-
 /* feature register */
 #define REG_BLOCK_LOCK		0xa0
 #define BL_ALL_UNLOCKED		0x00

-- 
2.51.0


