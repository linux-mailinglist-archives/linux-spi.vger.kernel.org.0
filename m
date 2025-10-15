Return-Path: <linux-spi+bounces-10672-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA3FBDE72B
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 14:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A46143B6A65
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 12:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66A4322DB7;
	Wed, 15 Oct 2025 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUwq513c"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C236B322541
	for <linux-spi@vger.kernel.org>; Wed, 15 Oct 2025 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760530826; cv=none; b=eAUyc7ybAiQqiDfLhihqyrgUMybwAqsroPobObCoBBX5C+VoDgggGlSPS0F7xj0gXw62jxIy6bm4Ap9ymku7/u7xxNuTbLMLc7l0lWf4JaSqrHA4AqLuPXl1uAwEVwt5MVZ4KLuHJZrw+A6RSf5ejzQnIoAdLs0l3rpmM5B50ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760530826; c=relaxed/simple;
	bh=n9mv2Tf2b5pb2qKYe9OjIrUQi03Xe95Ew4zGpasx50Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=pu9taaDZvaF0251713LpSqgWy9GfVtaaHrSbOco8zfWKKe5jif7OVuWjEB7u6pUEusGP5RvYe53w+BtXq2K+2zrGSad8khqDta/JIDX8kQ9sf5ko2ZM7LY0rfOhB20XuywAC8dM+RQpQRMnbeu7nCYND4kcfCIqjHUDA1pchjFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUwq513c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C8BC4CEF8;
	Wed, 15 Oct 2025 12:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760530825;
	bh=n9mv2Tf2b5pb2qKYe9OjIrUQi03Xe95Ew4zGpasx50Q=;
	h=Subject:From:Date:To:From;
	b=UUwq513ctJwCNaQzQpOWeMlnTfliTYmPpQYF6/i1UE/S27nT7bYuwnSBQlY2MDWAg
	 7jiTHI5H0pVXhGOD5/CjYfWJFVj5fv+Qs/884fOsCrxmV7lXYP7vkbPb0ZAYMtCYiD
	 oyo34FxiHpZfRU0/WND0lDYLQoDLfHWEsM/Yawt009xbbyo/geydr35npCFY0NMN+d
	 QpMBGRixiYauZfI7tFQncsxGqiS+iX7qneod+r9Mg1sW6z64wt2OiLgYT+t0u1fuAl
	 bBtHqF9HlmgFb9cpt3Y+NqbcVWVimdGMDiQN7HI6iNQRcwfQR5FIQIK5KX6aog/tab
	 f/WFgiWmy0OCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B3DA0380CFEC;
	Wed, 15 Oct 2025 12:20:11 +0000 (UTC)
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
 <176053081015.463832.9797092570023000252.git-patchwork-summary@kernel.org>
Date: Wed, 15 Oct 2025 12:20:10 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: aspeed: Improve clock, timing and address decoding logic
  Submitter: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1007657
  Lore link: https://lore.kernel.org/r/20251001112605.1130723-1-chin-ting_kuo@aspeedtech.com
    Patches: [1/6] spi: aspeed: Update clock selection strategy
             [2/6] spi: aspeed: Improve timing calibration algorithm for AST2600 platform
             [3/6] spi: aspeed: Force default address decoding range assignment for each CS
             [4/6] spi: aspeed: Centralize address decoding region management
             [5/6] spi: aspeed: Add per-platform adjust_window callback for decoding range
             [6/6] spi: aspeed: Only map necessary address window region

Series: Add target mode support for the DesignWare SPI controller
  Submitter: Benoît Monin <benoit.monin@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1008005
  Lore link: https://lore.kernel.org/r/20251002-spi-dw-target-v1-0-993e91c1a712@bootlin.com
    Patches: [RFC,1/2] spi: dw: rename the spi controller to ctlr
             [RFC,2/2] spi: dw: add target mode support

Patch: [v4,1/1] spi: offload: Add offset parameter
  Submitter: Marcelo Schmitt <marcelo.schmitt@analog.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1008715
  Lore link: https://lore.kernel.org/r/cd315e95c0bd8523f00e91c400abcd6a418e5924.1759760519.git.marcelo.schmitt@analog.com


Total patches: 9

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



