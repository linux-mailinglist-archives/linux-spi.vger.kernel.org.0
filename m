Return-Path: <linux-spi+bounces-8163-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B09AB9D7E
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 15:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 993AE1BC5650
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 13:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7407B73451;
	Fri, 16 May 2025 13:32:47 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA4578F4F
	for <linux-spi@vger.kernel.org>; Fri, 16 May 2025 13:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402366; cv=none; b=phgWW5x01hQYKrP8Ewe1dwBgo1g9oxiyqANRL+pV4O9AOgs39VvWY1ergrz0g0B3lUugEq/VmasL2LI9ki7iERwrh/AoHZdlcDd4ZmCcsxwjwcUb01kckdZCgWEguM5mhdjMbeRLyZHDejfh6GlBVYu2RTdte1U0WMSDml/utHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402366; c=relaxed/simple;
	bh=Z79Ft/DewGnTQHlDwWL9zKlnsIlUgjuVxh0Sq6RBDmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ia2E4tZe42lGocfKD8URHbURr1Pi862te6cAO0f50SscO3VvsWF6Nb5eFNn4H5BYXjl6NxRbQlZq30Ozc6ozF1fksljy1UxNtL6k5iIEgGbWxJglaU+xlDJGDS7ZGhR6XtuhZc6k56pRsYL3e0G29/2HI5VC/wb0ql8mM7+J7QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:b0d6:ccd4:58dc:70fd])
	by michel.telenet-ops.be with cmsmtp
	id ppYY2E0033S8nz406pYY0Z; Fri, 16 May 2025 15:32:33 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uFvAi-000000020jP-2Ww7;
	Fri, 16 May 2025 15:32:32 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uFvAt-0000000153Q-4AuP;
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
Subject: [PATCH v2 18/22] spi: sh-msiof: Simplify BRG's Division Ratio
Date: Fri, 16 May 2025 15:32:21 +0200
Message-ID: <e736221942b0381fb53dc64109a1389f7ec5f44a.1747401908.git.geert+renesas@glider.be>
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

As FIELD_PREP() masks the value to be stored in the field, the Baud Rate
Generator's Division Ratio handling can be simplified from a look-up
table to a single subtraction.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Gcc 13.3.0 is not smart enough to consider all possible values of
div_pow in the current code, hence this works fine.
However, the simpler test loop

    for (unsigned int pow = 0; pow < 6; pow++)
	    pr_info("pow %u scr 0x%08lx\n", pow,
		    FIELD_PREP(SISCR_BRDV, (pow - 1)));

does trigger a "FIELD_PREP: value too large for the field" compile-time
assertion, unless an explicit "& FIELD_MAX(SISCR_BRDV)" is added.
Should we be pro-active and add an extra "& FIELD_MAX(SISCR_BRDV)" now,
to prepare for compilers becoming smarter?

v2:
  - No changes.
---
 drivers/spi/spi-sh-msiof.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 26e71fc8890fda6d..2b8c143b21219521 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -112,12 +112,6 @@ struct sh_msiof_spi_priv {
 /* SITSCR and SIRSCR */
 #define SISCR_BRPS		GENMASK(12, 8)	/* Prescaler Setting (1-32) */
 #define SISCR_BRDV		GENMASK(2, 0)	/* Baud Rate Generator's Division Ratio */
-#define SISCR_BRDV_DIV_2	0U
-#define SISCR_BRDV_DIV_4	1U
-#define SISCR_BRDV_DIV_8	2U
-#define SISCR_BRDV_DIV_16	3U
-#define SISCR_BRDV_DIV_32	4U
-#define SISCR_BRDV_DIV_1	7U
 
 /* SICTR */
 #define SICTR_TSCKIZ		GENMASK(31, 30)	/* Transmit Clock I/O Polarity Select */
@@ -256,11 +250,6 @@ static void sh_msiof_spi_reset_regs(struct sh_msiof_spi_priv *p)
 				  100);
 }
 
-static const u32 sh_msiof_spi_div_array[] = {
-	SISCR_BRDV_DIV_1, SISCR_BRDV_DIV_2, SISCR_BRDV_DIV_4,
-	SISCR_BRDV_DIV_8, SISCR_BRDV_DIV_16, SISCR_BRDV_DIV_32,
-};
-
 static void sh_msiof_spi_set_clk_regs(struct sh_msiof_spi_priv *p,
 				      struct spi_transfer *t)
 {
@@ -299,7 +288,8 @@ static void sh_msiof_spi_set_clk_regs(struct sh_msiof_spi_priv *p,
 
 	t->effective_speed_hz = parent_rate / (brps << div_pow);
 
-	scr = FIELD_PREP(SISCR_BRDV, sh_msiof_spi_div_array[div_pow]) |
+	/* div_pow == 0 maps to SISCR_BRDV_DIV_1 == all ones */
+	scr = FIELD_PREP(SISCR_BRDV, div_pow - 1) |
 	      FIELD_PREP(SISCR_BRPS, brps - 1);
 	sh_msiof_write(p, SITSCR, scr);
 	if (!(p->ctlr->flags & SPI_CONTROLLER_MUST_TX))
-- 
2.43.0


