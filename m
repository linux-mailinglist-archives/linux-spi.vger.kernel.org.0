Return-Path: <linux-spi+bounces-7284-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCE4A6C51A
	for <lists+linux-spi@lfdr.de>; Fri, 21 Mar 2025 22:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A0F57AA3DC
	for <lists+linux-spi@lfdr.de>; Fri, 21 Mar 2025 21:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24205231A5F;
	Fri, 21 Mar 2025 21:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdZELiqx"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E271EF08D;
	Fri, 21 Mar 2025 21:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742592386; cv=none; b=QZv+X3kOVTKVnPFh9SPmIPKRZjgDHdGG6TDEZKBAs81qtnv0pj7GZup5oO9lEjraUbTcFNnwKm2XXz1yp/NU+H5409Ux85aCcdOEJDAz74okwj0kKaN+ksgdP+DQqlVudWWKJ668lIem+EOGSzC5WBCkzztTuPn6u6qy2uwCh+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742592386; c=relaxed/simple;
	bh=QyJ/ruzc3o3bTATFbHX0o2OHrDLiJdc9CfELSIkf6Go=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Yg29xzd5LCYNnIFygKVi8mcXHVjA/U8ZiSIlhkuNtbb2RVmhe8GXmxxr2cweLnC1S2ZvoeyGo8BJg1ceuiEE0skish+Bl6hte327km9iBkn0w1VnezzoxK+NlOsBKAiTrpQm5G/5niMC+Aco9FMkseWSCHI9LqI11fcb9H/ZM5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdZELiqx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8F3C4CEE3;
	Fri, 21 Mar 2025 21:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742592385;
	bh=QyJ/ruzc3o3bTATFbHX0o2OHrDLiJdc9CfELSIkf6Go=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RdZELiqx19u7FDEwstcTPga8qOSAGncEuDqxHatiqyioQXpTN2Zw18HcdLp8Tf+Gs
	 KESpmbKYXbk8VgN+oEdJY33x49fQ2vcS20WFg7JthLKc37G3yl44tccUkyQHmLCTZk
	 rORQPezbgwqrKR5EM3ImonY9MQT4o1kKCwlv2WpiLrVNMT6JYRUeTufDTdjcF3JyYy
	 Mf3tRgyNxbK+H/5dIktWMXuF3F/AxJ0EiIblG9fV6OqpzmB3okFkf+rsO8LvrI4+ne
	 O1XCP+d5HCZNs5zrAyExI825676/UdUXw5lOO+sCyr03Q+Z50VpkCNPqRdMZBth7mU
	 sUGNo7iuURclQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD583806659;
	Fri, 21 Mar 2025 21:27:02 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.14-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <a63096e1e044f828a77f611d7ef76140.broonie@kernel.org>
References: <a63096e1e044f828a77f611d7ef76140.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <a63096e1e044f828a77f611d7ef76140.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.14-rc7
X-PR-Tracked-Commit-Id: 176fda56d72a267731f82aa4a3aeca430394f10e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 88d324e69ea9f3ae1c1905ea75d717c08bdb8e15
Message-Id: <174259242142.2631089.1984753684459844773.pr-tracker-bot@kernel.org>
Date: Fri, 21 Mar 2025 21:27:01 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 21 Mar 2025 14:39:10 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.14-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/88d324e69ea9f3ae1c1905ea75d717c08bdb8e15

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

