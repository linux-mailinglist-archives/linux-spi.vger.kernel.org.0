Return-Path: <linux-spi+bounces-10330-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B0FBA755D
	for <lists+linux-spi@lfdr.de>; Sun, 28 Sep 2025 19:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0C884E10A2
	for <lists+linux-spi@lfdr.de>; Sun, 28 Sep 2025 17:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3F5212B31;
	Sun, 28 Sep 2025 17:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUbgHlQe"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DAC1F5435;
	Sun, 28 Sep 2025 17:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759080686; cv=none; b=F0yYkDHW0WQO/NrAUDiqodUP0RmlUFZ2iDaqus+jR58CMlNIjkcA94SxDYLm8U6JstHHIC6aNBsKZDoxzc/vd/IG88/shDZAHg4ilA9EcNHw3C7Ir+kQzfxCtD3iyUhvK0nP9CrXS9t7S7xy7Id7j2pspMAUnjWa25uUWmv1Dvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759080686; c=relaxed/simple;
	bh=HbGPT4Zql5i4PwISfqYs6lkjzvm9olMEWIxvtzU432w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SK3qVL0VXRoyAwy1l0iKFCQDcRFaxsuWaRjA4FvfEun1G6gHr83fmPwgEODrgR0McfDDfl0mlT3iU6i/iwBzzaD0qRYDSoXf+sfdfnngR2QMsVW2kLSdFwGaO7KRKtedKkPEV4QVl/ffLwWSo7RYSYlWEAgvQezXyZp0Da3YGqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUbgHlQe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5D8C4CEF0;
	Sun, 28 Sep 2025 17:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759080686;
	bh=HbGPT4Zql5i4PwISfqYs6lkjzvm9olMEWIxvtzU432w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YUbgHlQeoZCgY/UJ3Bwrv61TfJrZ0vR5FTvmiAdiyUO4TUGRZoOocn76ukxJCB2bs
	 cKYMZHKfHzzLuM8Nu5uCADTCUN/H3TTeHCr19oVWv8Sos6/+G3O6Xfk7CadPJZCBfv
	 O3sYccjLdYIe5VIs03y+03Zv2LFsjFzBoHCcXbupi2Q6Hh5n0bsK9PrdEB0VSCvhLe
	 vsU3i9j1dgcYlwjkoekcsgYylIVRBH7HMSjFLsgUhC2kZ0dweyqMmPqbLulICNO2W2
	 fDS1PWeB72tD36lgn9Fgz7OsPKODk4+8gRGwjbrB9UW80IqOxXJ6/aoDofoAKBjj9M
	 6xMyYrwnc8xLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EFD39D0C1A;
	Sun, 28 Sep 2025 17:31:21 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.17-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <e6994ab73abe36e39ec60eb63341f022@kernel.org>
References: <e6994ab73abe36e39ec60eb63341f022@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <e6994ab73abe36e39ec60eb63341f022@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.17-rc7
X-PR-Tracked-Commit-Id: 398a8a4e51dbd03e4103ea596ea4ea037fe67175
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5b2a9f5056b64aa41bd11d9166d836df30b0897
Message-Id: <175908067995.569924.9212046945760756463.pr-tracker-bot@kernel.org>
Date: Sun, 28 Sep 2025 17:31:19 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 28 Sep 2025 13:53:26 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.17-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5b2a9f5056b64aa41bd11d9166d836df30b0897

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

