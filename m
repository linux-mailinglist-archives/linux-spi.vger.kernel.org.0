Return-Path: <linux-spi+bounces-6055-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 805169F1BED
	for <lists+linux-spi@lfdr.de>; Sat, 14 Dec 2024 02:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB221188E66A
	for <lists+linux-spi@lfdr.de>; Sat, 14 Dec 2024 01:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EC518622;
	Sat, 14 Dec 2024 01:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Upc0acJ1"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867FE38F82;
	Sat, 14 Dec 2024 01:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734140132; cv=none; b=NgLCUYjkLMdP05JJPp9SAonrJxtThVgbYC8lNP0puDTJdy60VGms5Ava2WXBAkfMMITjjFXp+//w4PAQNnUsu+4RGhZmzjFvHQFSDCQ/9bO/KS48sQ9YiXKmv7ZV2iUeP1eASvhjGgftoA6paePqZBJ9c7iKLNgWlpjiFi2ZqKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734140132; c=relaxed/simple;
	bh=L1Snu1CLsrgEQZasr6nXP4ccEHPAM0I7nccMCV/I6hY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HV+XxCl6Wcx/oelYRBpALaS1Ry2EXVk4X1M3nXzeT3vl9zww9SHFLU+RQ4n5WvdP767Vb8IQIWgzRU8rgSn6LjXT+nfTeisZ8G/tKt6gJWEKRA58uFMHEKrUsC0NwJE17z+ckgb9iW3n/urR8ZxCFat9RHzvLHnHnCZCQ/IfSmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Upc0acJ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69CEFC4AF09;
	Sat, 14 Dec 2024 01:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734140132;
	bh=L1Snu1CLsrgEQZasr6nXP4ccEHPAM0I7nccMCV/I6hY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Upc0acJ1KpQ41+3KpciuzCqStg/vT3+5bd7uVGiXtGNum7dmu2eX00NQGb0JTnOpg
	 +5NpLdcvMHr1IV54gXtDWgaWEfHtOECajHy2sc/IbGSUL7G7F3pupUIUiR6La8LYIp
	 kE4wK6GfHfTxY65NO9awJsXe4hRlWHqK3rwOT1cLMelXIwUn6rmttCCTBPptBoKaHs
	 /x8/7OsnsCS4wsJzfHRb8AT16zXUh/N6XkWnK0nZzkNN0b6hqZ6jbhPD/YVraAWq/Z
	 OEWDFSd8ybhDVrfoH90d0tjeXJeJTXdX41NNykbwC1E7nSNuaNkIo3hd7+Pwc0fT3V
	 WL6xxA/hDr3/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BB8380A959;
	Sat, 14 Dec 2024 01:35:50 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.13-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <18812498d4f4eb6d0565c8e97f428d8e.broonie@kernel.org>
References: <18812498d4f4eb6d0565c8e97f428d8e.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <18812498d4f4eb6d0565c8e97f428d8e.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.13-rc2
X-PR-Tracked-Commit-Id: 25fb0e77b90e290a1ca30900d54c6a495eea65e2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f86135613a2552b1e6c0875726f45b34b0ddd5a6
Message-Id: <173414014893.3218065.11674056341849557761.pr-tracker-bot@kernel.org>
Date: Sat, 14 Dec 2024 01:35:48 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 14 Dec 2024 00:48:02 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.13-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f86135613a2552b1e6c0875726f45b34b0ddd5a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

