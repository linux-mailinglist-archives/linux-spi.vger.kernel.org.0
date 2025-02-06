Return-Path: <linux-spi+bounces-6643-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7588EA2AABF
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2025 15:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9CC18887A3
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2025 14:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B111C6FF0;
	Thu,  6 Feb 2025 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJ6lReiW"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915FD1624C3
	for <linux-spi@vger.kernel.org>; Thu,  6 Feb 2025 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738851005; cv=none; b=U9pzmJAnCF+9BFAmwy4i13MpuP/ohbQXevWCrat6okrNl+6UL5jiRGS7tRHjBF7LLltD6BKAWQSImou7XaKo9R5V8yaMK4KCzgQKbbAHK33bw0nVfRAU4y3oLiszg+ljgb/Lz46+U+HqXXLexUHR/sz2OMdL+Gfa8ODNp/9wQYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738851005; c=relaxed/simple;
	bh=Eg01w1rdWyWWu+gVbX0EfMxsLwMCW4gYllQ0wmgz4pI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=RPD3mlQ4whI86VLGiwY/rsYSSYcM4bTYDjvADyOgSbjco+2dXzrDO4EanCSfC1pevQ74BOHqM60k7DMgFvUJAj73weR4hShKo0rVKquoD3PeoZy4Ab230XuIJn5jWYgqx8tjaEBVKZ4d5/UzBuEnbnx7ByOMMYRRG4jXVAMQf/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJ6lReiW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BF5C4CEDD;
	Thu,  6 Feb 2025 14:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738851005;
	bh=Eg01w1rdWyWWu+gVbX0EfMxsLwMCW4gYllQ0wmgz4pI=;
	h=Subject:From:Date:To:From;
	b=HJ6lReiWq4I8ljRCNPK8N4wUZR4qfzXlUCtFTWafudXTxZ1mY9pQ3q0pp+m16uSQi
	 i9pnXHH/q9rYYrMO/JOgkiFLZHcb2utNenhawdlIqIS0uRsoHW5M9y0b61uJphHgoE
	 c0ou6WWB5RNpaty1fIi8N1sXXjndSK8HulbIA3eby7eP1iS9RHVxblE2jEsbUMdTJt
	 ftIWZeY2TyvZaQN8pHEnnpZggkAvnDbbQ8llEt98se6K2khG2/uEEGV+FXJhrbG1nN
	 RVxZ4q4bZMIXoVYzFQ7c+nFcluYgHjiTseyn0/erWeHysvJbRkQ95UM4qJ4AVPw3P/
	 oXvcc5eP7nbsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B81DC380AAE0;
	Thu,  6 Feb 2025 14:10:33 +0000 (UTC)
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
 <173885103212.1492547.2257416451856246411.git-patchwork-summary@kernel.org>
Date: Thu, 06 Feb 2025 14:10:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: gpio: Enable a single always-selected device
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=930819
  Lore link: https://lore.kernel.org/r/20250205132127.742750-1-andriy.shevchenko@linux.intel.com
    Patches: [v1,1/2] spi: gpio: Remove stale documentation part
             [v1,2/2] spi: gpio: Support a single always-selected device


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



