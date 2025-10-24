Return-Path: <linux-spi+bounces-10827-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39389C07C46
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 20:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E9423A6E65
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 18:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B42347BAC;
	Fri, 24 Oct 2025 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTd94XKE"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD291E51FA;
	Fri, 24 Oct 2025 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761330781; cv=none; b=S57hMXeJvO39p1gSv219LOjGxA1+7N9226z72g07l8cB+k20e8DcWYVkZRi1uHNyOjfUJDm66z77AlMmXZ6D+PmArCuVYlQexOHM9QoA6k1Mlq0WilhujDlaZfmYCXC4h/+zzBMCGwAAvYPhf9dBG67QZ3ULSRmgbrlrjERHpgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761330781; c=relaxed/simple;
	bh=jDvdZvPllReEk36qT4uetQs+/jgvMBwZY6d3J0J/yMw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ge2ETYVmFT8x76dHSfhKW8DJvqRz9hRZqkW5sKfgenGo0Ecq0rIUfdoRmlEghAoQz/F6Wdmi0bpGF+D+tWLiIc6Nr/xLdpOJJHz3C9SzWsJyzjz5EkBLSgwZZmvrLCZKel2ogQOHvNuuakKdQJXd5NzMW/TwUU6yUbOk5u57MK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTd94XKE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE8EC4CEF1;
	Fri, 24 Oct 2025 18:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761330781;
	bh=jDvdZvPllReEk36qT4uetQs+/jgvMBwZY6d3J0J/yMw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TTd94XKEX0EtZ8S/q0sOS6KBTbXKpE4AXK95W+c8HeSJO/LKHsHvh/e5P5lWQWeXr
	 GDop3ykj5EUDY69yb7PQeeBmJ6wKT68Z8i+6Bj0TVrCw1bmretUpJunqsSk+6yCRjM
	 sdy8epb8orOwxHH8BvjA1i2OwkZOy7SblvVlcrTfzOI1kC6G4UyNfPa7XBRoFNFNqo
	 Cpao/tKiTCaSDgduXasyz2VaYmz+yVKqekkUpiXITFjy5jijTRAi7rZVgWrFSGJx90
	 lKe/DCkEE/5exYAiUH+LUFohJjur6h42sdjhehWxf+8oZr8EYrL+ZNKkk1/HEGah5o
	 vFKX+ayuco+TQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE27D380AA4C;
	Fri, 24 Oct 2025 18:32:42 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.18-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <91559e62fdaf7b56c4a1bf9c30ea9e2a@kernel.org>
References: <91559e62fdaf7b56c4a1bf9c30ea9e2a@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <91559e62fdaf7b56c4a1bf9c30ea9e2a@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.18-rc2
X-PR-Tracked-Commit-Id: 1b824134261d2db08fb6583ccbd05cb71861bd53
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 58834e2d3ed49d4424821d75b7eac90795212acb
Message-Id: <176133076130.4023146.9811095712660089122.pr-tracker-bot@kernel.org>
Date: Fri, 24 Oct 2025 18:32:41 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 24 Oct 2025 14:08:41 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.18-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/58834e2d3ed49d4424821d75b7eac90795212acb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

