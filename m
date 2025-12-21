Return-Path: <linux-spi+bounces-12063-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9F5CD398F
	for <lists+linux-spi@lfdr.de>; Sun, 21 Dec 2025 02:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25FE7300DA54
	for <lists+linux-spi@lfdr.de>; Sun, 21 Dec 2025 01:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240771B81CA;
	Sun, 21 Dec 2025 01:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMKe0eoR"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F190535975;
	Sun, 21 Dec 2025 01:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766280752; cv=none; b=bVb7an0+lXJvSUB4trWS8heDNw9WUYQbx8oRLCOUJL+b9bDEHFu/sXn6d8JNaGW+rYiFzURnjQsZjS4kJ8IjGaooudhExJ932Rsf+R5QiMt6BLNh17G1ZgdqzTuVxG8/TDBpkCWn2z0H8L3VngO7wt4+bPAq7kmEKnn3fp/ZlMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766280752; c=relaxed/simple;
	bh=XpEmSmC+vplLmtR/VPSe2JkYR1ZJ3khlOVzPLuNDrdk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JMlZdw3J2TJ6HVkq3+mlM4+6lBpwdaNDPmESlk5OwpJ41Ss8jag6k3Fy8q2wm3CM+MQZcYYz1EnpGigs8rDBr9zGY4rbIXyvrHGSf1TbwW650D+swvT8ri8BNdJFHnPTcZfjLL8TzNkd40j/oPhb52xvasViHRbIl6l8OFi0uhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMKe0eoR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962EBC4CEF5;
	Sun, 21 Dec 2025 01:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766280751;
	bh=XpEmSmC+vplLmtR/VPSe2JkYR1ZJ3khlOVzPLuNDrdk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bMKe0eoRFqHtv0K1nxh6Y2JDPB1LJ3CZUpl6oXhXASopb5IvN6Xl7fyr3xirAe4Jn
	 5LVDvoAi4EtW1zlW04myr/0SlhJ+vEJ3wUe9v/R0deb7mFhVAMUVAYXh1rmRjdNPoL
	 +H2ugupQzwo2WfnA/WINsfctipxlZM6kmaJV5iDR9A+1yPB+n4gGJeRSnDidEwzY2X
	 Db7FoB5d4sa7lWQO957wuFbYJh8EK7IRKArsq/KwBHOu9B4oSniOaHOqtKEieCFZi6
	 p3CmHgf5oplbqFfklTyEqLymmYFuap5wJZLwWanLKsO249BIe3Wq99G/habMOdLv57
	 0LR61WuZPTVnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 840C13809A08;
	Sun, 21 Dec 2025 01:29:20 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.19-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251220225812.4BEE51AC56B2@finisterre.sirena.org.uk>
References: <20251220225812.4BEE51AC56B2@finisterre.sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251220225812.4BEE51AC56B2@finisterre.sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.19-rc1
X-PR-Tracked-Commit-Id: 9d651a6c62832ac8d1c445f5fa8c61a03ebfb649
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 78f2a78e8db88270006e09058f22995be281251f
Message-Id: <176628055786.180863.15248638271454928081.pr-tracker-bot@kernel.org>
Date: Sun, 21 Dec 2025 01:29:17 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 20 Dec 2025 22:58:07 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/78f2a78e8db88270006e09058f22995be281251f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

