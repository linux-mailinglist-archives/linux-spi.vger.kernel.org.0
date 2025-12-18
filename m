Return-Path: <linux-spi+bounces-11997-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF33CCAB5F
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 08:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F29733006A98
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 07:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574EC3A1E6E;
	Thu, 18 Dec 2025 07:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyyBMST6"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332443BB40
	for <linux-spi@vger.kernel.org>; Thu, 18 Dec 2025 07:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766043795; cv=none; b=B67e4EEbmMbp2KGsf+hqioVbpMhbY5WMJpZ+QBDQyAyGxblXgZ8uv2IZJEGTrqskOTketlFCcZEKAjMuOD34To4vS3nx4s3fSd70d4z4d5qeChS+oPvdnT3YrYCVn/30IAhlm4h61B9SQFu/nBlSNdCTx5/znCn754j+ukcDrvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766043795; c=relaxed/simple;
	bh=yEDIs/fXlsIDThMuaKWBDflHhq88pEg28ci+Y6KaTb8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=DN8Enokfd48TT9tMr6wAJ1uoyFxHLIg1ama+xbALyUikVZSufCYmjR7HybweEt4AGs7JI4PQnOgNxvSfpUxwTeeO2D0nz6wp7fX0YnY01X6DlakXizJnbD7m1EZDcZBiOhYfPtT4Mvnyp+vY6RS51XRepgpJb9DOlFg/zS0chqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyyBMST6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9BCC4CEFB;
	Thu, 18 Dec 2025 07:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766043795;
	bh=yEDIs/fXlsIDThMuaKWBDflHhq88pEg28ci+Y6KaTb8=;
	h=Subject:From:Date:To:From;
	b=DyyBMST6kj3LuqSpxJj8ocZBV00+66mWXv58h4P9Ac4024KgNMwdGo/QUrw4pM/3D
	 ac5/c4L42Ba768J4Wx5PDmvhLXuMCRJ/L+gIemGAAR5Xau9jU9QOjTBON+g88gxzfN
	 iGG+3s/GZ0C4QI4ZzTp4s26yF6BMCNZ3SHeoPk3B/kpWu7Kezrz0NSLfPr3L1juMTI
	 Cqz4LYVlc5fHxagsBvmN65fsgnFck+0hmNPvgv6KYLMvPAx9Yt0A1wEQ+YiUKQZjRU
	 aHbufkCr+DIq+8Bjo6HXbiw+nzG0oygSkfMDg10v3RjPCJZoGtmVmVeqqBX6cSZ3TM
	 zK9FGnzFq9ncw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA3FE3809A88;
	Thu, 18 Dec 2025 07:40:05 +0000 (UTC)
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
 <176604360429.2430573.13574103253354370396.git-patchwork-summary@kernel.org>
Date: Thu, 18 Dec 2025 07:40:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: mt65xx: Use IRQF_ONESHOT with threaded IRQ
  Submitter: Fei Shao <fshao@chromium.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1034123
  Lore link: https://lore.kernel.org/r/20251217101131.1975131-1-fshao@chromium.org

Patch: spi: dt-bindings: snps,dw-abp-ssi: Allow up to 16 chip-selects
  Submitter: Rob Herring <robh@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1033508
  Lore link: https://lore.kernel.org/r/20251215230323.3634112-1-robh@kernel.org


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



