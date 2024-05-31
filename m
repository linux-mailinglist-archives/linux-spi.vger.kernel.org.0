Return-Path: <linux-spi+bounces-3193-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A63C8D6CE7
	for <lists+linux-spi@lfdr.de>; Sat,  1 Jun 2024 01:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BFE91C226AE
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 23:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47CF12FB0B;
	Fri, 31 May 2024 23:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpCjGq3F"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD8512F5B6;
	Fri, 31 May 2024 23:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717198804; cv=none; b=izGDo8dW5AopdsqC3N+Wa4YSTRfks0hEpEoqVuKzGntzlG8ZdZNhIno3jxo6LwZ3Da42k8x2m92IXgkYqY7KzXqrkJKpVwkN4LQOtzN51YR9GjBdWTxzZ+49c7PiwZ0RBy8guOAMAJO/WETDo7BM6dzNhj9BJ7Ws5lGLgupDKAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717198804; c=relaxed/simple;
	bh=Az9v/cFQssPqYM6IL07EPrBlUc8iJClafQULByO6nKE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XE3Gi1Et0XJpVvo3rU1roCovpbevdB3bjV5CG59bW6CvnKWdsPeEZKFI93YG56oBBgcQ3DJwWq5nBePGEUDdmOeHfTb1LT9U+d4f9ozLDIyF91FxrAc6ugP2p/oKApTGbgEzAIblN9Y3nMCEahgA1+XhD4VwHEXY+dV6zbr6Dtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpCjGq3F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2301FC4AF09;
	Fri, 31 May 2024 23:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717198804;
	bh=Az9v/cFQssPqYM6IL07EPrBlUc8iJClafQULByO6nKE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YpCjGq3FQaYzAtHtpVNumEjTBRXRAyQQPjlBjsmrFFfxSKiJR1UBKLdDgd0Z971MB
	 91mTV0iit12OlV3rYbxvu6B4PeU2AO2s/yOzesg36AYV3n0n6zyaRSyOk7ARO6zUAZ
	 5eQLtY2PmDUp7FPNus2CmqkmDuiD/64MdjvAifsSw4+9Mswd1JwYfrGa1aIDoUAeCg
	 mtAtotVTWtj7a6ceon05UyHUS4GH0GBA0QjSnKiGiPUa85ZBO1kucPSpYL8tYGmRoR
	 3IBNLmyra3XsAwh4s8pU7ZoH/k5AtM+NxEWPvrmZol4J2yj0DEU5TRawK74dK5Y9zE
	 H+bHCm/cr0gtw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F2E09DEA716;
	Fri, 31 May 2024 23:40:03 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <a606dc99619c387713bc312d3222c98f.broonie@kernel.org>
References: <a606dc99619c387713bc312d3222c98f.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <a606dc99619c387713bc312d3222c98f.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.10-rc1
X-PR-Tracked-Commit-Id: 95d7c452a26564ef0c427f2806761b857106d8c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d5931dd0de5f4177e38defedcc4c9cede7933d3d
Message-Id: <171719880396.1891.15146753418123419699.pr-tracker-bot@kernel.org>
Date: Fri, 31 May 2024 23:40:03 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 31 May 2024 17:55:51 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d5931dd0de5f4177e38defedcc4c9cede7933d3d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

