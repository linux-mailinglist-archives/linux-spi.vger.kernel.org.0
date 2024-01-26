Return-Path: <linux-spi+bounces-866-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C69983DFE3
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 18:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0C311F21634
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 17:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079B51EB5E;
	Fri, 26 Jan 2024 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhyOjD64"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86061EB5B
	for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289624; cv=none; b=sv3JP0w37sm7OyXTPFk4JozJuUcpS0jIijqqSzv9FgwnJVdb5ibiXgVdwOKr8K62Czxb5sd9l3hopr2VSsRV+ZTHr0KMVNO2jf4wQpXg5ZhaXzju3mpPEsfQMBbTKDPklNPXJ2cIGDNdUDqvgFvDL8S0X+ZmXiW/Ypwcx8njRdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289624; c=relaxed/simple;
	bh=DaVBu1UMAfd8hmU3OSL3X7bEsUcCxuTLERwu0R2a4Xk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=JifyT1hivPJUOI3GshnIb9JWRMrMB86Wzkkb4WbewKwzdEXjRzuNGtmSkgjyacTmK4H8MCFcZntEmjhpt0u1oxArOMJW3jl6PTcYwFVlIQj746akuyuOsgLc3PG1DZyz/bso1civDoEP2XtJynGdqfEaCLL5khuTVkRo7zLtQek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhyOjD64; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A6DAC433F1;
	Fri, 26 Jan 2024 17:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706289624;
	bh=DaVBu1UMAfd8hmU3OSL3X7bEsUcCxuTLERwu0R2a4Xk=;
	h=Subject:From:Date:To:From;
	b=nhyOjD64n6Dfh+ea92WVq1dbW96bAZRHUW4OQ6qzLk1U1TYLyoIin+DbELnL0HWce
	 8kTPx9/4A64fFvLhFiSGilnYqOh+5MfxaReqoCzCl/UfzX6UY5C0Gri/LprxtzJg0V
	 4JjiEDnyy6KBtgdopG7zRiF2BawySToE709I8z4kqXNWxfzKCicN53oAOy1Y8kS+xu
	 7mdQ9BnW1HvySCTBZgz7VwqYgHgFZfyxDTRwRkts7YZyzhPJV6Tw5XsEnwbIT51xl3
	 Y6yHMmS7ZJSFczNnFvThWPtAoE3IZ6i1DVhtxQCQi6RONwu2PZoeSwunQ0N2Bs3cNi
	 UWl5Ev9nyUMuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2BD90DFF760;
	Fri, 26 Jan 2024 17:20:24 +0000 (UTC)
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
 <170628962412.26222.7345009047003035990.git-patchwork-summary@kernel.org>
Date: Fri, 26 Jan 2024 17:20:24 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: avoid double validation in __spi_sync()
  Submitter: David Lechner <dlechner@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=820072
  Lore link: https://lore.kernel.org/r/20240125234732.3530278-2-dlechner@baylibre.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



