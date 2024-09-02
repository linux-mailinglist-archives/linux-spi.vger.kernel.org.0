Return-Path: <linux-spi+bounces-4517-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F74968D41
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 20:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0ED1F2240C
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 18:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EC819CC0A;
	Mon,  2 Sep 2024 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r702XLkY"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7135C19CC02
	for <linux-spi@vger.kernel.org>; Mon,  2 Sep 2024 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725301229; cv=none; b=UnkkToqIE+Ny/tnGJ4XlsfjUXrJVe/JnrmdCNiveNpampIQlx4tHJG+Vhml3bPXnRbPXwK63Wt1/kp3vC3rH4WIsM2l0sSqjnL7WfYat9zxxHjGaN7nl1mMO93mk2Rn6FoPTAwzklBKORK0pAiWd7ORuvXCoMUDFYqhacvH+UDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725301229; c=relaxed/simple;
	bh=RAJ67fo9jQfPrWg4BT4iG+UmxiAexjjfVfGlSaizb2w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=nMP5PJVRMPu5/YIVsB1Kj+By4u6w4tZCeWBsfF3HgCYKTyad4KRhAlAYzj7b1kvkqHsKLB+8mm54AaKcEv/GLk+aysYDMjldKHEh1Q719zq4ykHAcKIU9jN2vpHoIy8pnukgQf8pwhkstEFt1Rhw0Vq6prKj2Q6WyirJ6IbUccY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r702XLkY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C67C4CEC2;
	Mon,  2 Sep 2024 18:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725301229;
	bh=RAJ67fo9jQfPrWg4BT4iG+UmxiAexjjfVfGlSaizb2w=;
	h=Subject:From:Date:To:From;
	b=r702XLkYqGUtRScaoYlNi23jOj+DCk/40T416XEuzIOffjsEU5oucE0enXMgkg4/e
	 lKvLwTh6LmMkdO5FSn/aWu65N85BxzrtnF/omd+kIgdSa4HKeQq0C4NEvETukoGkUv
	 VsjRsm+VgKZzqJQ+gLABVx6lw4HHDqQ9c0FYMiHFkeg5/0CT6/Z35HgGsmRMYWwBGK
	 ca0HJ9GH4/NPhyUsw6JeRYpSaxHHYG39bdZqyaAfbOWJhHGR16XyX3XqkN9kz2mjyg
	 MkiuLyGf088lcKuOW10+Ownjn5/XVs1JExKA2T51Q0dBRal9yA2Rp1uiu7nzs1ZoBC
	 ct44oAzoL5//g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 028CB3805D82;
	Mon,  2 Sep 2024 18:20:30 +0000 (UTC)
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
 <172530122940.3956957.4576836638322910261.git-patchwork-summary@kernel.org>
Date: Mon, 02 Sep 2024 18:20:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v1,1/1] Revert "spi: ppc4xx: handle irq_of_parse_and_map() errors"
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=881038
  Lore link: https://lore.kernel.org/r/20240819195029.2388397-1-andriy.shevchenko@linux.intel.com

Patch: [v2,1/1] spi: ppc4xx: Revert "handle irq_of_parse_and_map() errors"
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=885797
  Lore link: https://lore.kernel.org/r/20240902102853.2476165-1-andriy.shevchenko@linux.intel.com

Patch: [v1,1/1] spi: ppc4xx: Sort headers
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=885798
  Lore link: https://lore.kernel.org/r/20240902103203.2476576-1-andriy.shevchenko@linux.intel.com


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



