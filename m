Return-Path: <linux-spi+bounces-9332-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDBBB1F25F
	for <lists+linux-spi@lfdr.de>; Sat,  9 Aug 2025 07:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FFEF565A90
	for <lists+linux-spi@lfdr.de>; Sat,  9 Aug 2025 05:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1AF27A127;
	Sat,  9 Aug 2025 05:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmwa9gin"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0591827A11A;
	Sat,  9 Aug 2025 05:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754718332; cv=none; b=ajMO6H64jFfAcQkfCwKX2Se6o9Cc9d3sw9/mPO1e890y7MgKJlyJp733SblqZDrNaUgxuUPZA05/I9k+I8rum51VtMnOv6CPQBanY1mpzol+VzbisYfBmmyr/cFndHJZmWLI93CHuhgVtmO/i9x5lxpmCCC67+9Mck7H6ytRn3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754718332; c=relaxed/simple;
	bh=vvUmjLToG0Bca5JhJvQnjyQDSZ0qR2SEKzPkAoA+kpk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=D5IJwBMR3WAzDSYmnt+gN40pSvM8oz195gi1Gh6yC5K1MnIqrjZ5mDHBnoF5xSb3vMF5OpNug5sVRWI+iWbuZj1TroL1NOKVEEkO6dX5BUG9aCpH3J0j/lWgHN/oo3xnvyMqR9Y0zQRMKt+wDkHUqIUtwEzAGZaHGElvI9ChDtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmwa9gin; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90C3C4CEE7;
	Sat,  9 Aug 2025 05:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754718331;
	bh=vvUmjLToG0Bca5JhJvQnjyQDSZ0qR2SEKzPkAoA+kpk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mmwa9ginU8AIFB4jylfvIPjW9hyIqcoBe0J1atBurk8iOwtvVRo0VXpA3+2yAYseZ
	 MH/nV6ryl/Gw4cMv0VDwR0g4FyejUuwO5GY+ZP4zK8OmZ94KRporurVav1wqbr5cfC
	 JUjh8xnLoqzxb1tvg4TAHFhktk8vlmbgfGrI25aTCPzyhMN4SNyGGUqexHckZ0HZAg
	 jtBs48sgy0ra3hhb2aK6qAA8747T+jIDMO+mxNkHSDGvZR/KGEgETBBO1pdJKWWsuE
	 nqexjB5KCsGDOQ0pfeoRZL7ur3QZXSCgl8YRMZERnITllvBFlYvfE2CfbS71OZmrZp
	 /QQRCj7xycqSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AF0383BF5A;
	Sat,  9 Aug 2025 05:45:46 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.17-merge-window
From: pr-tracker-bot@kernel.org
In-Reply-To: <748ae3828202bb22422d4947b740f43b.broonie@kernel.org>
References: <748ae3828202bb22422d4947b740f43b.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <748ae3828202bb22422d4947b740f43b.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.17-merge-window
X-PR-Tracked-Commit-Id: ffcfd071eec7973e58c4ffff7da4cb0e9ca7b667
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 71a076033b261e1c6851c2403b598c27847bd28d
Message-Id: <175471834481.387690.8344350214585215972.pr-tracker-bot@kernel.org>
Date: Sat, 09 Aug 2025 05:45:44 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 08 Aug 2025 18:02:24 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.17-merge-window

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/71a076033b261e1c6851c2403b598c27847bd28d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

