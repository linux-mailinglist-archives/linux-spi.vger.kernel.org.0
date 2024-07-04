Return-Path: <linux-spi+bounces-3754-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA155927E12
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jul 2024 22:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11186B2351A
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jul 2024 20:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE0A13777D;
	Thu,  4 Jul 2024 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9+rpvHf"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1967E45000
	for <linux-spi@vger.kernel.org>; Thu,  4 Jul 2024 20:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720123232; cv=none; b=HzO8WcKURSzx46i0qlwcJu8+LWeoxef9pTvx62YlYWE9m+bOPkbEItQ3fGhaeaN53hhDO0zBFN6vuM9yLejyoAOVWbvOM7CTGEsX5olALQnuAGMzzh8ZkmRNEp9yVwic3zR37Cvsx2LTmy8j9p6R1VJ5+h9oTRYXtfFGfurIaFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720123232; c=relaxed/simple;
	bh=9hDbJrgo/6Rlh+wOEgBlTZ7Yz29AoT51HFSOPgCynPk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=N3ooAdi1WP9wWQPftrKZA7Bhu161IevZ840qWE8WhrV68cxllv51MZnqt2g08ij4viiNnhH2u1Cf7DOkHQPGu/9EkrA6ecxUhsdhFxQKzmxC5xbADVgeqnbLtURMnqOat8/P8QJlgNCNE8pMmmiEIpsL9ShfBUuiDTCvqgCrXiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9+rpvHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB643C3277B;
	Thu,  4 Jul 2024 20:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720123231;
	bh=9hDbJrgo/6Rlh+wOEgBlTZ7Yz29AoT51HFSOPgCynPk=;
	h=Subject:From:Date:To:From;
	b=s9+rpvHfR5NFy2/XP3zH727WfRFkfdCOLoNoN7QPquGyvKvBCIV0DJh4VTkYM3cZY
	 rJC2B/o0i/JcrWrXi2iC3Dnm+G9cBsRG4NfsxI9C1AX3Bmzdg4SCBVdjL72HcQTSD8
	 zhO/Kpgcb1ivaKm8Mg6RmbAZeaa9xb2bWXoZqzBEoZhQVCNzWv63TgmGjojVqN2oCe
	 xhK4u7E3/Tp5zNG9WwT3dHCaJ+mAcsmLfUnz63NmzV3x25E03Xw6dvtCQTMjOQ9C7L
	 pkLK32nHLzMYr/d7KO4gQBoTmO/Uamk7JfFtpbGd1e4Wq1zllCIre0Ya7BOJjBvHfX
	 kc+QV8MK8eF1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A0D5FC433A2;
	Thu,  4 Jul 2024 20:00:31 +0000 (UTC)
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
 <172012323160.29526.1222313170498295210.git-patchwork-summary@kernel.org>
Date: Thu, 04 Jul 2024 20:00:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: omap2-mcspi: Revert multi mode support
  Submitter: Mark Brown <broonie@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=868424
  Lore link: https://lore.kernel.org/r/20240704-spi-revert-omap2-multi-v1-1-69357ef13fdc@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



