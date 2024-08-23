Return-Path: <linux-spi+bounces-4294-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5183A95D9D0
	for <lists+linux-spi@lfdr.de>; Sat, 24 Aug 2024 01:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FAC02836BB
	for <lists+linux-spi@lfdr.de>; Fri, 23 Aug 2024 23:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F851CC882;
	Fri, 23 Aug 2024 23:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7XDkI5W"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911B71C8FBD;
	Fri, 23 Aug 2024 23:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724456724; cv=none; b=PGdCh0Gusmd/6kHPjp3BII/d400uzfbr7rGCW/XQTByHRWoxmzuew4qK25xH4AD1cp7d8Q7WYmjbkJBELmVhS39+RoSySF1Br6EV4HETAAsEmIbTIFpa5HuyNKyBIDHrbPpoPmXyM6CvZm/cR5iVC8Hb/3Ab0A7dn6lQTWfc3Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724456724; c=relaxed/simple;
	bh=5WrSXJ5i5b9voAEUBo78GduRrDZFVRk6pWKWrxteFlk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TYWxKXThgUoW60XXo6tJGNUoh6V8gOK/58eRkTB9MBsBKBXzwlnizNloxN87oShyFWSB9uNFbivuff8cpvz2knDf04X3pKwMRxOgZgHTkv9Ymw3Q9XasvmKeYXDSJzaSnaYOh0wB9AsineB3h0tNqfeDo47euQx6mx51oLKiSDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7XDkI5W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3430DC32786;
	Fri, 23 Aug 2024 23:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724456724;
	bh=5WrSXJ5i5b9voAEUBo78GduRrDZFVRk6pWKWrxteFlk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=W7XDkI5WvQieBPjVw7skXtnLCLikaDfB1IE5OSgH5YTMVXRLRq+CJz9FM4SCqTb2b
	 kYQl4pqklx6IrWHuEyCELoOzLSqLpjnsmBz1rs+nRsRGtLHo3oiJ5hg2qj/9V2o0KE
	 ISZw+bVnEaP52z39jpdUo7gUod+wvfehP/T7S0a/3dDLle4mhXmBvg42+f2IohGyuV
	 7j19qh0vQWRNk/9qQVO0oH+pYgTIO+FJAJq0YtFk6MC4dxJ4XN1XaOYXT7uiNXQPkV
	 KwiRbCgFemoWmmDK5iTFgSP9ajtk6OfuzPvDQwlJYq0kporL6zN/HS6JjswFJijXY8
	 /Pf05lI/yDFLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E293804C87;
	Fri, 23 Aug 2024 23:45:25 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.11-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <b0ca6a6ee44947633df125a567524286.broonie@kernel.org>
References: <b0ca6a6ee44947633df125a567524286.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <b0ca6a6ee44947633df125a567524286.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.11-rc3
X-PR-Tracked-Commit-Id: e17465f78eb92ebb4be17e35d6c0584406f643a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c2a905a6d6faa34991c993a321a01e8454934622
Message-Id: <172445672372.3112782.1750752725932721829.pr-tracker-bot@kernel.org>
Date: Fri, 23 Aug 2024 23:45:23 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 Aug 2024 11:13:46 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.11-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c2a905a6d6faa34991c993a321a01e8454934622

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

