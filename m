Return-Path: <linux-spi+bounces-10967-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCAFC2844C
	for <lists+linux-spi@lfdr.de>; Sat, 01 Nov 2025 18:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61F403B0903
	for <lists+linux-spi@lfdr.de>; Sat,  1 Nov 2025 17:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF3A2820DB;
	Sat,  1 Nov 2025 17:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNcr5jO2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5470A27B354;
	Sat,  1 Nov 2025 17:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762019587; cv=none; b=f6qjj+nG0Kh+m0ZMQRxoDjPOZR9HMwuj26iMZa9cs6VpRMI3UJrvMtWNcOleUQauBGfwEsA2Tj3ATFX8G3lvRPHuStQwkknCdtLN2HP86mVvgvRE4D4N18Xb9NTQiUMJnUnEPMqSEGOrz+QcPiDvQDAaHvdCIDzFxSxSWOcfDnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762019587; c=relaxed/simple;
	bh=Pq4hiA5KUEpQNLEUv5rFTagvCYc8rEZqjvCX624uJH8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=j7HTKuk97DZ8oRwBC6UKkx7ISe0xbNIg9vNlyUxxJpznxU6Kq4xIaNuiTxoZx4qpjvzkVlJLcyZREKHceiLSZZl8liTk8q0L8WMiAGalHWaq/h3KXxsK7D/YUucOFRjClvXgnFcueUyLaY7LJTwAAQa+Xgh7Rv9rNO94NXLL+iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNcr5jO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3221FC4CEF1;
	Sat,  1 Nov 2025 17:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762019587;
	bh=Pq4hiA5KUEpQNLEUv5rFTagvCYc8rEZqjvCX624uJH8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PNcr5jO28JFBBw223bL9o9owpb1RcWGxehgsa1xhLN/1jt8BLamSG0HL0d8nz7PPc
	 bnAC8GBaOcBJGxDnZnfo7Y8xsCc77g6QGtXaO10kKPqLarLwKiqSVa6FbyRmyM3Xa4
	 5fuY9PYjJxE0wR+DQbLSm6Gkr/nAc83czo/zgljr78b8AtLXyFfXSr5urFfPhZYxTj
	 qQMXIpfsLfCwagE3yKPPSZEaB65Sfcg6/E0/Oj02xfzphwk23gczEBJEpafxEMiXUd
	 reVZal24knl3/pBrtwXE2eRdx2tnZC/DoZ6AkaYhTzwP3HoJq7E/w8LVUjgQzcrH7O
	 vVbzzebE9xz2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1083809A1B;
	Sat,  1 Nov 2025 17:52:43 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.18-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <ebe895d1aed47312d7f57da076ac3d68@kernel.org>
References: <ebe895d1aed47312d7f57da076ac3d68@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <ebe895d1aed47312d7f57da076ac3d68@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.18-rc3
X-PR-Tracked-Commit-Id: e7dbfe6f15b4df34bb169d180bd10f1a3c043814
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 691d401c7e0e5ea34ac6f8151bc0696db1b2500a
Message-Id: <176201956268.853286.10590101280136848742.pr-tracker-bot@kernel.org>
Date: Sat, 01 Nov 2025 17:52:42 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 01 Nov 2025 12:30:05 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.18-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/691d401c7e0e5ea34ac6f8151bc0696db1b2500a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

