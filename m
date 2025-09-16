Return-Path: <linux-spi+bounces-10047-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D4FB5975F
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 15:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2104E322BA8
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 13:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D2230F929;
	Tue, 16 Sep 2025 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRrWozW7"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B2830F54C
	for <linux-spi@vger.kernel.org>; Tue, 16 Sep 2025 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758028833; cv=none; b=Vfo6VKET6AkeWKI/4U4XarYhU6UiotULtUBegfmQC62EvpNEoxJuc39tXy5bW4AQgrtY0pW177lgxsH/I4OaoBaQ0YZjujybMlg5mwfThVanlhHWCs9GwGL2P3/KgDE5cAyss2FRjbbV++r52br2+6oqe1sRCoUPLu2HOr8xZRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758028833; c=relaxed/simple;
	bh=nML/EKT9P+ON5h1hT/QbR0TwMz19bZdKS0N9pdSELvI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=FYLFjjP8G3Sg2la6ylPjdtn61uQk6syczQZsdm7uUmG+elBZRR39RJ/+F2xbguafd4Giea/XE5XUP3DRo8Q/Up9VGf1OTC5adj1pnKcEmzrPYudGPvmdzevd5Q/XHCOe0YtDaK0SRbgX7/2ZjVMUm6fi40Fis3qxKHZL3Jnn25s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRrWozW7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62298C4CEFA;
	Tue, 16 Sep 2025 13:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758028832;
	bh=nML/EKT9P+ON5h1hT/QbR0TwMz19bZdKS0N9pdSELvI=;
	h=Subject:From:Date:To:From;
	b=JRrWozW7m/yP/RROPQN9cQ2p9yHWsFFK2MnnoFFDdfZ5+t43Z176ls6JFggF57dXh
	 H8PIBNshHH7Mx6NzT1gCkXaeU+UyN6OwqETI8BgxHGIruRDL6FnErI2vCUoJPUV7y0
	 ZjqqMhsWZZwcmtINHyAEcnYaQEAZNOTcxbh0AWKqar3ZMbiGtn79taJTQafU2uXaSI
	 Hwcv8AY1mp20zbIy6B/jXdhwFOI06aNRQ4t4pNJpvDPpIC2fHvS2ClVZyNH5bXI9mt
	 izYklOa0VH7dlLUnNAATpQBfIueYg9KpgpD+QYr7AzsRhPTRLC5yI59kabjyHlSPAv
	 6/GP8Ma5e6LeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B155E39D0C1A;
	Tue, 16 Sep 2025 13:20:34 +0000 (UTC)
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
 <175802883323.749893.14981185447294391542.git-patchwork-summary@kernel.org>
Date: Tue, 16 Sep 2025 13:20:33 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [next] spi: amlogic: Fix error checking on regmap_write call
  Submitter: Colin Ian King <colin.i.king@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1002091
  Lore link: https://lore.kernel.org/r/20250913201612.1338217-1-colin.i.king@gmail.com

Patch: [next] spi: amlogic: Fix some error checking in aml_sfc_dma_buffer_setup()
  Submitter: Dan Carpenter <dan.carpenter@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1002311
  Lore link: https://lore.kernel.org/r/aMepB7E95kwYvx0o@stanley.mountain


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



