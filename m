Return-Path: <linux-spi+bounces-8679-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A738DAE1014
	for <lists+linux-spi@lfdr.de>; Fri, 20 Jun 2025 01:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC6D23B79E1
	for <lists+linux-spi@lfdr.de>; Thu, 19 Jun 2025 23:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF13C2253FC;
	Thu, 19 Jun 2025 23:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1c8Bedg"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C302248AA;
	Thu, 19 Jun 2025 23:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750376259; cv=none; b=OQQkODPuZ4cqBVa32Je6YmFsWuxhLgm/U7kt7/6mRdOWE0ozfBiS4TAcwigV7XnWJ+9zBRK/S5D4hAEU+ZsUvtSIPu9RQiOmPF8lIUJGCcmUWMvbJkwU4xs6HM/mGBsdWYvIrU8/R3uZmh2skUoHLS4qqhDF+CXTdhQcbGTo7+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750376259; c=relaxed/simple;
	bh=nE358TQi72UPUUeLFthC8tDYL3NhT2BMlR4SjOv2OPs=;
	h=Message-ID:From:To:Cc:Subject:Date; b=bFmf+iTu3C50plIQVXtXKcBKfX5QcYH7AHgQJ+fpAM/bkgvzkPakySI26f1vPaYdv1X032mKCPois7Ae/ZjCarUKbu44fafodx/yrLO5CImgcKc3enXWmbw69HPGQUuXiJw6UxPvz9AYXBYBgE+nmJ3VsXlsaML00yEQi70ZQ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1c8Bedg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0D8C4CEEA;
	Thu, 19 Jun 2025 23:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750376259;
	bh=nE358TQi72UPUUeLFthC8tDYL3NhT2BMlR4SjOv2OPs=;
	h=From:To:Cc:Subject:Date:From;
	b=V1c8BedgCt8XKDXIdSpRB4iQZLyctmlhz7MMoP8eknTJBoqdveoEQ9ZkT3pQj2t16
	 hD0zEHwbdkbQBufcnbbcN2iZEtRrde3fxvbHO0PU5KOZqtKdiSYDBPuwAv0va5+rMJ
	 6fsS7RjsmrbWrI4RnsSulOw9go25YuC7aR1SddkaruuGdcUx3272i9OquU7OJXwp4k
	 F2/Gebk7L3Li3jb5us/r5lYGInvqkJfcBZ5ws5u8TqbAXAQ1HMZ9rVQav2fP1Gop+K
	 Ukt1jbJY/joHZtSFppydo0LjjBVPpCeSa+3o9uX5/pHgoDjf3gO0MvcSp25qN/D04h
	 LqvejIN8ca7DA==
Message-ID: <2028a8ec593d05f1a11300d8bfb000f8.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.16-rc2
Date: Fri, 20 Jun 2025 00:37:33 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 9f0ad43b158d07bc7144d219ceabdea36e28e392:

  spi: spi-pci1xxxx: Drop MSI-X usage as unsupported by DMA engine (2025-06-13 12:25:31 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.16-rc2

for you to fetch changes up to d57e92dd660014ccac884eda616cafc7b04601e0:

  spi: tegra210-qspi: Remove cache operations (2025-06-13 17:30:56 +0100)

----------------------------------------------------------------
spi: Fix for v6.16

One fix here from Thierry, fixing crashes caused by attempting to do
cache sync operations on uncached memory on Tegra platforms.

----------------------------------------------------------------
Thierry Reding (1):
      spi: tegra210-qspi: Remove cache operations

 drivers/spi/spi-tegra210-quad.c | 14 --------------
 1 file changed, 14 deletions(-)

