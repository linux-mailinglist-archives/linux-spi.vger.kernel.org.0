Return-Path: <linux-spi+bounces-6091-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CFA9F555E
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2024 19:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E12D176B71
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2024 17:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB521F7563;
	Tue, 17 Dec 2024 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkStJBVW"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0D5142E77
	for <linux-spi@vger.kernel.org>; Tue, 17 Dec 2024 17:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734457812; cv=none; b=PPhvPV7LURIiD539t6SWESkoux4ACvNOIr5Zho8/DToOjkmRmJfMiLp1dLjMX/pbeD46ob+0afjvWHb0I3X4khlwCPoBtX0dL6d18zLsU4U59AkMx0X75mqgvdnWb+3yZIcBAiPNM3qiMXV9uTBRdCtc7S4Lzz+oa8RUks+wCLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734457812; c=relaxed/simple;
	bh=fRoFJ+LismY7jY72rfKf+59SifH2SD7dr2t4Fpyy8BM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=OzqHioc2EzJchQieluoKjSWmqAG1hNVIcuhdIhpH1RK/BSId6GJcfguUpG0yVcs0Gd51UxL5iIPzdjysC3XXkKOGL5mhrbfFVqOYbVdlGIdVhAo+15Y+rdGYrd1uAcDiMAxsNhiNEyI67ut7D/mdRwEzlgko7qPedZMVYwqy60M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkStJBVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B54EC4CED3;
	Tue, 17 Dec 2024 17:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734457812;
	bh=fRoFJ+LismY7jY72rfKf+59SifH2SD7dr2t4Fpyy8BM=;
	h=Subject:From:Date:To:From;
	b=bkStJBVWdeuOb8xT1rHepHUZ1c/COsR3Y4CAgA7rDUcesbVTRc9UzfdP+d4ClGMKI
	 sxL2Gg/dPUqY3E8uCDGNr571qiGMfhHrPeugfYrr5i3npZKYDgk7CwpwbDtOGqasV6
	 6yl/MY07OwxgNyHCA9PFjV5Cj1rgm+tu5aaouscjFj72cqXJJJSx7zkKC8qbFK+W4I
	 /GL1SntMWQk5ODAGUEFK5suz0h1SGaLsgqVxG7gKkhzLDxmbMCh3MVTtBubp4ZBGMg
	 W0Z6l3+wiH9idV31SxzWlyCTiFqQh3umZarO4a/QTMNDexvAhzyuXpMSc6B/dYrLtv
	 XPCxEt4GSbBrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B1F113806656;
	Tue, 17 Dec 2024 17:50:30 +0000 (UTC)
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
 <173445782917.985689.9209039641812195047.git-patchwork-summary@kernel.org>
Date: Tue, 17 Dec 2024 17:50:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v3] spi: dt-bindings: Document CS active-high
  Submitter: Iker Pedrosa <ikerpedrosam@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=918149
  Lore link: https://lore.kernel.org/r/20241216095739.27320-1-ikerpedrosam@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



