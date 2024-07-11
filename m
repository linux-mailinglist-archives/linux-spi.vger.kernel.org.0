Return-Path: <linux-spi+bounces-3836-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0C892EF9A
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jul 2024 21:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8E21F21FE4
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jul 2024 19:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2459B16F0C4;
	Thu, 11 Jul 2024 19:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaWNDT4I"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECABA16EC19;
	Thu, 11 Jul 2024 19:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720725875; cv=none; b=qpjF8ZRl1QB1wvpHoYSWwPdDdx/FvHwa3ctKlgO4PH0QHBiVaVJmKQIqj5MveQ02gFlqqvWlBcwvS5238nTParywqDvgAxdRaUCVnJh2XFTiq8t7XMlNUxxFOQu94TjN2BCBxpmhKF7tvyq8ME86vRXRuLsQkboWe3uDw7p/l2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720725875; c=relaxed/simple;
	bh=JctNEzDp3b3NTNaXVSMmiJIkBwtaBQ1y9HzY5qy13co=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=g1ZL3lMf4Z+f02wNVmc7dKEFnl9V3cXdiRNLm93jLU4ib8zUo0qhZ0vg+pCQwSA7dJ1TchBcjU+Q6oBoHPvHE6bkIlf/5YaoqFJqPVI7opWXiFcfUIu51J2OLZAArd6/28AfYL7SdBqmryD6zYI5v6W/No/Y+vbbBFKgMBo7nvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YaWNDT4I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDB3BC4AF09;
	Thu, 11 Jul 2024 19:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720725874;
	bh=JctNEzDp3b3NTNaXVSMmiJIkBwtaBQ1y9HzY5qy13co=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YaWNDT4IgvomnXCpP2pChEaOrrM4W0GW5Sng5ixyxXJF6k0QgssgHsPhZG44rihWf
	 2vOiVLdXE0i7/6F7lGLVE+U2q3quP/FtFpUAwHVfNnERhm3a/x5z07jAzGjvpw6RxH
	 P9gDvtwRZJeF0FW9rdsFU4Aoc4UWJvqaqTwsmJ7CJev0pR+Ma6rBNwkfTSOHzQ7cE1
	 UPUkJAr/pxjsj4z3MuZC/S0sB1FmGi6yBp0m3MCQ+SVktlU3bvIjFuo/coV+W0Cn0q
	 4GzhdxOzmH7ALr+TjbZ3wEf6WjSmT+NYf11NmZE2WE54LANpIELAdWyrOArL4U6qsD
	 1VWKGAR6IuSWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8046C43468;
	Thu, 11 Jul 2024 19:24:34 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.10-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <95eeaec80e22a55026b3aaa94d2a7ad6.broonie@kernel.org>
References: <95eeaec80e22a55026b3aaa94d2a7ad6.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <95eeaec80e22a55026b3aaa94d2a7ad6.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.10-rc7
X-PR-Tracked-Commit-Id: c8bd922d924bb4ab6c6c488310157d1a27996f31
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a18fda0febb7790de20ec1c3b4522ce026be1c6
Message-Id: <172072587474.27993.16010610248487844157.pr-tracker-bot@kernel.org>
Date: Thu, 11 Jul 2024 19:24:34 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Jul 2024 15:47:10 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.10-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a18fda0febb7790de20ec1c3b4522ce026be1c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

