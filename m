Return-Path: <linux-spi+bounces-7095-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD2CA5DD12
	for <lists+linux-spi@lfdr.de>; Wed, 12 Mar 2025 13:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBE69189C28B
	for <lists+linux-spi@lfdr.de>; Wed, 12 Mar 2025 12:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D702356D8;
	Wed, 12 Mar 2025 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2lGFoEx"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBAE7083C
	for <linux-spi@vger.kernel.org>; Wed, 12 Mar 2025 12:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783799; cv=none; b=A3NevQK5NWf8x0hSb8FKU7iTyDKCIN8a0Udw/0OQXDoAaNOQx8DZ3N7iKSEpUQrcv2ym9O2O6lMZCmzr25RIz3Qq+xn39XIR3KodT9P+5WotEm0wgyaz8QZ8yNmPmufPAFeW6rb+SMubH7ul1PGDQodgbYzQ56istqGJFfzMHh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783799; c=relaxed/simple;
	bh=SFjJtinrKB55d4Y0AKebfbXv8fj7dDAcOx1dHQ75yLI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=kp0P476eamWtiScwUD7fgFHZ8RNwSJ6nVj57++ay33xc79cOGzM4eDNE5jKjLV76J5iY9zIPoKqTJrSykjJ6JzzNw9QE6OOwhQTCQ0dBsBOqFd7ClWHAPaLvR0eRGrpmbbXv8sPtWuk7r81hhdYKJ83d59rO40Y2dj2spyyTigA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2lGFoEx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810ADC4CEE3;
	Wed, 12 Mar 2025 12:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741783798;
	bh=SFjJtinrKB55d4Y0AKebfbXv8fj7dDAcOx1dHQ75yLI=;
	h=Subject:From:Date:To:From;
	b=h2lGFoExAYJlR0tMJ1Xw67HyyJ38lEOsXqolj5y92MyR/lCBJjIj0voRkIJ8LRRAQ
	 r5QvYU4KUGJezxOJ55K7WjQBon16/6fiR9+Znxk9HpdyaWg9EPq+dw481t5rFbjtnq
	 qzNEkdEeNGLC4zUX+bzeu2Gcg6qhj6Z6qj8DYoQ6tNTxbXltAE0Xart/3WXMCMMADj
	 EE6NNdRacFrUWY78n5/wG3y1ksRu0XQpefd+PbNRU2dlAGfnd3e05t4uLiXuK3qY93
	 48HRriag16Ggd6gIM99Or3jFXaKE2ZzNxEm5rHXGr4kl5Zdmg6/tF04+dGXuj9M7sy
	 WQpavmK8h3+tQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EF48B3806647;
	Wed, 12 Mar 2025 12:50:33 +0000 (UTC)
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
 <174178383245.457727.8166478450394430894.git-patchwork-summary@kernel.org>
Date: Wed, 12 Mar 2025 12:50:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: sophgo: add Sophgo SPI NOR controller driver
  Submitter: Longbin Li <looong.bin@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=939926
  Lore link: https://lore.kernel.org/r/20250304083548.10101-1-looong.bin@gmail.com
    Patches: [v2,1/2] dt-bindings: spi: add SG2044 SPI NOR controller driver


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



