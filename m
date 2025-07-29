Return-Path: <linux-spi+bounces-9200-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CDAB148BA
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jul 2025 08:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0FD4545089
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jul 2025 06:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90495278E75;
	Tue, 29 Jul 2025 06:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhPXc2QS"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69616277CAC;
	Tue, 29 Jul 2025 06:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753771814; cv=none; b=Td+gYmX7JHLTDXFYysc8iYyhzjwM/pqP8y+1VYvTSEmo9m511L4k2niTGwxacSs4lrrD/lwBoqvUxEJMRldKYKarIrS8kiDaKbTa/VUTvB3hwnK4rTt+y9oM+jPmgtJ1eDu0de+62RZnVe6tulCC47rL3aAFi39ibKnxtyM7GEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753771814; c=relaxed/simple;
	bh=05PcAjPSO1cVWLo0kPm8ouA966+RXJLHb9GBCJ8guBY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rjba3IjfT+id5hKcJr+t8/8aufIlev7xD/1p/4Plu8FewCnf4juob1kt9oxnpZlLwuM4h68QiaPS480u/DaYYsxWs50ZoBTTXTgPV3WtDLhFEPlIqmw2EZy0kU1rROAPYt6kbJZVa92KEVUo3wIT4elnVz6HNpF5Wj+gt+t7PoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhPXc2QS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D52DC4CEEF;
	Tue, 29 Jul 2025 06:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753771814;
	bh=05PcAjPSO1cVWLo0kPm8ouA966+RXJLHb9GBCJ8guBY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MhPXc2QSo9QLnEacBFMRMrUZ5oBGXle8pVcK98/sCcMBqto11wOi/XzS3t/0LZeiG
	 /H+LRk24In/xI92L3pqEcxqrzb9kK+GXZXVVeRIf4M9HhoEefo5Wd1iI09k8qSuasw
	 MP4HAdb/UMl27K0cXTAHI1UU7P+GJ9+uN/vCGioMRWU53vaFRjI3M+rDgRMMVWbL6R
	 pHdMwwuLSaTM/4jNrv6oV3xPDleLRFEYXvCzKdIGkauQSZHa4xOUX0SeSbkiS37/bo
	 s6bd59wisHxAWY/hNFSZz6nzY0UqcHDnkk591jvKvAWH2gaFkyQ/stRjOKdwCTS8IY
	 UukSW3ImCUPDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 046DC383BF60;
	Tue, 29 Jul 2025 06:50:32 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <ead4b31b9f656b8a7ac9280d368fd210.broonie@kernel.org>
References: <ead4b31b9f656b8a7ac9280d368fd210.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ead4b31b9f656b8a7ac9280d368fd210.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.17
X-PR-Tracked-Commit-Id: 2d442a0c781403702de27ccfbc4bb233721585f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0262163136de813894cb172aa8ccf762b92e5fd7
Message-Id: <175377183080.1356386.3701150989011374661.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 06:50:30 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 13:24:37 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0262163136de813894cb172aa8ccf762b92e5fd7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

