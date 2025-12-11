Return-Path: <linux-spi+bounces-11858-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6F8CB4614
	for <lists+linux-spi@lfdr.de>; Thu, 11 Dec 2025 02:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1DA53001C09
	for <lists+linux-spi@lfdr.de>; Thu, 11 Dec 2025 01:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4FE1B424F;
	Thu, 11 Dec 2025 01:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZV62EwF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A84C126F0A;
	Thu, 11 Dec 2025 01:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765414916; cv=none; b=Y3SNQ7US370ScvXPenBDUMfdsmzcahB+4mooCaaW04SLu1ckvKqw5Nmocp78D7XOqHCtqPQEdG7ws84o9uQvYAB2MX1QlfPTdvodz4iWOFqFxwp5N+PzKFrVBtOLFG4wVCGbxwbhNLPPkfWhutm5sNPQQq2dIPtSVytZMh/1XHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765414916; c=relaxed/simple;
	bh=XPK//q/L2+t2eErRiqYrnm+0XVML5Ay8KSVdBkLTh2o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LmyeSbrMNx3q+IZz+QmrbT6RWGLL1lwGkOHhPzIXaNXu/K4WCuugBvayigD12LOrFHQFjGLamtkxU+9kZmsUzLi5Sc3oH9AaYlRRYu0BCV6rsrhBjpN/8UfShkEg0JHt38ldOxl1U5DvEKjqlNbWuuBIBmF0T7YvGb9he3JIvr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZV62EwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CABC4CEF1;
	Thu, 11 Dec 2025 01:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765414916;
	bh=XPK//q/L2+t2eErRiqYrnm+0XVML5Ay8KSVdBkLTh2o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BZV62EwFgbHqzTMt3djRXNhQMs5QsUnu9+1TmP3hDB+w5aUgjQ9XxWJia1hkjcQc4
	 F/NG9ZdxuuBUh6TJ0lBr2x408Cijybhr0iaPYIv2TCFRWICXKsEBu2wfgtGa2pdsgc
	 RTPQAAzz0JhDBzktLE3tBUEmY+T9jErk1+SJPFjia8HG4OzDzdFxWaHf19pFAW5hjo
	 iRSzSTJDIvjzmFHO+H9mzxjJU7HhxmutIUWAU8ZgyqdPUGUplDZNClKS43hg2/x2Qi
	 D7irmKSDmV+Y9bECgfujPyeCFREIK/ARFaSzS9/0aKGXLGIehiaJiXZjjv/zqxPWOL
	 kHvi7Wdek70Bw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 786AD3809A23;
	Thu, 11 Dec 2025 00:58:51 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.19-merge-window
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251211004915.47AD71ACB974@finisterre.sirena.org.uk>
References: <20251211004915.47AD71ACB974@finisterre.sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251211004915.47AD71ACB974@finisterre.sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.19-merge-window
X-PR-Tracked-Commit-Id: 8cef9b451dc6fdf86b92c7a35d55a47465d500db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c8081cc599fcafa25371d50959c17e154f9fd08
Message-Id: <176541473018.788014.6330508590707562232.pr-tracker-bot@kernel.org>
Date: Thu, 11 Dec 2025 00:58:50 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Dec 2025 09:49:09 +0900:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.19-merge-window

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c8081cc599fcafa25371d50959c17e154f9fd08

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

