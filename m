Return-Path: <linux-spi+bounces-6813-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DFBA3507E
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2025 22:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D6F916D457
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2025 21:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8528269832;
	Thu, 13 Feb 2025 21:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qvpj7icB"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA8026982D;
	Thu, 13 Feb 2025 21:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739482201; cv=none; b=DmbVjPhyjxB+gYjdsWfNBUQQGbDMTKEeWDLPageNwrIEb4XCmExlmF6DaMKgpRIAcA1UAjwNjqbyLfd8OcQX5l219mr+ADkEvychfW+GSCOTar1oEijgYLhStM0uHUjEW3Z7ajOQdGNI9NUgqEpxM6E/qAzq7wyb0VCyCg5GJ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739482201; c=relaxed/simple;
	bh=fIue4ylapBJV5v99yA2lNverKPqn70NncYrXnmwLTpo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LrnHDM2QbSDzBV21yMGzs9DuuKMBcdiK0QX4j3sJtyZPmemY5SA8FC5hE+Gkgb6YcHEtwIlysNKUQxNCOa1nHTa9K2HXGzgB2GTW4zFI3vPX8lEvyMe4WYyxgoqwwvaR1qzUO5cdwqmWLSOFaq1A0qgDSo5ZDLmvsNEcrt3loyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qvpj7icB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFC2C4CEE2;
	Thu, 13 Feb 2025 21:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739482201;
	bh=fIue4ylapBJV5v99yA2lNverKPqn70NncYrXnmwLTpo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Qvpj7icBy5IeFgqOxKQn4Az+9mNA/PTqfUE/fYeZcNDtg122qCh2aAWU4dYjbms63
	 9KJYCRzQ5E/Hb/DBE/0jpXRCwZjAgCftP2IqDColt3oLQm7HIrxUmVsV/JG29eppVD
	 eRcmaTaK34XxYpLR+TwDWSarQDVQowDah5R9lhBk9+DKvm2j4hT+ifVWoe5L3Kguch
	 6ylLsBb0zLjvACy9q25fRCypMBR1zgUkO3K9yyzIy3SVp/gDdMIXpasvo4OcyVzI1H
	 QWttUMUjQTgviR6+1GbnM4h5XtBIc+LL1MlMll3XnUWhNKR+21NMge4gmhubZcUFvL
	 NoMOLWtBxRaXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB230380CEF1;
	Thu, 13 Feb 2025 21:30:31 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.14-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <2b29351684e99c02491f86ee5cce20a6.broonie@kernel.org>
References: <2b29351684e99c02491f86ee5cce20a6.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2b29351684e99c02491f86ee5cce20a6.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.14-rc2
X-PR-Tracked-Commit-Id: 3588b1c0fde2f58d166e3f94a5a58d64b893526c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 68763b29e0a6441f57f9ee652bbf8e7bc59183e5
Message-Id: <173948223065.1382339.5249143432596481944.pr-tracker-bot@kernel.org>
Date: Thu, 13 Feb 2025 21:30:30 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 13 Feb 2025 19:00:31 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.14-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/68763b29e0a6441f57f9ee652bbf8e7bc59183e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

