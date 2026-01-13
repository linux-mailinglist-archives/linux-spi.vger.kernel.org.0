Return-Path: <linux-spi+bounces-12351-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D37CD1AD0D
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 19:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5710530184F0
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 18:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FCF30F555;
	Tue, 13 Jan 2026 18:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cusuNq59"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E73730DEAD
	for <linux-spi@vger.kernel.org>; Tue, 13 Jan 2026 18:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768328432; cv=none; b=lleunt6fBEp50nheb386QhoOTRMGKiADg3naOEsv8aORtiU756pMYL6+nX1hM7isaqju66c6JrOFBwduJW8bp+YtD9Qop8OJamlNrwQ8sH4WcCc0F9JkoviCNR/sL4HDhOmU1pEYKsKb0zAHpWuu7O1giFLfZy2eLzq2LOxlBzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768328432; c=relaxed/simple;
	bh=ns5x5R9xjM5vD9Li8szHjUrhCe0QOw2cveuV6g4P/n0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=opSJOBLT9/H8NqVZQQm1GBh2jfkYp5eAacyiaZs7LM5xjIdQQ+SoVYyHNWV7W00cp6F675oU6GWhcGosZo+z/c6QvNcsLXlbB0chpKZBx5aNSIVvMRBOwDu8JjEN8AWtEGZfer+QZBYav5c3RMcXFN2sc/Qbh5PJRrSv8KtHOq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cusuNq59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560BCC116C6;
	Tue, 13 Jan 2026 18:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768328432;
	bh=ns5x5R9xjM5vD9Li8szHjUrhCe0QOw2cveuV6g4P/n0=;
	h=Subject:From:Date:To:From;
	b=cusuNq59l5jzQ24D2Lfegb25nb3xvNCWHYr7HXokLIu0UDqbnWK48fsLUVMr0pnVH
	 VYN0uZCy9csZ0W9BSRDqpT3GJBaEfZKLaGnK7qtq91EgiTKE0NRUDi3mdEO5IzGExY
	 QcxoCxEJ5HoYStVWayEgEV2mhAdHYj/i9oKKEyqlNqknNpKPCe4PETzsB45zlp0S0x
	 rMjRSa4NMtgkSLyBKEIbHslIItusN6zlemhVx856lf5kVSMMEVMbZ9VuzngDUq8Ll4
	 XCUjC/e0yFmAFIXtyznE8k6BiXMcKVK1sIBMlOYkEuxe9+OPXllPh0lfvkC7DdYWuF
	 hJPPUIm1nXjOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BB8F23808200;
	Tue, 13 Jan 2026 18:17:06 +0000 (UTC)
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
 <176832822516.2345780.3551819079577642744.git-patchwork-summary@kernel.org>
Date: Tue, 13 Jan 2026 18:17:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: mtd: spinand: Octal DTR support
  Submitter: Miquel Raynal <miquel.raynal@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1040574
  Lore link: https://lore.kernel.org/r/20260109-winbond-v6-17-rc1-oddr-v2-0-1fff6a2ddb80@bootlin.com
    Patches: [v2,01/27] spi: spi-mem: Make the DTR command operation macro more suitable
             [v2,02/27] spi: spi-mem: Create a repeated address operation
             [v2,03/27] spi: spi-mem: Limit octal DTR constraints to octal DTR situations


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



