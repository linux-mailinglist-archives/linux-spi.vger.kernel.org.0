Return-Path: <linux-spi+bounces-8378-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D239AD0919
	for <lists+linux-spi@lfdr.de>; Fri,  6 Jun 2025 22:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B6B816B628
	for <lists+linux-spi@lfdr.de>; Fri,  6 Jun 2025 20:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55F62206B2;
	Fri,  6 Jun 2025 20:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjjRihJB"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B15B2206AC;
	Fri,  6 Jun 2025 20:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749241822; cv=none; b=kluci+EagIRLuR4HkPogoFBaeGnHfqCbUu8TVd6fol0MZ5+jQjcpIZUpDQix4tYvVMgb5+jCkRVoLsWE1Rx7mH1D/iTT5jjUrKssnIao4KHQn2JAKp7epfH101iHGRBug+NAbAjiSQ7NwboSHS5ZD83qR+/C683f/4WxbRlac1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749241822; c=relaxed/simple;
	bh=7AEqDwzu6KDTm7ciF2WMD0cK7H8dvye3fiLzz/Cv9G4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=M/Tm6txOI6FRX9XIpQu0BRsuvTd2iod3iIobxxlezQWmB6G7sJ1NgxfGKAneqbLyiOWIp5jhp2FomcsNuVrZLjxNmzobIn4sZ+cH8e5gQOZtL1Xd3pf/ffpOdfZwTNH05lD0bjQrm3esHaa/YR0/cZ7/R3q2wm489siuIFkBzqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjjRihJB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE32C4CEEF;
	Fri,  6 Jun 2025 20:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749241822;
	bh=7AEqDwzu6KDTm7ciF2WMD0cK7H8dvye3fiLzz/Cv9G4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HjjRihJB9g1CN+iFAFItpHPtSz7URP0ZgfJHLvmyNaVVCgHZ/cP7JnIKXeBD6m4Xl
	 rgctnq2aZ1ETqx2h01g4gto/e6RE8TWIRE8GPU/pVYPIwWmIpjSnIW5HdHi5J/mDCC
	 SeWKYgmv2EmtR2OErvy5vnVoTIgpRceGdIv8JwPl5/a2GDdGrebEharuvlcDOJY7MP
	 AUyzUPLfUGDqzQPDgQIJe0dz9dmEbqD9mWS+kzpdAyMjG2EJdD7ahdWCUUjvZu+7YT
	 K6m12VChMyqQjP6SnMEgN+9jgGYCL2PoI7tBTMFRblp0xP8XL6KKrc4VU4ixG7ydx+
	 iukK9Wbt4a0mA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C2339F1DF9;
	Fri,  6 Jun 2025 20:30:55 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v6.16-merge-window
From: pr-tracker-bot@kernel.org
In-Reply-To: <6cc76c26f4d4cca79b1f6fa9c7152f91.broonie@kernel.org>
References: <6cc76c26f4d4cca79b1f6fa9c7152f91.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6cc76c26f4d4cca79b1f6fa9c7152f91.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.16-merge-window
X-PR-Tracked-Commit-Id: 57cf46cd1fe351846e1b065ca9546eef66675ecd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7a912d04415b372324e5a8dfad3360d993d0c23a
Message-Id: <174924185396.3981198.8080624054043824553.pr-tracker-bot@kernel.org>
Date: Fri, 06 Jun 2025 20:30:53 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 06 Jun 2025 15:45:47 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.16-merge-window

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7a912d04415b372324e5a8dfad3360d993d0c23a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

