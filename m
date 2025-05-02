Return-Path: <linux-spi+bounces-7825-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B307AA6EF4
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 12:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885D0462E5E
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 10:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0EB22C35C;
	Fri,  2 May 2025 10:14:13 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7619B238C3A
	for <linux-spi@vger.kernel.org>; Fri,  2 May 2025 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746180851; cv=none; b=NnVG8tCqSI2QvBLMe5OqcTJd0JDQj+U8RChHMyV6Tzld/7EYIof8SISRlS73uq1RZVrLRt73rJJwmXe4Z3dQQh7htu3pDupLjobMMG7KGlYE9QblS9fEm/9oC3qoPkcPiCbIuEji0uhtp6XzRAzLIEiGFldOMJGzI3kFPtDRCTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746180851; c=relaxed/simple;
	bh=NRfGNySG//21qN7qr6z+IGOpyvY/jDAejLA+2e+ti/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbCSIa9teR4JkwAx/Th/Pugf22rkCKCfluRsCjdOh3j2Zo56qJ1lb/czVarvwGsCtMsngBfPSOmlOBUJNnah6GsKDUg+1WvbSojT+q1rJHKxdQJNH4HYy/WhWAloHFu2ejFxkFUnlwf5FF3kufT+5HwhqDzCLNlnHQaNFOxhE9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:df64:35e8:502:4ac0])
	by albert.telenet-ops.be with cmsmtp
	id kAE02E0194sst1106AE0JR; Fri, 02 May 2025 12:14:00 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uAnP2-00000000WA7-0Gxe;
	Fri, 02 May 2025 12:14:00 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uAnP6-00000008oXE-2D6R;
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
Subject: [PATCH 14/22] spi: sh-msiof: Add core support for dual-group transfers
Date: Fri,  2 May 2025 12:13:46 +0200
Message-ID: <b8c04fd606bd01644210aecc649e7bb188753e4a.1746180072.git.geert+renesas@glider.be>
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

All MSIOF variants support transferring data of multiple (2 or 4)
groups.  Add definitions for the register bits related to multiple
groups, and enhance sh_msiof_spi_set_mode_regs() to accept a second
group size.

For now the second group is unused.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
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


