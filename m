Return-Path: <linux-spi+bounces-7774-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A70A9D608
	for <lists+linux-spi@lfdr.de>; Sat, 26 Apr 2025 01:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79C4C9C2AE1
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 23:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BCC233140;
	Fri, 25 Apr 2025 23:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bl2Xp2MQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC1A635
	for <linux-spi@vger.kernel.org>; Fri, 25 Apr 2025 23:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745622592; cv=none; b=CyasiQUMmLFadH0Wb8u0FuuAmxZjCy3j3v5kuBoyeOKOr7SfCMmqalYJ1dyOMhR5Pxop0DNCoTYNtTfbLVr1B8zfggPvOomAFgpLEpqSMLa5kwaPJeZH858Izcpwno6HI0Fwp3Fgyif/wr2X40Ra6/spb740QQdt2Wx+3YgoQK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745622592; c=relaxed/simple;
	bh=KB7xOBGT9igqXxO7p5WrslReFmDf2CFO5ueYfGw8qhU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=NyxSJ7A5WwztlCxegxZDWjqWzYlB9flevPRiebj98tuaftTReW7YaAu6JHzcZ1x9qYmh5qNpZ6V3a8aW76d7hIOFLMkxuzXyX7wCbL+0boJAmNpby+txpHcehsmhkB6Dy3KMoMzTevAt6Yv0K0JPsT/laonSjecu30wK9jKghA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bl2Xp2MQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E00C4CEE4;
	Fri, 25 Apr 2025 23:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745622591;
	bh=KB7xOBGT9igqXxO7p5WrslReFmDf2CFO5ueYfGw8qhU=;
	h=Subject:From:Date:To:From;
	b=Bl2Xp2MQbaOA+O8P6RSVv4N+pAqEZoIe1GNsfsvmdwMuPLV5u8JLSh49IWWmDJhSm
	 ZcceqcVquhDZhn8G1bj46bOzSO3W0L9+GAvPk5JGfu4iW9Ymgu1s692DERVZPmWt6+
	 CWIBbS/szkWy2TxW6EncW1IoL9pmQng0rLhZzvKO9AtxB7N7C57I0pt/a1eE//z4ZO
	 dTM4MnHhVVd+rCgiYvhu+SCz0VQlC2eeJctQtzSfbNvvqsEkKkrJQHPBhxTgXpO9MY
	 WOix1zaBmZqQPb0xxjHsyozR12vXKJtopU3fEibAdVLho0HlOw7LJFDDstx9vDVGec
	 3nl1KJEKumDOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B1ABF380CFD7;
	Fri, 25 Apr 2025 23:10:31 +0000 (UTC)
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
 <174562263036.3869705.4124302997688904848.git-patchwork-summary@kernel.org>
Date: Fri, 25 Apr 2025 23:10:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: ASoC: add Renesas MSIOF sound driver
  Submitter: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=954674
  Lore link: https://lore.kernel.org/r/871ptq4blr.wl-kuninori.morimoto.gx@renesas.com
    Patches: [v4,1/9] dt-bindings: renesas,sh-msiof: Add MSIOF I2S Sound support
             [v4,2/9] spi: sh-msiof: use dev in sh_msiof_spi_probe()
             [v4,3/9] spi: sh-msiof: ignore driver probing if it was MSIOF Sound

Series: Configure Clocks, Add Native Dma support.
  Submitter: Vishwaroop A <va@nvidia.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=933216
  Lore link: https://lore.kernel.org/r/20250212144651.2433086-1-va@nvidia.com
    Patches: [v2,1/6] arm64: tegra: Configure QSPI clocks and add DMA
             [v2,2/6] spi: tegra210-quad: Update dummy sequence configuration
             [v2,3/6] spi: tegra210-quad: Fix X1_X2_X4 encoding and support x4 transfers
             [v2,4/6] spi: tegra210-quad: remove redundant error handling code
             [v2,5/6] spi: tegra210-quad: modify chip select (CS) deactivation

Series: Configure Clocks, Add Internal DMA support
  Submitter: Vishwaroop A <va@nvidia.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=953956
  Lore link: https://lore.kernel.org/r/20250416110606.2737315-1-va@nvidia.com
    Patches: [v3,1/6] spi: tegra210-quad: Fix X1_X2_X4 encoding and support x4 transfers
             [v3,2/6] spi: tegra210-quad: remove redundant error handling code
             [v3,3/6] spi: tegra210-quad: modify chip select (CS) deactivation
             [v3,5/6] spi: tegra210-quad: Update dummy sequence configuration


Total patches: 12

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



