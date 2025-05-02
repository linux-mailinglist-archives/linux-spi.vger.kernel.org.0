Return-Path: <linux-spi+bounces-7845-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE7DAA6F1C
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 12:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1103F1BC6479
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 10:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F100923C4F1;
	Fri,  2 May 2025 10:14:17 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B55214B965
	for <linux-spi@vger.kernel.org>; Fri,  2 May 2025 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746180857; cv=none; b=g/GVkjpVvdEE5WbajTeo4QWLPh1e0DqDHh7q/LeHjrEnBCwgFyCjV6nAsDvC4KQdW5v9FWCZ4uiwqVWzrswjUEpvFROr7XCVX/VGrt2CG6tZuh/j3FFGcqiuFKZFgxVo/ftF0tH01uc95svmwO5Imp4PqH0TMWkOaGWHafDTuws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746180857; c=relaxed/simple;
	bh=Gscx63sjgeDq3xT2xwpHzxrg440w82o5osnaGdQKv8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XbpDgMHIAGDa/R8PhSCe4IWQsHa2rkDdU17r2fe5f+KTSyjr7r5q7qgDwKNRpCDG9pmz0AOqnWhw6nXOucF8kNXyuA5P93jPLPdSPGY2OSZswGoZnU1HhSNc7nkp3E7QHnQYZBDmU+RXkIfLoZGmt1ez3wlGWl+4oZ/VeGmaSbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:df64:35e8:502:4ac0])
	by laurent.telenet-ops.be with cmsmtp
	id kAE02E00k4sst1101AE0qL; Fri, 02 May 2025 12:14:01 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uAnP1-00000000W9s-3o6Z;
	Fri, 02 May 2025 12:14:00 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uAnP6-00000008oWu-1aur;
	Fri, 02 May 2025 12:14:00 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Cc: linux-spi@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 10/22] spi: sh-msiof: SITSCR/SIRSCR bitfield conversion
Date: Fri,  2 May 2025 12:13:42 +0200
Message-ID: <c9b3192c046c226de3499ea3e52be6a69c0d4bf9.1746180072.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746180072.git.geert+renesas@glider.be>
References: <cover.1746180072.git.geert+renesas@glider.be>
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


