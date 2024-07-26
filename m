Return-Path: <linux-spi+bounces-4013-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F04D93D86D
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jul 2024 20:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5511F249C0
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jul 2024 18:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0233BBF4;
	Fri, 26 Jul 2024 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyNc01my"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A3F3A1DC;
	Fri, 26 Jul 2024 18:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722019142; cv=none; b=tWCtxWjeKWwUY76QxgeLOrB6HpALiS0Yh7oGI/+g8PPMhZifJhv0BD2zwSenlqTnLtBch8nuT4z9nNmJ77+wR5HDZ2noraj9IPg1l/CT9XpIFwI6kYwd6QpzEPlkSULDsgQVnboxhhDnD+6YOthsVmKHwlgb5RqzWKgDL6J8/mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722019142; c=relaxed/simple;
	bh=Vsg5y8daZVUKgFBS8/PBVEbLVWxUX3hNaa7iZO3dLS4=;
	h=Message-ID:From:To:Cc:Subject:Date; b=twYqUmpKDTPbKfDc3cP2cHRtk2pVfHKZ7dkc54Gj0U20TKvOVoftsMJ1MConAgL6GvTOCpdFSwKKjlsS7hYC0yj05asPScbcyQfInUQn+gZkH3IU114j31IhPjnFbEPcv2VYHoScBRxJdMBGbu42dfinE4lyJAk3f2e18STkxuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyNc01my; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29356C32782;
	Fri, 26 Jul 2024 18:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722019141;
	bh=Vsg5y8daZVUKgFBS8/PBVEbLVWxUX3hNaa7iZO3dLS4=;
	h=From:To:Cc:Subject:Date:From;
	b=GyNc01my3WYplCkK8RcriDlHOEcd2/2/W5xKRdR1Ktcmk/l3hAHZ4QV6169Rq9ul7
	 1ZK5qqcSdqEMolQ2/UHrbQPKRQUkUx8XmK1BMlxk4zgo3epqIh7HQHE2xb8crblB/7
	 Oz6lS+aShAT4k+L36K/4klHLOus5FUZF4FaQDA/o9C1fqigZMMfle63mPZEwHmUl22
	 2B0lfPs1I5XVOu6XamYOxTcStdDkfnak74Y0s5PG4b429m9AsS3MdPi9jPPxmfAmjy
	 SZ64By9p8GcrZzwBGbBfHGr5epdxrpSpkR3H6QEGTv6b8UmVaVjuD1qdSYI0HeZPDg
	 DZ8aVvQ59DM7w==
Message-ID: <bf741d1595d001bdd140a858fb45134a.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.11-merge-window
Date: Fri, 26 Jul 2024 19:38:48 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 3048dc8ba46b7ba11581f2a7e06849af0df13136:

  spi: dt-bindings: at91: Add sama7d65 compatible string (2024-07-12 00:18:43 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.11-merge-window

for you to fetch changes up to fc28d1c1fe3b3e2fbc50834c8f73dda72f6af9fc:

  spi: spidev: add correct compatible for Rohm BH2228FV (2024-07-18 11:17:09 +0100)

----------------------------------------------------------------
spi: Fixes for v6.11

The bulk of this is a series of fixes for the microchip-core driver
mostly originating from one of their customers, I also applied an
additional patch adding support for controlling the word size which came
along with it since it's still the merge window and clearly had a bunch
of fairly thorough testing.

We also have a fix for the compatible used to bind spidev to the
BH2228FV.

----------------------------------------------------------------
Conor Dooley (2):
      dt-bindings: trivial-devices: fix Rohm BH2228FV compatible string
      spi: spidev: add correct compatible for Rohm BH2228FV

Naga Sureshkumar Relli (1):
      spi: microchip-core: fix the issues in the isr

Steve Wilkins (5):
      spi: microchip-core: defer asserting chip select until just before write to TX FIFO
      spi: microchip-core: only disable SPI controller when register value change requires it
      spi: microchip-core: fix init function not setting the master and motorola modes
      spi: microchip-core: ensure TX and RX FIFOs are empty at start of a transfer
      spi: microchip-core: add support for word sizes of 1 to 32 bits

 .../devicetree/bindings/trivial-devices.yaml       |   4 +-
 drivers/spi/spi-microchip-core.c                   | 190 ++++++++++++---------
 drivers/spi/spidev.c                               |   1 +
 3 files changed, 114 insertions(+), 81 deletions(-)

