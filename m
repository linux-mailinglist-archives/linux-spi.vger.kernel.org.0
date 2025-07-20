Return-Path: <linux-spi+bounces-9139-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D6CB0B6E7
	for <lists+linux-spi@lfdr.de>; Sun, 20 Jul 2025 18:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5CC5177002
	for <lists+linux-spi@lfdr.de>; Sun, 20 Jul 2025 16:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B0A221267;
	Sun, 20 Jul 2025 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BH70Mafl"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405BD221F09;
	Sun, 20 Jul 2025 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753029054; cv=none; b=KAqFKN07rGB7/ZokTPIshzBn+64xQpAkFtYQOIIlltDIoMR6Mq25q3HIMcnNGxxgTTXUY62yuddRQCv4lxbj5aPgIkkfLzKxdGo3XcvU5SfZ2h7o02ZG2Bh4PtTE5GNEU/S8QDrq3A3EBIGiZ7rz4ONgF+RRBGuY9tWqpUDFqZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753029054; c=relaxed/simple;
	bh=UjW57NVJkTYbC+NAftPi3D6Taz/0seF71yGUFJ3yzxw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=diWkJmkWn444NxlA5Nh1iY5dAaj3TtLuEP8ItbGJHEu+e1l2VpeZxUmUsrVzu+w6WmqwcSe5l0hXob0MWigRBy6UetaOfqjCq1lPqVJdCjFGM7aZ3PoxCM8W4+W1MsHcSw+5J/ZYuVnjV5e+fTypf+THy5bPtmpm/yzvzjOMlrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BH70Mafl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FB4C4CEE7;
	Sun, 20 Jul 2025 16:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753029054;
	bh=UjW57NVJkTYbC+NAftPi3D6Taz/0seF71yGUFJ3yzxw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BH70MaflxNTSw4DtbT4vl+EHQOTjwfzPd/pV7FLhROwf8EG+cgC+7nlI1ui72xIuk
	 a2NdLZaag6m6PT/U1UqNla8cZ36oYM/62ybhcMWdLv49rxglv5DesllKtwnJe6GVGB
	 oeP/Q+DzuzQTKZF3gKsRH8Rlgcb0x5M5E4kRLxP/TGqFzeIzg9FgDyuWE/ZL2m0p/c
	 9LDROtvpmL9vS2CBXZbeW3qrfsddDcIXgjl3CRZhg1wu+deOxe06QuMg/Iqt0t7T0n
	 r0yIsN5E/fd5HzWab0MDbTQtrG7XjWZPTm9sScbpCdWuN9DmzAj+xIvNsRa1pAcYno
	 2+2/HAHmWFPRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CE1383BF51;
	Sun, 20 Jul 2025 16:31:14 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.16-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <b12fcfefe2ad579505fc03d6f2e4f666.broonie@kernel.org>
References: <b12fcfefe2ad579505fc03d6f2e4f666.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <b12fcfefe2ad579505fc03d6f2e4f666.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.16-rc6
X-PR-Tracked-Commit-Id: 710505212e3272396394f8cf78e3ddfd05df3f22
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 990b11a523a80de81ca4eacb1bdac80ad78fdf11
Message-Id: <175302907300.3241589.4496771531014400581.pr-tracker-bot@kernel.org>
Date: Sun, 20 Jul 2025 16:31:13 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 20 Jul 2025 15:18:08 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.16-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/990b11a523a80de81ca4eacb1bdac80ad78fdf11

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

