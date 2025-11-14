Return-Path: <linux-spi+bounces-11227-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC6BC5F5BF
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 22:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EE724E3253
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 21:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19FF3559D3;
	Fri, 14 Nov 2025 21:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqUWx+Jy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798173559CF;
	Fri, 14 Nov 2025 21:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763155555; cv=none; b=bC4bEBWdDmrlNyg5+Yqh832uqpG9J0TZArZsibZwWFCxQo5pwYv1loB6ZDkLBiXQzb0BYMLM+1jy+lGFfYjMD1DaT5PqoTX861fH0OIAOBdDauUwOy8HL+270J8DYPDfmHglzCVYzMLIaEM78EZUOLqvcpSTRHebg8h/7VCxMIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763155555; c=relaxed/simple;
	bh=IyE9XqoJjMwNMAphJdJGz9iRIatWx3thJQIe9sITNxc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ExsanW873BROXIhW+BKuVo/yr2no8uZYCZ1VW6NbX3kTo8GGC7geuw28qKxDHmZ1BpYnhuGPm7FiPFDXarWlCUhQJGlTyMiBKfEhrQm3SCseqkz5qltQvfAAULFo4IrUdvZq1tr4iUJ5ALXPCM4O7DXZd29uy6HRKkfslxf7lnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqUWx+Jy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03AC5C4CEF5;
	Fri, 14 Nov 2025 21:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763155555;
	bh=IyE9XqoJjMwNMAphJdJGz9iRIatWx3thJQIe9sITNxc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pqUWx+Jys/doYs4cXj4M14OkujNssN82X/hJPGGDpsDV47c4p42oXy3il2lcTGSkU
	 +qmX01ahbXTGNAnSQH6oFIgu7gMop0h5wtABeFMvAD6jytKUiQshXej6pzwXsumGPk
	 QNtD1CErf/UoGauoCz/oeWIlKA3IMm3fpKmDtfdrri4oLi/EmVj83Hki+u94VTwVSV
	 Q4eBL4HHTyNMsbZZFvygh7kai/7DCu9tcPlR/kylC7QSg9w8bujQC8rEBRGFwkABYM
	 McbnIZ1u8jPSGmLifshbPt2xicUptgq7bM3nCC96Lvmp47k/AXwwljc38XwjW5Frmd
	 CFzDgw5uK2nIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCB63A78A5E;
	Fri, 14 Nov 2025 21:25:24 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.18-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <fb5ead855a2851d4068598461ca74593@kernel.org>
References: <fb5ead855a2851d4068598461ca74593@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <fb5ead855a2851d4068598461ca74593@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.18-rc5
X-PR-Tracked-Commit-Id: 66e9feb03e7cf8983b1d0c540e2dad90d5146d48
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de90cc610eb61341662fc23919dd823573ef9a41
Message-Id: <176315552335.1840076.14680438952133506288.pr-tracker-bot@kernel.org>
Date: Fri, 14 Nov 2025 21:25:23 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Nov 2025 14:43:01 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.18-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de90cc610eb61341662fc23919dd823573ef9a41

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

