Return-Path: <linux-spi+bounces-4705-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED3E96E820
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 05:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965AF2864CD
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 03:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5534E1B3;
	Fri,  6 Sep 2024 03:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdMwcQSq"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BA84965C;
	Fri,  6 Sep 2024 03:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725592810; cv=none; b=b+nBBg8GZmS61ObI8r4KK+JutmC22vzr4k1X59Bexor/YDbE+Tpb6mbDHuSYb0Do4qM6tRmErmmKK+2id2X8HE3Z/gPWz4VoCCnao6gK2bkpYFPW7oSH3M2Vv0dtG1s3ccaUIHQzDF/et3mNB2VsV/ot04SDmFPTTvPA3utwBig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725592810; c=relaxed/simple;
	bh=jEnAmQVfD1kYHDqEOoRKWHxd7ES8Bgn0s7oADpvXLWM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=upM4t59dhk0W7RB8RjDTfk3eU+4Y5Bo3OqxG26hr0YRrJDsgcWJEUX67KFMhvKLVOV0D9y9AMhCCTn6oAMbzDC70T3g/N3rjBRP2R0l+H62SqiHPF3bWFyHD1CyWXzNy8HD64hTm3zlQrEHP2nEtKiT/IJBusEIzz1FmKidjlRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdMwcQSq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDADC4CEC3;
	Fri,  6 Sep 2024 03:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725592810;
	bh=jEnAmQVfD1kYHDqEOoRKWHxd7ES8Bgn0s7oADpvXLWM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XdMwcQSqwSd1AB+1UUWwBEh83kDA1fQ/oLBd763JH9DBuEy0/hzbugP2Njou2p/Xu
	 ag+cke1GhDVTRxWqYDCfw5fvDxCZIJ3fswhfgczpVAAV1PS4vFR3HZfGDSwYa7p6AM
	 ZYmbDZuF1au2eUyQpf4IHdqqvWZQTGw/59K8OzRbXDEjm/ckvLww7lS3G+1L4gefS4
	 EO5D2kRmz+W5x5O7eeeN/X6kDhFUE5BKcikeX1bR44W2v8Oj8rHLq3on57U8RKvuHo
	 HEAbTfH7KbhsI127mr9CbpAkWoyg75J/p18CCnwrMdMNfrjXCzX2A92CG1LQwvEZBI
	 w9/vKE7Xv2wVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711F43806654;
	Fri,  6 Sep 2024 03:20:12 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.11-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <7f8f5f4771bfeba33bb62b2f6b60c254.broonie@kernel.org>
References: <7f8f5f4771bfeba33bb62b2f6b60c254.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <7f8f5f4771bfeba33bb62b2f6b60c254.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.11-rc6
X-PR-Tracked-Commit-Id: c9ca76e8239810ccb08825a7b847c39d367410a6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f95359996ac35206ff24e378052ce564d5bfdc94
Message-Id: <172559281137.1917326.5603200650685826250.pr-tracker-bot@kernel.org>
Date: Fri, 06 Sep 2024 03:20:11 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 05 Sep 2024 23:09:39 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.11-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f95359996ac35206ff24e378052ce564d5bfdc94

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

