Return-Path: <linux-spi+bounces-8161-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B21D1AB9D71
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 15:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CE744A096F
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 13:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896B97261D;
	Fri, 16 May 2025 13:32:45 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E599074C08
	for <linux-spi@vger.kernel.org>; Fri, 16 May 2025 13:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402365; cv=none; b=AWyxYf66r8YRE84eOowv0xC+Rx9F1u91ANKG4GWdA4JlafLwL+kiqT21potU6aJ5Bg91nooP7o94H7wwiNhNv5Cr9UZ04Vfmuy0dNyk1InIffcacHbpnxpoRj+OHMmY4DIZ57m3sQ3p5APFuSVMCrlrXxJe/yzYOwBxrVL1AgDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402365; c=relaxed/simple;
	bh=apOAnFclzOiiHNN5XXz3m+ENeYMfSU8T8EP61/g+24I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R94E/fCM5K3xyDiKBhWJn+QjwkxE+LrqYhvGBqzZG6SS0KoDHesKgeTJiVHA81Ngxwfm4DzE9BTKzFWuK6EwpHGsp8jl/YH9x8Ly1vPk6hWYHykkGuR/M35xfw1NifV294s5oZZrhq3BXnHvesbz0xx7qMcH4vJ6vgmucS4I1kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:b0d6:ccd4:58dc:70fd])
	by albert.telenet-ops.be with cmsmtp
	id ppYX2E00K3S8nz406pYXx1; Fri, 16 May 2025 15:32:33 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uFvAi-000000020io-1Nok;
	Fri, 16 May 2025 15:32:31 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uFvAt-0000000152a-2zfh;
	Fri, 16 May 2025 15:32:31 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Koji Matsuoka <koji.matsuoka.xm@renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-spi@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 08/22] spi: sh-msiof: SITMDR1/SIRMDR1 bitfield conversion
Date: Fri, 16 May 2025 15:32:11 +0200
Message-ID: <9685c54e752b8ef4256c9b281e9d8292e71d222e.1747401908.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747401908.git.geert+renesas@glider.be>
References: <cover.1747401908.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert MSIOF Transmit and Receive Mode Register 1 field accesses to use
the FIELD_PREP() bitfield access macro.

This gets rid of explicit shifts.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.
---
 drivers/spi/spi-sh-msiof.c | 45 ++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 7c15de08f4d8f131..fb83b049690e0207 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2014-2017 Glider bvba
  */
 
+#include <linux/bitfield.h>
 #include <linux/bitmap.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
@@ -84,20 +85,19 @@ struct sh_msiof_spi_priv {
 
 /* SITMDR1 and SIRMDR1 */
 #define SIMDR1_TRMD		BIT(31)		/* Transfer Mode (1 = Master mode) */
-#define SIMDR1_SYNCMD_MASK	GENMASK(29, 28)	/* SYNC Mode */
-#define SIMDR1_SYNCMD_SPI	(2 << 28)	/*   Level mode/SPI */
-#define SIMDR1_SYNCMD_LR	(3 << 28)	/*   L/R mode */
-#define SIMDR1_SYNCAC_SHIFT	25		/* Sync Polarity (1 = Active-low) */
-#define SIMDR1_BITLSB_SHIFT	24		/* MSB/LSB First (1 = LSB first) */
-#define SIMDR1_DTDL_SHIFT	20		/* Data Pin Bit Delay for MSIOF_SYNC */
-#define SIMDR1_SYNCDL_SHIFT	16		/* Frame Sync Signal Timing Delay */
-#define SIMDR1_FLD_MASK		GENMASK(3, 2)	/* Frame Sync Signal Interval (0-3) */
-#define SIMDR1_FLD_SHIFT	2
+#define SIMDR1_SYNCMD		GENMASK(29, 28)	/* SYNC Mode */
+#define SIMDR1_SYNCMD_SPI	2U		/*   Level mode/SPI */
+#define SIMDR1_SYNCMD_LR	3U		/*   L/R mode */
+#define SIMDR1_SYNCAC		BIT(25)		/* Sync Polarity (1 = Active-low) */
+#define SIMDR1_BITLSB		BIT(24)		/* MSB/LSB First (1 = LSB first) */
+#define SIMDR1_DTDL		GENMASK(22, 20)	/* Data Pin Bit Delay for MSIOF_SYNC */
+#define SIMDR1_SYNCDL		GENMASK(18, 16)	/* Frame Sync Signal Timing Delay */
+#define SIMDR1_FLD		GENMASK(3, 2)	/* Frame Sync Signal Interval (0-3) */
 #define SIMDR1_XXSTP		BIT(0)		/* Transmission/Reception Stop on FIFO */
 /* SITMDR1 */
 #define SITMDR1_PCON		BIT(30)		/* Transfer Signal Connection */
-#define SITMDR1_SYNCCH_MASK	GENMASK(27, 26)	/* Sync Signal Channel Select */
-#define SITMDR1_SYNCCH_SHIFT	26		/* 0=MSIOF_SYNC, 1=MSIOF_SS1, 2=MSIOF_SS2 */
+#define SITMDR1_SYNCCH		GENMASK(27, 26)	/* Sync Signal Channel Select */
+						/* 0=MSIOF_SYNC, 1=MSIOF_SS1, 2=MSIOF_SS2 */
 
 /* SITMDR2 and SIRMDR2 */
 #define SIMDR2_BITLEN1(i)	(((i) - 1) << 24) /* Data Size (8-32 bits) */
@@ -341,8 +341,9 @@ static u32 sh_msiof_spi_get_dtdl_and_syncdl(struct sh_msiof_spi_priv *p)
 		return 0;
 	}
 
