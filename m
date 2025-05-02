Return-Path: <linux-spi+bounces-7846-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8B8AA6F1E
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 12:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF67B4C25BE
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 10:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B22423C51A;
	Fri,  2 May 2025 10:14:18 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from gauss.telenet-ops.be (gauss.telenet-ops.be [195.130.132.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB1523C513
	for <linux-spi@vger.kernel.org>; Fri,  2 May 2025 10:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746180858; cv=none; b=hb7VslHY9LFOQQuJ1UGH4Eb8VkUK6YjTnK9ZHLqDY7UAOYfw6/DEHl47wAPI7VldGeJaKUFWX+IK6rg3TPpSgu2hCxPGL21O6h3J6Pkb9XWjfpwkQSc4NB15v2Cs7MMNE0XqRGYEEuEWEz6J8gXtonKLAvYPYllNOJBTnn6DOTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746180858; c=relaxed/simple;
	bh=jdXT+5tCsEIXti4mAdWB/DUtoSCc0/dH688hFuz34O8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+Igq+ZSLUftw7uj3XSN5kAxgEfD9sZhJhZHMLNWbUGo9fskT4Gwh/KCSpv8bGr98XVi4zqJgBjf12sRZ+1SVO+x2h6FMwRH3owcqrORKaYrFRkTqdRgVsqRtwERAqajYYBqq9w05ZJr/AiE6lbBbIkZAJ7A/JRTxMKPEFLyjw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
	by gauss.telenet-ops.be (Postfix) with ESMTPS id 4Zpmwx185Sz4x4kT
	for <linux-spi@vger.kernel.org>; Fri, 02 May 2025 12:14:09 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:df64:35e8:502:4ac0])
	by xavier.telenet-ops.be with cmsmtp
	id kAE02E00H4sst1101AE0ia; Fri, 02 May 2025 12:14:00 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uAnP1-00000000W9o-3hoX;
	Fri, 02 May 2025 12:14:00 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uAnP6-00000008oWp-1Tgf;
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
Subject: [PATCH 09/22] spi: sh-msiof: SITMDR2 and SIRMDR2 bitfield conversion
Date: Fri,  2 May 2025 12:13:41 +0200
Message-ID: <14e32fa30e98ae465c7eca99cec205f9c1fcbff5.1746180072.git.geert+renesas@glider.be>
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

Convert MSIOF Transmit and Receive Mode Register 2 field accesses to use
the FIELD_PREP() bitfield access macro.

This gets rid of explicit shifts and custom field preparation macros.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-sh-msiof.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index fb83b049690e0207..51a9e89364756af0 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -100,8 +100,8 @@ struct sh_msiof_spi_priv {
 						/* 0=MSIOF_SYNC, 1=MSIOF_SS1, 2=MSIOF_SS2 */
 
 /* SITMDR2 and SIRMDR2 */
-#define SIMDR2_BITLEN1(i)	(((i) - 1) << 24) /* Data Size (8-32 bits) */
-#define SIMDR2_WDLEN1(i)	(((i) - 1) << 16) /* Word Count (1-64/256 (SH, A1))) */
+#define SIMDR2_BITLEN1		GENMASK(28, 24)	/* Data Size (8-32 bits) */
+#define SIMDR2_WDLEN1		GENMASK(23, 16)	/* Word Count (1-64/256 (SH, A1))) */
 #define SIMDR2_GRPMASK1		BIT(0)		/* Group Output Mask 1 (SH, A1) */
 
 /* SITSCR and SIRSCR */
@@ -397,7 +397,8 @@ static void sh_msiof_spi_set_mode_regs(struct sh_msiof_spi_priv *p,
 				       const void *tx_buf, void *rx_buf,
 				       u32 bits, u32 words)
 {
-	u32 dr2 = SIMDR2_BITLEN1(bits) | SIMDR2_WDLEN1(words);
+	u32 dr2 = FIELD_PREP(SIMDR2_BITLEN1, bits - 1) |
+		  FIELD_PREP(SIMDR2_WDLEN1, words - 1);
 
 	if (tx_buf || (p->ctlr->flags & SPI_CONTROLLER_MUST_TX))
 		sh_msiof_write(p, SITMDR2, dr2);
@@ -931,6 +932,7 @@ static int sh_msiof_transfer_one(struct spi_controller *ctlr,
 				 struct spi_transfer *t)
 {
 	struct sh_msiof_spi_priv *p = spi_controller_get_devdata(ctlr);
+	unsigned int max_wdlen = FIELD_MAX(SIMDR2_WDLEN1) + 1;
 	void (*copy32)(u32 *, const u32 *, unsigned int);
 	void (*tx_fifo)(struct sh_msiof_spi_priv *, const void *, unsigned int,
 			unsigned int);
@@ -940,7 +942,6 @@ static int sh_msiof_transfer_one(struct spi_controller *ctlr,
 	void *rx_buf = t->rx_buf;
 	unsigned int len = t->len;
 	unsigned int bits = t->bits_per_word;
-	unsigned int max_wdlen = 256;
 	unsigned int bytes_per_word;
 	unsigned int words;
 	int n;
-- 
2.43.0


