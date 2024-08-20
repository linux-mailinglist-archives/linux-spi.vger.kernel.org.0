Return-Path: <linux-spi+bounces-4258-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C13599587FA
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 15:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC7D283901
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 13:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CEF10A24;
	Tue, 20 Aug 2024 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sq7mQx6Y"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D67018A6CD
	for <linux-spi@vger.kernel.org>; Tue, 20 Aug 2024 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724160643; cv=none; b=dFyhufKn5u5Xo5kah+4b9Zc9tJSEED0EbAUnhhfsmdMUgJi7/5SFK5bapaTl5k0oIyO6v3XPFRsiqRpNBJBrYEBHLQnIMUkCsZKKVeGonRgUkhDJTIVec+0c6o9DJDl9Vc9YuKCgvBOVEcys9pxhRjeBv48cgIDwlnIj7hAQvBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724160643; c=relaxed/simple;
	bh=84ggK2EvsRII1MAXF3iOGfhKIPzCORTPkHN7NICvKcg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=VPOEaNTJhei5AYUScXjJZ0Z0vbg7nurxX7cfU8qjT5H+6mG/vlfIf7KsoLnDGSAzvcwIDXSwmBQ5H53JH+nEv4t3OHtK+o7BbflrV1Vyg6IOr3i5l5fDvBd5Dl8r434j+27QtLUk51TeJDXqQ+1BPpY6R64f3AwqRjxMjIrmpRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sq7mQx6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20961C4AF10;
	Tue, 20 Aug 2024 13:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724160643;
	bh=84ggK2EvsRII1MAXF3iOGfhKIPzCORTPkHN7NICvKcg=;
	h=Subject:From:Date:To:From;
	b=Sq7mQx6Y6lBFkAqDVQH+C2Jm+CM+kXbkRe9eb/MIhMECdBvn1nwynv9DKRyJp317r
	 VKuepp3/mcqrcABlhCokQA68nWpgsEVF+48uyLbcKSA/2VkHw+gLFNonygSuE4xpC9
	 8nksaXmPM39j/878X/48D4nYwt08qXlAp1onoU7meZ1S4nziiHmf+9RLTw4dt0h7JF
	 DIllIOVRWGvdv+HQ+KkMZpUrh7ydodGvA6gLZ/OZVD63ag2OLLb3RwSIc+V0xJEFHK
	 HSRpIInlMjdhN/uUSujHZZsVHK1bjJU0GI+dcl87inD9hY2ohUUd4Uf9t9ApvbsCW7
	 r1kQyc1ArwBCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B1A843804CA6;
	Tue, 20 Aug 2024 13:30:43 +0000 (UTC)
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
 <172416064230.1140908.2267156641420105988.git-patchwork-summary@kernel.org>
Date: Tue, 20 Aug 2024 13:30:42 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spi-fsl-lpspi: limit PRESCALE bit in TCR register
  Submitter: Carlos Song <carlos.song@nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=881182
  Lore link: https://lore.kernel.org/r/20240820070658.672127-1-carlos.song@nxp.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



