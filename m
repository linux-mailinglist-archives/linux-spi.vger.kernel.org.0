Return-Path: <linux-spi+bounces-7826-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4176FAA6EF6
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 12:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8CA0463CCD
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 10:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECA423C51B;
	Fri,  2 May 2025 10:14:15 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [195.130.132.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76033238C1D
	for <linux-spi@vger.kernel.org>; Fri,  2 May 2025 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746180852; cv=none; b=D2xnBmesJ1VhUN61Mk2Li3lKwdeYeKGBX65LXnJLtT9mYiSChfa1BHmIc47tJrXlxpW7oHAQJK45tZ7T1fvJQSeE8bR6K6QT8uwFcjuYK1Uo7knUtjwGzhsqPIgEFB0PA2UWJLhIE2fmM42cvu7NWu3EWon9kIYvUnxO3l7paP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746180852; c=relaxed/simple;
	bh=nnDwnDiCapc1iphoKutSv42+hHraKof+ziaq2QiNBFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bF0/veaJAmYBX11r28cHVwTM4iFs6WNDCMXg8B8Zze2RHZ+z4mpNh4LP8Z2ifxyycuW4jnnJHEiXTe4pzbEu3a8t64eSMlrujIj9Olw5S8mE1Wg5TnddTdwktNujth5DuAnF4QuOJd3+lB34SUJWI33tnfgiFgLprMThTVYBn5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
	by cantor.telenet-ops.be (Postfix) with ESMTPS id 4Zpmwn06qSz4x5HM
	for <linux-spi@vger.kernel.org>; Fri, 02 May 2025 12:14:01 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:df64:35e8:502:4ac0])
	by andre.telenet-ops.be with cmsmtp
	id kAE02E00k4sst1101AE0RM; Fri, 02 May 2025 12:14:00 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uAnP2-00000000WAG-0UGl;
	Fri, 02 May 2025 12:14:00 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uAnP6-00000008oXO-2TP3;
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
Subject: [PATCH 16/22] spi: sh-msiof: Correct RX FIFO size for R-Car Gen3
Date: Fri,  2 May 2025 12:13:48 +0200
Message-ID: <25d41fd2e9295b74d09f3fab7722214109b38908.1746180072.git.geert+renesas@glider.be>
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

According to the R-Car Gen3 Hardware Manual Errata for Rev 0.55 of
September 28, 2017, the MSIOF receive FIFOs on R-Car Gen3 SoCs have room
for 256 words of 32 bits.

Note that this change has no actual impact on the behavior of the
driver, as SPI_CONTROLLER_MUST_TX is set, and transfer size is currenty
limited to the minimum of the transmit and receive FIFO sizes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-sh-msiof.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 8d18a26128d600f6..8afb7c1f64cd4486 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1108,7 +1108,7 @@ static const struct sh_msiof_chipdata rcar_gen3_data = {
 	.bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16) |
 			      SPI_BPW_MASK(24) | SPI_BPW_MASK(32),
 	.tx_fifo_size = 64,
-	.rx_fifo_size = 64,
+	.rx_fifo_size = 256,
 	.ctlr_flags = SPI_CONTROLLER_MUST_TX,
 	.min_div_pow = 1,
 };
@@ -1117,7 +1117,7 @@ static const struct sh_msiof_chipdata rcar_r8a7795_data = {
 	.bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16) |
 			      SPI_BPW_MASK(24) | SPI_BPW_MASK(32),
 	.tx_fifo_size = 64,
-	.rx_fifo_size = 64,
+	.rx_fifo_size = 256,
 	.ctlr_flags = SPI_CONTROLLER_MUST_TX,
 	.min_div_pow = 1,
 	.flags = SH_MSIOF_FLAG_FIXED_DTDL_200,
-- 
2.43.0


