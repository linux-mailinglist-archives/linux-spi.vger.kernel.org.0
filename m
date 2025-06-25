Return-Path: <linux-spi+bounces-8776-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F174AE8E6F
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 21:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1360F1894DAC
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 19:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E0E2D6613;
	Wed, 25 Jun 2025 19:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jN8yqFSv"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919611C8621
	for <linux-spi@vger.kernel.org>; Wed, 25 Jun 2025 19:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750879180; cv=none; b=pAJNHzfAKjTY+UZETa7GHIp9GKx34rsauW3oSafxFbSrC2oUTSmuVWWk43/zfPKI46D/qsj+RKno1VntmlxgO96CVkooNQiryld+jcJKUczdrLvvLYpHFnLhbzhYJcSEON+snC6NUGInVAKRXIp/kQskI8kcGZ+DJ1AsqINWXbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750879180; c=relaxed/simple;
	bh=LgijzjmN5LQ4jcmZUlNSLepzSZvu5tEFZnsYXQS+Q1I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=CrFwCLsdZ+Z0ZY+SHrlW8fCo247AvIhG1Y/veUZmlNALiHmkYP0aLyktHpp88x4LSs8kZZUsm9AGgo8XbSogrZP6RJ5nyDb3dyVzQMsoGg8Ij3FAfpxT7YaAhnDMoer9ZKjPlcMS67zSz6hyJ8UZmGwwfrhqPpTMbpAUhza7FYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jN8yqFSv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14ACBC4CEEA;
	Wed, 25 Jun 2025 19:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750879180;
	bh=LgijzjmN5LQ4jcmZUlNSLepzSZvu5tEFZnsYXQS+Q1I=;
	h=Subject:From:Date:To:From;
	b=jN8yqFSvLQDsDw2QYaGMH/MaI4ZisOhVLAR+Wjs5kV/gHuHN8mk/ImwZ/sBpZ0mfg
	 y60bas4pD694wcSlt6Vy0coFKCkF7V9s2SzXuNYLeTDdmChvbajTwVMuneebc+aquL
	 vXVJy/wlS1ibEyIPgEP8kGsBAtHwHlXBtZxTCPuG/bwkRKDZvNHZufX+YM2oRL+UxI
	 g7k0IDGCq8r5AMXLTtbzqmexUk/CIllJFWEYkQLCr+iBEPP8cqVLS58gnuRXyADeL4
	 ESoIZDBIiK/ZUqwNlazaKty4jpd0hEaUY9Ez36Khd8iraSMeF6rMxyAUUMReAy0+Hc
	 1A2lj8xgxn38g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B14DA3A40FCB;
	Wed, 25 Jun 2025 19:20:07 +0000 (UTC)
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
 <175087920613.595307.10952256315522809810.git-patchwork-summary@kernel.org>
Date: Wed, 25 Jun 2025 19:20:06 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Add few updates to the STM32 SPI driver
  Submitter: Clement LE GOFFIC <clement.legoffic@foss.st.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=972418
  Lore link: https://lore.kernel.org/r/20250616-spi-upstream-v1-0-7e8593f3f75d@foss.st.com
    Patches: [1/6] spi: stm32: Add SPI_READY mode to spi controller
             [2/6] spi: stm32: Check for cfg availability in stm32_spi_probe
             [3/6] dt-bindings: spi: stm32: update bindings with SPI Rx DMA-MDMA chaining
             [4/6] spi: stm32: use STM32 DMA with STM32 MDMA to enhance DDR use
             [5/6] spi: stm32: deprecate `st,spi-midi-ns` property
             [6/6] dt-bindings: spi: stm32: deprecate `st,spi-midi-ns` property


Total patches: 6

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



