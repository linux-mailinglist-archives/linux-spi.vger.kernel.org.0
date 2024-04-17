Return-Path: <linux-spi+bounces-2411-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7FE8A84BD
	for <lists+linux-spi@lfdr.de>; Wed, 17 Apr 2024 15:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DFEF1F23DEA
	for <lists+linux-spi@lfdr.de>; Wed, 17 Apr 2024 13:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A965A13EFEE;
	Wed, 17 Apr 2024 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fC7MqdZr"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857A113E035
	for <linux-spi@vger.kernel.org>; Wed, 17 Apr 2024 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713360643; cv=none; b=oFVLNLOTuz/zHnBy4MJXRslbJCe8JrEOiT8+nZnohQXf8CdXIg9XSBcjve8cXYgRD28aTlK2PspdP9ZQ2eNpgQF0wvchtA2l3oGt9KPsw/p+DGAWxJiGbylT4lwrk2AbOGARpxE/Qz7blDCv+To+j6tHb/wfNFL+Ad8YMN1GPv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713360643; c=relaxed/simple;
	bh=jhhtud0qGDkLWMBKExowFgav0B7ITY7BRmdKYoVhQjk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=FWvFiA1mHaHEQi6+cCC9PbL73i9pCGwdoP/36Tqmx3JDy4PY/DsMq5PqJWboZvYODqx729MWsubX+bsbWpIuG62gOxzc9Zi1ohx9wyCbwD8ixVuMhXs+D+fJoGE4iameVW2bRns+BAWlDjQO+syzmnZoKV6DRV/eZBDl0EvzXD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fC7MqdZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27372C072AA;
	Wed, 17 Apr 2024 13:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713360643;
	bh=jhhtud0qGDkLWMBKExowFgav0B7ITY7BRmdKYoVhQjk=;
	h=Subject:From:Date:To:From;
	b=fC7MqdZrIWx0CQqj0y7BdHn/VVhFr69WD3O1e5DyhfzhXGo6xg9I8fK6nb2MxQYAa
	 LqSK/SAaxtw/LhHMUdiLOTvZg4kbhT9mh0z6glVZ7ML6mI2Sku+XRqU1/j9JG3QUUY
	 KmE2S+fxewfaXCmCCWvEChQ8MevCkOwq5RnlNfkl3x3i6e9XC/vHNH6Q3U//ymDV5+
	 WZu++tVHXO+QkB9jVK/9bewSn+t6Nf+9OEgHR5BL9WooUJ+y4yC+Y6ZbtMLpNXP965
	 xGYerrZTQAcG7l1hHucyDYcOgPtMDpOeKWeB9KB4DhNfCBDJKT7zgT5jGnkdc/1Paw
	 1uVdY2OY8La0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C89AFD5B3FD;
	Wed, 17 Apr 2024 13:30:42 +0000 (UTC)
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
 <171336064257.13200.516950440644976993.git-patchwork-summary@kernel.org>
Date: Wed, 17 Apr 2024 13:30:42 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [dt-bindings] spi: renesas,sh-msiof: Add r8a779h0 support
  Submitter: Geert Uytterhoeven <geert+renesas@glider.be>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=845096
  Lore link: https://lore.kernel.org/r/68a4d8ad8638c1133e21d0eef87e8982ddea3dd8.1713279687.git.geert+renesas@glider.be


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



