Return-Path: <linux-spi+bounces-2417-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 077288A903D
	for <lists+linux-spi@lfdr.de>; Thu, 18 Apr 2024 03:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD60282F97
	for <lists+linux-spi@lfdr.de>; Thu, 18 Apr 2024 01:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB3153AC;
	Thu, 18 Apr 2024 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckctsExm"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5459279E1
	for <linux-spi@vger.kernel.org>; Thu, 18 Apr 2024 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713402029; cv=none; b=c2AxRV0qvjqCY6FIA/hprgMPleUy5jD5dZl5Lsy4FMtzYnPOVPiomkO0qfno7/oC/I/ReVcHdcZoGwJE6lV84hiNBsUJFl3XTwaAKseCtSmnXJxhpbBwM8GgqpDmnDbnKrSslcqNttUbmKm94HnIo26dnFyO33oWa6HPuv/rurE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713402029; c=relaxed/simple;
	bh=tGZm3oT5oKmWqeMmt9ra1MEP8qY+VxfOK88KD5v/CNo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=EbM6VS4YRYvxTWLnkNVfg08HuJu2k8EkgNoPDnrNXXR3QeVNFTDXVRvUw6radSEG0uXZrzbGX+d1WEEoTy/lY29zqr1VwB0aTjqp0MyogoF4ZB8Z1BXGkU8kmJDcbbLz8MQJ5JRC0rnIltBjuteB2JMyMmDawutzRYeFTbBUig0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckctsExm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9FC1C072AA;
	Thu, 18 Apr 2024 01:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713402028;
	bh=tGZm3oT5oKmWqeMmt9ra1MEP8qY+VxfOK88KD5v/CNo=;
	h=Subject:From:Date:To:From;
	b=ckctsExmvhANIONzzKpsvBw6+WB0+Yz9+gWDekBREc8pHOPF8Caq4COXtYuCD0C+F
	 msitmF2K1nvRwKcrhnuPvzYAj01mzsf1nqln7l9LTlENcOIU3tOlmYxBzLbKlBxhZL
	 JINqqCg7zX8h4IvfirGEnN2WZFZKAi0Wl+l4zy5OUvkqNhuaAjzuerzP3kV1ft3Qem
	 56Vt2+F7mPrLnhMcw6A9cXjvhz7Uy+AT3in3VDtm7jd/yqLB4NvJK6R6rhLd+5Q/ab
	 UkrHNpor1GnSgchkQDLZaFAn9piFffGymiy1PG2iSsEuwn9XwmYeskqc0hY5cB1Pnv
	 4o6M3n+AyMQ3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0FAFC43616;
	Thu, 18 Apr 2024 01:00:28 +0000 (UTC)
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
 <171340202866.6924.524387137729817463.git-patchwork-summary@kernel.org>
Date: Thu, 18 Apr 2024 01:00:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [resend,v1,1/1] spi: oc-tiny: Remove unused of_gpio.h
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=845400
  Lore link: https://lore.kernel.org/r/20240417104730.2510856-1-andriy.shevchenko@linux.intel.com

Patch: spi: cs42l43: Use devm_add_action_or_reset()
  Submitter: Charles Keepax <ckeepax@opensource.cirrus.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=845378
  Lore link: https://lore.kernel.org/r/20240417093026.79396-1-ckeepax@opensource.cirrus.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



