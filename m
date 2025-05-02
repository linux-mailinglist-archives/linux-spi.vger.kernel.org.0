Return-Path: <linux-spi+bounces-7841-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D345FAA6F15
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 12:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D783C4C100E
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 10:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D73241696;
	Fri,  2 May 2025 10:14:17 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from gauss.telenet-ops.be (gauss.telenet-ops.be [195.130.132.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD3723C4FC
	for <linux-spi@vger.kernel.org>; Fri,  2 May 2025 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746180856; cv=none; b=rd5FjZo0p90fYquPQdfCr/0d5hQq7n6wz+0nl60r+8ypc4qJka+tnFpsXSwW5SFWEZ8+xGnhDP4ZkF8iqYZMT/bh+SMD79FPpNVVvDjnrAH7uUm6X5V/HTeBxJG8i4P2rOGIj/ylSmYMJ96mCgSfVKKmkjayngcwA6Pc9KJbIpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746180856; c=relaxed/simple;
	bh=akRFAKXqnDFUi0p3T88kQ+fD54WSZSZV0g6Htm+IHew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=odAfzb9VuOYIez0HuloWhZFl5twjMzXbaH3TSlfzAHdLuNcftSauZ6na0K2vmbTdQZilId5xD8eGXezQASn2ixWXCmxAnv2INhWGq+hSNPurvlWxYlxtEziD2tHrCynmMdu8KoPA21LxLVk7HMtW6DUSzuw0jRkzJMO9tc2EshQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
	by gauss.telenet-ops.be (Postfix) with ESMTPS id 4Zpmwn24wpz4x3kV
	for <linux-spi@vger.kernel.org>; Fri, 02 May 2025 12:14:01 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:df64:35e8:502:4ac0])
	by albert.telenet-ops.be with cmsmtp
	id kAE02E02d4sst1106AE0JZ; Fri, 02 May 2025 12:14:01 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uAnP2-00000000WAe-1N3F;
	Fri, 02 May 2025 12:14:00 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uAnP6-00000008oXs-3M4Z;
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
Subject: [PATCH 22/22] ASoC: renesas: msiof: Convert to <linux/spi/sh_msiof.h>
Date: Fri,  2 May 2025 12:13:54 +0200
Message-ID: <d8dfe7cdd8980e08b9fae51ff9fcddac20eca22b.1746180072.git.geert+renesas@glider.be>
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

Convert the MSIOF I2S driver to reuse the MSIOF register and register
bit definitions in the header file shared by the MSIOF SPI driver.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested and asm-inspected only due to lack of local sound
hardware.
---
 sound/soc/renesas/rcar/msiof.c | 94 ++++++++++------------------------
 1 file changed, 28 insertions(+), 66 deletions(-)

diff --git a/sound/soc/renesas/rcar/msiof.c b/sound/soc/renesas/rcar/msiof.c
index 75c9e91bada10289..36d31ab8ac6a5f18 100644
--- a/sound/soc/renesas/rcar/msiof.c
+++ b/sound/soc/renesas/rcar/msiof.c
@@ -30,56 +30,15 @@
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/spi/sh_msiof.h>
 #include <sound/dmaengine_pcm.h>
 #include <sound/soc.h>
 
