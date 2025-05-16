Return-Path: <linux-spi+bounces-8156-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBBDAB9D6C
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 15:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622AE1730C2
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 13:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FC51E871;
	Fri, 16 May 2025 13:32:38 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B6C2E40B
	for <linux-spi@vger.kernel.org>; Fri, 16 May 2025 13:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402358; cv=none; b=iDPRUJsdERa2c3CTVj2SpD6+jAS4jP+9lCeUTfsY98ZPf+xjyJVuQZn0FbyKpfebTY4SNs1YOwFXKDNR0B9b1iczY8sAob0OwdJn8uSXZ/mIYufBIa1nhY/YKbuKTdjYkfqV3KlPl/QyfOJgsyilDldhofZ0OmBjBcKJmTGc548=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402358; c=relaxed/simple;
	bh=ym1GoUTCYkN02Tub7Wp0X2XBhRpUMwaHua2LRoJKlb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XOm2jOsKVp81uNki/KJ6jaa+G0S+fEVo/pXhUQpB3lS//5gHtSh+9hnp/VSNOBf/vbZlMm+MHNGVqLWBpGcLV4O3sxrchs0WzFFSgU2VGaMWNpk9KcFyAsRef6/3JEW4Kv8/WoeD0YgrvVN1RwUP8MaS6y0U9KpzysAsBVR1Tb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:b0d6:ccd4:58dc:70fd])
	by baptiste.telenet-ops.be with cmsmtp
	id ppYX2E00L3S8nz401pYYVQ; Fri, 16 May 2025 15:32:33 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uFvAi-000000020iy-1h73;
	Fri, 16 May 2025 15:32:31 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uFvAt-0000000152r-3LD2;
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
Subject: [PATCH v2 11/22] spi: sh-msiof: SICTR bitfield conversion
Date: Fri, 16 May 2025 15:32:14 +0200
Message-ID: <4511c678c8fce5969eb50ffa7372d53396ff80ff.1747401908.git.geert+renesas@glider.be>
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

Convert MSIOF Control Register field accesses to use the FIELD_PREP()
bitfield access macro.

This gets rid of explicit shifts.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.
---
 drivers/spi/spi-sh-msiof.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 9bddf85dd9c7f2a1..4f582ecc524fe5fa 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -115,18 +115,18 @@ struct sh_msiof_spi_priv {
 #define SISCR_BRDV_DIV_1	7U
 
 /* SICTR */
-#define SICTR_TSCKIZ_MASK	GENMASK(31, 30)	/* Transmit Clock I/O Polarity Select */
+#define SICTR_TSCKIZ		GENMASK(31, 30)	/* Transmit Clock I/O Polarity Select */
 #define SICTR_TSCKIZ_SCK	BIT(31)		/*   Disable SCK when TX disabled */
-#define SICTR_TSCKIZ_POL_SHIFT	30		/*   Transmit Clock Polarity */
-#define SICTR_RSCKIZ_MASK	GENMASK(29, 28) /* Receive Clock Polarity Select */
+#define SICTR_TSCKIZ_POL	BIT(30)		/*   Transmit Clock Polarity */
+#define SICTR_RSCKIZ		GENMASK(29, 28) /* Receive Clock Polarity Select */
 #define SICTR_RSCKIZ_SCK	BIT(29)		/*   Must match CTR_TSCKIZ_SCK */
-#define SICTR_RSCKIZ_POL_SHIFT	28		/*   Receive Clock Polarity */
-#define SICTR_TEDG_SHIFT	27		/* Transmit Timing (1 = falling edge) */
-#define SICTR_REDG_SHIFT	26		/* Receive Timing (1 = falling edge) */
-#define SICTR_TXDIZ_MASK	GENMASK(23, 22)	/* Pin Output When TX is Disabled */
-#define SICTR_TXDIZ_LOW		(0 << 22)	/*   0 */
-#define SICTR_TXDIZ_HIGH	(1 << 22)	/*   1 */
-#define SICTR_TXDIZ_HIZ		(2 << 22)	/*   High-impedance */
+#define SICTR_RSCKIZ_POL	BIT(28)		/*   Receive Clock Polarity */
+#define SICTR_TEDG		BIT(27)		/* Transmit Timing (1 = falling edge) */
+#define SICTR_REDG		BIT(26)		/* Receive Timing (1 = falling edge) */
+#define SICTR_TXDIZ		GENMASK(23, 22)	/* Pin Output When TX is Disabled */
+#define SICTR_TXDIZ_LOW		0U		/*   0 */
+#define SICTR_TXDIZ_HIGH	1U		/*   1 */
+#define SICTR_TXDIZ_HIZ		2U		/*   High-impedance */
 #define SICTR_TSCKE		BIT(15)		/* Transmit Serial Clock Output Enable */
 #define SICTR_TFSE		BIT(14)		/* Transmit Frame Sync Signal Output Enable */
 #define SICTR_TXE		BIT(9)		/* Transmit Enable */
@@ -382,14 +382,15 @@ static void sh_msiof_spi_set_pin_regs(struct sh_msiof_spi_priv *p, u32 ss,
 	sh_msiof_write(p, SIRMDR1, tmp);
 
 	tmp = 0;
-	tmp |= SICTR_TSCKIZ_SCK | cpol << SICTR_TSCKIZ_POL_SHIFT;
-	tmp |= SICTR_RSCKIZ_SCK | cpol << SICTR_RSCKIZ_POL_SHIFT;
+	tmp |= SICTR_TSCKIZ_SCK | FIELD_PREP(SICTR_TSCKIZ_POL, cpol);
+	tmp |= SICTR_RSCKIZ_SCK | FIELD_PREP(SICTR_RSCKIZ_POL, cpol);
 
 	edge = cpol ^ !cpha;
 
-	tmp |= edge << SICTR_TEDG_SHIFT;
-	tmp |= edge << SICTR_REDG_SHIFT;
-	tmp |= tx_hi_z ? SICTR_TXDIZ_HIZ : SICTR_TXDIZ_LOW;
+	tmp |= FIELD_PREP(SICTR_TEDG, edge);
+	tmp |= FIELD_PREP(SICTR_REDG, edge);
+	tmp |= FIELD_PREP(SICTR_TXDIZ,
+			  tx_hi_z ? SICTR_TXDIZ_HIZ : SICTR_TXDIZ_LOW);
 	sh_msiof_write(p, SICTR, tmp);
 }
 
-- 
2.43.0


