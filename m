Return-Path: <linux-spi+bounces-8175-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F12AB9D8A
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 15:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4570E3AADB8
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 13:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C377470823;
	Fri, 16 May 2025 13:32:48 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [195.130.132.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5668C7263C
	for <linux-spi@vger.kernel.org>; Fri, 16 May 2025 13:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402368; cv=none; b=Uq6qyJks9KjJwJA47z9PA08Z+1fDsMWFfAdpIHCfuqRoGqz8OcBpcw9AwYU8iCGwYmpHDoJqJeZP9R9ke1vbKtjWWoeZgrprbnc+t0K1H+ELFdOA8nKhA+fBaR5mlPmPAXBgUv86oGH4Zrgm6ZCb4s1ip8seJNZOi5VbD7zuv4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402368; c=relaxed/simple;
	bh=HtteoMpXwZumxvkhLX0UpbrbT4fRDbTpJ3wPmMXkYtc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TZrtxjReWMyspzv4diIc+zf9+WrxRjqKL5WZL9iG8kIhweTxqb7yKHf5gpszWNEQe916g2oVHY6a4IfOQi/buVsOxy1C3xYWpg6hlBJc7uWfgEZ2gdeRqgxwwucqLWDfJCjElQvRO9eegLGt55FWHNpyF5ddaUVQN49r/tsfJsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
	by cantor.telenet-ops.be (Postfix) with ESMTPS id 4ZzSgP3wK8z4xBbR
	for <linux-spi@vger.kernel.org>; Fri, 16 May 2025 15:32:33 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:b0d6:ccd4:58dc:70fd])
	by albert.telenet-ops.be with cmsmtp
	id ppYX2E0083S8nz406pYXwv; Fri, 16 May 2025 15:32:33 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uFvAi-000000020iJ-0dAn;
	Fri, 16 May 2025 15:32:31 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uFvAt-00000001522-23dN;
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
Subject: [PATCH v2 00/22] spi: sh-msiof: Transfer size improvements and I2S reuse
Date: Fri, 16 May 2025 15:32:03 +0200
Message-ID: <cover.1747401908.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi all,

This patch series (A) improves single transfer sizes in the MSIOF
driver, using two methods:
  - By increasing the assumed FIFO sizes, impacting both PIO and DMA
    transfers,
  - By using two groups, impacting DMA transfers,
and (B) lets the recently-introduced MSIOF I2S drive reuse the SPI
driver's register definitions.  All of this is covered with a thick
sauce of fixes for (harmless) bugs, cleanups, and refactorings.

Changes compared to v1[1]:
  - Make include/linux/spi/sh_msiof.h self-contained,
  - Add Tested-by for the sound part.

Note that the driver uses the limitations as specified in the hardware
documentation.  For discovering the actual FIFO sizes, I wrote some
crude test code that can be found at [2].

This is based on spi/for-next and sound-asoc/for-next, and has been
tested on a variery of R-Car SoCs.

Thanks for your comments!

[1] https://lore.kernel.org/cover.1746180072.git.geert+renesas@glider.be
[2] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/log/?h=topic/msiof-fifo

Geert Uytterhoeven (22):
  spi: sh-msiof: Drop comma after OF match table sentinel
  spi: sh-msiof: Remove unneeded compatible values
  spi: sh-msiof: Fix maximum DMA transfer size
  spi: sh-msiof: Complete using dev in sh_msiof_spi_probe()
  spi: sh-msiof: Use bool for boolean flags
  spi: sh-msiof: Make words/bits unsigned in sh_msiof_spi_txrx_once()
  spi: sh-msiof: Make words/fs unsigned in FIFO helpers
  spi: sh-msiof: SITMDR1/SIRMDR1 bitfield conversion
  spi: sh-msiof: SITMDR2 and SIRMDR2 bitfield conversion
  spi: sh-msiof: SITSCR/SIRSCR bitfield conversion
  spi: sh-msiof: SICTR bitfield conversion
  spi: sh-msiof: SIFCTR bitfield conversion
  spi: sh-msiof: Correct SIMDR2_GRPMASK
  spi: sh-msiof: Add core support for dual-group transfers
  spi: sh-msiof: Correct RX FIFO size for R-Car Gen2
  spi: sh-msiof: Correct RX FIFO size for R-Car Gen3
  spi: sh-msiof: Increase TX FIFO size for R-Car V4H/V4M
  spi: sh-msiof: Simplify BRG's Division Ratio
  spi: sh-msiof: Double maximum DMA transfer size using two groups
  spi: sh-msiof: Document frame start sync pulse mode
  spi: sh-msiof: Move register definitions to <linux/spi/sh_msiof.h>
  ASoC: renesas: msiof: Convert to <linux/spi/sh_msiof.h>

 drivers/spi/spi-sh-msiof.c     | 357 +++++++++++++--------------------
 include/linux/spi/sh_msiof.h   | 125 ++++++++++++
 sound/soc/renesas/rcar/msiof.c |  94 +++------
 3 files changed, 287 insertions(+), 289 deletions(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