-/* register */
-#define SITMDR1		0x00
-#define SITMDR2		0x04
-#define SITMDR3		0x08
-#define SIRMDR1		0x10
-#define SIRMDR2		0x14
-#define SIRMDR3		0x18
-#define SICTR		0x28
-#define SISTR		0x40
-#define SIIER		0x44
-#define SITFDR		0x50
-#define SIRFDR		0x60
-
-/* SITMDR1/ SIRMDR1 */
-#define PCON		(1 << 30)		/* Transfer Signal Connection */
-#define SYNCMD_LR	(3 << 28)		/* L/R mode */
-#define SYNCAC		(1 << 25)		/* Sync Polarity (Active-low) */
-#define DTDL_1		(1 << 20)		/* 1-clock-cycle delay */
-#define TXSTP		(1 <<  0)		/* Transmission/Reception Stop on FIFO */
-
-/* SITMDR2 and SIRMDR2 */
-#define BITLEN1(x)	(((x) - 1) << 24)	/* Data Size (8-32 bits) */
-#define GRP		(1 << 30)		/* Group count */
-
-/* SICTR */
-#define TEDG		(1 << 27)		/* Transmit Timing (1 = falling edge) */
-#define REDG		(1 << 26)		/* Receive  Timing (1 = rising  edge) */
-#define TXE		(1 <<  9)		/* Transmit Enable */
-#define RXE		(1 <<  8)		/* Receive Enable */
-
 /* SISTR */
-#define TFSERR		(1 << 21)		/* Transmit Frame Synchronization Error */
-#define TFOVF		(1 << 20)		/* Transmit FIFO Overflow */
-#define TFUDF		(1 << 19)		/* Transmit FIFO Underflow */
-#define RFSERR		(1 <<  5)		/* Receive Frame Synchronization Error */
-#define RFUDF		(1 <<  4)		/* Receive FIFO Underflow */
-#define RFOVF		(1 <<  3)		/* Receive FIFO Overflow */
-#define SISTR_ERR_TX	(TFSERR | TFOVF | TFUDF)
-#define SISTR_ERR_RX	(RFSERR | RFOVF | RFUDF)
+#define SISTR_ERR_TX	(SISTR_TFSERR | SISTR_TFOVF | SISTR_TFUDF)
+#define SISTR_ERR_RX	(SISTR_RFSERR | SISTR_RFOVF | SISTR_RFUDF)
 #define SISTR_ERR	(SISTR_ERR_TX | SISTR_ERR_RX)
 
-/* SIIER */
-#define TDMAE		(1 << 31)		/* Transmit Data DMA Transfer Req. Enable */
-#define TDREQE		(1 << 28)		/* Transmit Data Transfer Request Enable */
-#define RDMAE		(1 << 15)		/* Receive Data DMA Transfer Req. Enable */
-#define RDREQE		(1 << 12)		/* Receive Data Transfer Request Enable */
-
 /*
  * The data on memory in 24bit case is located at <right> side
  *	[  xxxxxx]
@@ -174,42 +133,45 @@ static int msiof_hw_start(struct snd_soc_component *component,
 
 	/* SITMDRx */
 	if (is_play) {
-		val = PCON | SYNCMD_LR | SYNCAC | TXSTP;
+		val = SITMDR1_PCON |
+		      FIELD_PREP(SIMDR1_SYNCMD, SIMDR1_SYNCMD_LR) |
+		      SIMDR1_SYNCAC | SIMDR1_XXSTP;
 		if (msiof_flag_has(priv, MSIOF_FLAGS_NEED_DELAY))
-			val |= DTDL_1;
+			val |= FIELD_PREP(SIMDR1_DTDL, 1);
 
 		msiof_write(priv, SITMDR1, val);
 
-		val = BITLEN1(width);
-		msiof_write(priv, SITMDR2, val | GRP);
+		val = FIELD_PREP(SIMDR2_BITLEN1, width - 1);
+		msiof_write(priv, SITMDR2, val | FIELD_PREP(SIMDR2_GRP, 1));
 		msiof_write(priv, SITMDR3, val);
 
 	}
 	/* SIRMDRx */
 	else {
-		val = SYNCMD_LR | SYNCAC;
+		val = FIELD_PREP(SIMDR1_SYNCMD, SIMDR1_SYNCMD_LR) |
+		      SIMDR1_SYNCAC;
 		if (msiof_flag_has(priv, MSIOF_FLAGS_NEED_DELAY))
-			val |= DTDL_1;
+			val |= FIELD_PREP(SIMDR1_DTDL, 1);
 
 		msiof_write(priv, SIRMDR1, val);
 
-		val = BITLEN1(width);
-		msiof_write(priv, SIRMDR2, val | GRP);
+		val = FIELD_PREP(SIMDR2_BITLEN1, width - 1);
+		msiof_write(priv, SIRMDR2, val | FIELD_PREP(SIMDR2_GRP, 1));
 		msiof_write(priv, SIRMDR3, val);
 	}
 
 	/* SIIER */
 	if (is_play)
