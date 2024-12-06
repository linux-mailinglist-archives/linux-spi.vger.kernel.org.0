Return-Path: <linux-spi+bounces-5942-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1962A9E79BF
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2024 21:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDFFB28828E
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2024 20:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1E0204594;
	Fri,  6 Dec 2024 20:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qv2Fhyvi"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EFA20458B;
	Fri,  6 Dec 2024 20:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515433; cv=none; b=OxpUFb3QcoVh+zz7eaawFeY/XYJuFwc1KlyT6SfoHs+FXDQsG+T9pP3IdJPPhWaOOacRz3RPcJkESrF13DuUS1fnAD41qk4nOBYsxOrR+8HFKNA57oyw8o8GdY9eOgfdhtE3r5ocjxoIpO4q7J0Rc2wiYiLZg1yNWyaV+4VqEtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515433; c=relaxed/simple;
	bh=tz46XXEkh6To+nu5KudS/ZP4EgOFGS0nP06dAvan8xo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TTtvRa9gUQm+gXQ4Cd/JQzN48hbU0+W4UzvrrALJiWALUwayx2YyYHm91Gb9xcpjLR2Uxwj/WnLjprF21ZFHqCUnEIcbScVEJPaQaNgvcp8HtsdtTUubwhXk4qMOu26Wsu2cCcrZRZKk62kkprLDERXZ795F18mODATOnMDIEUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qv2Fhyvi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB632C4CED1;
	Fri,  6 Dec 2024 20:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733515432;
	bh=tz46XXEkh6To+nu5KudS/ZP4EgOFGS0nP06dAvan8xo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qv2FhyviM3xU6bC2LOGNMsiiXEzP6Zn5pQngs1G0G+P+icfN7kCCy575Mu5eF67lz
	 jnEH9D6m3sHR4wC49insZs74S6u6+zQ4/qTdbiM2vDkdehMtt+zuxmIGojvWKvwsD9
	 b1vt6ZB1JrTQE6VAUUHFXm+NUblnTNaC5TNiFp8lokLU4x1fEkeuXJMDJx/z7Kixiq
	 ptkJQhtB+ziX5cGxUvEClHlHHFowHoYSkNkHOb+qGxoHLIOENpYjBDmgXW5VwI7Cjo
	 /7lD16SmkvnGGqB0Gpq+8Fz8OzHx3+eX6XPB/lc8rleD3qTrEMDNcY06sn5Auyq8Oi
	 knd0idt5P4XCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB659380A95C;
	Fri,  6 Dec 2024 20:04:08 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <95c3aaea3b0fa248c2a9a5a852c444b2.broonie@kernel.org>
References: <95c3aaea3b0fa248c2a9a5a852c444b2.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <95c3aaea3b0fa248c2a9a5a852c444b2.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.13-rc1
X-PR-Tracked-Commit-Id: 4c6ac5446d060f0bf435ccc8bc3aa7b7b5f718ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b60500e9022f24b6d3e4cb3ff6928891c44a262d
Message-Id: <173351544752.2778953.9387253765616988078.pr-tracker-bot@kernel.org>
Date: Fri, 06 Dec 2024 20:04:07 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 06 Dec 2024 15:30:37 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b60500e9022f24b6d3e4cb3ff6928891c44a262d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

