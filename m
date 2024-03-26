Return-Path: <linux-spi+bounces-2006-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0862888C267
	for <lists+linux-spi@lfdr.de>; Tue, 26 Mar 2024 13:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8079DB216FA
	for <lists+linux-spi@lfdr.de>; Tue, 26 Mar 2024 12:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFCD14A8E;
	Tue, 26 Mar 2024 12:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lR4L9Nbh"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898A45CDE7
	for <linux-spi@vger.kernel.org>; Tue, 26 Mar 2024 12:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711456831; cv=none; b=qcsMvViXWCrFqAuvrT0gNFXeEUzGeCU0kQBzE5gkXIdENDSrBu7u6ceU/MTUKgaVJ01zEEvcpVIZs70fGa3XxkObFJzesttiQiD66J9hymzyOrGg8qehJm1+XvqBmtSzhe5y7iiQe3YOPU2vKkJ9pHF9iHIy9ZZGSw15qjnNIDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711456831; c=relaxed/simple;
	bh=xZd34em6f9daSCgq8QSZ1T1Wf2IAAvNSyYM5baHCp6w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=tS3Kx+f2jzVqT7qSbEQPXeUvUQirplZ79/dpVwYMlQPsCBNWLQmzh71EbOG9ynT3gSw3A2BkT2OfuhPIjL82wd5nX2lg1opfODsR4vEuYYkZwFcEu8kpgFoZlVvzwNV8uvnFOr/StbW2Z0NtGdiMriA+U0sk9iNMn3wmUvEkeoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lR4L9Nbh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6971FC433C7;
	Tue, 26 Mar 2024 12:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711456831;
	bh=xZd34em6f9daSCgq8QSZ1T1Wf2IAAvNSyYM5baHCp6w=;
	h=Subject:From:Date:To:From;
	b=lR4L9Nbhk2++geJ2kQ5QmIGsAkr6drHUSq2p0ABE/R+bsbsszpfcieiX83P0leiSU
	 qMpkmvN6MUJ9VZVmSW6ZtniQWpCsBTHHa53Adr+uz1pXEAolP7IQUtYfmPddMb2uHC
	 t2PtAtpSTTjVlyf3CXslaA8COP9is2Z2qgL0rax8sIrRzLD6UQyp+DOeNzKG5KUgka
	 3WaVQm7LVHD/eBIPwtkJEzu1+qQn5KIh6ujRgkOvnj0CYQa+A6rUhT762UU74AHV9z
	 FfVTwskNQyO0XFwsz9HY+srOWX/vcq+apJqXVL89diN9SfixdQFmBKfFKwmYdNBKAA
	 9Lft/UGDR5ssA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 53E7ED2D0E9;
	Tue, 26 Mar 2024 12:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <171145683126.12087.645233019302416160.git-patchwork-summary@kernel.org>
Date: Tue, 26 Mar 2024 12:40:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: pxa2xx: Clean up linux/spi/pxa2xx_spi.h
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=833560
  Lore link: https://lore.kernel.org/r/20240307195056.4059864-1-andriy.shevchenko@linux.intel.com
    Patches: [v3,1/3] spi: pxa2xx: Kill pxa2xx_set_spi_info()
             [v3,2/3] spi: pxa2xx: Make num_chipselect 8-bit in the struct pxa2xx_spi_controller
             [v3,3/3] spi: pxa2xx: Use proper SSP header in soc/pxa/ssp.c

Series: spi: xilinx: Massage xilinx_spi.h
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=833847
  Lore link: https://lore.kernel.org/r/20240308162920.46816-1-andriy.shevchenko@linux.intel.com
    Patches: [v2,1/3] spi: xilinx: Fix kernel documentation in the xilinx_spi.h
             [v2,2/3] spi: xilinx: Add necessary inclusion and forward declaration
             [v2,3/3] spi: xilinx: Make num_chipselect 8-bit in the struct xspi_platform_data

Patch: [v2] spi: remove struct spi_message::is_dma_mapped
  Submitter: David Lechner <dlechner@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=838043
  Lore link: https://lore.kernel.org/r/20240325-spi-remove-is_dma_mapped-v2-1-d08d62b61f1c@baylibre.com

Patch: [RESEND] spi: spi_amd: Add support for SPI MEM framework
  Submitter: Raju Rangoju <Raju.Rangoju@amd.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=838301
  Lore link: https://lore.kernel.org/r/20240326095707.507601-1-Raju.Rangoju@amd.com


Total patches: 8

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



