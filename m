Return-Path: <linux-spi+bounces-8638-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEDFADEBAD
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 14:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF48A16A8F7
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 12:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675A62E9ECE;
	Wed, 18 Jun 2025 12:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="osH0omy9"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84042E8DF9;
	Wed, 18 Jun 2025 12:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750248943; cv=none; b=Sp5Lm4ywb23z4XdEfbQHrns8lk3yB/+4vLklqUwEf4DFmhpr8/+AZmheQRS6PwDZqcqG6MbCaMfM3eFFvoW0HUtpP8La1kp40Bk6v2x4a8Rwlz1vv4ZBvwgpMUhNTMwzr2WFu+In3DISVx1BzN5FlZzvXCf1OWIrjgctGec3DBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750248943; c=relaxed/simple;
	bh=E6+erwMn29YSRf3qONAPJ8CIT/vPY1f8rDKGW3Z+tVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eMU72MFP2fmllkJiDSL7PUVqIuCyn5GFL58KhgS0a3CA53kmXytYStz9F8znYOCXZUTgFhQ2DhnxFsDcJUdbe1Un7c3JCxhoB/RHFnjxdAfeetqiPisS/XSWN9P1vz+E8wurvyG9HOFxJdbp5g0P0iqbO8CT+sqPdeh6BdOfz0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=osH0omy9; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 72BE743859;
	Wed, 18 Jun 2025 12:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750248937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VDNWc8C/6872zJbiaheKTU8yK/HnWLriIlMksb1OGDo=;
	b=osH0omy9LQIH3fSwHsZH4Ux+rB+oNOv6Dr+Tcb7fTMILEVf4vTfZLpnKkfp2NAxe/RGUEd
	hRBH3HWBFiCouTM4nR6MzPhDaWKSF+u7mDJedXNgAOexHWglBI3RDbZZe+0PqBOob6LVHK
	7rKEIVk+81w1UfIxq3Cz3O5ZmxplNMZph3aL5WhtQu61xqdDaGFEr4SGIwTk6YjlJRwTK9
	bGiwT/G2PS3KWfLc54mpdbWBDoBxXKB8D6Z6jtFKjLkvYb+90/apsqOeEVPM+IJ1pbI7Yf
	hbFsXqWFEZJdSrWH47CDpEe0z+n7lxCd4uVE3JSXCa6EhQW4NOuB464HMZvhEw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 18 Jun 2025 14:14:21 +0200
Subject: [PATCH 4/8] mtd: spinand: Add a frequency field to all
 READ_FROM_CACHE variants
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-winbond-6-16-rc1-octal-phy-upstream-v1-4-513202126013@bootlin.com>
References: <20250618-winbond-6-16-rc1-octal-phy-upstream-v1-0-513202126013@bootlin.com>
In-Reply-To: <20250618-winbond-6-16-rc1-octal-phy-upstream-v1-0-513202126013@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Yogesh S <yogeshs@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Steam Lin <STLin2@winbond.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvieduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelgfehvdduieefieeikeffgffggfdttdeugeffieetheeuleelfeehffdtffetveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrgeeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeihohhgvghshhhssehtihdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtp
 hhtthhopehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepuffvnfhinhdvseifihhnsghonhgurdgtohhmpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrgh
X-GND-Sasl: miquel.raynal@bootlin.com

These macros had initially no frequency field. When I added the "maximum
operation frequency" field, I did it initially on very common macros and
I decided to add an optional field for that (with VA_ARGS) in order to
prevent massively unreadable changes. I then added new variants in the
spinand.h header, and requested a frequency field for them by
default. Some times later, I also added maximum frequencies to other
existing variants, but I did it incorrectly, without noticing I was
wrong because the field was optional.

This mix is error prone, so let's do what I should have done since the
very beginning: add a frequency field to all READ_FROM_CACHE variants.

