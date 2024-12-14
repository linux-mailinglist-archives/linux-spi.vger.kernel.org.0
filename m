Return-Path: <linux-spi+bounces-6054-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1E99F1B75
	for <lists+linux-spi@lfdr.de>; Sat, 14 Dec 2024 01:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E16A1188ECE6
	for <lists+linux-spi@lfdr.de>; Sat, 14 Dec 2024 00:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A607489;
	Sat, 14 Dec 2024 00:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSEH1K6x"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCD114012;
	Sat, 14 Dec 2024 00:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734137295; cv=none; b=hv2uX6jgycah7PB9YEMOrc1j6Z44PsWbCkCmcDL3OEf4/2TbR7WwaMIOSUgIZjfc+WAbPko87GrYyLk7fk+hh/nAaJ0n79n0NgVq9evCK7GN4VInk59RSOixgSMcuY8fAYoCbDbB3UTavOFULhqeH8tGpicAg+WqYfU8aNFSmwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734137295; c=relaxed/simple;
	bh=kAL8S3WhNtOoyeJb2difKdwLeu8l0ESDZ74KO4EngkM=;
	h=Message-ID:From:To:Cc:Subject:Date; b=PbqH/lyshu/9o7bMIuRqNdW3BaRvtN+wFVDywtBZWxHobUrmp6U4oum6WWO42tPyBys/oBygJjDJY8NjRdgpreGM+++TfQ/QYy8A6gSKSt2iRo5vA8rxHNCTX9c7G4pA6cWoDUK1Pvj1SfAfmp5C4TBgeMnR0UqbNIXloAn3qzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSEH1K6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033A1C4CED0;
	Sat, 14 Dec 2024 00:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734137294;
	bh=kAL8S3WhNtOoyeJb2difKdwLeu8l0ESDZ74KO4EngkM=;
	h=From:To:Cc:Subject:Date:From;
	b=HSEH1K6x8um3WKCkEviQSXNf9XR/0Akpv1wr5+te1ac8QQAZHe//zxHp+d6a57hMk
	 MzAs3xrpyOzYlj28Zljq0TLMoKcYw17f7umrmuyL+BZLzp597bvCTs0VhKCzQmrpHt
	 AfTvymqNquCeVHjt36Jdy6PX6lzP9p5cOrS9wznAsDEth0S61koiKgCWmpNgaAyXLp
	 GUTl9s3E7VI2d6fZdWuIo/MYxfWVokzHvVKjmBrteiIlUVcWFNczPSRDOQB7HM9jFb
	 PJfHbDCaIQP81wQ3d6DYLjW/j5sSfQJInKfvQPmQEyvluGyssidZTzozzzjXV2pRma
	 dxXz1L11zaN4Q==
Message-ID: <18812498d4f4eb6d0565c8e97f428d8e.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.13-rc2
Date: Sat, 14 Dec 2024 00:48:02 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit fac04efc5c793dccbd07e2d59af9f90b7fc0dca4:

  Linux 6.13-rc2 (2024-12-08 14:03:39 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.13-rc2

for you to fetch changes up to 25fb0e77b90e290a1ca30900d54c6a495eea65e2:

  spi: spi-cadence-qspi: Disable STIG mode for Altera SoCFPGA. (2024-12-09 13:06:24 +0000)

----------------------------------------------------------------
spi: Fixes for v6.13

A few fairly small fixes for v6.13, the most substatial one being
disabling STIG mode for Cadence QSPI controllers on Altera SoCFPGA
platforms since it doesn't work.

----------------------------------------------------------------
Christian Loehle (1):
      spi: rockchip: Fix PM runtime count on no-op cs

Christophe JAILLET (1):
      spi: aspeed: Fix an error handling path in aspeed_spi_[read|write]_user()

Niravkumar L Rabara (1):
      spi: spi-cadence-qspi: Disable STIG mode for Altera SoCFPGA.

 drivers/spi/spi-aspeed-smc.c      | 10 ++++++----
 drivers/spi/spi-cadence-quadspi.c | 10 ++++++++--
 drivers/spi/spi-rockchip.c        | 14 ++++++++++++++
 3 files changed, 28 insertions(+), 6 deletions(-)

