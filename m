Return-Path: <linux-spi+bounces-11955-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AB8CC49E9
	for <lists+linux-spi@lfdr.de>; Tue, 16 Dec 2025 18:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07A0A30E0C2B
	for <lists+linux-spi@lfdr.de>; Tue, 16 Dec 2025 17:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856D3314D0E;
	Tue, 16 Dec 2025 17:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYw+sJEN"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEA41FF7C7
	for <linux-spi@vger.kernel.org>; Tue, 16 Dec 2025 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765904599; cv=none; b=PBfYjaDP8oiOtq/fQlKh4bHJJSRQPi7KJjnwyqughWPKeJVqsQCoqK3zkO0AB/SmPQyehfQy9XwRbbFXEK+tPQaQXC+9r5Ake3/EqaPydqY5qaW5zAmJQLxuA2WesHVaZjAHXa0iMwrk96NwRcvRNq6WhFi/ZGlGTZ4Ka0xfMOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765904599; c=relaxed/simple;
	bh=6ptsUgvx0CsUW8xwpH1TqiT+UWbyZbX3Umqlq7obeb8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=KWJyvf51BfxgJtiGTi7n9l84+V+NO9hcS8JPdfOGcOZOz0nUCWz0W8TDZCHdAbBGrI7F6n9EBjL4+wnDQbNuyksfikWVQbIcKLnY0FjCQFjS1X5yqyLPQL2mw2LUdnIw7V0eI54XD5+Y6/h6gi8Z3pJXytY/4Jf7ctq0n1fe/1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYw+sJEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB272C4CEF1;
	Tue, 16 Dec 2025 17:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765904598;
	bh=6ptsUgvx0CsUW8xwpH1TqiT+UWbyZbX3Umqlq7obeb8=;
	h=Subject:From:Date:To:From;
	b=VYw+sJENNNLYqWqw8+u/oOK3eqXQV5zmf11kfCF562lS4azdkrFa9t15WuKUgvqZy
	 u4MBPtVbeHhUrr5JUWD/vYknsiLOa+0mWyOE3zim2b8dNN0g4WxUPt4anDB52DQJar
	 9O7tMctOtWG1jtoj+CqA1x9o1DMrTBmOLzH923PEyStyzYvDCdyr1+JhdHUHia4cF0
	 xrqqwRoQgzyhEDpX9xI/frnafiUx3uD8aNesfCo4rTmYQS9G1o7ob6K9xywR3K93fb
	 xM2TdntXp+QrqNy2sEETBDYiH0GRkH0h1cRVkUv2OsRsV8F76eDft+Z093FwlOq8yM
	 8b7xwC97glswg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BBB773808200;
	Tue, 16 Dec 2025 17:00:09 +0000 (UTC)
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
 <176590440833.1202060.4576186691452078540.git-patchwork-summary@kernel.org>
Date: Tue, 16 Dec 2025 17:00:08 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: st: add power-domains on stm32mp2x
  Submitter: Alain Volmat <alain.volmat@foss.st.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1033229
  Lore link: https://lore.kernel.org/r/20251215-stm32-spi-mp2x-dt-updates-v1-0-464a5fd20f13@foss.st.com
    Patches: [1/3] dt-bindings: spi: st,stm32-spi: add 'power-domains' property


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



