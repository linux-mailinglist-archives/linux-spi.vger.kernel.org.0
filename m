Return-Path: <linux-spi+bounces-9193-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDBDB12D04
	for <lists+linux-spi@lfdr.de>; Sun, 27 Jul 2025 00:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8877D541D62
	for <lists+linux-spi@lfdr.de>; Sat, 26 Jul 2025 22:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428ED19F12D;
	Sat, 26 Jul 2025 22:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXekl1Kf"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7E610F1;
	Sat, 26 Jul 2025 22:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753570067; cv=none; b=a2jwJcoAfw28C9HaNO0rl7CM34hkXedyvCbAzOwOEWksvzI6EvbS8bJ2py53meHYmDbPXzBizFOVZmPIhP/0a6caqANCMQbQfvjoGPwBOnYsB0qgmj0SCpWC6UAdakV3efkfpyJ6931afAwqWYkjsr/HkYoP4VRxiF4+/oBWylQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753570067; c=relaxed/simple;
	bh=sFhxu4uCeYewrPKlcDLHvcUOwlN3L/gUcmvAKb8FCeU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CPVz6mnyP205RIWEwUx1eQnVabxq0+ScS7dkzHxFSrvhmbl8+Dhbm9iKdTwVY5vGqV0/iwJcPIONc4MFoAoDSHwnhx/bkOvgzbwaBq7FCgiAsN0smZkY8WvkdV84o8H85PrVujFGulDt3nYaa08vBsmAJsVlXJD+/xLjxe19QXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXekl1Kf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FFBC4CEED;
	Sat, 26 Jul 2025 22:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753570066;
	bh=sFhxu4uCeYewrPKlcDLHvcUOwlN3L/gUcmvAKb8FCeU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eXekl1KfUfkiad7Xiq9na/3diZz8S9016y4Jqu6hi7eYyfxEdHAvlq4Byl9qO/wuf
	 np5zIgXGwrcyjGgPc9ELrLsJkFds1tLV2tUPfzU3uJWUzJN1ddZsMG+Iw7tmjFBDmC
	 AMPN4rJAfMUhqcV1rST91KoSlQxlm4mm21Je90OICI30gKuDXU2qvgA7ZULmgbJDsk
	 sHQYmzH8i096lgjrZzBAjUxcTUiDSlgfeDG5evRQhHrsNQ6Ug1cVx2gZ+qV8b5V2oD
	 WwYAFfBtBFLJBRAI80Dj0QBMgHdX8hdREwxbOLQoTZ7CGvHjUW09r4zOdvyzsvlPli
	 7+8aRdBtvK4Tg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB142383BF4E;
	Sat, 26 Jul 2025 22:48:04 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.16-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <7ab95b9a2a3ad939ab24c1c8c4175096.broonie@kernel.org>
References: <7ab95b9a2a3ad939ab24c1c8c4175096.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <7ab95b9a2a3ad939ab24c1c8c4175096.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.16-rc7
X-PR-Tracked-Commit-Id: f820034864dd463cdcd2bebe7940f2eca0eb4223
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec2df4364666a96e7868b7257bc7235bae263dcb
Message-Id: <175357008355.3715092.9287088463096479088.pr-tracker-bot@kernel.org>
Date: Sat, 26 Jul 2025 22:48:03 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 26 Jul 2025 22:37:56 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.16-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec2df4364666a96e7868b7257bc7235bae263dcb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

