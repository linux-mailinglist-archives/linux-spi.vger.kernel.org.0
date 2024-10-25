Return-Path: <linux-spi+bounces-5485-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 472669B098E
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 18:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D27202833A2
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 16:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FDE70831;
	Fri, 25 Oct 2024 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Br3FPHvU"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD02618785B
	for <linux-spi@vger.kernel.org>; Fri, 25 Oct 2024 16:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872927; cv=none; b=i1onLpekSPO13CXcDqOB0Jl0Bp/Wvc/M+ocxGLWOg+wx+ZnfneY7QP3HoPu24FDd/zZj/WOTu8zz7HmcNQVhf6XsZ0Iz6ySmwJ8JPniqTWKluawNkvQ/cXRhRe2nfnnoLaHygRlV8hTBvan72WwwagA6qWSG9nzyA8Gy3jU1LFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872927; c=relaxed/simple;
	bh=ayuZww2xmMq2WNn+8zZ/dAc1O62fPwUm+L0H4td9dOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+EGotunYmOhZVXfNy+NlaPT0Q/i5HTVrfTL8GkZAyLVZLthBQ52njx5fM1X0FRcBg3KFPbb1reMxjB+Qc6JEZ3gLMV/itAjrDafjxv4pG+xTtngt+mhudu1bvaME4aoUKSS6UELwTKCDDlkdKOw4tArOKDDimr5LK/RJ86YZcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Br3FPHvU; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7FD80E0004;
	Fri, 25 Oct 2024 16:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729872922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MI8blDE2jqlm4lBzrGKhLxjhDMkMQ6wv2gYX7FnoaQ0=;
	b=Br3FPHvUGmcmT5l6SvlOHDcgT6kzPXnvjF39ghi/4URmH+rZUumOR7/B0PqwM2Ixlm8hMw
	CJE/HIc1SKW+QeMdzRmaSWI6IocAglbbgunQQYE2gKo1My2lWeMMAYg1EGlG7tWHQhi+PA
	y5ohAGhnRTxBVVMyJrtLpnn72qQLlxKqmeDvjdxVpxTQa8nTuZEazX5r6NJt3o1mpL9qE/
	OuOnftEzWtFYNDpZRd/M7dcneQpiZ6+PBxK+qw4mCVS3C/DLNfreeECSSPRAH0sF3+A1A3
	Fa511ySvE+Y2E5fih9Lhh2ipNJ7xOdsmCnugsneoiYIPdjHmMljjcauw4+8+zA==
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
Subject: [PATCH 17/24] mtd: spinand: Create distinct fast and slow read from cache variants
Date: Fri, 25 Oct 2024 18:14:54 +0200
Message-ID: <20241025161501.485684-18-miquel.raynal@bootlin.com>
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

So far, the SPINAND_PAGE_READ_FROM_CACHE_OP macro was taking a first
argument, "fast", which was inducing the possibility to support higher
bus frequencies than with the normal (slower) read from cache
alternative. In practice, without frequency change on the bus, this was
likely without effect, besides perhaps allowing another variant of the
same command, that could run at the default highest speed. If we want to
support this fully, we need to add a frequency parameter to the slowest
command. But before we do that, let's drop the "fast" boolean from the
macro and duplicate it, this will further help supporting having
different frequencies allowed for each variant.

The change is also of course propagated to all users. It has the nice
effect to have all macros aligned on the same pattern.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/alliancememory.c |  4 ++--
 drivers/mtd/nand/spi/ato.c            |  4 ++--
 drivers/mtd/nand/spi/esmt.c           |  4 ++--
 drivers/mtd/nand/spi/foresee.c        |  4 ++--
 drivers/mtd/nand/spi/gigadevice.c     | 16 ++++++++--------
 drivers/mtd/nand/spi/macronix.c       |  4 ++--
 drivers/mtd/nand/spi/micron.c         |  8 ++++----
 drivers/mtd/nand/spi/paragon.c        |  4 ++--
 drivers/mtd/nand/spi/toshiba.c        |  4 ++--
 drivers/mtd/nand/spi/winbond.c        |  4 ++--
 drivers/mtd/nand/spi/xtx.c            |  4 ++--
 include/linux/mtd/spinand.h           | 20 ++++++++++++++++----
 12 files changed, 46 insertions(+), 34 deletions(-)

diff --git a/drivers/mtd/nand/spi/alliancememory.c b/drivers/mtd/nand/spi/alliancememory.c
index 7936ea546b03..6046c73f8424 100644
--- a/drivers/mtd/nand/spi/alliancememory.c
+++ b/drivers/mtd/nand/spi/alliancememory.c
@@ -21,8 +21,8 @@ static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
 			   SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
diff --git a/drivers/mtd/nand/spi/ato.c b/drivers/mtd/nand/spi/ato.c
index 82b377c06812..bb5298911137 100644
--- a/drivers/mtd/nand/spi/ato.c
+++ b/drivers/mtd/nand/spi/ato.c
@@ -15,8 +15,8 @@
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
 		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
