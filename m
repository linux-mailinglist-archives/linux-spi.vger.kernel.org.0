Return-Path: <linux-spi+bounces-5653-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AA99C120F
	for <lists+linux-spi@lfdr.de>; Thu,  7 Nov 2024 23:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8F9A1C21CCF
	for <lists+linux-spi@lfdr.de>; Thu,  7 Nov 2024 22:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E66218929;
	Thu,  7 Nov 2024 22:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZFLev0a"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6838D1DC04A;
	Thu,  7 Nov 2024 22:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731020250; cv=none; b=RLuzvn6Wy/Aht0VVSiJYSo7freskc1XjQPg6XIiXpLV6LlO3pxSuCUbBjt5cZtQhK3+8BlcUrbHONWU/fOjkvXYUWVkyfZQjZ51Okriz5+CY6R0FOrb9DE0oLa/PeXU7FKpDp3SzlmnukpeVK80yvq5gkYwAPkFH+P7xQ5DzAUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731020250; c=relaxed/simple;
	bh=/PM+TM+9jsK0BHN3D4wY8juzrcTDOePqlyF1dIfs0ws=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Gk/haYyrFKwAtf70imuhg6knPZDTK5D3v00JQF/gRs7RAe+jP25GoYAOeyiAuJ2+marv6jqDJ8tuU1xTFcr/SBWlaG/KIsllmbyEAHhUauWK9CEFyZXjhbBei4vg+36NelGjoTzku7krsuCcYdKy7MGZECmQKC1cHh5TGx0OD4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZFLev0a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48662C4CECC;
	Thu,  7 Nov 2024 22:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731020250;
	bh=/PM+TM+9jsK0BHN3D4wY8juzrcTDOePqlyF1dIfs0ws=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eZFLev0apxjwyPoyAavRm2BrAYaWydV3mAi7wnfbIFRSHvCgdyWMWjD5tBem/nRUW
	 naUI7hcI94F4GyTCtjZXFsL62fpt2P5zWlm+37nxZXEHEVtwmH9YBOzYmKt3kZNHF0
	 sIwtGJKWNv9U+JrXHcLfGBCwwCKzWyZbhwrogJ1YS4hx9kydtWC/PqHqRQZWY1/6OH
	 D9+VK1rxrAvD2A9mj5jA1xxrDkJoKyhRpyojsu3M4ZweCoNBi4iSUHXeFjGIsaogCM
	 +JkMVLX4OYUNvdP8T4fJ9Z3M6xsBiNdoVFobDbLFbSxKTZVl0MK1xYu553FrwpKkhD
	 /uxYWLaFofxGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AFBE43809A80;
	Thu,  7 Nov 2024 22:57:40 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.12-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <b4e4042a741922cda75f4ee1b55234f9.broonie@kernel.org>
References: <b4e4042a741922cda75f4ee1b55234f9.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <b4e4042a741922cda75f4ee1b55234f9.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.12-rc6
X-PR-Tracked-Commit-Id: ebdcba2126a817da4efc085c9d4dce0c51942eba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 906bd684e4b1e517dd424a354744c5b0aebef8af
Message-Id: <173102025923.2124702.13180423378133269758.pr-tracker-bot@kernel.org>
Date: Thu, 07 Nov 2024 22:57:39 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 07 Nov 2024 22:21:57 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.12-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/906bd684e4b1e517dd424a354744c5b0aebef8af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

