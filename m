Return-Path: <linux-spi+bounces-11661-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A52C9337A
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 22:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7814434D3A5
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 21:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839872E0417;
	Fri, 28 Nov 2025 21:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ga2s7FJM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589E82DF710;
	Fri, 28 Nov 2025 21:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764367003; cv=none; b=Hx6fEwnT9//LfKL6DFOitgJFBtZXl7oG8DMdYbj/Z3vs16yX/44xL6YIZgHoKtdTM5z9xyq3Gqk8fYYeqapKAQnQLWUyT/N+rwYhZHtEFvEgORjtYRHJr8tqn8qnXg2SRaJAi3YUh3gBRhQg4MoSAHhd54zJexPYM6e+Nf4s3l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764367003; c=relaxed/simple;
	bh=0SWbhjPFXqnT160Wd0WsWJ17+1+Ik/+gv5CPM59neis=;
	h=Message-ID:From:To:Cc:Subject:Date; b=QLvfRvINPTE+G9bmC1EOkVHTsMnOyTGQQ6dPMOwOQuR4G6ggg9P9IaRJTnfH6wCC4TYRfJNysDpo7isFSYDMUth3eC0fWdu3RG3vSMzzd0U3qY1eezoxWICTbVBR97+dAiIKBHLetxlUYIEQMpTeYqea+sMjKZp8eJdDMm0ydK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ga2s7FJM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F722C4CEF1;
	Fri, 28 Nov 2025 21:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764367002;
	bh=0SWbhjPFXqnT160Wd0WsWJ17+1+Ik/+gv5CPM59neis=;
	h=From:To:Cc:Subject:Date:From;
	b=ga2s7FJMxLoKCSlk8LWhuV/meVAEiVubmQBZ9hN5ry7Jpg1DwLq9zHXxHyMvMZJds
	 CBEElB3kex2PLo2FBmP/Aga46IOkfKyMv4HNnU97njDjJbLjoPljOtHDcPLtDQH80R
	 1I2GIJG+0FqENkTCv9Q2w0F5ULbXfXNPldZk42lLZFYRYdVZJYLt1ETAtE1pOD9iX3
	 hJbXFJzGFbYt56BiH+B7gh5zBgRnhm2dpTMyJm+va/InSmPo+IJ1SeRbeSFweKmJii
	 ILcbtINA/AUWe9yaPzgxzkNCVr/n9gSQkf5Si4QkFFoZYwc6zBcC7SwBp29qiuMbQO
	 uj5Fs6cJbkpRA==
Message-ID: <e5dbc9d61c0e057d24e0e263175818f1@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.18-rc7
Date: Fri, 28 Nov 2025 21:56:34 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 66e9feb03e7cf8983b1d0c540e2dad90d5146d48:

  spi: Add TODO comment about ACPI GPIO setup (2025-11-10 14:03:53 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.18-rc7

for you to fetch changes up to 40ad64ac25bb736740f895d99a4aebbda9b80991:

  spi: nxp-fspi: Propagate fwnode in ACPI case as well (2025-11-27 11:41:06 +0000)

----------------------------------------------------------------
spi: Fixes for v6.18

A disappointingly large set of device specific fixes that have built up
since I've been a bit tardy with sending a pull requests as people kept
sending me new new fixes.  The bcm63xx and lpspi issues could lead to
corruption so the fixes are fairly important for the affected parts, the
other issues should all be relatively minor.

----------------------------------------------------------------
Andy Shevchenko (1):
      spi: nxp-fspi: Propagate fwnode in ACPI case as well

Anurag Dutta (2):
      spi: spi-cadence-quadspi: Enable pm runtime earlier to avoid imbalance
      spi: spi-cadence-quadspi: Remove duplicate pm_runtime_put_autosuspend() call

Carlos Song (1):
      spi: spi-fsl-lpspi: fix watermark truncation caused by type cast

Francesco Lavra (1):
      spi: tegra114: remove Kconfig dependency on TEGRA20_APB_DMA

Hang Zhou (1):
      spi: bcm63xx: fix premature CS deassertion on RX-only transactions

Haotian Zhang (1):
      spi: amlogic-spifc-a1: Handle devm_pm_runtime_enable() errors

Siddharth Vadapalli (1):
      spi: cadence-quadspi: Fix cqspi_probe() error handling for runtime pm

 drivers/spi/Kconfig                |  4 ++--
 drivers/spi/spi-amlogic-spifc-a1.c |  4 +++-
 drivers/spi/spi-bcm63xx.c          | 14 ++++++++++++++
 drivers/spi/spi-cadence-quadspi.c  | 18 ++++++++----------
 drivers/spi/spi-fsl-lpspi.c        |  8 +++++++-
 drivers/spi/spi-nxp-fspi.c         | 10 +++++-----
 6 files changed, 39 insertions(+), 19 deletions(-)

