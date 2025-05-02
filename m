Return-Path: <linux-spi+bounces-7832-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7153AA6F04
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 12:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8809C2EE9
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 10:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D15241665;
	Fri,  2 May 2025 10:14:16 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8813423A99F
	for <linux-spi@vger.kernel.org>; Fri,  2 May 2025 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746180854; cv=none; b=isbx3TPlDA5V4N+3jUZSd5UAEnGlzAWTnXAADYSLlFaWBatIjCeEBC+/h5cGHQqjsoDne5jXdZBTBCBseM65eoq2QxeIfDd+JwJ1tIae01iPHvEpYS9CduJfSwtGJhnE8QerFqiil87DHMzdsIunVPzo5OUEWMZ2xHMKVSsLL4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746180854; c=relaxed/simple;
	bh=Uochf4KKNuwQgGEjS89zcQx6YDh5QgNaP5jQSiROLbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZvxGlmYd7msvkyvBHAhidqG5J34rC0M90qZme25kdfCgn84q30mHKlZeaYO2YEbuA0RGIT3v0ZIvfUmjNcz4wbnRBRXegvqxUGv30J8HXbBVRn/7Cl1+6HZvXPNFLTlqiNECJJo0FEgzAMy48+wdSg+LSucJzKVPGBPtg964+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:df64:35e8:502:4ac0])
	by baptiste.telenet-ops.be with cmsmtp
	id kAE02E00S4sst1101AE0qE; Fri, 02 May 2025 12:14:00 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uAnP1-00000000W9x-41FM;
	Fri, 02 May 2025 12:14:00 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uAnP6-00000008oWz-1hAe;
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
Subject: [PATCH 11/22] spi: sh-msiof: SICTR bitfield conversion
Date: Fri,  2 May 2025 12:13:43 +0200
Message-ID: <adca6403a4738f1b6bc217f34f01f5704c905691.1746180072.git.geert+renesas@glider.be>
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

Convert MSIOF Control Register field accesses to use the FIELD_PREP()
bitfield access macro.

This gets rid of explicit shifts.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
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


