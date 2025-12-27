Return-Path: <linux-spi+bounces-12143-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72055CDF884
	for <lists+linux-spi@lfdr.de>; Sat, 27 Dec 2025 12:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B0253005BB9
	for <lists+linux-spi@lfdr.de>; Sat, 27 Dec 2025 11:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C131D2F362A;
	Sat, 27 Dec 2025 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZldIHC75"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8B42F0C6E;
	Sat, 27 Dec 2025 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766833830; cv=none; b=K7fIKhvGCAAJuQ8BwnKtKhBnIqWhmi/w4AnbDNRDvdLeUrnQa55F5oNtzVCRNX7pkduVNNW3tdrtqlKbA0wW+wINa/t5JUJAjy1rvsumQHvc9KVVxRxGrMFeyt4kUNPScPHocczDFTyEJ5BIOgneZ4rK2WuloxlkX18mh2KASTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766833830; c=relaxed/simple;
	bh=Pxinoarg3WZ7vUyqaSycBFfx07LX79J09U00W2RfA4g=;
	h=From:To:Cc:Subject:Date:Message-Id; b=SDhnd06cRK+qhAGiuxGGHih3Dpu/BuRGf3icIV0H5oMU7pSheNRUjiEWG+5kfVCH2BAN8U3Ei2g/rE1D4FUzaYdb46J1q88u3Pgvgi7KiwhG2dUmbwBCTOPXD5hZ+Tdk9WSZrTo03Zd8fAiHNk/UifEVr/BXJO8gM3JkPKEkX2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZldIHC75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7575C4CEFB;
	Sat, 27 Dec 2025 11:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766833829;
	bh=Pxinoarg3WZ7vUyqaSycBFfx07LX79J09U00W2RfA4g=;
	h=From:To:Cc:Subject:Date:From;
	b=ZldIHC75ahLfdHNkSyyAT6MQDEIs59IOKomRBR4QQJGsOO8vFk7bD2w15fNoFPxXn
	 b8R2J2YraBdsxG+0h47v/Vdgw4CcHtwKGzTqSAlTDMvRoZIeOrMDjizVcdPGs9NfZm
	 mXvD+UiX0DDV9OiNGgTm/xBCG4kr01oxkRoRzBDiP5F69fb0oxkJmYNjXGNU3MuwqM
	 7LC/CMEc9QIi+HIUnLZ7OzSKB6OeePGgEdcxZ9rwuhAtdtkTnZqqd76+E5nfhSs6eC
	 LYmHSSuwnT9m8kY6ESrF5ZbDScdy90XCBlFSmf8Twiv/PUwd9kiTQKFRx6O4ESpdWW
	 y7J821PkJEtzA==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 7C5791AC56B4; Sat, 27 Dec 2025 20:10:23 +0900 (JST)
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.19-rc2
Date: Sat, 27 Dec 2025 11:10:18 +0000
Message-Id: <20251227111023.7C5791AC56B4@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 9448598b22c50c8a5bb77a9103e2d49f134c9578:

  Linux 6.19-rc2 (2025-12-21 15:52:04 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.19-rc2

for you to fetch changes up to b005d618c8547b7dfb14e83a1b410a6a04ac36c6:

  spi: cadence-quadspi: Prevent indirect read (2025-12-23 15:18:22 +0000)

----------------------------------------------------------------
spi: Fixes for v6.19

We've got more fixes here for the Cadence QSPI controller, this time
fixing some issues that come up when working with slower flashes on some
platforms plus a general race condition.

We also add support for the Allwinner A523, this is just some new
compatibles.

----------------------------------------------------------------
Chen-Yu Tsai (2):
      spi: dt-bindings: sun6i: Add compatibles for A523's SPI controllers
      spi: sun6i: Support A523's SPI controllers

Mark Brown (1):
      spi: cadence-quadspi: Prevent indirect read

Mateusz Litwin (2):
      spi: cadence-quadspi: Prevent lost complete() call during indirect read
      spi: cadence-quadspi: Improve CQSPI_SLOW_SRAM quirk if flash is slow

 .../bindings/spi/allwinner,sun6i-a31-spi.yaml      |  4 ++++
 drivers/spi/spi-cadence-quadspi.c                  | 23 +++++++++++-----------
 drivers/spi/spi-sun6i.c                            | 11 +++++++----
 3 files changed, 22 insertions(+), 16 deletions(-)

