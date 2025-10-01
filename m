Return-Path: <linux-spi+bounces-10405-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA12BB18FB
	for <lists+linux-spi@lfdr.de>; Wed, 01 Oct 2025 21:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E53A7AD85F
	for <lists+linux-spi@lfdr.de>; Wed,  1 Oct 2025 19:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5878B2D24B5;
	Wed,  1 Oct 2025 19:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkzizFvv"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31934213E89;
	Wed,  1 Oct 2025 19:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759345501; cv=none; b=BnCL+Vxch0Po1kuiU0yk5NjXv9V7FtjvHYgoaXDrq8gCBemxKH/R2JcooEHGtBWLhEydJaD5m1xYEawgZNLmM2bgqZQ70qnisEXVNVBYLmg2bDmESFhAYPZSgpxcuGXfmjsdw3tnMHbmiLthuITgsc5aJEHvRlUxstXH51Fcenc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759345501; c=relaxed/simple;
	bh=haoGjaIu6PewXXfdOVrSkmWPT3dz2D8pX6J7C5O0udk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EQ1LCw8QfjcfRPsNvDs4jAsBKETEhTfbdOi4x5QYz2pRJPSVIAOJqWb52rcMlgkQSH1SnBRsCKLWYDMNhp9cuewtp1EtALjTiL/ivuP1ABo42K/hNVd1tDTyoLfRRkKSBWjAi3wXucvzpZ4L+dRppLRTLT3VUhnjwJNaNDvnAIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkzizFvv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4354C4CEF1;
	Wed,  1 Oct 2025 19:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759345500;
	bh=haoGjaIu6PewXXfdOVrSkmWPT3dz2D8pX6J7C5O0udk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MkzizFvv2yNa/Hr4LkWLoKDRAYiz+vnsZdX/IAV5m6beoZmRAtyH2LKTtHlflqr07
	 r3YUNc9UJkDE+qYWEIgfvc/eE8HR+CLHOLUFyz/ygfKyt0okLxvvQk1wIG8vYmeh39
	 ILIDyCz5NTZOCs+gasE1FhvZe+AbuoKTMeNp3bbK99EVlBoVqON8mZXV/I+uFyHKRO
	 /BZBS7Zy95nj0D9Pa+0YoyRncnoOZpe3Afj1TuvzksHLAFXe21J9HanHsTcvshsXTq
	 L4uxdWhWF/M8CeLS0QLPQmenrBacVSdGfXtRdpkd8mf+88qwznbmrm5T9sYeJnsCZd
	 fq6gc78kh4ckg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DAC39D0C3F;
	Wed,  1 Oct 2025 19:04:54 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <382d89fbfb545a45925ecee481f1847e@kernel.org>
References: <382d89fbfb545a45925ecee481f1847e@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <382d89fbfb545a45925ecee481f1847e@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.18
X-PR-Tracked-Commit-Id: 2bfb20b65d9bc1d0de58f8c28ca9d6f1d27bbc01
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea1c6c592522208df1dcac9e8f1deb7cc56a51b7
Message-Id: <175934549279.2583066.1847518579027500449.pr-tracker-bot@kernel.org>
Date: Wed, 01 Oct 2025 19:04:52 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 12:42:40 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea1c6c592522208df1dcac9e8f1deb7cc56a51b7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

