Return-Path: <linux-spi+bounces-7653-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E53A92E2C
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 01:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E74668A6168
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 23:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0291E1E09;
	Thu, 17 Apr 2025 23:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifYmG7qw"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECFE224237;
	Thu, 17 Apr 2025 23:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744931966; cv=none; b=FpI029z1+ZbGt95gLuw7qx5YVdFlPiL2RmRPJII05aegX34uBHzQ7rbDCOuUc1vxp4mTpt3y1qBgye3JBq2Flhu3KFDs4RF9Wewzp9fxq/eotkJdcKs3xaXNevH0k6oGcl4xo19XS4iS4CYrDpaGtZoySKhFArlWJJQMdjK8JNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744931966; c=relaxed/simple;
	bh=PwVDXdH0a7d9OMpZSilNCUiyi7LzpmEqN7mJfOgcaPQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=g8jCbvz4pABguuAHXYWCevWkokLViKGV8U8s31vm4ex7NpeJCRZuy2SMMxBHhTXgmQwSEkkFlUtSRaK48nZ6cmVvd93YEpdu1VV74a0FtCboRnSCXNoWuVKlFqzGNJtK5yUnUgKtkPAL6w09/WGX+QupiTqnmMWe2SRA4+14aSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifYmG7qw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A51C4CEE4;
	Thu, 17 Apr 2025 23:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744931965;
	bh=PwVDXdH0a7d9OMpZSilNCUiyi7LzpmEqN7mJfOgcaPQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ifYmG7qwWSwpfKi55HnRfV1uqNgYtx6ERwSddRunHsrpG7BkOZON5tZXhcfR51hWH
	 JfilJ6KNd94sQUUqpHSkWw8YkeybntKImT8qqyCDS6djiltgqxVslsLDJt7OJZ6eLO
	 n++RUBQpDMk8vvsZPQCicrGR86+tV99qZB5ciLCRkS29K6Zyms7qjlWmdbnA2QxEPG
	 O30k2l6Hgg6ezyU+mrsYXp6estbwQ03m7Jip8mNFviE3oqfuZwksJpSE3gVDpNgdDl
	 Y417FZx3DijRt8IsE3CAgPQt1HdbcwL61O1BG6dFH9gI6W5/uLh7Qk59r/oofV9duV
	 DH0FcBjoVUJJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34227380AAEB;
	Thu, 17 Apr 2025 23:20:05 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.15-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <2391fa16200e50aa1a9379b791d0b7a3.broonie@kernel.org>
References: <2391fa16200e50aa1a9379b791d0b7a3.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <2391fa16200e50aa1a9379b791d0b7a3.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.15-rc2
X-PR-Tracked-Commit-Id: 951a04ab3a2db4029debfa48d380ef834b93207e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 272876d599950c1ef12d3d146f1533733761c37e
Message-Id: <174493200371.45874.9462991792235811646.pr-tracker-bot@kernel.org>
Date: Thu, 17 Apr 2025 23:20:03 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 17 Apr 2025 20:08:34 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.15-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/272876d599950c1ef12d3d146f1533733761c37e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

