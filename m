Return-Path: <linux-spi+bounces-6438-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D86A19903
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jan 2025 20:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D951639E8
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jan 2025 19:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA899216E32;
	Wed, 22 Jan 2025 19:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSA8FAgI"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3080216E2C;
	Wed, 22 Jan 2025 19:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737572804; cv=none; b=aCG2DgUWxh0DCVc6WrAEMkcpHAITIYEJrcB6CRLgpbwFz6ofA1AB8FlQxhAjTafkw1jkwJPiLV1Z0vuYVUQisbm/eAicvZCxINAjb+yzQ8s1/kzZCE3GvuiSqQXoJjnuS1o77QIhJK6FTg7gE8CJCzGwUn9VGHMqXFqUlB79zCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737572804; c=relaxed/simple;
	bh=VIedzi/VNWcapUIDOx9R1OGKjEF9XS8yos/5fIXux8E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DP4FQ3q0YD1tUZCVkm0nXIf1tFO7Sjbn8zo0myFH6gi6yoiwrul//O0jtDo643l8V4JMO4ttEX/BPj3vbDWXV24VMVRCqdGqmwO07yEV8yncFpQmrhTiHFum1sM/rmsiKUqMo/CMcLYFi7HvpuOTObKq3NYQOP7IZYM2kd5CK8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSA8FAgI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF62C4CEE2;
	Wed, 22 Jan 2025 19:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737572804;
	bh=VIedzi/VNWcapUIDOx9R1OGKjEF9XS8yos/5fIXux8E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FSA8FAgIFuqLNCQuRuWF/RnjVUn6O7E7c2wnNA1TR4h7plKzzJMKkHEJKS6DaEuXY
	 7w3On+R/F4vy/1Ph4YyJlon6PibEhQ6VETUOKv4FMwwn1efe3+tm7motUi+fVCu1n7
	 mo6VevqrErOCBYHxDiA4UaZVBc8POtgoGORctHS7OPLJmbfMIXJyhZFq+pjwNwqjCF
	 DWpeHfaX6YrYmetNi0PCN3bVs/OlDSw82JOZYWeeocbqz36ug9I1UUPcE6eyD2xYuY
	 YFlqW5TvR7EA4l+82vyjtlzhhD4GKLzll7ALSRn02Kaje7Cqu225U3oTWPZbte9Rou
	 joIMZBNXoj7+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F5B380AA62;
	Wed, 22 Jan 2025 19:07:10 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <4c1f6ab0a30b9258969f7e1d4fbb46f7.broonie@kernel.org>
References: <4c1f6ab0a30b9258969f7e1d4fbb46f7.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <4c1f6ab0a30b9258969f7e1d4fbb46f7.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.14
X-PR-Tracked-Commit-Id: 78b435c9044a9ec321da29d299c70cb14b059682
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 38f5265ed2c468f43a3080e4f82abfe53d7ea0be
Message-Id: <173757282877.783272.5566572103387037495.pr-tracker-bot@kernel.org>
Date: Wed, 22 Jan 2025 19:07:08 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 20 Jan 2025 15:05:02 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/38f5265ed2c468f43a3080e4f82abfe53d7ea0be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

