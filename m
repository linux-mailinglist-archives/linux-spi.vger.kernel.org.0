Return-Path: <linux-spi+bounces-7862-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9ADAA7E48
	for <lists+linux-spi@lfdr.de>; Sat,  3 May 2025 05:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFC399A2AB8
	for <lists+linux-spi@lfdr.de>; Sat,  3 May 2025 03:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9F515666D;
	Sat,  3 May 2025 03:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSB8YLF2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E873CEEC3;
	Sat,  3 May 2025 03:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746243266; cv=none; b=NFzRrA04iiMzzfIfrYoqPtNTJcHRsFsQd1IewmqbzDfFXOpt4pcu3nJCnR4Y+PDO1OsXBDf2bH2t2p61S3VQbxVYm4Kjjjf0mQNGkN1Ab+NC9erP5omXTdw2xaiBsA2War+LY6RrjwVUjaVTWwfEAuoUjeMiIE2E44TVSIDMjko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746243266; c=relaxed/simple;
	bh=PjOdFIdI0wPuHDojoWUpU3RTdOnQV1sClW93tBY0JiY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GIHR2k1nNYCeUD8c25HDMalbOfCi4YAYzLO9CbTufkeoJW2SpP0z3qPi8ow/P8ENAxV0Eougi/qNtvxHfq7lKotPiraX9pnDkjzCiB/oJil5pQnrcn/SxpiIkjV3p9gd7KmnXBQNF6GiOkxyzFOsMr2nCrQ//WqyPNNX3YxZdxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSB8YLF2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DE8C4CEE3;
	Sat,  3 May 2025 03:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746243265;
	bh=PjOdFIdI0wPuHDojoWUpU3RTdOnQV1sClW93tBY0JiY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tSB8YLF2pnMiiDDD7ObrVoGRaUPYR8gWkwChDRqv+VPFqFNp+ZNhaVpyRU3GTSSYL
	 Y1cpmaaBxyOPh9kYf9o3BxtwiAsh+Iu+TIM1tllkjAn3xH5t5siHLre5ALV45qCmVr
	 bQ4oPOLt7G1cICr4RTul3FU08GiVdmRnfsz9SArn9XYl7FoTgZbWf/fRWVsX8/hYOa
	 fuLZYukT/85CIErg1vSiRWiZnyeeAII/KUQQLjufXaoV4Vve2c0kbKA2QndpCA/vW8
	 u+PF/frWTfLRW1QJJ55VRuPW5TbPtMj05L4n1Q13RJUs5upsu3eyUipV661mbOnCAA
	 ewXt/rV6A0GOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFC2380DBE9;
	Sat,  3 May 2025 03:35:05 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.15-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <9751094822c3f97d71b3f100baf655a3.broonie@kernel.org>
References: <9751094822c3f97d71b3f100baf655a3.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <9751094822c3f97d71b3f100baf655a3.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.15-rc4
X-PR-Tracked-Commit-Id: 4426e6b4ecf632bb75d973051e1179b8bfac2320
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 95d3481af6dc90fd7175a7643fd108cdcb808ce5
Message-Id: <174624330431.3786871.15723043373719859438.pr-tracker-bot@kernel.org>
Date: Sat, 03 May 2025 03:35:04 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 03 May 2025 08:29:59 +0900:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.15-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/95d3481af6dc90fd7175a7643fd108cdcb808ce5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