-		val = TDREQE | TDMAE | SISTR_ERR_TX;
+		val = SIIER_TDREQE | SIIER_TDMAE | SISTR_ERR_TX;
 	else
-		val = RDREQE | RDMAE | SISTR_ERR_RX;
+		val = SIIER_RDREQE | SIIER_RDMAE | SISTR_ERR_RX;
 	msiof_update(priv, SIIER, val, val);
 
 	/* SICTR */
 	if (is_play)
-		val = TXE | TEDG;
+		val = SICTR_TXE | SICTR_TEDG;
 	else
-		val = RXE | REDG;
+		val = SICTR_RXE | SICTR_REDG;
 	msiof_update_and_wait(priv, SICTR, val, val, val);
 
 	msiof_status_clear(priv);
@@ -230,9 +192,9 @@ static int msiof_hw_stop(struct snd_soc_component *component,
 
 	/* SIIER */
 	if (is_play)
-		val = TDREQE | TDMAE | SISTR_ERR_TX;
+		val = SIIER_TDREQE | SIIER_TDMAE | SISTR_ERR_TX;
 	else
-		val = RDREQE | RDMAE | SISTR_ERR_RX;
+		val = SIIER_RDREQE | SIIER_RDMAE | SISTR_ERR_RX;
 	msiof_update(priv, SIIER, val, 0);
 
 	/* Stop DMAC */
@@ -240,9 +202,9 @@ static int msiof_hw_stop(struct snd_soc_component *component,
 
 	/* SICTR */
 	if (is_play)
-		val = TXE;
+		val = SICTR_TXE;
 	else
-		val = RXE;
+		val = SICTR_RXE;
 	msiof_update_and_wait(priv, SICTR, val, 0, 0);
 
 	/* indicate error status if exist */
@@ -478,22 +440,22 @@ static irqreturn_t msiof_interrupt(int irq, void *data)
 	substream = priv->substream[SNDRV_PCM_STREAM_PLAYBACK];
 	if (substream && (sistr & SISTR_ERR_TX)) {
 		// snd_pcm_stop_xrun(substream);
-		if (sistr & TFSERR)
+		if (sistr & SISTR_TFSERR)
 			priv->err_syc[SNDRV_PCM_STREAM_PLAYBACK]++;
-		if (sistr & TFOVF)
+		if (sistr & SISTR_TFOVF)
 			priv->err_ovf[SNDRV_PCM_STREAM_PLAYBACK]++;
-		if (sistr & TFUDF)
+		if (sistr & SISTR_TFUDF)
 			priv->err_udf[SNDRV_PCM_STREAM_PLAYBACK]++;
 	}
 
 	substream = priv->substream[SNDRV_PCM_STREAM_CAPTURE];
 	if (substream && (sistr & SISTR_ERR_RX)) {
 		// snd_pcm_stop_xrun(substream);
-		if (sistr & RFSERR)
+		if (sistr & SISTR_RFSERR)
 			priv->err_syc[SNDRV_PCM_STREAM_CAPTURE]++;
-		if (sistr & RFOVF)
+		if (sistr & SISTR_RFOVF)
 			priv->err_ovf[SNDRV_PCM_STREAM_CAPTURE]++;
-		if (sistr & RFUDF)
+		if (sistr & SISTR_RFUDF)
 			priv->err_udf[SNDRV_PCM_STREAM_CAPTURE]++;
 	}
 
-- 
2.43.0


