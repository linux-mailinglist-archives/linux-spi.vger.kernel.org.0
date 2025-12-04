Return-Path: <linux-spi+bounces-11770-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DDCCA5207
	for <lists+linux-spi@lfdr.de>; Thu, 04 Dec 2025 20:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7285030C1109
	for <lists+linux-spi@lfdr.de>; Thu,  4 Dec 2025 19:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667AE34F488;
	Thu,  4 Dec 2025 19:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fa7mBPuL"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2C234F27C;
	Thu,  4 Dec 2025 19:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764876653; cv=none; b=gqOwEBstzTLtTYpxaI5DKc8Go2+/sSHmgDbLuB6KAnBCbe36eABP0VTZU1j77BVT/mpiKh2WksTBaXjZc3EjCE24kJhJSVfhylZVE3mz3kpC0qxVSZTJs/P6DXuU55qtx8zTuqW+JiT5gC+U7kc7QXWU9RZq0wWo6WNJ2HSAzmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764876653; c=relaxed/simple;
	bh=ECUEu+51er0wbaz1qfpk9P4u+fM/pp2kYzW2nxA+5kA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HXzMy9mhiPnL6U+0yIHBBWBLgxRQgQX1nZdljyNnfaQHnPivgWvTguqwNsbnj7AZzX8kvIxkv4a27FTVaPkaMyvYbE5jGzWYGyRCaSGrEM8Wd9h3LAyGvQPWqoreQGblt28KP6RPz64O3UPM3hiVpG3RBidG3CHtCtceqPuTltA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fa7mBPuL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104CCC116D0;
	Thu,  4 Dec 2025 19:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764876653;
	bh=ECUEu+51er0wbaz1qfpk9P4u+fM/pp2kYzW2nxA+5kA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fa7mBPuLb8Do+wAiz1KeAyZXEpV3HJL12vGK37ysji3tQeEnH33Axi+w+LIaKQ8Kw
	 Dtkg/wpYysMP4Bj5OGtvArXwYGWKo1E3d2jE7DNUn4vffJWNQjUMY6+YlPANKUDlkq
	 eCNNpAbe4K2D911OnzeyIx3mGEXIRcQDgUkvQRx4E/UN+sTRS4ckrFvfPAEYr4AEuF
	 ovTn0tqHDlcX4wA2WvgEAqqJmorlRgy47v4niF+iJ2FZvip0mYExh9wILbaN3ovNrp
	 CR7DlMeArf0MXRzNxQaFsnkQJt/Pbqq2iRKev5nGlLb8rwDmK/cdkQHUHaHbqDK0HI
	 EGCFQI997PGCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78618380048B;
	Thu,  4 Dec 2025 19:27:52 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <70ee20cc564827dd1636960e670a48af@kernel.org>
References: <70ee20cc564827dd1636960e670a48af@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <70ee20cc564827dd1636960e670a48af@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.19
X-PR-Tracked-Commit-Id: cb5c2eb459f4c98d584eaf3d3ea7c3612385d081
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa5ef105618ae9b5aaa51b3f09e41d88d4514207
Message-Id: <176487647106.944914.17371876584517959029.pr-tracker-bot@kernel.org>
Date: Thu, 04 Dec 2025 19:27:51 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 01 Dec 2025 20:17:32 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa5ef105618ae9b5aaa51b3f09e41d88d4514207

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

