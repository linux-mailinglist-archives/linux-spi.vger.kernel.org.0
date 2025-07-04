Return-Path: <linux-spi+bounces-9058-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F52AF99BE
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 19:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24CF73A25ED
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 17:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D73B2D8393;
	Fri,  4 Jul 2025 17:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTqPji05"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B3A2D838F;
	Fri,  4 Jul 2025 17:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751650572; cv=none; b=PggMdorl+gWF49+qdXsR+FyaKlb3L4ZHAX/rNZ1kE7L3XmHYkE0FJ5I4TsVUVaMfi/5yNP34pInCRbkmWgMwdOGuRY22UNjmxI4tt3U8Aj50L2NkSuzpVwj+f+4SI9J5tzTDnLK0+GxyRhJI539mHDDqCvtrmn28cuBLnJdYk9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751650572; c=relaxed/simple;
	bh=zT3sMakbhwFrNVaafncpigVu6xlhlv8cZoefYiNYWHs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DmiNCA8MxdjZGShz82BTFida81ycSC6COMlVoxQ6TItZFdPeWRKG/qRgl9BadVbjeHW+dqHhFnmuUb65GJ0oH3IHQ2pjwTIQ9lQSolq2cwzh24n3sxcB7qEvIIfUlkb3K34ou2q1k4SoSV4Mfa5BrDmiuzWC1yfEGrK6D7Kgd+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTqPji05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0A0C4CEE3;
	Fri,  4 Jul 2025 17:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751650572;
	bh=zT3sMakbhwFrNVaafncpigVu6xlhlv8cZoefYiNYWHs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sTqPji056CrEBEguhmofQC4eEg7sADIx4hKvFhafjiv0y0B/8MY8bhq95X/OOIzew
	 CUhCEV442q7hq4GXEounCZ8tkFjtU6fJ79buB2w1iJgCQmT4rbSmthn76BYW1jc1Ax
	 WB+UbqBcq0oXvYP3HK1AdaBHx7Oibyn/FleJgdq2XKPRKbOQ0egfDzGl07GAyonBa3
	 DVMiwICrL8PmHpZ9d0Kr4XV1ZmycZL1vHVeNVLOiV+G4V/AbVQ6qMF8us7wkdCAdc9
	 en6UJEhbPurpAyOCft6J1m4u2QfZnJ+fYRHKMUMBYYI+A5oFzDUKHOPUA3F1kE0oXO
	 G7pWxuVowybLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7E3CE383BA01;
	Fri,  4 Jul 2025 17:36:37 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.16-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <36262b502dd08b5d5c602f7c7a1d6449.broonie@kernel.org>
References: <36262b502dd08b5d5c602f7c7a1d6449.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <36262b502dd08b5d5c602f7c7a1d6449.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.16-rc4
X-PR-Tracked-Commit-Id: 04a8ff1bc3514808481ddebd454342ad902a3f60
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1d8128f701682d34d9308c9e6b7385c0ffa4b4b
Message-Id: <175165059623.2287194.392976876670181790.pr-tracker-bot@kernel.org>
Date: Fri, 04 Jul 2025 17:36:36 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 04 Jul 2025 16:07:12 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.16-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1d8128f701682d34d9308c9e6b7385c0ffa4b4b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

