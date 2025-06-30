Return-Path: <linux-spi+bounces-8920-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE55AEE1FE
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 17:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A92693BA63D
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 15:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3B628D843;
	Mon, 30 Jun 2025 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="og6/aR2Q"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55C928C005
	for <linux-spi@vger.kernel.org>; Mon, 30 Jun 2025 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751296180; cv=none; b=ZMSpxMPR9ZGfS8sm/p6ziiISRbi/2oScAINQePPvA7qTBva+kuRrZwYN4iRIyc0h7FncmGObsVpF3Xdf4cKHNEO7PCUxfP32MoSNSqTLvq25P6zaPsLmBxCPPugYsJ8aGWTc7cxrfwUy9DdAd1ZbL9vCAcQT4VIeyn99/ipPVr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751296180; c=relaxed/simple;
	bh=HA6YvZTMVtM1OpTeFs6jlicy1INUIxlNX8zac13574M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=XSd9M8XYqo7C779fM6W2d9NF2OTVjQskG/xDcrPTiTEBSI/ce/NiDOWaOOUjASr9Gwh9xhN071+Pjc18Lov2MnUAmiB5oNVXa8e4GEyHxHsszMdVxDC8honvn1eSJxjVF5qRw83kie2PMUcqddS17alIwIR8AvixxxHvnSc/PX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=og6/aR2Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA05C4CEE3;
	Mon, 30 Jun 2025 15:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751296180;
	bh=HA6YvZTMVtM1OpTeFs6jlicy1INUIxlNX8zac13574M=;
	h=Subject:From:Date:To:From;
	b=og6/aR2QwgjBgy3VmvAiW15xGAyXfMTddvrA+Szttqc9PL5OjrLYo4o+KDGkATre7
	 PUIPv6ThBz2N1dlu4KB7FSjpZLuxA2M1byXgVF4pZPKxtH6VObS5/PHkJ9DNda6j69
	 J/w/N9QHXqDimnyJJ7J49iGPtNR46M1fAFoEC4AfvRabUYKc+fFVVhI/2Tghd6uIgM
	 Pq9gf1FZmy8UMyaQfUdgM5EEWprjbk3KTVYv4orNl1qv4AFYiSBnaFBIWpiLOG5IQh
	 RjB0CmBaxdLmXGvLIiOytrF1UPAGGqqXaKsPnHDLXW1gt9vw5OnS3uFfcK0OVcFvcI
	 W0i3M6hN5nIag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 74A67383BA00;
	Mon, 30 Jun 2025 15:10:06 +0000 (UTC)
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
 <175129620502.3416863.1497366648963126131.git-patchwork-summary@kernel.org>
Date: Mon, 30 Jun 2025 15:10:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v1,for-next] spi: spi-pci1xxxx: enable concurrent DMA read/write across SPI transfers
  Submitter: Thangaraj Samynathan <thangaraj.s@microchip.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=977187
  Lore link: https://lore.kernel.org/r/20250630073233.7356-1-thangaraj.s@microchip.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



