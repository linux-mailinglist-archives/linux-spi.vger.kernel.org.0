Return-Path: <linux-spi+bounces-5838-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB439D8B77
	for <lists+linux-spi@lfdr.de>; Mon, 25 Nov 2024 18:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC6D9B28CA2
	for <lists+linux-spi@lfdr.de>; Mon, 25 Nov 2024 17:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70F514D43D;
	Mon, 25 Nov 2024 17:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltYKAe9m"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FFA1B4F2B
	for <linux-spi@vger.kernel.org>; Mon, 25 Nov 2024 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732556419; cv=none; b=gb2T9irOeflJ60c31o0ybsMuNdURXbtJ0OCf3U1oxhAmZhcuQk+BxwhpIbqSs3qSbphTx5gMBmFy0jrGwgpP3fTchypMPpTMhLYDQkG7Z+xS7vVapiilyF7pLJHV5ZYNA9aZbLwiJS3P//WdEqOBz/kMBV4QEVsw1xy09ehFX0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732556419; c=relaxed/simple;
	bh=G98sI1hHBvvf1SOuTsnXXxFlyMQztIppeqswspF2koE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=WaJttRDsGDf948R59snROcH2VCOiLkZqNG8LtzRbxsF9tcW7b23FhIpQq+zB4YWOSdB/cBFZhPLdnBx/tNzad6/JCirLdoTA8e0f0HfKC6JYeAsjxWWz2xuDsKQL6wfMpFXc4VggsOvRpAaO680iAVwcHgyQFA6XrxVTbPTlGpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltYKAe9m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06676C4CECE;
	Mon, 25 Nov 2024 17:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732556417;
	bh=G98sI1hHBvvf1SOuTsnXXxFlyMQztIppeqswspF2koE=;
	h=Subject:From:Date:To:From;
	b=ltYKAe9m9Ms1stLAQxytaHhGmV0U1fbVAWJu7snl2m3mSRpLzF1VwBvjjscdjE6/+
	 2cq8PbzfwKFFycvFd1frwJgy51nPa30NX4cz+65LUVB+NHV/2kMOyICfuAbO1dJ6FF
	 I42txw0yIhkkomZNyYTXoFoD0+lY7T2BuA73KOR9gIpiQoM/mhfbQIPa2ol0clhYWN
	 xrSCvnf6mcqew0y8uVlFG9IEx3DIA3PRWFjl89FjN7wZqzg3/97Rdf5Y7N4U0iBONo
	 9LSr5D+0wpssQWPSXzf9LIr0152VYgNwn8n2lgHACMshw5kojcqEnaYvGPeeV308ax
	 iQveFT7YhG8LQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B94263809A00;
	Mon, 25 Nov 2024 17:40:30 +0000 (UTC)
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
 <173255642925.3980917.3690781881381608468.git-patchwork-summary@kernel.org>
Date: Mon, 25 Nov 2024 17:40:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: Fix acpi deferred irq probe
  Submitter: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=911737
  Lore link: https://lore.kernel.org/r/20241122094224.226773-1-stanislaw.gruszka@linux.intel.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