There is no functional change.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/alliancememory.c | 12 ++++----
 drivers/mtd/nand/spi/ato.c            |  6 ++--
 drivers/mtd/nand/spi/esmt.c           |  8 ++---
 drivers/mtd/nand/spi/foresee.c        |  8 ++---
 drivers/mtd/nand/spi/gigadevice.c     | 48 ++++++++++++++---------------
 drivers/mtd/nand/spi/macronix.c       |  8 ++---
 drivers/mtd/nand/spi/micron.c         | 20 ++++++------
 drivers/mtd/nand/spi/paragon.c        | 12 ++++----
 drivers/mtd/nand/spi/skyhigh.c        | 12 ++++----
 drivers/mtd/nand/spi/toshiba.c        |  8 ++---
 drivers/mtd/nand/spi/winbond.c        | 22 +++++++-------
 drivers/mtd/nand/spi/xtx.c            | 12 ++++----
 include/linux/mtd/spinand.h           | 57 ++++++++++++++++++++---------------
 13 files changed, 121 insertions(+), 112 deletions(-)

diff --git a/drivers/mtd/nand/spi/alliancememory.c b/drivers/mtd/nand/spi/alliancememory.c
index 2ee498230ec1be23d77d975b2a4cc972f0f6e258..9e97c40955c9e923836ad66c31eb74cc0c1a4efa 100644
--- a/drivers/mtd/nand/spi/alliancememory.c
+++ b/drivers/mtd/nand/spi/alliancememory.c
@@ -17,12 +17,12 @@
 #define AM_STATUS_ECC_MAX_CORRECTED	(3 << 4)
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
-		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
 			   SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
diff --git a/drivers/mtd/nand/spi/ato.c b/drivers/mtd/nand/spi/ato.c
index 2b4df1d917ac8581f30079356b98eeba06da9687..45d38ce0736cc14b2c79d30e02a319d4318bc855 100644
--- a/drivers/mtd/nand/spi/ato.c
+++ b/drivers/mtd/nand/spi/ato.c
@@ -14,9 +14,9 @@
 
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
 		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
diff --git a/drivers/mtd/nand/spi/esmt.c b/drivers/mtd/nand/spi/esmt.c
index 9e286612a296c75831f7b95a010a5fe47579c36d..9a9325c0bc49726b0421d77680684ae07560bf2e 100644
--- a/drivers/mtd/nand/spi/esmt.c
+++ b/drivers/mtd/nand/spi/esmt.c
@@ -18,10 +18,10 @@
 	(CFG_OTP_ENABLE | ESMT_F50L1G41LB_CFG_OTP_PROTECT)
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
-			   SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
-			   SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
-			   SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
-			   SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
+			   SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
+			   SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
+			   SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
+			   SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
 			   SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
diff --git a/drivers/mtd/nand/spi/foresee.c b/drivers/mtd/nand/spi/foresee.c
index 7c61644bfb109d2960a8b3065f98f348bd23e162..c521dd6abc4b9773db2243a7172d893a4301ab3b 100644
--- a/drivers/mtd/nand/spi/foresee.c
+++ b/drivers/mtd/nand/spi/foresee.c
@@ -12,10 +12,10 @@
 #define SPINAND_MFR_FORESEE		0xCD
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
 		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
