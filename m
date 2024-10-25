Return-Path: <linux-spi+bounces-5486-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCDB9B098F
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 18:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DFD51C231FC
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 16:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7A518785B;
	Fri, 25 Oct 2024 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="D7+5mePw"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E547082B
	for <linux-spi@vger.kernel.org>; Fri, 25 Oct 2024 16:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872928; cv=none; b=mdv81E+LEwR5ZhBHHehxsy7qMnL6IbsiJrrCL95B883lhdzIcnDRDP2wFxGQ2mYTTzHuj99vLsIDMc+owx7fe7chvOOfTJ3pjVPYd/QfsEMLDrhuCpkQJlx4oSGw51f+agskBrSyfvdVUSW5Su8m8h3eMdpJyXmuT8wMFqX4Z6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872928; c=relaxed/simple;
	bh=JwyU5+JQro1yWmToy0KxjSOKCyD3V946ElpXxNu0oDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLeah0GuBhwI0iFm3zjZG4co+lEKZEwW7ENQDzoe7wdynEECJ96R8iS7rw4cHUtjfOxv+J/0frmBTTIMGj4d6E7IdrrPtw9S3dFQmLEDtm77P4MhYhOe9yrAWNi3JNpAJRAMhoAe2aXRiL9qMoK5wURd0kh7tqx4+ECmnDVN2Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=D7+5mePw; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A3229E000D;
	Fri, 25 Oct 2024 16:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729872923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FkvuH0AWdcL0zGrECt5K+wtClopnb+WgibOUAQNP4l4=;
	b=D7+5mePwAHc+DAdMGKrs42INvoZ1kL3wuLSrf5+dCnkxyXujRtp8m4hWERlmfQ/pMra7SE
	joAqZmLUG2Q+BfvbfafSJXkThkRFAW5Hly+OwbmHJnMPbQ7BiLbASNz9m8xXutShyfYNhx
	Et1mu+LLGoWd9Hh2l0JDnqgxwjA7qbciZ3dJKVpRwDtggr0ZFV63ykGZShHypCIc1kd8MN
	4qBLuJPksLDx1owGmS8wrPUgzBB1F0kYY1/0J0uatjs6a9gbowhdcYEsZECFXOFpIhy4fy
	yyF6M5P3N2zbI3G+DIn7OxRYTX+wr3x0d8j1YcSME2NLw3K0SoaN5BViAiVPcQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>
Cc: Mark Brown <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>,
	Steam Lin <stlin2@winbond.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Sanjay R Mehta <sanju.mehta@amd.com>,
	Han Xu <han.xu@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Michal Simek <michal.simek@amd.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 18/24] mtd: spinand: Add an optional frequency to read from cache macros
Date: Fri, 25 Oct 2024 18:14:55 +0200
Message-ID: <20241025161501.485684-19-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241025161501.485684-1-miquel.raynal@bootlin.com>
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

While the SPINAND_PAGE_READ_FROM_CACHE_FAST_OP macro is supposed to be
able to run at the highest supported frequency, it is not the case of
the regular read from cache, which may be limited in terms of maximum
frequency. Add an optional argument to this macro, which will be used to
set the maximum frequency, if any.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/linux/mtd/spinand.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 3730cdf914f8..6064029c5e05 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -62,11 +62,12 @@
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_NO_DATA)
 
-#define SPINAND_PAGE_READ_FROM_CACHE_OP(addr, ndummy, buf, len) \
+#define SPINAND_PAGE_READ_FROM_CACHE_OP(addr, ndummy, buf, len, ...) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),				\
 		   SPI_MEM_OP_ADDR(2, addr, 1),				\
 		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
-		   SPI_MEM_OP_DATA_IN(len, buf, 1))
+		   SPI_MEM_OP_DATA_IN(len, buf, 1),			\
+		   __VA_OPT__(SPI_MEM_OP_MAX_FREQ(__VA_ARGS__)))
 
 #define SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(addr, ndummy, buf, len) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x0b, 1),			\
-- 
2.43.0


