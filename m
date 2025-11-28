Return-Path: <linux-spi+bounces-11663-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EE2C933F3
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 23:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68BDD4E2F82
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 22:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DFA2E7F0A;
	Fri, 28 Nov 2025 22:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPsmOK/Q"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA652E7BBA;
	Fri, 28 Nov 2025 22:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764368526; cv=none; b=m9AungtQppRf/FMdj56vAajbkARgJWYWlczgirrz5ise4CGFhagPHOZhjYISuw9/4kJdu6uVJGaNHoIDik2CO6ewgW+6ECmNPmrDmkCNpATHcrAwUewT3WBgcUObGo2w/6EhqV7aRw8u5TE8IAM0W62XsVFqePcYgTH1PVq/qKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764368526; c=relaxed/simple;
	bh=h4yTDoLnZSX5T5jT4n02sS1wwHqRR9wltr1aN/lIuIM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tG6hzh1N+yZBETO+LFJOewBi3l5m7iiWUIRtEYLHi+tMYsdBI3SnuR5Io7O1NdPuGOWtDn2/toWuwfUGu0uqSFYFcsIBd8r+YGhjwYdOgPaEqUDoPCzqCX8pJUoefYdHEw0oJGNeKHkWIesN6DdRAgeV208xDhg45frUGh6BNqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPsmOK/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0578DC4CEF1;
	Fri, 28 Nov 2025 22:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764368526;
	bh=h4yTDoLnZSX5T5jT4n02sS1wwHqRR9wltr1aN/lIuIM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dPsmOK/QT5id+j+Ihit9N5SLYBlxWe+1tFED9/4RexJOoPzgUVXxrTBtg+u7XJeJ6
	 kYBd54c9pnYOCvVpZAO7TEjnUfPb7mdo/qI1XBOCk30ipw9QwAnLv7hSvvWZnxrOFe
	 +dh4kISPiUlABGlSqJincCCZkrL9Usy8IC56ytBAIW6UhNA+QXOfIStnrPinjDxPTz
	 LI+AMnrjLgm1YIf3ok/vPMWXME8ewHoE3FUJRG6mEIluyXyzXGSqGgQFwinSaPYt3W
	 r0xyw+IbTbHIcdpr9adNP4UBj6Mtf7HSqDD0iEMLu0qxMIRxpZ0s2sbWhkWnEEyUBW
	 6K2aF8iwbt7rA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2704380692B;
	Fri, 28 Nov 2025 22:19:08 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.18-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <e5dbc9d61c0e057d24e0e263175818f1@kernel.org>
References: <e5dbc9d61c0e057d24e0e263175818f1@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <e5dbc9d61c0e057d24e0e263175818f1@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.18-rc7
X-PR-Tracked-Commit-Id: 40ad64ac25bb736740f895d99a4aebbda9b80991
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e6640487845061255af9614ec0a192e4fafa486e
Message-Id: <176436834741.815567.3233716157329608158.pr-tracker-bot@kernel.org>
Date: Fri, 28 Nov 2025 22:19:07 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Nov 2025 21:56:34 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.18-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e6640487845061255af9614ec0a192e4fafa486e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

