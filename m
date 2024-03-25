Return-Path: <linux-spi+bounces-1987-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F8E88B167
	for <lists+linux-spi@lfdr.de>; Mon, 25 Mar 2024 21:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 302E01C3F44C
	for <lists+linux-spi@lfdr.de>; Mon, 25 Mar 2024 20:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBF14AEEF;
	Mon, 25 Mar 2024 20:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AI1F2vcx"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6609450
	for <linux-spi@vger.kernel.org>; Mon, 25 Mar 2024 20:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398628; cv=none; b=iGFIIoO6Ve3wjTaVE08omAo71uoTQsZy5duDIRN0FHNtJUdJ3LrRJJwSQ58VCkqcaFvNVwyj5gpgm+CK3Y/ouz21CfFJ7tAdIUH/n7Pca7sWO+RPCSH+jlI6thNNZsERrOa6mu8kRAJ5FDNGhqpdM1XyE5LP5nOm+gPv0Opsv4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398628; c=relaxed/simple;
	bh=frfzSx77rLAcuLxiSA+lW6niLUvUQ7lCRghWBLRVFzc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=dUSXg4VSU64N4Zejyk66tU79ARE/foO3sRb0B7/rxgnhWivpKirwlQhOqgqCYXr41tjCYovj+EFWdH+8GGSDJyoJDsTNCLeq3MYfbK1+noBrSZcvgoJMqkn4/2ITbri4Tu1aXv6dSkx9ivRkMFjfJMGnZpXNc/gOyrv06r9lPa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AI1F2vcx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8DE6C433C7;
	Mon, 25 Mar 2024 20:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711398627;
	bh=frfzSx77rLAcuLxiSA+lW6niLUvUQ7lCRghWBLRVFzc=;
	h=Subject:From:Date:To:From;
	b=AI1F2vcxd3uj+6zzAOmF7SgBHaymFXMywPgEYOi/QNPp9cEl5nS6xD056p0TzMCsq
	 3vQPjo+Y1NWzSBeHLUDW1t7Qrxq+ykcQmjbArzJouLiU0k/iIrT5MpmfIBF4XNDd5g
	 jj70BZXPA25xgPHiNGmr05+KmlT7AY6OuwnhNMNkUvkvFTs8ikMAINDm/znpmOyWm/
	 iq32vjZaQJ8V8PYLyeRbA77+anUlL8MjOT3CaqGEitFmajQoX7fAhJjFhEggKKdpR+
	 gt7COFQx/obhnlVWRGQNyjoEpqc/FsmUBEx0lPYm3AXnO+aw8ROo1P39Fp6RIlpu4d
	 xp39plXpk1URw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D03D8D2D0EA;
	Mon, 25 Mar 2024 20:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <171139862778.16803.1112791281453461620.git-patchwork-summary@kernel.org>
Date: Mon, 25 Mar 2024 20:30:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2,1/1] spi: rspi: Get rid of unused struct rspi_plat_data
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=837912
  Lore link: https://lore.kernel.org/r/20240325142118.3210915-1-andriy.shevchenko@linux.intel.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



