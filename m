Return-Path: <linux-spi+bounces-2786-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA17F8BFCEC
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 14:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87E87B211FC
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 12:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B8E82876;
	Wed,  8 May 2024 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZulwhQH"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7073376F1
	for <linux-spi@vger.kernel.org>; Wed,  8 May 2024 12:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715170228; cv=none; b=AZQkBUjthuNbB+4Nl/kQt7bnFnIdT/c+m1DKcn2sJYE9LhhBCNG5N6gOvZQT1S9Q+dkh4O4kSZi5KXrFN0FyeJMLUSTwR6URVcZ3Yz2wd8d3FeA00BI/KSvvBM7HkCKN+CN9kXyx4Fw34nAbqEkk3+AviOTB0xfOyVehxOroLn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715170228; c=relaxed/simple;
	bh=wLpQL+Kp9Mik6VRgISR8c5b6k9AaKOp3JK6N47ZOgic=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=FtjMaN7zyWvKvOUQ1TtQ9q4AVT1q16hyRooIwpRatXSYwIngaFmyViWDLMld/MVxm1+UK8rvaDdPCNYL5IbM5HZfujTGiFS2uxCrHrZtJEYufHoWiS+pBRoO+F+cMmXJY0eg1gh4bvK/LPlciVgYDySbWieZmDoCm3jIRgu4NNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZulwhQH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67CACC113CC;
	Wed,  8 May 2024 12:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715170227;
	bh=wLpQL+Kp9Mik6VRgISR8c5b6k9AaKOp3JK6N47ZOgic=;
	h=Subject:From:Date:To:From;
	b=jZulwhQHSF/ubHr/i/HoHR3r/vBovRsOlItYWfvhM1O4KTY/qF9GtqnVVERRlG0yU
	 RhTD2tC9D8rU3hJJ347LgnkxiJ0JMSoMfGc4WCrZMVAcveC8FpSHoeAuw3X38PvyaJ
	 +BhrWACj431heJ0oQO6slqrshlyrLOrivm0oexASi+Q35u5pfnX9CAxBQDlNYYaDnN
	 +dqgn6dy3CAjbbG9VaHnm8Vb2GYXpIdRxuRJjfhVVPuu9Q3m9dHKGnfV4Z31jiYIZf
	 noGakKnSwofTbv8W982uUOPu6MDjnViXLoWshtG/zNlNtt7RJ1Rn76gwBkRrqGhW73
	 7wFG2mLaZbzTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4D5BAC3275C;
	Wed,  8 May 2024 12:10:27 +0000 (UTC)
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
 <171517022725.4713.8306827076262153758.git-patchwork-summary@kernel.org>
Date: Wed, 08 May 2024 12:10:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v1,1/1] spi: Remove unneded check for orig_nents
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=851334
  Lore link: https://lore.kernel.org/r/20240507201028.564630-1-andriy.shevchenko@linux.intel.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



