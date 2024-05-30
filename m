Return-Path: <linux-spi+bounces-3143-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5859D8D4BB5
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 14:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FCA61F219A8
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 12:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B321A132108;
	Thu, 30 May 2024 12:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgocsmII"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFAA18309F
	for <linux-spi@vger.kernel.org>; Thu, 30 May 2024 12:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717072231; cv=none; b=f5UXBcrU5euHa1gJshkjtrFGpsUTgzu6w+dXs3wKYc1ekGkvvVRNi4bYWYBeTw3aBDQA/84urk10tlA1qSaLX+FSdDpN58SZNUUBRY2PkWrTsk6BUT4L+dvw5Tlts8RPLJvPeLwT7w1x9HiQeM2Fnz2sH5vTTF6vKEByqC9aWSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717072231; c=relaxed/simple;
	bh=KMs7v+TQvprmJw0rUZFcxLPtIRuftQAFl9xFtv7kE0M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=aelX2w9NJXyUKt3OKP0dAv9R3vMV1VoLSuuxcor/mDFgRvRRyVEEoUdUMaSVXiBWuAGgLkVfzURwZ5CUtYGGiH5iwuTMxymqxsAUoW7Ql4rvecf/HQAMRn5DPxVX+2OKKpGmnacPZ1E8amC1dUhI9c039FeUCvSViN+kdpohdcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgocsmII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16909C2BBFC;
	Thu, 30 May 2024 12:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717072231;
	bh=KMs7v+TQvprmJw0rUZFcxLPtIRuftQAFl9xFtv7kE0M=;
	h=Subject:From:Date:To:From;
	b=lgocsmIIUoNAeyozrDOuEeBw3cy6sa/gWD47t21usbSqfTr7bXcYC0qizpOG9WEzW
	 eUx8U7Qg65JB/aik4Ly6MlGFdF//69Bkd0tsTaAdC/1910Mh4ovPnYUv1k73Cu4fVG
	 Bqq6WNF20P0ejOC75mXzwRq0NVdDZe2L2Zm5+M08eJNXN2jmHPMLUsc60t4B9gGX7E
	 rS4buQn3sKopKP91NM8fCrwhCGExnMRd9in776FRSZTb2vfxTVuX3L29rOzN75CI5V
	 3yUuQDrHOJYYAiuawXcaOm5luqBBU81mHmi0Q1vc4jHvFmqhPd77IyWPXcs2leAdJU
	 VBEzK2ZKz54uQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF00CCF21F3;
	Thu, 30 May 2024 12:30:30 +0000 (UTC)
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
 <171707223092.18764.1552119134660979853.git-patchwork-summary@kernel.org>
Date: Thu, 30 May 2024 12:30:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: stm32: Don't warn about spurious interrupts
  Submitter: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=854691
  Lore link: https://lore.kernel.org/r/20240521105241.62400-2-u.kleine-koenig@pengutronix.de


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



