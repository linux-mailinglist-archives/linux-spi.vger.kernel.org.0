Return-Path: <linux-spi+bounces-11076-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE8BC3AA2D
	for <lists+linux-spi@lfdr.de>; Thu, 06 Nov 2025 12:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D2841A47903
	for <lists+linux-spi@lfdr.de>; Thu,  6 Nov 2025 11:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEE930FC0A;
	Thu,  6 Nov 2025 11:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phOUg+3j"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C765C30FC03
	for <linux-spi@vger.kernel.org>; Thu,  6 Nov 2025 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429268; cv=none; b=cQ4JdDcQkX2R8mIMjfAqFpDepOMMAMi1CKvhUatKcL5+OCAOeHR9J+HvzBeP/0bwCJ7ahOjaqaFNcu2q8rpUdJo8nmxakDSRLX8BkXhBMgrnUEKaH30X7creKJNDCyGauFj2qKWHdSnF6uv3jidFC7D6sQwE58Qt3yP0UrdEhnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429268; c=relaxed/simple;
	bh=SVh6N14HeQlbT9bb+7JFDO8zRJjiVrzAJ8vJ3u0afnc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=bmgFIJipDe8pKNeTUuXOoVK6gyH3wflK7ix1EO96VaQleS4eBYYbOlm5eOjJvx/8mSKXKNY3DVsH88YxAmJDFI0+TFyyHYgOcKHqBZAE1BuMKmaCUOTtc0Hp2MX+UfITXDxIoptTkFHIR3gWMgmHOa3qQ0oUAYiWTdnUlhNeAzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phOUg+3j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496E0C116C6;
	Thu,  6 Nov 2025 11:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762429266;
	bh=SVh6N14HeQlbT9bb+7JFDO8zRJjiVrzAJ8vJ3u0afnc=;
	h=Subject:From:Date:To:From;
	b=phOUg+3jAFOtodptDS+SUHXkKe9fYJPFHfUbDDsviep4e5c3vdJtscBDbMFJwJJ+h
	 kSF8WQT9ojASXqsGmeXZ352qOneQnmBg7e7jtNI+/MWFZHQ2RigXWR8NvX4X5RqTmH
	 XNUGCaPVxmqcLppISLJ3mebKq3ZReCYmsWv3ZFxfdeKQ7KfnSnUMhSYdas/c0t2Hcg
	 mQWAcnr3beGra1NY0F/D8iMvqopbML4RTrGdCjR5whuLrXG2dyn18xM+pkBjDsqsuP
	 aUDVnCcv1n14H7C2d87WVGL89Rdsk4RMlUfTt7ukAs4N5dEC7bE4YF6kex+bjid+6e
	 oub+8ZwaXzPRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 74AF539B167B;
	Thu,  6 Nov 2025 11:40:40 +0000 (UTC)
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
 <176242923907.167536.1682913204663009246.git-patchwork-summary@kernel.org>
Date: Thu, 06 Nov 2025 11:40:39 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: tegra210-quad: Improve timeout handling under high system load
  Submitter: Vishwaroop A <va@nvidia.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1016816
  Lore link: https://lore.kernel.org/r/20251028155703.4151791-1-va@nvidia.com
    Patches: [v5,1/3] spi: tegra210-quad: Fix timeout handling
             [v5,2/3] spi: tegra210-quad: Refactor error handling into helper functions
             [v5,3/3] spi: tegra210-quad: Check hardware status on timeout

Patch: [v2] spi: aspeed: Use devm_iounmap() to unmap devm_ioremap() memory
  Submitter: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1020315
  Lore link: https://lore.kernel.org/r/20251106091903.2800981-1-chin-ting_kuo@aspeedtech.com

Patch: spi: Try to get ACPI GPIO IRQ earlier
  Submitter: Hans de Goede <hansg@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1018660
  Lore link: https://lore.kernel.org/r/20251102190921.30068-1-hansg@kernel.org


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



