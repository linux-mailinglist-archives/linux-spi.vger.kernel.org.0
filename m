Return-Path: <linux-spi+bounces-10782-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BCACFBFE0B3
	for <lists+linux-spi@lfdr.de>; Wed, 22 Oct 2025 21:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7056D4F29D7
	for <lists+linux-spi@lfdr.de>; Wed, 22 Oct 2025 19:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872152F0671;
	Wed, 22 Oct 2025 19:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+B3USjJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BF525DCF0
	for <linux-spi@vger.kernel.org>; Wed, 22 Oct 2025 19:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761161424; cv=none; b=r3rgdLldlOzZ9tbY9CFjFo+yxe7D3ZMnAxn9s/uEhqM+lufZyiJfMpQNR0r8r4Zea+Z+anKYUhwZHfjulkMqF2drT0qo7s2bQzj78ZnimTqHBrvM850GzsO8unB5ksolgPr35N/eVXr8v4N3OyBUK83UhZGNN8Ce725GwIVW7pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761161424; c=relaxed/simple;
	bh=8896lKOXJA6Ybii8GmYLxsZh7F25ct5gUso/eO7uxe0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=C2kKv0JS0Kjrrql4UoyAsvVaNosF/977Y5VZfgXp50SypJKmTHiuwWat1gt2gCTH1d82csDioE7x/rNws7pRboYom4OqqRr/q4AaCdV2YNheDsnSSMwSRmuSOVuRTuT2e/mbp8ZVu9OGMn+kDhHi6N/1DaRmlhDxpp/lumpbPe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+B3USjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6BEC4CEE7;
	Wed, 22 Oct 2025 19:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761161424;
	bh=8896lKOXJA6Ybii8GmYLxsZh7F25ct5gUso/eO7uxe0=;
	h=Subject:From:Date:To:From;
	b=j+B3USjJQjPAsJGfdV6Vg/0iWnlbWxEtDePeRFMz9GROOzjf1iIgciZgdnjKYvbxn
	 70v0fCdn2Oe9OcGkKSb5NBkw+7YFxIiVWjzGAh7YKJ3UxrpV7sY+w6ex9slqiK7/UQ
	 /EEZ1fSKXfTWZv337bIXSdVpsJTH0LbQwNp4g8orcflZQ2c2sJiT73UZsKGrfKtXDo
	 Xnw1FyJbWcxqEu0NhkOIBLW1zgwrEsiXxk3Mk87anGMS25qHtMNGcdGSODQHbiw5Kw
	 JJP+1lTnzNyKJYILDhHLI0Mlgszhr26YvDkEe98QfFX8/2A5/q6oK0lj4pDokAgtPT
	 q4uULguSR7OpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 377A23A78ACA;
	Wed, 22 Oct 2025 19:30:06 +0000 (UTC)
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
 <176116140475.2063353.17451494394814433732.git-patchwork-summary@kernel.org>
Date: Wed, 22 Oct 2025 19:30:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: dt-bindings: spi: spi-rockchip: Add RK3506 compatible
  Submitter: Heiko Stuebner <heiko@sntech.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1014271
  Lore link: https://lore.kernel.org/r/20251022004200.204276-1-heiko@sntech.de


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



