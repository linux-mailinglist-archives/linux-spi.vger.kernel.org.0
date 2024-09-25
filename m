Return-Path: <linux-spi+bounces-4978-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4183E98690E
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 00:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71BB31C22FB3
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 22:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6FE146A7A;
	Wed, 25 Sep 2024 22:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqoKtCL5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39061D5AD5;
	Wed, 25 Sep 2024 22:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727302053; cv=none; b=Zsao7YtJQT7ZMzd+jsY/n7QeGiDMIIrSzD0gRNUhX/VLpkyrsB8e+aT4ItpoGeYfm9YwkM7dK4ZLbEHIZ8pIB0Ee8p0mlu8C5654A66irCDGwgWTB2ajp0Yrc84CosfKe2piUocg+ZfgyJgCqX8gYFjbpJcF6XG3xUCIoPjUiO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727302053; c=relaxed/simple;
	bh=WNoIkwVmat+ljeoReV4pEd2da3dv5STxiTCLNbW3UDA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eOV3QSKanVBBXhXVQjfT4tk51BOzn0etec0cU5/AmiV11YHeWUpdfze/qLi+e9UbZf0Kq8ghvfIqYcU6FvQ4dL/E6k3rB4w82uF/ENphsy7qAW8jlJygC77/lEVo9CSdvtvn4cIVfSYynLpsDulXecBYYQ3WzE0I5ehk++OWxsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqoKtCL5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47724C4CEC7;
	Wed, 25 Sep 2024 22:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727302053;
	bh=WNoIkwVmat+ljeoReV4pEd2da3dv5STxiTCLNbW3UDA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FqoKtCL58bRpMAXpZxsekwTxJktVQczizxgHyEYY7H90NW5/hUlZESOIlxBS7m5Br
	 rBTt8bOp9b1+xQ0E3u8q1W24qQxaoDCFy/wIqveWNj+JD2tWoOOQ1nbyWpouw0PgI7
	 TiF2WCfmpnpNR1JvpgqaSsTcwK826rDoZEg66xztE5thhYHofjkZ4lhkOhvYjnJUrF
	 14PXlWAWsQIpCAczkTW4AeJfldYZc5TdkZxZi6yBxhl8Dif2XxWNG6Q81vtXyVLwSC
	 1DOkn+kQICPIu8zcToU6Ew0wlxqggBg2tA9uiC0G0HcaYQJZWQy4YrQQAoehS/tG8z
	 NzsMjo6b3c7/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFB73809A80;
	Wed, 25 Sep 2024 22:07:36 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.12-merge-window
From: pr-tracker-bot@kernel.org
In-Reply-To: <5ae623a059a1f568473204bde232a815.broonie@kernel.org>
References: <5ae623a059a1f568473204bde232a815.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <5ae623a059a1f568473204bde232a815.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.12-merge-window
X-PR-Tracked-Commit-Id: 329ca3eed4a9a161515a8714be6ba182321385c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe29393877be63363247510b99ae9a8068cacb31
Message-Id: <172730205543.743114.5778771850041442370.pr-tracker-bot@kernel.org>
Date: Wed, 25 Sep 2024 22:07:35 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 25 Sep 2024 11:00:43 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.12-merge-window

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe29393877be63363247510b99ae9a8068cacb31

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

