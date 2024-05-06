Return-Path: <linux-spi+bounces-2751-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 891388BC526
	for <lists+linux-spi@lfdr.de>; Mon,  6 May 2024 03:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44B6E2813A2
	for <lists+linux-spi@lfdr.de>; Mon,  6 May 2024 01:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE3B1CAB4;
	Mon,  6 May 2024 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvTP40k3"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EC31A28D
	for <linux-spi@vger.kernel.org>; Mon,  6 May 2024 01:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714957827; cv=none; b=IGX7pERCusbClHO6/nuV/3bEYz16FJ+GIVU/2O58+/tkngaItmdZgo7UuZnr+mSRRLvQCHyFWyofAw1qn4NMUUtmvNQuBp5OmcDB0ic1qYv8Vu4CIImmG0QqFI93zaESGEW0x/MJ/Jy1pSOQanUwxiYfLNDbYJwF0WLmg0mdkyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714957827; c=relaxed/simple;
	bh=yMBY5JBG/aV9HgdgpLqtBYqhfj+a54/c5/Pvxz/nvRY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=gSCj7Qb9V+Tfr1fWNeB9B3LItxiw/od0nxc/YBjEFmUhKL+sjwshLApBPlqt0rRAwno/N6YmtWsopnUspEulqu6rCtTI0mS48nPQkJczvf6T1g9QM3goNqd7zFQ6Th/wA+mqengcUmWNbDtdZ5wf80BKdEL6p5HnpCzAsAQ4X+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvTP40k3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF601C113CC;
	Mon,  6 May 2024 01:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714957826;
	bh=yMBY5JBG/aV9HgdgpLqtBYqhfj+a54/c5/Pvxz/nvRY=;
	h=Subject:From:Date:To:From;
	b=FvTP40k3Y9W/KvZfzOjLCUY9lyY3hvZU0TTp22d20iJXsEzlUFCdxtJDLH/BQgW4F
	 HVYqYXLdzSfQqLORnGA5qGoqbAB2g+8jZjBLhVg8DeXnNiWhgM+YAOWKLtdNWEFck/
	 0Jvo82f42cxRRh/Frztl/YYhm3AzIyAuOoNAQRRHq2IPDssPuFX68KB01xYE2C2/r3
	 7IozCLAhWwsjsFfmUZBY5CZ35RmH3hOCMHceQmB5W9kJpX9XenRuPIIYkkAycRMefF
	 EYBAsjKiFR7GJDEGPNnB0Mjjz43XnI2ggdV1LTUYkPg3Zm+I1e9jKYRHl57nCSnbU9
	 aELtCaTtOJl4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A33D8DF55C6;
	Mon,  6 May 2024 01:10:26 +0000 (UTC)
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
 <171495782662.8839.15248190898044342126.git-patchwork-summary@kernel.org>
Date: Mon, 06 May 2024 01:10:26 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v1,1/1] spi: bitbang: Use NSEC_PER_*SEC rather than hard coding
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=849954
  Lore link: https://lore.kernel.org/r/20240502154825.2752464-1-andriy.shevchenko@linux.intel.com

Patch: [v3] spi: dt-bindings: ti,qspi: convert to dtschema
  Submitter: Kousik Sanagavarapu <five231003@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=849704
  Lore link: https://lore.kernel.org/r/20240501165203.13763-1-five231003@gmail.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



