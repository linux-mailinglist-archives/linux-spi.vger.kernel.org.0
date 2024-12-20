Return-Path: <linux-spi+bounces-6131-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 730679F9A51
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2024 20:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D555516B68A
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2024 19:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0076227585;
	Fri, 20 Dec 2024 19:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRt9ZhSN"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842A8227582;
	Fri, 20 Dec 2024 19:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734722387; cv=none; b=YtqyuBa/8Ocyjy2HUzu8dzIwIQqvlH6hbnvacbhgU2MTAqHASpKrIKC2QP/SCu7Hqw/tFByJjjyP/GooyI9f89MkP74xmsaX1cxnLSstaNtrp+PJ9z4dozIwxU7xlNv341EkceytukYs7K7rwChvkvP4H+/7kg2QCa7/WfChCJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734722387; c=relaxed/simple;
	bh=sghdaWnXEa2f/wBRKpVZV8FNoEKRoPaTQGBTlYH7atY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=L/UPQ5Eve25xnCw8tlPmnrMJNS/S7OdwnCpUDxZnMsRvxjfcp+bsktqqWCCwNkEsdGNb6WLu200VyVA9cvVFRNS7OwdXQLQPWqx1HO9CYNI634ebbisCD3mVBdBl53MzLxdOcHTcN9vC6V0nDhb18W3zFImrke/J0hV+8ecnRM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRt9ZhSN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D10C4CECD;
	Fri, 20 Dec 2024 19:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734722386;
	bh=sghdaWnXEa2f/wBRKpVZV8FNoEKRoPaTQGBTlYH7atY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KRt9ZhSNscDba4qaLG9Mu7n2wPPcXIkTw6e6Dy2fJzDr0kgMU/BPLTDdZSxty0AkE
	 OMULJPTK9/a3IYlDxQzbNQVabzsu0mQjkLyvJ301hxwbl558jiuIrJh142fuA2Q/fg
	 SODnHR3yY54UzkUDj3B/0dGIL+4u/xpePQtI8Oh202LO824I1hbfRpOxiydJgXrfFS
	 1FISJiMeIo+Tqhsu/Yazk9j55XHBiNwWsBseXzMtS+BUWr/SqpeeSlBz6yn55SWQGo
	 Td5SdCXAZi8QvvYAMRGEcZmmnE4NTuCv08i2DLG6HQfOA66vRbtANS0KjoohDBwhCU
	 BB8EtmHVBMBrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0323806656;
	Fri, 20 Dec 2024 19:20:05 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.13-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <aa309cfa0ae84b6e6495dfb1ac91b953.broonie@kernel.org>
References: <aa309cfa0ae84b6e6495dfb1ac91b953.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aa309cfa0ae84b6e6495dfb1ac91b953.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.13-rc3
X-PR-Tracked-Commit-Id: 7f9a1eed1ad8b274ed9163a02cef891a90427237
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5127e1495b04c4516f3d9ab5bd6f241873793245
Message-Id: <173472240434.2997869.2728393096778707569.pr-tracker-bot@kernel.org>
Date: Fri, 20 Dec 2024 19:20:04 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 20 Dec 2024 12:51:11 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.13-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5127e1495b04c4516f3d9ab5bd6f241873793245

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

