Return-Path: <linux-spi+bounces-8154-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A30AB9D6B
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 15:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D22F07B4FA6
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 13:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC54200A3;
	Fri, 16 May 2025 13:32:37 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4997811CAF
	for <linux-spi@vger.kernel.org>; Fri, 16 May 2025 13:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402357; cv=none; b=JY23xuTVXnA1wkJgXld++QMkSjMi0NAjABC5WRUsEiZredfrKRlnF2OlOZLkGd0Yd//BoCsppNf9xOamJtAJ53kYVeypAE4Ev6dholQmAmmQuRqTP7YeGkMWTZ89zGqTUVgXL+o6eOT0G0sHDfkysVgq0A6bYjGwdRt2DV3Et3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402357; c=relaxed/simple;
	bh=x1puk1ZFl1FwUZ/v7ztHeHybvqbpZ68TydGFBgHL1hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6QoOM2a2D33gPhRrjj6S4IC1F8btP0FXIDTXBsI9Df8saGiGDAPFpGgnb4Btt+MTZSuYzCnrSO2KMToFBLaUW12EqEFSZo5ujqbGGiapVdkNT4kEzMEb8zezuZLljKaMSMTjp9p/A6zJ35myEiIFXzWTnDFL++l8kyEekJ0BVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:b0d6:ccd4:58dc:70fd])
	by baptiste.telenet-ops.be with cmsmtp
	id ppYY2E0063S8nz401pYYVT; Fri, 16 May 2025 15:32:33 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uFvAi-000000020jJ-2KKJ;
	Fri, 16 May 2025 15:32:32 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uFvAt-0000000153G-3ykH;
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
Subject: [PATCH v2 16/22] spi: sh-msiof: Correct RX FIFO size for R-Car Gen3
Date: Fri, 16 May 2025 15:32:19 +0200
Message-ID: <6f74508ea4681aa0b7c6bf6810eab026725e75a3.1747401908.git.geert+renesas@glider.be>
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

According to the R-Car Gen3 Hardware Manual Errata for Rev 0.55 of
September 28, 2017, the MSIOF receive FIFOs on R-Car Gen3 SoCs have room
for 256 words of 32 bits.

Note that this change has no actual impact on the behavior of the
driver, as SPI_CONTROLLER_MUST_TX is set, and transfer size is currenty
limited to the minimum of the transmit and receive FIFO sizes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.
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


