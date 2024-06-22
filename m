Return-Path: <linux-spi+bounces-3538-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB0B91361A
	for <lists+linux-spi@lfdr.de>; Sat, 22 Jun 2024 23:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D646283C4B
	for <lists+linux-spi@lfdr.de>; Sat, 22 Jun 2024 21:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150326A342;
	Sat, 22 Jun 2024 21:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWth6dmI"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E756BFC7;
	Sat, 22 Jun 2024 21:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719090312; cv=none; b=OnFv/uAJosl7dcXYp92WEIcQn+dB0P2npoFUOhQ0wjVEfLV3WbojXC9vNKZ+5eL/fJ3IcxaxMUh4hpZ0EJnCtD/pKSGg1w/fhRhXNTjV7UhI0u25n4xJNFwzE47v93hemkca1i41CpkIX6vbMWYnndd9iI5HRuXSC+PgND+fqfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719090312; c=relaxed/simple;
	bh=5hKqXUILr1PLO+8Lbd2j90qjdkG88jfY+RxiDmoOpn0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TJfMHij0dBclniOoHeE1VPPtiRXnYgbZWa5BynDWY5rgu/f+C+/snUPEhL/hcQ7XAJJeZYBwYuNCnbfKNoSAVsKGtuSqUx6ivAkIanmmdDL5VIDZ3pHlzykrEhynoHNVkxgcZU6sRhokXCd6ulg5zaJiRjLhVhIUYobJMxXmqIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWth6dmI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3932C3277B;
	Sat, 22 Jun 2024 21:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719090311;
	bh=5hKqXUILr1PLO+8Lbd2j90qjdkG88jfY+RxiDmoOpn0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uWth6dmI/olue6kJUdqfEjnAzRIELML3504aFBdLs64Iocbci3jg1/09l6tEMahn1
	 Te2rVingWxpUOc2NgNSqZafw5ObkonGwi2QAZjYh14RKzcPF2YBZ92pK3ja5spwA4y
	 VojUCaleEZdTU0Q/KzJ8SOSDnIizQAwzLvORxzRR2umbe6SF4oHEv8VAsVVhsx5c0R
	 Bw/SgINO8fbAdJuCH15j5kXWK6Uzkrg5Br8efgR8kHUWhadNbQnRM0QGbZo7L8nKb6
	 m4ueqO5gm5Vl1rc6zmtPJD6e7w5jxJC5gqeqCIRR5LqueqemgBM6G8Bc81ADIKWSQu
	 H5BiEArwoc4ag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B989FE7C4C8;
	Sat, 22 Jun 2024 21:05:11 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.10-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <fcab2f718f086fd6e070a6ed65a28900.broonie@kernel.org>
References: <fcab2f718f086fd6e070a6ed65a28900.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <fcab2f718f086fd6e070a6ed65a28900.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.10-rc4
X-PR-Tracked-Commit-Id: df75470b317b46affbe1f5f8f006b34175be9789
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e24638afe264fd0f189ae7bb5941ea18b030911c
Message-Id: <171909031175.414.9176961453754675961.pr-tracker-bot@kernel.org>
Date: Sat, 22 Jun 2024 21:05:11 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Jun 2024 17:22:12 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.10-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e24638afe264fd0f189ae7bb5941ea18b030911c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

