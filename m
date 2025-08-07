Return-Path: <linux-spi+bounces-9316-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1053BB1DDBF
	for <lists+linux-spi@lfdr.de>; Thu,  7 Aug 2025 21:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B53717CA49
	for <lists+linux-spi@lfdr.de>; Thu,  7 Aug 2025 19:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8BE21D011;
	Thu,  7 Aug 2025 19:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drIvnWH5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0AD1FBC94
	for <linux-spi@vger.kernel.org>; Thu,  7 Aug 2025 19:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754596791; cv=none; b=cr925AIhgrPg48/fStHq7dsFSpIx3tgIK4yo8s48hHpP//mLceLjnD+68OB6/JZoAdmjXXLCkKV6Emqzt5SUXYJiA0bLHQ8YppRHxKvHwwFqChaVxKxZ8YMsuE0E3K3XzweHRoam+bfdPfQyAlbZenMNtmUrrUxB7rv9mp7rYZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754596791; c=relaxed/simple;
	bh=QA+HCvSSB/rGYKcjRdFhEjPUBBR49+pZQ2nOd6/AGDc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=E0JKMFgEWjRqXbieOhimfStcyXo4TFa5jBMr/3yBmH/CLy30RV99098egyXpxeHPk8Om7aw45SWuy24wPaydAAqtHNfizmkNrtr6K/SEvv8XiUjBtE7xNw3MSjQGlGNRWXXDqYiZQwjbmHpzC7YxiVvXuQEP2CNMIopP89/la2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drIvnWH5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E179C4CEEB;
	Thu,  7 Aug 2025 19:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754596791;
	bh=QA+HCvSSB/rGYKcjRdFhEjPUBBR49+pZQ2nOd6/AGDc=;
	h=Subject:From:Date:To:From;
	b=drIvnWH5GkroMC6zv1sTJs7fYiA9T69UO1rvX7/GHRMxVgBqohJXAclhv4gZ6qh+m
	 OpluZTdK1Ynuozp/kRfi84BCx/jUGuAlVg2MpdsypMoS85GyyldBjhLX7YBCmVRpv4
	 XU3ONFfGDLd8u8PQ1ccZ6xt+03N9H9NdJb6gL/Lt/WsEZLSRzfFeYUm2MWqs+L+8+H
	 lMjp6wQGrEzbSB659dyt/R7XMWJYDTOYdw7opbQ4OVTx+yZho9kqhSgkliMpBrMNRA
	 WuLgSdWsFaXjwn1ym5BLZN0kSS9XO1qiZDCXWLN63mgXzJgoo/36I+SyM21mBYciHw
	 FCoVSHLEa8ghQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EEB6D383BF5C;
	Thu,  7 Aug 2025 20:00:05 +0000 (UTC)
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
 <175459680447.3677160.2010727146569770773.git-patchwork-summary@kernel.org>
Date: Thu, 07 Aug 2025 20:00:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spi-fsl-lpspi: Clamp too high speed_hz
  Submitter: Stefan Wahren <wahrenst@gmx.net>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=989060
  Lore link: https://lore.kernel.org/r/20250807100742.9917-1-wahrenst@gmx.net

Patch: [v2] spi: spi-qpic-snand: fix calculating of ECC OOB regions' properties
  Submitter: Gabor Juhos <j4g8y7@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=988491
  Lore link: https://lore.kernel.org/r/20250805-qpic-snand-oob-ecc-fix-v2-1-e6f811c70d6f@gmail.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