diff --git a/drivers/mtd/nand/spi/gigadevice.c b/drivers/mtd/nand/spi/gigadevice.c
index cb1d316fc4d8326ac79a32919d4c41260d8f1b59..e4f34ade1a1c11c0d1dee84acaf2eb62f9923ce7 100644
--- a/drivers/mtd/nand/spi/gigadevice.c
+++ b/drivers/mtd/nand/spi/gigadevice.c
@@ -24,36 +24,36 @@
 #define GD5FXGQ4UXFXXG_STATUS_ECC_UNCOR_ERROR	(7 << 4)
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
-		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
 
 static SPINAND_OP_VARIANTS(read_cache_variants_f,
-		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_3A_1S_1S_4S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_3A_1S_1S_2S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_FAST_3A_1S_1S_1S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_3A_1S_1S_1S_OP(0, 0, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_3A_1S_1S_4S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_3A_1S_1S_2S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_3A_1S_1S_1S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_3A_1S_1S_1S_OP(0, 0, NULL, 0, 0));
 
 static SPINAND_OP_VARIANTS(read_cache_variants_1gq5,
-		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 2, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 2, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
 
 static SPINAND_OP_VARIANTS(read_cache_variants_2gq5,
-		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 4, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 2, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 4, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 2, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
 		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index eeaf5bf9f082a6e44daafbfcee1adc94f24f7540..edf63b9996cf029fffa4948566c7afda77d97cee 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -28,10 +28,10 @@ struct macronix_priv {
 };
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
 		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 8281c9d3f4f74e1234dc969b8ffc82e0b4d8496d..a49d7cb6a96da701ee981e677f414c57eabb2cec 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -35,12 +35,12 @@
 	(CFG_OTP_ENABLE | MICRON_MT29F2G01ABAGD_CFG_OTP_STATE)
 
 static SPINAND_OP_VARIANTS(quadio_read_cache_variants,
-		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 2, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 2, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
 
 static SPINAND_OP_VARIANTS(x4_write_cache_variants,
 		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
@@ -52,10 +52,10 @@ static SPINAND_OP_VARIANTS(x4_update_cache_variants,
 
 /* Micron  MT29F2G01AAAED Device */
 static SPINAND_OP_VARIANTS(x4_read_cache_variants,
-			   SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
-			   SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
-			   SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
-			   SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
+			   SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
+			   SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
+			   SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
+			   SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
 
 static SPINAND_OP_VARIANTS(x1_write_cache_variants,
 			   SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
diff --git a/drivers/mtd/nand/spi/paragon.c b/drivers/mtd/nand/spi/paragon.c
index 4670bac41245e1f357727d2855c2249bb420cac4..73bd124273a5f7e31f7eefe006a6f7f1d1fec338 100644
--- a/drivers/mtd/nand/spi/paragon.c
+++ b/drivers/mtd/nand/spi/paragon.c
@@ -22,12 +22,12 @@
 
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
-		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 2, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 2, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
 		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
diff --git a/drivers/mtd/nand/spi/skyhigh.c b/drivers/mtd/nand/spi/skyhigh.c
index 51d61785df61cdc987c1c330f7fa50f4389855e9..bf9ce163e6a7be5f37316413dff4f1d558f9b587 100644
--- a/drivers/mtd/nand/spi/skyhigh.c
+++ b/drivers/mtd/nand/spi/skyhigh.c
@@ -17,12 +17,12 @@
 #define SKYHIGH_CONFIG_PROTECT_EN		BIT(1)
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
-		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 4, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 2, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 4, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 2, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
 		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
index 4c6923047aeb84fa59369aced6d30ad6e9b6350d..6530257ac0beddf8b9e5a9591c5f5ccc4803c003 100644
--- a/drivers/mtd/nand/spi/toshiba.c
+++ b/drivers/mtd/nand/spi/toshiba.c
@@ -15,10 +15,10 @@
 #define TOSH_STATUS_ECC_HAS_BITFLIPS_T	(3 << 4)
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_x4_variants,
 		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index b7a28f001a387b2a2ca71faa61226f6dc3b81407..7a9e22e81dcf46ab26b03f7abf7112e0793f836c 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -27,8 +27,8 @@ static SPINAND_OP_VARIANTS(read_cache_octal_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1D_8D_OP(0, 2, NULL, 0, 105 * HZ_PER_MHZ),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_8S_8S_OP(0, 16, NULL, 0, 162 * HZ_PER_MHZ),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_8S_OP(0, 1, NULL, 0, 133 * HZ_PER_MHZ),
-		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_octal_variants,
 		SPINAND_PROG_LOAD_1S_8S_8S_OP(true, 0, NULL, 0),
@@ -43,22 +43,22 @@ static SPINAND_OP_VARIANTS(read_cache_dual_quad_dtr_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_1S_4D_4D_OP(0, 8, NULL, 0, 80 * HZ_PER_MHZ),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1D_4D_OP(0, 2, NULL, 0, 80 * HZ_PER_MHZ),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 2, NULL, 0, 104 * HZ_PER_MHZ),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_2D_2D_OP(0, 4, NULL, 0, 80 * HZ_PER_MHZ),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1D_2D_OP(0, 2, NULL, 0, 80 * HZ_PER_MHZ),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0, 104 * HZ_PER_MHZ),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1D_1D_OP(0, 2, NULL, 0, 80 * HZ_PER_MHZ),
-		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 54 * HZ_PER_MHZ));
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
-		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 2, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 2, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
 		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
diff --git a/drivers/mtd/nand/spi/xtx.c b/drivers/mtd/nand/spi/xtx.c
index 37336d5958a95377aa40bcbf81ebdda4907e2385..5915b37b47f51539f23c9fc3be24fd59cbdcc21a 100644
--- a/drivers/mtd/nand/spi/xtx.c
+++ b/drivers/mtd/nand/spi/xtx.c
@@ -23,12 +23,12 @@
 #define XT26XXXD_STATUS_ECC_UNCOR_ERROR     (2)
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
-		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
 		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 28a013f4f4f38881bb9f762f2a8ca1e788d400a8..61a4571cec7ea86bcc5cb439b76964ba778c0f89 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -62,30 +62,33 @@
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_NO_DATA)
 
-#define SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(addr, ndummy, buf, len, ...) \
+#define SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(addr, ndummy, buf, len, freq) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),				\
 		   SPI_MEM_OP_ADDR(2, addr, 1),				\
 		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
 		   SPI_MEM_OP_DATA_IN(len, buf, 1),			\
-		   SPI_MEM_OP_MAX_FREQ(__VA_ARGS__ + 0))
+		   SPI_MEM_OP_MAX_FREQ(freq))
 
-#define SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(addr, ndummy, buf, len) \
+#define SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(addr, ndummy, buf, len, freq) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x0b, 1),				\
 		   SPI_MEM_OP_ADDR(2, addr, 1),				\
 		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
-		   SPI_MEM_OP_DATA_IN(len, buf, 1))
+		   SPI_MEM_OP_DATA_IN(len, buf, 1),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
 
-#define SPINAND_PAGE_READ_FROM_CACHE_3A_1S_1S_1S_OP(addr, ndummy, buf, len) \
+#define SPINAND_PAGE_READ_FROM_CACHE_3A_1S_1S_1S_OP(addr, ndummy, buf, len, freq) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),				\
 		   SPI_MEM_OP_ADDR(3, addr, 1),				\
 		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
-		   SPI_MEM_OP_DATA_IN(len, buf, 1))
+		   SPI_MEM_OP_DATA_IN(len, buf, 1),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
 
-#define SPINAND_PAGE_READ_FROM_CACHE_FAST_3A_1S_1S_1S_OP(addr, ndummy, buf, len) \
+#define SPINAND_PAGE_READ_FROM_CACHE_FAST_3A_1S_1S_1S_OP(addr, ndummy, buf, len, freq) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x0b, 1),				\
 		   SPI_MEM_OP_ADDR(3, addr, 1),				\
 		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
-		   SPI_MEM_OP_DATA_IN(len, buf, 1))
+		   SPI_MEM_OP_DATA_IN(len, buf, 1),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
 
 #define SPINAND_PAGE_READ_FROM_CACHE_1S_1D_1D_OP(addr, ndummy, buf, len, freq) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x0d, 1),				\
