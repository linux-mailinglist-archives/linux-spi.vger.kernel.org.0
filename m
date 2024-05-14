Return-Path: <linux-spi+bounces-2853-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB5A8C5CFE
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2024 23:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04CA3280EF5
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2024 21:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2099D181CEB;
	Tue, 14 May 2024 21:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSB3y0TF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB53F181CE4;
	Tue, 14 May 2024 21:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715723088; cv=none; b=K2iUpRbQDq/P6d0ShcfGUAkjAAJdOOck0IZhIrtO1fGJChj722d2sWu55T875E9MOGMEaAVANiFemWUlnnf90GKaDPlSWV/GsL5DqmNb+Yv42HnlU3DOiFhAUNwvkFjXe9fCiYvLXjnVMrkrTBHpt0VqqTYjhaoQOr6JqjUTGG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715723088; c=relaxed/simple;
	bh=YOlc/DsKtz7RwpgN+N4oWeUegv5CDoz/T83fdg6LlPk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GEZbRvkeNNRfjrgDf2Dox161QTnyJmg7WqXCiedKw7NS8cW3TCy1XybsUHmi615+pEy6Ja6bQuqqoEk2/IRlk7F3z5j2OKMDKmsxNI644yRenzTnpEyAc1U9gckUe1RUlbh2pzuE4pvmYUmcubv+bce23O3Jv6pxSLZJ9pov+A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSB3y0TF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5F1AC4AF09;
	Tue, 14 May 2024 21:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715723087;
	bh=YOlc/DsKtz7RwpgN+N4oWeUegv5CDoz/T83fdg6LlPk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XSB3y0TFehqGNDHSDSGROZiHSBcckKeTcKs7urF0ASNCJMWP2w4R04ZFaW5avwLpG
	 8abGvOW1jsG/Orc42Al924QhZtOHLGGqDV/WIS5JCOe5pq6TXv7ZjHnl5CdJbpHTJR
	 Zn51J9//uPbORWrJpkz454TmL7IGrWEvQrB9Na6886ya8XqzjYAhJIyYa2/5Mnyufs
	 Uso0vbVS4YlhxPHDOZ66wqOdNHbcQPvKbZoY87/gCs8IlinobeZZYhoftiF04jd7cs
	 XCAdQxTyUE8zPoGvVxeRtOwAqog/OmdQF9WKMt3fztt5GQZ3iA2jvqETUkleTYunp6
	 immsvgnzkRzCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C03E0C433A2;
	Tue, 14 May 2024 21:44:47 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <9e996db977142fec01e9cbbbfb79c07d.broonie@kernel.org>
References: <9e996db977142fec01e9cbbbfb79c07d.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <9e996db977142fec01e9cbbbfb79c07d.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.10
X-PR-Tracked-Commit-Id: d6e7ffd4820f8894eb865890c96852085d3640e1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2b4a5bf32ffd0f5964e9949a82232fe5363b123
Message-Id: <171572308778.14334.6915391357636087444.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 21:44:47 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 10:39:18 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2b4a5bf32ffd0f5964e9949a82232fe5363b123

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

