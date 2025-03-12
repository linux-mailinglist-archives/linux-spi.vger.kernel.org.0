Return-Path: <linux-spi+bounces-7101-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 314BBA5E702
	for <lists+linux-spi@lfdr.de>; Wed, 12 Mar 2025 23:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1F1B3BB24F
	for <lists+linux-spi@lfdr.de>; Wed, 12 Mar 2025 22:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA081EC012;
	Wed, 12 Mar 2025 22:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmGwbVmg"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C330B1D5CD4;
	Wed, 12 Mar 2025 22:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741817372; cv=none; b=CEOScJmIo5EvrqjPYf+Lzs68g2Q8mFC732iP2XTNjc+lA6+fD0hLuLMAXkuAb156TjgkMPUVhOHWoyA/mUJEKJ4eWdwTREEAwnMe/qM5CPxq99IIbiqJ3K0D9UNkq5KOA5zrKWmu0wjvzaQ/1gOp6EIJaqyXiiRL5xGUTujR9Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741817372; c=relaxed/simple;
	bh=1RxSFH7LP0l1ozoJutBm6MFdFp3GINBmjeiwpGEZAdk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JrvUDctlN0O0PUpZVtNdxzcY7ZgW/wiNSGaBV3HsEWPdbLr1qVJWtrmp3pIkXXEj1KwVCULXaJ6mpW6D2nviNBjHSwTy8tsvL/g7IqJuMTKPkwIt7nzladNUsi18TFNyWSD44qGuQ8ShZ/spSmDR+4NH2GYgsBtsIqP345ZYBJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmGwbVmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463D1C4CEDD;
	Wed, 12 Mar 2025 22:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741817372;
	bh=1RxSFH7LP0l1ozoJutBm6MFdFp3GINBmjeiwpGEZAdk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cmGwbVmgq3Kp7Nz/FH6d37SbQUrD2XkxQEiC2QBL8xsOqJMwmz8eeGQ2sU6kHMryI
	 ZOgtfJYhZY9KtWkoR6U9dAdcO0wgNOhiOlb7RTdkojNRnDeYpqhDe+PHjKQd2fq9l7
	 oN5L97U063aanq7acmujPw4vQcedd57e8rv1EWq7Qr3ptOIw0cwR0YqOV6RLBjP+HE
	 lcY4MH+V20aUgsX/7Wv0QV+JG+e9EleStZRtW2VorJ7scCMpfFwJcnyywPDjxEionJ
	 idgZAbNX+JEJ+57gad9P5s6ICyLKDUUKrinDLegMCYloWz3dHmbw93lA2HAPcTp7O5
	 SAEHtFeDvwZbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB810380DBDF;
	Wed, 12 Mar 2025 22:10:07 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.14-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <a5d6a54f85162906b7ee1e0e9659e8f9.broonie@kernel.org>
References: <a5d6a54f85162906b7ee1e0e9659e8f9.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <a5d6a54f85162906b7ee1e0e9659e8f9.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.14-rc6
X-PR-Tracked-Commit-Id: 91cf42c63f2d8a9c1bcdfe923218e079b32e1a69
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e8e2f82bc26d4b4ac9bc4f3abe99a5661a04009
Message-Id: <174181740645.948527.3426782416508957296.pr-tracker-bot@kernel.org>
Date: Wed, 12 Mar 2025 22:10:06 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 12 Mar 2025 14:08:33 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.14-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e8e2f82bc26d4b4ac9bc4f3abe99a5661a04009

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

