Return-Path: <linux-spi+bounces-327-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EDB817AEC
	for <lists+linux-spi@lfdr.de>; Mon, 18 Dec 2023 20:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53E86285535
	for <lists+linux-spi@lfdr.de>; Mon, 18 Dec 2023 19:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FC67348A;
	Mon, 18 Dec 2023 19:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqo3YXsG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A00473486;
	Mon, 18 Dec 2023 19:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FF5CC433C8;
	Mon, 18 Dec 2023 19:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702927484;
	bh=aMS/vqsu8u0nN4l6VZZnYVN2sGRi9+0nRvDdUU5btPQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mqo3YXsGe5sIa5y6JDoWwdivQV/nZHt8EsOOSI/cTc11GrVA/L9LhHJpreLEsHJpL
	 4k93VoicoidN0V+zeMyQY7T4yhiKTXLGEyvTuD1a1WAqMzaqAaDgWmyFLMPRzFP7up
	 lNdAh9Zr8y1F4gjyqTm5WWNCHhtyq4XVqJ/bvIirUGRXZ98+yrUY84IZ4iIWMDa/HH
	 oE/BE06Sb5tfR0TVItSQyLgC4jsb+cbevP1Yw+WfPvGBF0737pM40tignbGoO+ahf2
	 HFjV4wkN4ojYpucIwZlOTeana2shAG4N48X+45278cSQ9V6p/8ZS6/JOZxxnyw+zBm
	 FdLi4cPsAXuzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43154D8C98B;
	Mon, 18 Dec 2023 19:24:44 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.7-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231218174050.A8487C433C7@smtp.kernel.org>
References: <20231218174050.A8487C433C7@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231218174050.A8487C433C7@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.7-rc7
X-PR-Tracked-Commit-Id: fc70d643a2f6678cbe0f5c86433c1aeb4d613fcc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26d6084791bb2cce41b83cb09b4cfdd9fa0c28f1
Message-Id: <170292748426.30314.2769806681276627153.pr-tracker-bot@kernel.org>
Date: Mon, 18 Dec 2023 19:24:44 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Dec 2023 17:40:47 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.7-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26d6084791bb2cce41b83cb09b4cfdd9fa0c28f1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

