Return-Path: <linux-spi+bounces-3786-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A59792A4B1
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jul 2024 16:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 649551C21AFF
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jul 2024 14:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFD61F94A;
	Mon,  8 Jul 2024 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPjobm7h"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1A31C06
	for <linux-spi@vger.kernel.org>; Mon,  8 Jul 2024 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720449062; cv=none; b=e3nMbmds3WL4R2bnpeyHYKBEnpkhXBKfsD70/v7YqN8OAX8MMABON2GpsLZ6A46Hpn1NQ/cJvY3J2bbBnZOFabRoPPRVhUQGGMb5/ECMO18DIarZKkw2PwR4rnbr0hOgO5PbRByG6ZVB1R57WkyC7pxL0CB8Pjn4zlSGm2MRU9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720449062; c=relaxed/simple;
	bh=rMAYhXxDJ1RCEstneCeTj7WESYGv2CNPE+MX/SC1rlg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Wf+0ydB+4Oc3HqSkM0n/4Ywlswqd8NfTH64+S7BseDw236hdBhyY/dzV5KLYGsjB0QVCLCuqv6S7vvLMbuuurGg1+gAReUMEzmADMEqyw72/4bile8xpKJDcMqllTY3Ehsiy3k7zF9NBQx4rtWFZpf8XDuoVLdl0TodPoCIr80M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPjobm7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4AA24C116B1;
	Mon,  8 Jul 2024 14:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720449062;
	bh=rMAYhXxDJ1RCEstneCeTj7WESYGv2CNPE+MX/SC1rlg=;
	h=Subject:From:Date:To:From;
	b=WPjobm7hwHtOiicGpnpdd3md28r2uTXYNg+Q6ksq8QAG9LYSnF9YAqQkQC5593PE4
	 e0lkn1OUl93QzWs7c4Uwn3yChnQtCu9nqY+CUF2M1Ksn4/Rv2AFlJfRLeBjqKrymRO
	 hz8ciy7UEcc5Yt1TGswqd4UG8cfuTg3S9oWUD1PWsaEdJxPYp94IfgBAuQPGyQ4WCp
	 H2DbRnMnbXxipjusDT4UmcOjaLM8jaPAYPunf6IwydiZwr2vCRFarEYM5UTa7wDRRS
	 fX0QO7LzD1jwpRMHKXQF2Xndx70U+KlxrJCpmJepztpbroO10/LDn+4RM99cAyU5oK
	 tAyQXcplZ7kiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3F6FEC433E9;
	Mon,  8 Jul 2024 14:31:02 +0000 (UTC)
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
 <172044906225.22805.16171662853982370535.git-patchwork-summary@kernel.org>
Date: Mon, 08 Jul 2024 14:31:02 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [v2,1/2] spi: dt-bindings: fsl-dspi: add dmas and dma-names properties
  Submitter: Frank Li <Frank.Li@nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=868131
  Lore link: https://lore.kernel.org/r/20240703165931.2325807-1-Frank.Li@nxp.com
    Patches: [v2,1/2] spi: dt-bindings: fsl-dspi: add dmas and dma-names properties
             [v2,2/2] spi: dt-bindings: fsl-dspi: add compatible string 'fsl,lx2160a-dspi'

Patch: spi: spi: Remove unnecessary ‘0’ values from status
  Submitter: Li zeming <zeming@nfschina.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=869140
  Lore link: https://lore.kernel.org/r/20240708041411.14424-1-zeming@nfschina.com

Patch: spi: spi: Remove unnecessary ‘0’ values from rc
  Submitter: Li zeming <zeming@nfschina.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=869138
  Lore link: https://lore.kernel.org/r/20240708035320.14241-1-zeming@nfschina.com


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



