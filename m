Return-Path: <linux-spi+bounces-11284-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3FDC6BF93
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 00:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54C644E0221
	for <lists+linux-spi@lfdr.de>; Tue, 18 Nov 2025 23:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03FA2DA753;
	Tue, 18 Nov 2025 23:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwswS3r1"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD73277011
	for <linux-spi@vger.kernel.org>; Tue, 18 Nov 2025 23:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763508041; cv=none; b=T+w09Hzj7pUauXbaQi5O3Iseijiha+BgmNzE69DpbBqkql1VUsPnRSMWkolH+d18TCNNaXFqQVWftYYioMLWTrbFDSa8OrJVyCtpwoGHIl/I0KcJ/gU9wOtD1ao3EqAZY1Xn22FCo/AtyhghtHIliOjTWFhuIUHGYvE+U3BvR6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763508041; c=relaxed/simple;
	bh=D0v0lDjGpqT5q7vkPYbP0yeFKm2lTVSd1G3U4wGesMk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=oLxDh5NG/6gG4qv6Zzxb4pdH8BFYYGZQVkqF/E2cLq78LRvlGv2xj9fzWvD82jDXWxJcyQLChuCj2X1ZT1cmdZduhGvBdGPWWoTXSihRq+ghuuFqluppJ7QjA+W8Ka6JFpNf9xZITqWDDrKdELBYU0Mqum3kFNkhPomFHsF02QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwswS3r1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C46C4CEF1;
	Tue, 18 Nov 2025 23:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763508040;
	bh=D0v0lDjGpqT5q7vkPYbP0yeFKm2lTVSd1G3U4wGesMk=;
	h=Subject:From:Date:To:From;
	b=fwswS3r1U57d7GIJnf+Hcz8aVwa6mDkjmTFezg5wHnqz0wGYcROBUPbxemp4yyJ3z
	 UNAiMWLZshnz8fPkmAvxFyvnqRj/5gkOYeEN6jh7CE6h2v+y4kjTDs9FeRKouK0j0y
	 9zqoHeUu6jx4hX9rTD5rrzeftl2MRu1VMRVQdP61AEOvDNASycR+5GelmLmNcZDfxW
	 fDsOktxAjVClqUNNm9S1gatGlSQB0v8MxeVNxaQ+o/Syj04pHuMSp9LaZ319areDYe
	 yoztxXfwaS/hHYb0f/xibxBOMtFCuFCbS67v5Q4k0qWmRQklPdqwpe1TOlfRxZ96/Q
	 j9tZl9sKUg4vg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 747CC380A94A;
	Tue, 18 Nov 2025 23:20:06 +0000 (UTC)
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
 <176350800509.140468.15918849875194586000.git-patchwork-summary@kernel.org>
Date: Tue, 18 Nov 2025 23:20:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: MAINTAINERS: adjust file entry in RISC-V MICROCHIP SUPPORT
  Submitter: Lukas Bulwahn <lbulwahn@redhat.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1024212
  Lore link: https://lore.kernel.org/r/20251117104044.291517-1-lukas.bulwahn@redhat.com

Patch: [v3] spi: imx: add 16/32 bits per word support for target PIO mode
  Submitter: Carlos Song <carlos.song@nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1024670
  Lore link: https://lore.kernel.org/r/20251118065012.1418279-1-carlos.song@nxp.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



