Return-Path: <linux-spi+bounces-5110-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 531D2991935
	for <lists+linux-spi@lfdr.de>; Sat,  5 Oct 2024 20:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19EF6282F9B
	for <lists+linux-spi@lfdr.de>; Sat,  5 Oct 2024 18:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A56C157A59;
	Sat,  5 Oct 2024 18:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEGtZx/j"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63FA156C71;
	Sat,  5 Oct 2024 18:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728151650; cv=none; b=RRbdwF7247MSUrd4oFvENJq7A9CjAAW0XSOdluZw5z2UWgVWVKpp10B5jVCLcbfOiW7IaIkkwn3SHfuNC2YqgRJ6LNW2NiYZnbISBA1eKrHgKs7ehrnPHkI+W9IQi/vSKz0ayfo57sWe0d41gmBDdnpTuygvcaPhNhnEmxoqY4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728151650; c=relaxed/simple;
	bh=+QdQxhtw8UHU+jIuufrQ1qr3stMFCxbsjeCCh5n6iJg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JuxmmWGhot7REF6FQ7l/bXOPiGSdZJXeJl55ERt9clo54LM+6YqTCAjZVvWWPyv8WQt6sWfOrng09yEM6WAjYdY1essY90NkD0FEMV0Rh4q2F5kmzZ5IWZ4xKAqc1CO26h+ZR1tnoVPw9ZQYwfPi0TXtANQMJw0Q7wpK+96XOEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEGtZx/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EA0C4CEC2;
	Sat,  5 Oct 2024 18:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728151650;
	bh=+QdQxhtw8UHU+jIuufrQ1qr3stMFCxbsjeCCh5n6iJg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oEGtZx/j7YOpHZ2dQDrggPRaErZmnHWECF0W8SrAwN/JQugVsZETfSiXNtOgzisuC
	 Xo+bj8GhXVFTTbH1U4IT1ddryfpIwm8twqbdNAYcPKwL3JE8rcP0w6SijwPGe6Odem
	 2PSfQU7yAYD5aIrNfpNnIg0kGKimop/xCJGuYQvTrARwDI0y3pPzVXDdYihaocEXhy
	 rJYC0zafwWh2++G91OsgbjcCk5IzqLhToO5MTp3a/6s2TLpKhavQQB8uXhTKWcIFvk
	 9uonjTHBoqK6Iz2uTMyGNJ295AVNlnOHTnaHxkp4F2KW7Bk8La+C0uyVKnAhgby/yr
	 0gf6Q3+8Oisiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFF43806656;
	Sat,  5 Oct 2024 18:07:35 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <bb073282a3cbc0a5349db87260957934.broonie@kernel.org>
References: <bb073282a3cbc0a5349db87260957934.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <bb073282a3cbc0a5349db87260957934.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.12-rc1
X-PR-Tracked-Commit-Id: 65fbec3121eb7a10a839784496357f5a833af69b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 60b9f47eb3b01f829a94f7fea81bc8d59ff93dc2
Message-Id: <172815165420.3145223.17580166253904272399.pr-tracker-bot@kernel.org>
Date: Sat, 05 Oct 2024 18:07:34 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 04 Oct 2024 22:58:22 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/60b9f47eb3b01f829a94f7fea81bc8d59ff93dc2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

