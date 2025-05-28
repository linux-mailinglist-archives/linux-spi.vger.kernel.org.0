Return-Path: <linux-spi+bounces-8319-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6644AC5E48
	for <lists+linux-spi@lfdr.de>; Wed, 28 May 2025 02:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A43854C153B
	for <lists+linux-spi@lfdr.de>; Wed, 28 May 2025 00:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4183C1DE881;
	Wed, 28 May 2025 00:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oa4CuLzN"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A54F1DE4F1;
	Wed, 28 May 2025 00:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748392160; cv=none; b=tG5cuIyF0y48WIhweu9EByal+zYfjhOTB76Ef+hbi+lWnhNtXPfC13GrOjIw1oGU1GhULUi5Hxjgd2F48jqTrZCKeza3iDPxD96DNV7pcvbVK38E1ReIX7eJ2NXMz5KroT4T1G1cqyTV8s6EYJaiDqiIv1OllKJCrWdY+KyEd24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748392160; c=relaxed/simple;
	bh=MWDvOy/cGKe/sJ+FFDga4SKXZLlHvUuPJ91f1/yhZsc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=e7vX0oJ6rzrkQWvUCI9g6o6oh+xllz+VOW86WauMtEf9WnaDTm3WIWGCCyiCQL+OCRncCHBY+o25PbHHX3o1s5WDCBW9TPzvMg9yGXmEmnsW/hrL9disnmaoYFNL9xcswU67HVe77oE9AdB+5eld5uAnxlx+wExJHgT2EWgtIdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oa4CuLzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89CCCC4CEE9;
	Wed, 28 May 2025 00:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748392159;
	bh=MWDvOy/cGKe/sJ+FFDga4SKXZLlHvUuPJ91f1/yhZsc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oa4CuLzNt1XpvJCDthpWlKmSbfE2/R4REC5QKXK/EYumDgvtZCuxa9+Mp4OHp86Qh
	 B/8qOfWouRMoEoBZ4Pvby+vIt3cbQ5FYj47w7Hnbirkdu84hubm6VOS7XWd9AGC6r6
	 EwokauIJ5O7b1Spa2DN/L1DWqJjelSvX7B+SfFtRsm0xJ+95GlvhTU4meBPHGx1FrQ
	 0IaDlKwda4Mu/dk5yPlXLQNmY5+NE4OVFcQdGQ3K8yT7Wr5WvxYsRfRcCubc33YmMI
	 U3mRCkaC062XWCpcT7o0DGZ9PXhtd35FRgxTA4VT6ddmEqROQHrhtYEDZtyeBTI5DA
	 OLkO7PC+TajMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADAC380AAE2;
	Wed, 28 May 2025 00:29:54 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <4a1559fc9c5d1fec91f1ac5d425871b5.broonie@kernel.org>
References: <4a1559fc9c5d1fec91f1ac5d425871b5.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <4a1559fc9c5d1fec91f1ac5d425871b5.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.16
X-PR-Tracked-Commit-Id: b00d6864a4c948529dc6ddd2df76bf175bf27c63
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5722a6cecfff3e381b96bbbd7e9b3911731e80d9
Message-Id: <174839219343.1837144.344561637732015603.pr-tracker-bot@kernel.org>
Date: Wed, 28 May 2025 00:29:53 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 26 May 2025 11:30:17 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5722a6cecfff3e381b96bbbd7e9b3911731e80d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

