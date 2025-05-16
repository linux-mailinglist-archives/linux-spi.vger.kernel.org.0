Return-Path: <linux-spi+bounces-8172-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E95FAB9D90
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 15:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9284B1BA7E39
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 13:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A92B15747D;
	Fri, 16 May 2025 13:32:48 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC80672619
	for <linux-spi@vger.kernel.org>; Fri, 16 May 2025 13:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402368; cv=none; b=ZO3GKa8nRlshdsmOsBNoG39iVPQ/3r5I8LdMTRlpEzhVF0uUSjHQbgUNhOBVyKeQ1YhqjSYUpGuGctDUOul9W1ddXWSpOAO/NnUm1khYJacxfyWAnrrdvEle/GgRziKYs9ecAH/xP/NlfrJP6UmBe/QqwradDP0qRoy2muv5abs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402368; c=relaxed/simple;
	bh=OCAbSjmSLPBTKg4S/+30tDY7Ef6+bvyxjGLe725Pq9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aA6PEF8dgRD4x0wTkKvDakDVLa5mcAoKUouf/Ltz2LPIavr/G0XxhhfTR6jC746N75b9XRlhsDo/zecmch+UJioN3BDQH2jllsJRxxxbmdJrpW2jAKciSD9ag5Ro153rlOp+h43wM6/8SHdIsdQbu5hco+f+nqLVsUdqOaVFONM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:b0d6:ccd4:58dc:70fd])
	by albert.telenet-ops.be with cmsmtp
	id ppYX2E00M3S8nz406pYXx2; Fri, 16 May 2025 15:32:33 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uFvAi-000000020iu-1aZ7;
	Fri, 16 May 2025 15:32:31 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uFvAt-0000000152m-3Dct;
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
Subject: [PATCH v2 10/22] spi: sh-msiof: SITSCR/SIRSCR bitfield conversion
Date: Fri, 16 May 2025 15:32:13 +0200
Message-ID: <f2462c99b6ea2e45b995ab4509c2f039043da032.1747401908.git.geert+renesas@glider.be>
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

Convert MSIOF Transmit and Receive Clock Select Register field accesses
to use the FIELD_PREP() bitfield access macro.

This gets rid of explicit shifts and custom field preparation macros.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.
---
 drivers/spi/spi-sh-msiof.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 51a9e89364756af0..9bddf85dd9c7f2a1 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -105,15 +105,14 @@ struct sh_msiof_spi_priv {
 #define SIMDR2_GRPMASK1		BIT(0)		/* Group Output Mask 1 (SH, A1) */
 
 /* SITSCR and SIRSCR */
-#define SISCR_BRPS_MASK		GENMASK(12, 8)	/* Prescaler Setting (1-32) */
-#define SISCR_BRPS(i)		(((i) - 1) << 8)
-#define SISCR_BRDV_MASK		GENMASK(2, 0)	/* Baud Rate Generator's Division Ratio */
-#define SISCR_BRDV_DIV_2	0
-#define SISCR_BRDV_DIV_4	1
-#define SISCR_BRDV_DIV_8	2
-#define SISCR_BRDV_DIV_16	3
-#define SISCR_BRDV_DIV_32	4
-#define SISCR_BRDV_DIV_1	7
+#define SISCR_BRPS		GENMASK(12, 8)	/* Prescaler Setting (1-32) */
+#define SISCR_BRDV		GENMASK(2, 0)	/* Baud Rate Generator's Division Ratio */
+#define SISCR_BRDV_DIV_2	0U
+#define SISCR_BRDV_DIV_4	1U
+#define SISCR_BRDV_DIV_8	2U
+#define SISCR_BRDV_DIV_16	3U
+#define SISCR_BRDV_DIV_32	4U
+#define SISCR_BRDV_DIV_1	7U
 
 /* SICTR */
 #define SICTR_TSCKIZ_MASK	GENMASK(31, 30)	/* Transmit Clock I/O Polarity Select */
@@ -299,7 +298,8 @@ static void sh_msiof_spi_set_clk_regs(struct sh_msiof_spi_priv *p,
 
 	t->effective_speed_hz = parent_rate / (brps << div_pow);
 
-	scr = sh_msiof_spi_div_array[div_pow] | SISCR_BRPS(brps);
+	scr = FIELD_PREP(SISCR_BRDV, sh_msiof_spi_div_array[div_pow]) |
+	      FIELD_PREP(SISCR_BRPS, brps - 1);
 	sh_msiof_write(p, SITSCR, scr);
 	if (!(p->ctlr->flags & SPI_CONTROLLER_MUST_TX))
 		sh_msiof_write(p, SIRSCR, scr);
-- 
2.43.0


