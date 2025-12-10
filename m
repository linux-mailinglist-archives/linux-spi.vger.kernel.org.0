Return-Path: <linux-spi+bounces-11846-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DE0CB29E9
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 11:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B485F300658E
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 10:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6FF307486;
	Wed, 10 Dec 2025 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oL2qyril"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3928E306B30
	for <linux-spi@vger.kernel.org>; Wed, 10 Dec 2025 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765360805; cv=none; b=JgeUhS8qwvH48Mg7B0mPV7+fzH1Q18qt1gEtzdauarcN1J8vgn+TBFlNW6PBl16h8MiloAoTffUpVz5POnAlR67ot0D6mBXSiYHl9DjlEsvXMf2ESDFLNgT1aLquLpX85eaN3BWCnAQ4fw1063CWy5P9yfVcFLwHDzizmmxnCGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765360805; c=relaxed/simple;
	bh=UK/6m006gJHq6AJpgu2bTnvsl5PpmzOvolIivvo+7jg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Z8G2t9+xlCDQUQcM2II6On+ZZqPEpDbRSDoEiTzLd+XeRJFl2gqfEPi/03OfHNLVxxyNsXOS4dLsHbpRJGNH9mrjzm3soz5zlO0q3ViTvnnSNNCBQv3sgM4RWvlpNLpji/3JbWNDgfZIqqtRtUwGrpkkxBKN5GWvEUbTUQyX2Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oL2qyril; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4636C4CEF1;
	Wed, 10 Dec 2025 10:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765360804;
	bh=UK/6m006gJHq6AJpgu2bTnvsl5PpmzOvolIivvo+7jg=;
	h=Subject:From:Date:To:From;
	b=oL2qyrilrCdhiMbH7dr65liyrhwrlUmadRsxYdnEb5JKQ3oJv7Ynp7l/+Zq13m7mk
	 rGQWOuct1Pq4DjlqSpHk4h/lzppQdgP18vbaNe+H41a2TtOugmk5FuqCra1EPDSn1o
	 lXP17WTVf5p+hkq24XVXKqc+AXn/YnVxAgQNq9rApDhwHkbl5V9I6ZT5p0Fkq3wxgr
	 4dWjPqXfJwcCXUyonAZN0kSR6vI28mXR2GeXj7O8y7XmcU+Q2p13y9ba0VsZ2m5NmR
	 7lCfcBIwQszRQ756GGISRHd7uNvPAWOyAHTDVGZ1hL0agmgkc9hg/MesM0GC9qdgtF
	 XjahvaYlZR2mw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8070A3809A18;
	Wed, 10 Dec 2025 09:57:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <176536061907.535139.12497752861124927.git-patchwork-housekeeping@kernel.org>
Date: Wed, 10 Dec 2025 09:56:59 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: atcspi200: Add support for Andes ATCSPI200 SPI controller (2025-12-10T09:04:29)
  Superseding: [v1] spi: atcspi200: Add support for Andes ATCSPI200 SPI controller (2025-11-12T03:47:23):
    [1/2] dt-bindings: spi: Add support for ATCSPI200 SPI controller
    [2/2] spi: atcspi200: Add ATCSPI200 SPI driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


