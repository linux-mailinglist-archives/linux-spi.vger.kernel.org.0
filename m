Return-Path: <linux-spi+bounces-4158-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F3394D921
	for <lists+linux-spi@lfdr.de>; Sat, 10 Aug 2024 01:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 494E81C2136E
	for <lists+linux-spi@lfdr.de>; Fri,  9 Aug 2024 23:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB2C1BC2A;
	Fri,  9 Aug 2024 23:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edroxebw"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38D743177;
	Fri,  9 Aug 2024 23:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723246462; cv=none; b=ln21rCJQihdVlb3WzjEb2WuvAIC/442VP60R/sD0wBm8XC4b2pUBWkc6s6zuwmu/eZBjZ0pl1jw0nkmX1Vi3EwAo8zmzBaULhTrfe8/gNs1fuL9RJBqcNrP9BFrUajzCP0aDzM6JfrM1zfrqNlerGgvoHr9pojx1WTMsyUOK1e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723246462; c=relaxed/simple;
	bh=Eg1UStVQFXJ314604fpLYcVoInTg3z0oNrpF5rDzsQE=;
	h=Message-ID:From:To:Cc:Subject:Date; b=qbx13wLNqhoNsZtwen2JSGc0jrZyr4kvilAjuh1R8BjmN0GjBapSEhEk818+VVsWAJWGXADeaVdcVVQc4uTBZ99rZOSOj/hilPDwwJOMnw9ZUnfwmNp4ciSDIV/4FXvUAg3kNSO4xqBQ3SQM26Z/hqObHRFiNnv8f4OyADoneDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edroxebw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9EEC32782;
	Fri,  9 Aug 2024 23:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723246462;
	bh=Eg1UStVQFXJ314604fpLYcVoInTg3z0oNrpF5rDzsQE=;
	h=From:To:Cc:Subject:Date:From;
	b=edroxebwOvR+sCydrUxoCbTPQHsH5QSLyGjyw/rmBzvs/MgKfqemxME1VcoaxDk3r
	 /W6m53iCysTbQ28L4HSDKpFS96Y84Ui9rk3GptM3vN/9FZsgXkYwkCfFUwYKpwXPKL
	 xFoE3rHslLzFFrE5ueIEdqgNWXNhJyqkYKF0WswWchJ7Fdx1r66vMhitB4mZo0xtwF
	 ctq8UXpDNRL7drKBTll49QpaUms357rk6ZhEfN3SPDByBjtU4jFOV04JArzgVgAJKz
	 ZMfEgbMePBNjtO89Af/LMez8+9eeJqhOfHlbP6Xg78Ly3MHrGXp3Bobody6o4QXBMm
	 0nOwCIEzBq5NQ==
Message-ID: <265e0ee468ae39e19e2fe1eb64e24386.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.11-rc2
Date: Sat, 10 Aug 2024 00:34:08 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.11-rc2

for you to fetch changes up to 730bbfaf7d4890bd99e637db7767dc68cfeb24e7:

  spi: spi-fsl-lpspi: Fix scldiv calculation (2024-08-07 23:45:12 +0100)

----------------------------------------------------------------
spi: Fixes for v6.11

A few SPI fixes since the merge window, clock rate calculation fixes for
the Kunpeng and lpsi drivers and a missing registration of a device ID
for spidev (which had only been updated for DT cases, causing warnings).

----------------------------------------------------------------
Devyn Liu (2):
      spi: hisi-kunpeng: Add validation for the minimum value of speed_hz
      spi: hisi-kunpeng: Add verification for the max_frequency provided by the firmware

Geert Uytterhoeven (1):
      spi: spidev: Add missing spi_device_id for bh2228fv

Stefan Wahren (1):
      spi: spi-fsl-lpspi: Fix scldiv calculation

 drivers/spi/spi-fsl-lpspi.c    | 6 ++++--
 drivers/spi/spi-hisi-kunpeng.c | 4 ++++
 drivers/spi/spidev.c           | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

