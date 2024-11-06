Return-Path: <linux-spi+bounces-5642-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6168A9BF831
	for <lists+linux-spi@lfdr.de>; Wed,  6 Nov 2024 21:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06A59B22DCF
	for <lists+linux-spi@lfdr.de>; Wed,  6 Nov 2024 20:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E131D318F;
	Wed,  6 Nov 2024 20:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMxubyhg"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2920214F9D9
	for <linux-spi@vger.kernel.org>; Wed,  6 Nov 2024 20:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730926221; cv=none; b=rpvhwsUVRSPnPrJ8LkMlIJiIXI32sao5hkzfYKJ2GFhEm8hAOCnj9iLLIYftAiWKOFKhaRJVDvzAIkkngTdxlEbMfeGxZw6iVaEZDZvl6tbMDhOmsBeocafj2iM1PCG5lGAKX27g3iXIKS92XOHwp2Ds7Y5nJUUcbWHFYB32gDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730926221; c=relaxed/simple;
	bh=oZpeCwbrbYyEs3pcDC3bLohIgpkC4Y/JN3lCrxMJ/Rk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=UtLC/VHvxXs9AdnRmlZ7trOV0A+y0wwqM9LF9Xyr8j6cWvpz/hSu95RLH8yRyjUadsAqCYKR+kVNPpR428GD0OrRXL094uTbG3ui+rZA0d0DuQYOVBkfmAMqfcmp+t6KM7t2YqSDh/M/mAY56ow4AQxsqcqA5dWW5lVlBw/S+Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMxubyhg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13A7C4CEC6;
	Wed,  6 Nov 2024 20:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730926220;
	bh=oZpeCwbrbYyEs3pcDC3bLohIgpkC4Y/JN3lCrxMJ/Rk=;
	h=Subject:From:Date:To:From;
	b=JMxubyhgDF9PHpTuw0qaH8UsGNz9y/X2AfbEap9iK8QrQxaC3mP1JjndT5g6xp0Io
	 FfK7dPIMOeAijRcQdDrf43i/G9flyYd1cAGda0GGSYvfQ36zLuR4z0EDXua1+G5ki1
	 XSNG9z/FTN5sT58IwjIGcd74K0dXn5xQc6sM/H5xBEJiMNwbxwnk0tt6GNWZ+vCz4x
	 GqqdIp2D/YrkvuflxEu66f1QTDQMWLi54wVpivMfX3TjlEPx7tsiKoL0N0ih96XdJV
	 hKtTODXaRLrxHlSTwEPhioFQLaT3Jm3ZVCOUVVJjYIwWgiVCmSbwfxn2yiRdeSSmPN
	 NFYaFx8LeH/aQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4DB73809A80;
	Wed,  6 Nov 2024 20:50:30 +0000 (UTC)
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
 <173092622921.1415888.1648346347611330150.git-patchwork-summary@kernel.org>
Date: Wed, 06 Nov 2024 20:50:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Apple SPI controller driver
  Submitter: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=906781
  Lore link: https://lore.kernel.org/r/20241106-asahi-spi-v5-0-e81a4f3a8e19@jannau.net
    Patches: [v5,1/3] spi: dt-bindings: apple,spi: Add binding for Apple SPI controllers
             [v5,2/3] spi: apple: Add driver for Apple SPI controller


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



