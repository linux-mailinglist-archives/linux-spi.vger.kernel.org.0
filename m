Return-Path: <linux-spi+bounces-7404-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EF8A7C20E
	for <lists+linux-spi@lfdr.de>; Fri,  4 Apr 2025 19:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 490921B6220F
	for <lists+linux-spi@lfdr.de>; Fri,  4 Apr 2025 17:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FAA21C19E;
	Fri,  4 Apr 2025 17:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sH7qFo07"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEBF21C18C;
	Fri,  4 Apr 2025 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743786088; cv=none; b=Cf2oUSplqIe7qD9dyI61GRg6Q8PFhjzMiwmAKr3qKEbgljXsYq5JH390uEutVyPvVHyqEUXK9wvW/Zyp8g4Qo6JLXapvTbrdb6vGA84uW8ZPOCG5Jc4j7P4XbZquQ1ny6Qd48zpagHGWrAyBCvpuhgjIGmv9rrx63wc5TMQ1pOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743786088; c=relaxed/simple;
	bh=FM90Zrr/Q3O7zTiIB5SmInbU8zTCY5ADRiVLnYTcVjY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JSxAYXWS5OtJ7qz23lROPSlyo0ehZd15ys7aAldLKfxnaNYiW4rBBbTddhNdrpRTol/7sBBg3UEIatBZTsaYbEyLlX5TbUQslkROt9tG/iabnUQ4cjC7KVZnNuofw445t0kG6+twG8mJNppt7phK0GjvnxEXYbWx8G0S6pRW0MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sH7qFo07; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FBEC4CEE9;
	Fri,  4 Apr 2025 17:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743786087;
	bh=FM90Zrr/Q3O7zTiIB5SmInbU8zTCY5ADRiVLnYTcVjY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sH7qFo07336m792/MI2xODI03UXHgg4Xhv5EzTvTkdu+i6mmxkCVJ/apQia6JYt7D
	 mn4Jwjib8+sFWO7ejHY6Dq3E4uNWe3/YlJylu77vDWu/oU+CTaqMFglqhsStrfx99c
	 WX4gfn2oCl6ZibsG1+IKXqj970LMb2HDQMvn9fA6cdoyZMcgnQRxyiLpFYw2RR+ojf
	 Efe9wzulCQ9IuWfBFEatHR+zUc8x3oe9vN8BtIJDxB2gJxGjJIbNPOB33140vTFmZ2
	 2CQRBwQmY7EBigUTwhQY7VXLnEyZTSibVBEH5fA6ljLSOBK3/4Z6oYYGa09bNKy9eU
	 C/1bIJIQuKvcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 32E843822D28;
	Fri,  4 Apr 2025 17:02:06 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.15-merge-window
From: pr-tracker-bot@kernel.org
In-Reply-To: <1fac1505c004071e4ad79df7e733d422.broonie@kernel.org>
References: <1fac1505c004071e4ad79df7e733d422.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1fac1505c004071e4ad79df7e733d422.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.15-merge-window
X-PR-Tracked-Commit-Id: e19c1272c80a5ecce387c1b0c3b995f4edf9c525
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 96364527357980ea68bb8bc7ec1490e22b9ed0cd
Message-Id: <174378612485.3331400.10917822712260026222.pr-tracker-bot@kernel.org>
Date: Fri, 04 Apr 2025 17:02:04 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 04 Apr 2025 16:20:13 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.15-merge-window

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/96364527357980ea68bb8bc7ec1490e22b9ed0cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

