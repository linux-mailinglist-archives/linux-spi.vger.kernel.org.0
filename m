Return-Path: <linux-spi+bounces-10326-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C9DBA7025
	for <lists+linux-spi@lfdr.de>; Sun, 28 Sep 2025 13:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EA0E7A1309
	for <lists+linux-spi@lfdr.de>; Sun, 28 Sep 2025 11:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD842DCF6B;
	Sun, 28 Sep 2025 11:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUISn9Vy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426281C1F05;
	Sun, 28 Sep 2025 11:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759060421; cv=none; b=IZwdVejLPQSEwSIq+FUZR7fKtJzx/HTGcf8+xpmgVvfIsyJlS58BNQe3jsneMG2piHpeuOPIp0jJTwtiaExA8dpdWK2IiqYRFcNxJGlUcTfE6XVPXOpcwhF1LRL6zZ2iX7LoK/sWa2TojUd1N1FT/z2tvpzPJufHPo1JXFz920M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759060421; c=relaxed/simple;
	bh=hQEJHc4OVq8vuXSSAqvTzJN5UrYFwsmzkeTaEHiIPmk=;
	h=Message-ID:From:To:Cc:Subject:Date; b=neOsE+Y+ZAE+V02EmTg/wk48Bdk5Efhw3YToClDl8bTzzL3bXCyPeigEz+z2H3IE9PlClfVC9DR3XkLS6XbkRWMbw7IHV9LNn8sEiZdVIKE8rOkFCuG5MlwdyPZ/NIp6tUkD2dacKhQtYbMOOHTc4Pj8ouAtCgmKc4mfUdhyDus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUISn9Vy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38BD4C4CEF0;
	Sun, 28 Sep 2025 11:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759060420;
	bh=hQEJHc4OVq8vuXSSAqvTzJN5UrYFwsmzkeTaEHiIPmk=;
	h=From:To:Cc:Subject:Date:From;
	b=QUISn9VyfSHmCwegCAkkuHwbDyZvm8QfwJbPK+Z+23KrkwGhhMPSYn0HFfvj2CxAY
	 le7Aybgzbz4G/Ah5Os1XOw5Ca+Zs0QLWPeWBNcznmqDikMfipj/Uc1+wNyruYGzOK2
	 FDI1Be0bPLkPqgAyW9kJg6Z1LRTk6nezOorwk8aO9a5bMuzYpH6JvjN0rMz7dz+mY2
	 jF2e1HKlhwaSTL8cF6FNd47niAk/jRd73JWg2XGnw0uKw0qK1/z7p2CK0A44Yef3FZ
	 c1K+zyqdAe7zhcBrJh/XEtfMseLYhI9mmbJ8RSWINoTSYO3M2zXrOhxAxygF6wQJBs
	 jhjTNn/XVWqGQ==
Message-ID: <e6994ab73abe36e39ec60eb63341f022@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.17-rc7
Date: Sun, 28 Sep 2025 13:53:26 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit f83ec76bf285bea5727f478a68b894f5543ca76e:

  Linux 6.17-rc6 (2025-09-14 14:21:14 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.17-rc7

for you to fetch changes up to 398a8a4e51dbd03e4103ea596ea4ea037fe67175:

  spi: omap2-mcspi: drive SPI_CLK on transfer_setup() (2025-09-22 09:28:50 +0100)

----------------------------------------------------------------
spi: Final fixes for v6.17

A few final driver specific fixes that have been sitting in -next for a
bit, the OMAP issue is likely to come up very infrequently since mixed
configuration SPI buses are rare and the Cadence issue is specific to
SoCFPGA systems.

----------------------------------------------------------------
Bastien Curutchet (Schneider Electric) (1):
      spi: omap2-mcspi: drive SPI_CLK on transfer_setup()

Khairul Anuar Romli (1):
      spi: cadence-qspi: defer runtime support on socfpga if reset bit is enabled

 drivers/spi/spi-cadence-quadspi.c | 53 ++++++++++++++++++++++++++-------------
 drivers/spi/spi-omap2-mcspi.c     |  1 +
 2 files changed, 37 insertions(+), 17 deletions(-)

