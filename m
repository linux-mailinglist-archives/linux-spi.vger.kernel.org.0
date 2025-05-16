Return-Path: <linux-spi+bounces-8176-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9B1AB9D8D
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 15:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C02633AB282
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 13:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5680060B8A;
	Fri, 16 May 2025 13:32:49 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [195.130.132.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97022CCDB
	for <linux-spi@vger.kernel.org>; Fri, 16 May 2025 13:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402369; cv=none; b=TP51gczZIwpj4py4F/qLfkUIlvxNnEjDTWAD29YOPyCnZORJkde89v8AmYLoEnFiVZj+0n04KRoO6u5dYD1mKFy+Dbx0Aazve8ByIq0SA5yvZOZdsOSKC3u+fUBaisjKD5q47WEFeQ7gTHGo77uHSuB58V92eFEylIWmOmpieuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402369; c=relaxed/simple;
	bh=Abw15zzJtQxJtQmksAX5S4pVBE/v9LqvizbIKz9pUGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aChOiUsH8EHeZakVAytC4LHCkk+P5nB4dg2BrBcKRcd/MWBoYagujvJaKEpuVQ2BjGZSlB2NAd7MFFdTSIz0oSqZF3yjvjkqP0KxmD4CetD6p0hazY+c5xRk8xesDlCNbpTh8X4cJg0rhwKVcHOBS9aG3oLEXw/8A1Nm1YIqDeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
	by cantor.telenet-ops.be (Postfix) with ESMTPS id 4ZzSgP4cRPz4xBbY
	for <linux-spi@vger.kernel.org>; Fri, 16 May 2025 15:32:33 +0200 (CEST)
Received: from ramsan.of.borg ([84.195.187.55])
	by albert.telenet-ops.be with cmsmtp
	id ppYY2E0061C8whw06pYYx7; Fri, 16 May 2025 15:32:33 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uFvAi-000000020jf-2xVV;
	Fri, 16 May 2025 15:32:32 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uFvAu-0000000153k-0Pb0;
	Fri, 16 May 2025 15:32:32 +0200
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
Subject: [PATCH v2 22/22] ASoC: renesas: msiof: Convert to <linux/spi/sh_msiof.h>
Date: Fri, 16 May 2025 15:32:25 +0200
Message-ID: <754ed54057e54effd06143e71d6cd305c3334eca.1747401908.git.geert+renesas@glider.be>
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

Convert the MSIOF I2S driver to reuse the MSIOF register and register
bit definitions in the header file shared by the MSIOF SPI driver.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
Compile-tested and asm-inspected only due to lack of local sound
hardware.

v2:
  - Add Tested-by.
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


