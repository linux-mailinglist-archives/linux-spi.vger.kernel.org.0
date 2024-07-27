Return-Path: <linux-spi+bounces-4022-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D693B93E0C8
	for <lists+linux-spi@lfdr.de>; Sat, 27 Jul 2024 22:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896211F2165C
	for <lists+linux-spi@lfdr.de>; Sat, 27 Jul 2024 20:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9596E1741D1;
	Sat, 27 Jul 2024 20:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tReQL+Cn"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC3412EBCA;
	Sat, 27 Jul 2024 20:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722110840; cv=none; b=lf5iGuc4yzQGQfkVdKq0s4QkaMN8hMRtyMuSbUNBykNbI1pXxzq/hHY8d8MAKIEgKXvbZJ++BXxLOLnjej2ZQUjwFdEqgWyKGCtSULa5czpwUHWEtrSpGOre/mg5EkfAZCwAl2WsEnpsIgNO4th+vlNeVSoCd6xJh6Y2wq643CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722110840; c=relaxed/simple;
	bh=M1WGpz7lS4aqJfWgc0LAyjB2lfzwAz/WKeFunA3u0iA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=h1yLtAH0zSnNuZiY36CocLLC0ad4rYPn3zA3HBGhuxIch9/KCTsKB4QO1lb+MCQ8FTrq6nMl4cn52JXn7V4cNCoSUp5fmqz5VXwH8gZbUK6AKEhjCPqj7EzllRkqpMYEyoD4ot3TZBh+qCA3dz+Eh1qkv7XjLYbyqA/gjjhxvnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tReQL+Cn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53A94C32781;
	Sat, 27 Jul 2024 20:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722110840;
	bh=M1WGpz7lS4aqJfWgc0LAyjB2lfzwAz/WKeFunA3u0iA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tReQL+CnVo5EvNMSFRn6sDOdcwy+5Nwx6wxdvzB/Vty+yG2sjNbKVdBynvzLHT3yy
	 kKxNgMwESm20e0oZmUI8VX3sn526K/NbkyeOjzSDwTu4NXLrl6D2CY6anrZ/+S7CsR
	 UgdOjCylcvjfXB9EA1/8/vlxgYUYvUhm1ZFuYyAL/8BEcweqoEU5sWuCqhL/j5LPr7
	 M2Jm7k1lE9ToopWs+HBQ/N55EBo7/cZHBbF7FxMvVRmnFH2NTq51GOtfb1vYZQpYKA
	 1dRdhA7zSFipHQCa/9nFkODGuV4JQfLAsXZYVd4PSjfNske/boDz70CJdgmD1EjxEG
	 Uw0++s6Tt+IMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4880FC4333D;
	Sat, 27 Jul 2024 20:07:20 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.11-merge-window
From: pr-tracker-bot@kernel.org
In-Reply-To: <bf741d1595d001bdd140a858fb45134a.broonie@kernel.org>
References: <bf741d1595d001bdd140a858fb45134a.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <bf741d1595d001bdd140a858fb45134a.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.11-merge-window
X-PR-Tracked-Commit-Id: fc28d1c1fe3b3e2fbc50834c8f73dda72f6af9fc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab11658f26bfb5bb62fd7155fe821e511e9a4668
Message-Id: <172211084028.16614.15745217185972603920.pr-tracker-bot@kernel.org>
Date: Sat, 27 Jul 2024 20:07:20 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Jul 2024 19:38:48 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.11-merge-window

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab11658f26bfb5bb62fd7155fe821e511e9a4668

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

