Return-Path: <linux-spi+bounces-6969-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 488C9A48024
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2025 14:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57846163D29
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2025 13:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED78022DFB3;
	Thu, 27 Feb 2025 13:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5Xy+nzI"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C968621661C
	for <linux-spi@vger.kernel.org>; Thu, 27 Feb 2025 13:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740664198; cv=none; b=MH0X0mwPInZxBdG9P01rSXGBHGPRQapB1uB55qLWuv7QpFK7ThbhA75TBI7G9c9/ZI51x+6JhDYKmA5X4fvGWN1Jh24uNRwT6VlTw8aV9/Z1ikGnlLx8CEA5YzxflXL/gfvihrA6LhLc0kCw5R+9o7wKwvZ6glJ+0ZEhRqcZayg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740664198; c=relaxed/simple;
	bh=b47sXdUh1PiybAIEnbdiplk9Aoez+nWpwzY3+X9xCwc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=KdnLLpcfWjj5eygSHh1kdJ0iDsQ8QH5MoEorSG8NyJWZnYgHrb3cke/Pu3L+n9cudxoREjzQP2HZBxpRaBNLkoEBqlyz1et1mQjeGKzfsVgYcQAbUZNj0MwlnpWlUAQWX5YnyZUDlFaR5Vaaziin7tN7Q0lpkuyDo6x6h+L0g9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5Xy+nzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26844C4CEDD;
	Thu, 27 Feb 2025 13:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740664198;
	bh=b47sXdUh1PiybAIEnbdiplk9Aoez+nWpwzY3+X9xCwc=;
	h=Subject:From:Date:To:From;
	b=h5Xy+nzI/bu6RqcgI7Qdms7ysw6Wse68eiQaRPHuTaYtd3AIAYmcPNKz8SDAur33X
	 HvA/I9b7w2NuSWjvfe4YMA6g+hh5mjFSH5P97Rn0e3TbodutaWTG/dugfRvDTm7S6g
	 FKjGgBXY1a6O8p8CwuGrpNd6Rl2xV/aV83ottMRuM0FaPv+9uA9oifRPST1xYIZa6p
	 h4cMCft65Hl2a8ATjExiA+0VB07iyUgHR92uLW5j0NuTI6wgzYNe0qCqFZwCYfnmEg
	 4HHtO3trIroGHGn4niOx5E5qAQTRskF1cFk7tnvGtQlWuB5sORDN3VcJy8reUcrNEE
	 82IWyldpWJJ8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 39FC6380AA7F;
	Thu, 27 Feb 2025 13:50:31 +0000 (UTC)
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
 <174066422967.1435501.6945925284004767335.git-patchwork-summary@kernel.org>
Date: Thu, 27 Feb 2025 13:50:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: rockchip: Add rk3562 support
  Submitter: Kever Yang <kever.yang@rock-chips.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=920696
  Lore link: https://lore.kernel.org/r/20241224094920.3821861-1-kever.yang@rock-chips.com

Patch: rockchip: Add rk3562 SoC and evb support
  Submitter: Kever Yang <kever.yang@rock-chips.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=938469
  Lore link: https://lore.kernel.org/r/20250227111913.2344207-1-kever.yang@rock-chips.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



