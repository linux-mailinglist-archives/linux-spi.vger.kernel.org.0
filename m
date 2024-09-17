Return-Path: <linux-spi+bounces-4838-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A66A97ACE8
	for <lists+linux-spi@lfdr.de>; Tue, 17 Sep 2024 10:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6058B2BE37
	for <lists+linux-spi@lfdr.de>; Tue, 17 Sep 2024 08:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765CF15E5DC;
	Tue, 17 Sep 2024 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXMNeSxu"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A99159583;
	Tue, 17 Sep 2024 08:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726562239; cv=none; b=Qz3S6oDr1n4QbQr1mYHTzFw7FtHS84NkqsjeaeHou6mqay6GsZP3efK08S+TmW2eadXv3c7qS3K+3iQmeC+5+76Rtv7RpJqD8CS+7/sfxg/GhKMJVGFSdQCc3WRppNOz8XWyOozArAexJKClVcQqK5hl3Vju/wbbplR12rMZHsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726562239; c=relaxed/simple;
	bh=aFHFDzJb9fpYwpZTzf5tUZQDlhEUPi0HRt0H5qkBZ4U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=b2H4mB9baE2T7Op/ywuP6VUiwGE9W9FQ6NY/KzR3yFnT75LSEBcfOYqhTzFubja/S9wqB5wW0+WldQtJor8ATnzdzJLhGbBlV/ZyhCY2WyFDe5xaWmbQjsP93HPIbiN+VvUc9uRKVRs+m4zZLcsYb/zIjn7YxB1mvwUyAQHV9mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXMNeSxu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87921C4CEC7;
	Tue, 17 Sep 2024 08:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726562239;
	bh=aFHFDzJb9fpYwpZTzf5tUZQDlhEUPi0HRt0H5qkBZ4U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tXMNeSxu5fwRknDJwjziOKOLSqZ9FLJeGk4T7PKcBJJr+YP6zZIsUTOmNKSROuuLq
	 eyROmau9yUtmweMpi0eyhxiWYoACSS4VBP/RKwkU07e2W98jUckaiBbQGz6VkMSrh+
	 Uttv7aVuUaH8EIxByZu30Q/AjFjCiC+dW60aBsn1S3KHQ8zKuuPMmBrDyohWV8zcqJ
	 EJ0xeSaHoOfTmRWOzkqg+WVXeXLC47M1+15UA9MGEDT0L7f4ke5qoE8Zf9vfzYY+lh
	 RgWurfi6C4HXewGedNGrUy4B6GVfUVZEJt4S72jA1JiaL2NYj1n/c8xDyv+WNgbXrh
	 ztkvOZ7JriwuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711113809A80;
	Tue, 17 Sep 2024 08:37:22 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <ed8725667a2a9b9a1ca8fc371c792772.broonie@kernel.org>
References: <ed8725667a2a9b9a1ca8fc371c792772.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ed8725667a2a9b9a1ca8fc371c792772.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.12
X-PR-Tracked-Commit-Id: 07f1eb718db281c3e0cdb068ea7d73c30921a81c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 303ba85c60442ecdca77231f227126a83ba39bd3
Message-Id: <172656224108.49587.543417542476279243.pr-tracker-bot@kernel.org>
Date: Tue, 17 Sep 2024 08:37:21 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 16 Sep 2024 00:26:43 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/303ba85c60442ecdca77231f227126a83ba39bd3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

