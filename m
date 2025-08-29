Return-Path: <linux-spi+bounces-9788-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B97B3C4C1
	for <lists+linux-spi@lfdr.de>; Sat, 30 Aug 2025 00:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38003A02E93
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 22:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4CC286D7F;
	Fri, 29 Aug 2025 22:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5L5TcS3"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8748278753
	for <linux-spi@vger.kernel.org>; Fri, 29 Aug 2025 22:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756505999; cv=none; b=JusBsiGdj0Df4APgTP2rKuIeT6JpgrjbwrBo7a3ITg9G3f6oD5OjHaSl4l6o7rZX5c1fd9SAE61goPrXaAZkUc3Y7m8L2NvtDZqLlDkqGb8Q/QftJADfxwiEnesB4zo1Ap/5MySFxRxSPJ65yO3MGCV8EE+qSL2HPXIKiz+LFjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756505999; c=relaxed/simple;
	bh=hFFSwaVLFSxW7fhVgmt+4uE6qgRbAXJx64llydcX2mU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=GWlxwLgsDo/Wqm9lvjZbTxCd6t2rf0wNd/iDWDizrTdyGHqYU82/OK46TKUjcgp6Nw+n3R1CP3xfuY+l6WDuLlZDAvIxuc4cVeUSUMA27feHEDZAVFqIuJJAvIgl8l3gfD1X1Mfg5suHgvTLk6nLeexQkkp33S3O85Raeza3J4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5L5TcS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D39EC4CEF0;
	Fri, 29 Aug 2025 22:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756505999;
	bh=hFFSwaVLFSxW7fhVgmt+4uE6qgRbAXJx64llydcX2mU=;
	h=Subject:From:Date:To:From;
	b=q5L5TcS3OegmLcisNa6QCLhBje9hzpCsU4F1v2JZSIV18docr0JknPA+J9CSw/XuG
	 GZxHrllQdp9C8v84sX8tI4GerMgXp1TZRWXPRnYwFHL5DOpJi4w6Aw+1fG+hE/BSQf
	 qtrvN1nNLfy93qB4xB3BfKuQC8vb5JbkTWbkAo0LYtGSWc4BRSr4luuK3WhOMCUY9g
	 W7ucCNcVLyCVFCcNTbM3S+QBHtQYjseMN61jPsy7MzY7pxPQQNH4CopmHqDUOUK3s/
	 A8gtgHRUj3q7jjtseD9GRPUbzH1f3dyTEQ5jk7wiIbujm+T/MStL6Rvbuk1cvfZxV3
	 p2xJNjoHScX1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F0891383BF75;
	Fri, 29 Aug 2025 22:20:06 +0000 (UTC)
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
 <175650600540.2352047.166111190324112761.git-patchwork-summary@kernel.org>
Date: Fri, 29 Aug 2025 22:20:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v1] spi: microchip-core-qspi: stop checking viability of op->max_freq in supports_op callback
  Submitter: Conor Dooley <conor@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=995183
  Lore link: https://lore.kernel.org/r/20250825-during-ploy-939bdd068593@spud


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



