Return-Path: <linux-spi+bounces-9588-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4B1B3073F
	for <lists+linux-spi@lfdr.de>; Thu, 21 Aug 2025 22:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 951F51BA659B
	for <lists+linux-spi@lfdr.de>; Thu, 21 Aug 2025 20:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF03C2F360A;
	Thu, 21 Aug 2025 20:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LywqfAjD"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B002F1FD1;
	Thu, 21 Aug 2025 20:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755808226; cv=none; b=YT3ciP7lITrIsaOwNdV8NYgIBWDKy+FHPhINZgGTBgcDv4nQCnQRSB+dPk/qoA7jwuU75bvw0ugr2rR/hq8KAsR+5G2yDUV/L9VK1nqWfrspVUkorhZuwT94LYD4qoXkGxOlKazbClyfxtJgcZ/adfi1+cRUEy0w/CDBMJNGtbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755808226; c=relaxed/simple;
	bh=bhl+p0DmMJQytQ9W8w6mhhTRl9UEVNIN7Aufw3znwr4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ol3zzHHgdW9R2++9sRsEGzIKHTuf1xSczNNEdfLX3hPVyiEihnBtQjgjf9pgloZuQHD1rgvKu/G6r+fy8QzueS/5VWscV1W8ezul1qs+3aQlqnSlEBwcBVNlUYlgPs5rg1Lcg2OWR4vVrU1J7yq0Mte1knOWTe+onq2TJlXskHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LywqfAjD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13065C4CEEB;
	Thu, 21 Aug 2025 20:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755808226;
	bh=bhl+p0DmMJQytQ9W8w6mhhTRl9UEVNIN7Aufw3znwr4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LywqfAjDisB+D+NnUDm2IHYO4oK9I75qVON4p3ctMUPZ3S9OWtqBdtNrygNJYcny8
	 uGZuITCjIHhJjPHQ+9G/7q89Gae6oKP7tImf7SyYZcQSqjwFtcQU74OIg5eBjswhZk
	 YLyHHJMrd94HIND/Yfn58R4P8gl3MQNL5jriGBKVjdyuKWAa1CDxrUi/jWUJ0qpbak
	 IJMqNMwXGcSHnsbDsuN7drAWZ2qnWTpqvc2TuAGiMOnVculQUIlwOABfXddSiw6gYM
	 09V6pBln29iC/lJo4RL0wRHbjfMvOiZicoUNlzDE0ANeDy1JElXxPeZdU6koZdVV6N
	 GWwRKFIntmk9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71099383BF5B;
	Thu, 21 Aug 2025 20:30:36 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.17-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <df4a6a9145a7c42a25af15e9dff7fef9.broonie@kernel.org>
References: <df4a6a9145a7c42a25af15e9dff7fef9.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <df4a6a9145a7c42a25af15e9dff7fef9.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.17-rc2
X-PR-Tracked-Commit-Id: 7c7cda81159b1abe7d50bcef2ccc6f662e225c8b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9a36b58a88f62398dbd005e5f3648f257ae2b9b4
Message-Id: <175580823515.1190489.8603738023519533955.pr-tracker-bot@kernel.org>
Date: Thu, 21 Aug 2025 20:30:35 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Aug 2025 20:21:23 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.17-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9a36b58a88f62398dbd005e5f3648f257ae2b9b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