@@ -94,17 +97,19 @@
 		   SPI_MEM_DTR_OP_DATA_IN(len, buf, 1),			\
 		   SPI_MEM_OP_MAX_FREQ(freq))
 
-#define SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(addr, ndummy, buf, len) \
+#define SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(addr, ndummy, buf, len, freq) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x3b, 1),				\
 		   SPI_MEM_OP_ADDR(2, addr, 1),				\
 		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
-		   SPI_MEM_OP_DATA_IN(len, buf, 2))
+		   SPI_MEM_OP_DATA_IN(len, buf, 2),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
 
-#define SPINAND_PAGE_READ_FROM_CACHE_3A_1S_1S_2S_OP(addr, ndummy, buf, len) \
+#define SPINAND_PAGE_READ_FROM_CACHE_3A_1S_1S_2S_OP(addr, ndummy, buf, len, freq) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x3b, 1),				\
 		   SPI_MEM_OP_ADDR(3, addr, 1),				\
 		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
-		   SPI_MEM_OP_DATA_IN(len, buf, 2))
+		   SPI_MEM_OP_DATA_IN(len, buf, 2),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
 
 #define SPINAND_PAGE_READ_FROM_CACHE_1S_1D_2D_OP(addr, ndummy, buf, len, freq) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x3d, 1),				\
@@ -113,18 +118,19 @@
 		   SPI_MEM_DTR_OP_DATA_IN(len, buf, 2),			\
 		   SPI_MEM_OP_MAX_FREQ(freq))
 
