Return-Path: <linux-spi+bounces-3866-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3299B931E61
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 03:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 644561C2221E
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 01:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858034C7B;
	Tue, 16 Jul 2024 01:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1uNf7WQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E40717BAF;
	Tue, 16 Jul 2024 01:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721092654; cv=none; b=koZyGiaX4mjZus4w4qaBDfrvg+oJzEM8/9xebUrjZZrve2HvM5ShxLu9/bKmd6s9bf2jSCtMr4+jHSPOMohKb9s4GXdw7dUgeAzwvMRuN20+DdvzwwbrTbeTuDQZHhSSPWenFLrQQEvGubmxVc8hNoLchYsbpJn3ru28DRQBbI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721092654; c=relaxed/simple;
	bh=lyhZSb53lvM3H5QhNULJc0zkmrJJ+O34byNHkmS3j1Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=V+t3vWS5LkJTBGWW+P7lF5+YWUArynD/M9ijxIVT86cZMGXaZ5oMNUV54NdTLvkex3cZwmwYu9067eS7/ddvAD/IWtceX+crOPIT8543ccACBRpH5YrwIqmWoSS+6i2j2zal9Y5+PPFILlEK5I6QLg5RK0tPS+vMWWu4SBEcIm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1uNf7WQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A889C4AF10;
	Tue, 16 Jul 2024 01:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721092654;
	bh=lyhZSb53lvM3H5QhNULJc0zkmrJJ+O34byNHkmS3j1Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=q1uNf7WQiIasuYxJeelEvV2sM0nAAeyZb3E+SpguF9FJN1/ETAba2b5aOwrUgkafC
	 wtHuGKS7E22BCjavE2KyaOsTCTEbirRuMErPUXg+BTRf9K9hdRl6KvyxaLM7GfRvQY
	 3HMLG1JzhOpF0fufCnR7oR5VdVyYcI0yAjPAAvysQfTS2lRcUGzJrXEfps1fikE1ek
	 j4MWv1XT0FyZhHIdn0h+X/ktE4rG5dlsoPsM0BS6I8Q0Ghlt4y6PS6tjpZbnrCbQaH
	 JH7GmQZkZDeTlhVUUwWKcjJtuviocKCmV+iOee8yYuZK6ONQoXvSxMqhZZXaydV38f
	 x8CGsPyoVclAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25C01C4332D;
	Tue, 16 Jul 2024 01:17:34 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <46da42db74d7a64dc347375f8087a6f4.broonie@kernel.org>
References: <46da42db74d7a64dc347375f8087a6f4.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <46da42db74d7a64dc347375f8087a6f4.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.11
X-PR-Tracked-Commit-Id: 3048dc8ba46b7ba11581f2a7e06849af0df13136
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e23dd95cfd063632fb212390740940f2761e322d
Message-Id: <172109265415.10916.1917455617501541507.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 01:17:34 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 15:15:23 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e23dd95cfd063632fb212390740940f2761e322d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

