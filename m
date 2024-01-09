Return-Path: <linux-spi+bounces-385-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6497A8290EA
	for <lists+linux-spi@lfdr.de>; Wed, 10 Jan 2024 00:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2589B231A9
	for <lists+linux-spi@lfdr.de>; Tue,  9 Jan 2024 23:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A92249E1;
	Tue,  9 Jan 2024 23:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWo/0FhW"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6453E47A;
	Tue,  9 Jan 2024 23:41:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5E24C433F1;
	Tue,  9 Jan 2024 23:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704843711;
	bh=4VheRJB+SlRDKOp9co2lBsGDm9h8vd0f7gSgXN/H+GU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gWo/0FhWZ31EipxpPuaOEuzsngnQO/+/TYnm6HKr1yN3RrKyDNQD7cayNN5+xqhe4
	 jz+JcN3HReQZAZf5RT+hvCjnwNwk89+nbmUIDbSiYheDzyRr2Nh2XEy0XtT/eoM6i2
	 KfvR74LcM6la7QMWF+YJ5eb4u7xO9wY5K40lil2Twj/QAFCfX6wM6Z88vW8T7R6S8U
	 VulRdpRQzNyBjC49DuFA+ECK4yZFSH6PFrQtZPQWn2uLcME0nqR+Rn1QnYnsWNInKg
	 OvgK07WNmfUWBIeO8kNQcbRytoAoiuy1hmmpedATA9flt5TJ83t23GA7QJobYPlZYo
	 7+cgyplC12zfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0748C4167D;
	Tue,  9 Jan 2024 23:41:51 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240107223817.EDB59C433C7@smtp.kernel.org>
References: <20240107223817.EDB59C433C7@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240107223817.EDB59C433C7@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.8
X-PR-Tracked-Commit-Id: f6cd66231aa58599526584ff4df1bdde8d86eac8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 301940020a92ebdef9352a0573075a1db42d17aa
Message-Id: <170484371171.10226.15653369376230899816.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 23:41:51 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 07 Jan 2024 22:38:09 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/301940020a92ebdef9352a0573075a1db42d17aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

