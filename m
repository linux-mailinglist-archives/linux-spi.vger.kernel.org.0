Return-Path: <linux-spi+bounces-5528-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EEE9B3C89
	for <lists+linux-spi@lfdr.de>; Mon, 28 Oct 2024 22:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0079F1C21F88
	for <lists+linux-spi@lfdr.de>; Mon, 28 Oct 2024 21:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B146B1E0E1D;
	Mon, 28 Oct 2024 21:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s71E3+eG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C5C1DFE1C;
	Mon, 28 Oct 2024 21:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730150039; cv=none; b=JIb4hPwy/GtSJ++WIF8pfAa7/KdmnoPaN93nuute+wYSkTkzTFXQIX5dRk+lyIE+/jc+/HyWin0ECc/LqHdLEA5GpR0gC3M9EMV/4Gz4l9Tc99MBBLkjaSDcG2cZN8frMFkrh8Vh8Qckw2Jq1fmMSvDCedCcV9ZhfifvDr/mjGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730150039; c=relaxed/simple;
	bh=lPkuo+CeRdjxk7DsKh7xYpnCi0UMZOrr8dOiow33BgI=;
	h=Message-ID:From:To:Cc:Subject:Date; b=lpDBvNExv5xZMn7VNg4S5UVO/TpzQzMIFl5rGZpuKKWFzaGf2aTyau2Eh21EMNAifNMa5k9I214xhbiSQMLzykSQtzSc42L8EndhWIxiaVRc+2TM/GFebIaNNg9GwKauNnoXZQoX2f5Sik4SVjmA2orobZwOVy/eEgTRSBgvFh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s71E3+eG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9FFC4CEC3;
	Mon, 28 Oct 2024 21:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730150039;
	bh=lPkuo+CeRdjxk7DsKh7xYpnCi0UMZOrr8dOiow33BgI=;
	h=From:To:Cc:Subject:Date:From;
	b=s71E3+eG4D85Aim8uCZkrnctNydWFVfXiSC00llxroogIYWyGklh4hj8Bf8rQ1YsA
	 3rEgfELI0uaVuUhuc8gSueaJwXd/BTbP58bs47X4i81PKh9qOIUjFsEdxvBrakv1ZN
	 T81BZfn3bAKVHy4+/2Ske9WwGnyN5k+FHANsLSXdsglufbbbqa1B6a33KsgsRSwuT9
	 205dQ1znASVc5TmxTB/s69L7akxersgFoZ+bya3nghK+FfedmBiv26CHd9Hvu+UH8a
	 MXBjPFBVkHqDiTdB6Z1LxXGlB9s2Sl49W47O2s7k0/UKznFdHMBfcd65BXMIx2I+c5
	 0SrcBJuuRFMPQ==
Message-ID: <e32f70e4cf5a79406b835f85d7923c51.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.12-rc5
Date: Mon, 28 Oct 2024 21:13:42 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.12-rc5

for you to fetch changes up to 25f00a13dccf8e45441265768de46c8bf58e08f6:

  spi: spi-fsl-dspi: Fix crash when not using GPIO chip select (2024-10-23 22:37:54 +0100)

----------------------------------------------------------------
spi: Fixes for v6.12

A small collection of driver specific fixes for SPI, there's nothing
particularly remarkable about any of them.

----------------------------------------------------------------
Alain Volmat (1):
      spi: stm32: fix missing device mode capability in stm32mp25

Bartosz Golaszewski (1):
      spi: mtk-snfi: fix kerneldoc for mtk_snand_is_page_ops()

Frank Li (1):
      spi: spi-fsl-dspi: Fix crash when not using GPIO chip select

Georgi Djakov (1):
      spi: geni-qcom: Fix boot warning related to pm_runtime and devres

 drivers/spi/spi-fsl-dspi.c  | 6 +++++-
 drivers/spi/spi-geni-qcom.c | 8 +++++---
 drivers/spi/spi-mtk-snfi.c  | 2 +-
 drivers/spi/spi-stm32.c     | 1 +
 4 files changed, 12 insertions(+), 5 deletions(-)

