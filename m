Return-Path: <linux-spi+bounces-8166-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BBEAB9D89
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 15:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B0631BC5F5D
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 13:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8AC1531C8;
	Fri, 16 May 2025 13:32:48 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EC3823DE
	for <linux-spi@vger.kernel.org>; Fri, 16 May 2025 13:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402367; cv=none; b=jNb6Hsm93FNFjgX+IAdUfRVShSLNcJVpJIiBj7plvkQPavXQmprZdBSgEhz9PXUxWtAhOVRle4nmZW1NDMtQSMOfblfyUA6F4tZFONQd9Jl81j9wSReE2q0gYSDCxyxBKuQeu5uYmp60MSVeqKQYo2fKcab95Co/r66e3OB8W30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402367; c=relaxed/simple;
	bh=MSvhpfzfxRAatgz6Ijb2BdMLJ7N3lj9jgMikPf86PqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ktrx8LgM9e++9qKwTkTecuwtauspSEzNCCjy/CU8AgKN65hNSiybFLy9CXpg9e620H0iwR5Arl3vJVRBfZVsdZHyGBhR6dV+IF5rp0QLtt71bOOvqGFIS1zjo2BlxrblOUkLuBhQpDcedMejmGiEeHPTYeeeafIxr9TL+o2Gv+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:b0d6:ccd4:58dc:70fd])
	by xavier.telenet-ops.be with cmsmtp
	id ppYY2E0023S8nz401pYYau; Fri, 16 May 2025 15:32:33 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uFvAi-000000020j9-27CA;
	Fri, 16 May 2025 15:32:31 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uFvAt-00000001536-3fWb;
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
Subject: [PATCH v2 14/22] spi: sh-msiof: Add core support for dual-group transfers
Date: Fri, 16 May 2025 15:32:17 +0200
Message-ID: <be75e20cfcd2a6c0d73ab09e0126f902911adc69.1747401908.git.geert+renesas@glider.be>
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

All MSIOF variants support transferring data of multiple (2 or 4)
groups.  Add definitions for the register bits related to multiple
groups, and enhance sh_msiof_spi_set_mode_regs() to accept a second
group size.

For now the second group is unused.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.
---
 drivers/spi/spi-sh-msiof.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 57f27040b0fc78d7..ea9277ab87f66cd5 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -100,10 +100,15 @@ struct sh_msiof_spi_priv {
 						/* 0=MSIOF_SYNC, 1=MSIOF_SS1, 2=MSIOF_SS2 */
 
 /* SITMDR2 and SIRMDR2 */
+#define SIMDR2_GRP		GENMASK(31, 30)	/* Group Count */
 #define SIMDR2_BITLEN1		GENMASK(28, 24)	/* Data Size (8-32 bits) */
 #define SIMDR2_WDLEN1		GENMASK(23, 16)	/* Word Count (1-64/256 (SH, A1))) */
 #define SIMDR2_GRPMASK		GENMASK(3, 0)	/* Group Output Mask 1-4 (SH, A1) */
 
+/* SITMDR3 and SIRMDR3 */
+#define SIMDR3_BITLEN2		GENMASK(28, 24)	/* Data Size (8-32 bits) */
+#define SIMDR3_WDLEN2		GENMASK(23, 16)	/* Word Count (1-64/256 (SH, A1))) */
+
 /* SITSCR and SIRSCR */
 #define SISCR_BRPS		GENMASK(12, 8)	/* Prescaler Setting (1-32) */
 #define SISCR_BRDV		GENMASK(2, 0)	/* Baud Rate Generator's Division Ratio */
@@ -392,10 +397,11 @@ static void sh_msiof_spi_set_pin_regs(struct sh_msiof_spi_priv *p, u32 ss,
 
 static void sh_msiof_spi_set_mode_regs(struct sh_msiof_spi_priv *p,
 				       const void *tx_buf, void *rx_buf,
-				       u32 bits, u32 words)
+				       u32 bits, u32 words1, u32 words2)
 {
-	u32 dr2 = FIELD_PREP(SIMDR2_BITLEN1, bits - 1) |
-		  FIELD_PREP(SIMDR2_WDLEN1, words - 1);
+	u32 dr2 = FIELD_PREP(SIMDR2_GRP, words2 ? 1 : 0) |
+		  FIELD_PREP(SIMDR2_BITLEN1, bits - 1) |
+		  FIELD_PREP(SIMDR2_WDLEN1, words1 - 1);
 
 	if (tx_buf || (p->ctlr->flags & SPI_CONTROLLER_MUST_TX))
 		sh_msiof_write(p, SITMDR2, dr2);
@@ -404,6 +410,15 @@ static void sh_msiof_spi_set_mode_regs(struct sh_msiof_spi_priv *p,
 
 	if (rx_buf)
 		sh_msiof_write(p, SIRMDR2, dr2);
+
+	if (words2) {
+		u32 dr3 = FIELD_PREP(SIMDR3_BITLEN2, bits - 1) |
+			  FIELD_PREP(SIMDR3_WDLEN2, words2 - 1);
+
+		sh_msiof_write(p, SITMDR3, dr3);
+		if (rx_buf)
+			sh_msiof_write(p, SIRMDR3, dr3);
+	}
 }
 
 static void sh_msiof_reset_str(struct sh_msiof_spi_priv *p)
@@ -712,7 +727,7 @@ static int sh_msiof_spi_txrx_once(struct sh_msiof_spi_priv *p,
 	sh_msiof_write(p, SIFCTR, 0);
 
 	/* setup msiof transfer mode registers */
-	sh_msiof_spi_set_mode_regs(p, tx_buf, rx_buf, bits, words);
+	sh_msiof_spi_set_mode_regs(p, tx_buf, rx_buf, bits, words, 0);
 	sh_msiof_write(p, SIIER, SIIER_TEOFE | SIIER_REOFE);
 
 	/* write tx fifo */
@@ -812,7 +827,7 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv *p, const void *tx,
 		       FIELD_PREP(SIFCTR_RFWM, SIFCTR_RFWM_1));
 
 	/* setup msiof transfer mode registers (32-bit words) */
-	sh_msiof_spi_set_mode_regs(p, tx, rx, 32, len / 4);
+	sh_msiof_spi_set_mode_regs(p, tx, rx, 32, len / 4, 0);
 
 	sh_msiof_write(p, SIIER, ier_bits);
 
-- 
2.43.0


