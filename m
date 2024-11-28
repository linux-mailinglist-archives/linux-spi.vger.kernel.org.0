Return-Path: <linux-spi+bounces-5867-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E389DBC6A
	for <lists+linux-spi@lfdr.de>; Thu, 28 Nov 2024 20:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18293164767
	for <lists+linux-spi@lfdr.de>; Thu, 28 Nov 2024 19:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43249142E9F;
	Thu, 28 Nov 2024 19:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQ3rCf5e"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4203FD4;
	Thu, 28 Nov 2024 19:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732821558; cv=none; b=u0Opmwo7RWPm14LRcaOS7PSwFx715k4dX61iAa4qjFk3JmF4CrWl5kkAJlxALERwLvj4UYrozaRXG8Hi7F6gqKhXESEQGj0ZqHjhrYsNcckzKAsiqf6+xNgfrnUJ8gktq6xqnlKlipXinnG5A/+rOEeFyqJY7aI7NRFIbVN129M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732821558; c=relaxed/simple;
	bh=Qax443U5ewae6beiHOcR9zaFTIG7DuRKxd9EDSR7Jeo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AAvcYxKssVX2iHfru44urv5Mwp5th6Q+DIyuJba7b8IiuiBWKXa4R2U/bZph7V37LAloSBUIkakskphOvFPj7p06AAbX/GgIq/6MnN1FicbJdKBMuB9xABtRLGdnR5ty0S/4AIUJS9bx5aQI/eQ4u0GsnOqshO9DzhOVh9OuhHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQ3rCf5e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA017C4CECE;
	Thu, 28 Nov 2024 19:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732821558;
	bh=Qax443U5ewae6beiHOcR9zaFTIG7DuRKxd9EDSR7Jeo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JQ3rCf5eykic2F4usJTFCNaabKW2w3gxS5jp9YyFF5V1/NsuHq1dEaaxkHtS7Q3Xx
	 huXlzPhmAePr3MTC30cfDX0I1JnWKlYh+/q8GxlXzKaKnzmje70UVfsZnsDXHlbNET
	 1nZnwZArfBYfz8TSLWNtyXjCbmfU5o8/Ix/5ZrzEB1I3J/XyFk07ppN+u7s5NaiGf1
	 P1ORzEKMb9KZ8AOuYXP7PvGa20fmYUOZS802+XLnOBPo8h81C9UOIgDnbpO6TMkJCN
	 g0AnoCY91IK+86UjSn6DyyhPzkDRoNIpUiVcSveT176GBQLpYiEOikdnoXxig2oqYH
	 ceuC39HmQmAcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EB7380A944;
	Thu, 28 Nov 2024 19:19:32 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.13-merge-window
From: pr-tracker-bot@kernel.org
In-Reply-To: <d3586482f22de4e1ccfca9139e4d30dd.broonie@kernel.org>
References: <d3586482f22de4e1ccfca9139e4d30dd.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <d3586482f22de4e1ccfca9139e4d30dd.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.13-merge-window
X-PR-Tracked-Commit-Id: d24cfee7f63d6b44d45a67c5662bd1cc48e8b3ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 86f419707c26e802287963f73c27bdaa4b21977e
Message-Id: <173282157093.1826869.7699556081584392119.pr-tracker-bot@kernel.org>
Date: Thu, 28 Nov 2024 19:19:30 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 28 Nov 2024 13:54:53 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.13-merge-window

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/86f419707c26e802287963f73c27bdaa4b21977e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

