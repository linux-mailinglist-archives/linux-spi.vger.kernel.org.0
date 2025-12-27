Return-Path: <linux-spi+bounces-12147-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B18CDFF84
	for <lists+linux-spi@lfdr.de>; Sat, 27 Dec 2025 17:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CFA3830021DB
	for <lists+linux-spi@lfdr.de>; Sat, 27 Dec 2025 16:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5DC288B1;
	Sat, 27 Dec 2025 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCus1cca"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF1B1DA55;
	Sat, 27 Dec 2025 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766854288; cv=none; b=jNTuSfn+xEMSIcN8oKcrfpUqx58z/Ut7kDbo2W51Z5NlZMoT0HKs/aGmMtD4S5qQTXJk3mgGif47HOW+/6Xfb8tCmN0bIdY8V/rn4H2Kk/ccWUtwUxUG4SKHjuVLhbQqkoSRhWC+KHYS4/DEv6s6MlrOrVKepgsQy0bYrmmlAOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766854288; c=relaxed/simple;
	bh=35jQprymPle7QZ0hUwJxPMNXAvTG9rmvP2tF4Q83xxM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=m3KmYGjouAiWNwtnPSvJhkNo1wC9Jq/0oQQW9LS7iNLLGk8sPEUmKWt6cY4bGe3AP/4VnZowDdUpxnQySP81vLvtNdxZYyeXVsMqQPqmmTObR3jsezeZ9Y/kZpRrvM9ssCU0ZHooSQgpPty5Za7/93jPwdT0vQfUIsiJrExGsck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCus1cca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30787C4CEF1;
	Sat, 27 Dec 2025 16:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766854288;
	bh=35jQprymPle7QZ0hUwJxPMNXAvTG9rmvP2tF4Q83xxM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KCus1cca4iabWrPWHNPlmQt/7Hk7p/QgXObPdz4QxxV4iQ7vnfOTogNIZvlKQhutf
	 qSaMNW/eK9oBGsN0PfibFe8ZmF14Eg3wjO27GPJrse93dJO7EUDrezaJZWRRm62Hn/
	 fy88eQ8tsJ1mYaDhNl8Edo5LVFNJXS5eOsI7mklPViy7ktEvYQXkQib2r3RXa7t9Dn
	 8r+hTIolIvp2ElmKFSXGYx37vC4JozYfgJrg+eLV++TEwaAmtFYV8mrpRwu/NHRVRr
	 kqkV+hqiFb6aDjAFtOq8YFaiGH9FpC/h9PNHbP65M1gwWfOnnt80nzElo+3TSORm8y
	 rNph6elhYRMpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3C1C33AAA77D;
	Sat, 27 Dec 2025 16:48:13 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.19-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251227111023.7C5791AC56B4@finisterre.sirena.org.uk>
References: <20251227111023.7C5791AC56B4@finisterre.sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251227111023.7C5791AC56B4@finisterre.sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.19-rc2
X-PR-Tracked-Commit-Id: b005d618c8547b7dfb14e83a1b410a6a04ac36c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d26143bb38e2546fe6f8c9860c13a88146ce5dd6
Message-Id: <176685409169.2176195.1355615617291747594.pr-tracker-bot@kernel.org>
Date: Sat, 27 Dec 2025 16:48:11 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 27 Dec 2025 11:10:18 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.19-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d26143bb38e2546fe6f8c9860c13a88146ce5dd6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