diff --git a/drivers/mtd/nand/spi/esmt.c b/drivers/mtd/nand/spi/esmt.c
index 4597a82de23a..323a20901fc9 100644
--- a/drivers/mtd/nand/spi/esmt.c
+++ b/drivers/mtd/nand/spi/esmt.c
@@ -15,8 +15,8 @@
 static SPINAND_OP_VARIANTS(read_cache_variants,
 			   SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
 			   SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-			   SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
-			   SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+			   SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(0, 1, NULL, 0),
+			   SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
 			   SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
diff --git a/drivers/mtd/nand/spi/foresee.c b/drivers/mtd/nand/spi/foresee.c
index e0d2d9257045..cb5c9e0517ea 100644
--- a/drivers/mtd/nand/spi/foresee.c
+++ b/drivers/mtd/nand/spi/foresee.c
@@ -14,8 +14,8 @@
 static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
 		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
diff --git a/drivers/mtd/nand/spi/gigadevice.c b/drivers/mtd/nand/spi/gigadevice.c
index 6023cba748bb..d620bb02a20a 100644
--- a/drivers/mtd/nand/spi/gigadevice.c
+++ b/drivers/mtd/nand/spi/gigadevice.c
@@ -28,32 +28,32 @@ static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(read_cache_variants_f,
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP_3A(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X2_OP_3A(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP_3A(true, 0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP_3A(false, 0, 0, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_OP_3A(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP_3A(0, 0, NULL, 0));
 
 static SPINAND_OP_VARIANTS(read_cache_variants_1gq5,
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(read_cache_variants_2gq5,
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 4, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 2, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
 		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index 3f9e9c572854..53e3ec38ef9f 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -15,8 +15,8 @@
 static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
 		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 12601bc4227a..ad0bb9755a09 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -33,8 +33,8 @@ static SPINAND_OP_VARIANTS(quadio_read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(x4_write_cache_variants,
 		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
@@ -48,8 +48,8 @@ static SPINAND_OP_VARIANTS(x4_update_cache_variants,
 static SPINAND_OP_VARIANTS(x4_read_cache_variants,
 			   SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
 			   SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-			   SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
-			   SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+			   SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(0, 1, NULL, 0),
+			   SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(x1_write_cache_variants,
 			   SPINAND_PROG_LOAD(true, 0, NULL, 0));
diff --git a/drivers/mtd/nand/spi/paragon.c b/drivers/mtd/nand/spi/paragon.c
index 519ade513c1f..6e7cc6995380 100644
--- a/drivers/mtd/nand/spi/paragon.c
+++ b/drivers/mtd/nand/spi/paragon.c
@@ -26,8 +26,8 @@ static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
 		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
index bbbcaa87c0bc..2e2106b2705f 100644
--- a/drivers/mtd/nand/spi/toshiba.c
+++ b/drivers/mtd/nand/spi/toshiba.c
@@ -17,8 +17,8 @@
 static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_x4_variants,
 		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index e472d0f692c2..329377bf3717 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -22,8 +22,8 @@ static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
 		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
diff --git a/drivers/mtd/nand/spi/xtx.c b/drivers/mtd/nand/spi/xtx.c
index 66a4255bdf06..3f539ca0de86 100644
--- a/drivers/mtd/nand/spi/xtx.c
+++ b/drivers/mtd/nand/spi/xtx.c
@@ -27,8 +27,8 @@ static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
 		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 5c19ead60499..3730cdf914f8 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -62,14 +62,26 @@
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_NO_DATA)
 
-#define SPINAND_PAGE_READ_FROM_CACHE_OP(fast, addr, ndummy, buf, len)	\
-	SPI_MEM_OP(SPI_MEM_OP_CMD(fast ? 0x0b : 0x03, 1),		\
+#define SPINAND_PAGE_READ_FROM_CACHE_OP(addr, ndummy, buf, len) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),				\
 		   SPI_MEM_OP_ADDR(2, addr, 1),				\
 		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
 		   SPI_MEM_OP_DATA_IN(len, buf, 1))
 
-#define SPINAND_PAGE_READ_FROM_CACHE_OP_3A(fast, addr, ndummy, buf, len) \
-	SPI_MEM_OP(SPI_MEM_OP_CMD(fast ? 0x0b : 0x03, 1),		\
+#define SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(addr, ndummy, buf, len) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x0b, 1),			\
+			 SPI_MEM_OP_ADDR(2, addr, 1),			\
+			 SPI_MEM_OP_DUMMY(ndummy, 1),			\
+			 SPI_MEM_OP_DATA_IN(len, buf, 1))
+
+#define SPINAND_PAGE_READ_FROM_CACHE_OP_3A(addr, ndummy, buf, len) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),				\
+		   SPI_MEM_OP_ADDR(3, addr, 1),				\
+		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
+		   SPI_MEM_OP_DATA_IN(len, buf, 1))
+
+#define SPINAND_PAGE_READ_FROM_CACHE_FAST_OP_3A(addr, ndummy, buf, len) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x0b, 1),				\
 		   SPI_MEM_OP_ADDR(3, addr, 1),				\
 		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
 		   SPI_MEM_OP_DATA_IN(len, buf, 1))
-- 
2.43.0


