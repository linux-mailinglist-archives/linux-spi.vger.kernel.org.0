Return-Path: <linux-spi+bounces-8680-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1F2AE1081
	for <lists+linux-spi@lfdr.de>; Fri, 20 Jun 2025 02:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F10E1896DB4
	for <lists+linux-spi@lfdr.de>; Fri, 20 Jun 2025 00:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129D43987D;
	Fri, 20 Jun 2025 00:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvWx2y0v"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB68935962;
	Fri, 20 Jun 2025 00:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750380776; cv=none; b=YVqi6tLdSv05o0n6s8+Zpo+ftDhIfMFrIgXBeccDmgSXI4pyFZua4yhtyLo4hqd6B6T6L8aR4PNuctpUaq4RO/c0vypEAJNvQxhT2+zSsK3VyMLLQEsVGcwNA7OT4JcK2grgiZHPB1WY+7zLtPwkW3L+HPT3gISev7n6saQzecM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750380776; c=relaxed/simple;
	bh=Xi79dSXbV7o3iJUaRu6Pn0ljP6CDPkYGcuQk5hW6Gns=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ko9vIwskO3JxbkJ8913GSRWI5g8pfmkrSw6SA5pFNc9EKTBeQQ0RgD0Ps1W5k/y2otHphxIs2GcgTUagSlcbQ7X50PWhHhZtUitSErfbNbCIJZVYn+qssuVvIdHAZihxt8XtP45u8xQudeOKu4tXvSol6OpzNjdcpTpc3nn+0c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvWx2y0v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC160C4CEEA;
	Fri, 20 Jun 2025 00:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750380775;
	bh=Xi79dSXbV7o3iJUaRu6Pn0ljP6CDPkYGcuQk5hW6Gns=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qvWx2y0vitigzlf6+ZBKTlDAhmAcr8ANdjS5mVHs/sDLbrT04O3CFP44WAAmDocjK
	 MBgL8P11wRZd3VGjiwtXxJury/OEsCEpFlFLpoObnXorHtJ2D/ujOWouFfvrAV6qFP
	 eEDekp+A5wd1RNyttysDBI+NQ3m7mFCvRV7oh2p4H3Nd6ZU4bA110eAM7e17G6dtJ3
	 pyWtl+f1+SPOvC07sI24gJPk3LJqNucx/5K8DRjUYv3/NkZS102UxcyT/XSsUogHkP
	 OtmTdeDCg10e1TP1ivitoZZn1uw0f7stYoP5Skk4uW/yW3kSCyy6UIBSVD2N0c9Wrq
	 ChsaflNB+lmJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB11638111DD;
	Fri, 20 Jun 2025 00:53:24 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.16-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <2028a8ec593d05f1a11300d8bfb000f8.broonie@kernel.org>
References: <2028a8ec593d05f1a11300d8bfb000f8.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <2028a8ec593d05f1a11300d8bfb000f8.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.16-rc2
X-PR-Tracked-Commit-Id: d57e92dd660014ccac884eda616cafc7b04601e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 41687a5c6f8b07ad0850d6c46452376d54fe9b65
Message-Id: <175038080366.1034889.9626370080787113018.pr-tracker-bot@kernel.org>
Date: Fri, 20 Jun 2025 00:53:23 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 20 Jun 2025 00:37:33 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.16-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/41687a5c6f8b07ad0850d6c46452376d54fe9b65

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

