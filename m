Return-Path: <linux-spi+bounces-9806-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D00B0B3C786
	for <lists+linux-spi@lfdr.de>; Sat, 30 Aug 2025 04:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9322A5675D4
	for <lists+linux-spi@lfdr.de>; Sat, 30 Aug 2025 02:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB8D26CE07;
	Sat, 30 Aug 2025 02:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBCrUxrn"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659B124BBE4;
	Sat, 30 Aug 2025 02:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756522203; cv=none; b=nOFlLCdvD3VnFQmCaidEurvQp7Tr4G7PhBqubVqRMFCawiP+8S9iOOt4mFoR/ZCotMawEaFPLfFUlz5KFLqRlD9GssXbDD/pa3ASOMVXpSwWp8gz0oysCgPexaxmZ+rz3MzC6PRRxBJQ4jhJlWVjNKGiNsa4zI+X28K72MZXLOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756522203; c=relaxed/simple;
	bh=UZNtHsqjj3uurf1AQ9wm8eTRJe1IDKmNLmTjkInNtec=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SU7R1DrImYM2oJTvcQf59IuBHHr3IR2t8dtIxOByw5t72hDOdLGJmc3AuBNrUFTgbuVL1yYTb1xOjpjW7/Sc/GeZuv9aXYPRFfa4jBWAlbSo+EM6fi2Dr56ewvuTV5xJRLQlaqucg6/cIt/tgLCjiT+CeU6I0t77DOyS6Mwr670=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBCrUxrn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E2EC4CEF0;
	Sat, 30 Aug 2025 02:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756522202;
	bh=UZNtHsqjj3uurf1AQ9wm8eTRJe1IDKmNLmTjkInNtec=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NBCrUxrn9aEmdY1yJTHKQUVq+G8WEhBPqGu2HJoVypE+oRn8BGU6rp/A/p7V4zWwV
	 usW5FU5gUO0Mrur+08nDFO8XflIGN8VoaHlKvvadAVrqUkrxT6o/mn+K9vkcCzW5tt
	 L7INF1kpHF1TkcNkTNNJsl9pLZHGq2JbwOBtYOO9MN5aYpiZ0EfHdRfJBaRP4Qc6aE
	 ZljTcgwt8jQqxg4AOmWpQHZhSvDGcn3VaNwAeHq65wUa5yYY/hpe9iJgErNOAXYu45
	 of5NXCWZDTcZky5dxfxCtL05HHmkZbbvp70LF6tETO1Ms51M4V5SfG2VKf1rYVe6Ti
	 T6t3Nrh2cIiJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC4E383BF75;
	Sat, 30 Aug 2025 02:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 0/3 net] microchip: lan865x: Fix probing issues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175652220950.2402606.8992590447276485384.git-patchwork-notify@kernel.org>
Date: Sat, 30 Aug 2025 02:50:09 +0000
References: <20250827115341.34608-1-wahrenst@gmx.net>
In-Reply-To: <20250827115341.34608-1-wahrenst@gmx.net>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: parthiban.veerasooran@microchip.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-spi@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 Aug 2025 13:53:38 +0200 you wrote:
> Recently I setup a customer i.MX93 board which contains a LAN8651 chip.
> During this process I discovered some probing related issues.
> 
> Changes in V2:
> - Add Andrew's RB tags
> - Also add lan8651 compatible to Patch 3 as suggested by Andrew Lunn
> - CCs for stable
> 
> [...]

Here is the summary with links:
  - [V2,1/3,net] net: ethernet: oa_tc6: Handle failure of spi_setup
    https://git.kernel.org/netdev/net/c/b3852ae3105e
  - [V2,2/3,net] microchip: lan865x: Fix module autoloading
    https://git.kernel.org/netdev/net/c/c7217963eb77
  - [V2,3/3,net] microchip: lan865x: Fix LAN8651 autoloading
    https://git.kernel.org/netdev/net/c/ca47c44d36a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



