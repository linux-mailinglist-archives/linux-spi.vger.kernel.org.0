Return-Path: <linux-spi+bounces-4159-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D70D494DAB5
	for <lists+linux-spi@lfdr.de>; Sat, 10 Aug 2024 06:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD911F2269F
	for <lists+linux-spi@lfdr.de>; Sat, 10 Aug 2024 04:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1522013B2B6;
	Sat, 10 Aug 2024 04:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2Iyd8cR"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39C1131BAF;
	Sat, 10 Aug 2024 04:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723264290; cv=none; b=gkjMjDeX1bNAPG5YkRoOjoJ+sGia6DZyZ825M/PBFd5LG7zDx+Ab8mVR2xDCe0KWWkLLQ15oqHemdbKaDUTTQdcaTsV8PNu2L67t8/lRFv07WI8u8GsYbAr//U+3sgKRHZxpS0cCyCnYFkk+kpbdSKguUfL+rQJNOAHcWUA2ong=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723264290; c=relaxed/simple;
	bh=ETP1A3m94vYJ3+h7sr/ARHYpS8SqbAS1ACywq3v/+yQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=p3O9FACCXda1LRUsWjAqptK2uhrI7MgupvhtV5ANLIL5L1tASOJ8zFmIDhgzsM9GpfPHMr2PR2Bd3TJV+4KQXbrf3Ifyp5cZgB+vOYrDD8E4X4wYA32R/WpQvoWXvWqp4hAEnumxjd3ErymwPpPEm0s8q5L3ZSk7QxUMLgvqXSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2Iyd8cR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5404C32781;
	Sat, 10 Aug 2024 04:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723264289;
	bh=ETP1A3m94vYJ3+h7sr/ARHYpS8SqbAS1ACywq3v/+yQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=d2Iyd8cRlIwWk9KgUXgEqIVMGuLo3UBVZFwi8coh+QfMk1MgBj3YVHMys+cQfQPfO
	 mC3bUm1CqfSDysapMPriqJl+dC49JaU4G1ljkvZdxFVRVm8jRMISL7uNqm0gtVRALa
	 eMM+MvLIRQLl5vWQGvE7Pci+dTyoPcXIdSvzm5DO0nbbQCkXO3PKpP48d2TV8Iw+LB
	 8YfJ1jO7RrWbQzkaAN91M/iJU7hb3nUhtV/oe6rTNyrzFXsRTr7ANX0wmZFdyT5xLG
	 VSdLeA5l5OE/F8Am4XasMdZ0Mowq1ebR4VVJ+zU6memtZrVFokvMaVYbKOoc4oYJb3
	 K0RaxDDhnvn8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC69F382333F;
	Sat, 10 Aug 2024 04:31:29 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.11-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <265e0ee468ae39e19e2fe1eb64e24386.broonie@kernel.org>
References: <265e0ee468ae39e19e2fe1eb64e24386.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <265e0ee468ae39e19e2fe1eb64e24386.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.11-rc2
X-PR-Tracked-Commit-Id: 730bbfaf7d4890bd99e637db7767dc68cfeb24e7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 57b935eb8c553b93e7c88fc3c6f9163b06ef907e
Message-Id: <172326428836.4136681.17723006283034584068.pr-tracker-bot@kernel.org>
Date: Sat, 10 Aug 2024 04:31:28 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 10 Aug 2024 00:34:08 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.11-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/57b935eb8c553b93e7c88fc3c6f9163b06ef907e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

