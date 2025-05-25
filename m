Return-Path: <linux-spi+bounces-8278-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DE2AC3243
	for <lists+linux-spi@lfdr.de>; Sun, 25 May 2025 05:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 202E9189A005
	for <lists+linux-spi@lfdr.de>; Sun, 25 May 2025 03:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AB329408;
	Sun, 25 May 2025 03:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QorPzH0y"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B30B2DCBF5;
	Sun, 25 May 2025 03:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748142281; cv=none; b=gff23A9IqS0r51GBVp1Xbz5n7BNpdVm61q58syKnuFNs5YtbfIik/JakxaTlsAVs378+j6MRLekanggWHDD1E4+3fdBuH7MbxYelEjLPzJ1Zx9/4o7R935F5qJO8mKVwVljpwFMyMKn94pYOt7Ejh8KwvI06T8OlqJLjWTa9QM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748142281; c=relaxed/simple;
	bh=JCp68hQ6nGjArmkEd9rIKb6/LMSoHGV3v0pcwh+1ero=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Us8QxaZqMYycoma1ZoVtgvQ0beItTXt3JhlmZBtP2DkmBZKpKijTaDtZ2ahtFXcFMAkJHDEZ0oyO7O3xA1DFZdJL6sxJzHocDb6OzC37xYaYFd+YjDCwA15eK5AewK9jvOrue3lJGGk/ity9KE1LOjikhfi98uAEMIDzIJU9sv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QorPzH0y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97791C4CEE7;
	Sun, 25 May 2025 03:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748142280;
	bh=JCp68hQ6nGjArmkEd9rIKb6/LMSoHGV3v0pcwh+1ero=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QorPzH0yn6Vjzm50a+/neNayozbcw9bXGW26yf6HiTOjZaRF25daLRqUe68sI6Btn
	 1WRB64+k8Npf0tyHxAhvQoG0m2FU4kxEKPwD3+MwaCHaje42g7dUR9iqPIw9ZGMGQO
	 QJ3D4xate4tlV6pgi2rjDLKK4kAsYkiCsBlQa8ACWB7zPS+Bzkf9Uykvdhoa65Ydhw
	 9yGDBxHN/nD2OSjGt86ZFfVqyr1qlFENcGvEq5cqJTKQJYS/Ot5vYcsYadyHnjz2J5
	 U+EFt3oemJAfHbVV+0vu6keJ3uQh4iGWllNqHsqyw5YrEOlvAvRBMjHG5hD5/n3p1v
	 Ne9QLd6xe5/jw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE5939D654B;
	Sun, 25 May 2025 03:05:16 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.15-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <cc4326d57c0588f9916731c203773a17.broonie@kernel.org>
References: <cc4326d57c0588f9916731c203773a17.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <cc4326d57c0588f9916731c203773a17.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.15-rc7
X-PR-Tracked-Commit-Id: 7aba292eb15389073c7f3bd7847e3862dfdf604d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 95a9580d58f8d11d8673612d8ab0893335810dfa
Message-Id: <174814231517.4035660.17483286090791444622.pr-tracker-bot@kernel.org>
Date: Sun, 25 May 2025 03:05:15 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 24 May 2025 23:35:12 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.15-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/95a9580d58f8d11d8673612d8ab0893335810dfa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

