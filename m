Return-Path: <linux-spi+bounces-8179-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FD7ABA0F3
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 18:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A601C0133B
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 16:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC4F1DF742;
	Fri, 16 May 2025 16:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyY4NHcZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267B91DD877;
	Fri, 16 May 2025 16:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747413834; cv=none; b=rZS98+N+LXG2JO1Wn0qSbzIVhu3fXZNlKNKpmIrJFU7gO7PGq9/qCTst5EN59qFkcmnKcU85DahL3f0DErsz1ew1WoQG6X0ku5ARSLaCz48e5gjiVCSsfFSvSnoopJA381H5QiJxwA2h1kDFxitU/oIGT+H5+eQx7Zu6ifJDYnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747413834; c=relaxed/simple;
	bh=3gYv3lKYq3F49Q8Gc2RmFV3892PuaJ6k22DerWIaYBM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JdeBp7DrlrkV2htavFrKu7Sjk2hjPYagi5DenRcbRRaF+kqCjcTKscSoVr8rmCUvIlzBXpNUBpTi0e4DpYo4qo61eaPHoTHulwjNzdZKKaRE9Ko7rAX14AS32xvzj8rzj0ebAEnzwGfSPO8YFot5+hNrFQezmZncj8dmohwN0f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyY4NHcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A040BC4CEE4;
	Fri, 16 May 2025 16:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747413833;
	bh=3gYv3lKYq3F49Q8Gc2RmFV3892PuaJ6k22DerWIaYBM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jyY4NHcZyAC5cpSHZILKD41lmKWimEoK9rsNIaudiNr04CbZwl+lEHhitVCfWL/2a
	 OyWbyLPK7hauIlWa7Cl6TgAxJQadOgkuryADsbMbZ4f81RTQUdsvLhzPSGpa6DM9X9
	 UjbhFQTeoia2sTUSsqoa1OdVgsRkFa1u6GLB9C33E+2ll5QsAqUizgsQQ72KDJM5Uh
	 Vsn9I2NwDsJM3Y6mQ+f78QzszSwbh8vKfnT25cPHL7URn19wvJCok+sNqUywJ/TJ+w
	 InoPPIhLyaNQ6WW/aTtAOtfisFKpcLGdO9P0HrHlf9huI2lsb049PdN0f2LAt1gWBd
	 0WVqbvE79gvRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD603806659;
	Fri, 16 May 2025 16:44:31 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.15-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <8c0c7f276b6ea8988bd8b824603cbe99.broonie@kernel.org>
References: <8c0c7f276b6ea8988bd8b824603cbe99.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <8c0c7f276b6ea8988bd8b824603cbe99.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.15-rc6
X-PR-Tracked-Commit-Id: fb98bd0a13de2c9d96cb5c00c81b5ca118ac9d71
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bd8bb9f38a88f6987a4d6f561f71dd46bb91171c
Message-Id: <174741387036.3992786.1993160880642216800.pr-tracker-bot@kernel.org>
Date: Fri, 16 May 2025 16:44:30 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 May 2025 13:31:40 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.15-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bd8bb9f38a88f6987a4d6f561f71dd46bb91171c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

