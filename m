Return-Path: <linux-spi+bounces-7847-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9855AA6F21
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 12:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3729C21A4
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 10:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DAD242930;
	Fri,  2 May 2025 10:14:18 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from weierstrass.telenet-ops.be (weierstrass.telenet-ops.be [195.130.137.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE09E23C507
	for <linux-spi@vger.kernel.org>; Fri,  2 May 2025 10:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746180858; cv=none; b=Eqns3jDoEcM4NzGjJQN9riBG5wl8OtDAomDLuEYB0V/gMVsf17yiGk/ybiyDcHP/XC4mUQwz/wt4vjp1Xj176ZPflbjbPMBsc1fVzjcLr8wwxobnliE8ONOScVVWuxDJTbAjcfA5xi95S5nwytWNPgCy9dqk0a7mONX88idWNLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746180858; c=relaxed/simple;
	bh=rtpMKSBdw7G6oomPP3AMvIJqgODpki9kuFP581HfOLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=daqu3d8pu6b/2+YQZ7cPxx+JUL7V+yqvyLroiyPnjoWr7YF/+L8A29EZV3aE/CmXGsBa+i5jawaXdwlQUYOm/JR4t/lF0kQv6bGRN/5vsYnnX5/lkIy5tKGFd6pPChtIA/TTWY5AFirnBhb5CUxgp7akZNOUMmj3gDUxoJ4GKRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
	by weierstrass.telenet-ops.be (Postfix) with ESMTPS id 4Zpmwx0ZjFz4x67R
	for <linux-spi@vger.kernel.org>; Fri, 02 May 2025 12:14:09 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:df64:35e8:502:4ac0])
	by xavier.telenet-ops.be with cmsmtp
	id kAE02E00C4sst1101AE0iZ; Fri, 02 May 2025 12:14:00 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uAnP1-00000000W9G-2l3t;
	Fri, 02 May 2025 12:14:00 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uAnP6-00000008oWA-0IU2;
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
Subject: [PATCH 00/22] spi: sh-msiof: Transfer size improvements and I2S reuse
Date: Fri,  2 May 2025 12:13:32 +0200
Message-ID: <cover.1746180072.git.geert+renesas@glider.be>
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

Note that the driver uses the limitations as specified in the hardware
documentation.  For discovering the actual FIFO sizes, I wrote some
crude test code that can be found at [1].

This is based on spi/for-next and sound-asoc/for-next, and has been
tested on a variery of R-Car SoCs.

Thanks for your comments!

[1] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/log/?h=topic/msiof-fifo

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

 drivers/spi/spi-sh-msiof.c     | 358 +++++++++++++--------------------
 include/linux/spi/sh_msiof.h   | 122 +++++++++++
 sound/soc/renesas/rcar/msiof.c |  94 +++------
 3 files changed, 285 insertions(+), 289 deletions(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

