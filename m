Return-Path: <linux-spi+bounces-7139-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7DFA600F0
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 20:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 474463B958F
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 19:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EB5190477;
	Thu, 13 Mar 2025 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plxdu2z6"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA8578C9C
	for <linux-spi@vger.kernel.org>; Thu, 13 Mar 2025 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741893601; cv=none; b=jmWRjH9cpr6s05fKI0FpIp7o1VKBKil3LYrEYWWVi9QQ+OY1wdLGwc7gN+WJnL5Ue1I8/8l3nrelFCBfR60MsZnhgrLn3ZI7+ZUydgzGSnODeoW7vb6fdAr/OGQCpURuZf2x5CeiXZmZbjeufTfnK0cfjC5X3+ofZ4bQz2Ushwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741893601; c=relaxed/simple;
	bh=sH03cGy3v292oSVy3shX9/OpZuDfCJ7J1UwBHUsogfY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=SvxaDeJZgEJfYOS6Meal+UybmIuLiw2fBM4Zv8X+SX78+OC/M26qnho9MaaHnQuyRVePw3OLQD4Fv6X2xl6+frNrjzXTSE5ghJIuhl8NcIirjkP1p84+UrvmmxvInJUxcKn170wpT0HLoSo7b6bQEdEGOuiTL3zxeZ0Whsuk1AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plxdu2z6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6611C4CEDD;
	Thu, 13 Mar 2025 19:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741893600;
	bh=sH03cGy3v292oSVy3shX9/OpZuDfCJ7J1UwBHUsogfY=;
	h=Subject:From:Date:To:From;
	b=plxdu2z6bn6FYbQj/Lw9afQTiiVfFQetwoxxTAh02bZnFNPOi8/9/hxjSp8Z4hAnR
	 KM/sSFFbihvghApk1azcmELOk18itpTCUdHBojcPakFTKYbCUSqXyPByXUUijvbOLt
	 6Q+PtP1ZaMUBZPSxzXHQ+PwYQSU7tFVpv00QZUa4t8nb0pChUPJ/LMEdmpZB3YYkwQ
	 oZjvN1UpsPc//RFyRTxClPmKfmYipE+g8a9dt+dMaFzn/fqrJ4laOVRYO9rgYaZM5B
	 NO3D6PWrQw0oDW9+B2Vj0zuDNi03NJWQgrgD+ytLBgZtBNA8dBkDNSnQsElnEJmEpy
	 67lGN/vk92TNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE27E3806651;
	Thu, 13 Mar 2025 19:20:36 +0000 (UTC)
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
 <174189363532.1637470.15259117304797929086.git-patchwork-summary@kernel.org>
Date: Thu, 13 Mar 2025 19:20:35 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2,1/1] spi: Use inclusive language
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=943551
  Lore link: https://lore.kernel.org/r/20250313140340.380359-1-andriy.shevchenko@linux.intel.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



