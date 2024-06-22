Return-Path: <linux-spi+bounces-3537-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA321913509
	for <lists+linux-spi@lfdr.de>; Sat, 22 Jun 2024 18:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71F57283493
	for <lists+linux-spi@lfdr.de>; Sat, 22 Jun 2024 16:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A857616F8FB;
	Sat, 22 Jun 2024 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLQgUTGG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA9716C445;
	Sat, 22 Jun 2024 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719073345; cv=none; b=sbiQhcGTNaMRGqH8g0RIwAi6rRs8/VXb4Sa1vFBV38dPo7l/tj5mfPAQXtuA0Yh9YlL5MNp9QTpb9ASGRshJJ0BTDqQD+q7PAnjjy+ArtMr6IbXiD8lMf+GIm4jsb3RT7TtqDguypGuw2UWp9y2fGQ5crZPHeqgHq7VONQ2030M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719073345; c=relaxed/simple;
	bh=v734lrashmmLcmU8CA5SsjdAs6vVjhSTF1u5U4dc/6M=;
	h=Message-ID:From:To:Cc:Subject:Date; b=uNRSncZPEXDIYqpbBPjfiUQ2Z3ulAf+FmjXj0sDAStDZv2rp7DEFu/yIwj7Ov2OCZYriKX1hxaH393DGBlokkItB8q/somCWHqEOb6gJdu/4g9mX7qO1tSIrFy1iWP44YkoC9IK6CJRbeAO9iwHC5l8g428ekHIFhgdANoyMLiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLQgUTGG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9F3C3277B;
	Sat, 22 Jun 2024 16:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719073344;
	bh=v734lrashmmLcmU8CA5SsjdAs6vVjhSTF1u5U4dc/6M=;
	h=From:To:Cc:Subject:Date:From;
	b=ZLQgUTGGEjWzkPXs8+8MN7pE7WjCbMtoTX7gHy8+3qXvps8CmKj1zrpvO+iSXgK8a
	 N6gnUJe2hgyiC9x0aLxgMdItFyg3oFVIFs+b2Zxwcd41B+t5WjfA9zU/jiyWXXv6Qo
	 SVuWjrXE0VgcoszfjcC06XtqRMr6H5PaE8Ib4g7GymPk7rC0xidxgrSX5AtS+yzBol
	 e1OLVupad1tQVP9BWWsO+n0JO5sFqj2jmuYgjbm9QpfSZblr6BZNpMkbua2It15y07
	 hlgCYMXb3QzEu8rtmB3bmq5AbI97Jk6imNvrH3fnLzzDvoddKKqfQpHkI0QqQUN7xr
	 ftltkDHbR3zkA==
Message-ID: <fcab2f718f086fd6e070a6ed65a28900.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.10-rc4
Date: Sat, 22 Jun 2024 17:22:12 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit c3f38fa61af77b49866b006939479069cd451173:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.10-rc4

for you to fetch changes up to df75470b317b46affbe1f5f8f006b34175be9789:

  spi: spi-imx: imx51: revert burst length calculation back to bits_per_word (2024-06-19 14:07:13 +0100)

----------------------------------------------------------------
spi: Fixes for v6.10

A number of fixes that have built up for SPI, a bunch of driver specific
ones including an unfortunate revert of an optimisation for the i.MX
driver which was causing issues with some configurations, plus a couple
of core fixes for the rarely used octal mode and for a bad interaction
between multi-CS support and target mode.

----------------------------------------------------------------
Amit Kumar Mahapatra (1):
      spi: Fix SPI slave probe failure

Charles Keepax (2):
      spi: cs42l43: Correct SPI root clock speed
      spi: cs42l43: Drop cs35l56 SPI speed down to 11MHz

Marc Kleine-Budde (1):
      spi: spi-imx: imx51: revert burst length calculation back to bits_per_word

Patrice Chotard (3):
      spi: stm32: qspi: Fix dual flash mode sanity test in stm32_qspi_setup()
      spi: stm32: qspi: Clamp stm32_qspi_get_mode() output to CCR_BUSWIDTH_4
      spi: Fix OCTAL mode support

 drivers/spi/spi-cs42l43.c    |  6 +++---
 drivers/spi/spi-imx.c        | 14 ++------------
 drivers/spi/spi-stm32-qspi.c | 12 +++++-------
 drivers/spi/spi.c            | 16 ++++++++++------
 include/linux/spi/spi.h      |  5 +++--
 5 files changed, 23 insertions(+), 30 deletions(-)

