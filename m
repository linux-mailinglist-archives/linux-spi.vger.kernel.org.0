Return-Path: <linux-spi+bounces-1368-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7755B856A90
	for <lists+linux-spi@lfdr.de>; Thu, 15 Feb 2024 18:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C115B27437
	for <lists+linux-spi@lfdr.de>; Thu, 15 Feb 2024 17:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D34131731;
	Thu, 15 Feb 2024 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjHCtu1t"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8CE136663
	for <linux-spi@vger.kernel.org>; Thu, 15 Feb 2024 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016431; cv=none; b=GZTv0Qha/b/VdIm9kbDESyJTxl/cr/5Z0xd+JFM3fhO+vXLmvKEQh0lxUIquGDndKIHeRy2yE2jbLOF4MyZU+RTH0DEIUUXPzFOohYSh6cGfHdr7mp5ccXlrQ3DMbmB5L3wFHUCvITDbXJko4AHwdRiFB44ZYCtoFkGx2t/q6IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016431; c=relaxed/simple;
	bh=+c+bioUNInlg7JMgyBgFa10jECoS0j4yctQmY/3XfH4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=WnnsUmvfuGdurjkA1xLzIwv6zuEHSCfyQ7s9vqLeT96bzLgoZZWylc2iSZN5eB7M8x3zVSXePdSMNSDSqnyBVHWjQh0QuTXhU4lvoLP8TipUDPa08GcPVPFW04utrTh1SNYkDLEVk0IqR76Cce4zfCNVFbYinbPRI5I806kdOds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjHCtu1t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A8B5C433C7;
	Thu, 15 Feb 2024 17:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708016430;
	bh=+c+bioUNInlg7JMgyBgFa10jECoS0j4yctQmY/3XfH4=;
	h=Subject:From:Date:To:From;
	b=DjHCtu1tXt8vY4h5km2ZJMQFuv2VjtbBBm8SDgMqbkfKAOyQW4rjHymfst+M1i+Bt
	 rQ5je/6MSt5Estia4Z3G9eRN4lWzLXd4sxkX4us0IIjCYUufkbVMzyNKbaU0tnjnPO
	 WIU3SQ2EkUtPOgmrz3ojqFhZWexWaMi7hdt9PUfj1ssLTCC83wfqQW0CFdMnSkCTlJ
	 /aFunWnnDgGWfpn7rTToU6QqKQPBzRD/JE4SV2EvPYvTptnR74Vsg8HEdsRl19WSf0
	 X6L66qTVcfsDG1AzpFZMtUKHA/Elyit+550VxivUfSE3tlycMx8se3hzKklwoqg8Ny
	 KX+YPvRc/MEKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 696EED8C978;
	Thu, 15 Feb 2024 17:00:30 +0000 (UTC)
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
 <170801643035.15803.10067092312143025474.git-patchwork-summary@kernel.org>
Date: Thu, 15 Feb 2024 17:00:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: Documentation: spi: Update the "master/slave" terminology
  Submitter: Dhruva Gole <d-gole@ti.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=826262
  Lore link: https://lore.kernel.org/r/20240215085404.1711976-1-d-gole@ti.com

Patch: [next] spi: dw: remove redundant assignment to variable len
  Submitter: Colin Ian King <colin.i.king@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=826379
  Lore link: https://lore.kernel.org/r/20240215131603.2062332-1-colin.i.king@gmail.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



