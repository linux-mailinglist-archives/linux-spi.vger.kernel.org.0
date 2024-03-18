Return-Path: <linux-spi+bounces-1879-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAA787EED4
	for <lists+linux-spi@lfdr.de>; Mon, 18 Mar 2024 18:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BA1A1C220B8
	for <lists+linux-spi@lfdr.de>; Mon, 18 Mar 2024 17:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E282C54BD5;
	Mon, 18 Mar 2024 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5YkoSHe"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE15B55784
	for <linux-spi@vger.kernel.org>; Mon, 18 Mar 2024 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710783028; cv=none; b=EF+4DCUC9q/zJcroLJrlDj4sxC0Vr6KIH5CHl4bFEznufWmkHetAnEJP0ozAk8v8YVAYqo+JG5qXwSKstwJTLf5dBJZ0rrEUmK/TTFxfrtInf1Gk70C4s+Gu8kUQykEC43/2En3cvox8A3UaCaYRqpstRg+Binwg9GZr8AdYnqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710783028; c=relaxed/simple;
	bh=ta5/UrlXPbSIln+38FPT/3NxOy2NLoIy7OdrQAefofA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=amby/JgHtYX8P/rx0rA4V06PDFAFYdR7YMCqnJ5nRwg1H8xCnCUAJl1H+q68wJiSnTILjuAyRDMV+JiwihMDVpmI85Ym/0aNBXq3ljyNkIGpBAQ+QazaCYH+6ZClnNl4jMU+wagvIwja+IkbdiGUSawLNeO1bsd8NlXjbOoHVwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5YkoSHe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5101AC433F1;
	Mon, 18 Mar 2024 17:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710783028;
	bh=ta5/UrlXPbSIln+38FPT/3NxOy2NLoIy7OdrQAefofA=;
	h=Subject:From:Date:To:From;
	b=q5YkoSHefXWKQSfiLIg0wu9caNSFxrvgUJunEs9I10MeEzj5orIoDOTtH0+lijfHH
	 Y6kh7BVzS3LF3Q2+R7vp+GdgLj/+ja9FsIwc3M0hssJhv/cTL2KJyaDtfSsJ8IZpDM
	 aq3DmCgYHsQppovFtRPbWdbt84lS2YliKKilUPk6EeIzg4+s1Q9SUt6aIN3IyEdaGP
	 gGax0TWvL0l05InnJijpYeSPOYxhOpaoDCjYBMBNWDJ0zqyqo9LoaUcJGKk3nnc2R0
	 Nz0rls5APauVmxrHX6Aj86Y6XnbOjD85Rmq9whsY6RKW9659bn9NoZau3MBCJTDa7G
	 Yb+/oxaD2vZnQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A101C04E24;
	Mon, 18 Mar 2024 17:30:28 +0000 (UTC)
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
 <171078302818.31733.1012620383081685243.git-patchwork-summary@kernel.org>
Date: Mon, 18 Mar 2024 17:30:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [v2,1/2] spi: lm70llp: fix links in doc and comments
  Submitter: Kousik Sanagavarapu <five231003@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=836118
  Lore link: https://lore.kernel.org/r/20240318154540.90613-2-five231003@gmail.com
    Patches: [v2,1/2] spi: lm70llp: fix links in doc and comments


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



