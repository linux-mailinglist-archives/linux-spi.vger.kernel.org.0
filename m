Return-Path: <linux-spi+bounces-7828-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F454AA6EFA
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 12:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 538FE1BC451D
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 10:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0814023E342;
	Fri,  2 May 2025 10:14:16 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from riemann.telenet-ops.be (riemann.telenet-ops.be [195.130.137.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC06239086
	for <linux-spi@vger.kernel.org>; Fri,  2 May 2025 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746180853; cv=none; b=ipYccK0OZLAzWpJzdAe+2gwDCxZ3+dLb0hAlP2u37nySaWR2JgUofJXT6+wW0prpBf4I6Fl29DH7sN6CiXjzPIQzpGKvvm7lj+wsAgg63zTB8USHsxMIyVXOOOxkOyf2KXfWm7LYNaExIJJp1iiLCTrgvK6Am2gUlbYiOBn2pZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746180853; c=relaxed/simple;
	bh=SzXMf1ZgFlGplr5nm3abuFttP6lJHZ7f0w06FE44j2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ul8cwpNTIk4JWl94/E5erHbXDrok0xREdsM6DyZtzc+FA6TqqVKdnt2opgBPiL1mU8k/zryHoxPQLHcWf2bMPQnhRp8enrC4F4XOmka+0Gqh8mFmBTAo48qT8S1lG1zlAD0B/SH22G+ydIrptcrNb203eBinz4WGbP8mVE9jQ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
	by riemann.telenet-ops.be (Postfix) with ESMTPS id 4Zpmwn0LGRz4x5fy
	for <linux-spi@vger.kernel.org>; Fri, 02 May 2025 12:14:01 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:df64:35e8:502:4ac0])
	by andre.telenet-ops.be with cmsmtp
	id kAE02E00j4sst1101AE0RL; Fri, 02 May 2025 12:14:00 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uAnP2-00000000WAC-0NpE;
	Fri, 02 May 2025 12:14:00 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uAnP6-00000008oXJ-2MRW;
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
Subject: [PATCH 15/22] spi: sh-msiof: Correct RX FIFO size for R-Car Gen2
Date: Fri,  2 May 2025 12:13:47 +0200
Message-ID: <00b38f543d57efcda912e391fa358b42bd29f83b.1746180072.git.geert+renesas@glider.be>
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

According to Renesas Technical Updates TN-RCS-S068A/E, the MSIOF receive
FIFOs on R-Car Gen2 SoCs have room for 128 words of 32 bits.

Note that this change has no actual impact on the behavior of the
driver, as SPI_CONTROLLER_MUST_TX is set, and transfer size is currenty
limited to the minimum of the transmit and receive FIFO sizes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-sh-msiof.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index ea9277ab87f66cd5..8d18a26128d600f6 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1099,7 +1099,7 @@ static const struct sh_msiof_chipdata rcar_gen2_data = {
 	.bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16) |
 			      SPI_BPW_MASK(24) | SPI_BPW_MASK(32),
 	.tx_fifo_size = 64,
-	.rx_fifo_size = 64,
+	.rx_fifo_size = 128,
 	.ctlr_flags = SPI_CONTROLLER_MUST_TX,
 	.min_div_pow = 0,
 };
-- 
2.43.0