-#define SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(addr, ndummy, buf, len, ...) \
+#define SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(addr, ndummy, buf, len, freq) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0xbb, 1),				\
 		   SPI_MEM_OP_ADDR(2, addr, 2),				\
 		   SPI_MEM_OP_DUMMY(ndummy, 2),				\
 		   SPI_MEM_OP_DATA_IN(len, buf, 2),			\
-		   SPI_MEM_OP_MAX_FREQ(__VA_ARGS__ + 0))
+		   SPI_MEM_OP_MAX_FREQ(freq))
 
-#define SPINAND_PAGE_READ_FROM_CACHE_3A_1S_2S_2S_OP(addr, ndummy, buf, len) \
+#define SPINAND_PAGE_READ_FROM_CACHE_3A_1S_2S_2S_OP(addr, ndummy, buf, len, freq) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0xbb, 1),				\
 		   SPI_MEM_OP_ADDR(3, addr, 2),				\
 		   SPI_MEM_OP_DUMMY(ndummy, 2),				\
-		   SPI_MEM_OP_DATA_IN(len, buf, 2))
+		   SPI_MEM_OP_DATA_IN(len, buf, 2),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
 
 #define SPINAND_PAGE_READ_FROM_CACHE_1S_2D_2D_OP(addr, ndummy, buf, len, freq) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0xbd, 1),				\
@@ -133,17 +139,19 @@
 		   SPI_MEM_DTR_OP_DATA_IN(len, buf, 2),			\
 		   SPI_MEM_OP_MAX_FREQ(freq))
 
-#define SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(addr, ndummy, buf, len) \
+#define SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(addr, ndummy, buf, len, freq) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x6b, 1),				\
 		   SPI_MEM_OP_ADDR(2, addr, 1),				\
 		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
-		   SPI_MEM_OP_DATA_IN(len, buf, 4))
+		   SPI_MEM_OP_DATA_IN(len, buf, 4),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
 
-#define SPINAND_PAGE_READ_FROM_CACHE_3A_1S_1S_4S_OP(addr, ndummy, buf, len)	\
+#define SPINAND_PAGE_READ_FROM_CACHE_3A_1S_1S_4S_OP(addr, ndummy, buf, len, freq) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x6b, 1),				\
 		   SPI_MEM_OP_ADDR(3, addr, 1),				\
 		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
-		   SPI_MEM_OP_DATA_IN(len, buf, 4))
+		   SPI_MEM_OP_DATA_IN(len, buf, 4),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
 
 #define SPINAND_PAGE_READ_FROM_CACHE_1S_1D_4D_OP(addr, ndummy, buf, len, freq) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x6d, 1),				\
@@ -152,18 +160,19 @@
 		   SPI_MEM_DTR_OP_DATA_IN(len, buf, 4),			\
 		   SPI_MEM_OP_MAX_FREQ(freq))
 
-#define SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(addr, ndummy, buf, len, ...) \
+#define SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(addr, ndummy, buf, len, freq) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0xeb, 1),				\
 		   SPI_MEM_OP_ADDR(2, addr, 4),				\
 		   SPI_MEM_OP_DUMMY(ndummy, 4),				\
 		   SPI_MEM_OP_DATA_IN(len, buf, 4),			\
-		   SPI_MEM_OP_MAX_FREQ(__VA_ARGS__ + 0))
+		   SPI_MEM_OP_MAX_FREQ(freq))
 
-#define SPINAND_PAGE_READ_FROM_CACHE_3A_1S_4S_4S_OP(addr, ndummy, buf, len) \
+#define SPINAND_PAGE_READ_FROM_CACHE_3A_1S_4S_4S_OP(addr, ndummy, buf, len, freq) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0xeb, 1),				\
 		   SPI_MEM_OP_ADDR(3, addr, 4),				\
 		   SPI_MEM_OP_DUMMY(ndummy, 4),				\
-		   SPI_MEM_OP_DATA_IN(len, buf, 4))
+		   SPI_MEM_OP_DATA_IN(len, buf, 4),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
 
 #define SPINAND_PAGE_READ_FROM_CACHE_1S_4D_4D_OP(addr, ndummy, buf, len, freq) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0xed, 1),				\

-- 
2.48.1


