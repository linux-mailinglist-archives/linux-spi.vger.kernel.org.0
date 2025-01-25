Return-Path: <linux-spi+bounces-6477-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7D1A1BF98
	for <lists+linux-spi@lfdr.de>; Sat, 25 Jan 2025 01:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81B97163FD0
	for <lists+linux-spi@lfdr.de>; Sat, 25 Jan 2025 00:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF535800;
	Sat, 25 Jan 2025 00:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jonIpHso"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88C11E86E;
	Sat, 25 Jan 2025 00:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737764086; cv=none; b=dV4c9TqoHk9+Bktkehe62UHRJtsx+7ASIqa8H2YfLpVXB1AkNjp+szsNggnDOB2JKx4e244X8L1qRZ9ckUMjUb4CPNh9UE2LqJKy5fQu+0wHQdivY7D7V1/zUZOWJGHXmJAPs5NPjE4bH68ObBkRLbxWiGVHTE8CmWIiJLVZMGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737764086; c=relaxed/simple;
	bh=hAmnSKR1gaTOLwFnVIMMnn+iyj/Fn1eBl8F/R3rsPxM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WrLBR/U66o83KURxZovVRJREl3b7+fRvDXqpt3cODujQ7SDdEP72iIpvdF1YX2VYwHP4H81sUFB7oRM/+NvKCtnwMo1eG5LAlE44Pf9bx5R8p0urOQTPab6JeQ8s1tH0mSN1RKb8A0DQS2/HCKyJXAvmPKWXGKc/bhWgf7cN504=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jonIpHso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E21C4CED2;
	Sat, 25 Jan 2025 00:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737764086;
	bh=hAmnSKR1gaTOLwFnVIMMnn+iyj/Fn1eBl8F/R3rsPxM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jonIpHsowoh9OQiXWYgVRBLDbp+OuwRJHUiZZYdP8w1KtCkhov5I+VCZFKzG7g7hh
	 Rd7fPD6se+Y675MhoNiYux/pW8LyMuonbY1K1Q9rueX1+uJX3z+6dqbROLfWiQ4D/4
	 g2PD3bq/+plLFOGHAnl3YQsQQpwOtEE2z+TogEEvWV0CfwhxzLs9HBVyC8rL3XsUYY
	 ZhGrmlI9XOJ0fe6noR1/rqj/9MqhAMdgTGFzTn8l6p4XCRvUEFpf2pQM7m6ckjDIwB
	 d30KVcW7S1W3bRrVIZzfW1FHLLCHnwtKogw93eQgT4numEJqsaEOzBv8hIpmh32Ruq
	 MjewdgJV8HqWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id CD987380AA79;
	Sat, 25 Jan 2025 00:15:12 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.14-merge-window
From: pr-tracker-bot@kernel.org
In-Reply-To: <5dc55026c1c6ad511e0ff918b43b6792.broonie@kernel.org>
References: <5dc55026c1c6ad511e0ff918b43b6792.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <5dc55026c1c6ad511e0ff918b43b6792.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.14-merge-window
X-PR-Tracked-Commit-Id: a07eb4f67ed085f32002a1af2b6073546d67de3f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b46c89c08f4146e7987fc355941a93b12e2c03ef
Message-Id: <173776411166.2216626.13800467603153993132.pr-tracker-bot@kernel.org>
Date: Sat, 25 Jan 2025 00:15:11 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 24 Jan 2025 18:03:21 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.14-merge-window

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b46c89c08f4146e7987fc355941a93b12e2c03ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

