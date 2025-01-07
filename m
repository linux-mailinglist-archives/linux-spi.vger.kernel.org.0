Return-Path: <linux-spi+bounces-6243-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C973FA03E6E
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jan 2025 13:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0301A188040C
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jan 2025 12:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4E41EE00F;
	Tue,  7 Jan 2025 12:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sm/nIZj4"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B591E8850
	for <linux-spi@vger.kernel.org>; Tue,  7 Jan 2025 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251207; cv=none; b=YXO4oKMF10Ysg+ZUMc0GyDt3kllEG0+nKt7caI8T9ofxf3QjQMxEa+VL5Us84jyoWcmkTsRuuvK/YkYte/7i9d+5AWYtXHrWi4I0TH98jbUrk06GOZrm9XdGggR02KFzPxdQn81BiVQeBBtM71OvnBbo8T1IMYFYWvqd7GJ7cl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251207; c=relaxed/simple;
	bh=VvVakUTA/T0V8vWuTw1rc7CPpJxj1nGArPNPUHZWpvI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Z/dW0y1eowSBpfkXTBwk909zJUo2ak+Z3o+t6cX07SD46hOLmIETgxlhlI6ydD6SLdn9UYp895FKmKkFjn/PFWKjYRVzHXd31/SwZ58SdwkfARcnigUTuiQHOAyCz2TKSe4RU+3Honm0n1aBpCkg4typFpd8/vVXRrlJ4XxY+pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sm/nIZj4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB86C4CED6;
	Tue,  7 Jan 2025 12:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736251207;
	bh=VvVakUTA/T0V8vWuTw1rc7CPpJxj1nGArPNPUHZWpvI=;
	h=Subject:From:Date:To:From;
	b=sm/nIZj4isp9afhAdAg+XWPjfJW/QoIKSHmCb2WD/AKFpKdgMEFJIN0w7POZ7xT81
	 rk4OeP07rhfAX2GaD8EzwXgBSNpdygjOVD7HV6YckJaDMZ0xcSav6I5Fjnv9LeatFQ
	 CjcAwIy2EnUsIutajS67Pt1jOM28IFndTJuMMcV3mYzhsQeuKJsUgT/bmQe1wsTg6O
	 6QW43B3wkJm4mf1Vdf9oK/m6EU+SaeL5AvmcX0T6vJdSCqBdD3w4/Sx6k0koH5MrGv
	 +uBCd3IxQnkkTB2zkTA1ZaeVXUoGbvW9kSw9u0M+alg/YrqG7Tu61gZ5t9pGIijQlb
	 Pvb1hY2fwET9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 754AB380A97E;
	Tue,  7 Jan 2025 12:00:29 +0000 (UTC)
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
 <173625122792.4127084.7866583361761352483.git-patchwork-summary@kernel.org>
Date: Tue, 07 Jan 2025 12:00:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [resubmit,v2] spi: atmel-qspi: Memory barriers after memory-mapped I/O
  Submitter: Bence Csókás <csokas.bence@prolan.hu>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=922616
  Lore link: https://lore.kernel.org/r/20250106154806.1959266-1-csokas.bence@prolan.hu

Patch: spi: rockchip-sfc: Support sclk_x2 version
  Submitter: Jon Lin <jon.lin@rock-chips.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=919510
  Lore link: https://lore.kernel.org/r/20241219142216.2123065-1-jon.lin@rock-chips.com

Patch: spi: cadence-quadspi: Enable SPI_TX_QUAD
  Submitter: Santhosh Kumar K <s-k6@ti.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=921769
  Lore link: https://lore.kernel.org/r/20250102120544.1407152-1-s-k6@ti.com

Patch: [resubmit] spi: atmel-quadspi: Use devm_ clock management
  Submitter: Bence Csókás <csokas.bence@prolan.hu>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=922619
  Lore link: https://lore.kernel.org/r/20250106155416.1959803-1-csokas.bence@prolan.hu


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



