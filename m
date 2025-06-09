Return-Path: <linux-spi+bounces-8411-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C20AD26E2
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 21:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C37591884414
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 19:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7486155A25;
	Mon,  9 Jun 2025 19:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsIWwh4v"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A295735963
	for <linux-spi@vger.kernel.org>; Mon,  9 Jun 2025 19:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749498000; cv=none; b=Tm+YKKx4ceygSIsYTm4dF70ilcnVyOqvzt4+mtFpezulSU63SDOShidj2PzybvIaI1LGEQjm7uToBlO8u7gyOoYJTBId0F0IK5dMJ204D8SwR7ntaYIQ+QVfwrn0nYbPksUMN0Cgn21Mg4+/O3IbDUxKSVluwP9OfhMSaXC8Lo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749498000; c=relaxed/simple;
	bh=apiObFa0bGaOy9YE+kM1bHMNGJE2wrf9e2kXZ0Y7Fac=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=S8SRAYeyQyURvcdQa+uTL/ZdSwg1HzfBVT1VWVCiZY00yD5780oYzg7Kr1EkzFG14B7J1BkhVNddvP6A/gHV45+8AEQcNcz63lZH3WkAjGAcr+M2L2Kj88dueH5Xc9F3bs4tTcs/qvHosHXiWHGnngxmqujiUk7qKjaugqDwyfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsIWwh4v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FC5C4CEEB;
	Mon,  9 Jun 2025 19:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749498000;
	bh=apiObFa0bGaOy9YE+kM1bHMNGJE2wrf9e2kXZ0Y7Fac=;
	h=Subject:From:Date:To:From;
	b=LsIWwh4vUahVDSmvqz+EI02LRwH5fMQ5+FYqnybONslJmvH/LjV/G85A9wEiORScj
	 obqLs5viVaO26aPjOeRZ1QuGYws1IV/ttvygsBV0BCZH+U9OoW04bjvUvyEN7evIiC
	 fnT/2EfVO0iQmF08rV2JFY++88ywv2fRku1/aIa+sy08Jq4GO3+PcgvWAJGtvIsHsY
	 kpUrO3hQL1aa0v0XWdSR8pBkwfwwqwhtcgr+tpAO8ggwI8THKzeknb2J3b7kon/i2f
	 YiVMcyZG4iIUPDyfoY+1JqSEefgO1tLcBIBGxfBMCfUooxol78ebsQ/EDb4pv/YnYX
	 dYpcLWI2UH5Xw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EE39C3822D49;
	Mon,  9 Jun 2025 19:40:31 +0000 (UTC)
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
 <174949803054.1509492.15773449342438872195.git-patchwork-summary@kernel.org>
Date: Mon, 09 Jun 2025 19:40:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: spi-fsl-dspi: DSPI support for NXP S32G platforms
  Submitter: James Clark <james.clark@linaro.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=965438
  Lore link: https://lore.kernel.org/r/20250522-james-nxp-spi-v2-0-bea884630cfb@linaro.org
    Patches: [v2,01/14] spi: spi-fsl-dspi: restrict register range for regmap access
             [v2,04/14] spi: spi-fsl-dspi: Re-use one volatile regmap for both device types
             [v2,05/14] spi: spi-fsl-dspi: Define regmaps per device
             [v2,06/14] spi: spi-fsl-dspi: Add config and regmaps for S32G platforms
             [v2,07/14] spi: spi-fsl-dspi: Use spi_alloc_target for target
             [v2,08/14] spi: spi-fsl-dspi: Avoid setup_accel logic for DMA transfers
             [v2,09/14] spi: spi-fsl-dspi: Use DMA for S32G controller in target mode
             [v2,10/14] spi: spi-fsl-dspi: Reinitialize DSPI regs after resuming for S32G
             [v2,11/14] spi: spi-fsl-dspi: Enable modified transfer protocol on S32G
             [v2,12/14] dt-bindings: spi: dspi: Add S32G support
             [v2,13/14] spi: spi-fsl-dspi: Enable support for S32G platforms

Series: SPI: omap2-mcspi: Fix SPI CS behaviour around cs_change in SPI transfers
  Submitter: Félix Piédallu <felix.piedallu@non.se.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=969279
  Lore link: https://lore.kernel.org/r/20250606-cs_change_fix-v1-0-27191a98a2e5@non.se.com
    Patches: [1/2] spi: omap2-mcspi: Disable multi mode when CS should be kept asserted after message
             [2/2] spi: omap2-mcspi: Disable multi-mode when the previous message kept CS asserted

Patch: [v6] spi: stm32-ospi: Make usage of reset_control_acquire/release() API
  Submitter: Patrice Chotard <patrice.chotard@foss.st.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=969885
  Lore link: https://lore.kernel.org/r/20250609-b4-upstream_ospi_reset_update-v6-1-5b602b567e8a@foss.st.com


Total patches: 14

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



