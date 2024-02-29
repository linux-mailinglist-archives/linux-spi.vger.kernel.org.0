Return-Path: <linux-spi+bounces-1598-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0C786D4F2
	for <lists+linux-spi@lfdr.de>; Thu, 29 Feb 2024 21:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4EC1F249D5
	for <lists+linux-spi@lfdr.de>; Thu, 29 Feb 2024 20:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCF874C13;
	Thu, 29 Feb 2024 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIYEmBrV"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A15474C10
	for <linux-spi@vger.kernel.org>; Thu, 29 Feb 2024 20:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239232; cv=none; b=nTIwMaUtL1k/raGMbFVcZG4qCYpRMoGnF325u4/fOeZJOyK+V/BBlsOU/0o9lBFBHcQ0S/MCVRGCfVCdjtm55iTRxKDzUWNYrNZvIC6vo5R4dQ5qHPy3MI44NM8TYJHgXt+3GR3s3j5ow75gYlQdDNoUfXldUtY0VZDaHjqErRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239232; c=relaxed/simple;
	bh=fSNKwhlh5nrM84DY/G2GP6238gt+CjJ0pNjhL1STjbE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=QbZPCSIOChs3tm3aanKeO5uzMokwDwJnRgRQI1j2Z/CQr4o5WA0Jy1uK44w6fI0HTNcii7rwaNTsiJI2172hk0RTsHfv0TXbImBzRm+i+JnZ1N1dhqxld2UW3rmf1F3Mjoq3QyOelHjTSyZIOF2PxbUtBLDWGvvR2IAlLUfIXL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIYEmBrV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9F4FC433F1;
	Thu, 29 Feb 2024 20:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239231;
	bh=fSNKwhlh5nrM84DY/G2GP6238gt+CjJ0pNjhL1STjbE=;
	h=Subject:From:Date:To:From;
	b=EIYEmBrVW1C0XvTeGRUY3WdzY25jUypeT87VIk9D1NuBNTHUrUzSfBFpHH4WI/Jd3
	 eqby68AbX5afdCdDxvUut1ZsEhtd1FkDOXDCQPy4CxooQ6zfMarhTtU4Xhssmp+awc
	 9rHRPjiP57XKdNELJAmw/8dU+JoWlK2MGa2HHzOQmVV6fZxoEhj/502aIFF72/TBh6
	 LqIQTWOTh/ojfX9nkJKMSBAw8f0I3sdG/MJJbJiTu/XzWrSo2oMvFj4fpQVfnify+U
	 L/ae0hQy8511XlnCkL94xkG71s+mPd5+5Z1n9PLQO29FfUOE+A4WxgFmf3DIBWrlOt
	 c3ota2Vt9DRBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90272C595C4;
	Thu, 29 Feb 2024 20:40:31 +0000 (UTC)
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
 <170923923153.24686.705472900874013623.git-patchwork-summary@kernel.org>
Date: Thu, 29 Feb 2024 20:40:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v1,1/1] spi: stm32-qspi: Replace of_gpio.h by proper one
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=830840
  Lore link: https://lore.kernel.org/r/20240228194632.3606563-1-andriy.shevchenko@linux.intel.com

Patch: [v1,1/1] spi: oc-tiny: Replace of_gpio.h by proper one
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=830835
  Lore link: https://lore.kernel.org/r/20240228194015.3605928-1-andriy.shevchenko@linux.intel.com

Patch: [v2,1/1] spi: pic32: Replace of_gpio.h by proper one
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=830841
  Lore link: https://lore.kernel.org/r/20240228194818.3606841-1-andriy.shevchenko@linux.intel.com


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



