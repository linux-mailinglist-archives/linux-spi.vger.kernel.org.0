Return-Path: <linux-spi+bounces-6417-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F3BA180CD
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jan 2025 16:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 760FB3A33CB
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jan 2025 15:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32141F236B;
	Tue, 21 Jan 2025 15:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfvyG/9N"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0F31F4282
	for <linux-spi@vger.kernel.org>; Tue, 21 Jan 2025 15:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737472209; cv=none; b=BfjIZE5YadWX7C+AI4hEa7d0nZmmkD47ehyG/YjW4qhVet1eEJh12wMH0Mwi/IjxODU4yQ14Z7tiTYU69BN36TuXDBLnuKf65pxhnru2bIm77YiEq7ZHXIl+A7dTDh+/8YaCs46PGUpR+K6LAggLew9VdKeDZdaDfk96dqgJL3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737472209; c=relaxed/simple;
	bh=S0kTQcWrkeeN5l4mtMztPoNPzznUbdrroPPoig79m8U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=uKdHbDGI2R9GPs0em+5qyVEL+ZUOB3GbjkS4tiSitbYT3kxCol9H8p3tf9YiJccFloOiqU5y9OIpWuA2kXPogjPKqCcUUcF/rPHptA12FbFmrDFIJZx7gUi5pCUqqVL0tq79m5aR0CO+P3ur3Lwxu/mNabCwAe6wxXYLiiOJOHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfvyG/9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7DDC4CEDF;
	Tue, 21 Jan 2025 15:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737472209;
	bh=S0kTQcWrkeeN5l4mtMztPoNPzznUbdrroPPoig79m8U=;
	h=Subject:From:Date:To:From;
	b=DfvyG/9NDexmidtJDTC8yQ23ojXGPMZGcz81K0qm9mql3zScy3Yl47fdsAm+Dfr7h
	 JaJYxv1or5T+5oHZw6RaXCi9FaBXp0qLS7MQu6qVtweRphsF1DBNoW1CtnN7YwDnKy
	 b4nm7OMcMGN4B1C6napxdxhZowPDWxmqazqiCZzgiBEGfEvXsh49VtzAM40zlTYGDu
	 ReL3DD05qW/dhID3SrkBMtVYgh7YH4Uu9AMtzfWRiurpNfTIMRbk0hwQ9/NkEZCccB
	 AhNbC/TsmA4yuo2T36OeQ5Ec/4BZSxxN9nDrxK8sjQBrepEhTJt9bVCKqVa+WaK8sh
	 debxQs7YIgbLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 76604380AA75;
	Tue, 21 Jan 2025 15:10:34 +0000 (UTC)
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
 <173747223282.24117.3870077314918036668.git-patchwork-summary@kernel.org>
Date: Tue, 21 Jan 2025 15:10:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: omap2-mcspi: Correctly handle devm_clk_get_optional() errors
  Submitter: Mark Brown <broonie@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=926507
  Lore link: https://lore.kernel.org/r/20250117-spi-fix-omap2-optional-v1-1-e77d4ac6db6e@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



