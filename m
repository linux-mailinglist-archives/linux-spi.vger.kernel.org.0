Return-Path: <linux-spi+bounces-8550-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EEFAD93BC
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 19:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36065188B30D
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 17:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC54B1F4722;
	Fri, 13 Jun 2025 17:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rElbI7LX"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06DE1DE3D6;
	Fri, 13 Jun 2025 17:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749835443; cv=none; b=LAG2PnhpHEIlup2LemoI7LrGHX6cs8yit/ZLHI5ZWGIkLO60Ysjwh9Lqp0De145tkeUJL15lkWRy5aki8bxtfOqRgALCRAqyv+x6PjJEETEhXPUQSyExZeZnsMOrDTgDBJ/brrR2PzxfxAeoGTlpQAndkQCZjOUrx+OLU6RExiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749835443; c=relaxed/simple;
	bh=BHv4FZ2RKkUXVAc8+iK0FCz2f0vExdZ7AbSQmQUHUkU=;
	h=Message-ID:From:To:Cc:Subject:Date; b=cXa5wiwh4i7zi/qV1gdkU4OZsWtCmoq6+JFWv3IVTCCm+i70eXOOaV1lPGzjwOgV4CYD/IEXhFuxbBR36ZpcEXoSPRLZnU3A+39VonGvY3141pOsIWR999tt4W9l0rFfG+nvK31B7D4U2lj/CdEarhP2o5xowqTFiro7hRVWkU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rElbI7LX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A54C4CEE3;
	Fri, 13 Jun 2025 17:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749835443;
	bh=BHv4FZ2RKkUXVAc8+iK0FCz2f0vExdZ7AbSQmQUHUkU=;
	h=From:To:Cc:Subject:Date:From;
	b=rElbI7LX9zkpN4F7hFliTEexbMMaR70UHdAFH39OdyN2uTLych7/YzrfGsCMxSANI
	 RVEiQ5pyJNwibj3elih5EzX03q1dDo+0ghBlIV1J8vZEBC9MkFCn1FWgHBNA5uv5vW
	 FrBmoNNcl5ZCqlLJ8X79R7c1+Fb+SP+5+2yYySSRlqZP7u2Fei9PvibJ+YvELnPWuN
	 LblgYgft2CcVxoXyQbpUyWN0/c56n7Cwt+ZIU2IR+3EHL/UT22YIN8rsHdgtg3HdAz
	 R04iM5rNphTkrwiWk8Xk23N1V5a3lxxt956EOwW2MGI2BAzIco4/JuUCXRTOFSjEzd
	 x84pASFh0PvkQ==
Message-ID: <6b7c1c97241248c0f3c35512f1150ffd.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.16-rc1
Date: Fri, 13 Jun 2025 18:23:53 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.16-rc1

for you to fetch changes up to 9f0ad43b158d07bc7144d219ceabdea36e28e392:

  spi: spi-pci1xxxx: Drop MSI-X usage as unsupported by DMA engine (2025-06-13 12:25:31 +0100)

----------------------------------------------------------------
spi: Fies for v6.16

A collection of driver specific fixes, most minor apart from the OMAP
ones which disable some recent performance optimisations in some
non-standard cases where we could start driving the bus incorrectly.

The change to the stm32-ospi driver to use the newer reset APIs is a fix
for interactions with other IP sharing the same reset line in some SoCs.

----------------------------------------------------------------
Andres Urian Florez (1):
      spi: offload: check offload ops existence before disabling the trigger

Dan Carpenter (2):
      spi: spi-pci1xxxx: Fix error code in probe
      spi: stm32-ospi: clean up on error in probe()

Félix Piédallu (2):
      spi: omap2-mcspi: Disable multi mode when CS should be kept asserted after message
      spi: omap2-mcspi: Disable multi-mode when the previous message kept CS asserted

Huacai Chen (1):
      spi: loongson: Fix build warnings about export.h

Mark Brown (1):
      SPI: omap2-mcspi: Fix SPI CS behaviour around

Patrice Chotard (1):
      spi: stm32-ospi: Make usage of reset_control_acquire/release() API

Thangaraj Samynathan (1):
      spi: spi-pci1xxxx: Drop MSI-X usage as unsupported by DMA engine

 drivers/spi/spi-loongson-core.c |  1 +
 drivers/spi/spi-offload.c       |  2 +-
 drivers/spi/spi-omap2-mcspi.c   | 30 ++++++++++++++++++------------
 drivers/spi/spi-pci1xxxx.c      |  4 ++--
 drivers/spi/spi-stm32-ospi.c    | 24 +++++++++++++++++++-----
 5 files changed, 41 insertions(+), 20 deletions(-)

