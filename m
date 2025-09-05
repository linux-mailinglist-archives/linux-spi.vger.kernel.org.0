Return-Path: <linux-spi+bounces-9926-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 749F6B466BB
	for <lists+linux-spi@lfdr.de>; Sat,  6 Sep 2025 00:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 436A556866A
	for <lists+linux-spi@lfdr.de>; Fri,  5 Sep 2025 22:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A32272816;
	Fri,  5 Sep 2025 22:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWs4thxE"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8E2524F;
	Fri,  5 Sep 2025 22:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757111656; cv=none; b=k2hDL1g3rEkJQaQEghpt6RFxNw//nayGigzXtEidToiIrzABCnYSJ7FZghl7zsATwzdkuG43AL5qEDjl29Ol1AdqUss0ktYX1C6tUVFXzR3chkSYopjrFT+JDx7j9C9para0eQ4pPmXwY1F4nKaXpWkHarII5hoI3MDQw2pi+V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757111656; c=relaxed/simple;
	bh=CUZp9+bj/KJba67Ywx0nj01uaiig3RTgVDJGGQyi+ts=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VQjFlL48ILGfmW3Yjtfaw3s4TUnMrgjEZj/Qjq71JNb+kEneRYG/4H2TYX53CPRJoxxVWgs8yGNMKfzZ24C43J4+X0e47ei2pFR6qTh0KwABllTlw4qVvwyFZRKpA1X0yNYDy0IuK1sMHRhvN7PWWAPt2uf+PE1/KI6tDDG/d4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWs4thxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D85EC4CEF1;
	Fri,  5 Sep 2025 22:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757111656;
	bh=CUZp9+bj/KJba67Ywx0nj01uaiig3RTgVDJGGQyi+ts=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rWs4thxE4LrRkvWEJ4iSA1geR4BlUHzfzXqaz7hm0EypuLSLAKsUdOXAn4PdlUUtI
	 hZ/YgWOD1K01ZLSaS0Bo6FhQuB2HWrHNw4M6kGhTR1Y88M7KBJt2iglUtSxjA8fHVR
	 1Eqbeg3HSIztCKrePXJzJXnurM5eGBOxNcV2R/WnXnRM+CMtG6IgjHe8/7IEGN3irk
	 yTydhLdBbKGtNG9U50PBPkpyGn6HK/J/fPn9QufUtgcNQESvlguCFA8K2VEt03s+Ni
	 mMhhaMns7FQp6A7eMyJuUBq8epF0dsnPwVCyZEDSHbg6FErlyW7tVWJa+N1N21FFPK
	 a8vtoqYLau2rg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADF7383BF69;
	Fri,  5 Sep 2025 22:34:21 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.17-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <279ce5a01bec4d9c300da6709a582e21@kernel.org>
References: <279ce5a01bec4d9c300da6709a582e21@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <279ce5a01bec4d9c300da6709a582e21@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.17-rc3
X-PR-Tracked-Commit-Id: 1991a458528588ff34e98b6365362560d208710f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 53b48f62f29dce6dcad490dc1994286994098837
Message-Id: <175711166040.2706660.14198195274543144676.pr-tracker-bot@kernel.org>
Date: Fri, 05 Sep 2025 22:34:20 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 05 Sep 2025 19:39:55 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.17-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/53b48f62f29dce6dcad490dc1994286994098837

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

