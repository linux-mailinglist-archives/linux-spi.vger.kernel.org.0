Return-Path: <linux-spi+bounces-4201-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D12695303A
	for <lists+linux-spi@lfdr.de>; Thu, 15 Aug 2024 15:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0A2E1C24E23
	for <lists+linux-spi@lfdr.de>; Thu, 15 Aug 2024 13:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C13A19D89D;
	Thu, 15 Aug 2024 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrrjYfxR"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578DE18D627
	for <linux-spi@vger.kernel.org>; Thu, 15 Aug 2024 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729230; cv=none; b=HOI6OG58EIdVVoyGQSz3wZ0rRUAyZNTTBDVOB8YZUSxr+6018bpbxqrViI4KhYcbjG5OWEqIUbEBhstvZ5QKQWgZxcYXhV70+iiehfO+yWK4uVXSulz7743opAViKPN4GgoF1UaG76XbiorsYsCKtk4u9F9P4gVAAsR+qMgBk8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729230; c=relaxed/simple;
	bh=tNeXxaQNX4wkbKj7VOYwvxTyNbvbA3pUksBzIdd56Is=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=a24F5soG7jox3ahEwGgRtkFwJu6FKJfN9rD7Q8tkxLgA7g0TfeeE7RnneiCi/LZEhKzhXQGc3SkAffZs245N9WdisEkjrDBWTh4wOzXSEBpIXXX50OtoseGrckUpNZnuRR1OKHLVqFz8YTvNq0lf1v0MK7rIC8bKFMYKPCDmGUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrrjYfxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F395C32786;
	Thu, 15 Aug 2024 13:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723729230;
	bh=tNeXxaQNX4wkbKj7VOYwvxTyNbvbA3pUksBzIdd56Is=;
	h=Subject:From:Date:To:From;
	b=rrrjYfxRBvwbgj0ZiZqBJ+mjioOhSedLqYtrOQGI9yU7RjvcVkJFtnFFK+4d7atm/
	 PSYc4U1zqhWqVDluOZazfYH+kDqHTX/I2gjJYyU5FqQRLWhFtvcVytNgvqQEX457Ei
	 hl3/Mci1ssWnU/R+kWAO8EOlyQkeXDXCSHIMggONE3Gcl/mMTkolF60v2hfI+boMYg
	 E7IEfvlkWHBZpgqUHjd5vJrpolesTJ8c3IzYwKimP8JWbvHmCEKGfBxIxlKvwyXCgW
	 UPbTansMvQWdYThxa/z3OzJpyTV3e54Gq4DCWq+vUlJ72Mx7jdSc2gBkLL9sHf4Og5
	 vFOLTPlkzNvKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 76C8D382327A;
	Thu, 15 Aug 2024 13:40:30 +0000 (UTC)
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
 <172372922893.2856418.7630663999901344053.git-patchwork-summary@kernel.org>
Date: Thu, 15 Aug 2024 13:40:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spi-cadence-quadspi: Fix OSPI NOR failures during system resume
  Submitter: Vignesh Raghavendra <vigneshr@ti.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=879681
  Lore link: https://lore.kernel.org/r/20240814151237.3856184-1-vigneshr@ti.com

Patch: spi: cadence-quadspi: Simplify with scoped for each OF child loop
  Submitter: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=879670
  Lore link: https://lore.kernel.org/r/20240814143805.98874-1-krzysztof.kozlowski@linaro.org

Patch: None
  Submitter:  <pierre-henry.moussay@microchip.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=873829
  Lore link: https://lore.kernel.org/r/20240725121609.13101-5-pierre-henry.moussay@microchip.com


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



