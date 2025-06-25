Return-Path: <linux-spi+bounces-8773-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 620B5AE8D24
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 20:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF125A394C
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 18:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2370528C87D;
	Wed, 25 Jun 2025 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZXd7y1A"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F036E1CAA7B;
	Wed, 25 Jun 2025 18:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750877841; cv=none; b=hADNphSx5xRz2f8+xjmaMYPZA81roBVabT6INs2ejlJBLy9yAEV7GVqp12yUshnW+xgjsEKWQntFhe41F8Bp7qZWS0YUSdOLkH1np6ov7gUV2hdEFApi7j9WlIpJ/oq7AVrVqPKMztmqiOGZXi2TuP0deOnxUbu54A8ENhgPB08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750877841; c=relaxed/simple;
	bh=g9MdnvXM1cS39MYc2X3tFmUcCDwm1mtB3Z0pQyd7VEs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EraNQYz1DEVuIGJioCeQRP8JfnK9LTAQRGk5pruxCoINhc9PX7al+AKC7Lmi8W9OiurV5UnpEa+esLZducrH9In4b5ii/aMooBWjnU524+IFo0SZImsSRqLU2xwmgWbVBROEhRGSVEpu4nTkkLVfu8GzASy8jsqKYg+f9KpHB4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZXd7y1A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 890B2C4CEEA;
	Wed, 25 Jun 2025 18:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750877840;
	bh=g9MdnvXM1cS39MYc2X3tFmUcCDwm1mtB3Z0pQyd7VEs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aZXd7y1AHwWzhnVdDxYD4GchVJkQrzn8vsDCGwyJJQSca6GCDrHao0pM41zEkGrQI
	 8+X11XI76jgkJfwkigO39xkDfvcvn/6XAP5DGBP8dX3hJJAtjzx+rG/bBX/MyMB6MP
	 tpT8TPpODZD+stKG1qUqQbIVOpfkO+IwzJt0dQ1REhFYhjiY4YqPS++cjVAkclySEU
	 4CEtXOqPGFartSeQSPZYAFGUrd/ZhKyD3cZQHDHfG1cKu/bUWP0Hst4bJTTcnoj2u/
	 gBy2vfcgM5tQbGWKBKfU+2lsbj0vpi7nO9CAVHrU8B1GRL1FFEMp/N7T7KL+krcL+i
	 BODN3laEJ1FXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341273A40FCB;
	Wed, 25 Jun 2025 18:57:48 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.16-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <95ca93d21c843dd7a6ae15410596d123.broonie@kernel.org>
References: <95ca93d21c843dd7a6ae15410596d123.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <95ca93d21c843dd7a6ae15410596d123.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.16-rc3
X-PR-Tracked-Commit-Id: b07f349d1864abe29436f45e3047da2bdd476462
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c4dce0c094a89b1bc8fde1163342bd6fe29c0370
Message-Id: <175087786687.586441.1151070774574538348.pr-tracker-bot@kernel.org>
Date: Wed, 25 Jun 2025 18:57:46 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 25 Jun 2025 19:53:07 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.16-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c4dce0c094a89b1bc8fde1163342bd6fe29c0370

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

