Return-Path: <linux-spi+bounces-8551-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77169AD9428
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 20:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8EC17B37A
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 18:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A491B241674;
	Fri, 13 Jun 2025 18:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2N/vG01"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D6E23F429;
	Fri, 13 Jun 2025 18:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749837870; cv=none; b=XhdqH4rVAjEc4lFRHW8Az+Aggd8jJBti+klv0w1BOdWIB/W+gUidGL2HaLEkLn663DXxZcD/VMmodPyD5nkQmzepNCc9n8mKktJ69MMIjVKOFLny9B6vRMHZWi6gx+wdcv0TjHr8g0o/DN3+f1dHugcQaTJwp7tDVkgqclsQ9Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749837870; c=relaxed/simple;
	bh=4lgOtRux7AhkwT1tqi+zKVMpv+dgcgt+LmxUhdElYh4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Y5+HO972CIqeXvofGeXMijvTEwRVert8XM73eOz2asU1/5jUumfy3yOuJBj0U1m/rhoq6puZvKvEjGTIwoLBoDM6hDS3/6xbHNqNliA7DSi8gAEYOtoCGL27Hj3UebIBYogUdzHOzTA6mqzl/kyCY1W5M+aJOb21NciiA9OKVTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2N/vG01; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C32FC4CEEB;
	Fri, 13 Jun 2025 18:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749837870;
	bh=4lgOtRux7AhkwT1tqi+zKVMpv+dgcgt+LmxUhdElYh4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=R2N/vG01o6zUug0W9HmR1YiqvbrX2kawn+ic2zDOtFave/mXT/pLHtYfI/bcCnRPr
	 g3NqCPtyrUlKkAAVaFscYOCYWzorHGDUMXkWiPq4zB08KpxtAFtLDs++egx8kAFdoW
	 YzODnGcu96yO0GHTuaBNRqTEGY23ZbolLmzljFACp3goms4+mLmklR9SZOWUj4xhr9
	 HaMJOQVKNyn6NkpfjjkYWow1YNr+c/YpnqPW3kjIuXDiXSoCO/2qAhwgGVm8DSF7cw
	 TxLihz9kQ9mGbVxxe04Jauy/oaL/2Jw/efGyqjTQlc2/lx28Okvx+b7vcVzm5sUZyk
	 u6DKt9jN0ljxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B36380AAD0;
	Fri, 13 Jun 2025 18:05:01 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.16-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <6b7c1c97241248c0f3c35512f1150ffd.broonie@kernel.org>
References: <6b7c1c97241248c0f3c35512f1150ffd.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6b7c1c97241248c0f3c35512f1150ffd.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.16-rc1
X-PR-Tracked-Commit-Id: 9f0ad43b158d07bc7144d219ceabdea36e28e392
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 02adc1490e6d8681cc81057ed86d123d0240909b
Message-Id: <174983789978.834702.5471087257660089155.pr-tracker-bot@kernel.org>
Date: Fri, 13 Jun 2025 18:04:59 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Jun 2025 18:23:53 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/02adc1490e6d8681cc81057ed86d123d0240909b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

