Return-Path: <linux-spi+bounces-12241-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B40B6D0AF91
	for <lists+linux-spi@lfdr.de>; Fri, 09 Jan 2026 16:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B4B130D5C95
	for <lists+linux-spi@lfdr.de>; Fri,  9 Jan 2026 15:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113632EAB6E;
	Fri,  9 Jan 2026 15:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geGlpLOR"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F732DA768
	for <linux-spi@vger.kernel.org>; Fri,  9 Jan 2026 15:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972811; cv=none; b=HrJJKK+HfamdQ4wJKUmKOWOdDOXoBB+DVhPh/gPjeHrOW7k27Edjdf48NKNyTd/+ras1vVS7i27cOvt1GxJQ4PHiw4LZGerQAfLcuJo6fl1k13gslUAkvYh8lvn+0cfKHAelyynCbG+E4QqEjFYeNorzzcuH4p1gyZg5nd3oCCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972811; c=relaxed/simple;
	bh=huw7v89IVFlSWbfjlNeD4g542D+0NrOshRzhH1vgahc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ea7dAi5igaqRDO+8rLFDiQoSNiZRDcEzCpdgEWbMB2MVHJpkuxYlc9SkYXhVvyrD0QSbWCLAaQ0EfTV92ZHGEcnRXERuNwBOFbdCdN5BNAFPbjmWps6Tu9/4gm1PlBWbKEADNduiHkLhMpn4cfq8F7eAngn2VMO7su90Kb7SYs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geGlpLOR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E33C4CEF1;
	Fri,  9 Jan 2026 15:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767972810;
	bh=huw7v89IVFlSWbfjlNeD4g542D+0NrOshRzhH1vgahc=;
	h=Subject:From:Date:To:From;
	b=geGlpLORyEG7dPIF6LCysOeNXj3g+NwkPgPhUrHlOZuD2B7+tgeXEMFNXD/3Q/YVL
	 2VmcTJOSHpeLQb9e+YF9EtvgGfnLkbPjbg1TI+T480SzKUHGcGsyx+0q9zRjSzmKMs
	 Z+QJSC5NHFqIxGQOgMAKGF4BaBMcm8T5k3kF3IZQOYwSQ0lpa9djDi0KXhd6E3UAUa
	 6cyfIO1lJ1Ykker6u+AXcVpIlj22GPLT2CvOBwgRWrC8OGup4wn0TCj4782EoMwhmh
	 q0iZqHvzOWTRL8CW7oG2+9Z1WmBJ/a74qlNqC/KpMbdpOiMhuOHnAMbp85FDzq0jQy
	 tkkrJWS2RYkjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D5813930CB3;
	Fri,  9 Jan 2026 15:30:07 +0000 (UTC)
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
 <176797260592.293560.16620378279279360829.git-patchwork-summary@kernel.org>
Date: Fri, 09 Jan 2026 15:30:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v1,1/1] spi: Simplify devm_spi_*_controller()
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1040071
  Lore link: https://lore.kernel.org/r/20260108175145.3535441-1-andriy.shevchenko@linux.intel.com

Series: spi: microchip-core: Code improvements (part 2)
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1028777
  Lore link: https://lore.kernel.org/r/20251128185518.3989250-1-andriy.shevchenko@linux.intel.com
    Patches: [v4,1/2] spi: microchip-core: Refactor FIFO read and write handlers
             [v4,2/2] spi: microchip-core: use XOR instead of ANDNOT to simplify the logic

Patch: [v1,1/1] spi: microchip-core: use XOR instead of ANDNOT to fix the logic
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1040070
  Lore link: https://lore.kernel.org/r/20260108175100.3535306-1-andriy.shevchenko@linux.intel.com


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



