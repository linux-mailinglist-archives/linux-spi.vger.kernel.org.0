Return-Path: <linux-spi+bounces-5489-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 382E99B0991
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 18:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A091C232DB
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 16:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F70188588;
	Fri, 25 Oct 2024 16:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="S+w1Hwv/"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4047082B
	for <linux-spi@vger.kernel.org>; Fri, 25 Oct 2024 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872930; cv=none; b=St8v2pkNV1pVnEuZ3SMJw8LiaNKa9aGGNHjXIfTKN/4TvxGORfZYAII78lWnGbcjxbcpGT/72G3XHxLYlY22NvrX4hx798456sQhbzT66pQU+stEsSD4jGUf3LLlrraUfC+eACHcPDK+Dlzxg0fbfu/yW0horffSr1E4/SVyRp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872930; c=relaxed/simple;
	bh=bQrbu6pJB7Gqb2YsduL7JRIT54WhjJofGtvgJz1/fY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wb5UdFZngMBKBSIGqFMK1tj/4KuIymCGUeJOafWeAI/W6N3UF1i3Yb36VHc5cPSu/nEqA6dm6i3RYkk+tYiBMayS3uzAiHCLYDcPsHBGS1CyM4yn38h/dApEA8TCeChXyshGaGk+/zEQ7oDY3jTX07OZkGeUb7TrnBKwcXBDU8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=S+w1Hwv/; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AFD4AE0005;
	Fri, 25 Oct 2024 16:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729872924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gP/qcdb5gg8KjdWKCoDKUL1fJp7AcT58aQ8bLIsoI4k=;
	b=S+w1Hwv/fKN1ElmR9O5xc2uFOUZ31/oOHy5biHeSUnEMzALff1tOvwYiMxRQnU6t/9Mw7z
	nx8mLEm88VZfrOYyJKQ3zZMB26ZyIOO9Ir+Muj8ENUXFlcVJs7P6NDexFsmVkIFpchr7/V
	gyovMfC7O7/cSWN8pmGUNELYh+MvHAfG+sPb3imx6ZD7YuhWihtfwosj7m+Y7hF1YTdD7h
	2bX8m/zCCsxrtKz1rmo6ILYvJ+C0EOLCA3RxDet23qNq1APz/4QLW//d8aTO/LDmfENrPo
	KvWCrDd0vKqxxt9/+WA/XmqqkWKd3kKUCS7C6LFLKkKSsBaiBlBQk3bW29GCvQ==
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
Subject: [PATCH 19/24] mtd: spinand: winbond: Fix the *JW chip definitions
Date: Fri, 25 Oct 2024 18:14:56 +0200
Message-ID: <20241025161501.485684-20-miquel.raynal@bootlin.com>
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

W25N01JW and W25N02JW use a different technology with higher frequencies
supported (up to 166MHz). There is one drawback though, the slowest
READ_FROM_CACHE command cannot run above 54MHz. Because of that, we need
to set a limit for these chips on the basic READ_FROM_CACHE variant.

Duplicating this list is not a problem because these chips have DTR
support, and the list of supported variants will diverge from all the
other chips when adding support for it.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/winbond.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 329377bf3717..686e872fe0ff 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -10,6 +10,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/mtd/spinand.h>
+#include <linux/units.h>
 
 #define SPINAND_MFR_WINBOND		0xEF
 
@@ -17,6 +18,14 @@
 
 #define W25N04KV_STATUS_ECC_5_8_BITFLIPS	(3 << 4)
 
+static SPINAND_OP_VARIANTS(read_cache_dtr_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0, 54 * HZ_PER_MHZ));
+
 static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
@@ -177,7 +186,7 @@ static const struct spinand_info winbond_spinand_table[] = {
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xbc, 0x21),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(1, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_dtr_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
@@ -197,7 +206,7 @@ static const struct spinand_info winbond_spinand_table[] = {
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xbf, 0x22),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 2, 1),
 		     NAND_ECCREQ(1, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_dtr_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-- 
2.43.0


