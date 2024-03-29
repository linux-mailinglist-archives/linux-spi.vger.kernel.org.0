Return-Path: <linux-spi+bounces-2093-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4500889105D
	for <lists+linux-spi@lfdr.de>; Fri, 29 Mar 2024 02:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289A71C2432C
	for <lists+linux-spi@lfdr.de>; Fri, 29 Mar 2024 01:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB9D1642F;
	Fri, 29 Mar 2024 01:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BY0y0fvH"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260EF12B83
	for <linux-spi@vger.kernel.org>; Fri, 29 Mar 2024 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711675832; cv=none; b=Ub1cZqhe4v5eLXvMzdW+0gK8rgmfxp4Yc+pydVu3OjQswF4AmUuwyglSilg7u5RAB4/XwIVK0JVhwF1oS+7Okn7pZG8NBuVTfwA3xpU8rEAx18nZdIgBXt1BzR+z3qfvaUF2nE4XQ+uCXkO09n1yzOAUH6F3BZEhyXd3TvdcEc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711675832; c=relaxed/simple;
	bh=ReYIhxCYTvnPUZDWnPw0DeRCFkD3IHa4hpfjUPwZdAA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=RByoNnDtXj66Q2UBTS8pixvP0IrjNZCA/+4ippSd6JbX3Z2QbhHh75vPoUo3Er9TbWVV4g4nJsRYvMTadGHg5pQXWoamvZb7T4HAv9vPtaK6mGC1EAdT6wmrUvFvQHcJcqYaReZR9AwxbCutcGDs8aXKyrf0BWUi+sFvoLL5ouE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BY0y0fvH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4DE7C433C7;
	Fri, 29 Mar 2024 01:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711675831;
	bh=ReYIhxCYTvnPUZDWnPw0DeRCFkD3IHa4hpfjUPwZdAA=;
	h=Subject:From:Date:To:From;
	b=BY0y0fvHD39QSa8VCPSGPVWRXRBEkyGHj1t+ZSD8OOixHTtZ66a9KJp1pxwyheVgF
	 Yx84KUyryS7d03AiPuy3JFFHHLknHXjTcP1/nFnrZRXujSja0jxgA2Tu2NmABdTQWU
	 UjbHoaZSyfAGVlrDkMoSIitmvZO1g6kd5M6EOQeI5W6yAgkIZ8+OWyYw/eegX3hXe9
	 /qERBHT8PhmRdHBx4EGVXANvUgYcHRBlobZM5Rb6mxsG40hOC/3pp1JiFvr7vWTbYh
	 4rMDa+5Dsqnu8W/J1TKaVTyIOxENHEEpNAeN1vl506h+fWZvfLOruYsnK9hFcyzer0
	 lSYtKKvyz6pJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 814CED2D0EB;
	Fri, 29 Mar 2024 01:30:31 +0000 (UTC)
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
 <171167583146.32458.1414923579885871288.git-patchwork-summary@kernel.org>
Date: Fri, 29 Mar 2024 01:30:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: pxa2xx: Drop linux/spi/pxa2xx_spi.h
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=839046
  Lore link: https://lore.kernel.org/r/20240327193138.2385910-1-andriy.shevchenko@linux.intel.com
    Patches: [v2,1/9] spi: pxa2xx: Narrow the Kconfig option visibility
             [v2,2/9] spi: pxa2xx: Drop ACPI_PTR() and of_match_ptr()
             [v2,3/9] spi: pxa2xx: Extract pxa2xx_spi_init_ssp() helper
             [v2,4/9] spi: pxa2xx: Skip SSP initialization if it's done elsewhere


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



