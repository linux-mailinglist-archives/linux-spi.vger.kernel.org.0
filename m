Return-Path: <linux-spi+bounces-8596-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BC8ADB6F6
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 18:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8474E1885025
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 16:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2593B2868BA;
	Mon, 16 Jun 2025 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osxpqqH2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0128B2874E1
	for <linux-spi@vger.kernel.org>; Mon, 16 Jun 2025 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750091400; cv=none; b=nN0EoOUHXSH9FveGxZuyYwM3w7AHJu4qP+0UzsUdGthQr3tJrg4GVYz7a6krjxQavKwje2zheYBRxUx6k8jhdKrhvw0IhzPCMoaCKRbJSgf9MPdaYh3VuSGhWL0iXHXByTjql+PnfPgsX10IsBCo+dVTVbhNybIiJzRnYFd01cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750091400; c=relaxed/simple;
	bh=LXPdd+vqdrC8upDXJQjSCLOghEUee/yimtV1eRx6sDw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ru465AjYA79K5M9iLi5IA3WNSDAFMq8pOkVsf4TOaupgAZXWggzGzDWzECvfUjErt7+wK3AooZ2Q8iNYk0o57SBH3wQa1PPA5/0gKUz+DFhA5sz8N7uSaDFRSlpAM4gGOjLsyiXFbqMNcocRLwoCPAmJSSQDXaTWsyDPelUTpB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osxpqqH2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8967BC4CEEA;
	Mon, 16 Jun 2025 16:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750091399;
	bh=LXPdd+vqdrC8upDXJQjSCLOghEUee/yimtV1eRx6sDw=;
	h=Subject:From:Date:To:From;
	b=osxpqqH2X6ijGbIf5CvUOsbH+7w6qLAvx78vbh8n4et+LShJ1JyJ6hy13afqZomUf
	 qiladtXxWxQamQ8JqcaJxciD26M/FPubTit/Vii4W/0Z92K3eJ0Rv07zdNJyIc5gke
	 M9Tj3MtENF8o0B0CLc/8d3dbXmAsWwCcHBtqlzhfieFdQ+qlAa5BHgh37/qCtPBBg3
	 unjmr9ztY/wGaGyJBu7y6+/kQLv1OIRmPeSzszeLMiZY4y8pPYEuw/DgMFS6JZCKHl
	 m8BWIiIGgWejl4L0nkGdr0mCDfKh15VveKe6+9hElPCOrh7Q1FlUBzCR3qZ0ZWbpjo
	 35GZyry1Pr5Dw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 74A4638111D8;
	Mon, 16 Jun 2025 16:30:29 +0000 (UTC)
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
 <175009142800.2433020.6547966248507978776.git-patchwork-summary@kernel.org>
Date: Mon, 16 Jun 2025 16:30:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spi-fsl-dspi: Revert unintended dependency change in config SPI_FSL_DSPI
  Submitter: Lukas Bulwahn <lbulwahn@redhat.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=972417
  Lore link: https://lore.kernel.org/r/20250616091955.20547-1-lukas.bulwahn@redhat.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