-	val = sh_msiof_get_delay_bit(p->info->dtdl) << SIMDR1_DTDL_SHIFT;
-	val |= sh_msiof_get_delay_bit(p->info->syncdl) << SIMDR1_SYNCDL_SHIFT;
+	val = FIELD_PREP(SIMDR1_DTDL, sh_msiof_get_delay_bit(p->info->dtdl)) |
+	      FIELD_PREP(SIMDR1_SYNCDL,
+			 sh_msiof_get_delay_bit(p->info->syncdl));
 
 	return val;
 }
@@ -361,16 +362,18 @@ static void sh_msiof_spi_set_pin_regs(struct sh_msiof_spi_priv *p, u32 ss,
 	 *    1    0         11     11    0    0
 	 *    1    1         11     11    1    1
 	 */
-	tmp = SIMDR1_SYNCMD_SPI | 1 << SIMDR1_FLD_SHIFT | SIMDR1_XXSTP;
-	tmp |= !cs_high << SIMDR1_SYNCAC_SHIFT;
-	tmp |= lsb_first << SIMDR1_BITLSB_SHIFT;
+	tmp = FIELD_PREP(SIMDR1_SYNCMD, SIMDR1_SYNCMD_SPI) |
+	      FIELD_PREP(SIMDR1_FLD, 1) | SIMDR1_XXSTP |
+	      FIELD_PREP(SIMDR1_SYNCAC, !cs_high) |
+	      FIELD_PREP(SIMDR1_BITLSB, lsb_first);
 	tmp |= sh_msiof_spi_get_dtdl_and_syncdl(p);
 	if (spi_controller_is_target(p->ctlr)) {
 		sh_msiof_write(p, SITMDR1, tmp | SITMDR1_PCON);
 	} else {
 		sh_msiof_write(p, SITMDR1,
 			       tmp | SIMDR1_TRMD | SITMDR1_PCON |
-			       (ss < MAX_SS ? ss : 0) << SITMDR1_SYNCCH_SHIFT);
+			       FIELD_PREP(SITMDR1_SYNCCH,
+					  ss < MAX_SS ? ss : 0));
 	}
 	if (p->ctlr->flags & SPI_CONTROLLER_MUST_TX) {
 		/* These bits are reserved if RX needs TX */
@@ -579,12 +582,12 @@ static int sh_msiof_spi_setup(struct spi_device *spi)
 		return 0;
 
 	/* Configure native chip select mode/polarity early */
-	clr = SIMDR1_SYNCMD_MASK;
-	set = SIMDR1_SYNCMD_SPI;
+	clr = SIMDR1_SYNCMD;
+	set = FIELD_PREP(SIMDR1_SYNCMD, SIMDR1_SYNCMD_SPI);
 	if (spi->mode & SPI_CS_HIGH)
-		clr |= BIT(SIMDR1_SYNCAC_SHIFT);
+		clr |= SIMDR1_SYNCAC;
 	else
-		set |= BIT(SIMDR1_SYNCAC_SHIFT);
+		set |= SIMDR1_SYNCAC;
 	pm_runtime_get_sync(&p->pdev->dev);
 	tmp = sh_msiof_read(p, SITMDR1) & ~clr;
 	sh_msiof_write(p, SITMDR1, tmp | set | SIMDR1_TRMD | SITMDR1_PCON);
-- 
2.43.0


