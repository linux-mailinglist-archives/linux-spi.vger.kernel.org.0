Return-Path: <linux-spi+bounces-12002-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BC3CCAEE1
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 09:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9ABAE3019B72
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 08:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F017A29D280;
	Thu, 18 Dec 2025 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjZk+DRz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA5A2147FB
	for <linux-spi@vger.kernel.org>; Thu, 18 Dec 2025 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766046200; cv=none; b=oUSWm9xTnWgoS8eGXPFmXWheNRIwgzg5BnEjWecImzSqRdRnkT8xx24ivbokotGX9aQQpX0YK0dJlT6nZsIQWVOB2fTcvfDjaDG+wCvq7aYH9lcfttOQAcZbnJbNHoI0Xnw6qVDyPt0xZsB8cFdS+g07KMx14Io6GFAoH4y+p+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766046200; c=relaxed/simple;
	bh=Vng7/cmEZwjKVRZ01cdTN9i78YrRRSHO/J+G6G3J57U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=VcKafO7P6JUBEZOxd+Ar5l3KkvN3ZDp/KxpQm1TgP988CmMdAMbp9w0hRPAIh1S5v8unAYwJb+DeJjIzkAdqt7tr91Hk1qoapUw9k/chi0w5iWL16H8RZG8a9u8JDsqN17cBmArntnCEnD8Vr6wF5wE9AqF8fmI2HtV6KIDYYBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjZk+DRz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF00C4CEFB;
	Thu, 18 Dec 2025 08:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766046200;
	bh=Vng7/cmEZwjKVRZ01cdTN9i78YrRRSHO/J+G6G3J57U=;
	h=Subject:From:Date:To:From;
	b=qjZk+DRzjSg0d+epToNXtDmcsyK6lWUJCNT2SrqSFzwLHdk218pj4baDyC1yr/2ZR
	 Hhp0V7M/EQhfGbbIi/TpYtsUXhggnkPN2TXpLftD8cThbF3NLei/LGONtWelPXvHQX
	 1IWpF/LEcGWeXpwxvUF0Eah8DV9ZBE8hdLdbI0iZ3WCXcDgl7OELDLOYLFaxjCk1FX
	 kTM56nq4hBEvauV2a/2Bo6RrT6qEaXgK6dBTJF4HV3wAP7dLbD1AA6QN47NYH4iDLY
	 JVEe/jHQF1YA9Ne/xorqgbuo9Oc8vo9iiSjsdQazKZ2T715ijqhNVWIgJoGYXuEZYt
	 QTz/AgLXZiP5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0318C3809A8E;
	Thu, 18 Dec 2025 08:20:11 +0000 (UTC)
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
 <176604600944.2446289.10420653928348349884.git-patchwork-summary@kernel.org>
Date: Thu, 18 Dec 2025 08:20:09 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: stm32-ospi: Remove unneeded semicolon
  Submitter: Chen Ni <nichen@iscas.ac.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1033601
  Lore link: https://lore.kernel.org/r/20251216043210.1521722-1-nichen@iscas.ac.cn

Patch: spi: stm32-qspi: Remove unneeded semicolon
  Submitter: Chen Ni <nichen@iscas.ac.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1033976
  Lore link: https://lore.kernel.org/r/20251217023721.1684244-1-nichen@iscas.ac.cn


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



